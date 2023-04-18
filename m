Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09D46E57E7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 05:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjDRDpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 23:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjDRDps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 23:45:48 -0400
X-Greylist: delayed 61 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 17 Apr 2023 20:45:44 PDT
Received: from mx-lax3-2.ucr.edu (mx-lax3-2.ucr.edu [169.235.156.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8BE2D77
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 20:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1681789545; x=1713325545;
  h=mime-version:from:date:message-id:subject:to;
  bh=xDBjTaE67Cb+Nzj8qJ3O2h9jG2RsQrCHa6V0pN0XI9I=;
  b=PzMkxoR6+h42bsfrz5Om5KcZEViewNlkd0lOHN/MSjHIpeDvPPfzKc4v
   7S9tZ6TE0siMXxntcHu7ZjFce0beZvPESe/nSR0jye0jJXMXjCJMlBWJK
   NUTkv3T2iturl6dHvdgdeYZmKUzVhGVi+xyRayKApBMlr5pr9McL1Eok7
   DRnKPQeiuxW1eQnlO++73zwvoOh9K3/Tt46lrSL1l6+t7QIcanwTSnbgp
   xiFRZKxjZFsRZ7DcmwdfKVPpcysZY3EMdrKzcHcWiCIdl3p0sn0YVYdrI
   HbzCh+h7E6sv40fNJWG9upzMyWOtOlAjrmGSJzSkyx7N1LERRjg9aOHRN
   w==;
Received: from mail-wr1-f70.google.com ([209.85.221.70])
  by smtp-lax3-2.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Apr 2023 20:44:42 -0700
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-2f43679bcf5so1192486f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 20:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1681789480; x=1684381480;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kROVwPDEPMCQDtsOlJbEFcTtu/j+d1Kp4iPlnoa2yyc=;
        b=a4+y63KY0KnU9Ry1bt84+EHLtLQixgxjfpRbnW2b9nqpJxPrvI/WUJ/CWbragMyyL6
         uirwfGMDldKUH19/RxoPpRmVidPIn/JP3sQzUYV9ntO+nIgeiec9UzaIqGM3oCeIsb5M
         I59JOzsVeUm3b/cPjSdDp9R6J6NI/4bVnxTpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681789480; x=1684381480;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kROVwPDEPMCQDtsOlJbEFcTtu/j+d1Kp4iPlnoa2yyc=;
        b=E0HGa6DKeRwOz4s13oRxyLFfG9d9I9XkQUj1pe0Uan+UgpEukHQsaXkUZj2KteEA/m
         i/oKEwGL5uji5ZuSZwzDfDd9VFOx/yN2qwdlRhJpck55fJ91Pqx6dOgrWi9m4/Toi6Ln
         kNUAL+KOxQVzHaVMpGDhbaR/s/iu+87X10B6P2sMvUwpZm9YIERq9uStmt4MEGJlj8st
         35XUva0BR8GJepzuhPkS+0e43i5Ne7WUSMG0CIYP+ibfrJkFqR6rcU/n/krgDlyd+8Qj
         pfk9pLDto9Mj5vS/CLpk+wAENbTx0/xJQllPwwTfrwc1bkKGlz1evxd0Wbq5pQ69LS8w
         p3Tw==
X-Gm-Message-State: AAQBX9eAdKz7nHbfWHXbLVOxmKfkmKItGhFbQq8PdwlV0OstDzhEJwT1
        FoK31X06nTb24dR202WylQTBP5j8mtGIFnwM4wT0u8/+oAgBU8e9VqEi4G+tIizQS+QIivT795l
        w9+u78B+PGYy3401VwGn5pWVleAfKHr/V2slslfGz0zSkJl+K+qMH
X-Received: by 2002:a5d:4007:0:b0:2c7:1d0d:7184 with SMTP id n7-20020a5d4007000000b002c71d0d7184mr706699wrp.11.1681789479957;
        Mon, 17 Apr 2023 20:44:39 -0700 (PDT)
X-Google-Smtp-Source: AKy350bEL3kIbpPoiT9TMFoCNPYUY0MQviV70fYqmzhA3Q91cjkDxTcnIazQQZOzZMfX6bfttfavfLxdGsTdZnQaqow=
X-Received: by 2002:a5d:4007:0:b0:2c7:1d0d:7184 with SMTP id
 n7-20020a5d4007000000b002c71d0d7184mr706693wrp.11.1681789479647; Mon, 17 Apr
 2023 20:44:39 -0700 (PDT)
MIME-Version: 1.0
From:   Yu Hao <yhao016@ucr.edu>
Date:   Mon, 17 Apr 2023 20:44:30 -0700
Message-ID: <CA+UBctCZok5FSQ=LPRA+A-jocW=L8FuMVZ_7MNqhh483P5yN8A@mail.gmail.com>
Subject: BUG: sleeping function called from invalid context in __might_resched
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

We found the following issue using syzkaller on Linux v6.2.0.
A similar bug was found in function `n_hdlc_tty_wakeup` before.
(https://groups.google.com/g/syzkaller-bugs/c/XAyZCUO-eAY/m/Lpj5SzDNAwAJ)
Now it is found in a different caller `gsmld_write`.
It needs to fix the bug in `gsmld_write` again.

The full report including the C reproducer:
https://gist.github.com/ZHYfeng/eb410de5d7aec253d8c83cf34e628d6a

The brief report is below:

Syzkaller hit 'BUG: sleeping function called from invalid context in
__might_resched' bug.

BUG: sleeping function called from invalid context at
kernel/printk/printk.c:2656
in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 9817, name: (agetty)
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
3 locks held by (agetty)/9817:
 #0: ffff888017797098 (&tty->ldisc_sem){++++}-{0:0}, at:
tty_ldisc_ref_wait+0x27/0x80 drivers/tty/tty_ldisc.c:244
 #1: ffff888017797130 (&tty->atomic_write_lock){+.+.}-{3:3}, at:
tty_write_lock+0x23/0x90 drivers/tty/tty_io.c:944
 #2: ffff888046ee93e0 (&gsm->tx_lock){....}-{2:2}, at:
gsmld_write+0x63/0x150 drivers/tty/n_gsm.c:3410
irq event stamp: 3146
hardirqs last  enabled at (3145): [<ffffffff8a0f3a32>]
syscall_enter_from_user_mode+0x22/0xb0 kernel/entry/common.c:111
hardirqs last disabled at (3146): [<ffffffff8a12e6b3>]
__raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:108 [inline]
hardirqs last disabled at (3146): [<ffffffff8a12e6b3>]
_raw_spin_lock_irqsave+0x53/0x60 kernel/locking/spinlock.c:162
softirqs last  enabled at (0): [<ffffffff814b301d>]
copy_process+0x1a8d/0x7490 kernel/fork.c:2211
softirqs last disabled at (0): [<0000000000000000>] 0x0
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 0 PID: 9817 Comm: (agetty) Not tainted 6.2.0 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 __might_resched.cold+0x222/0x26b kernel/sched/core.c:10045
 console_lock+0x1c/0x80 kernel/printk/printk.c:2656
 do_con_write+0x114/0x1e40 drivers/tty/vt/vt.c:2908
 con_write+0x26/0x40 drivers/tty/vt/vt.c:3295
 gsmld_write+0xd0/0x150 drivers/tty/n_gsm.c:3413
 do_tty_write drivers/tty/tty_io.c:1018 [inline]
 file_tty_write.isra.0+0x48f/0x820 drivers/tty/tty_io.c:1089
 call_write_iter include/linux/fs.h:2189 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x9cf/0xd90 fs/read_write.c:584
 ksys_write+0x12c/0x250 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f5538c101b0
Code: 2e 0f 1f 84 00 00 00 00 00 90 48 8b 05 19 7e 20 00 c3 0f 1f 84
00 00 00 00 00 83 3d 19 c2 20 00 00 75 10 b8 01 00 00 00 0f 05 <48> 3d
01 f0 ff ff 73 31 c3 48 83 ec 08 e8 ae fc ff ff 48 89 04 24
RSP: 002b:00007ffdb4aadbe8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 000000000000000a RCX: 00007f5538c101b0
RDX: 000000000000000a RSI: 00007f553b13ccbe RDI: 0000000000000003
RBP: 00007f553b13ccbe R08: 00007ffdb4aadba0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
R13: 0000000000000000 R14: ffffffffffffffff R15: 00007ffdb4aadea0
 </TASK>
