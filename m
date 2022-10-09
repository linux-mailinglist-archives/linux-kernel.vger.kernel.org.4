Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F90D5F897A
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 07:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiJIFoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 01:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiJIFom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 01:44:42 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86603BE
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 22:44:34 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id f15-20020a056e020b4f00b002fa34db70f0so6573610ilu.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Oct 2022 22:44:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fpFS3tXUJIJ1lvr8WD7oOeKm9COmA13LgY/8qZADTak=;
        b=vdx2MsRLNqgOFYvmYfZ7hJlWVtk4IYGyXrXIbExoJOLGPSqsJsUdfjLZa3ArOqH506
         KpISVc7mrl/4v9OTXGavG//zcPnEI1C9FXMlVCZ4kFLyGKWjMPJlIqu1gZMaA/eOANHL
         K4ObMKO/4RIJrN2l65D4xmUiKb/r5Sv3WVvNgj6V1A2XZM3zmNiHlHNFuTNps/ulURNi
         133tNej/kgpQhK+c/EhyjVZDoXQqqi1MjP1zWwUPgh2FzUuLAMBPX8iI1mCsluy1+0p8
         OyhOHdldL3b/VHjeJk1i+HliiAPrzVCmGEfzIjThi/NKy5/EAhnciAws41v6thxBmfgg
         XF2Q==
X-Gm-Message-State: ACrzQf0fjjWZZTPkPS3kz64rrGAbVrypy+DxQbOUjDmOIO+D/+xfavQs
        3pjyXMJ/qTC2n7EglRoF8i97m4gosEPiSi3ks1FV849/HrnT
X-Google-Smtp-Source: AMsMyM70qc/gzV4yqAeKQPQNgETmT3N23If+QxZYK/NIPv6NTMdvIGJiFrzLxXpYRdJFkLj2ZK9pyevEphEjbZL8RSyuKBOVGbK6
MIME-Version: 1.0
X-Received: by 2002:a02:a0ca:0:b0:363:4661:c7e0 with SMTP id
 i10-20020a02a0ca000000b003634661c7e0mr6563138jah.214.1665294274175; Sat, 08
 Oct 2022 22:44:34 -0700 (PDT)
Date:   Sat, 08 Oct 2022 22:44:34 -0700
In-Reply-To: <00000000000019201505ba43855e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a8ac5905ea9389f9@google.com>
Subject: Re: [syzbot] BUG: Bad page state (8)
From:   syzbot <syzbot+97ef6376738cb5104a71@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, hch@lst.de, kent.overstreet@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        sales@linkscomputer.com, syzkaller-bugs@googlegroups.com,
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    a6afa4199d3d Merge tag 'mailbox-v6.1' of git://git.linaro...
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13185e34880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e2021a61197ebe02
dashboard link: https://syzkaller.appspot.com/bug?extid=97ef6376738cb5104a71
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11b84b5c880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1334d00c880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b8f297fb220e/disk-a6afa419.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9b6bc23e32ef/vmlinux-a6afa419.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/058bad60fb03/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+97ef6376738cb5104a71@syzkaller.appspotmail.com

ERROR: (device loop0): remounting filesystem as read-only
=======================================================
WARNING: The mand mount option has been deprecated and
         and is ignored by this kernel. Remove the mand
         option from the mount to silence this warning.
=======================================================
BUG: Bad page state in process syz-executor306  pfn:70d41
page:ffffea0001c35040 refcount:0 mapcount:0 mapping:0000000000000000 index:0x2f pfn:0x70d41
flags: 0xfff00000002006(referenced|uptodate|private|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000002006 ffffea0001c35088 ffffea0001c355c8 0000000000000000
raw: 000000000000002f ffff88801fe96c98 00000000ffffffff 0000000000000000
page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x40c40(GFP_NOFS|__GFP_COMP), pid 3602, tgid 3602 (syz-executor306), ts 38348851793, free_ts 30056820819
 prep_new_page mm/page_alloc.c:2532 [inline]
 get_page_from_freelist+0x109b/0x2ce0 mm/page_alloc.c:4283
 __alloc_pages+0x1c7/0x510 mm/page_alloc.c:5549
 alloc_pages+0x1a6/0x270 mm/mempolicy.c:2270
 folio_alloc+0x1c/0x70 mm/mempolicy.c:2280
 filemap_alloc_folio+0x306/0x3a0 mm/filemap.c:970
 __filemap_get_folio+0x328/0xed0 mm/filemap.c:1970
 pagecache_get_page+0x2e/0x290 mm/folio-compat.c:104
 find_or_create_page include/linux/pagemap.h:613 [inline]
 grab_cache_page include/linux/pagemap.h:743 [inline]
 __get_metapage+0x262/0xef0 fs/jfs/jfs_metapage.c:613
 diNewExt+0x7e9/0x1a10 fs/jfs/jfs_imap.c:2265
 diAllocExt fs/jfs/jfs_imap.c:1945 [inline]
 diAllocAG+0x15f1/0x2200 fs/jfs/jfs_imap.c:1662
 diAlloc+0x82d/0x1730 fs/jfs/jfs_imap.c:1583
 ialloc+0x89/0xaa0 fs/jfs/jfs_inode.c:56
 jfs_mkdir+0x1f0/0xab0 fs/jfs/namei.c:225
 vfs_mkdir+0x489/0x740 fs/namei.c:4013
 do_mkdirat+0x28c/0x310 fs/namei.c:4038
 __do_sys_mkdir fs/namei.c:4058 [inline]
 __se_sys_mkdir fs/namei.c:4056 [inline]
 __x64_sys_mkdir+0xf2/0x140 fs/namei.c:4056
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1449 [inline]
 free_pcp_prepare+0x5e4/0xd20 mm/page_alloc.c:1499
 free_unref_page_prepare mm/page_alloc.c:3380 [inline]
 free_unref_page+0x19/0x4d0 mm/page_alloc.c:3476
 __folio_put_small mm/swap.c:105 [inline]
 __folio_put+0xc1/0x130 mm/swap.c:128
 folio_put include/linux/mm.h:1125 [inline]
 put_page include/linux/mm.h:1177 [inline]
 anon_pipe_buf_release+0x3f7/0x4b0 fs/pipe.c:138
 pipe_buf_release include/linux/pipe_fs_i.h:183 [inline]
 pipe_read+0x610/0x1100 fs/pipe.c:324
 call_read_iter include/linux/fs.h:2184 [inline]
 new_sync_read fs/read_write.c:389 [inline]
 vfs_read+0x7f6/0x930 fs/read_write.c:470
 ksys_read+0x1e8/0x250 fs/read_write.c:613
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
Modules linked in:
CPU: 0 PID: 3602 Comm: syz-executor306 Not tainted 6.0.0-syzkaller-09039-ga6afa4199d3d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 bad_page.cold+0x9c/0xbd mm/page_alloc.c:716
 check_free_page_bad mm/page_alloc.c:1288 [inline]
 check_free_page mm/page_alloc.c:1298 [inline]
 free_pages_prepare mm/page_alloc.c:1443 [inline]
 free_pcp_prepare+0x6bd/0xd20 mm/page_alloc.c:1499
 free_unref_page_prepare mm/page_alloc.c:3380 [inline]
 free_unref_page_list+0x16f/0xb90 mm/page_alloc.c:3522
 release_pages+0xbd3/0x1400 mm/swap.c:1012
 __pagevec_release+0x77/0x100 mm/swap.c:1032
 pagevec_release include/linux/pagevec.h:71 [inline]
 folio_batch_release include/linux/pagevec.h:135 [inline]
 truncate_inode_pages_range+0x318/0x1510 mm/truncate.c:373
 jfs_remount+0x4bd/0x640 fs/jfs/super.c:451
 legacy_reconfigure+0x115/0x180 fs/fs_context.c:633
 reconfigure_super+0x408/0xa30 fs/super.c:934
 do_remount fs/namespace.c:2702 [inline]
 path_mount+0x182c/0x1e20 fs/namespace.c:3362
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fc67425cb39
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcf34ad8f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fc67425cb39
RDX: 0000000000000000 RSI: 0000000020000180 RDI: 0000000000000000
RBP: 00007ffcf34ad920 R08: 0000000000000000 R09: 0000000032303633
R10: 0000000000000060 R11: 0000000000000246 R12: 00007ffcf34ada00
R13: 0000001200030083 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
BUG: Bad page state in process syz-executor306  pfn:70d42
page:ffffea0001c35080 refcount:0 mapcount:0 mapping:0000000000000000 index:0x2e pfn:0x70d42
flags: 0xfff00000002006(referenced|uptodate|private|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000002006 ffffea0001c350c8 ffffea0001c355c8 0000000000000000
raw: 000000000000002e ffff88801fe96ba0 00000000ffffffff 0000000000000000
page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x40c40(GFP_NOFS|__GFP_COMP), pid 3602, tgid 3602 (syz-executor306), ts 38348835963, free_ts 30056827399
 prep_new_page mm/page_alloc.c:2532 [inline]
 get_page_from_freelist+0x109b/0x2ce0 mm/page_alloc.c:4283
 __alloc_pages+0x1c7/0x510 mm/page_alloc.c:5549
 alloc_pages+0x1a6/0x270 mm/mempolicy.c:2270
 folio_alloc+0x1c/0x70 mm/mempolicy.c:2280
 filemap_alloc_folio+0x306/0x3a0 mm/filemap.c:970
 __filemap_get_folio+0x328/0xed0 mm/filemap.c:1970
 pagecache_get_page+0x2e/0x290 mm/folio-compat.c:104
 find_or_create_page include/linux/pagemap.h:613 [inline]
 grab_cache_page include/linux/pagemap.h:743 [inline]
 __get_metapage+0x262/0xef0 fs/jfs/jfs_metapage.c:613
 diNewExt+0x7e9/0x1a10 fs/jfs/jfs_imap.c:2265
 diAllocExt fs/jfs/jfs_imap.c:1945 [inline]
 diAllocAG+0x15f1/0x2200 fs/jfs/jfs_imap.c:1662
 diAlloc+0x82d/0x1730 fs/jfs/jfs_imap.c:1583
 ialloc+0x89/0xaa0 fs/jfs/jfs_inode.c:56
 jfs_mkdir+0x1f0/0xab0 fs/jfs/namei.c:225
 vfs_mkdir+0x489/0x740 fs/namei.c:4013
 do_mkdirat+0x28c/0x310 fs/namei.c:4038
 __do_sys_mkdir fs/namei.c:4058 [inline]
 __se_sys_mkdir fs/namei.c:4056 [inline]
 __x64_sys_mkdir+0xf2/0x140 fs/namei.c:4056
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1449 [inline]
 free_pcp_prepare+0x5e4/0xd20 mm/page_alloc.c:1499
 free_unref_page_prepare mm/page_alloc.c:3380 [inline]
 free_unref_page+0x19/0x4d0 mm/page_alloc.c:3476
 __folio_put_small mm/swap.c:105 [inline]
 __folio_put+0xc1/0x130 mm/swap.c:128
 folio_put include/linux/mm.h:1125 [inline]
 put_page include/linux/mm.h:1177 [inline]
 anon_pipe_buf_release+0x3f7/0x4b0 fs/pipe.c:138
 pipe_buf_release include/linux/pipe_fs_i.h:183 [inline]
 pipe_read+0x610/0x1100 fs/pipe.c:324
 call_read_iter include/linux/fs.h:2184 [inline]
 new_sync_read fs/read_write.c:389 [inline]
 vfs_read+0x7f6/0x930 fs/read_write.c:470
 ksys_read+0x1e8/0x250 fs/read_write.c:613
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
Modules linked in:
CPU: 0 PID: 3602 Comm: syz-executor306 Tainted: G    B              6.0.0-syzkaller-09039-ga6afa4199d3d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 bad_page.cold+0x9c/0xbd mm/page_alloc.c:716
 check_free_page_bad mm/page_alloc.c:1288 [inline]
 check_free_page mm/page_alloc.c:1298 [inline]
 free_pages_prepare mm/page_alloc.c:1443 [inline]
 free_pcp_prepare+0x6bd/0xd20 mm/page_alloc.c:1499
 free_unref_page_prepare mm/page_alloc.c:3380 [inline]
 free_unref_page_list+0x16f/0xb90 mm/page_alloc.c:3522
 release_pages+0xbd3/0x1400 mm/swap.c:1012
 __pagevec_release+0x77/0x100 mm/swap.c:1032
 pagevec_release include/linux/pagevec.h:71 [inline]
 folio_batch_release include/linux/pagevec.h:135 [inline]
 truncate_inode_pages_range+0x318/0x1510 mm/truncate.c:373
 jfs_remount+0x4bd/0x640 fs/jfs/super.c:451
 legacy_reconfigure+0x115/0x180 fs/fs_context.c:633
 reconfigure_super+0x408/0xa30 fs/super.c:934
 do_remount fs/namespace.c:2702 [inline]
 path_mount+0x182c/0x1e20 fs/namespace.c:3362
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fc67425cb39
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcf34ad8f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fc67425cb39
RDX: 0000000000000000 RSI: 0000000020000180 RDI: 0000000000000000
RBP: 00007ffcf34ad920 R08: 0000000000000000 R09: 0000000032303633
R10: 0000000000000060 R11: 0000000000000246 R12: 00007ffcf34ada00
R13: 0000001200030083 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
BUG: Bad page state in process syz-executor306  pfn:70d43
page:ffffea0001c350c0 refcount:0 mapcount:0 mapping:0000000000000000 index:0x2d pfn:0x70d43
flags: 0xfff00000002006(referenced|uptodate|private|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000002006 ffffea0001c34ec8 ffffea0001c355c8 0000000000000000
raw: 000000000000002d ffff88801fe96aa8 00000000ffffffff 0000000000000000
page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x40c40(GFP_NOFS|__GFP_COMP), pid 3602, tgid 3602 (syz-executor306), ts 38348815033, free_ts 30056832129
 prep_new_page mm/page_alloc.c:2532 [inline]
 get_page_from_freelist+0x109b/0x2ce0 mm/page_alloc.c:4283
 __alloc_pages+0x1c7/0x510 mm/page_alloc.c:5549
 alloc_pages+0x1a6/0x270 mm/mempolicy.c:2270
 folio_alloc+0x1c/0x70 mm/mempolicy.c:2280
 filemap_alloc_folio+0x306/0x3a0 mm/filemap.c:970
 __filemap_get_folio+0x328/0xed0 mm/filemap.c:1970
 pagecache_get_page+0x2e/0x290 mm/folio-compat.c:104
 find_or_create_page include/linux/pagemap.h:613 [inline]
 grab_cache_page include/linux/pagemap.h:743 [inline]
 __get_metapage+0x262/0xef0 fs/jfs/jfs_metapage.c:613
 diNewExt+0x7e9/0x1a10 fs/jfs/jfs_imap.c:2265
 diAllocExt fs/jfs/jfs_imap.c:1945 [inline]
 diAllocAG+0x15f1/0x2200 fs/jfs/jfs_imap.c:1662
 diAlloc+0x82d/0x1730 fs/jfs/jfs_imap.c:1583
 ialloc+0x89/0xaa0 fs/jfs/jfs_inode.c:56
 jfs_mkdir+0x1f0/0xab0 fs/jfs/namei.c:225
 vfs_mkdir+0x489/0x740 fs/namei.c:4013
 do_mkdirat+0x28c/0x310 fs/namei.c:4038
 __do_sys_mkdir fs/namei.c:4058 [inline]
 __se_sys_mkdir fs/namei.c:4056 [inline]
 __x64_sys_mkdir+0xf2/0x140 fs/namei.c:4056
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1449 [inline]
 free_pcp_prepare+0x5e4/0xd20 mm/page_alloc.c:1499
 free_unref_page_prepare mm/page_alloc.c:3380 [inline]
 free_unref_page+0x19/0x4d0 mm/page_alloc.c:3476
 __folio_put_small mm/swap.c:105 [inline]
 __folio_put+0xc1/0x130 mm/swap.c:128
 folio_put include/linux/mm.h:1125 [inline]
 put_page include/linux/mm.h:1177 [inline]
 anon_pipe_buf_release+0x3f7/0x4b0 fs/pipe.c:138
 pipe_buf_release include/linux/pipe_fs_i.h:183 [inline]
 pipe_read+0x610/0x1100 fs/pipe.c:324
 call_read_iter include/linux/fs.h:2184 [inline]
 new_sync_read fs/read_write.c:389 [inline]
 vfs_read+0x7f6/0x930 fs/read_write.c:470
 ksys_read+0x1e8/0x250 fs/read_write.c:613
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
Modules linked in:
CPU: 1 PID: 3602 Comm: syz-executor306 Tainted: G    B              6.0.0-syzkaller-09039-ga6afa4199d3d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 bad_page.cold+0x9c/0xbd mm/page_alloc.c:716
 check_free_page_bad mm/page_alloc.c:1288 [inline]
 check_free_page mm/page_alloc.c:1298 [inline]
 free_pages_prepare mm/page_alloc.c:1443 [inline]
 free_pcp_prepare+0x6bd/0xd20 mm/page_alloc.c:1499
 free_unref_page_prepare mm/page_alloc.c:3380 [inline]
 free_unref_page_list+0x16f/0xb90 mm/page_alloc.c:3522
 release_pages+0xbd3/0x1400 mm/swap.c:1012
 __pagevec_release+0x77/0x100 mm/swap.c:1032
 pagevec_release include/linux/pagevec.h:71 [inline]
 folio_batch_release include/linux/pagevec.h:135 [inline]
 truncate_inode_pages_range+0x318/0x1510 mm/truncate.c:373
 jfs_remount+0x4bd/0x640 fs/jfs/super.c:451
 legacy_reconfigure+0x115/0x180 fs/fs_context.c:633
 reconfigure_super+0x408/0xa30 fs/super.c:934
 do_remount fs/namespace.c:2702 [inline]
 path_mount+0x182c/0x1e20 fs/namespace.c:3362
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fc67425cb39
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcf34ad8f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fc

