Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89D66E8B67
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 09:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234100AbjDTH1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 03:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234057AbjDTH1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 03:27:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31BE4C2C
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 00:27:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DE9A6457F
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 07:27:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17D19C433D2;
        Thu, 20 Apr 2023 07:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681975648;
        bh=NVw8V8F7KES4FsBHfm//e0CtYsLVO0znyJS14sgnyN8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ECiwGlrQdrSz0avemQU/m0qoDlDxy+0EDhluEGE4U5+f8VFgGPXxTPQ9fsaPnh5Qq
         YXoTUohfMfHSIbq49y/apjDO8Mns3HOlCguGPX6xxhBqogH+NBQHsBHlI34jac+M1W
         yUMM6kTbGUxPOrbm0qr71ZLBRssYgGgMOkInoJi9ByTTYEvWkEfPBR+/uO/LJRtr3b
         wWzZngO4EfzN3MUyuAaWDmFODfJKCN/pyCKJzYoZPqiV4wUiTEuRPrwAIqdxuPGWP5
         iJaNz6DVSWJlB+oWPSLB4jVDm6+iHHjZz0MBQRR/ozWpl//UkU3qbsLLeeMXq+VI6t
         frTbh3VSLcIEA==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org, jassisinghbrar@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mailbox: mailbox-test: Fix potential double-free in mbox_test_message_write()
Date:   Thu, 20 Apr 2023 08:27:18 +0100
Message-ID: <20230420072718.881079-2-lee@kernel.org>
X-Mailer: git-send-email 2.40.0.396.gfff15efe05-goog
In-Reply-To: <20230420072718.881079-1-lee@kernel.org>
References: <20230420072718.881079-1-lee@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a user can make copy_from_user() fail, there is a potential for
UAF/DF due to a lack of locking around the allocation, use and freeing
of the data buffers.

This issue is not theoretical.  I managed to author a POC for it:

    BUG: KASAN: double-free in kfree+0x5c/0xac
    Free of addr ffff29280be5de00 by task poc/356
    CPU: 1 PID: 356 Comm: poc Not tainted 6.1.0-00001-g961aa6552c04-dirty #20
    Hardware name: linux,dummy-virt (DT)
    Call trace:
     dump_backtrace.part.0+0xe0/0xf0
     show_stack+0x18/0x40
     dump_stack_lvl+0x64/0x80
     print_report+0x188/0x48c
     kasan_report_invalid_free+0xa0/0xc0
     ____kasan_slab_free+0x174/0x1b0
     __kasan_slab_free+0x18/0x24
     __kmem_cache_free+0x130/0x2e0
     kfree+0x5c/0xac
     mbox_test_message_write+0x208/0x29c
     full_proxy_write+0x90/0xf0
     vfs_write+0x154/0x440
     ksys_write+0xcc/0x180
     __arm64_sys_write+0x44/0x60
     invoke_syscall+0x60/0x190
     el0_svc_common.constprop.0+0x7c/0x160
     do_el0_svc+0x40/0xf0
     el0_svc+0x2c/0x6c
     el0t_64_sync_handler+0xf4/0x120
     el0t_64_sync+0x18c/0x190

    Allocated by task 356:
     kasan_save_stack+0x3c/0x70
     kasan_set_track+0x2c/0x40
     kasan_save_alloc_info+0x24/0x34
     __kasan_kmalloc+0xb8/0xc0
     kmalloc_trace+0x58/0x70
     mbox_test_message_write+0x6c/0x29c
     full_proxy_write+0x90/0xf0
     vfs_write+0x154/0x440
     ksys_write+0xcc/0x180
     __arm64_sys_write+0x44/0x60
     invoke_syscall+0x60/0x190
     el0_svc_common.constprop.0+0x7c/0x160
     do_el0_svc+0x40/0xf0
     el0_svc+0x2c/0x6c
     el0t_64_sync_handler+0xf4/0x120
     el0t_64_sync+0x18c/0x190

    Freed by task 357:
     kasan_save_stack+0x3c/0x70
     kasan_set_track+0x2c/0x40
     kasan_save_free_info+0x38/0x5c
     ____kasan_slab_free+0x13c/0x1b0
     __kasan_slab_free+0x18/0x24
     __kmem_cache_free+0x130/0x2e0
     kfree+0x5c/0xac
     mbox_test_message_write+0x208/0x29c
     full_proxy_write+0x90/0xf0
     vfs_write+0x154/0x440
     ksys_write+0xcc/0x180
     __arm64_sys_write+0x44/0x60
     invoke_syscall+0x60/0x190
     el0_svc_common.constprop.0+0x7c/0x160
     do_el0_svc+0x40/0xf0
     el0_svc+0x2c/0x6c
     el0t_64_sync_handler+0xf4/0x120
     el0t_64_sync+0x18c/0x190

Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/mailbox/mailbox-test.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mailbox/mailbox-test.c b/drivers/mailbox/mailbox-test.c
index 51e62817f2438..c4a705c303314 100644
--- a/drivers/mailbox/mailbox-test.c
+++ b/drivers/mailbox/mailbox-test.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/mailbox_client.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/poll.h>
@@ -39,6 +40,7 @@ struct mbox_test_device {
 	char			*signal;
 	char			*message;
 	spinlock_t		lock;
+	struct mutex		mutex;
 	wait_queue_head_t	waitq;
 	struct fasync_struct	*async_queue;
 	struct dentry		*root_debugfs_dir;
@@ -111,6 +113,8 @@ static ssize_t mbox_test_message_write(struct file *filp,
 		return -EINVAL;
 	}
 
+	mutex_lock(&tdev->mutex);
+
 	tdev->message = kzalloc(MBOX_MAX_MSG_LEN, GFP_KERNEL);
 	if (!tdev->message)
 		return -ENOMEM;
@@ -145,6 +149,8 @@ static ssize_t mbox_test_message_write(struct file *filp,
 	kfree(tdev->message);
 	tdev->signal = NULL;
 
+	mutex_unlock(&tdev->mutex);
+
 	return ret < 0 ? ret : count;
 }
 
@@ -393,6 +399,7 @@ static int mbox_test_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, tdev);
 
 	spin_lock_init(&tdev->lock);
+	mutex_init(&tdev->mutex);
 
 	if (tdev->rx_channel) {
 		tdev->rx_buffer = devm_kzalloc(&pdev->dev,
-- 
2.40.0.396.gfff15efe05-goog

