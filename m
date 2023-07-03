Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 853797456EC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 10:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbjGCIG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 04:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbjGCIGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 04:06:15 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90C81BD0
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 01:05:23 -0700 (PDT)
Received: from kwepemm600014.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Qvdf53Z7vzMqF6;
        Mon,  3 Jul 2023 16:01:01 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.175.28) by
 kwepemm600014.china.huawei.com (7.193.23.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 3 Jul 2023 16:04:14 +0800
From:   Yi Yang <yiyang13@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>
CC:     <jannh@google.com>, <linux-kernel@vger.kernel.org>,
        <fengtao40@huawei.com>, <guozihua@huawei.com>,
        <yiyang13@huawei.com>
Subject: [PATCH RFC] tty: tty_jobctrl: fix pid memleak in tty_signal_session_leader()
Date:   Mon, 3 Jul 2023 16:03:23 +0800
Message-ID: <20230703080323.76548-1-yiyang13@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.28]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600014.china.huawei.com (7.193.23.54)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a leaked pid in tty.

unreferenced object 0xffff889362619440 (size 112):
  comm "sudo", pid 3603376, jiffies 4462415649 (age 71614.172s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 0f 00 40 da  ..............@.
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000fd13ed06>] alloc_pid+0x85/0x6b0
    [<000000007c449cf0>] copy_process+0xf60/0x2840
    [<000000008c3ae147>] kernel_clone+0x11a/0x510
    [<000000005d9b1265>] __se_sys_clone+0xcd/0x110
    [<000000009d4d672e>] do_syscall_64+0x33/0x40
    [<000000002fc0b8b9>] entry_SYSCALL_64_after_hwframe+0x61/0xc6

Race condition between disassociate_ctty() and tty_signal_session_leader()
was found, which would cause a leakage of tty_old_pgrp. The race condition
is described as follows:

CPU1:				CPU2:
disassociate_ctty()
{
   ...
   spin_lock_irq(&current->sighand->siglock);
   put_pid(current->signal->tty_old_pgrp);
   current->signal->tty_old_pgrp = NULL;
   tty = tty_kref_get(current->signal->tty);
   spin_unlock_irq(&current->sighand->siglock);

			tty_signal_session_leader()
			{
			   spin_lock_irq(&p->sighand->siglock);
			   ...
			   spin_lock(&tty->ctrl_lock);
			   tty_pgrp = get_pid(tty->pgrp);
			   if (tty->pgrp)
	An extra get>>       p->signal->tty_old_pgrp = get_pid(tty->pgrp);
			   spin_unlock(&tty->ctrl_lock);
			   spin_unlock_irq(&p->sighand->siglock);
			}

  if (tty) {
    tty_lock(tty);
    spin_lock_irqsave(&tty->ctrl_lock, flags);
    ...
    tty->pgrp = NULL;
    spin_unlock_irqrestore(&tty->ctrl_lock, flags);
    tty_unlock(tty);
    tty_kref_put(tty);
  }
}

The issue is believed to be introduced by commit c8bcd9c5be24 ("tty:
Fix ->session locking") who moves the unlock of siglock in
disassociate_ctty() above "if (tty)", making a small window allowing
tty_signal_session_leader()to kick in. It can be easily reproduced by
adding a delay before "if (tty)".

To fix this issue, we check whether the session leader is exiting before
assigning a new tty_old_pgrp.

Fixes: c8bcd9c5be24 ("tty: Fix ->session locking")
Signed-off-by: Yi Yang <yiyang13@huawei.com>
Co-developed-by: GUO Zihua <guozihua@huawei.com>
Signed-off-by: GUO Zihua <guozihua@huawei.com>
---
 drivers/tty/tty_jobctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/tty_jobctrl.c b/drivers/tty/tty_jobctrl.c
index 0d04287da098..f9a144aaedfc 100644
--- a/drivers/tty/tty_jobctrl.c
+++ b/drivers/tty/tty_jobctrl.c
@@ -220,7 +220,7 @@ int tty_signal_session_leader(struct tty_struct *tty, int exit_session)
 			put_pid(p->signal->tty_old_pgrp);  /* A noop */
 			spin_lock(&tty->ctrl.lock);
 			tty_pgrp = get_pid(tty->ctrl.pgrp);
-			if (tty->ctrl.pgrp)
+			if (tty->ctrl.pgrp && !(p->flags & PF_EXITING))
 				p->signal->tty_old_pgrp =
 					get_pid(tty->ctrl.pgrp);
 			spin_unlock(&tty->ctrl.lock);
-- 
2.17.1

