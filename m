Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2C0645450
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 08:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiLGHAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 02:00:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiLGHAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 02:00:49 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DDB4EC06
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 23:00:48 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id o15-20020a6bf80f000000b006de313e5cfeso12983239ioh.6
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 23:00:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ucw3nYpJXRPLlC5lh3bgfdvB49nVLd/MO6a/6x+xcP0=;
        b=6g2+xUVUEiis4fY6QpISKBsQ5fMBmKRspPKGsqNpaePrpmjIDBw29eGyAhPUQF8EPf
         9QR3G3wPJFCKSVQKPlzybtf0ocnhV+3qWxMLnHBFtaYL3TM2bkw8RRi5tHeLTpA4vXEy
         vBmj/kggNo3C2s4MNgDFKALeKZ2skTr2g0iVTGfAKWkYKqYRwkFVeqk7Xip1SLUYnfrW
         h1fmTwkljjeTbi1i5PycR/koC+XAk+5w8C0xlxR+5SQojQtoufucKPz0g0weyRUMWVMR
         dLgS6fsM0CGA4kq/TkE2OkWSYlKkFFpHb20T0sPzIubkzI1SN282nwPJ71pmcPnP1xxo
         G+0w==
X-Gm-Message-State: ANoB5plCp0rtkQk+KvXtQsniihhiE60EEFd3ZuFRG6kZ3SoOe9aCUNdF
        oLxlZH/zC6prHXSkBmGyMZfcBkf08b0G1F/GgcK8hehdlYh0
X-Google-Smtp-Source: AA0mqf4dVSrdfQGmDym4pxMsH1xHsY17zDRlmwsZSfzJ8KCsUXRW7tXVs+2HP8oPj9f7MIhgcQzsr/lxkcO5p4Tg6trkh3yBArc2
MIME-Version: 1.0
X-Received: by 2002:a6b:3102:0:b0:6bf:e923:388b with SMTP id
 j2-20020a6b3102000000b006bfe923388bmr42986397ioa.105.1670396447962; Tue, 06
 Dec 2022 23:00:47 -0800 (PST)
Date:   Tue, 06 Dec 2022 23:00:47 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ea3c3105ef377a12@google.com>
Subject: [syzbot] KASAN: slab-out-of-bounds Read in ntfs_listxattr
From:   syzbot <syzbot+9fcea5ef6dc4dc72d334@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        nathan@kernel.org, ndesaulniers@google.com, ntfs3@lists.linux.dev,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
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

HEAD commit:    8ed710da2873 Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10027d97880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=50de433dd4debef8
dashboard link: https://syzkaller.appspot.com/bug?extid=9fcea5ef6dc4dc72d334
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=160e0797880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16bf79d5880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/75851d210874/disk-8ed710da.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c70846514634/vmlinux-8ed710da.xz
kernel image: https://storage.googleapis.com/syzbot-assets/34393d745af1/bzImage-8ed710da.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/ce942d5850e5/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9fcea5ef6dc4dc72d334@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 4096
ntfs3: loop0: Different NTFS' sector size (1024) and media sector size (512)
==================================================================
BUG: KASAN: slab-out-of-bounds in ntfs_list_ea fs/ntfs3/xattr.c:191 [inline]
BUG: KASAN: slab-out-of-bounds in ntfs_listxattr+0x401/0x570 fs/ntfs3/xattr.c:710
Read of size 1 at addr ffff888021acaf3d by task syz-executor128/3632

CPU: 1 PID: 3632 Comm: syz-executor128 Not tainted 6.1.0-rc8-syzkaller-00014-g8ed710da2873 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e3/0x2cb lib/dump_stack.c:106
 print_address_description+0x74/0x340 mm/kasan/report.c:284
 print_report+0x107/0x220 mm/kasan/report.c:395
 kasan_report+0x139/0x170 mm/kasan/report.c:495
 ntfs_list_ea fs/ntfs3/xattr.c:191 [inline]
 ntfs_listxattr+0x401/0x570 fs/ntfs3/xattr.c:710
 vfs_listxattr fs/xattr.c:457 [inline]
 listxattr+0x293/0x2d0 fs/xattr.c:804
 path_listxattr fs/xattr.c:828 [inline]
 __do_sys_llistxattr fs/xattr.c:846 [inline]
 __se_sys_llistxattr fs/xattr.c:843 [inline]
 __x64_sys_llistxattr+0x174/0x230 fs/xattr.c:843
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fbd70b66749
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff05b9d818 EFLAGS: 00000246 ORIG_RAX: 00000000000000c3
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 00007fbd70b66749
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000200000c0
RBP: 00007fbd70b25fe0 R08: 000000000001f6fe R09: 0000000000000000
R10: 00007fff05b9d6e0 R11: 0000000000000246 R12: 00007fbd70b26070
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

Allocated by task 3632:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4c/0x70 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:371 [inline]
 __kasan_kmalloc+0x97/0xb0 mm/kasan/common.c:380
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slab_common.c:955 [inline]
 __kmalloc+0xaf/0x1a0 mm/slab_common.c:968
 kmalloc include/linux/slab.h:558 [inline]
 ntfs_read_ea+0x437/0x820 fs/ntfs3/xattr.c:110
 ntfs_list_ea fs/ntfs3/xattr.c:168 [inline]
 ntfs_listxattr+0x184/0x570 fs/ntfs3/xattr.c:710
 vfs_listxattr fs/xattr.c:457 [inline]
 listxattr+0x293/0x2d0 fs/xattr.c:804
 path_listxattr fs/xattr.c:828 [inline]
 __do_sys_llistxattr fs/xattr.c:846 [inline]
 __se_sys_llistxattr fs/xattr.c:843 [inline]
 __x64_sys_llistxattr+0x174/0x230 fs/xattr.c:843
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff888021acaf00
 which belongs to the cache kmalloc-64 of size 64
The buggy address is located 61 bytes inside of
 64-byte region [ffff888021acaf00, ffff888021acaf40)

The buggy address belongs to the physical page:
page:ffffea000086b280 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff888021aca080 pfn:0x21aca
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffffea0000796a40 dead000000000005 ffff888012841640
raw: ffff888021aca080 000000008020001d 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 46, tgid 46 (kworker/u4:3), ts 7050450825, free_ts 6956530319
 prep_new_page mm/page_alloc.c:2539 [inline]
 get_page_from_freelist+0x72b/0x7a0 mm/page_alloc.c:4291
 __alloc_pages+0x259/0x560 mm/page_alloc.c:5558
 alloc_slab_page+0xbd/0x190 mm/slub.c:1794
 allocate_slab+0x5e/0x4b0 mm/slub.c:1939
 new_slab mm/slub.c:1992 [inline]
 ___slab_alloc+0x7f4/0xeb0 mm/slub.c:3180
 __slab_alloc mm/slub.c:3279 [inline]
 slab_alloc_node mm/slub.c:3364 [inline]
 __kmem_cache_alloc_node+0x252/0x310 mm/slub.c:3437
 kmalloc_node_trace+0x23/0x60 mm/slab_common.c:1058
 kmalloc_node include/linux/slab.h:575 [inline]
 kzalloc_node include/linux/slab.h:700 [inline]
 __get_vm_area_node+0x13f/0x380 mm/vmalloc.c:2494
 __vmalloc_node_range+0x3a6/0x1400 mm/vmalloc.c:3173
 alloc_thread_stack_node+0x307/0x500 kernel/fork.c:311
 dup_task_struct+0x8b/0x490 kernel/fork.c:974
 copy_process+0x637/0x3fc0 kernel/fork.c:2084
 kernel_clone+0x227/0x640 kernel/fork.c:2671
 user_mode_thread+0x12d/0x190 kernel/fork.c:2747
 call_usermodehelper_exec_work+0x57/0x220 kernel/umh.c:175
 process_one_work+0x81c/0xd10 kernel/workqueue.c:2289
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1459 [inline]
 free_pcp_prepare+0x80c/0x8f0 mm/page_alloc.c:1509
 free_unref_page_prepare mm/page_alloc.c:3387 [inline]
 free_unref_page+0x7d/0x630 mm/page_alloc.c:3483
 __vunmap+0x867/0x9d0 mm/vmalloc.c:2713
 free_work+0x66/0x90 mm/vmalloc.c:97
 process_one_work+0x81c/0xd10 kernel/workqueue.c:2289
 worker_thread+0xb14/0x1330 kernel/workqueue.c:2436
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306

Memory state around the buggy address:
 ffff888021acae00: 00 00 00 00 01 fc fc fc fc fc fc fc fc fc fc fc
 ffff888021acae80: 00 00 00 00 01 fc fc fc fc fc fc fc fc fc fc fc
>ffff888021acaf00: 00 00 00 00 00 00 00 04 fc fc fc fc fc fc fc fc
                                        ^
 ffff888021acaf80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff888021acb000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
