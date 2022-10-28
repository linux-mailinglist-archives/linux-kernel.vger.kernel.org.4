Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419E1611BB2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 22:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiJ1Umx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 16:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiJ1Umr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 16:42:47 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DC323922B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 13:42:45 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id x19-20020a0566022c5300b006c7e5c33b6eso4222083iov.7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 13:42:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+RJmYcVdDq8KxDZxpRtEnpnur5rE3IEOXgOv5w8AZK8=;
        b=l8E7TwZTGKw8B+MiMmslrB0DbXBMNGolbztMvoNI0j2oU2xt734aZRWaQAZjVcNrVj
         IHpGK6kvrRrmDNbmfuyby3OS1K87P1/rJWcBaMNF5xOZn9KjasEdAqxtScGsvMobtAPS
         /X5rug+GU32tScCs2SyyX0oVrhMKLRa8/XW5n2NeI+McOK6Cu+nC8t3+pUcMaw1ZnqCP
         NLuOwATmvZ+9y/DlfMdiWMsSZ6aY4ztiZgluQt9DnNbfy34qC6BmsGz3AKVVGORRl7Cd
         ekt1zmxGuOfn1Rj+VMqQ52atkhu6kITm2oNjAjbHKF0S+TmN1iStBVpGP0I64VJcim4I
         GdTw==
X-Gm-Message-State: ACrzQf3yvL5Bytezdpra4mprxNEbNjNj50QoqyatmiC0TX9r68VP2+/y
        y5BwuY201Tt5rfwpC+RFbvfUMTluJ10ZbCrxvGUbNZxJVVdl
X-Google-Smtp-Source: AMsMyM7XGLqVBjNvBLjNM4DUC7oibxYdFhbE/h9bhCtgQg76dGxY16o9Wzdiz2gWTHna/+/JtMbhEIdw7u9U19Jf9m6uLGuj9DEH
MIME-Version: 1.0
X-Received: by 2002:a05:6602:14c1:b0:689:34d0:a0ef with SMTP id
 b1-20020a05660214c100b0068934d0a0efmr656677iow.69.1666989765194; Fri, 28 Oct
 2022 13:42:45 -0700 (PDT)
Date:   Fri, 28 Oct 2022 13:42:45 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cc796105ec1e4c7b@google.com>
Subject: [syzbot] KASAN: vmalloc-out-of-bounds Read in cleanup_bitmap_list
From:   syzbot <syzbot+174ea873dedcd7fb6de3@syzkaller.appspotmail.com>
To:     bvanassche@acm.org, damien.lemoal@opensource.wdc.com, jack@suse.cz,
        jlayton@kernel.org, linux-kernel@vger.kernel.org, neilb@suse.de,
        reiserfs-devel@vger.kernel.org, song@kernel.org,
        syzkaller-bugs@googlegroups.com, willy@infradead.org,
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
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17752b36880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d3548a4365ba17d
dashboard link: https://syzkaller.appspot.com/bug?extid=174ea873dedcd7fb6de3
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1377875a880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=160063ce880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/24728b72a896/disk-b229b6ca.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/10a3c40c60e1/vmlinux-b229b6ca.xz
kernel image: https://storage.googleapis.com/syzbot-assets/69f963b02b7e/bzImage-b229b6ca.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/bf92a420a87f/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+174ea873dedcd7fb6de3@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: vmalloc-out-of-bounds in cleanup_bitmap_list+0x181/0x520 fs/reiserfs/journal.c:231
Read of size 8 at addr ffffc90000b1e008 by task syz-executor487/3616

CPU: 1 PID: 3616 Comm: syz-executor487 Not tainted 6.1.0-rc2-syzkaller-00105-gb229b6ca5abb #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 print_address_description+0x74/0x340 mm/kasan/report.c:284
 print_report+0x107/0x1f0 mm/kasan/report.c:395
 kasan_report+0xcd/0x100 mm/kasan/report.c:495
 cleanup_bitmap_list+0x181/0x520 fs/reiserfs/journal.c:231
 free_list_bitmaps+0x48/0x1a0 fs/reiserfs/journal.c:249
 free_journal_ram+0xf7/0x400 fs/reiserfs/journal.c:1887
 do_journal_release fs/reiserfs/journal.c:1960 [inline]
 journal_release_error+0x76/0x90 fs/reiserfs/journal.c:1978
 reiserfs_fill_super+0x1115/0x24a0 fs/reiserfs/super.c:2223
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
RIP: 0033:0x7fc6ca28fd1a
Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 a8 00 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc6ca23b0e8 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fc6ca28fd1a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007fc6ca23b100
RBP: 0000000000000004 R08: 00007fc6ca23b140 R09: 00007fc6ca23b6b8
R10: 000000000020040a R11: 0000000000000286 R12: 00007fc6ca23b140
R13: 0000000000000008 R14: 00007fc6ca23b100 R15: 0000000020000600
 </TASK>

The buggy address belongs to the virtual mapping at
 [ffffc90000b1e000, ffffc90000b20000) created by:
 reiserfs_allocate_list_bitmaps+0x4c/0x220 fs/reiserfs/journal.c:290

The buggy address belongs to the physical page:
page:ffffea0001dbff40 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x76ffd
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 0000000000000000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2dc2(GFP_KERNEL|__GFP_HIGHMEM|__GFP_NOWARN|__GFP_ZERO), pid 3616, tgid 3611 (syz-executor487), ts 38397863032, free_ts 29187098302
 prep_new_page mm/page_alloc.c:2538 [inline]
 get_page_from_freelist+0x742/0x7c0 mm/page_alloc.c:4287
 __alloc_pages+0x259/0x560 mm/page_alloc.c:5554
 __alloc_pages_bulk+0x7e0/0xe70 mm/page_alloc.c:5502
 vm_area_alloc_pages mm/vmalloc.c:2947 [inline]
 __vmalloc_area_node mm/vmalloc.c:3043 [inline]
 __vmalloc_node_range+0x74b/0x1290 mm/vmalloc.c:3213
 __vmalloc_node mm/vmalloc.c:3278 [inline]
 vzalloc+0x75/0x80 mm/vmalloc.c:3351
 reiserfs_allocate_list_bitmaps+0x4c/0x220 fs/reiserfs/journal.c:290
 journal_init+0x2de/0x2510 fs/reiserfs/journal.c:2733
 reiserfs_fill_super+0xf4b/0x24a0 fs/reiserfs/super.c:2022
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
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1458 [inline]
 free_pcp_prepare+0x80c/0x8f0 mm/page_alloc.c:1508
 free_unref_page_prepare mm/page_alloc.c:3386 [inline]
 free_unref_page+0x7d/0x5f0 mm/page_alloc.c:3482
 pipe_buf_release include/linux/pipe_fs_i.h:183 [inline]
 pipe_read+0x718/0x1340 fs/pipe.c:324
 call_read_iter include/linux/fs.h:2185 [inline]
 new_sync_read fs/read_write.c:389 [inline]
 vfs_read+0x7ac/0xbf0 fs/read_write.c:470
 ksys_read+0x177/0x2a0 fs/read_write.c:613
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffffc90000b1df00: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc90000b1df80: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
>ffffc90000b1e000: 00 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
                      ^
 ffffc90000b1e080: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc90000b1e100: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
