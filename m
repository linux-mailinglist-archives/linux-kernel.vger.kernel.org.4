Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03A46F24E0
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 15:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjD2NhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 09:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjD2NhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 09:37:06 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BAAB1994
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 06:37:05 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-32b51da14a9so4364555ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 06:37:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682775424; x=1685367424;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ntpEb2v6t5YxF3MBMr3e4Pfov8hnyljpRnIsUSWLUeM=;
        b=UnxoBKCvWEb6wJWTLn/Ksocd6plLb18O72LWefjLBQsPWjNItBGNVmgVvUU1/xS3sU
         +s9jJHojW9APLEGdls6l0wVdqACFVaLfV0XBMXp5P62/vFwO1Av55itIPx+xG1qJgV9F
         r37uvNdORGHCNk+OID+NW+m+aLqX2tb1G4QiZG4ahPl1htTz5lG/x4BIFrlLzcjgCC7D
         xfjc6H71Yr4ZGVo15d8Sf3HYJHY2JcIFweItJH4UdFAgzrGXUBACiPMXZIGvjyg/UgCS
         zSCG0j3Fftyr/mVR2EoIvJmmT9J9EPC77IjVbwwGT2f0towQ0Zw7DJLGZGUfYDIPL+vU
         gNGA==
X-Gm-Message-State: AC+VfDxco8s5LA6TsHVd14Ngk9c5oGejAsndyDo7JEAGAHf7eG6GkaE1
        v0SFv275tAIk9C9qNT00ksAgA8a3hawVTHjSTBDdhVn0sU59NXQ=
X-Google-Smtp-Source: ACHHUZ7ZDBp7FW05qbNS4ITPjrf0GN8MRyLdc8OxX+U9fVcK89p9nA9DK8aEoxshvwSrwaq3jtgo3VGE6S/t3AeYXJGJEi76SxkT
MIME-Version: 1.0
X-Received: by 2002:a02:84a7:0:b0:3c5:1302:c88a with SMTP id
 f36-20020a0284a7000000b003c51302c88amr3873045jai.0.1682775424641; Sat, 29 Apr
 2023 06:37:04 -0700 (PDT)
Date:   Sat, 29 Apr 2023 06:37:04 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006c30a305fa79afe5@google.com>
Subject: [syzbot] upstream boot error: BUG: unable to handle kernel paging
 request in __irq_resolve_mapping
From:   syzbot <syzbot+bf1c5e262f97aca4bc88@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, maz@kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
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

HEAD commit:    36006b1d5c04 Merge tag 'ata-6.4-rc1' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1014285fc80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fdfddd4c38713bb9
dashboard link: https://syzkaller.appspot.com/bug?extid=bf1c5e262f97aca4bc88
compiler:       arm-linux-gnueabi-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bf1c5e262f97aca4bc88@syzkaller.appspotmail.com

vkms_vblank_simulate: vblank timer overrun
vkms_vblank_simulate: vblank timer overrun
8<--- cut here ---
Unable to handle kernel paging request at virtual address 000c019f when read
[000c019f] *pgd=80000080004003, *pmd=00000000
Internal error: Oops: 207 [#1] PREEMPT SMP ARM
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.3.0-syzkaller #0
Hardware name: ARM-Versatile Express
PC is at irq_data_to_desc include/linux/irqdesc.h:124 [inline]
PC is at __irq_resolve_mapping+0x40/0x90 kernel/irq/irqdomain.c:968
LR is at rcu_read_lock include/linux/rcupdate.h:771 [inline]
LR is at __irq_resolve_mapping+0x20/0x90 kernel/irq/irqdomain.c:960
pc : [<802bd68c>]    lr : [<802bd66c>]    psr: 200c0193
sp : 82401e40  ip : 82401e40  fp : 82401e5c
r10: 825df6a1  r9 : 8241ae40  r8 : 00000000
r7 : df80a00c  r6 : 00000000  r5 : 0000001b  r4 : 82894000
r3 : 8021666c  r2 : 8241ae40  r1 : 0000001b  r0 : 000c0193
Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 30c5387d  Table: 840da040  DAC: fffffffd
Register r0 information: 2-page vmalloc region starting at 0xffffffff allocated at kernel_clone+0x9c/0x3d4 kernel/fork.c:2774
Register r1 information: 2-page vmalloc region starting at 0xffffffff allocated at kernel_clone+0x9c/0x3d4 kernel/fork.c:2774
Register r2 information: 2-page vmalloc region starting at 0xffffffff allocated at kernel_clone+0x9c/0x3d4 kernel/fork.c:2774
Register r3 information: 2-page vmalloc region starting at 0xffffffff allocated at kernel_clone+0x9c/0x3d4 kernel/fork.c:2774
Register r4 information: slab kmalloc-1k start 82894000 pointer offset 0 size 1024
Register r5 information: 2-page vmalloc region starting at 0xffffffff allocated at kernel_clone+0x9c/0x3d4 kernel/fork.c:2774
Register r6 information: 2-page vmalloc region starting at 0xffffffff allocated at kernel_clone+0x9c/0x3d4 kernel/fork.c:2774
Register r7 information:
8<--- cut here ---
Unable to handle kernel paging request at virtual address fffffff7 when read
[fffffff7] *pgd=80000080007003, *pmd=deffd003, *pte=00000000
Internal error: Oops: 207 [#2] PREEMPT SMP ARM
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.3.0-syzkaller #0
Hardware name: ARM-Versatile Express
PC is at __find_vmap_area mm/vmalloc.c:841 [inline]
PC is at find_vmap_area mm/vmalloc.c:1862 [inline]
PC is at find_vm_area mm/vmalloc.c:2571 [inline]
PC is at vmalloc_dump_obj+0x38/0xb4 mm/vmalloc.c:4108
LR is at __raw_spin_lock include/linux/spinlock_api_smp.h:132 [inline]
LR is at _raw_spin_lock+0x18/0x58 kernel/locking/spinlock.c:154
pc : [<8046b3a8>]    lr : [<817ddddc>]    psr: a00c0193
sp : 82401cd0  ip : 82401cb8  fp : 82401ce4
r10: 8241ae40  r9 : 8241c964  r8 : 8264d41c
r7 : 600c0193  r6 : 00000008  r5 : df80b000  r4 : ffffffff
r3 : 80216684  r2 : 00001dd7  r1 : 00000000  r0 : 00000001
Flags: NzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 30c5387d  Table: 840da040  DAC: fffffffd


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
