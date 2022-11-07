Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F0661E7CF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 01:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiKGAEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 19:04:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbiKGAEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 19:04:45 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CCEBE3A
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 16:04:44 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id j20-20020a056e02219400b00300a22a7fe0so7645377ila.3
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 16:04:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HcE7kLihBa6CEUaoqLpOeyRK6SUL8ybmiCmMzV2rmlQ=;
        b=OdiKQmcurGtpGqgU87a8jtHc3rj1JI2szdMRZkUzr4ob/Cky+dOqBOC5Q8saKVLK7h
         BC6qiyylTGUjhFS2Ye8Lc4zbpz8Jds0N6shX2d3W5wNoNz5iVbu3aCEnVH7LvvMLNdJA
         x0hCmcyoPBjuh9ySC3pJwelsa41ytvnKn3XmmjIvaNlEONI2MlrK6AhxTb+GPJzXg6IH
         jlLlQPaRzl9Imi8IIoNnLJ/W0vySlwTM6rebQjiNjYy+8H6ITc9+x4G4jYqMe0LC+SJj
         gCrslgem/zLFC2QQkkZN1OdOcfyxGPiKq1uGBQpLZ+7Iaj3cWbDCozZDuZ2USJZVwfs/
         LuCA==
X-Gm-Message-State: ANoB5pkuFEX7EvIZFS3yRv1qIRasmkKFFxApGt7/3FVq2usgTrcAF67c
        aua3Goozwv5PeHZRuQyz39uflVqg+uFYw2Y5b5NMSKbIii2T
X-Google-Smtp-Source: AA0mqf69tKoz3EWC77737bO3FK/DAf75zEWVyuPI5frhi3QDguvEE2ls4K9l4wsga6Ka+zamTSFgsSE42LLcauJ2Ei/RHPK6y6bz
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aab:b0:302:770:3997 with SMTP id
 l11-20020a056e021aab00b0030207703997mr4386567ilv.34.1667779483760; Sun, 06
 Nov 2022 16:04:43 -0800 (PST)
Date:   Sun, 06 Nov 2022 16:04:43 -0800
In-Reply-To: <0000000000009abbbf05ecd5f687@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b1832205ecd62ba5@google.com>
Subject: Re: [syzbot] possible deadlock in btrfs_search_slot_get_root
From:   syzbot <syzbot+4ef9e52e464c6ff47d9d@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    bbed346d5a96 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=15a085a9880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3a4a45d2d827c1e
dashboard link: https://syzkaller.appspot.com/bug?extid=4ef9e52e464c6ff47d9d
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=154649a9880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=115dc1a9880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e8e91bc79312/disk-bbed346d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c1cb3fb3b77e/vmlinux-bbed346d.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/e4f681f3b5be/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4ef9e52e464c6ff47d9d@syzkaller.appspotmail.com

BTRFS info (device loop0): using xxhash64 (xxhash64-generic) checksum algorithm
BTRFS info (device loop0): using free space tree
BTRFS info (device loop0): enabling ssd optimizations
======================================================
WARNING: possible circular locking dependency detected
6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0 Not tainted
------------------------------------------------------
syz-executor307/3029 is trying to acquire lock:
ffff0000c02525d8 (&mm->mmap_lock){++++}-{3:3}, at: __might_fault+0x54/0xb4 mm/memory.c:5576

but task is already holding lock:
ffff0000c958a608 (btrfs-root-00){++++}-{3:3}, at: __btrfs_tree_read_lock fs/btrfs/locking.c:134 [inline]
ffff0000c958a608 (btrfs-root-00){++++}-{3:3}, at: btrfs_tree_read_lock fs/btrfs/locking.c:140 [inline]
ffff0000c958a608 (btrfs-root-00){++++}-{3:3}, at: btrfs_read_lock_root_node+0x13c/0x1c0 fs/btrfs/locking.c:279

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (btrfs-root-00){++++}-{3:3}:
       down_read_nested+0x64/0x84 kernel/locking/rwsem.c:1624
       __btrfs_tree_read_lock fs/btrfs/locking.c:134 [inline]
       btrfs_tree_read_lock fs/btrfs/locking.c:140 [inline]
       btrfs_read_lock_root_node+0x13c/0x1c0 fs/btrfs/locking.c:279
       btrfs_search_slot_get_root+0x74/0x338 fs/btrfs/ctree.c:1637
       btrfs_search_slot+0x1b0/0xfd8 fs/btrfs/ctree.c:1944
       btrfs_update_root+0x6c/0x5a0 fs/btrfs/root-tree.c:132
       commit_fs_roots+0x1f0/0x33c fs/btrfs/transaction.c:1459
       btrfs_commit_transaction+0x89c/0x12d8 fs/btrfs/transaction.c:2343
       flush_space+0x66c/0x738 fs/btrfs/space-info.c:786
       btrfs_async_reclaim_metadata_space+0x43c/0x4e0 fs/btrfs/space-info.c:1059
       process_one_work+0x2d8/0x504 kernel/workqueue.c:2289
       worker_thread+0x340/0x610 kernel/workqueue.c:2436
       kthread+0x12c/0x158 kernel/kthread.c:376
       ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860

-> #2 (&fs_info->reloc_mutex){+.+.}-{3:3}:
       __mutex_lock_common+0xd4/0xca8 kernel/locking/mutex.c:603
       __mutex_lock kernel/locking/mutex.c:747 [inline]
       mutex_lock_nested+0x38/0x44 kernel/locking/mutex.c:799
       btrfs_record_root_in_trans fs/btrfs/transaction.c:516 [inline]
       start_transaction+0x248/0x944 fs/btrfs/transaction.c:752
       btrfs_start_transaction+0x34/0x44 fs/btrfs/transaction.c:781
       btrfs_create_common+0xf0/0x1b4 fs/btrfs/inode.c:6651
       btrfs_create+0x8c/0xb0 fs/btrfs/inode.c:6697
       lookup_open fs/namei.c:3413 [inline]
       open_last_lookups fs/namei.c:3481 [inline]
       path_openat+0x804/0x11c4 fs/namei.c:3688
       do_filp_open+0xdc/0x1b8 fs/namei.c:3718
       do_sys_openat2+0xb8/0x22c fs/open.c:1313
       do_sys_open fs/open.c:1329 [inline]
       __do_sys_openat fs/open.c:1345 [inline]
       __se_sys_openat fs/open.c:1340 [inline]
       __arm64_sys_openat+0xb0/0xe0 fs/open.c:1340
       __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
       invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
       el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
       do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
       el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
       el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
       el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581

-> #1 (sb_internal#2){.+.+}-{0:0}:
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1826 [inline]
       sb_start_intwrite include/linux/fs.h:1948 [inline]
       start_transaction+0x360/0x944 fs/btrfs/transaction.c:683
       btrfs_join_transaction+0x30/0x40 fs/btrfs/transaction.c:795
       btrfs_dirty_inode+0x50/0x140 fs/btrfs/inode.c:6103
       btrfs_update_time+0x1c0/0x1e8 fs/btrfs/inode.c:6145
       inode_update_time fs/inode.c:1872 [inline]
       touch_atime+0x1f0/0x4a8 fs/inode.c:1945
       file_accessed include/linux/fs.h:2516 [inline]
       btrfs_file_mmap+0x50/0x88 fs/btrfs/file.c:2407
       call_mmap include/linux/fs.h:2192 [inline]
       mmap_region+0x7fc/0xc14 mm/mmap.c:1752
       do_mmap+0x644/0x97c mm/mmap.c:1540
       vm_mmap_pgoff+0xe8/0x1d0 mm/util.c:552
       ksys_mmap_pgoff+0x1cc/0x278 mm/mmap.c:1586
       __do_sys_mmap arch/arm64/kernel/sys.c:28 [inline]
       __se_sys_mmap arch/arm64/kernel/sys.c:21 [inline]
       __arm64_sys_mmap+0x58/0x6c arch/arm64/kernel/sys.c:21
       __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
       invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
       el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
       do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
       el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
       el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
       el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581

-> #0 (&mm->mmap_lock){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3095 [inline]
       check_prevs_add kernel/locking/lockdep.c:3214 [inline]
       validate_chain kernel/locking/lockdep.c:3829 [inline]
       __lock_acquire+0x1530/0x30a4 kernel/locking/lockdep.c:5053
       lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5666
       __might_fault+0x7c/0xb4 mm/memory.c:5577
       _copy_to_user include/linux/uaccess.h:134 [inline]
       copy_to_user include/linux/uaccess.h:160 [inline]
       btrfs_ioctl_get_subvol_rootref+0x3a8/0x4bc fs/btrfs/ioctl.c:3203
       btrfs_ioctl+0xa08/0xa64 fs/btrfs/ioctl.c:5556
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:870 [inline]
       __se_sys_ioctl fs/ioctl.c:856 [inline]
       __arm64_sys_ioctl+0xd0/0x140 fs/ioctl.c:856
       __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
       invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
       el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
       do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
       el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
       el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
       el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581

other info that might help us debug this:

Chain exists of:
  &mm->mmap_lock --> &fs_info->reloc_mutex --> btrfs-root-00

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(btrfs-root-00);
                               lock(&fs_info->reloc_mutex);
                               lock(btrfs-root-00);
  lock(&mm->mmap_lock);

 *** DEADLOCK ***

1 lock held by syz-executor307/3029:
 #0: ffff0000c958a608 (btrfs-root-00){++++}-{3:3}, at: __btrfs_tree_read_lock fs/btrfs/locking.c:134 [inline]
 #0: ffff0000c958a608 (btrfs-root-00){++++}-{3:3}, at: btrfs_tree_read_lock fs/btrfs/locking.c:140 [inline]
 #0: ffff0000c958a608 (btrfs-root-00){++++}-{3:3}, at: btrfs_read_lock_root_node+0x13c/0x1c0 fs/btrfs/locking.c:279

stack backtrace:
CPU: 0 PID: 3029 Comm: syz-executor307 Not tainted 6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
Call trace:
 dump_backtrace+0x1c4/0x1f0 arch/arm64/kernel/stacktrace.c:156
 show_stack+0x2c/0x54 arch/arm64/kernel/stacktrace.c:163
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x104/0x16c lib/dump_stack.c:106
 dump_stack+0x1c/0x58 lib/dump_stack.c:113
 print_circular_bug+0x2c4/0x2c8 kernel/locking/lockdep.c:2053
 check_noncircular+0x14c/0x154 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3095 [inline]
 check_prevs_add kernel/locking/lockdep.c:3214 [inline]
 validate_chain kernel/locking/lockdep.c:3829 [inline]
 __lock_acquire+0x1530/0x30a4 kernel/locking/lockdep.c:5053
 lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5666
 __might_fault+0x7c/0xb4 mm/memory.c:5577
 _copy_to_user include/linux/uaccess.h:134 [inline]
 copy_to_user include/linux/uaccess.h:160 [inline]
 btrfs_ioctl_get_subvol_rootref+0x3a8/0x4bc fs/btrfs/ioctl.c:3203
 btrfs_ioctl+0xa08/0xa64 fs/btrfs/ioctl.c:5556
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __arm64_sys_ioctl+0xd0/0x140 fs/ioctl.c:856
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
 el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581

