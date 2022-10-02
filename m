Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF665F21B0
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 09:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiJBHSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 03:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiJBHSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 03:18:42 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E189491F9;
        Sun,  2 Oct 2022 00:18:41 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id d187so8639409vsd.6;
        Sun, 02 Oct 2022 00:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Eeu/u3ewD1YbBXdEDyQWkpaDpozwUYi0aAk9FxHOmyU=;
        b=JSiNog7CVA+3TaA3URMaM1BODKctrIls4LqDeY1Lnq6i17sDX61lhgx7UtovQ0dcyV
         KrFextZzcBYcB0aLU8rKJIgpzBqUbevGZIIfKBMY0zbJJ0cugrzEqzDxlDBycYVhwJw/
         L7RDgSIYIiL11lNm33+gmFJD3nARPRHHVsICMNKlNMv8ww4N76Cipc4Eg6+ThbCzaRXp
         mFlrjVU8yBJoD9hnRpSJ8OiOAGd1CeKvpPNMs9fVwAMzPeJ+xa81jqfPxYKakjOEkJXT
         wPZ1l6alltV8h8O7Cb45StKYAMrP5IwVshGMw1zq30Gu7D5eDYxJvfK9w71FoPkA5j8I
         zpyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Eeu/u3ewD1YbBXdEDyQWkpaDpozwUYi0aAk9FxHOmyU=;
        b=MeP4LyZ3vR7fpM0lIDvYY+4uiDIWgKtsroK86owIGYhHsucLbG4YxbfG8x5Gi2xsqY
         tqAU8zNthn8x2PcnlaUgHyL0ivmXJlWJmindgJFqJ3i+5KEuqhmC46pymwikiKBjSqLm
         VjbwDFV6zyF6/oUC4e5YCKa6AaxPAqrY7B/0ubjd12P1oKy084gjbEXhY3QEDqvPlNOi
         mxCGr/60Kn6oc0ipnr8nTipZglwMk3HBG08fg//FE9x2iWwdnc8L3GKyrG2R5J5oFMC2
         57Dd9saT00sxRKIij46zssTaYuHqrWN13dWr/8WGGpZntqUfH0ZAWM4Ff2Bh9ZEYGZ/i
         wt9A==
X-Gm-Message-State: ACrzQf2fc9T9+J5rRr8iUe5EEpBnsgpJqGV04C0pp2+vJlkM8iD2/4bD
        ao1sNJy86Vk7zKBUs38XmJEyic+LJZ0AT1EapwbkoW/m5jg=
X-Google-Smtp-Source: AMsMyM65Hl99mOd5fU3F/p6EAJlC2yd5IZ0Vwj0DNxZ4rpqCzkN+P9iHayon1ewRBEMNoXJW6MD0eavU4b/y6/DKn/k=
X-Received: by 2002:a05:6102:5709:b0:390:e360:88e8 with SMTP id
 dg9-20020a056102570900b00390e36088e8mr6726326vsb.22.1664695120342; Sun, 02
 Oct 2022 00:18:40 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000cdf4e105e9c0108f@google.com>
In-Reply-To: <000000000000cdf4e105e9c0108f@google.com>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Sun, 2 Oct 2022 16:18:23 +0900
Message-ID: <CAKFNMonuQB1wmd3VQDpvXi4a=LwCjpv6-wkgMBuyKuADJCDz_A@mail.gmail.com>
Subject: Re: [syzbot] WARNING: locking bug in nilfs_find_or_create_root
To:     syzbot <syzbot+79cb3895126af21042fa@syzkaller.appspotmail.com>
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

On Thu, Sep 29, 2022 at 2:26 AM syzbot  wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    c194837ebb57 Merge branch 'for-next/core', remote-tracking..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=1135c4ff080000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=15a770deac0c935a
> dashboard link: https://syzkaller.appspot.com/bug?extid=79cb3895126af21042fa
> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1649fcdf080000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10f24cff080000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/8d8ae425e7fa/disk-c194837e.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/c540d501ebe7/vmlinux-c194837e.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+79cb3895126af21042fa@syzkaller.appspotmail.com
>
> NILFS (loop0): broken superblock, retrying with spare superblock (blocksize = 1024)
> ------------[ cut here ]------------
> DEBUG_LOCKS_WARN_ON(1)
> WARNING: CPU: 0 PID: 3052 at kernel/locking/lockdep.c:231 check_wait_context kernel/locking/lockdep.c:4727 [inline]
> WARNING: CPU: 0 PID: 3052 at kernel/locking/lockdep.c:231 __lock_acquire+0x2b0/0x30a4 kernel/locking/lockdep.c:5003
> Modules linked in:
> CPU: 0 PID: 3052 Comm: syz-executor334 Not tainted 6.0.0-rc6-syzkaller-17742-gc194837ebb57 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
> pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : check_wait_context kernel/locking/lockdep.c:4727 [inline]
> pc : __lock_acquire+0x2b0/0x30a4 kernel/locking/lockdep.c:5003
> lr : hlock_class kernel/locking/lockdep.c:231 [inline]
> lr : check_wait_context kernel/locking/lockdep.c:4727 [inline]
> lr : __lock_acquire+0x298/0x30a4 kernel/locking/lockdep.c:5003
> sp : ffff800012763850
> x29: ffff800012763930 x28: 0000000000000001 x27: ffff0000c70a3528
> x26: ffff0000cb0b4300 x25: ffff0000c70a3f58 x24: 0000000000000000
> x23: 0000000000000000 x22: 0000000000000001 x21: 0000000000000000
> x20: 0000000000000000 x19: 5555560001430f3e x18: 00000000000000c0
> x17: ffff80000dd0b198 x16: ffff80000db49158 x15: ffff0000c70a3500
> x14: 0000000000000000 x13: 0000000000000012 x12: ffff80000d5ef920
> x11: ff808000081c1630 x10: ffff80000dd0b198 x9 : 4ab275c465431000
> x8 : 0000000000000000 x7 : 4e5241575f534b43 x6 : ffff800008195d30
> x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
> x2 : 0000000000000000 x1 : 0000000100000001 x0 : 0000000000000016
> Call trace:
>  check_wait_context kernel/locking/lockdep.c:4727 [inline]
>  __lock_acquire+0x2b0/0x30a4 kernel/locking/lockdep.c:5003
>  lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5666
>  __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
>  _raw_spin_lock+0x54/0x6c kernel/locking/spinlock.c:154
>  spin_lock include/linux/spinlock.h:349 [inline]
>  nilfs_lookup_root fs/nilfs2/the_nilfs.c:716 [inline]
>  nilfs_find_or_create_root+0x34/0x310 fs/nilfs2/the_nilfs.c:743
>  nilfs_attach_checkpoint+0x64/0x1c8 fs/nilfs2/super.c:519
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
>  el0t_64_sync+0x18c/0x190
> irq event stamp: 2725
> hardirqs last  enabled at (2725): [<ffff800008162680>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1367 [inline]
> hardirqs last  enabled at (2725): [<ffff800008162680>] finish_lock_switch+0x94/0xe8 kernel/sched/core.c:4942
> hardirqs last disabled at (2724): [<ffff80000bfc3cdc>] __schedule+0x84/0x5a0 kernel/sched/core.c:6393
> softirqs last  enabled at (2540): [<ffff8000080102e4>] _stext+0x2e4/0x37c
> softirqs last disabled at (2523): [<ffff800008017c14>] ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:79
> ---[ end trace 0000000000000000 ]---
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
> user pgtable: 4k pages, 48-bit VAs, pgdp=0000000107187000
> [00000000000000b8] pgd=08000001097ad003, p4d=08000001097ad003, pud=080000010b0a7003, pmd=0000000000000000
> Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
> Modules linked in:
> CPU: 0 PID: 3052 Comm: syz-executor334 Tainted: G        W          6.0.0-rc6-syzkaller-17742-gc194837ebb57 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
> pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : check_wait_context kernel/locking/lockdep.c:4727 [inline]
> pc : __lock_acquire+0x2d0/0x30a4 kernel/locking/lockdep.c:5003
> lr : hlock_class kernel/locking/lockdep.c:231 [inline]
> lr : check_wait_context kernel/locking/lockdep.c:4727 [inline]
> lr : __lock_acquire+0x298/0x30a4 kernel/locking/lockdep.c:5003
> sp : ffff800012763850
> x29: ffff800012763930 x28: 0000000000000001 x27: ffff0000c70a3528
> x26: ffff0000cb0b4300 x25: ffff0000c70a3f58 x24: 0000000000000000
> x23: 0000000000000000 x22: 0000000000000001 x21: 0000000000000000
> x20: 0000000000000000 x19: 5555560001430f3e x18: 00000000000000c0
> x17: ffff80000dd0b198 x16: ffff80000db49158 x15: ffff0000c70a3500
> x14: 0000000000000000 x13: 0000000000000012 x12: ffff80000d5ef920
> x11: ff808000081c1630 x10: ffff80000dd0b198 x9 : 0000000000040f3e
> x8 : 0000000000000000 x7 : 4e5241575f534b43 x6 : ffff800008195d30
> x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
> x2 : 0000000000000000 x1 : 0000000100000001 x0 : 0000000000000016
> Call trace:
>  hlock_class kernel/locking/lockdep.c:222 [inline]
>  check_wait_context kernel/locking/lockdep.c:4728 [inline]
>  __lock_acquire+0x2d0/0x30a4 kernel/locking/lockdep.c:5003
>  lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5666
>  __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
>  _raw_spin_lock+0x54/0x6c kernel/locking/spinlock.c:154
>  spin_lock include/linux/spinlock.h:349 [inline]
>  nilfs_lookup_root fs/nilfs2/the_nilfs.c:716 [inline]
>  nilfs_find_or_create_root+0x34/0x310 fs/nilfs2/the_nilfs.c:743
>  nilfs_attach_checkpoint+0x64/0x1c8 fs/nilfs2/super.c:519
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
>  el0t_64_sync+0x18c/0x190
> Code: 9002db8a 91056210 9106614a b9400329 (3942e114)
> ---[ end trace 0000000000000000 ]---
> ----------------
> Code disassembly (best guess):
>    0:   9002db8a        adrp    x10, 0x5b70000
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

#syz dup: BUG: unable to handle kernel paging request in kernfs_put_active

This turned out to be the same issue as the above report.

I confirmed that the associated bugfix commit "fs: fix UAF/GPF bug in
nilfs_mdt_destroy" fixes the oops.

Ryusuke Konishi
