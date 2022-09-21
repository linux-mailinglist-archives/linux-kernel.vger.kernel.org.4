Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2963B5BFC88
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 12:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbiIUKmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 06:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiIUKmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 06:42:13 -0400
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D301310564
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 03:42:08 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-631-DGMXSy5cObOiTx5N5XIHaA-1; Wed, 21 Sep 2022 06:42:06 -0400
X-MC-Unique: DGMXSy5cObOiTx5N5XIHaA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ECC05801231;
        Wed, 21 Sep 2022 10:42:05 +0000 (UTC)
Received: from comp-core-i7-2640m-0182e6.redhat.com (unknown [10.40.208.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 971971759F;
        Wed, 21 Sep 2022 10:42:04 +0000 (UTC)
From:   Alexey Gladkov <legion@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Manfred Spraul <manfred@colorfullife.com>
Subject: [PATCH v3 2/3] sysctl: Allow to change limits for posix messages queues
Date:   Wed, 21 Sep 2022 12:41:48 +0200
Message-Id: <7eb21211c8622e91d226e63416b1b93c079f60ee.1663756794.git.legion@kernel.org>
In-Reply-To: <cover.1663756794.git.legion@kernel.org>
References: <202209211737.0Bu0F40t-lkp@intel.com> <cover.1663756794.git.legion@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All parameters of posix messages queues (queues_max/msg_max/msgsize_max)
end up being limited by RLIMIT_MSGQUEUE. The code in mqueue_get_inode is
where that limiting happens.

The RLIMIT_MSGQUEUE is bound to the user namespace and is counted
hierarchically.

We can allow root in the user namespace to modify the posix messages
queues parameters.

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 ipc/mq_sysctl.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/ipc/mq_sysctl.c b/ipc/mq_sysctl.c
index fbf6a8b93a26..ff1054fbbacc 100644
--- a/ipc/mq_sysctl.c
+++ b/ipc/mq_sysctl.c
@@ -12,6 +12,7 @@
 #include <linux/stat.h>
 #include <linux/capability.h>
 #include <linux/slab.h>
+#include <linux/cred.h>
 
 static int msg_max_limit_min = MIN_MSGMAX;
 static int msg_max_limit_max = HARD_MSGMAX;
@@ -76,8 +77,43 @@ static int set_is_seen(struct ctl_table_set *set)
 	return &current->nsproxy->ipc_ns->mq_set == set;
 }
 
+static void mq_set_ownership(struct ctl_table_header *head,
+			     struct ctl_table *table,
+			     kuid_t *uid, kgid_t *gid)
+{
+	struct ipc_namespace *ns =
+		container_of(head->set, struct ipc_namespace, mq_set);
+
+	kuid_t ns_root_uid = make_kuid(ns->user_ns, 0);
+	kgid_t ns_root_gid = make_kgid(ns->user_ns, 0);
+
+	*uid = uid_valid(ns_root_uid) ? ns_root_uid : GLOBAL_ROOT_UID;
+	*gid = gid_valid(ns_root_gid) ? ns_root_gid : GLOBAL_ROOT_GID;
+}
+
+static int mq_permissions(struct ctl_table_header *head, struct ctl_table *table)
+{
+	int mode = table->mode;
+	kuid_t ns_root_uid;
+	kgid_t ns_root_gid;
+
+	mq_set_ownership(head, table, &ns_root_uid, &ns_root_gid);
+
+	if (uid_eq(current_euid(), ns_root_uid))
+		mode >>= 6;
+
+	if (in_egroup_p(ns_root_gid))
+		mode >>= 3;
+
+	mode &= 7;
+
+	return (mode << 6) | (mode << 3) | mode;
+}
+
 static struct ctl_table_root set_root = {
 	.lookup = set_lookup,
+	.permissions = mq_permissions,
+	.set_ownership = mq_set_ownership,
 };
 
 bool setup_mq_sysctls(struct ipc_namespace *ns)
-- 
2.33.4

