Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE10644908
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 17:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235028AbiLFQSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 11:18:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235070AbiLFQRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 11:17:33 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6CA2F3A2
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 08:13:57 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id c20-20020a5d9754000000b006dbd4e6a5abso12055475ioo.17
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 08:13:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lhw81hNB5WiCNETfCUyp1zKp8L5SvzG8ToCAjsGkMhE=;
        b=QTlCTWRRXKeyP4PszFvx1fB/JmRrR6TPux7iXJeiNzrR0rE7d+FmpARrS9mmznStQI
         Tyv29jS02EYl5gLOVMK8/aEiy2FPfGyb0r3xGRDMZ4KNw0sU6V5rEk5HOh5cgvpD0mqw
         XMoQ03Cz+CrIP/fKI4D7XFoIzGvwfYwx8lz3lfXjfxrf+G9I9SxmeQXgISCTNqoi9WcV
         E68OZGrLLXkJw7quuq1VdWRyuxDUu7I+4ve3lES0qRSHVXV/Nv7SnFXDxPIVrpinyRBg
         CxkEpDfiGwNDYLwe3ehmiplEssvrpaS8AnZw1NSLKnJF4EE7GFeYkYP9joKOOjvVHcm4
         X0xA==
X-Gm-Message-State: ANoB5pkt5UmFaomTIflo6kxcR/fdZLdN4ESVbxLdThoslFqz5xF0nNnD
        UeSNB12cfsFdPX6xaPh5XOOc+cUJFxusf5/IIF8vDc3FS0tq
X-Google-Smtp-Source: AA0mqf7D4ialz2qyef+dthnAsk3+pSdzU5U+7a18vHygpVbB0i4IwdHxWdXnxLdIgMC0nfNAaCcMsrwSrxCl+43jLszd4mKl+/Ld
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1008:b0:300:5bd2:5af4 with SMTP id
 n8-20020a056e02100800b003005bd25af4mr31193944ilj.244.1670343236521; Tue, 06
 Dec 2022 08:13:56 -0800 (PST)
Date:   Tue, 06 Dec 2022 08:13:56 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000044198805ef2b17cb@google.com>
Subject: [syzbot] possible deadlock in fs_reclaim_acquire (4)
From:   syzbot <syzbot+9b9bbfea68487857fb9c@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, reiserfs-devel@vger.kernel.org,
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

syzbot found the following issue on:

HEAD commit:    a4412fdd49dc error-injection: Add prompt for function erro..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1418c55b880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4aa2a38f1d88bd1c
dashboard link: https://syzkaller.appspot.com/bug?extid=9b9bbfea68487857fb9c
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9b9bbfea68487857fb9c@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.1.0-rc7-syzkaller-00123-ga4412fdd49dc #0 Not tainted
------------------------------------------------------
klogd/3144 is trying to acquire lock:
ffff88801ef6d090 (&sbi->lock){+.+.}-{3:3}, at: reiserfs_write_lock+0x79/0x100 fs/reiserfs/lock.c:27

but task is already holding lock:
ffffffff8c6c9a40 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim mm/page_alloc.c:4755 [inline]
ffffffff8c6c9a40 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_direct_reclaim mm/page_alloc.c:4780 [inline]
ffffffff8c6c9a40 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_slowpath.constprop.0+0x808/0x23d0 mm/page_alloc.c:5186

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (fs_reclaim){+.+.}-{0:0}:
       __fs_reclaim_acquire mm/page_alloc.c:4682 [inline]
       fs_reclaim_acquire+0x11d/0x160 mm/page_alloc.c:4696
       might_alloc include/linux/sched/mm.h:271 [inline]
       slab_pre_alloc_hook mm/slab.h:710 [inline]
       slab_alloc_node mm/slab.c:3241 [inline]
       slab_alloc mm/slab.c:3265 [inline]
       __kmem_cache_alloc_lru mm/slab.c:3442 [inline]
       kmem_cache_alloc_lru+0x3e/0x7b0 mm/slab.c:3468
       __d_alloc+0x32/0x980 fs/dcache.c:1769
       d_alloc_anon fs/dcache.c:1868 [inline]
       d_make_root+0x49/0x110 fs/dcache.c:2069
       reiserfs_fill_super+0x12eb/0x2e90 fs/reiserfs/super.c:2083
       mount_bdev+0x351/0x410 fs/super.c:1401
       legacy_get_tree+0x109/0x220 fs/fs_context.c:610
       vfs_get_tree+0x8d/0x2f0 fs/super.c:1531
       do_new_mount fs/namespace.c:3040 [inline]
       path_mount+0x132a/0x1e20 fs/namespace.c:3370
       do_mount fs/namespace.c:3383 [inline]
       __do_sys_mount fs/namespace.c:3591 [inline]
       __se_sys_mount fs/namespace.c:3568 [inline]
       __x64_sys_mount+0x283/0x300 fs/namespace.c:3568
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (&sbi->lock){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3097 [inline]
       check_prevs_add kernel/locking/lockdep.c:3216 [inline]
       validate_chain kernel/locking/lockdep.c:3831 [inline]
       __lock_acquire+0x2a43/0x56d0 kernel/locking/lockdep.c:5055
       lock_acquire kernel/locking/lockdep.c:5668 [inline]
       lock_acquire+0x1e3/0x630 kernel/locking/lockdep.c:5633
       __mutex_lock_common kernel/locking/mutex.c:603 [inline]
       __mutex_lock+0x12f/0x1360 kernel/locking/mutex.c:747
       reiserfs_write_lock+0x79/0x100 fs/reiserfs/lock.c:27
       reiserfs_dirty_inode+0xd2/0x260 fs/reiserfs/super.c:704
       __mark_inode_dirty+0x247/0x11e0 fs/fs-writeback.c:2408
       mark_inode_dirty_sync include/linux/fs.h:2480 [inline]
       iput.part.0+0x57/0x880 fs/inode.c:1770
       iput+0x5c/0x80 fs/inode.c:1763
       dentry_unlink_inode+0x2b1/0x460 fs/dcache.c:401
       __dentry_kill+0x3c0/0x640 fs/dcache.c:607
       shrink_dentry_list+0x240/0x800 fs/dcache.c:1201
       prune_dcache_sb+0xeb/0x150 fs/dcache.c:1282
       super_cache_scan+0x33a/0x590 fs/super.c:104
       do_shrink_slab+0x464/0xce0 mm/vmscan.c:842
       shrink_slab_memcg mm/vmscan.c:911 [inline]
       shrink_slab+0x388/0x660 mm/vmscan.c:990
       shrink_node_memcgs mm/vmscan.c:6112 [inline]
       shrink_node+0x93d/0x1f30 mm/vmscan.c:6141
       shrink_zones mm/vmscan.c:6379 [inline]
       do_try_to_free_pages+0x3b4/0x17a0 mm/vmscan.c:6441
       try_to_free_pages+0x2e5/0x960 mm/vmscan.c:6676
       __perform_reclaim mm/page_alloc.c:4758 [inline]
       __alloc_pages_direct_reclaim mm/page_alloc.c:4780 [inline]
       __alloc_pages_slowpath.constprop.0+0x8b6/0x23d0 mm/page_alloc.c:5186
       __alloc_pages+0x4aa/0x5b0 mm/page_alloc.c:5571
       alloc_pages+0x1aa/0x270 mm/mempolicy.c:2285
       folio_alloc+0x20/0x70 mm/mempolicy.c:2295
       filemap_alloc_folio+0x30a/0x3a0 mm/filemap.c:971
       __filemap_get_folio+0x32c/0xd90 mm/filemap.c:1965
       filemap_fault+0x15aa/0x2400 mm/filemap.c:3145
       __do_fault+0x107/0x600 mm/memory.c:4203
       do_read_fault mm/memory.c:4554 [inline]
       do_fault mm/memory.c:4683 [inline]
       handle_pte_fault mm/memory.c:4955 [inline]
       __handle_mm_fault+0x2184/0x3a40 mm/memory.c:5097
       handle_mm_fault+0x1cc/0x780 mm/memory.c:5218
       do_user_addr_fault+0x475/0x1210 arch/x86/mm/fault.c:1428
       handle_page_fault arch/x86/mm/fault.c:1519 [inline]
       exc_page_fault+0x98/0x170 arch/x86/mm/fault.c:1575
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(fs_reclaim);
                               lock(&sbi->lock);
                               lock(fs_reclaim);
  lock(&sbi->lock);

 *** DEADLOCK ***

4 locks held by klogd/3144:
 #0: ffff8880210a28a0 (mapping.invalidate_lock){++++}-{3:3}, at: filemap_invalidate_lock_shared include/linux/fs.h:811 [inline]
 #0: ffff8880210a28a0 (mapping.invalidate_lock){++++}-{3:3}, at: filemap_fault+0x1564/0x2400 mm/filemap.c:3142
 #1: ffffffff8c6c9a40 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim mm/page_alloc.c:4755 [inline]
 #1: ffffffff8c6c9a40 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_direct_reclaim mm/page_alloc.c:4780 [inline]
 #1: ffffffff8c6c9a40 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_slowpath.constprop.0+0x808/0x23d0 mm/page_alloc.c:5186
 #2: ffffffff8c688470 (shrinker_rwsem){++++}-{3:3}, at: shrink_slab_memcg mm/vmscan.c:884 [inline]
 #2: ffffffff8c688470 (shrinker_rwsem){++++}-{3:3}, at: shrink_slab+0x2a0/0x660 mm/vmscan.c:990
 #3: ffff88801c1200e0 (&type->s_umount_key#63){++++}-{3:3}, at: trylock_super fs/super.c:415 [inline]
 #3: ffff88801c1200e0 (&type->s_umount_key#63){++++}-{3:3}, at: super_cache_scan+0x70/0x590 fs/super.c:79

stack backtrace:
CPU: 2 PID: 3144 Comm: klogd Not tainted 6.1.0-rc7-syzkaller-00123-ga4412fdd49dc #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd1/0x138 lib/dump_stack.c:106
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2177
 check_prev_add kernel/locking/lockdep.c:3097 [inline]
 check_prevs_add kernel/locking/lockdep.c:3216 [inline]
 validate_chain kernel/locking/lockdep.c:3831 [inline]
 __lock_acquire+0x2a43/0x56d0 kernel/locking/lockdep.c:5055
 lock_acquire kernel/locking/lockdep.c:5668 [inline]
 lock_acquire+0x1e3/0x630 kernel/locking/lockdep.c:5633
 __mutex_lock_common kernel/locking/mutex.c:603 [inline]
 __mutex_lock+0x12f/0x1360 kernel/locking/mutex.c:747
 reiserfs_write_lock+0x79/0x100 fs/reiserfs/lock.c:27
 reiserfs_dirty_inode+0xd2/0x260 fs/reiserfs/super.c:704
 __mark_inode_dirty+0x247/0x11e0 fs/fs-writeback.c:2408
 mark_inode_dirty_sync include/linux/fs.h:2480 [inline]
 iput.part.0+0x57/0x880 fs/inode.c:1770
 iput+0x5c/0x80 fs/inode.c:1763
 dentry_unlink_inode+0x2b1/0x460 fs/dcache.c:401
 __dentry_kill+0x3c0/0x640 fs/dcache.c:607
 shrink_dentry_list+0x240/0x800 fs/dcache.c:1201
 prune_dcache_sb+0xeb/0x150 fs/dcache.c:1282
 super_cache_scan+0x33a/0x590 fs/super.c:104
 do_shrink_slab+0x464/0xce0 mm/vmscan.c:842
 shrink_slab_memcg mm/vmscan.c:911 [inline]
 shrink_slab+0x388/0x660 mm/vmscan.c:990
 shrink_node_memcgs mm/vmscan.c:6112 [inline]
 shrink_node+0x93d/0x1f30 mm/vmscan.c:6141
 shrink_zones mm/vmscan.c:6379 [inline]
 do_try_to_free_pages+0x3b4/0x17a0 mm/vmscan.c:6441
 try_to_free_pages+0x2e5/0x960 mm/vmscan.c:6676
 __perform_reclaim mm/page_alloc.c:4758 [inline]
 __alloc_pages_direct_reclaim mm/page_alloc.c:4780 [inline]
 __alloc_pages_slowpath.constprop.0+0x8b6/0x23d0 mm/page_alloc.c:5186
 __alloc_pages+0x4aa/0x5b0 mm/page_alloc.c:5571
 alloc_pages+0x1aa/0x270 mm/mempolicy.c:2285
 folio_alloc+0x20/0x70 mm/mempolicy.c:2295
 filemap_alloc_folio+0x30a/0x3a0 mm/filemap.c:971
 __filemap_get_folio+0x32c/0xd90 mm/filemap.c:1965
 filemap_fault+0x15aa/0x2400 mm/filemap.c:3145
 __do_fault+0x107/0x600 mm/memory.c:4203
 do_read_fault mm/memory.c:4554 [inline]
 do_fault mm/memory.c:4683 [inline]
 handle_pte_fault mm/memory.c:4955 [inline]
 __handle_mm_fault+0x2184/0x3a40 mm/memory.c:5097
 handle_mm_fault+0x1cc/0x780 mm/memory.c:5218
 do_user_addr_fault+0x475/0x1210 arch/x86/mm/fault.c:1428
 handle_page_fault arch/x86/mm/fault.c:1519 [inline]
 exc_page_fault+0x98/0x170 arch/x86/mm/fault.c:1575
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0033:0x7fb9df1a0df1
Code: Unable to access opcode bytes at 0x7fb9df1a0dc7.
RSP: 002b:00007ffd6af99d40 EFLAGS: 00010206
RAX: 0000000000000003 RBX: 0000000000000000 RCX: 0000000000000006
RDX: 00007fb9df2626c6 RSI: 00007fb9df26423e RDI: 00007fb9df2626c6
RBP: 0000559d3192c2e4 R08: 0000000000000001 R09: 00007ffd6af99e5f
R10: 0000000000000000 R11: 0000559d3192c2e4 R12: 00000000ffffffff
R13: 0000000000000000 R14: 00007fb9df26423e R15: 0000000000000000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
