Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5024162FF00
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 21:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbiKRUtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 15:49:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiKRUtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 15:49:52 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC05E6EB78
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 12:49:50 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id q6-20020a056e020c2600b00302664fc72cso4023867ilg.14
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 12:49:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vjnhenvie0zObLdwhT12BKLnuhGXTRgNA6SSOS/rCgg=;
        b=qKPrk94wYSUKfPwxN2YeDMPOa9EIg+7vk4g/8EQnQHZFHDZIJjjPmYHd4mxze14NF7
         Evo2HlmWMWrOX9i4WjzzBfTbG7cNXUq0FXDopRxYuwkVp3YFAO21Vr0QS2kJdvpwGVtq
         cGgt0N/k1aetOdtlaauDBz4hQH2QbsN1IDRKtpEYFuwLQ/mqAhUQCM70u9cMsJfdKW4Z
         u2v9vv2sEZ7+ZQDD1SiIdyp5r61NYnkE3MgXjq7/pzkEKdFru0cc4FOGieG5fQyMhYES
         B5T6IH+v5bc/hpnjtRJOv+B7v4E17H18jENAe/VvAoStuZmUn3ctqlPM9wJ7YGZSoTXM
         zuTQ==
X-Gm-Message-State: ANoB5pmGC+KCnx59VnDvCjF/YtqGXLIjiWCBIp6WnoTsTUIuJPmEqiII
        v0Bt4HB6Ymc9b0AYIM4Fb/M/xdapQGSHQ+69SQpdySKVG/3S
X-Google-Smtp-Source: AA0mqf5Try25wHQfNygf6wD0UaIhuITGgZsq57pUwpDBBEPqQdPbHPygXiXdn0tODuycfQXfn4cyf1Rmy9ybjIKwsmuexFOROqwo
MIME-Version: 1.0
X-Received: by 2002:a02:5146:0:b0:371:1431:d4f2 with SMTP id
 s67-20020a025146000000b003711431d4f2mr4026528jaa.184.1668804590223; Fri, 18
 Nov 2022 12:49:50 -0800 (PST)
Date:   Fri, 18 Nov 2022 12:49:50 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ccc93c05edc4d8cf@google.com>
Subject: [syzbot] possible deadlock in __btrfs_release_delayed_node
From:   syzbot <syzbot+9b7c21f486f5e7f8d029@syzkaller.appspotmail.com>
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

Hello,

syzbot found the following issue on:

HEAD commit:    15f3bff12cf6 Add linux-next specific files for 20221116
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=131d1d31880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ec2a1d4f50866178
dashboard link: https://syzkaller.appspot.com/bug?extid=9b7c21f486f5e7f8d029
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b67307c8c3c9/disk-15f3bff1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/956c7b56c5c1/vmlinux-15f3bff1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/505ae2f65529/bzImage-15f3bff1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9b7c21f486f5e7f8d029@syzkaller.appspotmail.com

BTRFS info (device loop1): auto enabling async discard
======================================================
WARNING: possible circular locking dependency detected
6.1.0-rc5-next-20221116-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor.1/16154 is trying to acquire lock:
ffff88807e3084a0 (&delayed_node->mutex){+.+.}-{3:3}, at: __btrfs_release_delayed_node.part.0+0xa1/0xf30 fs/btrfs/delayed-inode.c:256

but task is already holding lock:
ffff88807df33078 (btrfs-log-00){++++}-{3:3}, at: __btrfs_tree_lock+0x32/0x3d0 fs/btrfs/locking.c:197

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (btrfs-log-00){++++}-{3:3}:
       down_read_nested+0x9e/0x450 kernel/locking/rwsem.c:1634
       __btrfs_tree_read_lock+0x32/0x350 fs/btrfs/locking.c:135
       btrfs_tree_read_lock fs/btrfs/locking.c:141 [inline]
       btrfs_read_lock_root_node+0x82/0x3a0 fs/btrfs/locking.c:280
       btrfs_search_slot_get_root fs/btrfs/ctree.c:1678 [inline]
       btrfs_search_slot+0x3ca/0x2c70 fs/btrfs/ctree.c:1998
       btrfs_lookup_csum+0x116/0x3f0 fs/btrfs/file-item.c:209
       btrfs_csum_file_blocks+0x40e/0x1370 fs/btrfs/file-item.c:1021
       log_csums.isra.0+0x244/0x2d0 fs/btrfs/tree-log.c:4258
       copy_items.isra.0+0xbfb/0xed0 fs/btrfs/tree-log.c:4403
       copy_inode_items_to_log+0x13d6/0x1d90 fs/btrfs/tree-log.c:5873
       btrfs_log_inode+0xb19/0x4680 fs/btrfs/tree-log.c:6495
       btrfs_log_inode_parent+0x890/0x2a20 fs/btrfs/tree-log.c:6982
       btrfs_log_dentry_safe+0x59/0x80 fs/btrfs/tree-log.c:7083
       btrfs_sync_file+0xa41/0x13c0 fs/btrfs/file.c:1921
       vfs_fsync_range+0x13e/0x230 fs/sync.c:188
       generic_write_sync include/linux/fs.h:2856 [inline]
       iomap_dio_complete+0x73a/0x920 fs/iomap/direct-io.c:128
       btrfs_direct_write fs/btrfs/file.c:1536 [inline]
       btrfs_do_write_iter+0xba2/0x1470 fs/btrfs/file.c:1668
       call_write_iter include/linux/fs.h:2160 [inline]
       do_iter_readv_writev+0x20b/0x3b0 fs/read_write.c:735
       do_iter_write+0x182/0x700 fs/read_write.c:861
       vfs_iter_write+0x74/0xa0 fs/read_write.c:902
       iter_file_splice_write+0x745/0xc90 fs/splice.c:686
       do_splice_from fs/splice.c:764 [inline]
       direct_splice_actor+0x114/0x180 fs/splice.c:931
       splice_direct_to_actor+0x335/0x8a0 fs/splice.c:886
       do_splice_direct+0x1ab/0x280 fs/splice.c:974
       do_sendfile+0xb19/0x1270 fs/read_write.c:1255
       __do_sys_sendfile64 fs/read_write.c:1323 [inline]
       __se_sys_sendfile64 fs/read_write.c:1309 [inline]
       __x64_sys_sendfile64+0x259/0x2c0 fs/read_write.c:1309
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #1 (btrfs-tree-00){++++}-{3:3}:
       __lock_release kernel/locking/lockdep.c:5382 [inline]
       lock_release+0x371/0x810 kernel/locking/lockdep.c:5688
       up_write+0x2a/0x520 kernel/locking/rwsem.c:1614
       btrfs_tree_unlock_rw fs/btrfs/locking.h:189 [inline]
       btrfs_unlock_up_safe+0x1e3/0x290 fs/btrfs/locking.c:238
       search_leaf fs/btrfs/ctree.c:1832 [inline]
       btrfs_search_slot+0x265e/0x2c70 fs/btrfs/ctree.c:2074
       btrfs_insert_empty_items+0xbd/0x1c0 fs/btrfs/ctree.c:4133
       btrfs_insert_delayed_item+0x826/0xfa0 fs/btrfs/delayed-inode.c:746
       btrfs_insert_delayed_items fs/btrfs/delayed-inode.c:824 [inline]
       __btrfs_commit_inode_delayed_items fs/btrfs/delayed-inode.c:1111 [inline]
       __btrfs_run_delayed_items+0x280/0x590 fs/btrfs/delayed-inode.c:1153
       flush_space+0x147/0xe90 fs/btrfs/space-info.c:728
       btrfs_async_reclaim_metadata_space+0x541/0xc10 fs/btrfs/space-info.c:1086
       process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
       worker_thread+0x669/0x1090 kernel/workqueue.c:2436
       kthread+0x2e8/0x3a0 kernel/kthread.c:376
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

-> #0 (&delayed_node->mutex){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3097 [inline]
       check_prevs_add kernel/locking/lockdep.c:3216 [inline]
       validate_chain kernel/locking/lockdep.c:3831 [inline]
       __lock_acquire+0x2a43/0x56d0 kernel/locking/lockdep.c:5055
       lock_acquire kernel/locking/lockdep.c:5668 [inline]
       lock_acquire+0x1e3/0x630 kernel/locking/lockdep.c:5633
       __mutex_lock_common kernel/locking/mutex.c:603 [inline]
       __mutex_lock+0x12f/0x1360 kernel/locking/mutex.c:747
       __btrfs_release_delayed_node.part.0+0xa1/0xf30 fs/btrfs/delayed-inode.c:256
       __btrfs_release_delayed_node fs/btrfs/delayed-inode.c:251 [inline]
       btrfs_release_delayed_node fs/btrfs/delayed-inode.c:281 [inline]
       btrfs_remove_delayed_node+0x52/0x60 fs/btrfs/delayed-inode.c:1285
       btrfs_evict_inode+0x511/0xf30 fs/btrfs/inode.c:5554
       evict+0x2ed/0x6b0 fs/inode.c:664
       dispose_list+0x117/0x1e0 fs/inode.c:697
       prune_icache_sb+0xeb/0x150 fs/inode.c:896
       super_cache_scan+0x391/0x590 fs/super.c:106
       do_shrink_slab+0x464/0xce0 mm/vmscan.c:843
       shrink_slab_memcg mm/vmscan.c:912 [inline]
       shrink_slab+0x388/0x660 mm/vmscan.c:991
       shrink_node_memcgs mm/vmscan.c:6088 [inline]
       shrink_node+0x93d/0x1f30 mm/vmscan.c:6117
       shrink_zones mm/vmscan.c:6355 [inline]
       do_try_to_free_pages+0x3b4/0x17a0 mm/vmscan.c:6417
       try_to_free_mem_cgroup_pages+0x3a4/0xa70 mm/vmscan.c:6732
       reclaim_high.constprop.0+0x182/0x230 mm/memcontrol.c:2393
       mem_cgroup_handle_over_high+0x190/0x520 mm/memcontrol.c:2578
       try_charge_memcg+0xe0c/0x12f0 mm/memcontrol.c:2816
       try_charge mm/memcontrol.c:2827 [inline]
       charge_memcg+0x90/0x3b0 mm/memcontrol.c:6889
       __mem_cgroup_charge+0x2b/0x90 mm/memcontrol.c:6910
       mem_cgroup_charge include/linux/memcontrol.h:667 [inline]
       __filemap_add_folio+0x615/0xf80 mm/filemap.c:852
       filemap_add_folio+0xaf/0x1e0 mm/filemap.c:934
       __filemap_get_folio+0x389/0xd80 mm/filemap.c:1976
       pagecache_get_page+0x2e/0x280 mm/folio-compat.c:104
       find_or_create_page include/linux/pagemap.h:612 [inline]
       alloc_extent_buffer+0x2b9/0x1580 fs/btrfs/extent_io.c:4588
       btrfs_init_new_buffer fs/btrfs/extent-tree.c:4869 [inline]
       btrfs_alloc_tree_block+0x2e1/0x1320 fs/btrfs/extent-tree.c:4988
       __btrfs_cow_block+0x3b2/0x1420 fs/btrfs/ctree.c:440
       btrfs_cow_block+0x2fa/0x950 fs/btrfs/ctree.c:595
       btrfs_search_slot+0x11b0/0x2c70 fs/btrfs/ctree.c:2038
       btrfs_update_root+0xdb/0x630 fs/btrfs/root-tree.c:137
       update_log_root fs/btrfs/tree-log.c:2841 [inline]
       btrfs_sync_log+0xbfb/0x2870 fs/btrfs/tree-log.c:3064
       btrfs_sync_file+0xdb9/0x13c0 fs/btrfs/file.c:1947
       vfs_fsync_range+0x13e/0x230 fs/sync.c:188
       generic_write_sync include/linux/fs.h:2856 [inline]
       iomap_dio_complete+0x73a/0x920 fs/iomap/direct-io.c:128
       btrfs_direct_write fs/btrfs/file.c:1536 [inline]
       btrfs_do_write_iter+0xba2/0x1470 fs/btrfs/file.c:1668
       call_write_iter include/linux/fs.h:2160 [inline]
       do_iter_readv_writev+0x20b/0x3b0 fs/read_write.c:735
       do_iter_write+0x182/0x700 fs/read_write.c:861
       vfs_iter_write+0x74/0xa0 fs/read_write.c:902
       iter_file_splice_write+0x745/0xc90 fs/splice.c:686
       do_splice_from fs/splice.c:764 [inline]
       direct_splice_actor+0x114/0x180 fs/splice.c:931
       splice_direct_to_actor+0x335/0x8a0 fs/splice.c:886
       do_splice_direct+0x1ab/0x280 fs/splice.c:974
       do_sendfile+0xb19/0x1270 fs/read_write.c:1255
       __do_sys_sendfile64 fs/read_write.c:1323 [inline]
       __se_sys_sendfile64 fs/read_write.c:1309 [inline]
       __x64_sys_sendfile64+0x259/0x2c0 fs/read_write.c:1309
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

Chain exists of:
  &delayed_node->mutex --> btrfs-tree-00 --> btrfs-log-00

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(btrfs-log-00);
                               lock(btrfs-tree-00);
                               lock(btrfs-log-00);
  lock(&delayed_node->mutex);

 *** DEADLOCK ***

8 locks held by syz-executor.1/16154:
 #0: ffff88801aa16460 (sb_writers#24){.+.+}-{0:0}, at: __do_sys_sendfile64 fs/read_write.c:1323 [inline]
 #0: ffff88801aa16460 (sb_writers#24){.+.+}-{0:0}, at: __se_sys_sendfile64 fs/read_write.c:1309 [inline]
 #0: ffff88801aa16460 (sb_writers#24){.+.+}-{0:0}, at: __x64_sys_sendfile64+0x259/0x2c0 fs/read_write.c:1309
 #1: ffff88801aa16650 (sb_internal#2){.+.+}-{0:0}, at: btrfs_sync_file+0x9c6/0x13c0 fs/btrfs/file.c:1914
 #2: ffff88807d792318 (btrfs_trans_num_writers){++++}-{0:0}, at: extwriter_counter_inc fs/btrfs/transaction.c:217 [inline]
 #2: ffff88807d792318 (btrfs_trans_num_writers){++++}-{0:0}, at: join_transaction+0x3e0/0x10e0 fs/btrfs/transaction.c:286
 #3: ffff88807d792340 (btrfs_trans_num_extwriters){++++}-{0:0}, at: extwriter_counter_inc fs/btrfs/transaction.c:217 [inline]
 #3: ffff88807d792340 (btrfs_trans_num_extwriters){++++}-{0:0}, at: join_transaction+0x3e0/0x10e0 fs/btrfs/transaction.c:286
 #4: ffff8880764ca3b0 (&root->log_mutex){+.+.}-{3:3}, at: btrfs_sync_log+0x9d4/0x2870 fs/btrfs/tree-log.c:3053
 #5: ffff88807df33078 (btrfs-log-00){++++}-{3:3}, at: __btrfs_tree_lock+0x32/0x3d0 fs/btrfs/locking.c:197
 #6: ffffffff8c88fe10 (shrinker_rwsem){++++}-{3:3}, at: shrink_slab_memcg mm/vmscan.c:885 [inline]
 #6: ffffffff8c88fe10 (shrinker_rwsem){++++}-{3:3}, at: shrink_slab+0x2a0/0x660 mm/vmscan.c:991
 #7: ffff88801aa160e0 (&type->s_umount_key#87){++++}-{3:3}, at: trylock_super fs/super.c:415 [inline]
 #7: ffff88801aa160e0 (&type->s_umount_key#87){++++}-{3:3}, at: super_cache_scan+0x70/0x590 fs/super.c:79

stack backtrace:
CPU: 0 PID: 16154 Comm: syz-executor.1 Not tainted 6.1.0-rc5-next-20221116-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
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
 __btrfs_release_delayed_node.part.0+0xa1/0xf30 fs/btrfs/delayed-inode.c:256
 __btrfs_release_delayed_node fs/btrfs/delayed-inode.c:251 [inline]
 btrfs_release_delayed_node fs/btrfs/delayed-inode.c:281 [inline]
 btrfs_remove_delayed_node+0x52/0x60 fs/btrfs/delayed-inode.c:1285
 btrfs_evict_inode+0x511/0xf30 fs/btrfs/inode.c:5554
 evict+0x2ed/0x6b0 fs/inode.c:664
 dispose_list+0x117/0x1e0 fs/inode.c:697
 prune_icache_sb+0xeb/0x150 fs/inode.c:896
 super_cache_scan+0x391/0x590 fs/super.c:106
 do_shrink_slab+0x464/0xce0 mm/vmscan.c:843
 shrink_slab_memcg mm/vmscan.c:912 [inline]
 shrink_slab+0x388/0x660 mm/vmscan.c:991
 shrink_node_memcgs mm/vmscan.c:6088 [inline]
 shrink_node+0x93d/0x1f30 mm/vmscan.c:6117
 shrink_zones mm/vmscan.c:6355 [inline]
 do_try_to_free_pages+0x3b4/0x17a0 mm/vmscan.c:6417
 try_to_free_mem_cgroup_pages+0x3a4/0xa70 mm/vmscan.c:6732
 reclaim_high.constprop.0+0x182/0x230 mm/memcontrol.c:2393
 mem_cgroup_handle_over_high+0x190/0x520 mm/memcontrol.c:2578
 try_charge_memcg+0xe0c/0x12f0 mm/memcontrol.c:2816
 try_charge mm/memcontrol.c:2827 [inline]
 charge_memcg+0x90/0x3b0 mm/memcontrol.c:6889
 __mem_cgroup_charge+0x2b/0x90 mm/memcontrol.c:6910
 mem_cgroup_charge include/linux/memcontrol.h:667 [inline]
 __filemap_add_folio+0x615/0xf80 mm/filemap.c:852
 filemap_add_folio+0xaf/0x1e0 mm/filemap.c:934
 __filemap_get_folio+0x389/0xd80 mm/filemap.c:1976
 pagecache_get_page+0x2e/0x280 mm/folio-compat.c:104
 find_or_create_page include/linux/pagemap.h:612 [inline]
 alloc_extent_buffer+0x2b9/0x1580 fs/btrfs/extent_io.c:4588
 btrfs_init_new_buffer fs/btrfs/extent-tree.c:4869 [inline]
 btrfs_alloc_tree_block+0x2e1/0x1320 fs/btrfs/extent-tree.c:4988
 __btrfs_cow_block+0x3b2/0x1420 fs/btrfs/ctree.c:440
 btrfs_cow_block+0x2fa/0x950 fs/btrfs/ctree.c:595
 btrfs_search_slot+0x11b0/0x2c70 fs/btrfs/ctree.c:2038
 btrfs_update_root+0xdb/0x630 fs/btrfs/root-tree.c:137
 update_log_root fs/btrfs/tree-log.c:2841 [inline]
 btrfs_sync_log+0xbfb/0x2870 fs/btrfs/tree-log.c:3064
 btrfs_sync_file+0xdb9/0x13c0 fs/btrfs/file.c:1947
 vfs_fsync_range+0x13e/0x230 fs/sync.c:188
 generic_write_sync include/linux/fs.h:2856 [inline]
 iomap_dio_complete+0x73a/0x920 fs/iomap/direct-io.c:128
 btrfs_direct_write fs/btrfs/file.c:1536 [inline]
 btrfs_do_write_iter+0xba2/0x1470 fs/btrfs/file.c:1668
 call_write_iter include/linux/fs.h:2160 [inline]
 do_iter_readv_writev+0x20b/0x3b0 fs/read_write.c:735
 do_iter_write+0x182/0x700 fs/read_write.c:861
 vfs_iter_write+0x74/0xa0 fs/read_write.c:902
 iter_file_splice_write+0x745/0xc90 fs/splice.c:686
 do_splice_from fs/splice.c:764 [inline]
 direct_splice_actor+0x114/0x180 fs/splice.c:931
 splice_direct_to_actor+0x335/0x8a0 fs/splice.c:886
 do_splice_direct+0x1ab/0x280 fs/splice.c:974
 do_sendfile+0xb19/0x1270 fs/read_write.c:1255
 __do_sys_sendfile64 fs/read_write.c:1323 [inline]
 __se_sys_sendfile64 fs/read_write.c:1309 [inline]
 __x64_sys_sendfile64+0x259/0x2c0 fs/read_write.c:1309
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f0153a8b639
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0154831168 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f0153babf80 RCX: 00007f0153a8b639
RDX: 0000000000000000 RSI: 0000000000000006 RDI: 0000000000000004
RBP: 00007f0153ae6ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 000080001d00c0d0 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffcd009321f R14: 00007f0154831300 R15: 0000000000022000
 </TASK>
syz-executor.1 (16154) used greatest stack depth: 18648 bytes left


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
