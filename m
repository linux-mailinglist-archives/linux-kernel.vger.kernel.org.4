Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF81626EDE
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 11:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235244AbiKMKJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 05:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiKMKJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 05:09:22 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702135FD7
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 02:09:21 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id 13-20020a056e0216cd00b003023e8b7d03so4359915ilx.7
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 02:09:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X+LHHEzurjh08M3to0NZu+eL0d7c7yneTqvdpDbSVDo=;
        b=x0G4MpxUOLw6zCmCT7kod6wzwdpJ+a2rAy7idibOqsZ3wVpMB/I8k9QsTtN4jy9sY8
         fRJPny+MiyfEXfg8Xiu52/4878IkN1JDXLZluD/54LDL+pKg61BMTVMOssfya1bny6lW
         N1pLG2GilXtElkUWl/Mi6EYqOBpi42ALjPLjiSUBG19qI+445zqgrEqayTO0Z9sK5Q+9
         QkS1pmfBxuf4VAaUeWiqtVFVLJ921dsH91+/YxgDndf4CmeyUNE6WEcGp5wABHCOCs1V
         zNrBKOGWdqoAAgGryn5HiWBzqleyltd+n+CvCnllvBCfNQuGAsfEVG58CXHe1Gl1A0W8
         dk5g==
X-Gm-Message-State: ANoB5plKtWt/t4PTVGwWS7w/zPth+pu+EHpIFBqMKpgQ4MSllGGXfw0o
        PhejHIeW13FGMu6Rm0m+OdRKa6apXhOmQy8nH6MqTfEYl9G4
X-Google-Smtp-Source: AA0mqf4/30kHPyc1WmV10oXX+lDGnicuNgAH67YQTXLQPAPapaioE85P3DA/cUno2DrJwA+z9Rj805f4Fbt12f+69tsjnXtow9cB
MIME-Version: 1.0
X-Received: by 2002:a92:c14e:0:b0:2ff:f996:8695 with SMTP id
 b14-20020a92c14e000000b002fff9968695mr4321923ilh.172.1668334160791; Sun, 13
 Nov 2022 02:09:20 -0800 (PST)
Date:   Sun, 13 Nov 2022 02:09:20 -0800
In-Reply-To: <20221113055842.1710-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000054d5405ed57514d@google.com>
Subject: Re: [syzbot] WARNING: locking bug in hugetlb_no_page
From:   syzbot <syzbot+d07c65298d2c15eafcb0@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING: locking bug in hugetlb_no_page

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(1)
WARNING: CPU: 1 PID: 3786 at kernel/locking/lockdep.c:231 check_wait_context kernel/locking/lockdep.c:4729 [inline]
WARNING: CPU: 1 PID: 3786 at kernel/locking/lockdep.c:231 __lock_acquire+0x2b0/0x3084 kernel/locking/lockdep.c:5005
Modules linked in:
CPU: 1 PID: 3786 Comm: syz-executor.1 Not tainted 6.1.0-rc4-syzkaller-00039-g1621b6eaebf7-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : check_wait_context kernel/locking/lockdep.c:4729 [inline]
pc : __lock_acquire+0x2b0/0x3084 kernel/locking/lockdep.c:5005
lr : hlock_class kernel/locking/lockdep.c:231 [inline]
lr : check_wait_context kernel/locking/lockdep.c:4729 [inline]
lr : __lock_acquire+0x298/0x3084 kernel/locking/lockdep.c:5005
sp : ffff80001301b3e0
x29: ffff80001301b4c0 x28: 0000000000000001 x27: ffff0000cfbbb4a8
x26: ffff0000d342ea78 x25: ffff0000cfbbbeb0 x24: 0000000000000000
x23: 0000000000000000
 x22: 0000000000000001 x21: 0000000000000000
x20: 0000000000000001 x19: aaaaaa0001076c5e
 x18: 00000000000000c0
x17: ffff80000dcdc198 x16: ffff80000db1a158 x15: ffff0000cfbbb480
x14: 0000000000000000 x13: 0000000000000012 x12: ffff80000d86ff30
x11: ff808000081c06c8
 x10: ffff80000dcdc198
 x9 : 3a226953cce2cb00

x8 : 0000000000000000 x7 : 4e5241575f534b43
 x6 : ffff80000c01775c
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000

x2 : 0000000000000000
 x1 : 0000000100000000
 x0 : 0000000000000016
Call trace:
 check_wait_context kernel/locking/lockdep.c:4729 [inline]
 __lock_acquire+0x2b0/0x3084 kernel/locking/lockdep.c:5005
 reacquire_held_locks+0x120/0x1c0 kernel/locking/lockdep.c:5193
 __lock_release kernel/locking/lockdep.c:5382 [inline]
 lock_release+0x148/0x2b4 kernel/locking/lockdep.c:5688
 __mutex_unlock_slowpath+0x44/0x1cc kernel/locking/mutex.c:907
 mutex_unlock+0x24/0x30 kernel/locking/mutex.c:543
 hugetlb_no_page+0x284/0xe1c mm/hugetlb.c:5779
 hugetlb_fault+0x3a0/0xdfc mm/hugetlb.c:5882
 handle_mm_fault+0x904/0xa48 mm/memory.c:5216
 __do_page_fault arch/arm64/mm/fault.c:506 [inline]
 do_page_fault+0x428/0x79c arch/arm64/mm/fault.c:606
 do_translation_fault+0x78/0x194 arch/arm64/mm/fault.c:689
 do_mem_abort+0x54/0x130 arch/arm64/mm/fault.c:825
 el1_abort+0x3c/0x5c arch/arm64/kernel/entry-common.c:367
 el1h_64_sync_handler+0x60/0xac arch/arm64/kernel/entry-common.c:427
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:579
 __arch_copy_from_user+0x24/0x1f4 arch/arm64/lib/copy_from_user.S:77
 __import_iovec+0x60/0x248 lib/iov_iter.c:1773
 import_iovec+0x6c/0x88 lib/iov_iter.c:1838
 vfs_writev fs/read_write.c:931 [inline]
 do_writev+0xf8/0x234 fs/read_write.c:977
 __do_sys_writev fs/read_write.c:1050 [inline]
 __se_sys_writev fs/read_write.c:1047 [inline]
 __arm64_sys_writev+0x28/0x38 fs/read_write.c:1047
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584
irq event stamp: 41
hardirqs last  enabled at (41): [<ffff80000c01c86c>] __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:159 [inline]
hardirqs last  enabled at (41): [<ffff80000c01c86c>] _raw_spin_unlock_irq+0x3c/0x70 kernel/locking/spinlock.c:202
hardirqs last disabled at (40): [<ffff80000c01c66c>] __raw_spin_lock_irq include/linux/spinlock_api_smp.h:117 [inline]
hardirqs last disabled at (40): [<ffff80000c01c66c>] _raw_spin_lock_irq+0x34/0x9c kernel/locking/spinlock.c:170
softirqs last  enabled at (8): [<ffff80000801c38c>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (6): [<ffff80000801c358>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
BUG: sleeping function called from invalid context at arch/arm64/mm/fault.c:597
in_atomic(): 0, irqs_disabled(): 128, non_block: 0, pid: 3786, name: syz-executor.1
preempt_count: 0, expected: 0
RCU nest depth: 0, expected: 0
INFO: lockdep is turned off.
irq event stamp: 41
hardirqs last  enabled at (41): [<ffff80000c01c86c>] __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:159 [inline]
hardirqs last  enabled at (41): [<ffff80000c01c86c>] _raw_spin_unlock_irq+0x3c/0x70 kernel/locking/spinlock.c:202
hardirqs last disabled at (40): [<ffff80000c01c66c>] __raw_spin_lock_irq include/linux/spinlock_api_smp.h:117 [inline]
hardirqs last disabled at (40): [<ffff80000c01c66c>] _raw_spin_lock_irq+0x34/0x9c kernel/locking/spinlock.c:170
softirqs last  enabled at (8): [<ffff80000801c38c>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (6): [<ffff80000801c358>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
CPU: 1 PID: 3786 Comm: syz-executor.1 Tainted: G        W          6.1.0-rc4-syzkaller-00039-g1621b6eaebf7-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
Call trace:
 dump_backtrace+0x1c4/0x1f0 arch/arm64/kernel/stacktrace.c:156
 show_stack+0x2c/0x54 arch/arm64/kernel/stacktrace.c:163
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x104/0x16c lib/dump_stack.c:106
 dump_stack+0x1c/0x58 lib/dump_stack.c:113
 __might_resched+0x208/0x218 kernel/sched/core.c:9890
 __might_sleep+0x48/0x78 kernel/sched/core.c:9819
 do_page_fault+0x214/0x79c arch/arm64/mm/fault.c:597
 do_translation_fault+0x78/0x194 arch/arm64/mm/fault.c:689
 do_mem_abort+0x54/0x130 arch/arm64/mm/fault.c:825
 el1_abort+0x3c/0x5c arch/arm64/kernel/entry-common.c:367
 el1h_64_sync_handler+0x60/0xac arch/arm64/kernel/entry-common.c:427
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:579
 hlock_class kernel/locking/lockdep.c:222 [inline]
 check_wait_context kernel/locking/lockdep.c:4730 [inline]
 __lock_acquire+0x2d0/0x3084 kernel/locking/lockdep.c:5005
 reacquire_held_locks+0x120/0x1c0 kernel/locking/lockdep.c:5193
 __lock_release kernel/locking/lockdep.c:5382 [inline]
 lock_release+0x148/0x2b4 kernel/locking/lockdep.c:5688
 __mutex_unlock_slowpath+0x44/0x1cc kernel/locking/mutex.c:907
 mutex_unlock+0x24/0x30 kernel/locking/mutex.c:543
 hugetlb_no_page+0x284/0xe1c mm/hugetlb.c:5779
 hugetlb_fault+0x3a0/0xdfc mm/hugetlb.c:5882
 handle_mm_fault+0x904/0xa48 mm/memory.c:5216
 __do_page_fault arch/arm64/mm/fault.c:506 [inline]
 do_page_fault+0x428/0x79c arch/arm64/mm/fault.c:606
 do_translation_fault+0x78/0x194 arch/arm64/mm/fault.c:689
 do_mem_abort+0x54/0x130 arch/arm64/mm/fault.c:825
 el1_abort+0x3c/0x5c arch/arm64/kernel/entry-common.c:367
 el1h_64_sync_handler+0x60/0xac arch/arm64/kernel/entry-common.c:427
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:579
 __arch_copy_from_user+0x24/0x1f4 arch/arm64/lib/copy_from_user.S:77
 __import_iovec+0x60/0x248 lib/iov_iter.c:1773
 import_iovec+0x6c/0x88 lib/iov_iter.c:1838
 vfs_writev fs/read_write.c:931 [inline]
 do_writev+0xf8/0x234 fs/read_write.c:977
 __do_sys_writev fs/read_write.c:1050 [inline]
 __se_sys_writev fs/read_write.c:1047 [inline]
 __arm64_sys_writev+0x28/0x38 fs/read_write.c:1047
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584
Unable to handle kernel NULL pointer dereference at virtual address 00000000000000b8
Mem abort info:
  ESR = 0x0000000096000006
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x06: level 2 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000006
  CM = 0, WnR = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=000000011345f000
[00000000000000b8] pgd=080000011347a003, p4d=080000011347a003, pud=080000011347e003, pmd=0000000000000000
Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 3786 Comm: syz-executor.1 Tainted: G        W          6.1.0-rc4-syzkaller-00039-g1621b6eaebf7-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : check_wait_context kernel/locking/lockdep.c:4729 [inline]
pc : __lock_acquire+0x2d0/0x3084 kernel/locking/lockdep.c:5005
lr : hlock_class kernel/locking/lockdep.c:231 [inline]
lr : check_wait_context kernel/locking/lockdep.c:4729 [inline]
lr : __lock_acquire+0x298/0x3084 kernel/locking/lockdep.c:5005
sp : ffff80001301b3e0
x29: ffff80001301b4c0 x28: 0000000000000001 x27: ffff0000cfbbb4a8
x26: ffff0000d342ea78 x25: ffff0000cfbbbeb0 x24: 0000000000000000
x23: 0000000000000000 x22: 0000000000000001 x21: 0000000000000000
x20: 0000000000000001 x19: aaaaaa0001076c5e x18: 00000000000000c0
x17: ffff80000dcdc198 x16: ffff80000db1a158 x15: ffff0000cfbbb480
x14: 0000000000000000 x13: 0000000000000012 x12: ffff80000d86ff30
x11: ff808000081c06c8 x10: ffff80000dcdc198 x9 : 0000000000050c5e
x8 : 0000000000000000 x7 : 4e5241575f534b43 x6 : ffff80000c01775c
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000100000000 x0 : 0000000000000016
Call trace:
 hlock_class kernel/locking/lockdep.c:222 [inline]
 check_wait_context kernel/locking/lockdep.c:4730 [inline]
 __lock_acquire+0x2d0/0x3084 kernel/locking/lockdep.c:5005
 reacquire_held_locks+0x120/0x1c0 kernel/locking/lockdep.c:5193
 __lock_release kernel/locking/lockdep.c:5382 [inline]
 lock_release+0x148/0x2b4 kernel/locking/lockdep.c:5688
 __mutex_unlock_slowpath+0x44/0x1cc kernel/locking/mutex.c:907
 mutex_unlock+0x24/0x30 kernel/locking/mutex.c:543
 hugetlb_no_page+0x284/0xe1c mm/hugetlb.c:5779
 hugetlb_fault+0x3a0/0xdfc mm/hugetlb.c:5882
 handle_mm_fault+0x904/0xa48 mm/memory.c:5216
 __do_page_fault arch/arm64/mm/fault.c:506 [inline]
 do_page_fault+0x428/0x79c arch/arm64/mm/fault.c:606
 do_translation_fault+0x78/0x194 arch/arm64/mm/fault.c:689
 do_mem_abort+0x54/0x130 arch/arm64/mm/fault.c:825
 el1_abort+0x3c/0x5c arch/arm64/kernel/entry-common.c:367
 el1h_64_sync_handler+0x60/0xac arch/arm64/kernel/entry-common.c:427
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:579
 __arch_copy_from_user+0x24/0x1f4 arch/arm64/lib/copy_from_user.S:77
 __import_iovec+0x60/0x248 lib/iov_iter.c:1773
 import_iovec+0x6c/0x88 lib/iov_iter.c:1838
 vfs_writev fs/read_write.c:931 [inline]
 do_writev+0xf8/0x234 fs/read_write.c:977
 __do_sys_writev fs/read_write.c:1050 [inline]
 __se_sys_writev fs/read_write.c:1047 [inline]
 __arm64_sys_writev+0x28/0x38 fs/read_write.c:1047
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584
Code: d002da0a 91056210 9106614a b9400329 (3942e114) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	d002da0a 	adrp	x10, 0x5b42000
   4:	91056210 	add	x16, x16, #0x158
   8:	9106614a 	add	x10, x10, #0x198
   c:	b9400329 	ldr	w9, [x25]
* 10:	3942e114 	ldrb	w20, [x8, #184] <-- trapping instruction


Tested on:

commit:         1621b6ea Merge branch 'for-next/fixes' into for-kernelci
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15b39c85880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=606e57fd25c5c6cc
dashboard link: https://syzkaller.appspot.com/bug?extid=d07c65298d2c15eafcb0
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14fbe185880000

