Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC724631EA3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 11:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiKUKph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 05:45:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKUKpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 05:45:35 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8007AF53
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 02:45:34 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id k21-20020a5e8915000000b006de391b332fso5130037ioj.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 02:45:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4XxqWtN23g37X5FE/Dv6J+437LjF+0nMYA6IbqWTuxs=;
        b=astnDpNPXnXeJMcqqwbopFJNDIl/B5suzwok2rcpGt9ci082r9uo3uTFdjnf7eBA12
         NVZHoHppZI8lXyLUZgUp2Nz6eAejOsn4zNv3cWAbDb/vhRv7tPoR4IaqPZT5zDdXZgyg
         xxjUMTJAJ7d0D1OveZEjL7MkllXESuQ61yxGYcVxp7a7w0DdlOF70BDpela1Un9Aowyv
         oiBaGMGVOGI22rZgfVq3+EcCEqA69WBdWQv5gRDFOjArAc0oIa5CTbrww21Wgtzc3rf9
         H1RbURsi4NR81qweM3zsGDvZVk/zR6KahfGQNrMqlbIssBeG2ASjw7cQ9Nk+cmSb9keT
         +IFQ==
X-Gm-Message-State: ANoB5pnV1LkC/+SSKvdY9s9i4c29PC2svVMgTXLAm2Qh4CLJWw/pnKuN
        dC4DXYhXBUt51QoKa6Oe30jwNkEWjUswRBd1ucYI4ihrXeKM
X-Google-Smtp-Source: AA0mqf5gP7TlhrTBNsvz1dtOSofzKGvxDAY8reRuK4/gTDrOU3wJlNsrjxkEFGrmOgjBHEZXJcBJH5FeMmkc5BDTIVBtmv5NEJ7m
MIME-Version: 1.0
X-Received: by 2002:a02:3f60:0:b0:375:2d83:f970 with SMTP id
 c32-20020a023f60000000b003752d83f970mr7588624jaf.205.1669027533529; Mon, 21
 Nov 2022 02:45:33 -0800 (PST)
Date:   Mon, 21 Nov 2022 02:45:33 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000041a69905edf8c1e3@google.com>
Subject: [syzbot] KASAN: use-after-free Read in __unmap_hugepage_range_final
From:   syzbot <syzbot+12c0b1ffb9f94668586f@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev, mike.kravetz@oracle.com,
        nathan@kernel.org, ndesaulniers@google.com,
        songmuchun@bytedance.com, syzkaller-bugs@googlegroups.com,
        trix@redhat.com
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

HEAD commit:    81e7cfa3a9eb Merge tag 'erofs-for-6.1-rc6-fixes' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=165645be880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=11d3fa0b3feb5055
dashboard link: https://syzkaller.appspot.com/bug?extid=12c0b1ffb9f94668586f
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8b37d56c44e6/disk-81e7cfa3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/73cad2fe5bfa/vmlinux-81e7cfa3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/961f30b0f25b/bzImage-81e7cfa3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+12c0b1ffb9f94668586f@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in __lock_acquire+0x3ee7/0x56d0 kernel/locking/lockdep.c:4925
Read of size 8 at addr ffff888077f35e38 by task syz-executor.4/18398

CPU: 1 PID: 18398 Comm: syz-executor.4 Not tainted 6.1.0-rc5-syzkaller-00015-g81e7cfa3a9eb #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd1/0x138 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:284 [inline]
 print_report+0x15e/0x461 mm/kasan/report.c:395
 kasan_report+0xbf/0x1f0 mm/kasan/report.c:495
 __lock_acquire+0x3ee7/0x56d0 kernel/locking/lockdep.c:4925
 lock_acquire kernel/locking/lockdep.c:5668 [inline]
 lock_acquire+0x1e3/0x630 kernel/locking/lockdep.c:5633
 __raw_spin_lock_irq include/linux/spinlock_api_smp.h:119 [inline]
 _raw_spin_lock_irq+0x36/0x50 kernel/locking/spinlock.c:170
 rwsem_down_write_slowpath+0x657/0x12e0 kernel/locking/rwsem.c:1194
 __down_write_common kernel/locking/rwsem.c:1305 [inline]
 __down_write_common kernel/locking/rwsem.c:1302 [inline]
 __down_write kernel/locking/rwsem.c:1314 [inline]
 down_write+0x1e8/0x220 kernel/locking/rwsem.c:1563
 hugetlb_vma_lock_write mm/hugetlb.c:6838 [inline]
 __unmap_hugepage_range_final+0x9b/0x350 mm/hugetlb.c:5202
 unmap_single_vma+0x23d/0x2a0 mm/memory.c:1690
 zap_page_range+0x392/0x530 mm/memory.c:1762
 madvise_dontneed_single_vma mm/madvise.c:793 [inline]
 madvise_dontneed_free mm/madvise.c:886 [inline]
 madvise_vma_behavior+0x12df/0x2050 mm/madvise.c:1025
 madvise_walk_vmas+0x1c7/0x2b0 mm/madvise.c:1250
 do_madvise.part.0+0x24a/0x340 mm/madvise.c:1429
 do_madvise mm/madvise.c:1442 [inline]
 __do_sys_madvise mm/madvise.c:1442 [inline]
 __se_sys_madvise mm/madvise.c:1440 [inline]
 __x64_sys_madvise+0x117/0x150 mm/madvise.c:1440
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fe427c8b639
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe428987168 EFLAGS: 00000246 ORIG_RAX: 000000000000001c
RAX: ffffffffffffffda RBX: 00007fe427dac120 RCX: 00007fe427c8b639
RDX: 0000000000000004 RSI: 0000000000800000 RDI: 0000000020800000
RBP: 00007fe427ce6ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff480924af R14: 00007fe428987300 R15: 0000000000022000
 </TASK>

Allocated by task 18391:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:371 [inline]
 ____kasan_kmalloc mm/kasan/common.c:330 [inline]
 __kasan_kmalloc+0xa3/0xb0 mm/kasan/common.c:380
 kmalloc include/linux/slab.h:553 [inline]
 hugetlb_vma_lock_alloc.part.0+0x3f/0x130 mm/hugetlb.c:6930
 hugetlb_vma_lock_alloc mm/hugetlb.c:6686 [inline]
 hugetlb_reserve_pages+0xa43/0xe90 mm/hugetlb.c:6555
 hugetlbfs_file_mmap+0x410/0x5c0 fs/hugetlbfs/inode.c:167
 call_mmap include/linux/fs.h:2196 [inline]
 mmap_region+0x6c3/0x1dd0 mm/mmap.c:2625
 do_mmap+0x831/0xf60 mm/mmap.c:1412
 vm_mmap_pgoff+0x1af/0x280 mm/util.c:520
 ksys_mmap_pgoff+0x1c7/0x5a0 mm/mmap.c:1458
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 18396:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2b/0x40 mm/kasan/generic.c:511
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x13b/0x1a0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:177 [inline]
 __cache_free mm/slab.c:3389 [inline]
 __do_kmem_cache_free mm/slab.c:3585 [inline]
 __kmem_cache_free+0xcd/0x3b0 mm/slab.c:3592
 hugetlb_vma_lock_release mm/hugetlb.c:6875 [inline]
 kref_put include/linux/kref.h:65 [inline]
 __hugetlb_vma_unlock_write_put mm/hugetlb.c:6890 [inline]
 __hugetlb_vma_unlock_write_free mm/hugetlb.c:6898 [inline]
 __unmap_hugepage_range_final+0x2b1/0x350 mm/hugetlb.c:5215
 unmap_single_vma+0x23d/0x2a0 mm/memory.c:1690
 zap_page_range+0x392/0x530 mm/memory.c:1762
 madvise_dontneed_single_vma mm/madvise.c:793 [inline]
 madvise_dontneed_free mm/madvise.c:886 [inline]
 madvise_vma_behavior+0x12df/0x2050 mm/madvise.c:1025
 madvise_walk_vmas+0x1c7/0x2b0 mm/madvise.c:1250
 do_madvise.part.0+0x24a/0x340 mm/madvise.c:1429
 do_madvise mm/madvise.c:1442 [inline]
 __do_sys_madvise mm/madvise.c:1442 [inline]
 __se_sys_madvise mm/madvise.c:1440 [inline]
 __x64_sys_madvise+0x117/0x150 mm/madvise.c:1440
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff888077f35e00
 which belongs to the cache kmalloc-192 of size 192
The buggy address is located 56 bytes inside of
 192-byte region [ffff888077f35e00, ffff888077f35ec0)

The buggy address belongs to the physical page:
page:ffffea0001dfcd40 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x77f35
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffffea0001f70ac8 ffffea00005e87c8 ffff888012040000
raw: 0000000000000000 ffff888077f35000 0000000100000010 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x3420c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_COMP|__GFP_HARDWALL|__GFP_THISNODE), pid 16305, tgid 16297 (syz-executor.0), ts 943277514051, free_ts 941060075554
 prep_new_page mm/page_alloc.c:2539 [inline]
 get_page_from_freelist+0x10b5/0x2d50 mm/page_alloc.c:4288
 __alloc_pages+0x1cb/0x5b0 mm/page_alloc.c:5555
 __alloc_pages_node include/linux/gfp.h:223 [inline]
 kmem_getpages mm/slab.c:1363 [inline]
 cache_grow_begin+0x75/0x360 mm/slab.c:2570
 cache_alloc_refill+0x27f/0x380 mm/slab.c:2943
 ____cache_alloc mm/slab.c:3019 [inline]
 ____cache_alloc mm/slab.c:3002 [inline]
 __do_cache_alloc mm/slab.c:3202 [inline]
 slab_alloc_node mm/slab.c:3250 [inline]
 __kmem_cache_alloc_node+0x44a/0x510 mm/slab.c:3549
 kmalloc_trace+0x26/0x60 mm/slab_common.c:1045
 kmalloc include/linux/slab.h:553 [inline]
 kzalloc include/linux/slab.h:689 [inline]
 push_stack+0x77/0x560 kernel/bpf/verifier.c:1282
 check_cond_jmp_op kernel/bpf/verifier.c:10233 [inline]
 do_check kernel/bpf/verifier.c:12460 [inline]
 do_check_common+0x643f/0xcc80 kernel/bpf/verifier.c:14652
 do_check_main kernel/bpf/verifier.c:14715 [inline]
 bpf_check+0x88dc/0xb8e0 kernel/bpf/verifier.c:15285
 bpf_prog_load+0x1543/0x2220 kernel/bpf/syscall.c:2605
 __sys_bpf+0x1436/0x4f40 kernel/bpf/syscall.c:4965
 __do_sys_bpf kernel/bpf/syscall.c:5069 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5067 [inline]
 __x64_sys_bpf+0x79/0xc0 kernel/bpf/syscall.c:5067
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1459 [inline]
 free_pcp_prepare+0x65c/0xd90 mm/page_alloc.c:1509
 free_unref_page_prepare mm/page_alloc.c:3387 [inline]
 free_unref_page+0x1d/0x4d0 mm/page_alloc.c:3483
 slab_destroy mm/slab.c:1615 [inline]
 slabs_destroy+0x85/0xc0 mm/slab.c:1635
 cache_flusharray mm/slab.c:3360 [inline]
 ___cache_free+0x2ac/0x3d0 mm/slab.c:3423
 qlink_free mm/kasan/quarantine.c:168 [inline]
 qlist_free_all+0x4f/0x1a0 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x184/0x210 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0x63/0x90 mm/kasan/common.c:302
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slab.h:737 [inline]
 slab_alloc_node mm/slab.c:3257 [inline]
 kmem_cache_alloc_node+0x28f/0x580 mm/slab.c:3537
 __alloc_skb+0x214/0x300 net/core/skbuff.c:497
 alloc_skb_fclone include/linux/skbuff.h:1317 [inline]
 tcp_stream_alloc_skb+0x3c/0x580 net/ipv4/tcp.c:862
 tcp_connect+0xd1b/0x4240 net/ipv4/tcp_output.c:3855
 tcp_v4_connect+0x19ad/0x2580 net/ipv4/tcp_ipv4.c:333
 __inet_stream_connect+0x69e/0xed0 net/ipv4/af_inet.c:665
 inet_stream_connect+0x57/0xa0 net/ipv4/af_inet.c:729
 __sys_connect_file+0x153/0x1a0 net/socket.c:1976
 io_connect+0x3cc/0x720 io_uring/net.c:1429

Memory state around the buggy address:
 ffff888077f35d00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888077f35d80: 00 fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888077f35e00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                        ^
 ffff888077f35e80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff888077f35f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
