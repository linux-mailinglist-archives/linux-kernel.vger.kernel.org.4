Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79BCB665ECF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 16:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234804AbjAKPJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 10:09:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232457AbjAKPJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 10:09:45 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AE8C53
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 07:09:44 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id 4-20020a6b1404000000b00704700d919cso656640iou.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 07:09:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/spnDawV/eFkbsSyHLWzb1Chyz08v/PTLTMKtmmIo4c=;
        b=NC9lkwj9S5MfljHRBCxwjDIV/XBvDG7G2akcQ98TvvVWphGxFouo4optARVEpWe5+p
         4bH+6vHseItauGI5CRbWGfgjjJ3ERRAfAxGdDutoH+PtQc2YOPXTaeGlbXvW2+HdH5kB
         2ahbDZLrxw2+7P6FfEPt5IgWye5Kgwnum8XwT/I+51j3DHI+pAeaEW/OrB4wbL1P0O6o
         b1ZFz0nxVG0zT6EcSMFnB0gyNXEl+hCkZdsI8/T9+PE0ytYHRnsZp3QVGtIXCvijmGIQ
         L4qJnLjW9VA24c1wKABxvhmBuITp1iQX5mRtniY9hLfbqKH1eAzEtUV0McNphSUxzzip
         w55Q==
X-Gm-Message-State: AFqh2kqxzSsSTCIguHH465UvNPUCTVtr5+NhMcihCoWFxtoIkRhraEzh
        ylCHVq9D1BaMHPKPeS8qbXTYRIS3EHtQb2UFG+5s7/6FLzwQ
X-Google-Smtp-Source: AMrXdXs/PjCnnOai/lEXHOMu/6yI7Q9QhSPZ/UO81JhL9wY9JiEXHpPDGANGwJ/Br9yzWFfIYCM1oQHGR9Jhho3E9kcyk27IRF+r
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aae:b0:30d:94b0:1138 with SMTP id
 l14-20020a056e021aae00b0030d94b01138mr1153442ilv.159.1673449783658; Wed, 11
 Jan 2023 07:09:43 -0800 (PST)
Date:   Wed, 11 Jan 2023 07:09:43 -0800
In-Reply-To: <0000000000004ab8ac05ef9b1578@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e7915705f1fe6339@google.com>
Subject: Re: [syzbot] [xfs?] KASAN: stack-out-of-bounds Read in xfs_buf_lock
From:   syzbot <syzbot+0bc698a422b5e4ac988c@syzkaller.appspotmail.com>
To:     djwong@kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    7dd4b804e080 Merge tag 'nfsd-6.2-3' of git://git.kernel.or..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1488d42c480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2b6ecad960fc703e
dashboard link: https://syzkaller.appspot.com/bug?extid=0bc698a422b5e4ac988c
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10c58bd2480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11cc664a480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e8f3d4c62796/disk-7dd4b804.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/eb3961bfb8a3/vmlinux-7dd4b804.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1b3589ad06f2/bzImage-7dd4b804.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/b6c0aa20f078/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0bc698a422b5e4ac988c@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: stack-out-of-bounds in instrument_atomic_read include/linux/instrumented.h:72 [inline]
BUG: KASAN: stack-out-of-bounds in atomic_read include/linux/atomic/atomic-instrumented.h:27 [inline]
BUG: KASAN: stack-out-of-bounds in xfs_buf_lock+0xd0/0x750 fs/xfs/xfs_buf.c:1118
Read of size 4 at addr ffffc9000654fbec by task syz-executor824/5676

CPU: 0 PID: 5676 Comm: syz-executor824 Not tainted 6.2.0-rc3-syzkaller-00021-g7dd4b804e080 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd1/0x138 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:306 [inline]
 print_report+0x15e/0x45d mm/kasan/report.c:417
 kasan_report+0xbf/0x1f0 mm/kasan/report.c:517
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0x141/0x190 mm/kasan/generic.c:189
 instrument_atomic_read include/linux/instrumented.h:72 [inline]
 atomic_read include/linux/atomic/atomic-instrumented.h:27 [inline]
 xfs_buf_lock+0xd0/0x750 fs/xfs/xfs_buf.c:1118
 xfs_buf_delwri_submit_buffers+0x131/0xae0 fs/xfs/xfs_buf.c:2165
 xfs_buf_delwri_submit+0x8a/0x260 fs/xfs/xfs_buf.c:2243
 xfs_qm_shrink_scan fs/xfs/xfs_qm.c:522 [inline]
 xfs_qm_shrink_scan+0x1a7/0x370 fs/xfs/xfs_qm.c:503
 do_shrink_slab+0x464/0xce0 mm/vmscan.c:843
 shrink_slab+0x175/0x660 mm/vmscan.c:1003
 drop_slab_node mm/vmscan.c:1031 [inline]
 drop_slab+0x13a/0x2a0 mm/vmscan.c:1049
 drop_caches_sysctl_handler+0xfa/0x110 fs/drop_caches.c:66
 proc_sys_call_handler+0x49c/0x6d0 fs/proc/proc_sysctl.c:604
 call_write_iter include/linux/fs.h:2189 [inline]
 do_iter_readv_writev+0x20b/0x3b0 fs/read_write.c:735
 do_iter_write+0x182/0x700 fs/read_write.c:861
 vfs_iter_write+0x74/0xa0 fs/read_write.c:902
 iter_file_splice_write+0x745/0xc90 fs/splice.c:686
 do_splice_from fs/splice.c:764 [inline]
 direct_splice_actor+0x114/0x180 fs/splice.c:931
 splice_direct_to_actor+0x335/0x8a0 fs/splice.c:886
 do_splice_direct+0x1ab/0x280 fs/splice.c:974
 do_sendfile+0xb19/0x1270 fs/read_write.c:1255
 __do_sys_sendfile64 fs/read_write.c:1317 [inline]
 __se_sys_sendfile64 fs/read_write.c:1309 [inline]
 __x64_sys_sendfile64+0x14d/0x210 fs/read_write.c:1309
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fd74df22779
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 01 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe1c61a0e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00000000000114e9 RCX: 00007fd74df22779
RDX: 0000000020002080 RSI: 0000000000000004 RDI: 0000000000000005
RBP: 0000000000000000 R08: 00007ffe1c61a110 R09: 00007ffe1c61a110
R10: 0000000000000870 R11: 0000000000000246 R12: 00007ffe1c61a10c
R13: 00007ffe1c61a140 R14: 00007ffe1c61a120 R15: 000000000000000b
 </TASK>

The buggy address belongs to the virtual mapping at
 [ffffc90006548000, ffffc90006551000) created by:
 kernel_clone+0xeb/0x990 kernel/fork.c:2681

The buggy address belongs to the physical page:
page:ffffea00008d3f00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x234fc
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 0000000000000000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2dc2(GFP_KERNEL|__GFP_HIGHMEM|__GFP_NOWARN|__GFP_ZERO), pid 2, tgid 2 (kthreadd), ts 71883428260, free_ts 70232816920
 prep_new_page mm/page_alloc.c:2531 [inline]
 get_page_from_freelist+0x119c/0x2ce0 mm/page_alloc.c:4283
 __alloc_pages+0x1cb/0x5b0 mm/page_alloc.c:5549
 alloc_pages+0x1aa/0x270 mm/mempolicy.c:2286
 vm_area_alloc_pages mm/vmalloc.c:2989 [inline]
 __vmalloc_area_node mm/vmalloc.c:3057 [inline]
 __vmalloc_node_range+0x978/0x13c0 mm/vmalloc.c:3227
 alloc_thread_stack_node kernel/fork.c:311 [inline]
 dup_task_struct kernel/fork.c:987 [inline]
 copy_process+0x12d2/0x7520 kernel/fork.c:2097
 kernel_clone+0xeb/0x990 kernel/fork.c:2681
 kernel_thread+0xb9/0xf0 kernel/fork.c:2741
 create_kthread kernel/kthread.c:399 [inline]
 kthreadd+0x4f2/0x750 kernel/kthread.c:746
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1446 [inline]
 free_pcp_prepare+0x65c/0xc00 mm/page_alloc.c:1496
 free_unref_page_prepare mm/page_alloc.c:3369 [inline]
 free_unref_page_list+0x176/0xcd0 mm/page_alloc.c:3510
 release_pages+0xcb1/0x1330 mm/swap.c:1076
 tlb_batch_pages_flush+0xa8/0x1a0 mm/mmu_gather.c:97
 tlb_flush_mmu_free mm/mmu_gather.c:292 [inline]
 tlb_flush_mmu mm/mmu_gather.c:299 [inline]
 tlb_finish_mmu+0x14b/0x7e0 mm/mmu_gather.c:391
 exit_mmap+0x202/0x7b0 mm/mmap.c:3096
 __mmput+0x128/0x4c0 kernel/fork.c:1207
 mmput+0x60/0x70 kernel/fork.c:1229
 exit_mm kernel/exit.c:563 [inline]
 do_exit+0x9ac/0x2950 kernel/exit.c:854
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1012
 __do_sys_exit_group kernel/exit.c:1023 [inline]
 __se_sys_exit_group kernel/exit.c:1021 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1021
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffffc9000654fa80: 00 00 00 00 00 f1 f1 f1 f1 00 00 f3 f3 00 00 00
 ffffc9000654fb00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffc9000654fb80: 00 00 00 00 00 00 00 00 00 00 00 f1 f1 f1 f1 04
                                                          ^
 ffffc9000654fc00: f2 04 f2 00 f2 f2 f2 00 f3 f3 f3 00 00 00 00 00
 ffffc9000654fc80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================

