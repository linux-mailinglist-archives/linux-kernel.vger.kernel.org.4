Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D6D5F1C85
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 15:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiJANsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 09:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiJANsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 09:48:41 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1CFABD70
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 06:48:39 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id k6-20020a92c246000000b002f80993e780so5429068ilo.13
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 06:48:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=WXEnnl5QF9uOTiiySHkjmZUysPOscyGcmv++x9GaIWk=;
        b=GfTVl+j1nSFLh8upUk5cNKXd3uFZQK3dQ+nxVjhDKrUxXFVi4Ai725h/Irn5X84Gi+
         JVfno59DnOlQx3QEDgmiRPmA5DbICrMVwEAqcLd1Ji0q/7dx7X4Fj1LGerk7aLwHrNHW
         LH/gOxD7V74YkipW2drStgvLunliyKGrzfrqzUnJbropGYdFv6T15TcqdBp7fIoOpyj9
         /lgtArgoETizSuLK+/cFlrJ52x8qOXikZvasxbQxmxAzsKQ5fFn6XAtS/62cPbGZgO9E
         HunH1MtyOVSIO2O9ZbDok1SQZ26eSyGu/f4cVkMKTk2xOB4pETC+u9f7grcefiUtq6EP
         tnKg==
X-Gm-Message-State: ACrzQf3oiOGtjokQYIa08RQEbz6hIa5q+QYci9bXp2I3IsC81B09wsi0
        e/MjNZnEakjUB6WXfjD5MNdiZgD1svoU1zNJL4nNgKvMYweL
X-Google-Smtp-Source: AMsMyM7rsI6ZPFxpge2xVaDM4vJzTY2QWU/3mFvJE11JwOEbaysXZBeYI+7lGCqttvjJMZYhDDmEk9yXLLue9m0/uOmhPXc3JvZq
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c04:b0:2f1:aafc:a472 with SMTP id
 l4-20020a056e021c0400b002f1aafca472mr6357874ilh.0.1664632118941; Sat, 01 Oct
 2022 06:48:38 -0700 (PDT)
Date:   Sat, 01 Oct 2022 06:48:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000219dcd05e9f95ed9@google.com>
Subject: [syzbot] KASAN: use-after-free Read in nilfs_segctor_confirm
From:   syzbot <syzbot+b8c672b0e22615c80fe0@syzkaller.appspotmail.com>
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

HEAD commit:    aaa11ce2ffc8 Add linux-next specific files for 20220923
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17db205c880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=186d1ff305f10294
dashboard link: https://syzkaller.appspot.com/bug?extid=b8c672b0e22615c80fe0
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=178843ef080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16ba96c0880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/95c7bf83c07e/disk-aaa11ce2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b161cd56a7a3/vmlinux-aaa11ce2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b8c672b0e22615c80fe0@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 2048
==================================================================
BUG: KASAN: use-after-free in nilfs_segctor_confirm+0x175/0x190 fs/nilfs2/segment.c:837
Read of size 8 at addr ffff88801274fc30 by task syz-executor290/3609

CPU: 0 PID: 3609 Comm: syz-executor290 Not tainted 6.0.0-rc6-next-20220923-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:284 [inline]
 print_report+0x15e/0x45d mm/kasan/report.c:395
 kasan_report+0xbb/0x1f0 mm/kasan/report.c:495
 nilfs_segctor_confirm+0x175/0x190 fs/nilfs2/segment.c:837
 nilfs_segctor_destroy fs/nilfs2/segment.c:2727 [inline]
 nilfs_detach_log_writer+0x856/0x9f0 fs/nilfs2/segment.c:2808
 nilfs_put_super+0x3f/0x1a0 fs/nilfs2/super.c:468
 generic_shutdown_super+0x154/0x410 fs/super.c:491
 kill_block_super+0x97/0xf0 fs/super.c:1427
 deactivate_locked_super+0x94/0x160 fs/super.c:331
 deactivate_super+0xad/0xd0 fs/super.c:362
 cleanup_mnt+0x2ae/0x3d0 fs/namespace.c:1186
 task_work_run+0x16b/0x270 kernel/task_work.c:179
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xb35/0x2a20 kernel/exit.c:820
 do_group_exit+0xd0/0x2a0 kernel/exit.c:950
 __do_sys_exit_group kernel/exit.c:961 [inline]
 __se_sys_exit_group kernel/exit.c:959 [inline]
 __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:959
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f7f96472ba9
Code: Unable to access opcode bytes at 0x7f7f96472b7f.
RSP: 002b:00007fff812c4e88 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f7f964ea330 RCX: 00007f7f96472ba9
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000001
RBP: 0000000000000001 R08: ffffffffffffffc0 R09: 00007f7f964e4e40
R10: 00007f7f964e4e40 R11: 0000000000000246 R12: 00007f7f964ea330
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
 </TASK>

Allocated by task 3609:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:45
 kasan_set_track+0x21/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:371 [inline]
 ____kasan_kmalloc mm/kasan/common.c:330 [inline]
 __kasan_kmalloc+0xa1/0xb0 mm/kasan/common.c:380
 kmalloc include/linux/slab.h:559 [inline]
 kzalloc include/linux/slab.h:695 [inline]
 nilfs_find_or_create_root+0x84/0x4d0 fs/nilfs2/the_nilfs.c:747
 nilfs_attach_checkpoint+0xc1/0x4b0 fs/nilfs2/super.c:519
 nilfs_fill_super fs/nilfs2/super.c:1064 [inline]
 nilfs_mount+0xb12/0xfb0 fs/nilfs2/super.c:1317
 legacy_get_tree+0x105/0x220 fs/fs_context.c:610
 vfs_get_tree+0x89/0x2f0 fs/super.c:1530
 do_new_mount fs/namespace.c:3040 [inline]
 path_mount+0x1326/0x1e20 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 3609:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:45
 kasan_set_track+0x21/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2a/0x40 mm/kasan/generic.c:511
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x160/0x1c0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:177 [inline]
 slab_free_hook mm/slub.c:1669 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1695
 slab_free mm/slub.c:3599 [inline]
 __kmem_cache_free+0xab/0x3b0 mm/slub.c:3612
 nilfs_put_root+0xb1/0xd0 fs/nilfs2/the_nilfs.c:804
 nilfs_clear_inode+0x29a/0x330 fs/nilfs2/inode.c:895
 nilfs_evict_inode+0x318/0x440 fs/nilfs2/inode.c:908
 evict+0x2ed/0x6b0 fs/inode.c:664
 dispose_list+0x117/0x1e0 fs/inode.c:697
 evict_inodes+0x352/0x450 fs/inode.c:747
 generic_shutdown_super+0xab/0x410 fs/super.c:479
 kill_block_super+0x97/0xf0 fs/super.c:1427
 deactivate_locked_super+0x94/0x160 fs/super.c:331
 deactivate_super+0xad/0xd0 fs/super.c:362
 cleanup_mnt+0x2ae/0x3d0 fs/namespace.c:1186
 task_work_run+0x16b/0x270 kernel/task_work.c:179
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xb35/0x2a20 kernel/exit.c:820
 do_group_exit+0xd0/0x2a0 kernel/exit.c:950
 __do_sys_exit_group kernel/exit.c:961 [inline]
 __se_sys_exit_group kernel/exit.c:959 [inline]
 __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:959
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff88801274fc00
 which belongs to the cache kmalloc-256 of size 256
The buggy address is located 48 bytes inside of
 256-byte region [ffff88801274fc00, ffff88801274fd00)

The buggy address belongs to the physical page:
page:ffffea000049d380 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1274e
head:ffffea000049d380 order:1 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 ffff888011841b40 dead000080100010 0000000000000000
raw: 0000000000000000 dead000000000001 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (swapper/0), ts 2053424585, free_ts 0
 prep_new_page mm/page_alloc.c:2538 [inline]
 get_page_from_freelist+0x1092/0x2d20 mm/page_alloc.c:4287
 __alloc_pages+0x1c7/0x5a0 mm/page_alloc.c:5546
 alloc_page_interleave+0x1e/0x200 mm/mempolicy.c:2113
 alloc_pages+0x22f/0x270 mm/mempolicy.c:2275
 alloc_slab_page mm/slub.c:1739 [inline]
 allocate_slab+0x213/0x300 mm/slub.c:1884
 new_slab mm/slub.c:1937 [inline]
 ___slab_alloc+0xac1/0x1430 mm/slub.c:3119
 __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3217
 slab_alloc_node mm/slub.c:3302 [inline]
 __kmem_cache_alloc_node+0x18a/0x3d0 mm/slub.c:3375
 __do_kmalloc_node mm/slab_common.c:933 [inline]
 __kmalloc_node_track_caller+0x45/0xc0 mm/slab_common.c:954
 __do_krealloc mm/slab_common.c:1318 [inline]
 krealloc+0x8c/0xf0 mm/slab_common.c:1351
 add_sysfs_param+0xca/0x960 kernel/params.c:651
 kernel_add_sysfs_param kernel/params.c:812 [inline]
 param_sysfs_builtin kernel/params.c:851 [inline]
 param_sysfs_init+0x301/0x43b kernel/params.c:970
 do_one_initcall+0x13d/0x780 init/main.c:1307
 do_initcall_level init/main.c:1382 [inline]
 do_initcalls init/main.c:1398 [inline]
 do_basic_setup init/main.c:1417 [inline]
 kernel_init_freeable+0x6ff/0x788 init/main.c:1637
 kernel_init+0x1a/0x1d0 init/main.c:1525
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88801274fb00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88801274fb80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88801274fc00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                     ^
 ffff88801274fc80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88801274fd00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
