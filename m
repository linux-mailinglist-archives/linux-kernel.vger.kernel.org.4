Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2F1709C31
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 18:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjESQOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 12:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjESQOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 12:14:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8EA10DD;
        Fri, 19 May 2023 09:14:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5762365905;
        Fri, 19 May 2023 16:14:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22FFAC433EF;
        Fri, 19 May 2023 16:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684512846;
        bh=DazjSu0p439CX/aFG0CP+vx6931tX9hLexv94jEHTmo=;
        h=From:To:Cc:Subject:Date:From;
        b=tHAu7idGKo4VEDxhXTHOkeFRm61j7leOD+13gHi6emQ++oTvwrJQiMR50++QfBcoY
         VPSvAj7mYEgWeGj8X90sk9BrAOrNJYK9HZGAqydNnTy+TWLT16f9wPx47EeBfvmNVx
         GxJI0dZYmtCvamf3X5UCp9MK9LaXU90ckOgWO/8BTiZWf4qWUhHcND5D4kLxNJG8hP
         S3VmhnJIHxve1zGy7g2SYrJeJYZ1eaxjQw6OvMpwWX85O998LFP+uJPPi1IpOIn/up
         6hXDQ5A9thUcGrIjXw0unCH6snEtQoG65FSQ1auegE9G6/FuQv1FMTnLj++n7g/Aau
         db99J0k57xeYw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lee Jones <lee@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Sasha Levin <sashal@kernel.org>, jassisinghbrar@gmail.com
Subject: [PATCH AUTOSEL 4.19] mailbox: mailbox-test: Fix potential double-free in mbox_test_message_write()
Date:   Fri, 19 May 2023 12:14:04 -0400
Message-Id: <20230519161404.2756494-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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

From: Lee Jones <lee@kernel.org>

[ Upstream commit 2d1e952a2b8e5e92d8d55ac88a7cf7ca5ea591ad ]

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
Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mailbox/mailbox-test.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mailbox/mailbox-test.c b/drivers/mailbox/mailbox-test.c
index 129b3656c453a..c7ff9653223bf 100644
--- a/drivers/mailbox/mailbox-test.c
+++ b/drivers/mailbox/mailbox-test.c
@@ -16,6 +16,7 @@
 #include <linux/kernel.h>
 #include <linux/mailbox_client.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/poll.h>
@@ -43,6 +44,7 @@ struct mbox_test_device {
 	char			*signal;
 	char			*message;
 	spinlock_t		lock;
+	struct mutex		mutex;
 	wait_queue_head_t	waitq;
 	struct fasync_struct	*async_queue;
 };
@@ -114,6 +116,8 @@ static ssize_t mbox_test_message_write(struct file *filp,
 		return -EINVAL;
 	}
 
+	mutex_lock(&tdev->mutex);
+
 	tdev->message = kzalloc(MBOX_MAX_MSG_LEN, GFP_KERNEL);
 	if (!tdev->message)
 		return -ENOMEM;
@@ -148,6 +152,8 @@ static ssize_t mbox_test_message_write(struct file *filp,
 	kfree(tdev->message);
 	tdev->signal = NULL;
 
+	mutex_unlock(&tdev->mutex);
+
 	return ret < 0 ? ret : count;
 }
 
@@ -396,6 +402,7 @@ static int mbox_test_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, tdev);
 
 	spin_lock_init(&tdev->lock);
+	mutex_init(&tdev->mutex);
 
 	if (tdev->rx_channel) {
 		tdev->rx_buffer = devm_kzalloc(&pdev->dev,
-- 
2.39.2

