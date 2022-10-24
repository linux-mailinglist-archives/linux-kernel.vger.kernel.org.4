Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F16C060B132
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 18:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234189AbiJXQRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 12:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234764AbiJXQPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 12:15:11 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816239FC7;
        Mon, 24 Oct 2022 08:02:59 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id 128so8134044vsz.12;
        Mon, 24 Oct 2022 08:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rikvGZsheNdp/WHsA3B+/2VQRCjNNzZ0AvUijRbif+4=;
        b=oQAYQ3fy3he0cYhVYOlm2YlfWKSyYYlJeI0XnIlAuUKO3va7HezEPVLJ4lYlhv1EJ5
         0sr33KlkgFJkQSEgQ0LXwoIDjocsHmcGBYB+yAWila99bIKNCl6GOdsvLVZqmkVr5/F6
         RWQ/2Kp6rMRJFGZELj74252Sg8l6y7XGxIfekC5eBPcW6USYkeo9qYLZKuwNKMGKEWBG
         5TzphDOuWQkKtiADDOML7H83Te0Ig9cz7Uz/PifrlwlgnJt89k8ML7XdX3WKtWLCwTCL
         ta01RjiiWzP+coWFLhm7VGxHIUOJdjrzO5ty5sdBD2WLZyvaQBpFaf4LuTPKgjh1h+Re
         /FPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rikvGZsheNdp/WHsA3B+/2VQRCjNNzZ0AvUijRbif+4=;
        b=ECdXLeOk9oLoNJET/z3I61xr0V+0243/wg48myfmbfTo3+BhcCb2o3b3TmlBsgPVp7
         jHr4d96zVdoEy1AmVIbaTsNjmrakZUFbACRsQaJZUT47iX5L6rYIu8S/JAIWTO0W2uRZ
         WAHDbWoq6DrW7S+wZmzKS/MrxJFBlGZuYcmBOG+Wi5T5xUZHwa6W1eQYFfcTP8G44V/E
         kQQVaz6ghHdKxHiHe43QdchupK2xSgXqxD9bBJW3tsGAYME+IGoIKfrfAmQY5R1hx11a
         uz8ytcSPG5RiViO3L30/uTQsOpcn4uPstEOz/ODE9+Dqt0v4ddQmQx7DbIcZgB0ABqpV
         t/Hg==
X-Gm-Message-State: ACrzQf0SmjtbNdjEpNDLb1HeOZ92zfuB92ndfCINRPgZZPE+703d0StC
        PqM4b8tP7bOxG517GF93bDu5CAHKsqxIkVgO8RzHCO4j6N4=
X-Google-Smtp-Source: AMsMyM47nPc4VGCrQ1dig0eVsrOxozziRS+Yk2pJV7jrvn7GbEuRDCoa0+HM/AKfsivbagW7eRRK9z4ldxtjYitIA4s=
X-Received: by 2002:a67:db0d:0:b0:3aa:12be:c26c with SMTP id
 z13-20020a67db0d000000b003aa12bec26cmr4457918vsj.26.1666623630420; Mon, 24
 Oct 2022 08:00:30 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000931cf305ebaea35d@google.com>
In-Reply-To: <000000000000931cf305ebaea35d@google.com>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Tue, 25 Oct 2022 00:00:13 +0900
Message-ID: <CAKFNMonJiE+c3Qt2zoB-NgqrpCP641kHgeTbv+pTgFpV=XCvPg@mail.gmail.com>
Subject: Re: [syzbot] WARNING: locking bug in nilfs_cpfile_get_checkpoint
To:     syzbot <syzbot+e567d760e00a7a29512b@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-nilfs@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 23, 2022 at 4:29 PM syzbot wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    bbed346d5a96 Merge branch 'for-next/core' into for-kernelci
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=10581572880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3a4a45d2d827c1e
> dashboard link: https://syzkaller.appspot.com/bug?extid=e567d760e00a7a29512b
> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16e8d05a880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=114a1022880000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/e8e91bc79312/disk-bbed346d.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/c1cb3fb3b77e/vmlinux-bbed346d.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/e10e77b79957/mount_0.gz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+e567d760e00a7a29512b@syzkaller.appspotmail.com
>
> loop0: detected capacity change from 0 to 2048
> ------------[ cut here ]------------
> DEBUG_LOCKS_WARN_ON(1)
> WARNING: CPU: 0 PID: 4135 at kernel/locking/lockdep.c:231 check_wait_context kernel/locking/lockdep.c:4727 [inline]
> WARNING: CPU: 0 PID: 4135 at kernel/locking/lockdep.c:231 __lock_acquire+0x2b0/0x30a4 kernel/locking/lockdep.c:5003
> Modules linked in:
> CPU: 0 PID: 4135 Comm: syz-executor168 Not tainted 6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
> pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : check_wait_context kernel/locking/lockdep.c:4727 [inline]
> pc : __lock_acquire+0x2b0/0x30a4 kernel/locking/lockdep.c:5003
> lr : hlock_class kernel/locking/lockdep.c:231 [inline]
> lr : check_wait_context kernel/locking/lockdep.c:4727 [inline]
> lr : __lock_acquire+0x298/0x30a4 kernel/locking/lockdep.c:5003
> sp : ffff800012d9b820
> x29: ffff800012d9b900 x28: 0000000000000002 x27: ffff0000c1f14fd0
> x26: ffff0000c954eb70 x25: ffff0000c1f15a00 x24: 0000000000000000
> x23: 0000000000000000 x22: 0000000000000001 x21: 0000000000000000
> x20: 0000000000000000 x19: ffffff555651563c x18: 0000000000000026
> x17: ffff80000bffd6bc x16: ffff80000db49158 x15: ffff0000c1f14f80
> x14: 0000000000000000 x13: 0000000000000012 x12: ffff80000d5ef920
> x11: ff808000081c0d5c x10: ffff80000dd0b198 x9 : 1e098b7dd4c21b00
> x8 : 0000000000000000 x7 : 4e5241575f534b43 x6 : ffff80000819545c
> x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
> x2 : 0000000000000000 x1 : 0000000100000000 x0 : 0000000000000016
> Call trace:
>  check_wait_context kernel/locking/lockdep.c:4727 [inline]
>  __lock_acquire+0x2b0/0x30a4 kernel/locking/lockdep.c:5003
>  lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5666
>  down_write+0x5c/0xcc kernel/locking/rwsem.c:1552
>  nilfs_cpfile_get_checkpoint+0xa8/0x404 fs/nilfs2/cpfile.c:230
>  nilfs_attach_checkpoint+0xb8/0x1c8 fs/nilfs2/super.c:528
>  nilfs_fill_super+0x154/0x2f8 fs/nilfs2/super.c:1064
>  nilfs_mount+0x370/0x52c fs/nilfs2/super.c:1317
>  legacy_get_tree+0x30/0x74 fs/fs_context.c:610
>  vfs_get_tree+0x40/0x140 fs/super.c:1530
>  do_new_mount+0x1dc/0x4e4 fs/namespace.c:3040
>  path_mount+0x358/0x914 fs/namespace.c:3370
>  do_mount fs/namespace.c:3383 [inline]
>  __do_sys_mount fs/namespace.c:3591 [inline]
>  __se_sys_mount fs/namespace.c:3568 [inline]
>  __arm64_sys_mount+0x2c4/0x3c4 fs/namespace.c:3568
>  __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
>  invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
>  el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
>  do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
>  el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
>  el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
>  el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581
> irq event stamp: 2345
> hardirqs last  enabled at (2345): [<ffff800008161dac>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1367 [inline]
> hardirqs last  enabled at (2345): [<ffff800008161dac>] finish_lock_switch+0x94/0xe8 kernel/sched/core.c:4942
> hardirqs last disabled at (2344): [<ffff80000bfc0a34>] __schedule+0x84/0x5a0 kernel/sched/core.c:6393
> softirqs last  enabled at (1180): [<ffff80000801c33c>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
> softirqs last disabled at (1178): [<ffff80000801c308>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
> ---[ end trace 0000000000000000 ]---
> BUG: sleeping function called from invalid context at arch/arm64/mm/fault.c:593
> in_atomic(): 0, irqs_disabled(): 128, non_block: 0, pid: 4135, name: syz-executor168
> preempt_count: 0, expected: 0
> RCU nest depth: 0, expected: 0
> INFO: lockdep is turned off.
> irq event stamp: 2345
> hardirqs last  enabled at (2345): [<ffff800008161dac>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1367 [inline]
> hardirqs last  enabled at (2345): [<ffff800008161dac>] finish_lock_switch+0x94/0xe8 kernel/sched/core.c:4942
> hardirqs last disabled at (2344): [<ffff80000bfc0a34>] __schedule+0x84/0x5a0 kernel/sched/core.c:6393
> softirqs last  enabled at (1180): [<ffff80000801c33c>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
> softirqs last disabled at (1178): [<ffff80000801c308>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
> CPU: 0 PID: 4135 Comm: syz-executor168 Tainted: G        W          6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
> Call trace:
>  dump_backtrace+0x1c4/0x1f0 arch/arm64/kernel/stacktrace.c:156
>  show_stack+0x2c/0x54 arch/arm64/kernel/stacktrace.c:163
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x104/0x16c lib/dump_stack.c:106
>  dump_stack+0x1c/0x58 lib/dump_stack.c:113
>  __might_resched+0x208/0x218 kernel/sched/core.c:9892
>  __might_sleep+0x48/0x78 kernel/sched/core.c:9821
>  do_page_fault+0x214/0x79c arch/arm64/mm/fault.c:593
>  do_translation_fault+0x78/0x194 arch/arm64/mm/fault.c:685
>  do_mem_abort+0x54/0x130 arch/arm64/mm/fault.c:821
>  el1_abort+0x3c/0x5c arch/arm64/kernel/entry-common.c:366
>  el1h_64_sync_handler+0x60/0xac arch/arm64/kernel/entry-common.c:426
>  el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:576
>  hlock_class kernel/locking/lockdep.c:222 [inline]
>  check_wait_context kernel/locking/lockdep.c:4728 [inline]
>  __lock_acquire+0x2d0/0x30a4 kernel/locking/lockdep.c:5003
>  lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5666
>  down_write+0x5c/0xcc kernel/locking/rwsem.c:1552
>  nilfs_cpfile_get_checkpoint+0xa8/0x404 fs/nilfs2/cpfile.c:230
>  nilfs_attach_checkpoint+0xb8/0x1c8 fs/nilfs2/super.c:528
>  nilfs_fill_super+0x154/0x2f8 fs/nilfs2/super.c:1064
>  nilfs_mount+0x370/0x52c fs/nilfs2/super.c:1317
>  legacy_get_tree+0x30/0x74 fs/fs_context.c:610
>  vfs_get_tree+0x40/0x140 fs/super.c:1530
>  do_new_mount+0x1dc/0x4e4 fs/namespace.c:3040
>  path_mount+0x358/0x914 fs/namespace.c:3370
>  do_mount fs/namespace.c:3383 [inline]
>  __do_sys_mount fs/namespace.c:3591 [inline]
>  __se_sys_mount fs/namespace.c:3568 [inline]
>  __arm64_sys_mount+0x2c4/0x3c4 fs/namespace.c:3568
>  __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
>  invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
>  el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
>  do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
>  el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
>  el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
>  el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581
> Unable to handle kernel NULL pointer dereference at virtual address 00000000000000b8
> Mem abort info:
>   ESR = 0x0000000096000006
>   EC = 0x25: DABT (current EL), IL = 32 bits
>   SET = 0, FnV = 0
>   EA = 0, S1PTW = 0
>   FSC = 0x06: level 2 translation fault
> Data abort info:
>   ISV = 0, ISS = 0x00000006
>   CM = 0, WnR = 0
> user pgtable: 4k pages, 48-bit VAs, pgdp=00000001071a6000
> [00000000000000b8] pgd=0800000107366003, p4d=0800000107366003, pud=080000010ab71003, pmd=0000000000000000
> Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
> Modules linked in:
> CPU: 0 PID: 4135 Comm: syz-executor168 Tainted: G        W          6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
> pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : check_wait_context kernel/locking/lockdep.c:4727 [inline]
> pc : __lock_acquire+0x2d0/0x30a4 kernel/locking/lockdep.c:5003
> lr : hlock_class kernel/locking/lockdep.c:231 [inline]
> lr : check_wait_context kernel/locking/lockdep.c:4727 [inline]
> lr : __lock_acquire+0x298/0x30a4 kernel/locking/lockdep.c:5003
> sp : ffff800012d9b820
> x29: ffff800012d9b900 x28: 0000000000000002 x27: ffff0000c1f14fd0
> x26: ffff0000c954eb70 x25: ffff0000c1f15a00 x24: 0000000000000000
> x23: 0000000000000000 x22: 0000000000000001 x21: 0000000000000000
> x20: 0000000000000000 x19: ffffff555651563c x18: 0000000000000026
> x17: ffff80000bffd6bc x16: ffff80000db49158 x15: ffff0000c1f14f80
> x14: 0000000000000000 x13: 0000000000000012 x12: ffff80000d5ef920
> x11: ff808000081c0d5c x10: ffff80000dd0b198 x9 : 000000000004163c
> x8 : 0000000000000000 x7 : 4e5241575f534b43 x6 : ffff80000819545c
> x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
> x2 : 0000000000000000 x1 : 0000000100000000 x0 : 0000000000000016
> Call trace:
>  hlock_class kernel/locking/lockdep.c:222 [inline]
>  check_wait_context kernel/locking/lockdep.c:4728 [inline]
>  __lock_acquire+0x2d0/0x30a4 kernel/locking/lockdep.c:5003
>  lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5666
>  down_write+0x5c/0xcc kernel/locking/rwsem.c:1552
>  nilfs_cpfile_get_checkpoint+0xa8/0x404 fs/nilfs2/cpfile.c:230
>  nilfs_attach_checkpoint+0xb8/0x1c8 fs/nilfs2/super.c:528
>  nilfs_fill_super+0x154/0x2f8 fs/nilfs2/super.c:1064
>  nilfs_mount+0x370/0x52c fs/nilfs2/super.c:1317
>  legacy_get_tree+0x30/0x74 fs/fs_context.c:610
>  vfs_get_tree+0x40/0x140 fs/super.c:1530
>  do_new_mount+0x1dc/0x4e4 fs/namespace.c:3040
>  path_mount+0x358/0x914 fs/namespace.c:3370
>  do_mount fs/namespace.c:3383 [inline]
>  __do_sys_mount fs/namespace.c:3591 [inline]
>  __se_sys_mount fs/namespace.c:3568 [inline]
>  __arm64_sys_mount+0x2c4/0x3c4 fs/namespace.c:3568
>  __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
>  invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
>  el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
>  do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
>  el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
>  el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
>  el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581
> Code: b002db8a 91056210 9106614a b9400329 (3942e114)
> ---[ end trace 0000000000000000 ]---
> ----------------
> Code disassembly (best guess):
>    0:   b002db8a        adrp    x10, 0x5b71000
>    4:   91056210        add     x16, x16, #0x158
>    8:   9106614a        add     x10, x10, #0x198
>    c:   b9400329        ldr     w9, [x25]
> * 10:   3942e114        ldrb    w20, [x8, #184] <-- trapping instruction
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this issue, for details see:
> https://goo.gl/tpsmEJ#testing-patches

Look like the same bug as below:

#syz dup: BUG: unable to handle kernel paging request in kernfs_put_active

The bugfix for this is the patch titled "fs: fix UAF/GPF bug in
nilfs_mdt_destroy", which is merged in the mainline after the commit
of the tested kernel.

I confirmed that the fix patch suppresses the bug by testing with the
C-reproducer.

Ryusuke Konishi
