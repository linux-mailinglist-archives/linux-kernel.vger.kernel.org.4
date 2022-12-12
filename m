Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30FF46497F5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 03:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbiLLCid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 21:38:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbiLLCib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 21:38:31 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB566552
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 18:38:30 -0800 (PST)
Received: from kwepemi500024.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NVm4X6NHTzmWZP;
        Mon, 12 Dec 2022 10:37:32 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemi500024.china.huawei.com
 (7.221.188.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 12 Dec
 2022 10:38:28 +0800
From:   Zeng Heng <zengheng4@huawei.com>
To:     <jirislaby@kernel.org>, <deller@gmx.de>,
        <gregkh@linuxfoundation.org>, <zhangxuezhi1@coolpad.com>,
        <ilpo.jarvinen@linux.intel.com>, <daniel.vetter@ffwll.ch>,
        <daniel.starke@siemens.com>
CC:     <liwei391@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] tty/vt: fix sleeping function called from invalid context in do_con_write()
Date:   Mon, 12 Dec 2022 10:35:30 +0800
Message-ID: <20221212023530.2498025-1-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500024.china.huawei.com (7.221.188.100)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a BUG report from syzkaller:

BUG: sleeping function called from invalid context at kernel/printk/printk.c:2565

3 locks held by mingetty/6405:
 #0: ffff8881109b7098 (&tty->ldisc_sem){++++}-{0:0},
	at: tty_ldisc_ref_wait+0x22/0x80
 #1: ffff8881109b7130 (&tty->atomic_write_lock){+.+.}-{3:3},
	at: file_tty_write.constprop.0+0x26f/0x8c0
 #2: ffff8880147293e0 (&gsm->tx_lock){....}-{2:2},
	at: gsmld_write+0x5e/0x140

Call Trace:
 __might_resched.cold+0x222/0x26b
 console_lock+0x17/0x80
 do_con_write+0x10f/0x1e30
 con_write+0x21/0x40
 gsmld_write+0xcb/0x140
 file_tty_write.constprop.0+0x471/0x8c0
 vfs_write+0x9ef/0xde0
 ksys_write+0x127/0x250
 do_syscall_64+0x35/0x80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

And another bug report caused by the same reason is shown as below:

BUG: spinlock wrong CPU on CPU#2, mingetty/30460
 lock: 0xffff8880340553c8, .magic: dead4ead, .owner: mingetty/30460, .owner_cpu: 1
Call Trace:
 dump_stack_lvl+0xcd/0x134
 do_raw_spin_unlock+0x1af/0x230
 _raw_spin_unlock_irqrestore+0x1e/0x70
 gsmld_write+0xde/0x140

In gsmld_write(), in case of race condition, it would fetch the spin-lock
and disable IRQ. But in the following trace, do_con_write() attempt to down
semaphore which would probably cause re-schedule task and in further, IRQs
woud be ignored for a quite time.

Add if condition in do_con_write(). When the current task is in atomic
context, return immediately.

Fixes: 32dd59f96924 ("tty: n_gsm: fix race condition in gsmld_write()")
Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 drivers/tty/vt/vt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 981d2bfcf9a5..7662b6eb0836 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2902,7 +2902,7 @@ static int do_con_write(struct tty_struct *tty, const unsigned char *buf, int co
 	struct vt_notifier_param param;
 	bool rescan;
 
-	if (in_interrupt())
+	if (in_interrupt() || irqs_disabled())
 		return count;
 
 	console_lock();
@@ -3358,7 +3358,7 @@ static void con_flush_chars(struct tty_struct *tty)
 {
 	struct vc_data *vc;
 
-	if (in_interrupt())	/* from flush_to_ldisc */
+	if (in_interrupt() || irqs_disabled())	/* from flush_to_ldisc */
 		return;
 
 	/* if we race with con_close(), vt may be null */
-- 
2.25.1

