Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4016462704F
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 16:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235334AbiKMPvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 10:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235273AbiKMPvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 10:51:08 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0632DF15
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 07:51:06 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id j7-20020a056e02154700b003025b3c0ea3so855508ilu.10
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 07:51:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hv0aHOsIcFqs7KhUaCuH6Ea8wfRQF7vjwOhf98Ii52g=;
        b=s0tJ9HgvmGg+RhWHFzRbsxR2bq2dTMCWQZtxo5KdddbKUF9HMB9S1hHUq7BcN7oNXE
         XsuAlgM5v+Td/hI7rU5aGFdPLWEATc0GsV/cnEJdYwOtFXgjW+TNg6HbyogZ1Hv4mzoH
         XWXpQJJdx1qqOIEU4bjpO8C0UYmqP1dGkPaHalUa7BDZ5WqgtTtkeW9nHghtVSIf0QTA
         kipr+D4w8bmrsh8IvqsNQTIOenUrsvLMH7UjzCOYfSgS9jyLzNMwXndzxOn70SZfFhx+
         BnqJphpVxjuTA8pRdQolDEZ1UgcMExQMGX3nuW5v0gnCHbyJD/OBaWYKj1emf12c8INq
         g89g==
X-Gm-Message-State: ANoB5pmIe5jBNQ0nTOcvfm+jf+5An4KO63xKVOsCkoxWjgRXs+i/RQm0
        kGznx8hKc+ZlNzdYiWKOomw2QHnzKQ3xrBmsz3T3v1OC6HgA
X-Google-Smtp-Source: AA0mqf6KZvTMkzltuPdhVMPy9T06GWdR9cYNJFGDpT/2m3xUN2w0DUNOgZKpupIZIDBF20VU4qv6cI+zUKOex+VEkvOwOrFQiajB
MIME-Version: 1.0
X-Received: by 2002:a05:6638:504:b0:375:13ba:925 with SMTP id
 i4-20020a056638050400b0037513ba0925mr4210531jar.207.1668354666179; Sun, 13
 Nov 2022 07:51:06 -0800 (PST)
Date:   Sun, 13 Nov 2022 07:51:06 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003cb3c405ed5c17f9@google.com>
Subject: [syzbot] KASAN: use-after-free Read in do_garbage_collect
From:   syzbot <syzbot+f8f3dfa4abc489e768a1@syzkaller.appspotmail.com>
To:     chao@kernel.org, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    fef7fd48922d Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16e17f66880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=37dfef4b6dcee4a
dashboard link: https://syzkaller.appspot.com/bug?extid=f8f3dfa4abc489e768a1
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1699ef51880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14705e71880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3f2148d0d19b/disk-fef7fd48.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8b46b3d5f02f/vmlinux-fef7fd48.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b3ffcc7c8d30/bzImage-fef7fd48.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/1445ad299ad6/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f8f3dfa4abc489e768a1@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in data_blkaddr fs/f2fs/f2fs.h:2891 [inline]
BUG: KASAN: slab-out-of-bounds in is_alive fs/f2fs/gc.c:1117 [inline]
BUG: KASAN: slab-out-of-bounds in gc_data_segment fs/f2fs/gc.c:1520 [inline]
BUG: KASAN: slab-out-of-bounds in do_garbage_collect+0x386a/0x3df0 fs/f2fs/gc.c:1734
Read of size 4 at addr ffff888076557568 by task kworker/u4:3/52

CPU: 1 PID: 52 Comm: kworker/u4:3 Not tainted 6.1.0-rc4-syzkaller-00362-gfef7fd48922d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Workqueue: writeback wb_workfn (flush-7:0)
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:284 [inline]
 print_report+0x15e/0x45d mm/kasan/report.c:395
 kasan_report+0xbb/0x1f0 mm/kasan/report.c:495
 data_blkaddr fs/f2fs/f2fs.h:2891 [inline]
 is_alive fs/f2fs/gc.c:1117 [inline]
 gc_data_segment fs/f2fs/gc.c:1520 [inline]
 do_garbage_collect+0x386a/0x3df0 fs/f2fs/gc.c:1734
 f2fs_gc+0x88c/0x20a0 fs/f2fs/gc.c:1831
 f2fs_balance_fs+0x544/0x6b0 fs/f2fs/segment.c:410
 f2fs_write_inode+0x57e/0xe20 fs/f2fs/inode.c:753
 write_inode fs/fs-writeback.c:1440 [inline]
 __writeback_single_inode+0xcfc/0x1440 fs/fs-writeback.c:1652
 writeback_sb_inodes+0x54d/0xf90 fs/fs-writeback.c:1870
 wb_writeback+0x2c5/0xd70 fs/fs-writeback.c:2044
 wb_do_writeback fs/fs-writeback.c:2187 [inline]
 wb_workfn+0x2dc/0x12f0 fs/fs-writeback.c:2227
 process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e4/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>

Allocated by task 3607:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:45
 kasan_set_track+0x21/0x30 mm/kasan/common.c:52
 __kasan_slab_alloc+0x7e/0x80 mm/kasan/common.c:325
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slab.h:737 [inline]
 kmem_cache_alloc_bulk+0x3e9/0x830 mm/slub.c:3854
 mt_alloc_bulk lib/maple_tree.c:157 [inline]
 mas_alloc_nodes+0x309/0x810 lib/maple_tree.c:1251
 mas_node_count_gfp lib/maple_tree.c:1310 [inline]
 mas_preallocate+0x1b7/0x360 lib/maple_tree.c:5717
 __vma_adjust+0x18e/0x1ae0 mm/mmap.c:716
 vma_adjust include/linux/mm.h:2663 [inline]
 __split_vma+0x295/0x5c0 mm/mmap.c:2240
 do_mas_align_munmap+0x27e/0xee0 mm/mmap.c:2341
 do_mas_munmap+0x26a/0x2b0 mm/mmap.c:2502
 __vm_munmap+0x14f/0x290 mm/mmap.c:2779
 __do_sys_munmap mm/mmap.c:2804 [inline]
 __se_sys_munmap mm/mmap.c:2801 [inline]
 __x64_sys_munmap+0x55/0x80 mm/mmap.c:2801
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 3607:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:45
 kasan_set_track+0x21/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2a/0x40 mm/kasan/generic.c:511
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x160/0x1c0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:177 [inline]
 slab_free_hook mm/slub.c:1724 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1750
 slab_free mm/slub.c:3661 [inline]
 kmem_cache_free_bulk.part.0+0x205/0x780 mm/slub.c:3779
 mt_free_bulk lib/maple_tree.c:163 [inline]
 mas_destroy+0x394/0x5c0 lib/maple_tree.c:5767
 mas_store_prealloc+0xec/0x150 lib/maple_tree.c:5701
 __vma_adjust+0x772/0x1ae0 mm/mmap.c:811
 vma_adjust include/linux/mm.h:2663 [inline]
 __split_vma+0x295/0x5c0 mm/mmap.c:2240
 do_mas_align_munmap+0x27e/0xee0 mm/mmap.c:2341
 do_mas_munmap+0x26a/0x2b0 mm/mmap.c:2502
 __vm_munmap+0x14f/0x290 mm/mmap.c:2779
 __do_sys_munmap mm/mmap.c:2804 [inline]
 __se_sys_munmap mm/mmap.c:2801 [inline]
 __x64_sys_munmap+0x55/0x80 mm/mmap.c:2801
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff888076557400
 which belongs to the cache maple_node of size 256
The buggy address is located 104 bytes to the right of
 256-byte region [ffff888076557400, ffff888076557500)

The buggy address belongs to the physical page:
page:ffffea0001d95580 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x76556
head:ffffea0001d95580 order:1 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 ffffea0001f57d00 dead000000000003 ffff88801184fdc0
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 3317, tgid 3317 (dhcpcd-run-hook), ts 25081543086, free_ts 22135868707
 prep_new_page mm/page_alloc.c:2539 [inline]
 get_page_from_freelist+0x10b5/0x2d50 mm/page_alloc.c:4288
 __alloc_pages+0x1c7/0x5a0 mm/page_alloc.c:5555
 alloc_pages+0x1a6/0x270 mm/mempolicy.c:2285
 alloc_slab_page mm/slub.c:1794 [inline]
 allocate_slab+0x213/0x300 mm/slub.c:1939
 new_slab mm/slub.c:1992 [inline]
 ___slab_alloc+0xa91/0x1400 mm/slub.c:3180
 kmem_cache_alloc_bulk+0x28b/0x830 mm/slub.c:3830
 mt_alloc_bulk lib/maple_tree.c:157 [inline]
 mas_alloc_nodes+0x309/0x810 lib/maple_tree.c:1251
 mas_node_count_gfp lib/maple_tree.c:1310 [inline]
 mas_preallocate+0x1b7/0x360 lib/maple_tree.c:5717
 do_mas_align_munmap+0x11c/0xee0 mm/mmap.c:2314
 do_mas_munmap+0x26a/0x2b0 mm/mmap.c:2502
 __vm_munmap+0x14f/0x290 mm/mmap.c:2779
 elf_map+0x1f5/0x2a0 fs/binfmt_elf.c:392
 load_elf_interp fs/binfmt_elf.c:638 [inline]
 load_elf_binary+0x3376/0x4f00 fs/binfmt_elf.c:1250
 search_binary_handler fs/exec.c:1727 [inline]
 exec_binprm fs/exec.c:1768 [inline]
 bprm_execve fs/exec.c:1837 [inline]
 bprm_execve+0x7ef/0x19f0 fs/exec.c:1799
 do_execveat_common+0x724/0x890 fs/exec.c:1942
 do_execve fs/exec.c:2016 [inline]
 __do_sys_execve fs/exec.c:2092 [inline]
 __se_sys_execve fs/exec.c:2087 [inline]
 __x64_sys_execve+0x8f/0xc0 fs/exec.c:2087
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1459 [inline]
 free_pcp_prepare+0x65c/0xd90 mm/page_alloc.c:1509
 free_unref_page_prepare mm/page_alloc.c:3387 [inline]
 free_unref_page+0x19/0x4d0 mm/page_alloc.c:3483
 __unfreeze_partials+0x17c/0x1a0 mm/slub.c:2586
 qlink_free mm/kasan/quarantine.c:168 [inline]
 qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x180/0x200 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0x62/0x80 mm/kasan/common.c:302
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slab.h:737 [inline]
 slab_alloc_node mm/slub.c:3398 [inline]
 __kmem_cache_alloc_node+0x2da/0x3e0 mm/slub.c:3437
 kmalloc_trace+0x22/0x60 mm/slab_common.c:1045
 kmalloc include/linux/slab.h:553 [inline]
 tomoyo_print_header security/tomoyo/audit.c:156 [inline]
 tomoyo_init_log+0x18a/0x1ed0 security/tomoyo/audit.c:255
 tomoyo_supervisor+0x350/0xf10 security/tomoyo/common.c:2088
 tomoyo_audit_path_log security/tomoyo/file.c:168 [inline]
 tomoyo_path_permission security/tomoyo/file.c:587 [inline]
 tomoyo_path_permission+0x270/0x3a0 security/tomoyo/file.c:573
 tomoyo_path_perm+0x2f0/0x400 security/tomoyo/file.c:838
 security_inode_getattr+0xcf/0x140 security/security.c:1347
 vfs_getattr fs/stat.c:158 [inline]
 vfs_statx+0x16e/0x430 fs/stat.c:233
 vfs_fstatat+0x8c/0xb0 fs/stat.c:267
 __do_sys_newfstatat+0x94/0x120 fs/stat.c:437

Memory state around the buggy address:
 ffff888076557400: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888076557480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888076557500: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                                                          ^
 ffff888076557580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888076557600: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
