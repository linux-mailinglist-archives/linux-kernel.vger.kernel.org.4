Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9820A5EE313
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 19:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234353AbiI1R1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 13:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234075AbiI1R04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 13:26:56 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59292F2774
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 10:26:49 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id g1-20020a92cda1000000b002f612391d5bso10190299ild.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 10:26:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=1WpfxtMPemdXU0XUFPB+4hPuLUMXFFSkhL1O/jeF1Dk=;
        b=n0NjLWX4C9H9tSbBJ2Lhw5Kdb481yv7EuYWXxM/L7zybhpnUthCFvXCsUoDpCGOCmP
         BjyfVqF30mDPb9DQKnMwyIXmxGGq2QW2ZVejU9c5KG/im4OyyxisdVrpVx/66lfugb7i
         k/rBZKTh+4nLj3x1wn1/1MZKYyneQEsYHOKNwlUY8LKObPoo8nFkNmDU8YQMGQv5Ui8o
         qKhqUuuvcT1xNwILleI4cNsmUhNUfSrAQ7x3HKvSn5BIAqEZhm7xrU2ytVanZU70tI4O
         fBUoK3fJy3EHhMo+fEOm+HC4ZrxWSt+y31Ap7+luFXkD6QBkV8F7IAypj/2rZiZkQG59
         QBYg==
X-Gm-Message-State: ACrzQf2meN7D5eZ7fIkLfK0Cp9mGQZtLC8GY6zySkgzf0QCIIiUErWGt
        BKRNZvhcCmffg56EXm6+80HNyswItOlunTOqJRtfJWNnHgDN
X-Google-Smtp-Source: AMsMyM4EOqBGeCEXrI1ebhLwLgLTLHHAhELKBkMSVg0vW+hno13KjXDw/TOP95XWU1gb81vzxaxfmndQ8tcT2tcYTgMPgLAbfVmh
MIME-Version: 1.0
X-Received: by 2002:a05:6638:22c5:b0:35a:88fa:3d3a with SMTP id
 j5-20020a05663822c500b0035a88fa3d3amr18195534jat.115.1664386008476; Wed, 28
 Sep 2022 10:26:48 -0700 (PDT)
Date:   Wed, 28 Sep 2022 10:26:48 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cdf4e105e9c0108f@google.com>
Subject: [syzbot] WARNING: locking bug in nilfs_find_or_create_root
From:   syzbot <syzbot+79cb3895126af21042fa@syzkaller.appspotmail.com>
To:     konishi.ryusuke@gmail.com, linux-kernel@vger.kernel.org,
        linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    c194837ebb57 Merge branch 'for-next/core', remote-tracking..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1135c4ff080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=15a770deac0c935a
dashboard link: https://syzkaller.appspot.com/bug?extid=79cb3895126af21042fa
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1649fcdf080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10f24cff080000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8d8ae425e7fa/disk-c194837e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c540d501ebe7/vmlinux-c194837e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+79cb3895126af21042fa@syzkaller.appspotmail.com

NILFS (loop0): broken superblock, retrying with spare superblock (blocksize = 1024)
------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(1)
WARNING: CPU: 0 PID: 3052 at kernel/locking/lockdep.c:231 check_wait_context kernel/locking/lockdep.c:4727 [inline]
WARNING: CPU: 0 PID: 3052 at kernel/locking/lockdep.c:231 __lock_acquire+0x2b0/0x30a4 kernel/locking/lockdep.c:5003
Modules linked in:
CPU: 0 PID: 3052 Comm: syz-executor334 Not tainted 6.0.0-rc6-syzkaller-17742-gc194837ebb57 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : check_wait_context kernel/locking/lockdep.c:4727 [inline]
pc : __lock_acquire+0x2b0/0x30a4 kernel/locking/lockdep.c:5003
lr : hlock_class kernel/locking/lockdep.c:231 [inline]
lr : check_wait_context kernel/locking/lockdep.c:4727 [inline]
lr : __lock_acquire+0x298/0x30a4 kernel/locking/lockdep.c:5003
sp : ffff800012763850
x29: ffff800012763930 x28: 0000000000000001 x27: ffff0000c70a3528
x26: ffff0000cb0b4300 x25: ffff0000c70a3f58 x24: 0000000000000000
x23: 0000000000000000 x22: 0000000000000001 x21: 0000000000000000
x20: 0000000000000000 x19: 5555560001430f3e x18: 00000000000000c0
x17: ffff80000dd0b198 x16: ffff80000db49158 x15: ffff0000c70a3500
x14: 0000000000000000 x13: 0000000000000012 x12: ffff80000d5ef920
x11: ff808000081c1630 x10: ffff80000dd0b198 x9 : 4ab275c465431000
x8 : 0000000000000000 x7 : 4e5241575f534b43 x6 : ffff800008195d30
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000100000001 x0 : 0000000000000016
Call trace:
 check_wait_context kernel/locking/lockdep.c:4727 [inline]
 __lock_acquire+0x2b0/0x30a4 kernel/locking/lockdep.c:5003
 lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5666
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x54/0x6c kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:349 [inline]
 nilfs_lookup_root fs/nilfs2/the_nilfs.c:716 [inline]
 nilfs_find_or_create_root+0x34/0x310 fs/nilfs2/the_nilfs.c:743
 nilfs_attach_checkpoint+0x64/0x1c8 fs/nilfs2/super.c:519
 nilfs_fill_super+0x154/0x2f8 fs/nilfs2/super.c:1064
 nilfs_mount+0x370/0x52c fs/nilfs2/super.c:1317
 legacy_get_tree+0x30/0x74 fs/fs_context.c:610
 vfs_get_tree+0x40/0x140 fs/super.c:1530
 do_new_mount+0x1dc/0x4e4 fs/namespace.c:3040
 path_mount+0x358/0x914 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __arm64_sys_mount+0x2c4/0x3c4 fs/namespace.c:3568
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
 el0t_64_sync+0x18c/0x190
irq event stamp: 2725
hardirqs last  enabled at (2725): [<ffff800008162680>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1367 [inline]
hardirqs last  enabled at (2725): [<ffff800008162680>] finish_lock_switch+0x94/0xe8 kernel/sched/core.c:4942
hardirqs last disabled at (2724): [<ffff80000bfc3cdc>] __schedule+0x84/0x5a0 kernel/sched/core.c:6393
softirqs last  enabled at (2540): [<ffff8000080102e4>] _stext+0x2e4/0x37c
softirqs last disabled at (2523): [<ffff800008017c14>] ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:79
---[ end trace 0000000000000000 ]---
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
user pgtable: 4k pages, 48-bit VAs, pgdp=0000000107187000
[00000000000000b8] pgd=08000001097ad003, p4d=08000001097ad003, pud=080000010b0a7003, pmd=0000000000000000
Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 3052 Comm: syz-executor334 Tainted: G        W          6.0.0-rc6-syzkaller-17742-gc194837ebb57 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : check_wait_context kernel/locking/lockdep.c:4727 [inline]
pc : __lock_acquire+0x2d0/0x30a4 kernel/locking/lockdep.c:5003
lr : hlock_class kernel/locking/lockdep.c:231 [inline]
lr : check_wait_context kernel/locking/lockdep.c:4727 [inline]
lr : __lock_acquire+0x298/0x30a4 kernel/locking/lockdep.c:5003
sp : ffff800012763850
x29: ffff800012763930 x28: 0000000000000001 x27: ffff0000c70a3528
x26: ffff0000cb0b4300 x25: ffff0000c70a3f58 x24: 0000000000000000
x23: 0000000000000000 x22: 0000000000000001 x21: 0000000000000000
x20: 0000000000000000 x19: 5555560001430f3e x18: 00000000000000c0
x17: ffff80000dd0b198 x16: ffff80000db49158 x15: ffff0000c70a3500
x14: 0000000000000000 x13: 0000000000000012 x12: ffff80000d5ef920
x11: ff808000081c1630 x10: ffff80000dd0b198 x9 : 0000000000040f3e
x8 : 0000000000000000 x7 : 4e5241575f534b43 x6 : ffff800008195d30
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000100000001 x0 : 0000000000000016
Call trace:
 hlock_class kernel/locking/lockdep.c:222 [inline]
 check_wait_context kernel/locking/lockdep.c:4728 [inline]
 __lock_acquire+0x2d0/0x30a4 kernel/locking/lockdep.c:5003
 lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5666
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x54/0x6c kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:349 [inline]
 nilfs_lookup_root fs/nilfs2/the_nilfs.c:716 [inline]
 nilfs_find_or_create_root+0x34/0x310 fs/nilfs2/the_nilfs.c:743
 nilfs_attach_checkpoint+0x64/0x1c8 fs/nilfs2/super.c:519
 nilfs_fill_super+0x154/0x2f8 fs/nilfs2/super.c:1064
 nilfs_mount+0x370/0x52c fs/nilfs2/super.c:1317
 legacy_get_tree+0x30/0x74 fs/fs_context.c:610
 vfs_get_tree+0x40/0x140 fs/super.c:1530
 do_new_mount+0x1dc/0x4e4 fs/namespace.c:3040
 path_mount+0x358/0x914 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __arm64_sys_mount+0x2c4/0x3c4 fs/namespace.c:3568
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
 el0t_64_sync+0x18c/0x190
Code: 9002db8a 91056210 9106614a b9400329 (3942e114) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	9002db8a 	adrp	x10, 0x5b70000
   4:	91056210 	add	x16, x16, #0x158
   8:	9106614a 	add	x10, x10, #0x198
   c:	b9400329 	ldr	w9, [x25]
* 10:	3942e114 	ldrb	w20, [x8, #184] <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
