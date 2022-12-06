Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9BE5643F13
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 09:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234316AbiLFIwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 03:52:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234287AbiLFIwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 03:52:40 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5F9F35
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 00:52:37 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id e15-20020a056602158f00b006e01d8fa493so2219428iow.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 00:52:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y7yrUr1Oe8LDaWZu1hg0kLNM8SHLsAk9jHEpRWzXlxI=;
        b=rFLgXvPC7D2S3kFvAEafY03PasTGFYqBPpZfbdWlML0YxSNBv/liwJ7Cjuy2SFly+l
         zaPIgNIwXgGPE/iRal9eCZDmz6Z12zHIoYGEbYg0BUM/3bC8Usm6pnxpI+btoldD7Ah5
         IyZbvg8n2wjtET6B1rLmmlQ6tjGVT9F0zyT46AKQPyfzmH4PAOsyNM/m97UscJaZvb8A
         ZLIuOnDJ0hw/X636+1N+jnpiGlTwOTCQDR/NNQYuPzyFdnqS+4sDGrg+a9nq0M5Xu4QF
         LiXAgY2rba464DI1UhryROu3zWAQlhEG7HlyATHhG7V315J97l1tedHRsaEc0Bkp6BYf
         /4QQ==
X-Gm-Message-State: ANoB5pmbV+RyW5n61ml1rY0z5ALb16g6jgbW8j4XD4C9IvO8hkcfcCyY
        tnVw6YWi7kYvWRkAiLTUj3Un5qwQAiS2EMHH8toGFICvK0cE
X-Google-Smtp-Source: AA0mqf7KZB8UIOIL0dJ0KiL+bVwgIIcwOdkGGv4feDmTz82co9v4jvXLmzO+VyVkM/xoRnpK/P39EgAn2Ot7jIvqHxeBhGLBs9+6
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d8c:b0:300:da4a:f8f6 with SMTP id
 h12-20020a056e021d8c00b00300da4af8f6mr11006984ila.99.1670316756487; Tue, 06
 Dec 2022 00:52:36 -0800 (PST)
Date:   Tue, 06 Dec 2022 00:52:36 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eed81005ef24ecc9@google.com>
Subject: [syzbot] KASAN: slab-out-of-bounds Read in hdr_delete_de
From:   syzbot <syzbot+9c2811fd56591639ff5f@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev,
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

HEAD commit:    76dcd734eca2 Linux 6.1-rc8
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16bef6f5880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d58e7fe7f9cf5e24
dashboard link: https://syzkaller.appspot.com/bug?extid=9c2811fd56591639ff5f
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=105205d3880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=167dc11d880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/335b45e348d5/disk-76dcd734.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f40c1ab3021e/vmlinux-76dcd734.xz
kernel image: https://storage.googleapis.com/syzbot-assets/efd2263d5bdc/bzImage-76dcd734.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/125139c76268/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9c2811fd56591639ff5f@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 4096
ntfs3: loop0: Different NTFS' sector size (2048) and media sector size (512)
==================================================================
BUG: KASAN: slab-out-of-bounds in hdr_delete_de+0xe0/0x150 fs/ntfs3/index.c:806
Read of size 16842960 at addr ffff888079cc0600 by task syz-executor934/3631

CPU: 0 PID: 3631 Comm: syz-executor934 Not tainted 6.1.0-rc8-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 print_address_description+0x74/0x340 mm/kasan/report.c:284
 print_report+0x107/0x1f0 mm/kasan/report.c:395
 kasan_report+0xcd/0x100 mm/kasan/report.c:495
 kasan_check_range+0x2a7/0x2e0 mm/kasan/generic.c:189
 memmove+0x25/0x60 mm/kasan/shadow.c:54
 hdr_delete_de+0xe0/0x150 fs/ntfs3/index.c:806
 indx_delete_entry+0x74f/0x3670 fs/ntfs3/index.c:2193
 ni_remove_name+0x27a/0x980 fs/ntfs3/frecord.c:2910
 ntfs_unlink_inode+0x3d4/0x720 fs/ntfs3/inode.c:1712
 ntfs_rename+0x41a/0xcb0 fs/ntfs3/namei.c:276
 vfs_rename+0xd53/0x1130 fs/namei.c:4779
 do_renameat2+0xb53/0x1370 fs/namei.c:4930
 __do_sys_rename fs/namei.c:4976 [inline]
 __se_sys_rename fs/namei.c:4974 [inline]
 __x64_sys_rename+0x82/0x90 fs/namei.c:4974
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fb16d7e97c9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdc864b578 EFLAGS: 00000246 ORIG_RAX: 0000000000000052
RAX: ffffffffffffffda RBX: 0031656c69662f2e RCX: 00007fb16d7e97c9
RDX: 0000000000000030 RSI: 0000000020000080 RDI: 0000000020000040
RBP: 00007fb16d7a9060 R08: 000000000001f376 R09: 0000000000000000
R10: 00007ffdc864b440 R11: 0000000000000246 R12: 00007fb16d7a90f0
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

Allocated by task 3631:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x3d/0x60 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:371 [inline]
 __kasan_kmalloc+0x97/0xb0 mm/kasan/common.c:380
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slab_common.c:955 [inline]
 __kmalloc+0xaf/0x1a0 mm/slab_common.c:968
 kmalloc include/linux/slab.h:558 [inline]
 indx_read+0x29a/0x880 fs/ntfs3/index.c:978
 indx_find+0x491/0xb20 fs/ntfs3/index.c:1080
 indx_delete_entry+0x460/0x3670 fs/ntfs3/index.c:2167
 ni_remove_name+0x27a/0x980 fs/ntfs3/frecord.c:2910
 ntfs_unlink_inode+0x3d4/0x720 fs/ntfs3/inode.c:1712
 ntfs_rename+0x41a/0xcb0 fs/ntfs3/namei.c:276
 vfs_rename+0xd53/0x1130 fs/namei.c:4779
 do_renameat2+0xb53/0x1370 fs/namei.c:4930
 __do_sys_rename fs/namei.c:4976 [inline]
 __se_sys_rename fs/namei.c:4974 [inline]
 __x64_sys_rename+0x82/0x90 fs/namei.c:4974
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff888079cc0000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 1536 bytes inside of
 4096-byte region [ffff888079cc0000, ffff888079cc1000)

The buggy address belongs to the physical page:
page:ffffea0001e73000 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x79cc0
head:ffffea0001e73000 order:3 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 dead000000000100 dead000000000122 ffff888012842140
raw: 0000000000000000 0000000080040004 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 2999, tgid 2999 (udevd), ts 25263182361, free_ts 19241901550
 prep_new_page mm/page_alloc.c:2539 [inline]
 get_page_from_freelist+0x742/0x7c0 mm/page_alloc.c:4291
 __alloc_pages+0x259/0x560 mm/page_alloc.c:5558
 alloc_slab_page+0xbd/0x190 mm/slub.c:1794
 allocate_slab+0x5e/0x4b0 mm/slub.c:1939
 new_slab mm/slub.c:1992 [inline]
 ___slab_alloc+0x782/0xe20 mm/slub.c:3180
 __slab_alloc mm/slub.c:3279 [inline]
 slab_alloc_node mm/slub.c:3364 [inline]
 __kmem_cache_alloc_node+0x252/0x310 mm/slub.c:3437
 __do_kmalloc_node mm/slab_common.c:954 [inline]
 __kmalloc+0x9e/0x1a0 mm/slab_common.c:968
 kmalloc include/linux/slab.h:558 [inline]
 tomoyo_realpath_from_path+0xcd/0x5f0 security/tomoyo/realpath.c:251
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path_perm+0x227/0x670 security/tomoyo/file.c:822
 security_inode_getattr+0xc0/0x140 security/security.c:1347
 vfs_getattr fs/stat.c:158 [inline]
 vfs_statx+0x188/0x4a0 fs/stat.c:233
 vfs_fstatat fs/stat.c:267 [inline]
 __do_sys_newfstatat fs/stat.c:437 [inline]
 __se_sys_newfstatat+0xed/0x7d0 fs/stat.c:431
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
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
 slab_alloc mm/slub.c:3406 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3413 [inline]
 kmem_cache_alloc+0x1cc/0x300 mm/slub.c:3422
 vm_area_alloc+0x20/0xe0 kernel/fork.c:458
 mmap_region+0xd38/0x1e20 mm/mmap.c:2602
 do_mmap+0x8d9/0xf30 mm/mmap.c:1412
 vm_mmap_pgoff+0x19e/0x2b0 mm/util.c:520
 ksys_mmap_pgoff+0x48c/0x6d0 mm/mmap.c:1458
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff888079cc0f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888079cc0f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888079cc1000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                   ^
 ffff888079cc1080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888079cc1100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
