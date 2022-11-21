Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B90632901
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 17:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiKUQJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 11:09:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiKUQIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 11:08:51 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514BBC5B5E
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 08:08:50 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id j20-20020a056e02219400b00300a22a7fe0so8869979ila.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 08:08:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sGxC+usgv6yhaYnFxXwjDdn0RrDa3glghs/ovAtSB9g=;
        b=nUJqAKtSsY5mU0QmVFUwaUxdYHQVdBG3Hx+Gq5TXi6G8o5kdNGhAiIcp2cbTETpIA2
         9JXkhatdj6W/LHJ+PUdx0ccw4JXUQkMfcbzgeVNWs52uwj0rIxr8iPYqRqS0WnDgZCLt
         NahBjPuUbJP2bpKySGFOq5ESOHds+2rkltaPznbOOfDNHIj947ekp+MnCdQQRGqedoXO
         JV71UPiRI7XG/9AqWaTXTPwECawqauz1e8WofS8O1lsF8brxqhj9pRn28LHXzw8H55IP
         eil13fPsDAqYCMsEnM1oKabnLXThnBn8qBWNuBMm1PxtX8hqqra58CtZEYnwvoJUP26s
         8Egw==
X-Gm-Message-State: ANoB5plpKMHYbmTQYzF3LJ83Y8n8/vtkQj6ddIZGAVoZOBH4+q34DI7T
        J0GZNb5chmO9TM6a9PErt2S/4C/gZ2j4q6k6VeaEhdZWqCL+
X-Google-Smtp-Source: AA0mqf70BOA7Lv3gZLuaNYLcF2q/pv/fvXJAuVjgSJKrqz3GpgF3Ws8bc/fgOVjymiHhg3b1Dzqr/+kRsKgolZXMrnN/TMz3j9K2
MIME-Version: 1.0
X-Received: by 2002:a92:cc50:0:b0:302:ad5b:a728 with SMTP id
 t16-20020a92cc50000000b00302ad5ba728mr304996ilq.110.1669046929695; Mon, 21
 Nov 2022 08:08:49 -0800 (PST)
Date:   Mon, 21 Nov 2022 08:08:49 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005bab1105edfd4565@google.com>
Subject: [syzbot] WARNING in kfree_rcu_work
From:   syzbot <syzbot+f6ec2d932b89616d83c7@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    9500fc6e9e60 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=121adaf9880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b25c9f218686dd5e
dashboard link: https://syzkaller.appspot.com/bug?extid=f6ec2d932b89616d83c7
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1538c909880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16e5ce19880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1363e60652f7/disk-9500fc6e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fcc4da811bb6/vmlinux-9500fc6e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0b554298f1fa/Image-9500fc6e.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f6ec2d932b89616d83c7@syzkaller.appspotmail.com

------------[ cut here ]------------
ODEBUG: active_state not available (active state 0) object type: rcu_head hint: 0x0
WARNING: CPU: 1 PID: 21 at lib/debugobjects.c:505 debug_print_object lib/debugobjects.c:502 [inline]
WARNING: CPU: 1 PID: 21 at lib/debugobjects.c:505 debug_object_active_state+0x174/0x1dc lib/debugobjects.c:948
Modules linked in:
CPU: 1 PID: 21 Comm: kworker/1:0 Not tainted 6.1.0-rc5-syzkaller-32269-g9500fc6e9e60 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
Workqueue: events kfree_rcu_work
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : debug_print_object lib/debugobjects.c:502 [inline]
pc : debug_object_active_state+0x174/0x1dc lib/debugobjects.c:948
lr : debug_print_object lib/debugobjects.c:502 [inline]
lr : debug_object_active_state+0x174/0x1dc lib/debugobjects.c:948
sp : ffff80000f33bcc0
x29: ffff80000f33bcc0 x28: 0000000000000150 x27: 0000000000000000
x26: 0000000000000000 x25: ffff0001fefde3e8 x24: 0000000000000000
x23: 0000000000000001 x22: 0000000000000000 x21: ffff80000f175000
x20: ffff0000cc581000 x19: ffff80000c0eec40 x18: 0000000000000225
x17: ffff80000c0ed83c x16: ffff80000dc18158 x15: ffff0000c0331a40
x14: 0000000000000000 x13: 00000000ffffffff x12: ffff0000c0331a40
x11: ff808000081c6510 x10: 0000000000000000 x9 : e93e9ee3facb8300
x8 : e93e9ee3facb8300 x7 : ffff800008165f54 x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000006 x1 : 0000000100000000 x0 : 0000000000000053
Call trace:
 debug_print_object lib/debugobjects.c:502 [inline]
 debug_object_active_state+0x174/0x1dc lib/debugobjects.c:948
 debug_rcu_head_unqueue kernel/rcu/rcu.h:198 [inline]
 debug_rcu_bhead_unqueue kernel/rcu/tree.c:2933 [inline]
 kfree_rcu_work+0xa8/0x31c kernel/rcu/tree.c:3032
 process_one_work+0x2d8/0x504 kernel/workqueue.c:2289
 worker_thread+0x340/0x610 kernel/workqueue.c:2436
 kthread+0x12c/0x158 kernel/kthread.c:376
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:863
irq event stamp: 109630
hardirqs last  enabled at (109629): [<ffff800008165fe4>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1366 [inline]
hardirqs last  enabled at (109629): [<ffff800008165fe4>] finish_lock_switch+0x94/0xe8 kernel/sched/core.c:4950
hardirqs last disabled at (109630): [<ffff80000c0a4f34>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:405
softirqs last  enabled at (97456): [<ffff8000080102e4>] _stext+0x2e4/0x37c
softirqs last disabled at (96913): [<ffff800008017c88>] ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:79
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
ODEBUG: deactivate not available (active state 0) object type: rcu_head hint: 0x0
WARNING: CPU: 1 PID: 21 at lib/debugobjects.c:505 debug_print_object lib/debugobjects.c:502 [inline]
WARNING: CPU: 1 PID: 21 at lib/debugobjects.c:505 debug_object_deactivate+0x128/0x1dc lib/debugobjects.c:760
Modules linked in:
CPU: 1 PID: 21 Comm: kworker/1:0 Tainted: G        W          6.1.0-rc5-syzkaller-32269-g9500fc6e9e60 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
Workqueue: events kfree_rcu_work
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : debug_print_object lib/debugobjects.c:502 [inline]
pc : debug_object_deactivate+0x128/0x1dc lib/debugobjects.c:760
lr : debug_print_object lib/debugobjects.c:502 [inline]
lr : debug_object_deactivate+0x128/0x1dc lib/debugobjects.c:760
sp : ffff80000f33bcd0
x29: ffff80000f33bcd0 x28: 0000000000000150 x27: 0000000000000000
x26: 0000000000000000 x25: ffff0001fefde3e8 x24: 0000000000000000
x23: ffff0000cc581000 x22: 0000000000000000 x21: ffff80000f175000
x20: ffff0000cc581000 x19: ffff80000c0eec40 x18: 0000000000000313
x17: 72203a6570797420 x16: ffff80000dc18158 x15: ffff0000c0331a40
x14: 0000000000000000 x13: 00000000ffffffff x12: ffff0000c0331a40
x11: ff808000081c6510 x10: 0000000000000000 x9 : e93e9ee3facb8300
x8 : e93e9ee3facb8300 x7 : ffff800008165f54 x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000006 x1 : 0000000100000000 x0 : 0000000000000051
Call trace:
 debug_print_object lib/debugobjects.c:502 [inline]
 debug_object_deactivate+0x128/0x1dc lib/debugobjects.c:760
 debug_rcu_head_unqueue kernel/rcu/rcu.h:201 [inline]
 debug_rcu_bhead_unqueue kernel/rcu/tree.c:2933 [inline]
 kfree_rcu_work+0xb4/0x31c kernel/rcu/tree.c:3032
 process_one_work+0x2d8/0x504 kernel/workqueue.c:2289
 worker_thread+0x340/0x610 kernel/workqueue.c:2436
 kthread+0x12c/0x158 kernel/kthread.c:376
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:863
irq event stamp: 109762
hardirqs last  enabled at (109761): [<ffff800008165fe4>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1366 [inline]
hardirqs last  enabled at (109761): [<ffff800008165fe4>] finish_lock_switch+0x94/0xe8 kernel/sched/core.c:4950
hardirqs last disabled at (109762): [<ffff80000c0a4f34>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:405
softirqs last  enabled at (109754): [<ffff8000080102e4>] _stext+0x2e4/0x37c
softirqs last disabled at (109737): [<ffff800008017c88>] ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:79
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
ODEBUG: active_state not available (active state 0) object type: rcu_head hint: 0x0
WARNING: CPU: 1 PID: 21 at lib/debugobjects.c:505 debug_print_object lib/debugobjects.c:502 [inline]
WARNING: CPU: 1 PID: 21 at lib/debugobjects.c:505 debug_object_active_state+0x174/0x1dc lib/debugobjects.c:948
Modules linked in:
CPU: 1 PID: 21 Comm: kworker/1:0 Tainted: G        W          6.1.0-rc5-syzkaller-32269-g9500fc6e9e60 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
Workqueue: events kfree_rcu_work

pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : debug_print_object lib/debugobjects.c:502 [inline]
pc : debug_object_active_state+0x174/0x1dc lib/debugobjects.c:948
lr : debug_print_object lib/debugobjects.c:502 [inline]
lr : debug_object_active_state+0x174/0x1dc lib/debugobjects.c:948
sp : ffff80000f33bcc0
x29: ffff80000f33bcc0
 x28: 0000000000000151
 x27: 0000000000000000

x26: 0000000000000000
 x25: ffff0001fefde3e8
 x24: 0000000000000000

x23: 0000000000000001
 x22: 0000000000000000
 x21: ffff80000f175000
x20: ffff0000cc581100
 x19: ffff80000c0eec40 x18: 0000000000000313
x17: 2020202020205720 x16: 2020202020202047 x15: 203a6465746e6961
x14: 5420353331726f74 x13: 205d383734335420 x12: 5b5d373438373031
x11: ff808000081c6510 x10: 0000000000000000 x9 : e93e9ee3facb8300
x8 : e93e9ee3facb8300 x7 : 205b5d3734383730 x6 : ffff8000081c880c
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : ffff0000c0331a40 x1 : 0000000100000000 x0 : 0000000000000053
Call trace:
 debug_print_object lib/debugobjects.c:502 [inline]
 debug_object_active_state+0x174/0x1dc lib/debugobjects.c:948
 debug_rcu_head_unqueue kernel/rcu/rcu.h:198 [inline]
 debug_rcu_bhead_unqueue kernel/rcu/tree.c:2933 [inline]
 kfree_rcu_work+0xa8/0x31c kernel/rcu/tree.c:3032
 process_one_work+0x2d8/0x504 kernel/workqueue.c:2289
 worker_thread+0x340/0x610 kernel/workqueue.c:2436
 kthread+0x12c/0x158 kernel/kthread.c:376
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:863
irq event stamp: 109762
hardirqs last  enabled at (109761): [<ffff800008165fe4>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1366 [inline]
hardirqs last  enabled at (109761): [<ffff800008165fe4>] finish_lock_switch+0x94/0xe8 kernel/sched/core.c:4950
hardirqs last disabled at (109762): [<ffff80000c0a4f34>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:405
softirqs last  enabled at (109754): [<ffff8000080102e4>] _stext+0x2e4/0x37c
softirqs last disabled at (109737): [<ffff800008017c88>] ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:79
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
ODEBUG: deactivate not available (active state 0) object type: rcu_head hint: 0x0
WARNING: CPU: 1 PID: 21 at lib/debugobjects.c:505 debug_print_object lib/debugobjects.c:502 [inline]
WARNING: CPU: 1 PID: 21 at lib/debugobjects.c:505 debug_object_deactivate+0x128/0x1dc lib/debugobjects.c:760
Modules linked in:
CPU: 1 PID: 21 Comm: kworker/1:0 Tainted: G        W          6.1.0-rc5-syzkaller-32269-g9500fc6e9e60 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
Workqueue: events kfree_rcu_work
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : debug_print_object lib/debugobjects.c:502 [inline]
pc : debug_object_deactivate+0x128/0x1dc lib/debugobjects.c:760
lr : debug_print_object lib/debugobjects.c:502 [inline]
lr : debug_object_deactivate+0x128/0x1dc lib/debugobjects.c:760
sp : ffff80000f33bcd0
x29: ffff80000f33bcd0 x28: 0000000000000151 x27: 0000000000000000
x26: 0000000000000000 x25: ffff0001fefde3e8 x24: 0000000000000000
x23: ffff0000cc581100 x22: 0000000000000000 x21: ffff80000f175000
x20: ffff0000cc581100 x19: ffff80000c0eec40 x18: 00000000000000ff
x17: 0000000000000000 x16: 0000000000000117 x15: 0000000000000018
x14: 0000000002d879f3 x13: 0000000000000120 x12: 0000000000000000
x11: ff808000081c6510 x10: 0000000000000000 x9 : e93e9ee3facb8300
x8 : e93e9ee3facb8300 x7 : 00000000000f4240 x6 : ffff800008165f54
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : ffff0000c0331a40 x1 : 0000000100000000 x0 : 0000000000000051
Call trace:
 debug_print_object lib/debugobjects.c:502 [inline]
 debug_object_deactivate+0x128/0x1dc lib/debugobjects.c:760
 debug_rcu_head_unqueue kernel/rcu/rcu.h:201 [inline]
 debug_rcu_bhead_unqueue kernel/rcu/tree.c:2933 [inline]
 kfree_rcu_work+0xb4/0x31c kernel/rcu/tree.c:3032
 process_one_work+0x2d8/0x504 kernel/workqueue.c:2289
 worker_thread+0x340/0x610 kernel/workqueue.c:2436
 kthread+0x12c/0x158 kernel/kthread.c:376
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:863
irq event stamp: 109762
hardirqs last  enabled at (109761): [<ffff800008165fe4>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1366 [inline]
hardirqs last  enabled at (109761): [<ffff800008165fe4>] finish_lock_switch+0x94/0xe8 kernel/sched/core.c:4950
hardirqs last disabled at (109762): [<ffff80000c0a4f34>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:405
softirqs last  enabled at (109754): [<ffff8000080102e4>] _stext+0x2e4/0x37c
softirqs last disabled at (109737): [<ffff800008017c88>] ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:79
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
ODEBUG: active_state not available (active state 0) object type: rcu_head hint: 0x0
WARNING: CPU: 1 PID: 21 at lib/debugobjects.c:505 debug_print_object lib/debugobjects.c:502 [inline]
WARNING: CPU: 1 PID: 21 at lib/debugobjects.c:505 debug_object_active_state+0x174/0x1dc lib/debugobjects.c:948
Modules linked in:
CPU: 1 PID: 21 Comm: kworker/1:0 Tainted: G        W          6.1.0-rc5-syzkaller-32269-g9500fc6e9e60 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
Workqueue: events kfree_rcu_work
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : debug_print_object lib/debugobjects.c:502 [inline]
pc : debug_object_active_state+0x174/0x1dc lib/debugobjects.c:948
lr : debug_print_object lib/debugobjects.c:502 [inline]
lr : debug_object_active_state+0x174/0x1dc lib/debugobjects.c:948
sp : ffff80000f33bcc0
x29: ffff80000f33bcc0 x28: 0000000000000152 x27: 0000000000000000
x26: 0000000000000000 x25: ffff0001fefde3e8 x24: 0000000000000000
x23: 0000000000000001 x22: 0000000000000000 x21: ffff80000f175000
x20: ffff0000cc581280 x19: ffff80000c0eec40 x18: 00000000000000ff
x17: 3a65707974207463 x16: 656a626f20293020 x15: 6574617473206576
x14: 697463612820656c x13: 205d313254202020 x12: 5b5d373733313732
x11: ff808000081c6510 x10: 0000000000000000 x9 : e93e9ee3facb8300
x8 : e93e9ee3facb8300 x7 : 205b5d3737333137 x6 : ffff80000c0b2b74
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000100000000 x0 : 0000000000000053
Call trace:
 debug_print_object lib/debugobjects.c:502 [inline]
 debug_object_active_state+0x174/0x1dc lib/debugobjects.c:948
 debug_rcu_head_unqueue kernel/rcu/rcu.h:198 [inline]
 debug_rcu_bhead_unqueue kernel/rcu/tree.c:2933 [inline]
 kfree_rcu_work+0xa8/0x31c kernel/rcu/tree.c:3032
 process_one_work+0x2d8/0x504 kernel/workqueue.c:2289
 worker_thread+0x340/0x610 kernel/workqueue.c:2436
 kthread+0x12c/0x158 kernel/kthread.c:376
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:863
irq event stamp: 109762
hardirqs last  enabled at (109761): [<ffff800008165fe4>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1366 [inline]
hardirqs last  enabled at (109761): [<ffff800008165fe4>] finish_lock_switch+0x94/0xe8 kernel/sched/core.c:4950
hardirqs last disabled at (109762): [<ffff80000c0a4f34>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:405
softirqs last  enabled at (109754): [<ffff8000080102e4>] _stext+0x2e4/0x37c
softirqs last disabled at (109737): [<ffff800008017c88>] ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:79
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
