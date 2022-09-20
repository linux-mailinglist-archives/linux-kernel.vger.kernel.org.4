Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB2C5BEC84
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 20:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbiITSJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 14:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbiITSI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 14:08:59 -0400
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF076747B
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 11:08:56 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-168-cS9gUiCyO26z06RYJEcy-A-1; Tue, 20 Sep 2022 14:08:52 -0400
X-MC-Unique: cS9gUiCyO26z06RYJEcy-A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E98FF8027EA;
        Tue, 20 Sep 2022 18:08:51 +0000 (UTC)
Received: from comp-core-i7-2640m-0182e6.redhat.com (unknown [10.40.208.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 821B92166B26;
        Tue, 20 Sep 2022 18:08:50 +0000 (UTC)
From:   Alexey Gladkov <legion@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Manfred Spraul <manfred@colorfullife.com>
Subject: [PATCH v2 1/3] sysctl: Allow change system v ipc sysctls inside ipc namespace
Date:   Tue, 20 Sep 2022 20:08:20 +0200
Message-Id: <0895bd453013370eb4f9600e26e2a9969ee755de.1663696560.git.legion@kernel.org>
In-Reply-To: <cover.1663696560.git.legion@kernel.org>
References: <YynnI2ySUkpu9j6S@example.org> <cover.1663696560.git.legion@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rootless containers are not allowed to modify kernel IPC parameters.

All default limits are set to such high values that in fact there are no
limits at all. All limits are not inherited and are initialized to
default values when a new ipc_namespace is created.

For new ipc_namespace:

size_t       ipc_ns.shm_ctlmax = SHMMAX; // (ULONG_MAX - (1UL << 24))
size_t       ipc_ns.shm_ctlall = SHMALL; // (ULONG_MAX - (1UL << 24))
int          ipc_ns.shm_ctlmni = IPCMNI; // (1 << 15)
int          ipc_ns.shm_rmid_forced = 0;
unsigned int ipc_ns.msg_ctlmax = MSGMAX; // 8192
unsigned int ipc_ns.msg_ctlmni = MSGMNI; // 32000
unsigned int ipc_ns.msg_ctlmnb = MSGMNB; // 16384

The shm_tot (total amount of shared pages) has also ceased to be
global, it is located in ipc_namespace and is not inherited from
anywhere.

In such conditions, it cannot be said that these limits limit anything.
The real limiter for them is cgroups.

If we allow rootless containers to change these parameters, then it can
only be reduced.

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 ipc/ipc_sysctl.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
index ef313ecfb53a..a6a9d7f680dd 100644
--- a/ipc/ipc_sysctl.c
+++ b/ipc/ipc_sysctl.c
@@ -190,25 +190,53 @@ static int set_is_seen(struct ctl_table_set *set)
 	return &current->nsproxy->ipc_ns->ipc_set == set;
 }
 
+static void ipc_set_ownership(struct ctl_table_header *head,
+			      struct ctl_table *table,
+			      kuid_t *uid, kgid_t *gid)
+{
+	struct ipc_namespace *ns =
+		container_of(head->set, struct ipc_namespace, ipc_set);
+
+	kuid_t ns_root_uid = make_kuid(ns->user_ns, 0);
+	kgid_t ns_root_gid = make_kgid(ns->user_ns, 0);
+
+	*uid = uid_valid(ns_root_uid) ? ns_root_uid : GLOBAL_ROOT_UID;
+	*gid = gid_valid(ns_root_gid) ? ns_root_gid : GLOBAL_ROOT_GID;
+}
+
 static int ipc_permissions(struct ctl_table_header *head, struct ctl_table *table)
 {
+	struct ipc_namespace *ns =
+		container_of(head->set, struct ipc_namespace, ipc_set);
 	int mode = table->mode;
+	kuid_t ns_root_uid;
+	kgid_t ns_root_gid;
 
-#ifdef CONFIG_CHECKPOINT_RESTORE
-	struct ipc_namespace *ns = current->nsproxy->ipc_ns;
+	ipc_set_ownership(head, table, &ns_root_uid, ns_root_gid);
 
+#ifdef CONFIG_CHECKPOINT_RESTORE
 	if (((table->data == &ns->ids[IPC_SEM_IDS].next_id) ||
 	     (table->data == &ns->ids[IPC_MSG_IDS].next_id) ||
 	     (table->data == &ns->ids[IPC_SHM_IDS].next_id)) &&
 	    checkpoint_restore_ns_capable(ns->user_ns))
 		mode = 0666;
+	else
 #endif
-	return mode;
+	if (uid_eq(current_euid(), ns_root_uid))
+		mode >>= 6;
+
+	else if (in_egroup_p(ns_root_gid))
+		mode >>= 3;
+
+	mode &= 7;
+
+	return (mode << 6) | (mode << 3) | mode;
 }
 
 static struct ctl_table_root set_root = {
 	.lookup = set_lookup,
 	.permissions = ipc_permissions,
+	.set_ownership = ipc_set_ownership,
 };
 
 bool setup_ipc_sysctls(struct ipc_namespace *ns)
-- 
2.33.4

