Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF8325FA7A0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 00:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiJJWVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 18:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiJJWVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 18:21:43 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14B01C10E
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 15:21:39 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id i21-20020a056e021d1500b002f9e4f8eab7so9562997ila.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 15:21:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y2Gg+leZ8xgFvHY7RKw1TT2iAfDuzT5tY1WEzpaaQ58=;
        b=nBloLlwJACUA1tLykZjLysmAbJk6Oh2EEyhqOGOljWkO4BbqAEQ2xLlKIinVWW/Z7R
         vYJl4g4jaF69NmDJNrkyNRx0t9UFVGtYpEo/gFnjwPWsLYAyoWyTRUxYOZrJjSOymAfg
         cx0Bmw0sKxiMIaWZ3R3Q4UisprRnpMw0S9ncV8ZuG4YkQa3cbcBxBRA0Lt1Pzp9PZ8bT
         0vVugI+OADWxYPgUyqSJENeMQ0IwUxT0Z5LFeN3nrstLmckaQQG9l+smCMvUWGIPfteq
         5XU7YxjyOE5cPJ7k9MOX5AVqnkvuvurJuZfzCIsgzHpcgRX2mrXuO7wn7bEhz5ZgfPsN
         /N0A==
X-Gm-Message-State: ACrzQf1OYRIsRbT8INL91H1aj71/R7mxdzLaWCHAwqPXnALBS+zgJBNJ
        1CQFVdjmy/qu+bSj3AnJGlyNfIMiOeJb8AvQ3qtgIeqtZdO7
X-Google-Smtp-Source: AMsMyM7W1yJ1lYmuoAKZSGPBadDyxV4P8QHRCveoTnGBcbJjZxhE06IpVM5/mbegSIdR/V8UENvyh4qUFRRU3ii/Jfq6QCsQ6Kok
MIME-Version: 1.0
X-Received: by 2002:a92:ab01:0:b0:2fc:405a:d055 with SMTP id
 v1-20020a92ab01000000b002fc405ad055mr3463667ilh.94.1665440499017; Mon, 10 Oct
 2022 15:21:39 -0700 (PDT)
Date:   Mon, 10 Oct 2022 15:21:39 -0700
In-Reply-To: <0000000000004f067905ea8ab9b2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000056ad0b05eab59541@google.com>
Subject: Re: [syzbot] possible deadlock in dquot_commit (2)
From:   syzbot <syzbot+70ff52e51b7e7714db8a@syzkaller.appspotmail.com>
To:     jack@suse.com, linux-kernel@vger.kernel.org,
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
console output: https://syzkaller.appspot.com/x/log.txt?x=12a6f83a880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3a4a45d2d827c1e
dashboard link: https://syzkaller.appspot.com/bug?extid=70ff52e51b7e7714db8a
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13002db2880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14fce2dc880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e8e91bc79312/disk-bbed346d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c1cb3fb3b77e/vmlinux-bbed346d.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/05209e29dc74/mount_0.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/9644b6673e5e/mount_4.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+70ff52e51b7e7714db8a@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0 Not tainted
------------------------------------------------------
syz-executor252/3082 is trying to acquire lock:
ffff0000c6c8c0a8 (&dquot->dq_lock){+.+.}-{3:3}, at: dquot_commit+0x34/0x1e4 fs/quota/dquot.c:479

but task is already holding lock:
ffff0000ca4f8c18 (&ei->i_data_sem/2){++++}-{3:3}, at: ext4_map_blocks+0x444/0xaec fs/ext4/inode.c:638

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&ei->i_data_sem/2){++++}-{3:3}:
       down_read+0x5c/0x78 kernel/locking/rwsem.c:1499
       ext4_map_blocks+0x15c/0xaec fs/ext4/inode.c:568
       ext4_getblk+0xc4/0x448 fs/ext4/inode.c:858
       ext4_bread+0x3c/0x164 fs/ext4/inode.c:914
       ext4_quota_write+0x120/0x31c fs/ext4/super.c:6956
       write_blk fs/quota/quota_tree.c:64 [inline]
       get_free_dqblk+0xec/0x1a0 fs/quota/quota_tree.c:93
       do_insert_tree+0xdc/0x838 fs/quota/quota_tree.c:300
       do_insert_tree+0x24c/0x838 fs/quota/quota_tree.c:331
       do_insert_tree+0x24c/0x838 fs/quota/quota_tree.c:331
       do_insert_tree+0x24c/0x838 fs/quota/quota_tree.c:331
       dq_insert_tree fs/quota/quota_tree.c:357 [inline]
       qtree_write_dquot+0x188/0x204 fs/quota/quota_tree.c:376
       v2_write_dquot+0x70/0xb0 fs/quota/quota_v2.c:358
       dquot_acquire+0x158/0x23c fs/quota/dquot.c:444
       ext4_acquire_dquot+0xd4/0x11c fs/ext4/super.c:6612
       dqget+0x44c/0x5c0 fs/quota/dquot.c:914
       __dquot_initialize+0x15c/0x588 fs/quota/dquot.c:1492
       dquot_initialize+0x24/0x34 fs/quota/dquot.c:1550
       ext4_create+0x50/0x26c fs/ext4/namei.c:2789
       lookup_open fs/namei.c:3413 [inline]
       open_last_lookups fs/namei.c:3481 [inline]
       path_openat+0x804/0x11c4 fs/namei.c:3688
       do_filp_open+0xdc/0x1b8 fs/namei.c:3718
       file_open_name fs/open.c:1258 [inline]
       filp_open+0x104/0x144 fs/open.c:1278
       do_coredump+0xd98/0x10a0 fs/coredump.c:697
       get_signal+0x7c4/0xb40 kernel/signal.c:2843
       do_signal+0xd4/0x438 arch/arm64/kernel/signal.c:1071
       do_notify_resume+0xc0/0x1f0 arch/arm64/kernel/signal.c:1124
       prepare_exit_to_user_mode arch/arm64/kernel/entry-common.c:137 [inline]
       exit_to_user_mode arch/arm64/kernel/entry-common.c:142 [inline]
       el0_da+0xb8/0x16c arch/arm64/kernel/entry-common.c:515
       el0t_64_sync_handler+0xcc/0xf0 arch/arm64/kernel/entry-common.c:657
       el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581

-> #1 (&s->s_dquot.dqio_sem){++++}-{3:3}:
       down_read+0x5c/0x78 kernel/locking/rwsem.c:1499
       v2_read_dquot+0x28/0x64 fs/quota/quota_v2.c:332
       dquot_acquire+0x74/0x23c fs/quota/dquot.c:435
       ext4_acquire_dquot+0xd4/0x11c fs/ext4/super.c:6612
       dqget+0x44c/0x5c0 fs/quota/dquot.c:914
       __dquot_initialize+0x1b8/0x588 fs/quota/dquot.c:1492
       dquot_initialize+0x24/0x34 fs/quota/dquot.c:1550
       ext4_create+0x50/0x26c fs/ext4/namei.c:2789
       lookup_open fs/namei.c:3413 [inline]
       open_last_lookups fs/namei.c:3481 [inline]
       path_openat+0x804/0x11c4 fs/namei.c:3688
       do_filp_open+0xdc/0x1b8 fs/namei.c:3718
       file_open_name fs/open.c:1258 [inline]
       filp_open+0x104/0x144 fs/open.c:1278
       do_coredump+0xd98/0x10a0 fs/coredump.c:697
       get_signal+0x7c4/0xb40 kernel/signal.c:2843
       do_signal+0xd4/0x438 arch/arm64/kernel/signal.c:1071
       do_notify_resume+0xc0/0x1f0 arch/arm64/kernel/signal.c:1124
       prepare_exit_to_user_mode arch/arm64/kernel/entry-common.c:137 [inline]
       exit_to_user_mode arch/arm64/kernel/entry-common.c:142 [inline]
       el0_da+0xb8/0x16c arch/arm64/kernel/entry-common.c:515
       el0t_64_sync_handler+0xcc/0xf0 arch/arm64/kernel/entry-common.c:657
       el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581

-> #0 (&dquot->dq_lock){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3095 [inline]
       check_prevs_add kernel/locking/lockdep.c:3214 [inline]
       validate_chain kernel/locking/lockdep.c:3829 [inline]
       __lock_acquire+0x1530/0x30a4 kernel/locking/lockdep.c:5053
       lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5666
       __mutex_lock_common+0xd4/0xca8 kernel/locking/mutex.c:603
       __mutex_lock kernel/locking/mutex.c:747 [inline]
       mutex_lock_nested+0x38/0x44 kernel/locking/mutex.c:799
       dquot_commit+0x34/0x1e4 fs/quota/dquot.c:479
       ext4_write_dquot fs/ext4/super.c:6596 [inline]
       ext4_mark_dquot_dirty+0xdc/0x148 fs/ext4/super.c:6644
       mark_dquot_dirty fs/quota/dquot.c:346 [inline]
       mark_all_dquot_dirty fs/quota/dquot.c:384 [inline]
       __dquot_alloc_space+0x2a8/0x644 fs/quota/dquot.c:1722
       dquot_alloc_space_nodirty include/linux/quotaops.h:300 [inline]
       dquot_alloc_space include/linux/quotaops.h:313 [inline]
       dquot_alloc_block include/linux/quotaops.h:337 [inline]
       ext4_mb_new_blocks+0x5fc/0x9e4 fs/ext4/mballoc.c:5574
       ext4_ext_map_blocks+0x7d8/0x10a0 fs/ext4/extents.c:4285
       ext4_map_blocks+0x4a8/0xaec fs/ext4/inode.c:645
       _ext4_get_block+0xb4/0x248 fs/ext4/inode.c:802
       ext4_get_block+0x4c/0x60 fs/ext4/inode.c:819
       ext4_block_write_begin+0x2d8/0x112c fs/ext4/inode.c:1092
       ext4_write_begin+0x21c/0xc38
       ext4_da_write_begin+0x1ac/0x4d0 fs/ext4/inode.c:2972
       generic_perform_write+0xf0/0x2cc mm/filemap.c:3738
       ext4_buffered_write_iter+0x15c/0x294 fs/ext4/file.c:270
       ext4_file_write_iter+0x544/0xc6c
       __kernel_write+0x128/0x2cc fs/read_write.c:523
       __dump_emit fs/coredump.c:805 [inline]
       dump_emit+0x210/0x4d4 fs/coredump.c:842
       elf_core_dump+0x111c/0x16dc fs/binfmt_elf.c:2263
       do_coredump+0x91c/0x10a0 fs/coredump.c:756
       get_signal+0x7c4/0xb40 kernel/signal.c:2843
       do_signal+0xd4/0x438 arch/arm64/kernel/signal.c:1071
       do_notify_resume+0xc0/0x1f0 arch/arm64/kernel/signal.c:1124
       prepare_exit_to_user_mode arch/arm64/kernel/entry-common.c:137 [inline]
       exit_to_user_mode arch/arm64/kernel/entry-common.c:142 [inline]
       el0_da+0xb8/0x16c arch/arm64/kernel/entry-common.c:515
       el0t_64_sync_handler+0xcc/0xf0 arch/arm64/kernel/entry-common.c:657
       el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581

other info that might help us debug this:

Chain exists of:
  &dquot->dq_lock --> &s->s_dquot.dqio_sem --> &ei->i_data_sem/2

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&ei->i_data_sem/2);
                               lock(&s->s_dquot.dqio_sem);
                               lock(&ei->i_data_sem/2);
  lock(&dquot->dq_lock);

 *** DEADLOCK ***

4 locks held by syz-executor252/3082:
 #0: ffff0000cd8a1460 (sb_writers#3){.+.+}-{0:0}, at: do_coredump+0x910/0x10a0 fs/coredump.c:755
 #1: ffff0000ca4f8d90 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:756 [inline]
 #1: ffff0000ca4f8d90 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_buffered_write_iter+0x50/0x294 fs/ext4/file.c:264
 #2: ffff0000ca4f8c18 (&ei->i_data_sem/2){++++}-{3:3}, at: ext4_map_blocks+0x444/0xaec fs/ext4/inode.c:638
 #3: ffff80000d47ee98 (dquot_srcu){....}-{0:0}, at: rcu_lock_acquire+0x10/0x4c include/linux/rcupdate.h:279

stack backtrace:
CPU: 0 PID: 3082 Comm: syz-executor252 Not tainted 6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0
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
 __mutex_lock_common+0xd4/0xca8 kernel/locking/mutex.c:603
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x38/0x44 kernel/locking/mutex.c:799
 dquot_commit+0x34/0x1e4 fs/quota/dquot.c:479
 ext4_write_dquot fs/ext4/super.c:6596 [inline]
 ext4_mark_dquot_dirty+0xdc/0x148 fs/ext4/super.c:6644
 mark_dquot_dirty fs/quota/dquot.c:346 [inline]
 mark_all_dquot_dirty fs/quota/dquot.c:384 [inline]
 __dquot_alloc_space+0x2a8/0x644 fs/quota/dquot.c:1722
 dquot_alloc_space_nodirty include/linux/quotaops.h:300 [inline]
 dquot_alloc_space include/linux/quotaops.h:313 [inline]
 dquot_alloc_block include/linux/quotaops.h:337 [inline]
 ext4_mb_new_blocks+0x5fc/0x9e4 fs/ext4/mballoc.c:5574
 ext4_ext_map_blocks+0x7d8/0x10a0 fs/ext4/extents.c:4285
 ext4_map_blocks+0x4a8/0xaec fs/ext4/inode.c:645
 _ext4_get_block+0xb4/0x248 fs/ext4/inode.c:802
 ext4_get_block+0x4c/0x60 fs/ext4/inode.c:819
 ext4_block_write_begin+0x2d8/0x112c fs/ext4/inode.c:1092
 ext4_write_begin+0x21c/0xc38
 ext4_da_write_begin+0x1ac/0x4d0 fs/ext4/inode.c:2972
 generic_perform_write+0xf0/0x2cc mm/filemap.c:3738
 ext4_buffered_write_iter+0x15c/0x294 fs/ext4/file.c:270
 ext4_file_write_iter+0x544/0xc6c
 __kernel_write+0x128/0x2cc fs/read_write.c:523
 __dump_emit fs/coredump.c:805 [inline]
 dump_emit+0x210/0x4d4 fs/coredump.c:842
 elf_core_dump+0x111c/0x16dc fs/binfmt_elf.c:2263
 do_coredump+0x91c/0x10a0 fs/coredump.c:756
 get_signal+0x7c4/0xb40 kernel/signal.c:2843
 do_signal+0xd4/0x438 arch/arm64/kernel/signal.c:1071
 do_notify_resume+0xc0/0x1f0 arch/arm64/kernel/signal.c:1124
 prepare_exit_to_user_mode arch/arm64/kernel/entry-common.c:137 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:142 [inline]
 el0_da+0xb8/0x16c arch/arm64/kernel/entry-common.c:515
 el0t_64_sync_handler+0xcc/0xf0 arch/arm64/kernel/entry-common.c:657
 el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581
EXT4-fs (loop0): unmounting filesystem.

