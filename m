Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855F061E777
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 00:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiKFXJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 18:09:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKFXJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 18:09:12 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3922D2AD6;
        Sun,  6 Nov 2022 15:09:11 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id p4so9071985vsa.11;
        Sun, 06 Nov 2022 15:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BoRb+vcOPgFNoR16yc7eRBZHB5iKQ9RtBZTrICzcXxw=;
        b=llshyBByPgX14SxNQxTQSs9T4O8HR3B1WvfBC14Py2XqYjTBDnl2vqidIZo/L7CsOI
         i7AKaMr7zhelibfLTjRfTMOgkxqCl9CCrUZFuxOTPCa/baPqv6D9xi61QnSrFrHeQbTI
         CpbMSVYe3cNGtp4ctF2Amk/RRF3TzoS7jV92QMpbVbch7Y6dLair+14Th4dbpffbH4+2
         mgG5/bx1g3W3blGT7K3yVEQZgk7ahPJ8JXXlrYlbfQUxhuT+kR6VtzkSsQkUPEhBzum8
         CHcoIsD/ipaYhJw0f+e3Du6unEkPfV1qjc7ThhjR7DHHGRSJ0GmMlOfdcjum6YzQlm/0
         ogzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BoRb+vcOPgFNoR16yc7eRBZHB5iKQ9RtBZTrICzcXxw=;
        b=fOf+yxOuTAXDU5hlXvdadl4QG7pcYwqcvypdNJMuKfF9CGZhXcFxp6LqiPXa96c0dK
         DP7scrnCYQsxjzPzmqsAKWxe/UQKBs5GzkBnn3D9CfC2+5xNMjaRbEp6LCMxODQPubp7
         efcUaoWeaeUEswh3QgwDD3SruyF4PyhKqFP+9ULTGQU55EoCZ9lE19JQoaLNk70rEQM/
         FVoutqsRksr2bLuHeXs6zRF7Ch/otLIds2ZyQ3bd+iZmp9GPZ/3Rr1FNDJ9S5jQiGhWj
         N1VwYwpyf3idNbu2vyrEvUoh6zODDFliY2jwCV5yWK6Rys79aRkCJsu2VGAbdVKxov8u
         TfxQ==
X-Gm-Message-State: ACrzQf2ehgegH9NyydApVX2kEJtw4T0e5fsoFOKNEkin641D6AKU4Myt
        hCc+4mUEUOfbWjbk5d4EgRTrq6jNw9JpXCJjRzQ=
X-Google-Smtp-Source: AMsMyM53d8x4NxGCVxwEk70IPAYbmn+kZgImdabFDkBJiJ6BftXB8coueq7Klb3RQfY+AM40yKKnrgfCX7ORduFAMrA=
X-Received: by 2002:a67:db0d:0:b0:3aa:12be:c26c with SMTP id
 z13-20020a67db0d000000b003aa12bec26cmr24472013vsj.26.1667776150134; Sun, 06
 Nov 2022 15:09:10 -0800 (PST)
MIME-Version: 1.0
References: <000000000000859fca05ecd04647@google.com>
In-Reply-To: <000000000000859fca05ecd04647@google.com>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Mon, 7 Nov 2022 08:08:53 +0900
Message-ID: <CAKFNMomCzGD_Znc2rrAEaNuzD+8eE2kk_NYpSSNLd_UkBV6U_Q@mail.gmail.com>
Subject: Re: [syzbot] WARNING: locking bug in nilfs_palloc_destroy_cache
To:     syzbot <syzbot+52bf723c703aa9b88640@syzkaller.appspotmail.com>
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

On Mon, Nov 7, 2022 at 2:02 AM syzbot wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    bbed346d5a96 Merge branch 'for-next/core' into for-kernelci
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=157dc905880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3a4a45d2d827c1e
> dashboard link: https://syzkaller.appspot.com/bug?extid=52bf723c703aa9b88640
> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17179651880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10cc5d91880000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/e8e91bc79312/disk-bbed346d.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/c1cb3fb3b77e/vmlinux-bbed346d.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/3bd548b7efd3/mount_0.gz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+52bf723c703aa9b88640@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> DEBUG_LOCKS_WARN_ON(1)
> WARNING: CPU: 1 PID: 3031 at kernel/locking/lockdep.c:231 check_wait_context kernel/locking/lockdep.c:4727 [inline]
> WARNING: CPU: 1 PID: 3031 at kernel/locking/lockdep.c:231 __lock_acquire+0x2b0/0x30a4 kernel/locking/lockdep.c:5003
> Modules linked in:
> CPU: 1 PID: 3031 Comm: syz-executor196 Not tainted 6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
> pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : check_wait_context kernel/locking/lockdep.c:4727 [inline]
> pc : __lock_acquire+0x2b0/0x30a4 kernel/locking/lockdep.c:5003
> lr : hlock_class kernel/locking/lockdep.c:231 [inline]
> lr : check_wait_context kernel/locking/lockdep.c:4727 [inline]
> lr : __lock_acquire+0x298/0x30a4 kernel/locking/lockdep.c:5003
> sp : ffff8000129f3900
> x29: ffff8000129f39e0 x28: 0000000000000001 x27: ffff0000c5371aa8
> x26: ffff80000cb49def x25: ffff0000c53724d8 x24: 0000000000000000
> x23: 0000000000000000 x22: 0000000000000001 x21: 0000000000000000
> x20: 0000000000000000 x19: 55f07fe0846faa84 x18: 00000000000003e8
> x17: ffff80000bffd6bc x16: ffff80000db49158 x15: ffff0000c5371a80
> x14: 0000000000000000 x13: 0000000000000012 x12: ffff80000d5ef920
> x11: ff808000081c0d5c x10: ffff80000dd0b198 x9 : 62dca878cb47c300
> x8 : 0000000000000000 x7 : 4e5241575f534b43 x6 : ffff80000819545c
> x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
> x2 : 0000000000000000 x1 : 0000000100000001 x0 : 0000000000000016
> Call trace:
>  check_wait_context kernel/locking/lockdep.c:4727 [inline]
>  __lock_acquire+0x2b0/0x30a4 kernel/locking/lockdep.c:5003
>  lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5666
>  __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
>  _raw_spin_lock+0x54/0x6c kernel/locking/spinlock.c:154
>  spin_lock include/linux/spinlock.h:349 [inline]
>  nilfs_palloc_clear_cache fs/nilfs2/alloc.c:848 [inline]
>  nilfs_palloc_destroy_cache+0x2c/0xb8 fs/nilfs2/alloc.c:860
>  nilfs_mdt_clear+0x34/0x70 fs/nilfs2/mdt.c:478
>  nilfs_clear_inode+0x64/0x140 fs/nilfs2/inode.c:886
>  nilfs_evict_inode+0x68/0x1cc fs/nilfs2/inode.c:908
>  evict+0xec/0x334 fs/inode.c:665
>  iput_final fs/inode.c:1748 [inline]
>  iput+0x2c4/0x324 fs/inode.c:1774
>  nilfs_put_super+0x6c/0x9c fs/nilfs2/super.c:476
>  generic_shutdown_super+0x8c/0x190 fs/super.c:491
>  kill_block_super+0x30/0x78 fs/super.c:1427
>  deactivate_locked_super+0x70/0xe8 fs/super.c:332
>  deactivate_super+0xd0/0xd4 fs/super.c:363
>  cleanup_mnt+0x1f8/0x234 fs/namespace.c:1186
>  __cleanup_mnt+0x20/0x30 fs/namespace.c:1193
>  task_work_run+0xc4/0x14c kernel/task_work.c:177
>  resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
>  do_notify_resume+0x174/0x1f0 arch/arm64/kernel/signal.c:1127
>  prepare_exit_to_user_mode arch/arm64/kernel/entry-common.c:137 [inline]
>  exit_to_user_mode arch/arm64/kernel/entry-common.c:142 [inline]
>  el0_svc+0x9c/0x150 arch/arm64/kernel/entry-common.c:637
>  el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
>  el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581
> irq event stamp: 356107
> hardirqs last  enabled at (356107): [<ffff80000bfc8a34>] __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:159 [inline]
> hardirqs last  enabled at (356107): [<ffff80000bfc8a34>] _raw_spin_unlock_irq+0x3c/0x70 kernel/locking/spinlock.c:202
> hardirqs last disabled at (356106): [<ffff80000bfc8834>] __raw_spin_lock_irq include/linux/spinlock_api_smp.h:117 [inline]
> hardirqs last disabled at (356106): [<ffff80000bfc8834>] _raw_spin_lock_irq+0x34/0x9c kernel/locking/spinlock.c:170
> softirqs last  enabled at (355348): [<ffff80000801c33c>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
> softirqs last disabled at (355346): [<ffff80000801c308>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
> ---[ end trace 0000000000000000 ]---
> Unable to handle kernel NULL pointer dereference at virtual address 00000000000000b8
> Mem abort info:
>   ESR = 0x0000000096000004
>   EC = 0x25: DABT (current EL), IL = 32 bits
>   SET = 0, FnV = 0
>   EA = 0, S1PTW = 0
>   FSC = 0x04: level 0 translation fault
> Data abort info:
>   ISV = 0, ISS = 0x00000004
>   CM = 0, WnR = 0
> user pgtable: 4k pages, 48-bit VAs, pgdp=000000010ae77000
> [00000000000000b8] pgd=0000000000000000, p4d=0000000000000000
> Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
> Modules linked in:
> CPU: 1 PID: 3031 Comm: syz-executor196 Tainted: G        W          6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
> pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : check_wait_context kernel/locking/lockdep.c:4727 [inline]
> pc : __lock_acquire+0x2d0/0x30a4 kernel/locking/lockdep.c:5003
> lr : hlock_class kernel/locking/lockdep.c:231 [inline]
> lr : check_wait_context kernel/locking/lockdep.c:4727 [inline]
> lr : __lock_acquire+0x298/0x30a4 kernel/locking/lockdep.c:5003
> sp : ffff8000129f3900
> x29: ffff8000129f39e0 x28: 0000000000000001 x27: ffff0000c5371aa8
> x26: ffff80000cb49def x25: ffff0000c53724d8 x24: 0000000000000000
> x23: 0000000000000000 x22: 0000000000000001 x21: 0000000000000000
> x20: 0000000000000000 x19: 55f07fe0846faa84 x18: 00000000000003e8
> x17: ffff80000bffd6bc x16: ffff80000db49158 x15: ffff0000c5371a80
> x14: 0000000000000000 x13: 0000000000000012 x12: ffff80000d5ef920
> x11: ff808000081c0d5c x10: ffff80000dd0b198 x9 : 0000000000040a84
> x8 : 0000000000000000 x7 : 4e5241575f534b43 x6 : ffff80000819545c
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
>  nilfs_palloc_clear_cache fs/nilfs2/alloc.c:848 [inline]
>  nilfs_palloc_destroy_cache+0x2c/0xb8 fs/nilfs2/alloc.c:860
>  nilfs_mdt_clear+0x34/0x70 fs/nilfs2/mdt.c:478
>  nilfs_clear_inode+0x64/0x140 fs/nilfs2/inode.c:886
>  nilfs_evict_inode+0x68/0x1cc fs/nilfs2/inode.c:908
>  evict+0xec/0x334 fs/inode.c:665
>  iput_final fs/inode.c:1748 [inline]
>  iput+0x2c4/0x324 fs/inode.c:1774
>  nilfs_put_super+0x6c/0x9c fs/nilfs2/super.c:476
>  generic_shutdown_super+0x8c/0x190 fs/super.c:491
>  kill_block_super+0x30/0x78 fs/super.c:1427
>  deactivate_locked_super+0x70/0xe8 fs/super.c:332
>  deactivate_super+0xd0/0xd4 fs/super.c:363
>  cleanup_mnt+0x1f8/0x234 fs/namespace.c:1186
>  __cleanup_mnt+0x20/0x30 fs/namespace.c:1193
>  task_work_run+0xc4/0x14c kernel/task_work.c:177
>  resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
>  do_notify_resume+0x174/0x1f0 arch/arm64/kernel/signal.c:1127
>  prepare_exit_to_user_mode arch/arm64/kernel/entry-common.c:137 [inline]
>  exit_to_user_mode arch/arm64/kernel/entry-common.c:142 [inline]
>  el0_svc+0x9c/0x150 arch/arm64/kernel/entry-common.c:637
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

This is the same bug as below:

#syz dup: BUG: unable to handle kernel paging request in kernfs_put_active

The bugfix for this is the patch titled "fs: fix UAF/GPF bug in
nilfs_mdt_destroy", which is merged in the mainline after the commit
of the tested kernel.

I confirmed that the fix patch suppresses the bug by testing with the
C-reproducer.

Ryusuke Konishi
