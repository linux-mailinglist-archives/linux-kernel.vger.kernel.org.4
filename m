Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E75461830B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 16:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbiKCPlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 11:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbiKCPln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 11:41:43 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BBE193CD
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 08:41:42 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id bx19-20020a056602419300b006bcbf3b91fdso1271765iob.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 08:41:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aVkB089SchyOQ3W6vPx+w6IpkMPGk+5HLWOF0OvZdyo=;
        b=6kO8Lvt9+rLSxXCjoQd4VCbeZXtjZLJB48vf14DY4saHtOE+Z8ee8MfRAk04OSgIa5
         YVHeCUNa4hOAVkxJ2QHD+oXQN1SlFRKtRu+IhPUZP+VWLxPPxTunvHYnMTptQl+skgQZ
         61CpghL3+wECNDFdKEAWGji0G7fXg8QrP6pmQFRIUbA4Nzk64m+If5b5dkaR+uz4Cz03
         DT5Mzn5l99JIhGS6EzGOD3+6doXg07Ejuv1AcKGBHXMWSL+zD7BFT/IlWqO6XE3CqUP9
         x+XzZvJB5R8tj3PFvGczkLQIKG/Jzy8gxhCx+XCyKCqr0LGxNSh9F9wRQ0n5w071+ka9
         Nw9A==
X-Gm-Message-State: ACrzQf2YyyhsRZG+oXSRVoithwl6mSesuJQSW3xmun0LA3y7DYVDRA21
        LYbEAJkG3hjYifIqSP5dBiX55xBpZtjbUmFJBJaU2TpdNlgj
X-Google-Smtp-Source: AMsMyM5CsIdG4vIRMBSLLdtv8ZevAWWU5S4D7qcmtkbLglD1qmApGQY7Nxt6rKEbHaYxUO5oFg0aADQViiUsAeXlj6CsZ6OvPSWd
MIME-Version: 1.0
X-Received: by 2002:a6b:c5c4:0:b0:6a2:4ab2:6490 with SMTP id
 v187-20020a6bc5c4000000b006a24ab26490mr18705354iof.129.1667490101689; Thu, 03
 Nov 2022 08:41:41 -0700 (PDT)
Date:   Thu, 03 Nov 2022 08:41:41 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002d868805ec92cbf0@google.com>
Subject: [syzbot] KASAN: slab-out-of-bounds Read in search_by_key (2)
From:   syzbot <syzbot+b3b14fb9f8a14c5d0267@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, axboe@kernel.dk, bvanassche@acm.org,
        linux-kernel@vger.kernel.org, reiserfs-devel@vger.kernel.org,
        song@kernel.org, syzkaller-bugs@googlegroups.com,
        yi.zhang@huawei.com
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

HEAD commit:    b229b6ca5abb Merge tag 'perf-tools-fixes-for-v6.1-2022-10-..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14ff0ede880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d3548a4365ba17d
dashboard link: https://syzkaller.appspot.com/bug?extid=b3b14fb9f8a14c5d0267
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/24728b72a896/disk-b229b6ca.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/10a3c40c60e1/vmlinux-b229b6ca.xz
kernel image: https://storage.googleapis.com/syzbot-assets/69f963b02b7e/bzImage-b229b6ca.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b3b14fb9f8a14c5d0267@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in search_by_key+0xf2/0x49c0 fs/reiserfs/stree.c:632
Read of size 8 at addr ffff88802678e3f0 by task syz-executor.4/9639

CPU: 1 PID: 9639 Comm: syz-executor.4 Not tainted 6.1.0-rc2-syzkaller-00105-gb229b6ca5abb #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 print_address_description+0x74/0x340 mm/kasan/report.c:284
 print_report+0x107/0x1f0 mm/kasan/report.c:395
 kasan_report+0xcd/0x100 mm/kasan/report.c:495
 search_by_key+0xf2/0x49c0 fs/reiserfs/stree.c:632
 search_by_entry_key+0x36/0xd20 fs/reiserfs/namei.c:125
 reiserfs_readdir_inode+0x235/0x1410 fs/reiserfs/dir.c:98
 iterate_dir+0x257/0x5f0
 __do_sys_getdents fs/readdir.c:286 [inline]
 __se_sys_getdents+0x1db/0x4d0 fs/readdir.c:271
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f1f6208b5a9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1f62e83168 EFLAGS: 00000246 ORIG_RAX: 000000000000004e
RAX: ffffffffffffffda RBX: 00007f1f621abf80 RCX: 00007f1f6208b5a9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007f1f620e67b0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc33ce425f R14: 00007f1f62e83300 R15: 0000000000022000
 </TASK>

Allocated by task 9639:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x3d/0x60 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:371 [inline]
 __kasan_kmalloc+0x97/0xb0 mm/kasan/common.c:380
 kmalloc include/linux/slab.h:576 [inline]
 kzalloc include/linux/slab.h:712 [inline]
 bfs_fill_super+0x5a/0xe30 fs/bfs/inode.c:321
 mount_bdev+0x26c/0x3a0 fs/super.c:1400
 legacy_get_tree+0xea/0x180 fs/fs_context.c:610
 vfs_get_tree+0x88/0x270 fs/super.c:1530
 do_new_mount+0x289/0xad0 fs/namespace.c:3040
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff88802678e200
 which belongs to the cache kmalloc-256 of size 256
The buggy address is located 240 bytes to the right of
 256-byte region [ffff88802678e200, ffff88802678e300)

The buggy address belongs to the physical page:
page:ffffea000099e380 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2678e
head:ffffea000099e380 order:1 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 ffffea00007c1380 dead000000000003 ffff888012041b40
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 34, tgid 34 (kworker/u4:2), ts 195026526707, free_ts 195023823133
 prep_new_page mm/page_alloc.c:2538 [inline]
 get_page_from_freelist+0x742/0x7c0 mm/page_alloc.c:4287
 __alloc_pages+0x259/0x560 mm/page_alloc.c:5554
 alloc_slab_page+0x70/0xf0 mm/slub.c:1794
 allocate_slab+0x5e/0x4b0 mm/slub.c:1939
 new_slab mm/slub.c:1992 [inline]
 ___slab_alloc+0x782/0xe20 mm/slub.c:3180
 __slab_alloc mm/slub.c:3279 [inline]
 slab_alloc_node mm/slub.c:3364 [inline]
 __kmem_cache_alloc_node+0x252/0x310 mm/slub.c:3437
 __do_kmalloc_node mm/slab_common.c:954 [inline]
 __kmalloc+0x9e/0x1a0 mm/slab_common.c:968
 kmalloc include/linux/slab.h:581 [inline]
 kzalloc include/linux/slab.h:712 [inline]
 ieee80211_ibss_build_presp+0x116/0x1920 net/mac80211/ibss.c:70
 __ieee80211_sta_join_ibss+0x7b9/0x14b0 net/mac80211/ibss.c:316
 ieee80211_sta_create_ibss+0x35b/0x600 net/mac80211/ibss.c:1348
 ieee80211_sta_find_ibss net/mac80211/ibss.c:1478 [inline]
 ieee80211_ibss_work+0xe9c/0x1540 net/mac80211/ibss.c:1705
 process_one_work+0x877/0xdb0 kernel/workqueue.c:2289
 worker_thread+0xb14/0x1330 kernel/workqueue.c:2436
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1458 [inline]
 free_pcp_prepare+0x80c/0x8f0 mm/page_alloc.c:1508
 free_unref_page_prepare mm/page_alloc.c:3386 [inline]
 free_unref_page+0x7d/0x5f0 mm/page_alloc.c:3482
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
 slab_alloc mm/slub.c:3406 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3413 [inline]
 kmem_cache_alloc+0x1cc/0x300 mm/slub.c:3422
 getname_flags+0xb8/0x4e0 fs/namei.c:139
 user_path_at_empty+0x2a/0x1a0 fs/namei.c:2875
 do_readlinkat+0x10c/0x3d0 fs/stat.c:468
 __do_sys_readlink fs/stat.c:501 [inline]
 __se_sys_readlink fs/stat.c:498 [inline]
 __x64_sys_readlink+0x7b/0x90 fs/stat.c:498
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff88802678e280: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88802678e300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88802678e380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                                                             ^
 ffff88802678e400: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802678e480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
