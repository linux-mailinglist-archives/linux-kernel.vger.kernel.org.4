Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2265F6FFBFF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 23:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239375AbjEKVlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 17:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232437AbjEKVlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 17:41:21 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649F66A5A
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 14:41:12 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-763c3442563so602681439f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 14:41:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683841271; x=1686433271;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZnNVGSdwvev+0rTu8W8x2OttEZdggd2UjeO9MspjFWQ=;
        b=lKOSWcViaFcyH1h5HY/m4OWwLQOYWOHw2S27hxN5DDlzuDXJdG1R8I27UnC2HFp+rM
         5Y5yWRCCEP+0K37dyf2AVQz7anI2J8NZTBkv/Y9LJSNDfdnFtlsBNeGLEDBUovHgyaz+
         amX32TRQ4n3cY9UpGuPw88fSWMSMwdP7sPL8tOBY0loNO2TN/YhOhcgWwLktOFSeTtGU
         AYrVdUaZh15LKD7yRXFS6xfz33j0p9KkCH2nJzBZ/TnqfkNFsMOPvNxdPrJ3mpxorQJP
         HdNulr2nWU3F7QtUKYY56zwaGjagzW0lAffHbW811w1EcG1RTCpUD2H82ChVXcujAeN7
         XioA==
X-Gm-Message-State: AC+VfDwQjxaGEWvjFFP0ugfpAa/IlITCIan+9CItSfFvSG8NRxJTDze+
        XvmK5gI4cLTOge0y+rZAosvq37KHa50e2Webb07oWpoFD2Rw
X-Google-Smtp-Source: ACHHUZ5LoNRmmBWjtcVAzm6FeN6ZQ7EdsscoZsWIcYL13IlOVYJYzL8WaVi//8oSbFOmkaapVNqL+NKYhhNwwudGTMS0708cHall
MIME-Version: 1.0
X-Received: by 2002:a5e:a90a:0:b0:76c:7d48:d798 with SMTP id
 c10-20020a5ea90a000000b0076c7d48d798mr1692027iod.0.1683841271603; Thu, 11 May
 2023 14:41:11 -0700 (PDT)
Date:   Thu, 11 May 2023 14:41:11 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000da2a8505fb71d81b@google.com>
Subject: [syzbot] upstream boot error: BUG: unable to handle kernel NULL
 pointer dereference in gic_eoi_irq
From:   syzbot <syzbot+afc1d968649e7e851562@syzkaller.appspotmail.com>
To:     geert+renesas@glider.be, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, magnus.damm@gmail.com,
        maz@kernel.org, syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    ac9a78681b92 Linux 6.4-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=102a3f6a280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cc86fee67199911d
dashboard link: https://syzkaller.appspot.com/bug?extid=afc1d968649e7e851562
compiler:       arm-linux-gnueabi-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/c35b5b2731d2/non_bootable_disk-ac9a7868.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c04bec59d77d/vmlinux-ac9a7868.xz
kernel image: https://storage.googleapis.com/syzbot-assets/070113b307f3/zImage-ac9a7868.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+afc1d968649e7e851562@syzkaller.appspotmail.com

8<--- cut here ---
Unable to handle kernel NULL pointer dereference at virtual address 000005f4 when read
[000005f4] *pgd=80000080004003, *pmd=00000000
Internal error: Oops: 207 [#1] PREEMPT SMP ARM
Modules linked in:
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.4.0-rc1-syzkaller #0
Hardware name: ARM-Versatile Express
PC is at gic_eoi_irq+0x64/0x70 drivers/irqchip/irq-gic.c:228
LR is at handle_percpu_devid_irq+0xb8/0x2d4 kernel/irq/chip.c:944
pc : [<8087e328>]    lr : [<802bf798>]    psr: 20000193
sp : df805f60  ip : df805f78  fp : df805f74
r10: 00000000  r9 : 831f4680  r8 : 00000001
r7 : 0000001c  r6 : 81b0febc  r5 : 000005f0  r4 : 8309a218
r3 : 000005f0  r2 : 0009127a  r1 : ddde8b00  r0 : 8309a218
Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 30c5387d  Table: 84804d80  DAC: 00000000
Register r0 information: slab kmalloc-256 start 8309a200 pointer offset 24 size 256
Register r1 information: non-slab/vmalloc memory
Register r2 information:
8<--- cut here ---
Unable to handle kernel NULL pointer dereference at virtual address 000001ff when read
[000001ff] *pgd=80000080004003, *pmd=00000000
Internal error: Oops: 207 [#2] PREEMPT SMP ARM
Modules linked in:
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.4.0-rc1-syzkaller #0
Hardware name: ARM-Versatile Express
PC is at __find_vmap_area mm/vmalloc.c:841 [inline]
PC is at find_vmap_area mm/vmalloc.c:1862 [inline]
PC is at find_vm_area mm/vmalloc.c:2623 [inline]
PC is at vmalloc_dump_obj+0x38/0xb4 mm/vmalloc.c:4221
LR is at __raw_spin_lock include/linux/spinlock_api_smp.h:132 [inline]
LR is at _raw_spin_lock+0x18/0x58 kernel/locking/spinlock.c:154
pc : [<8047a2ec>]    lr : [<81801fd4>]    psr: 20000193
sp : df805df0  ip : df805dd8  fp : df805e04
r10: 831f4680  r9 : 8261c9a4  r8 : 8285041c
r7 : 60000193  r6 : 00000003  r5 : 00092000  r4 : 00000207
r3 : 830e13a0  r2 : 00001dda  r1 : 00000000  r0 : 00000001
Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 30c5387d  Table: 84804d80  DAC: 00000000


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
