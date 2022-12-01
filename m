Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD30063EFF7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 12:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiLALys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 06:54:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiLALyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 06:54:44 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394664F18C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 03:54:42 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id i1-20020a056e021d0100b00303357fe402so1648719ila.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 03:54:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8Wfl5e5wiBtgitPwDZw2Vzgqjf5obm5C3tgcs2CYhzk=;
        b=O1LcEgJI29taIRlwLJm+OGuqEsRe7Kl9xt8Ykc8s3IFxhirRrHWMXwn2xXJxaZoSyl
         BTUM0HpY0H2rbNuWFPvK+OWomfD+u/qqmXN5C0XLBA1iN7q3OoPNz2PwoRJY9/l08qN4
         6x3Woc5b7e7Ehu1r4zuPKW8ThyyaIKx2y4YPmsGd27+/Bi1sPDlDFdranOVjR/asuOlV
         G8GxQcRH0+nyfN0g+uMt7EM7P8WsXvV/wQ0cLV444DtmKRJTJzEagw49sIWUZAMPoect
         /f30eEr794LbQW4/2MFpI5cpB+EAzpCbxl38YMpo4P7RPZ6hZ/23zKAFYZGGC3ctSgcp
         9f+g==
X-Gm-Message-State: ANoB5pnjZOyPbKBfFrb602bFB4Gb2ziOUGq+dlqlqm0UL7sdoI195uxz
        470GLAuci7k3RiQB2OcNx11DBA54CmoJokAlc3eVG1l+3ps0
X-Google-Smtp-Source: AA0mqf5BbxkTrG3vRehTde0Ch+ILbFjV4VU9IBxM7GpsPARK4hPLbR+f18nwVihHSv7cpLt/vNVMkvNfa/3wgsI3/ASzq/fNLCpT
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:106d:b0:302:a6df:80a with SMTP id
 q13-20020a056e02106d00b00302a6df080amr20674013ilj.197.1669895681189; Thu, 01
 Dec 2022 03:54:41 -0800 (PST)
Date:   Thu, 01 Dec 2022 03:54:41 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e3af1a05eec2e287@google.com>
Subject: [syzbot] KASAN: use-after-free Read in leaf_paste_in_buffer
From:   syzbot <syzbot+55b82aea13452e3d128f@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, reiserfs-devel@vger.kernel.org,
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

HEAD commit:    04aa64375f48 drm/i915: fix TLB invalidation for Gen12 vide..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=120af47b880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2325e409a9a893e1
dashboard link: https://syzkaller.appspot.com/bug?extid=55b82aea13452e3d128f
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=179f39bb880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1082d8d5880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c7931c6633f6/disk-04aa6437.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9f73ec98f0cb/vmlinux-04aa6437.xz
kernel image: https://storage.googleapis.com/syzbot-assets/63f3355b068c/bzImage-04aa6437.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/897f7c1e79f7/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+55b82aea13452e3d128f@syzkaller.appspotmail.com

REISERFS (device loop0): Using r5 hash to sort names
REISERFS (device loop0): Created .reiserfs_priv - reserved for xattr storage.
==================================================================
BUG: KASAN: use-after-free in leaf_paste_in_buffer+0x739/0xca0
Read of size 80 at addr ffff88806fa50fe0 by task syz-executor881/3646

CPU: 1 PID: 3646 Comm: syz-executor881 Not tainted 6.1.0-rc7-syzkaller-00102-g04aa64375f48 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 print_address_description+0x74/0x340 mm/kasan/report.c:284
 print_report+0x107/0x1f0 mm/kasan/report.c:395
 kasan_report+0xcd/0x100 mm/kasan/report.c:495
 kasan_check_range+0x2a7/0x2e0 mm/kasan/generic.c:189
 memcpy+0x25/0x60 mm/kasan/shadow.c:65
 leaf_paste_in_buffer+0x739/0xca0
 leaf_copy_dir_entries+0x6e2/0xbf0 fs/reiserfs/lbalance.c:108
 leaf_copy_boundary_item+0xb7c/0x20f0 fs/reiserfs/lbalance.c:168
 leaf_copy_items fs/reiserfs/lbalance.c:551 [inline]
 leaf_move_items+0xc74/0x1330 fs/reiserfs/lbalance.c:726
 leaf_shift_left+0xb7/0x420 fs/reiserfs/lbalance.c:750
 balance_leaf_left fs/reiserfs/do_balan.c:616 [inline]
 balance_leaf+0x1579/0x123a0 fs/reiserfs/do_balan.c:1409
 do_balance+0x2d6/0x8d0 fs/reiserfs/do_balan.c:1888
 reiserfs_paste_into_item+0x740/0x880 fs/reiserfs/stree.c:2159
 reiserfs_get_block+0x223f/0x5180 fs/reiserfs/inode.c:1069
 __block_write_begin_int+0x54c/0x1a80 fs/buffer.c:1991
 reiserfs_write_begin+0x247/0x510 fs/reiserfs/inode.c:2775
 generic_perform_write+0x2e4/0x5e0 mm/filemap.c:3753
 __generic_file_write_iter+0x176/0x400 mm/filemap.c:3881
 generic_file_write_iter+0xab/0x310 mm/filemap.c:3913
 call_write_iter include/linux/fs.h:2199 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x7dc/0xc50 fs/read_write.c:584
 ksys_write+0x177/0x2a0 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7ff595fcba39
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffefc311618 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 000000000000db17 RCX: 00007ff595fcba39
RDX: 000000000000fea7 RSI: 00000000200001c0 RDI: 0000000000000006
RBP: 0000000000000000 R08: 00007ffefc311640 R09: 00007ffefc311640
R10: 00007ffefc311640 R11: 0000000000000246 R12: 00007ffefc31163c
R13: 00007ffefc311670 R14: 00007ffefc311650 R15: 0000000000000006
 </TASK>

The buggy address belongs to the physical page:
page:ffffea0001be9400 refcount:6 mapcount:0 mapping:ffff88801f8128f8 index:0x214 pfn:0x6fa50
memcg:ffff888140150000
aops:def_blk_aops ino:700000
flags: 0xfff00000002010(lru|private|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000002010 ffffea0001be9388 ffffea00007a5508 ffff88801f8128f8
raw: 0000000000000214 ffff88807007fae0 00000006ffffffff ffff888140150000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Movable, gfp_mask 0x148c48(GFP_NOFS|__GFP_NOFAIL|__GFP_COMP|__GFP_HARDWALL|__GFP_MOVABLE), pid 3646, tgid 3646 (syz-executor881), ts 56559691091, free_ts 56351514064
 prep_new_page mm/page_alloc.c:2539 [inline]
 get_page_from_freelist+0x742/0x7c0 mm/page_alloc.c:4291
 __alloc_pages+0x259/0x560 mm/page_alloc.c:5558
 folio_alloc+0x1a/0x50 mm/mempolicy.c:2295
 filemap_alloc_folio+0x7e/0x1c0 mm/filemap.c:971
 __filemap_get_folio+0x898/0x1260 mm/filemap.c:1965
 pagecache_get_page+0x28/0x260 mm/folio-compat.c:110
 find_or_create_page include/linux/pagemap.h:613 [inline]
 grow_dev_page+0xba/0x920 fs/buffer.c:946
 grow_buffers fs/buffer.c:1011 [inline]
 __getblk_slow fs/buffer.c:1038 [inline]
 __getblk_gfp+0x16c/0x290 fs/buffer.c:1333
 sb_getblk include/linux/buffer_head.h:356 [inline]
 get_empty_nodes+0x68a/0xd00 fs/reiserfs/fix_node.c:890
 fix_nodes+0x25e8/0x8920 fs/reiserfs/fix_node.c:2662
 reiserfs_insert_item+0xa78/0xcb0 fs/reiserfs/stree.c:2240
 reiserfs_new_inode+0x11c7/0x1cd0 fs/reiserfs/inode.c:2054
 reiserfs_create+0x39a/0x660 fs/reiserfs/namei.c:668
 lookup_open fs/namei.c:3413 [inline]
 open_last_lookups fs/namei.c:3481 [inline]
 path_openat+0x12d0/0x2df0 fs/namei.c:3711
 do_filp_open+0x264/0x4f0 fs/namei.c:3741
 do_sys_openat2+0x124/0x4e0 fs/open.c:1310
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1459 [inline]
 free_pcp_prepare+0x80c/0x8f0 mm/page_alloc.c:1509
 free_unref_page_prepare mm/page_alloc.c:3387 [inline]
 free_unref_page_list+0xb4/0x7b0 mm/page_alloc.c:3529
 release_pages+0x232a/0x25c0 mm/swap.c:1055
 __pagevec_release+0x7d/0xf0 mm/swap.c:1075
 pagevec_release include/linux/pagevec.h:71 [inline]
 folio_batch_release include/linux/pagevec.h:135 [inline]
 shmem_undo_range+0x89a/0x2260 mm/shmem.c:946
 shmem_truncate_range mm/shmem.c:1034 [inline]
 shmem_evict_inode+0x27f/0xab0 mm/shmem.c:1143
 evict+0x2a4/0x620 fs/inode.c:664
 __dentry_kill+0x3b1/0x5b0 fs/dcache.c:607
 dentry_kill+0xbb/0x290
 dput+0x1f3/0x410 fs/dcache.c:913
 __fput+0x5e4/0x880 fs/file_table.c:328
 task_work_run+0x243/0x300 kernel/task_work.c:179
 ptrace_notify+0x29a/0x340 kernel/signal.c:2354
 ptrace_report_syscall include/linux/ptrace.h:420 [inline]
 ptrace_report_syscall_exit include/linux/ptrace.h:482 [inline]
 syscall_exit_work+0x8c/0xe0 kernel/entry/common.c:251
 syscall_exit_to_user_mode_prepare+0x63/0xc0 kernel/entry/common.c:278
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0xa/0x60 kernel/entry/common.c:296

Memory state around the buggy address:
 ffff88806fa50f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88806fa50f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88806fa51000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                   ^
 ffff88806fa51080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88806fa51100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
