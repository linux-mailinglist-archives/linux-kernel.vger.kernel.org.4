Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8096B3DAC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 12:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjCJL1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 06:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjCJL0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 06:26:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E0CC9A5F
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 03:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678447575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P/VItM166X+OYnKhtfKsQovz6iE6g5P711OGiudw6Ss=;
        b=ZYtzt+gLnnIYcyAItwYP9dMGEy0R6FIj1UCXF1QTV6ieDQ/75z/ccr7hVKUnowboW+QKJF
        3KzH4yANk4847wI1EaaqknrOtAI2GkXW12QdczEqlZ70OPET6tkYNtAdTRI705nJq5gVvZ
        WSCd+rD9TO6BUtthyC3KAlF5Sgvy4Ew=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-642-8p-RQurRPlKDuDleB571yA-1; Fri, 10 Mar 2023 06:26:12 -0500
X-MC-Unique: 8p-RQurRPlKDuDleB571yA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4A5DF382888F;
        Fri, 10 Mar 2023 11:26:12 +0000 (UTC)
Received: from carbon.redhat.com (unknown [10.39.194.146])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BB90DC15BA0;
        Fri, 10 Mar 2023 11:26:09 +0000 (UTC)
From:   Giuseppe Scrivano <gscrivan@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     keescook@chromium.org, bristot@redhat.com, ebiederm@xmission.com,
        brauner@kernel.org, cyphar@cyphar.com, viro@zeniv.linux.org.uk,
        walters@verbum.org, avagin@gmail.com, alexl@redhat.com,
        peterz@infradead.org, bmasney@redhat.com, gscrivan@redhat.com
Subject: [PATCH v4 2/3] exec: PR_HIDE_SELF_EXE hides /proc/self/map_files
Date:   Fri, 10 Mar 2023 12:25:53 +0100
Message-Id: <20230310112554.1261731-2-gscrivan@redhat.com>
In-Reply-To: <20230310112554.1261731-1-gscrivan@redhat.com>
References: <20230310112554.1261731-1-gscrivan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

extend the new prctl(PR_HIDE_SELF_EXE) to prevent using
/proc/self/map_files as well.

Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
---
 fs/proc/base.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 14102a133655..72f1cb44691f 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2255,9 +2255,21 @@ proc_map_files_get_link(struct dentry *dentry,
 			struct inode *inode,
 		        struct delayed_call *done)
 {
+	struct task_struct *task;
+	bool hide_self_exe;
+
 	if (!checkpoint_restore_ns_capable(&init_user_ns))
 		return ERR_PTR(-EPERM);
 
+	task = get_proc_task(d_inode(dentry));
+	if (!task)
+		return ERR_PTR(-ENOENT);
+	hide_self_exe = is_hide_self_exe_blocked(task);
+	put_task_struct(task);
+
+	if (hide_self_exe)
+		return ERR_PTR(-EPERM);
+
 	return proc_pid_get_link(dentry, inode, done);
 }
 
-- 
2.39.2

