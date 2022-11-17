Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1935A62DE1B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 15:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240083AbiKQO37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 09:29:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240036AbiKQO3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 09:29:38 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2F12AC74
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 06:29:36 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id j20-20020a056e02219400b00300a22a7fe0so1298946ila.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 06:29:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hpqS9S+SX6aP7ADJXRvU7UOnqyvT8C0tBlLCj5pahYQ=;
        b=3b9N/hnMaGnv354FxvDUj/dsvEcLHbgwHvTAhXOo2fDnbSJtgK7YgaPMmuXQ7Wx+To
         EeTEiIhQpudJkH5dpq6/QbOmRWtpl9hkM49Wm+EcY3Yx0FIMPeHi5IscL/rrIQJ6Kb2E
         cubWw1M8mPyetlbFbCf6Peg1cZUQK0YKo8idL1xTDI4HivDa6jQVXk+jivpueUEmqnm4
         vCHw7AWiqqAugdRuvT1YCMJG/HRT5KqP0Lbv9qsAsBHQGtvQMRKu6ubArXPHsgP348ag
         ErMwhRgMf6AS7ZVwtE2Hh4ua0yy6l3NIaWi2aMp130TYD8RqBK/N+DLI9k2kAPBoSyTM
         ufpw==
X-Gm-Message-State: ANoB5pnVxc3SRo37ALgEwKcrjGLDX4iIM+vF1P0lZ/DUDEXaPFvpgaJH
        vc2cLQ+X4lfP8K4QK+3SIJHcGQ09KM3HbK6g1WT7aD2uNDuW
X-Google-Smtp-Source: AA0mqf487YSqiI2fmUDr91c2ZAh8FHslgdhFd76XF8DsiF8KTdy10rp0nQkt3aXBycQOPRTJdbkPHtVlVFLisCKEFQ/8y1VCjTzt
MIME-Version: 1.0
X-Received: by 2002:a02:3501:0:b0:363:accc:d7e5 with SMTP id
 k1-20020a023501000000b00363acccd7e5mr1173396jaa.34.1668695376199; Thu, 17 Nov
 2022 06:29:36 -0800 (PST)
Date:   Thu, 17 Nov 2022 06:29:36 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000230bea05edab6ba5@google.com>
Subject: [syzbot] possible deadlock in nilfs_bmap_clear
From:   syzbot <syzbot+4a885c3a7a60d6be3583@syzkaller.appspotmail.com>
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

HEAD commit:    cc675d22e422 Merge tag 'for-linus-6.1-rc6-tag' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16d91101880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=378c11a9ed9a0efe
dashboard link: https://syzkaller.appspot.com/bug?extid=4a885c3a7a60d6be3583
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/380daf81802f/disk-cc675d22.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5dc8149b5d8c/vmlinux-cc675d22.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3595cfb45f6c/bzImage-cc675d22.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4a885c3a7a60d6be3583@syzkaller.appspotmail.com

============================================
WARNING: possible recursive locking detected
6.1.0-rc5-syzkaller-00044-gcc675d22e422 #0 Not tainted
--------------------------------------------
syz-executor.4/18478 is trying to acquire lock:
ffff888076ad93f8 (&bmap->b_sem){++++}-{3:3}, at: nilfs_bmap_clear+0x25/0x90 fs/nilfs2/bmap.c:311

but task is already holding lock:
ffff88808d5900c0 (&bmap->b_sem){++++}-{3:3}, at: nilfs_bmap_insert+0x9d/0x390 fs/nilfs2/bmap.c:146

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&bmap->b_sem);
  lock(&bmap->b_sem);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

7 locks held by syz-executor.4/18478:
 #0: ffff8880824a0460 (sb_writers#30){.+.+}-{0:0}, at: do_sendfile+0x61c/0xfd0 fs/read_write.c:1254
 #1: ffff88808d5902a8 (&sb->s_type->i_mutex_key#37){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:756 [inline]
 #1: ffff88808d5902a8 (&sb->s_type->i_mutex_key#37){+.+.}-{3:3}, at: generic_file_write_iter+0x7f/0x310 mm/filemap.c:3910
 #2: ffff8880824a0650 (sb_internal#3){.+.+}-{0:0}, at: nilfs_write_begin+0x6c/0x110 fs/nilfs2/inode.c:256
 #3: ffff8880855592a0 (&nilfs->ns_segctor_sem){++++}-{3:3}, at: nilfs_transaction_begin+0x359/0x770 fs/nilfs2/segment.c:223
 #4: ffff88808d5900c0 (&bmap->b_sem){++++}-{3:3}, at: nilfs_bmap_insert+0x9d/0x390 fs/nilfs2/bmap.c:146
 #5: ffffffff8d3d0d10 (shrinker_rwsem){++++}-{3:3}, at: shrink_slab_memcg+0xd9/0x630 mm/vmscan.c:884
 #6: ffff8880824a00e0 (&type->s_umount_key#106){++++}-{3:3}, at: trylock_super fs/super.c:415 [inline]
 #6: ffff8880824a00e0 (&type->s_umount_key#106){++++}-{3:3}, at: super_cache_scan+0x6a/0x470 fs/super.c:79

stack backtrace:
CPU: 1 PID: 18478 Comm: syz-executor.4 Not tainted 6.1.0-rc5-syzkaller-00044-gcc675d22e422 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e3/0x2cb lib/dump_stack.c:106
 print_deadlock_bug kernel/locking/lockdep.c:2990 [inline]
 check_deadlock kernel/locking/lockdep.c:3033 [inline]
 validate_chain+0x4721/0x6470 kernel/locking/lockdep.c:3818
 __lock_acquire+0x1292/0x1f60 kernel/locking/lockdep.c:5055
 lock_acquire+0x1a7/0x400 kernel/locking/lockdep.c:5668
 down_write+0x9c/0x270 kernel/locking/rwsem.c:1562
 nilfs_bmap_clear+0x25/0x90 fs/nilfs2/bmap.c:311
 nilfs_clear_inode+0x161/0x2c0 fs/nilfs2/inode.c:906
 nilfs_evict_inode+0xf9/0x3e0 fs/nilfs2/inode.c:925
 evict+0x2a4/0x620 fs/inode.c:664
 dispose_list fs/inode.c:697 [inline]
 prune_icache_sb+0x268/0x320 fs/inode.c:896
 super_cache_scan+0x362/0x470 fs/super.c:106
 do_shrink_slab+0x4e1/0xa00 mm/vmscan.c:842
 shrink_slab_memcg+0x2ec/0x630 mm/vmscan.c:911
 shrink_slab+0xbe/0x340 mm/vmscan.c:990
 shrink_node_memcgs+0x3c3/0x770 mm/vmscan.c:6076
 shrink_node+0x299/0x1050 mm/vmscan.c:6105
 shrink_zones+0x4fb/0xc40 mm/vmscan.c:6343
 do_try_to_free_pages+0x215/0xcd0 mm/vmscan.c:6405
 try_to_free_mem_cgroup_pages+0x3cb/0x6d0 mm/vmscan.c:6720
 reclaim_high+0x1f4/0x280 mm/memcontrol.c:2389
 mem_cgroup_handle_over_high+0x145/0x2b0 mm/memcontrol.c:2574
 try_charge_memcg+0xfed/0x11f0 mm/memcontrol.c:2812
 try_charge mm/memcontrol.c:2823 [inline]
 charge_memcg+0x132/0x620 mm/memcontrol.c:6879
 __mem_cgroup_charge+0x23/0x80 mm/memcontrol.c:6900
 mem_cgroup_charge include/linux/memcontrol.h:667 [inline]
 __filemap_add_folio+0x3f6/0x1a60 mm/filemap.c:852
 filemap_add_folio+0x12c/0x5c0 mm/filemap.c:934
 __filemap_get_folio+0x93c/0x1240 mm/filemap.c:1976
 pagecache_get_page+0x28/0x260 mm/folio-compat.c:110
 find_or_create_page include/linux/pagemap.h:613 [inline]
 grab_cache_page include/linux/pagemap.h:743 [inline]
 nilfs_grab_buffer+0xab/0x550 fs/nilfs2/page.c:57
 nilfs_btnode_create_block+0x4b/0x340 fs/nilfs2/btnode.c:52
 nilfs_btree_get_new_block fs/nilfs2/btree.c:65 [inline]
 nilfs_btree_prepare_insert fs/nilfs2/btree.c:1130 [inline]
 nilfs_btree_insert+0xd22/0x1c30 fs/nilfs2/btree.c:1238
 nilfs_bmap_do_insert fs/nilfs2/bmap.c:121 [inline]
 nilfs_bmap_insert+0x23b/0x390 fs/nilfs2/bmap.c:147
 nilfs_get_block+0x423/0x8e0 fs/nilfs2/inode.c:101
 __block_write_begin_int+0x57c/0x1ae0 fs/buffer.c:1991
 __block_write_begin fs/buffer.c:2041 [inline]
 block_write_begin+0x93/0x1e0 fs/buffer.c:2102
 nilfs_write_begin+0x9c/0x110 fs/nilfs2/inode.c:261
 generic_perform_write+0x314/0x610 mm/filemap.c:3753
 __generic_file_write_iter+0x29b/0x400 mm/filemap.c:3849
 generic_file_write_iter+0xab/0x310 mm/filemap.c:3913
 do_iter_write+0x6f0/0xc50 fs/read_write.c:861
 iter_file_splice_write+0x830/0xff0 fs/splice.c:686
 do_splice_from fs/splice.c:764 [inline]
 direct_splice_actor+0xe6/0x1c0 fs/splice.c:931
 splice_direct_to_actor+0x4e4/0xc00 fs/splice.c:886
 do_splice_direct+0x2a0/0x3f0 fs/splice.c:974
 do_sendfile+0x641/0xfd0 fs/read_write.c:1255
 __do_sys_sendfile64 fs/read_write.c:1323 [inline]
 __se_sys_sendfile64+0x178/0x1e0 fs/read_write.c:1309
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f74c308b639
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f74c3e97168 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f74c31ac050 RCX: 00007f74c308b639
RDX: 0000000000000000 RSI: 0000000000000003 RDI: 0000000000000004
RBP: 00007f74c30e6ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000f03affff R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe3045508f R14: 00007f74c3e97300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
