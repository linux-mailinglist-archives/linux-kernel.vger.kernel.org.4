Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24986C764C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 04:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjCXDi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 23:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjCXDi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 23:38:56 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A6A1721
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 20:38:54 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id v126-20020a6bac84000000b007587234a54cso453672ioe.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 20:38:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679629134;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=87x4VzUzYdjZDqhgHArtYo3fs+oZPTv5WxFwGQic5zE=;
        b=QTPnhToIY8o7NErDyOG3cetcg9qxgxN4FpszAZWoaiZHlF6tK0IpvFguXGW+V3+frH
         ZFeu3qYeuLZAG5HY3VLX/nEzmk93lMOMVD7Zi6tTfJf9yg4PPTYS2/7qoktHhdl3StB8
         YTFRNmjFYk5lesgUfEwvR2TfHFIhZETAcgLIhe7nd3pzK7cIVpAj0yir25WwXPVs+LlI
         h1xbGtxKml2RYEXDDwkGNd2XoU+300+mJY3WBH8oGSoNUxSWA1KFTX8/YBvFuH/kjn7I
         wnDBn2ClthRARe9pPKjLoTUuuKMe2iRtZ7kHThIpLgQPSYBC252+PBdyEdVKXENqvni/
         /l/A==
X-Gm-Message-State: AO0yUKUCNR5HOVStqQO/5qKFqcNjCEEsOk9UCY3QbaH0EmfpoZKnTgBE
        9+0crCXPdAa2d1nsTpDHiW/nAlELO0Iq7XkBpDkIgOcXAazx
X-Google-Smtp-Source: AK7set++5gUfbt5XPYoA6NPrDniPV0R5bcObaD4CKx2CYm6SrVBSyd6+CJd2G8lxkfo0IiJAHbYTnrfOt6tvpQgpUWoQcSHq6H/b
MIME-Version: 1.0
X-Received: by 2002:a6b:fe08:0:b0:752:ed8d:d015 with SMTP id
 x8-20020a6bfe08000000b00752ed8dd015mr513064ioh.1.1679629133908; Thu, 23 Mar
 2023 20:38:53 -0700 (PDT)
Date:   Thu, 23 Mar 2023 20:38:53 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e190b405f79d218b@google.com>
Subject: [syzbot] [udf?] KASAN: slab-out-of-bounds Write in udf_adinicb_writepage
From:   syzbot <syzbot+a3db10baf0c0ee459854@syzkaller.appspotmail.com>
To:     jack@suse.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    e8d018dd0257 Linux 6.3-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12c20a4ec80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d40f6d44826f6cf7
dashboard link: https://syzkaller.appspot.com/bug?extid=a3db10baf0c0ee459854
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=159fa1d6c80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17bbce16c80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/36c3f1b07e1e/disk-e8d018dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b45f2ee6f521/vmlinux-e8d018dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f03104e87ec4/bzImage-e8d018dd.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/64b4c6ef75d6/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a3db10baf0c0ee459854@syzkaller.appspotmail.com

UDF-fs: INFO Mounting volume 'LinuxUDF', timestamp 2022/11/22 14:59 (1000)
==================================================================
BUG: KASAN: slab-out-of-bounds in memcpy_from_page include/linux/highmem.h:391 [inline]
BUG: KASAN: slab-out-of-bounds in udf_adinicb_writepage+0x1e4/0x3f0 fs/udf/inode.c:196
Write of size 800 at addr ffff88801d399800 by task syz-executor314/8665

CPU: 1 PID: 8665 Comm: syz-executor314 Not tainted 6.3.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:319 [inline]
 print_report+0x163/0x540 mm/kasan/report.c:430
 kasan_report+0x176/0x1b0 mm/kasan/report.c:536
 kasan_check_range+0x283/0x290 mm/kasan/generic.c:187
 __asan_memcpy+0x40/0x70 mm/kasan/shadow.c:106
 memcpy_from_page include/linux/highmem.h:391 [inline]
 udf_adinicb_writepage+0x1e4/0x3f0 fs/udf/inode.c:196
 write_cache_pages+0x89e/0x12c0 mm/page-writeback.c:2473
 do_writepages+0x3a6/0x670 mm/page-writeback.c:2551
 filemap_fdatawrite_wbc+0x125/0x180 mm/filemap.c:390
 __filemap_fdatawrite_range mm/filemap.c:423 [inline]
 file_write_and_wait_range+0x20f/0x300 mm/filemap.c:781
 __generic_file_fsync+0x72/0x190 fs/libfs.c:1132
 generic_file_fsync+0x73/0xf0 fs/libfs.c:1173
 generic_write_sync include/linux/fs.h:2452 [inline]
 udf_file_write_iter+0x55b/0x660 fs/udf/file.c:126
 do_iter_write+0x6ea/0xc50 fs/read_write.c:861
 iter_file_splice_write+0x843/0xfe0 fs/splice.c:778
 do_splice_from fs/splice.c:856 [inline]
 direct_splice_actor+0xe7/0x1c0 fs/splice.c:1022
 splice_direct_to_actor+0x4c4/0xbd0 fs/splice.c:977
 do_splice_direct+0x283/0x3d0 fs/splice.c:1065
 do_sendfile+0x620/0xff0 fs/read_write.c:1255
 __do_sys_sendfile64 fs/read_write.c:1323 [inline]
 __se_sys_sendfile64+0x17c/0x1e0 fs/read_write.c:1309
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fc22ccad869
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 91 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc22cc512f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007fc22cd2c7c0 RCX: 00007fc22ccad869
RDX: 0000000000000000 RSI: 0000000000000007 RDI: 0000000000000006
RBP: 00007fc22ccf8e88 R08: 0000000000000000 R09: 0000000000000000
R10: 0001000000201005 R11: 0000000000000246 R12: 6573726168636f69
R13: 0030656c69662f2e R14: 0031656c69662f2e R15: 00007fc22cd2c7c8
 </TASK>

Allocated by task 8665:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:383
 kasan_kmalloc include/linux/kasan.h:196 [inline]
 __do_kmalloc_node mm/slab_common.c:967 [inline]
 __kmalloc+0xb9/0x230 mm/slab_common.c:980
 udf_new_inode+0x2e7/0xd10
 udf_create+0x21/0xe0 fs/udf/namei.c:384
 lookup_open fs/namei.c:3416 [inline]
 open_last_lookups fs/namei.c:3484 [inline]
 path_openat+0x13df/0x3170 fs/namei.c:3712
 do_filp_open+0x234/0x490 fs/namei.c:3742
 do_sys_openat2+0x13f/0x500 fs/open.c:1348
 do_sys_open fs/open.c:1364 [inline]
 __do_sys_creat fs/open.c:1440 [inline]
 __se_sys_creat fs/open.c:1434 [inline]
 __x64_sys_creat+0x123/0x160 fs/open.c:1434
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff88801d399800
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 0 bytes inside of
 allocated 336-byte region [ffff88801d399800, ffff88801d399950)

The buggy address belongs to the physical page:
page:ffffea000074e600 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1d398
head:ffffea000074e600 order:2 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 ffff888012441c80 ffffea00009f6a00 dead000000000002
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 341, tgid 341 (kworker/u4:0), ts 7858900157, free_ts 0
 prep_new_page mm/page_alloc.c:2552 [inline]
 get_page_from_freelist+0x3246/0x33c0 mm/page_alloc.c:4325
 __alloc_pages+0x255/0x670 mm/page_alloc.c:5591
 alloc_slab_page+0x6a/0x160 mm/slub.c:1851
 allocate_slab mm/slub.c:1998 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2051
 ___slab_alloc+0xa85/0x10a0 mm/slub.c:3193
 __slab_alloc mm/slub.c:3292 [inline]
 __slab_alloc_node mm/slub.c:3345 [inline]
 slab_alloc_node mm/slub.c:3442 [inline]
 __kmem_cache_alloc_node+0x1b8/0x290 mm/slub.c:3491
 kmalloc_trace+0x2a/0xe0 mm/slab_common.c:1061
 kmalloc include/linux/slab.h:580 [inline]
 kzalloc include/linux/slab.h:720 [inline]
 alloc_bprm+0x57/0x710 fs/exec.c:1511
 kernel_execve+0x96/0xa10 fs/exec.c:1985
 call_usermodehelper_exec_async+0x233/0x370 kernel/umh.c:110
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88801d399800: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88801d399880: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88801d399900: 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc
                                                 ^
 ffff88801d399980: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88801d399a00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
