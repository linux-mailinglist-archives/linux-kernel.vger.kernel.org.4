Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0970660384E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 04:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiJSC4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 22:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiJSC4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 22:56:09 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F446E5EF5;
        Tue, 18 Oct 2022 19:56:08 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Msb2m05xLzHv4d;
        Wed, 19 Oct 2022 10:56:00 +0800 (CST)
Received: from dggpemm500016.china.huawei.com (7.185.36.25) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 19 Oct 2022 10:55:45 +0800
Received: from huawei.com (10.67.174.33) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 19 Oct
 2022 10:55:45 +0800
From:   "GONG, Ruiqi" <gongruiqi1@huawei.com>
To:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>
CC:     Ondrej Mosnacek <omosnace@redhat.com>, <selinux@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Xiu Jianfeng" <xiujianfeng@huawei.com>, <gongruiqi1@huawei.com>
Subject: [PATCH v2] selinux: use GFP_ATOMIC in convert_context()
Date:   Wed, 19 Oct 2022 10:57:10 +0800
Message-ID: <20221019025710.2482945-1-gongruiqi1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.33]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following warning was triggered on a hardware environment:

  SELinux: Converting 162 SID table entries...
  BUG: sleeping function called from invalid context at __might_sleep+0x60/0x74 0x0
  in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 5943, name: tar
  CPU: 7 PID: 5943 Comm: tar Tainted: P O 5.10.0 #1
  Call trace:
   dump_backtrace+0x0/0x1c8
   show_stack+0x18/0x28
   dump_stack+0xe8/0x15c
   ___might_sleep+0x168/0x17c
   __might_sleep+0x60/0x74
   __kmalloc_track_caller+0xa0/0x7dc
   kstrdup+0x54/0xac
   convert_context+0x48/0x2e4
   sidtab_context_to_sid+0x1c4/0x36c
   security_context_to_sid_core+0x168/0x238
   security_context_to_sid_default+0x14/0x24
   inode_doinit_use_xattr+0x164/0x1e4
   inode_doinit_with_dentry+0x1c0/0x488
   selinux_d_instantiate+0x20/0x34
   security_d_instantiate+0x70/0xbc
   d_splice_alias+0x4c/0x3c0
   ext4_lookup+0x1d8/0x200 [ext4]
   __lookup_slow+0x12c/0x1e4
   walk_component+0x100/0x200
   path_lookupat+0x88/0x118
   filename_lookup+0x98/0x130
   user_path_at_empty+0x48/0x60
   vfs_statx+0x84/0x140
   vfs_fstatat+0x20/0x30
   __se_sys_newfstatat+0x30/0x74
   __arm64_sys_newfstatat+0x1c/0x2c
   el0_svc_common.constprop.0+0x100/0x184
   do_el0_svc+0x1c/0x2c
   el0_svc+0x20/0x34
   el0_sync_handler+0x80/0x17c
   el0_sync+0x13c/0x140
  SELinux: Context system_u:object_r:pssp_rsyslog_log_t:s0:c0 is not valid (left unmapped).

It was found that within a critical section of spin_lock_irqsave in
sidtab_context_to_sid(), convert_context() (hooked by
sidtab_convert_params.func) might cause the process to sleep via
allocating memory with GFP_KERNEL, which is problematic.

As Ondrej pointed out [1], convert_context()/sidtab_convert_params.func
has another caller sidtab_convert_tree(), which is okay with GFP_KERNEL.
Therefore, fix this problem by adding a gfp_t argument for
convert_context()/sidtab_convert_params.func and pass GFP_KERNEL/_ATOMIC
properly in individual callers.

Link: https://lore.kernel.org/all/20221018120111.1474581-1-gongruiqi1@huawei.com/ [1]
Reported-by: Tan Ninghao <tanninghao1@huawei.com>
Fixes: ee1a84fdfeed ("selinux: overhaul sidtab to fix bug and improve performance")
Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
---

v2: change as Ondrej suggests & redraft commit message

 security/selinux/ss/services.c | 5 +++--
 security/selinux/ss/sidtab.c   | 4 ++--
 security/selinux/ss/sidtab.h   | 2 +-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index fe5fcf571c56..64a6a37dc36d 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2022,7 +2022,8 @@ static inline int convert_context_handle_invalid_context(
  * in `newc'.  Verify that the context is valid
  * under the new policy.
  */
-static int convert_context(struct context *oldc, struct context *newc, void *p)
+static int convert_context(struct context *oldc, struct context *newc, void *p,
+			   gfp_t gfp_flags)
 {
 	struct convert_context_args *args;
 	struct ocontext *oc;
@@ -2036,7 +2037,7 @@ static int convert_context(struct context *oldc, struct context *newc, void *p)
 	args = p;
 
 	if (oldc->str) {
-		s = kstrdup(oldc->str, GFP_KERNEL);
+		s = kstrdup(oldc->str, gfp_flags);
 		if (!s)
 			return -ENOMEM;
 
diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
index a54b8652bfb5..db5cce385bf8 100644
--- a/security/selinux/ss/sidtab.c
+++ b/security/selinux/ss/sidtab.c
@@ -325,7 +325,7 @@ int sidtab_context_to_sid(struct sidtab *s, struct context *context,
 		}
 
 		rc = convert->func(context, &dst_convert->context,
-				   convert->args);
+				   convert->args, GFP_ATOMIC);
 		if (rc) {
 			context_destroy(&dst->context);
 			goto out_unlock;
@@ -404,7 +404,7 @@ static int sidtab_convert_tree(union sidtab_entry_inner *edst,
 		while (i < SIDTAB_LEAF_ENTRIES && *pos < count) {
 			rc = convert->func(&esrc->ptr_leaf->entries[i].context,
 					   &edst->ptr_leaf->entries[i].context,
-					   convert->args);
+					   convert->args, GFP_KERNEL);
 			if (rc)
 				return rc;
 			(*pos)++;
diff --git a/security/selinux/ss/sidtab.h b/security/selinux/ss/sidtab.h
index 4eff0e49dcb2..9fce0d553fe2 100644
--- a/security/selinux/ss/sidtab.h
+++ b/security/selinux/ss/sidtab.h
@@ -65,7 +65,7 @@ struct sidtab_isid_entry {
 };
 
 struct sidtab_convert_params {
-	int (*func)(struct context *oldc, struct context *newc, void *args);
+	int (*func)(struct context *oldc, struct context *newc, void *args, gfp_t gfp_flags);
 	void *args;
 	struct sidtab *target;
 };
-- 
2.25.1

