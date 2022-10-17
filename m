Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67FC600820
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 09:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbiJQHxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 03:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiJQHxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 03:53:41 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4245B07F
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 00:53:39 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id m9-20020a056e021c2900b002fadb905ddcso8492170ilh.18
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 00:53:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wh91P2RPniSdLBfho/7Li/y6rllMI672uM2CJ+A/hVU=;
        b=yW52PVmCiH97qy0HY4OTx7rQ1wAMGKWxYE9Kg0AoTvHBFUEeFsgJ4xCbuVevi12+RP
         sRetrahSmGfackbwU7fGkTiNLPvLdwDag6fS023BVEJewu8EYxKj3OyXl508y5/iRhnW
         cnPf3zM6GY0ROMC0tqW7JR8v0OB9utRwUQ2bHw65UAhCZwdfa/gMZxJ8/FHhFflENTLM
         OghCdIkyWTSVuj6YE9M7StZbs9rgA8X89rm1lDPWdiIGu/EuMirCdAefqNTVIjULimKc
         L3YnfDqs5GhXSfrJPZlGVSNiWXwucfx7jpcfMm7MegfCe7IO8GYyLm+hoSviB24EkC5a
         md8g==
X-Gm-Message-State: ACrzQf2cuWGt2AsEqP7YWLp5YvfYl4/7OR04isrooufCaqAGdKhJ7tgk
        MejXqxj/sEWgWdJCd3duOWNWSz1y/RhqkRt1lZwb728wlE1Y
X-Google-Smtp-Source: AMsMyM5mtqVNcbKyPF8LlUX0hh4FpvdYIBwUPdwNRsqy6LOeSAjuNv+UwlWi9T4TZo1pPSfkcc0WMIWEe4hV4227hlQkxrg05Es3
MIME-Version: 1.0
X-Received: by 2002:a05:6638:240e:b0:363:dbde:4176 with SMTP id
 z14-20020a056638240e00b00363dbde4176mr4609403jat.243.1665993218884; Mon, 17
 Oct 2022 00:53:38 -0700 (PDT)
Date:   Mon, 17 Oct 2022 00:53:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000028a3c05eb364667@google.com>
Subject: [syzbot] BUG: spinlock bad magic in nilfs_palloc_destroy_cache
From:   syzbot <syzbot+5f89bb8d098de14e095a@syzkaller.appspotmail.com>
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

HEAD commit:    bbed346d5a96 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=14b7bfa4880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3a4a45d2d827c1e
dashboard link: https://syzkaller.appspot.com/bug?extid=5f89bb8d098de14e095a
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16dbead6880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=105d329a880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e8e91bc79312/disk-bbed346d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c1cb3fb3b77e/vmlinux-bbed346d.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/79de466a501c/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5f89bb8d098de14e095a@syzkaller.appspotmail.com

BUG: spinlock bad magic on CPU#1, syz-executor283/3079
 lock: lock_classes+0x4aac0/0x180000, .magic: ffff8000, .owner: /235063856, .owner_cpu: 242347152
CPU: 1 PID: 3079 Comm: syz-executor283 Not tainted 6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
Call trace:
 dump_backtrace+0x1c4/0x1f0 arch/arm64/kernel/stacktrace.c:156
 show_stack+0x2c/0x54 arch/arm64/kernel/stacktrace.c:163
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x104/0x16c lib/dump_stack.c:106
 dump_stack+0x1c/0x58 lib/dump_stack.c:113
 spin_dump kernel/locking/spinlock_debug.c:69 [inline]
 spin_bug+0xa8/0xec kernel/locking/spinlock_debug.c:77
 debug_spin_lock_before kernel/locking/spinlock_debug.c:85 [inline]
 do_raw_spin_lock+0xb0/0x110 kernel/locking/spinlock_debug.c:114
 __raw_spin_lock include/linux/spinlock_api_smp.h:134 [inline]
 _raw_spin_lock+0x5c/0x6c kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:349 [inline]
 nilfs_palloc_clear_cache fs/nilfs2/alloc.c:848 [inline]
 nilfs_palloc_destroy_cache+0x2c/0xb8 fs/nilfs2/alloc.c:860
 nilfs_mdt_clear+0x34/0x70 fs/nilfs2/mdt.c:478
 nilfs_clear_inode+0x64/0x140 fs/nilfs2/inode.c:886
 nilfs_evict_inode+0x68/0x1cc fs/nilfs2/inode.c:908
 evict+0xec/0x334 fs/inode.c:665
 iput_final fs/inode.c:1748 [inline]
 iput+0x2c4/0x324 fs/inode.c:1774
 nilfs_put_super+0x6c/0x9c fs/nilfs2/super.c:476
 generic_shutdown_super+0x8c/0x190 fs/super.c:491
 kill_block_super+0x30/0x78 fs/super.c:1427
 deactivate_locked_super+0x70/0xe8 fs/super.c:332
 deactivate_super+0xd0/0xd4 fs/super.c:363
 cleanup_mnt+0x1f8/0x234 fs/namespace.c:1186
 __cleanup_mnt+0x20/0x30 fs/namespace.c:1193
 task_work_run+0xc4/0x14c kernel/task_work.c:177
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 do_notify_resume+0x174/0x1f0 arch/arm64/kernel/signal.c:1127
 prepare_exit_to_user_mode arch/arm64/kernel/entry-common.c:137 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:142 [inline]
 el0_svc+0x9c/0x150 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
 el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581
Unable to handle kernel paging request at virtual address ffff80000d272a70
Mem abort info:
  ESR = 0x0000000096000047
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x07: level 3 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000047
  CM = 0, WnR = 1
swapper pgtable: 4k pages, 48-bit VAs, pgdp=00000001c566b000
[ffff80000d272a70] pgd=100000023ffff003, p4d=100000023ffff003, pud=100000023fffe003, pmd=100000023fffa003, pte=0000000000000000
Internal error: Oops: 0000000096000047 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 3079 Comm: syz-executor283 Not tainted 6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
pstate: 00400005 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : queued_spin_lock_slowpath+0x198/0x380 kernel/locking/qspinlock.c:474
lr : queued_spin_lock_slowpath+0x114/0x380 kernel/locking/qspinlock.c:405
sp : ffff800010fe3a70
x29: ffff800010fe3a70 x28: ffff0000c02f4f80 x27: 0000000000000000
x26: ffff80000d30cf28 x25: 0000000000000000 x24: ffff0001fefefa40
x23: 0000000000000000 x22: ffff80000d30cf28 x21: ffff80000d272a40
x20: 0000000000000001 x19: ffff80000db93c18 x18: 0000000000000260
x17: 6e69676e45206574 x16: 0000000000000002 x15: 0000000000000000
x14: 0000000000000000 x13: 0000000000000db7 x12: 0000000000000000
x11: ffff80000d272a70 x10: 0000000000080000 x9 : ffff0001fefefa48
x8 : ffff0001fefefa40 x7 : 205b5d3838383531 x6 : ffff80000819545c
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000001 x1 : ffff80000ce26a9f x0 : 0000000000000001
Call trace:
 decode_tail kernel/locking/qspinlock.c:131 [inline]
 queued_spin_lock_slowpath+0x198/0x380 kernel/locking/qspinlock.c:471
 queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
 do_raw_spin_lock+0x10c/0x110 kernel/locking/spinlock_debug.c:115
 __raw_spin_lock include/linux/spinlock_api_smp.h:134 [inline]
 _raw_spin_lock+0x5c/0x6c kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:349 [inline]
 nilfs_palloc_clear_cache fs/nilfs2/alloc.c:848 [inline]
 nilfs_palloc_destroy_cache+0x2c/0xb8 fs/nilfs2/alloc.c:860
 nilfs_mdt_clear+0x34/0x70 fs/nilfs2/mdt.c:478
 nilfs_clear_inode+0x64/0x140 fs/nilfs2/inode.c:886
 nilfs_evict_inode+0x68/0x1cc fs/nilfs2/inode.c:908
 evict+0xec/0x334 fs/inode.c:665
 iput_final fs/inode.c:1748 [inline]
 iput+0x2c4/0x324 fs/inode.c:1774
 nilfs_put_super+0x6c/0x9c fs/nilfs2/super.c:476
 generic_shutdown_super+0x8c/0x190 fs/super.c:491
 kill_block_super+0x30/0x78 fs/super.c:1427
 deactivate_locked_super+0x70/0xe8 fs/super.c:332
 deactivate_super+0xd0/0xd4 fs/super.c:363
 cleanup_mnt+0x1f8/0x234 fs/namespace.c:1186
 __cleanup_mnt+0x20/0x30 fs/namespace.c:1193
 task_work_run+0xc4/0x14c kernel/task_work.c:177
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 do_notify_resume+0x174/0x1f0 arch/arm64/kernel/signal.c:1127
 prepare_exit_to_user_mode arch/arm64/kernel/entry-common.c:137 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:142 [inline]
 el0_svc+0x9c/0x150 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
 el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581
Code: 8b2c4ecc f85f818c 1200056b 8b2b52ab (f82b6988) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	8b2c4ecc 	add	x12, x22, w12, uxtw #3
   4:	f85f818c 	ldur	x12, [x12, #-8]
   8:	1200056b 	and	w11, w11, #0x3
   c:	8b2b52ab 	add	x11, x21, w11, uxtw #4
* 10:	f82b6988 	str	x8, [x12, x11] <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
