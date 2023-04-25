Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 230396EE8CC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 22:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236237AbjDYUGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 16:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236230AbjDYUGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 16:06:44 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D97B463
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 13:06:43 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7635a2dd490so963006339f.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 13:06:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682453202; x=1685045202;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p4fMexIJHfqxhZnypL/zvA27ZdlKr/POdpuWq1kaqlA=;
        b=B4UXrarBN+v7iRo58BYjJx+frnILjt0DIG+CyRcbnLBJUHuj9jdtux3slp/zy0+V2f
         ruVVOddCo1Niu0YiEoLVZvJGIJuHFiDvSvwEsm06x5hQtq/Pjd2rV++PDAmT7oX4kmQB
         zq6Lr5+Kalpv8qGrjC0rY3W7ls0IKeKomK9wANMFj/9SajgMesz5qVAn3CKizqDaWQBe
         2ErWhsWCSsbQyfZU7G7XActRL0IlumDdLf+KuED279u7C4hnv0RfvfvgPdB5WIjYPPLK
         p2auCWGeQv7bnSPF4UtXpmXoowKNWw5L1Ytqwe30ZqfQANfP7yT1sMhb/AqYmqxD5KOm
         irgA==
X-Gm-Message-State: AAQBX9ev+1ri8LFxMNcbHk/cttVlI7PLz36jbotU2frHIFIRn4oC+ZWk
        Ad8zzJbawXJzb16wj1eygyAkIdbrgXcT6xw445uDx3PjiE2A
X-Google-Smtp-Source: AKy350aQpy7LmHkX25TQItyrllevYSOkpnrGATU0KYX8z+pBI37JoSpVyiOL7HDqHPER/bQraSij19oH8DEO5YVadTcKjm/ZyXqj
MIME-Version: 1.0
X-Received: by 2002:a6b:7e4b:0:b0:745:70d7:4962 with SMTP id
 k11-20020a6b7e4b000000b0074570d74962mr7687052ioq.0.1682453202331; Tue, 25 Apr
 2023 13:06:42 -0700 (PDT)
Date:   Tue, 25 Apr 2023 13:06:42 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000079eebe05fa2ea9ad@google.com>
Subject: [syzbot] upstream boot error: BUG: unable to handle kernel NULL
 pointer dereference in __dabt_svc
From:   syzbot <syzbot+d692037148a8169fc9dd@syzkaller.appspotmail.com>
To:     alex.gaynor@gmail.com, andriy.shevchenko@linux.intel.com,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com,
        bpf@vger.kernel.org, gary@garyguo.net,
        linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk,
        ojeda@kernel.org, pmladek@suse.com, rostedt@goodmis.org,
        rust-for-linux@vger.kernel.org, senozhatsky@chromium.org,
        syzkaller-bugs@googlegroups.com, wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    de10553fce40 Merge tag 'x86-apic-2023-04-24' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14bdae68280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=975b8311f6b96bca
dashboard link: https://syzkaller.appspot.com/bug?extid=d692037148a8169fc9dd
compiler:       arm-linux-gnueabi-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d692037148a8169fc9dd@syzkaller.appspotmail.com

8<--- cut here ---
Unable to handle kernel NULL pointer dereference at virtual address 000005fc when read
[000005fc] *pgd=80000080004003, *pmd=00000000
Internal error: Oops: 206 [#1] PREEMPT SMP ARM
Modules linked in:
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.3.0-syzkaller #0
Hardware name: ARM-Versatile Express
Insufficient stack space to handle exception!
Task stack:     [0xdf85c000..0xdf85e000]
IRQ stack:      [0xdf804000..0xdf806000]
Overflow stack: [0x828ae000..0x828af000]
Internal error: kernel stack overflow: 0 [#2] PREEMPT SMP ARM
Modules linked in:
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.3.0-syzkaller #0
Hardware name: ARM-Versatile Express
PC is at __dabt_svc+0x14/0x60 arch/arm/kernel/entry-armv.S:210
LR is at vsnprintf+0x378/0x408 lib/vsprintf.c:2862
pc : [<80200a74>]    lr : [<817ad5d8>]    psr: 00000193
sp : df804028  ip : df805868  fp : df805864
r10: 00000060  r9 : ffffffff  r8 : 00000010
r7 : 00000020  r6 : 00000004  r5 : ffffffff  r4 : df805960
r3 : ffffffff  r2 : 00000040  r1 : ffffffff  r0 : 8264d250
Flags: nzcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 30c5387d  Table: 80003000  DAC: 00000000
Register r0 information:
8<--- cut here ---
Unable to handle kernel NULL pointer dereference at virtual address 000001ff when read
[000001ff] *pgd=80000080004003, *pmd=00000000
Internal error: Oops: 206 [#3] PREEMPT SMP ARM
Modules linked in:
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.3.0-syzkaller #0
Hardware name: ARM-Versatile Express
PC is at __find_vmap_area mm/vmalloc.c:841 [inline]
PC is at find_vmap_area mm/vmalloc.c:1862 [inline]
PC is at find_vm_area mm/vmalloc.c:2571 [inline]
PC is at vmalloc_dump_obj+0x38/0xb4 mm/vmalloc.c:4108
LR is at __raw_spin_lock include/linux/spinlock_api_smp.h:132 [inline]
LR is at _raw_spin_lock+0x18/0x58 kernel/locking/spinlock.c:154
pc : [<8046b2f0>]    lr : [<817db0f4>]    psr: 20000193
sp : 828aeef8  ip : 828aeee0  fp : 828aef0c
r10: 828f3980  r9 : 8241c964  r8 : 8264d41c
r7 : 60000193  r6 : 00000001  r5 : 8264e000  r4 : 00000207
r3 : 80216bd4  r2 : 00001d4c  r1 : 00000000  r0 : 00000001
Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 30c5387d  Table: 80003000  DAC: 00000000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
