Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0AD263A602
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 11:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbiK1KVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 05:21:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbiK1KVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 05:21:40 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9641D1A80D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 02:21:37 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id j20-20020a056e02219400b00300a22a7fe0so8446175ila.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 02:21:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xcHq16J87X/jtzgV+W1u1qxDDHtgTsIdNttbPajzsMU=;
        b=Zm7e6lhzR02+HhZMwv87HzQ3EpJc47lnYuEsBuSxidaAxW32oTZ4AGHIR/SdUm0qhm
         bPgJDi9Q1HXnrn9Jtp10JLqb53kwVJ1VLAN7FREEoPbuMQQwlYVYLIBWLhYgEk9uANLb
         UtDef640+HsZEjRwymmmot4RStdCbZiWb3DGDVkZMYYwGvoQ0jC8i3daYKxShP4Dsvzu
         RKorSnmbZgSobIZvtf8QEFRricBSKhV0I9dvShsTkzcsnmZ1YJLn1whYy370FOGvwSU+
         iwijGbZzuKwa89DRn7flV7Uy49XibAMtnjQZBSgx1C69aBX/LXjYVxI1ntQY2UJWwLWn
         1X4A==
X-Gm-Message-State: ANoB5pmQp644kwXLIWHD1VEd5D44JKHdWYdT9kz02mKz8qimFzCr06B0
        AbdvycXPJkBy9hW2AC4ZVPRpMXmP6wRx5g+rD/rAa4T+8hJJ
X-Google-Smtp-Source: AA0mqf44+XfoHthx6BDXORDne95duUNyqjJzxo59BnyMWGWHXLq3guh+toYpdyyRJcmJ/4tArNMYhlAWO/Asc3AbcxV3nl5m5Vgp
MIME-Version: 1.0
X-Received: by 2002:a92:680f:0:b0:300:e393:34c3 with SMTP id
 d15-20020a92680f000000b00300e39334c3mr21641035ilc.112.1669630896930; Mon, 28
 Nov 2022 02:21:36 -0800 (PST)
Date:   Mon, 28 Nov 2022 02:21:36 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000084862805ee853c4c@google.com>
Subject: [syzbot] KASAN: use-after-free Read in reiserfs_find_actor
From:   syzbot <syzbot+e80d43036932e96e90bd@syzkaller.appspotmail.com>
To:     brauner@kernel.org, damien.lemoal@opensource.wdc.com,
        edward.shishkin@gmail.com, jack@suse.cz, jlayton@kernel.org,
        linuszeng@tencent.com, linux-kernel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    faf68e3523c2 Merge tag 'kbuild-fixes-v6.1-4' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13a257c5880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d01b6e3197974dd
dashboard link: https://syzkaller.appspot.com/bug?extid=e80d43036932e96e90bd
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3bfa6577f378/disk-faf68e35.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7bf0af58cde3/vmlinux-faf68e35.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3e15d7d640b0/bzImage-faf68e35.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e80d43036932e96e90bd@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in reiserfs_find_actor+0xdf/0x100 fs/reiserfs/inode.c:1625
Read of size 4 at addr ffff88803459e8f0 by task syz-executor.1/6406

CPU: 0 PID: 6406 Comm: syz-executor.1 Not tainted 6.1.0-rc6-syzkaller-00315-gfaf68e3523c2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 print_address_description+0x74/0x340 mm/kasan/report.c:284
 print_report+0x107/0x1f0 mm/kasan/report.c:395
 kasan_report+0xcd/0x100 mm/kasan/report.c:495
 reiserfs_find_actor+0xdf/0x100 fs/reiserfs/inode.c:1625
 find_inode+0x1ac/0x4c0 fs/inode.c:915
 inode_insert5+0xf3/0x500 fs/inode.c:1170
 insert_inode_locked4+0x5a/0x90 fs/inode.c:1680
 reiserfs_new_inode+0x4e5/0x1cd0 fs/reiserfs/inode.c:1960
 reiserfs_create+0x39a/0x660 fs/reiserfs/namei.c:668
 lookup_open fs/namei.c:3413 [inline]
 open_last_lookups fs/namei.c:3481 [inline]
 path_openat+0x12d0/0x2df0 fs/namei.c:3711
 do_filp_open+0x264/0x4f0 fs/namei.c:3741
 do_sys_openat2+0x124/0x4e0 fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_openat fs/open.c:1342 [inline]
 __se_sys_openat fs/open.c:1337 [inline]
 __x64_sys_openat+0x243/0x290 fs/open.c:1337
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f6c04c8c0d9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6c059de168 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f6c04dac050 RCX: 00007f6c04c8c0d9
RDX: 000000000000275a RSI: 0000000020000280 RDI: ffffffffffffff9c
RBP: 00007f6c04ce7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd8cc8768f R14: 00007f6c059de300 R15: 0000000000022000
 </TASK>

Allocated by task 30009:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x3d/0x60 mm/kasan/common.c:52
 __kasan_slab_alloc+0x65/0x70 mm/kasan/common.c:325
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slab.h:737 [inline]
 slab_alloc_node mm/slub.c:3398 [inline]
 slab_alloc mm/slub.c:3406 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3413 [inline]
 kmem_cache_alloc_lru+0x180/0x2e0 mm/slub.c:3429
 alloc_inode_sb include/linux/fs.h:3117 [inline]
 f2fs_alloc_inode+0x14d/0x520 fs/f2fs/super.c:1366
 alloc_inode fs/inode.c:259 [inline]
 iget_locked+0x191/0x830 fs/inode.c:1286
 f2fs_iget+0x51/0x4bb0 fs/f2fs/inode.c:505
 f2fs_fill_super+0x52c4/0x6c40 fs/f2fs/super.c:4333
 mount_bdev+0x26c/0x3a0 fs/super.c:1401
 legacy_get_tree+0xea/0x180 fs/fs_context.c:610
 vfs_get_tree+0x88/0x270 fs/super.c:1531
 do_new_mount+0x289/0xad0 fs/namespace.c:3040
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Last potentially related work creation:
 kasan_save_stack+0x2b/0x50 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xb0/0xc0 mm/kasan/generic.c:481
 call_rcu+0x163/0x9c0 kernel/rcu/tree.c:2798
 f2fs_put_super+0x5c7/0xb60 fs/f2fs/super.c:1596
 generic_shutdown_super+0x130/0x310 fs/super.c:492
 kill_block_super+0x79/0xd0 fs/super.c:1428
 kill_f2fs_super+0x2f9/0x3c0 fs/f2fs/super.c:4612
 deactivate_locked_super+0xa7/0xf0 fs/super.c:332
 cleanup_mnt+0x494/0x520 fs/namespace.c:1186
 task_work_run+0x243/0x300 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop+0x124/0x150 kernel/entry/common.c:171
 exit_to_user_mode_prepare+0xb2/0x140 kernel/entry/common.c:203
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x26/0x60 kernel/entry/common.c:296
 do_syscall_64+0x49/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Second to last potentially related work creation:
 kasan_save_stack+0x2b/0x50 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xb0/0xc0 mm/kasan/generic.c:481
 call_rcu+0x163/0x9c0 kernel/rcu/tree.c:2798
 f2fs_put_super+0x606/0xb60 fs/f2fs/super.c:1599
 generic_shutdown_super+0x130/0x310 fs/super.c:492
 kill_block_super+0x79/0xd0 fs/super.c:1428
 kill_f2fs_super+0x2f9/0x3c0 fs/f2fs/super.c:4612
 deactivate_locked_super+0xa7/0xf0 fs/super.c:332
 cleanup_mnt+0x494/0x520 fs/namespace.c:1186
 task_work_run+0x243/0x300 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop+0x124/0x150 kernel/entry/common.c:171
 exit_to_user_mode_prepare+0xb2/0x140 kernel/entry/common.c:203
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x26/0x60 kernel/entry/common.c:296
 do_syscall_64+0x49/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff88803459e1a0
 which belongs to the cache f2fs_inode_cache of size 2144
The buggy address is located 1872 bytes inside of
 2144-byte region [ffff88803459e1a0, ffff88803459ea00)

The buggy address belongs to the physical page:
page:ffffea0000d16600 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff888034599aa0 pfn:0x34598
head:ffffea0000d16600 order:3 compound_mapcount:0 compound_pincount:0
memcg:ffff8880222cf501
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 ffffea0000d35a00 dead000000000002 ffff88801cb74c80
raw: ffff888034599aa0 00000000800e0005 00000001ffffffff ffff8880222cf501
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Reclaimable, gfp_mask 0x1d2050(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL|__GFP_RECLAIMABLE), pid 27886, tgid 27885 (syz-executor.1), ts 1184915928737, free_ts 1175787154919
 prep_new_page mm/page_alloc.c:2539 [inline]
 get_page_from_freelist+0x742/0x7c0 mm/page_alloc.c:4291
 __alloc_pages+0x259/0x560 mm/page_alloc.c:5558
 alloc_slab_page+0x70/0xf0 mm/slub.c:1794
 allocate_slab+0x5e/0x4b0 mm/slub.c:1939
 new_slab mm/slub.c:1992 [inline]
 ___slab_alloc+0x782/0xe20 mm/slub.c:3180
 __slab_alloc mm/slub.c:3279 [inline]
 slab_alloc_node mm/slub.c:3364 [inline]
 slab_alloc mm/slub.c:3406 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3413 [inline]
 kmem_cache_alloc_lru+0x233/0x2e0 mm/slub.c:3429
 alloc_inode_sb include/linux/fs.h:3117 [inline]
 f2fs_alloc_inode+0x14d/0x520 fs/f2fs/super.c:1366
 alloc_inode fs/inode.c:259 [inline]
 iget_locked+0x191/0x830 fs/inode.c:1286
 f2fs_iget+0x51/0x4bb0 fs/f2fs/inode.c:505
 f2fs_fill_super+0x5382/0x6c40 fs/f2fs/super.c:4341
 mount_bdev+0x26c/0x3a0 fs/super.c:1401
 legacy_get_tree+0xea/0x180 fs/fs_context.c:610
 vfs_get_tree+0x88/0x270 fs/super.c:1531
 do_new_mount+0x289/0xad0 fs/namespace.c:3040
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1459 [inline]
 free_pcp_prepare+0x80c/0x8f0 mm/page_alloc.c:1509
 free_unref_page_prepare mm/page_alloc.c:3387 [inline]
 free_unref_page+0x7d/0x5f0 mm/page_alloc.c:3483
 free_slab mm/slub.c:2031 [inline]
 discard_slab mm/slub.c:2037 [inline]
 __unfreeze_partials+0x1ab/0x200 mm/slub.c:2586
 put_cpu_partial+0x106/0x170 mm/slub.c:2662
 qlist_free_all+0x2b/0x70 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x169/0x180 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0x1f/0x70 mm/kasan/common.c:302
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slab.h:737 [inline]
 slab_alloc_node mm/slub.c:3398 [inline]
 __kmem_cache_alloc_node+0x1d7/0x310 mm/slub.c:3437
 __do_kmalloc_node mm/slab_common.c:954 [inline]
 __kmalloc+0x9e/0x1a0 mm/slab_common.c:968
 kmalloc include/linux/slab.h:558 [inline]
 tomoyo_realpath_from_path+0xcd/0x5f0 security/tomoyo/realpath.c:251
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path_number_perm+0x1d3/0x760 security/tomoyo/file.c:723
 security_file_ioctl+0x55/0xb0 security/security.c:1554
 __do_sys_ioctl fs/ioctl.c:864 [inline]
 __se_sys_ioctl+0x48/0x170 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff88803459e780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88803459e800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88803459e880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                             ^
 ffff88803459e900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88803459e980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
