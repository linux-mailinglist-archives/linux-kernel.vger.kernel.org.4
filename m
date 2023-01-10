Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172D9663F6B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 12:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjAJLqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 06:46:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbjAJLqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 06:46:31 -0500
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B3948CD1;
        Tue, 10 Jan 2023 03:46:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1673351179; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=KzUVpDH4yAJRpJ8xxKrcI+ABzCtsWIvYAoBfYdqUdr/YMp/f3h85IauWXnvUxpShHj9kIewwWpnIChCUKGm+DQI+nTbQQ98Lune8Qz4IDoKgR3ZQ3neEQg5vGn+gOTUn3sqGcbCKfQPSKmwNrFuSXndoGADHwDir7m2ChGKUODM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1673351179; h=Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=RPawfXkHoPL7Y8+J9U9JKYo2P4bL8EODHWvhtbG7JUM=; 
        b=noo5uskees5bJsL53OoThxFJ7Aj5kyxkAaVZD/CDqhRwnVY1FZS50srIgWA9DBg/Sa/4QTmoIyTc+SDgGuaYhJLaVumrENjeNatf0WIHKRoFcJbtQDIqWJs75uhkMvay8kdn1BAngoFfUBKlP/rOU212mJaam8I8pv1Wy+1zW90=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=linux.beauty;
        spf=pass  smtp.mailfrom=me@linux.beauty;
        dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1673351179;
        s=zmail; d=linux.beauty; i=me@linux.beauty;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=RPawfXkHoPL7Y8+J9U9JKYo2P4bL8EODHWvhtbG7JUM=;
        b=cMBmQMqpuLqyn71C4hiies8itTeQAPKfHZLKzwv4/wR3TvNFR45elQf7Yz2ggUal
        rFTSIinvxMCQhd3FYt7QUg+38wL2qePJYt3Zns7q7T5lYex3tHkJXmDBdXMx9yZNyH/
        AeLfz+huOtWh/+9P1kcMLaGG1C6Njp3LOMiq5v8o=
Received: from shbuild9.ambarella.net (116.246.37.178 [116.246.37.178]) by mx.zohomail.com
        with SMTPS id 1673351177408190.58179689203598; Tue, 10 Jan 2023 03:46:17 -0800 (PST)
From:   Li Chen <me@linux.beauty>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Li Chen <lchen@ambarella.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clk: create write_enable file to control clk rate write and other dangerous ops permission
Date:   Tue, 10 Jan 2023 19:45:39 +0800
Message-Id: <20230110114540.2975540-1-me@linux.beauty>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Chen <lchen@ambarella.com>

It's common requirement for bsp debug/test to change clk rate from userspace.

Currently, we must define CLKOCK_ALLOW_WRITE_DEBUGFS then re-compile kernel
to allow this feature. Let's replace it with a "write_enable" file to
allow enable it at runtime.

Signed-off-by: Li Chen <lchen@ambarella.com>
Change-Id: Ic4bf94c572c24f6979c2b7aea042fec654370220
---
 drivers/clk/clk.c | 39 ++++++++++-----------------------------
 1 file changed, 10 insertions(+), 29 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index e62552a75f08..668f691bf67a 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -89,6 +89,7 @@ struct clk_core {
 	struct hlist_node	debug_node;
 #endif
 	struct kref		ref;
+	bool write_enable;
 };
 
 #define CREATE_TRACE_POINTS
@@ -3263,8 +3264,6 @@ static int clk_dump_show(struct seq_file *s, void *data)
 }
 DEFINE_SHOW_ATTRIBUTE(clk_dump);
 
-#undef CLOCK_ALLOW_WRITE_DEBUGFS
-#ifdef CLOCK_ALLOW_WRITE_DEBUGFS
 /*
  * This can be dangerous, therefore don't provide any real compile time
  * configuration option for this feature.
@@ -3275,6 +3274,9 @@ static int clk_rate_set(void *data, u64 val)
 	struct clk_core *core = data;
 	int ret;
 
+	if (!core->write_enable)
+		return -EACCES;
+
 	clk_prepare_lock();
 	ret = clk_core_set_rate_nolock(core, val);
 	clk_prepare_unlock();
@@ -3289,6 +3291,9 @@ static int clk_prepare_enable_set(void *data, u64 val)
 	struct clk_core *core = data;
 	int ret = 0;
 
+	if (!core->write_enable)
+		return -EACCES;
+
 	if (val)
 		ret = clk_prepare_enable(core->hw->clk);
 	else
@@ -3301,6 +3306,9 @@ static int clk_prepare_enable_get(void *data, u64 *val)
 {
 	struct clk_core *core = data;
 
+	if (!core->write_enable)
+		return -EACCES;
+
 	*val = core->enable_count && core->prepare_count;
 	return 0;
 }
@@ -3308,11 +3316,6 @@ static int clk_prepare_enable_get(void *data, u64 *val)
 DEFINE_DEBUGFS_ATTRIBUTE(clk_prepare_enable_fops, clk_prepare_enable_get,
 			 clk_prepare_enable_set, "%llu\n");
 
-#else
-#define clk_rate_set	NULL
-#define clk_rate_mode	0444
-#endif
-
 static int clk_rate_get(void *data, u64 *val)
 {
 	struct clk_core *core = data;
@@ -3426,7 +3429,6 @@ static int current_parent_show(struct seq_file *s, void *data)
 }
 DEFINE_SHOW_ATTRIBUTE(current_parent);
 
-#ifdef CLOCK_ALLOW_WRITE_DEBUGFS
 static ssize_t current_parent_write(struct file *file, const char __user *ubuf,
 				    size_t count, loff_t *ppos)
 {
@@ -3460,7 +3462,6 @@ static const struct file_operations current_parent_rw_fops = {
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
-#endif
 
 static int clk_duty_cycle_show(struct seq_file *s, void *data)
 {
@@ -3524,7 +3525,6 @@ static void clk_debug_create_one(struct clk_core *core, struct dentry *pdentry)
 	debugfs_create_u32("clk_notifier_count", 0444, root, &core->notifier_count);
 	debugfs_create_file("clk_duty_cycle", 0444, root, core,
 			    &clk_duty_cycle_fops);
-#ifdef CLOCK_ALLOW_WRITE_DEBUGFS
 	debugfs_create_file("clk_prepare_enable", 0644, root, core,
 			    &clk_prepare_enable_fops);
 
@@ -3532,7 +3532,6 @@ static void clk_debug_create_one(struct clk_core *core, struct dentry *pdentry)
 		debugfs_create_file("clk_parent", 0644, root, core,
 				    &current_parent_rw_fops);
 	else
-#endif
 	if (core->num_parents > 0)
 		debugfs_create_file("clk_parent", 0444, root, core,
 				    &current_parent_fops);
@@ -3592,24 +3591,6 @@ static int __init clk_debug_init(void)
 {
 	struct clk_core *core;
 
-#ifdef CLOCK_ALLOW_WRITE_DEBUGFS
-	pr_warn("\n");
-	pr_warn("********************************************************************\n");
-	pr_warn("**     NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE           **\n");
-	pr_warn("**                                                                **\n");
-	pr_warn("**  WRITEABLE clk DebugFS SUPPORT HAS BEEN ENABLED IN THIS KERNEL **\n");
-	pr_warn("**                                                                **\n");
-	pr_warn("** This means that this kernel is built to expose clk operations  **\n");
-	pr_warn("** such as parent or rate setting, enabling, disabling, etc.      **\n");
-	pr_warn("** to userspace, which may compromise security on your system.    **\n");
-	pr_warn("**                                                                **\n");
-	pr_warn("** If you see this message and you are not debugging the          **\n");
-	pr_warn("** kernel, report this immediately to your vendor!                **\n");
-	pr_warn("**                                                                **\n");
-	pr_warn("**     NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE           **\n");
-	pr_warn("********************************************************************\n");
-#endif
-
 	rootdir = debugfs_create_dir("clk", NULL);
 
 	debugfs_create_file("clk_summary", 0444, rootdir, &all_lists,
-- 
2.34.1

