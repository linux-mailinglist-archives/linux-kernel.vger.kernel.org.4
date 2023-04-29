Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D186F24E1
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 15:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbjD2NhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 09:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjD2NhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 09:37:07 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900CF1FDD
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 06:37:05 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-32f23e2018fso110176375ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 06:37:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682775425; x=1685367425;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i+7gtFde1uJ31JhRfXbVrkLj5gYnzZd9OD9Pbp43K4c=;
        b=DeZBx9YHdcVXOTq1AQrwVYg4AwSFVbqZmuxQcIxaG6E4XwG60mUCiVj6HJjjik5Y9t
         dtYWtYzlUrZBuJRvWuq5CI+OA9xhetRXLu4MwbzqQ14j6ljx+U/l43Sbd09icI7gOcYB
         VTVqD5pg2x2rhOFQrGje/hGiRtojxK5bTGKcMU1TUgtKh7ApmlgrAs6CaMtipmiS+XBV
         ORLiV4MEWEknRjlQEIugI7yIH7BBg/MKu4yfSHsomCsfJyASWhj49pkUvvvwA11QMnaC
         moM/qmTa9RKo45yRgI6zTqDpqeYVFP+FX20D0kLkxfNzd4HMgg+v0bSuiwkGrhyFjWJV
         eQBg==
X-Gm-Message-State: AC+VfDyJJDqymXVL8Z/UqgZmWVx6vYvK88Sdfg/0t6Xvpks+3uVUsOoc
        1eKCa/bQuhleUJstXL+6FKn3ZMGz60IcPZLFWQOH6ysHyuht
X-Google-Smtp-Source: ACHHUZ7wMg/4Gx/whiLyBKTbzzTcMMt3Lr2bijgLBv3BWF29l5EAoCkMFpY9KAfVfRKhYnazhyWS/tICWVfv5So/EH5zXtTZuDUX
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1352:b0:329:66f6:470c with SMTP id
 k18-20020a056e02135200b0032966f6470cmr8718325ilr.3.1682775424942; Sat, 29 Apr
 2023 06:37:04 -0700 (PDT)
Date:   Sat, 29 Apr 2023 06:37:04 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000070ccd705fa79afe9@google.com>
Subject: [syzbot] upstream boot error: BUG: unable to handle kernel paging
 request in gic_handle_irq
From:   syzbot <syzbot+4aee2040dfac273d198e@syzkaller.appspotmail.com>
To:     geert+renesas@glider.be, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, magnus.damm@gmail.com,
        maz@kernel.org, syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    cec24b8b6bb8 Merge tag 'char-misc-6.4-rc1' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11334c30280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c159a5b5ee7dcf56
dashboard link: https://syzkaller.appspot.com/bug?extid=4aee2040dfac273d198e
compiler:       arm-linux-gnueabi-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4aee2040dfac273d198e@syzkaller.appspotmail.com

8<--- cut here ---
Unable to handle kernel paging request at virtual address df80a00c when read
[df80a00c] *pgd=80000080007003, *pmd=82893003, *pte=80216680
Internal error: Oops: 207 [#1] PREEMPT SMP ARM
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.3.0-syzkaller #0
Hardware name: ARM-Versatile Express
PC is at __raw_readl arch/arm/include/asm/io.h:113 [inline]
PC is at gic_handle_irq+0x1c/0x7c drivers/irqchip/irq-gic.c:344
LR is at generic_handle_arch_irq+0x60/0x80 kernel/irq/handle.c:238
pc : [<8086e724>]    lr : [<817e3dd0>]    psr: 20000193
sp : 82401e70  ip : 82401e90  fp : 82401e8c
r10: 825dfffd  r9 : 8241ae40  r8 : 00000000
r7 : df80a00c  r6 : 81f1590c  r5 : df80a000  r4 : 8240cde8
r3 : 8086e708  r2 : 00904870  r1 : 81f4ff24  r0 : 82401eb8
Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 30c5387d  Table: 80003000  DAC: fffffffd
Register r0 information:
8<--- cut here ---
Unable to handle kernel paging request at virtual address fffffff7 when read
[fffffff7] *pgd=80000080007003, *pmd=deffd003, *pte=00000000
Internal error: Oops: 207 [#2] PREEMPT SMP ARM


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
