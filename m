Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D6664991C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 08:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbiLLHB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 02:01:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbiLLHB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 02:01:56 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60474BF42
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 23:01:55 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id z9-20020a6be009000000b006e0577c3686so5670122iog.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 23:01:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0mPgoMg87vPOKC0UjuNxDbWwpmOmscsf4VbkK7wqqwg=;
        b=n/f5qLvyCKuci3MJfy17Oy/43x8FLT3gXUxm10/w2XdLX0DHtMsvRrz9YMvNajj37a
         LSEvCMM6cYKtAdktYcwHA736Fah8TuJLfGzr8T6thRwVCGlBpCQS9NCybyI2cT7QrtHH
         jQsKFHOBjBOCXDDEiNxBVKXQArRUDHpBBXOAws46xctpsqFgB43/M6KnfR6joSb9uXnz
         dZ6NQsp5wtsgu6es9j5BUkNFrTeuENnENcLNSwN4R0i9y6Htnfn3zEo75+HPA4aJfPut
         /tBU2rKus9626DlGkL5sI4XIIlctUhPdfdOfwB6J4YN1gDssGj2daCJt3PlH/4yKrACL
         F2LQ==
X-Gm-Message-State: ANoB5pnHjziFdJO2zp77oZk8h2Jzw2XsbGpp6ZKY1HztEDS8gs3N6nkz
        hWueMyqX7OdcAVSdKW+7ww7dIuopDWwoVdhnXl3hKSWyaKXP
X-Google-Smtp-Source: AA0mqf4QZsRMXyeLfqq3XZnYm1GdTP4D0wyE7RvDzCPp1YR13yy0dSZ5WUVgQUFSfEcXgWup3y8V+ozK1sAoZWZpspcg4HpuVZ4o
MIME-Version: 1.0
X-Received: by 2002:a6b:c84f:0:b0:6e0:2b9e:b1c4 with SMTP id
 y76-20020a6bc84f000000b006e02b9eb1c4mr5255683iof.186.1670828514726; Sun, 11
 Dec 2022 23:01:54 -0800 (PST)
Date:   Sun, 11 Dec 2022 23:01:54 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000019e05005ef9c1481@google.com>
Subject: [syzbot] KASAN: stack-out-of-bounds Read in xfs_buf_delwri_submit_buffers
From:   syzbot <syzbot+d2cdeba65d32ed1d2c4d@syzkaller.appspotmail.com>
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

Hello,

syzbot found the following issue on:

HEAD commit:    3ecc37918c80 Merge tag 'media/v6.1-4' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=162de243880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d58e7fe7f9cf5e24
dashboard link: https://syzkaller.appspot.com/bug?extid=d2cdeba65d32ed1d2c4d
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=170a950b880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1625948f880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/be14794fd26b/disk-3ecc3791.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/35b850996388/vmlinux-3ecc3791.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0eec0f8f6777/bzImage-3ecc3791.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/f72864a73792/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d2cdeba65d32ed1d2c4d@syzkaller.appspotmail.com

XFS (loop5): Quotacheck: Done.
==================================================================
BUG: KASAN: stack-out-of-bounds in __lock_acquire+0x79/0x1f60 kernel/locking/lockdep.c:4925
Read of size 8 at addr ffffc9000cad7918 by task syz-executor223/5006

CPU: 1 PID: 5006 Comm: syz-executor223 Not tainted 6.1.0-rc8-syzkaller-00152-g3ecc37918c80 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 print_address_description+0x74/0x340 mm/kasan/report.c:284
 print_report+0x107/0x1f0 mm/kasan/report.c:395
 kasan_report+0xcd/0x100 mm/kasan/report.c:495
 __lock_acquire+0x79/0x1f60 kernel/locking/lockdep.c:4925
 lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0xb3/0x100 kernel/locking/spinlock.c:162
 down+0x35/0xb0 kernel/locking/semaphore.c:59
 xfs_buf_lock fs/xfs/xfs_buf.c:1120 [inline]
 xfs_buf_delwri_submit_buffers+0x22e/0x820 fs/xfs/xfs_buf.c:2164
 xfs_buf_delwri_submit+0xbb/0x320 fs/xfs/xfs_buf.c:2242
 xfs_qm_shrink_scan+0x1ca/0x410 fs/xfs/xfs_qm.c:514
 do_shrink_slab+0x4e1/0xa00 mm/vmscan.c:842
 shrink_slab+0x1e6/0x340 mm/vmscan.c:1002
 drop_slab_node mm/vmscan.c:1037 [inline]
 drop_slab+0x185/0x2c0 mm/vmscan.c:1047
 drop_caches_sysctl_handler+0xb1/0x160 fs/drop_caches.c:66
 proc_sys_call_handler+0x576/0x890 fs/proc/proc_sysctl.c:604
 do_iter_write+0x6c2/0xc20 fs/read_write.c:861
 iter_file_splice_write+0x7fc/0xfc0 fs/splice.c:686
 do_splice_from fs/splice.c:764 [inline]
 direct_splice_actor+0xe6/0x1c0 fs/splice.c:931
 splice_direct_to_actor+0x4e4/0xc00 fs/splice.c:886
 do_splice_direct+0x279/0x3d0 fs/splice.c:974
 do_sendfile+0x5fb/0xf80 fs/read_write.c:1255
 __do_sys_sendfile64 fs/read_write.c:1317 [inline]
 __se_sys_sendfile64+0xd0/0x1b0 fs/read_write.c:1309
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fb176007db9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 31 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff863d4df8 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 0000000000055e8c RCX: 00007fb176007db9
RDX: 0000000020002080 RSI: 0000000000000004 RDI: 0000000000000005
RBP: 0000000000000000 R08: 00007fff863d4e20 R09: 00007fff863d4e20
R10: 0000000000000870 R11: 0000000000000246 R12: 00007fff863d4e1c
R13: 00007fff863d4e50 R14: 00007fff863d4e30 R15: 000000000000001a
 </TASK>

The buggy address belongs to the virtual mapping at
 [ffffc9000cad0000, ffffc9000cad9000) created by:
 dup_task_struct+0x8b/0x490 kernel/fork.c:974

The buggy address belongs to the physical page:
page:ffffea0001dbf580 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x76fd6
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 0000000000000000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2dc2(GFP_KERNEL|__GFP_HIGHMEM|__GFP_NOWARN|__GFP_ZERO), pid 2, tgid 2 (kthreadd), ts 350542932176, free_ts 350448019466
 prep_new_page mm/page_alloc.c:2539 [inline]
 get_page_from_freelist+0x742/0x7c0 mm/page_alloc.c:4291
 __alloc_pages+0x259/0x560 mm/page_alloc.c:5558
 vm_area_alloc_pages mm/vmalloc.c:2975 [inline]
 __vmalloc_area_node mm/vmalloc.c:3043 [inline]
 __vmalloc_node_range+0x9b2/0x1400 mm/vmalloc.c:3213
 alloc_thread_stack_node+0x307/0x500 kernel/fork.c:311
 dup_task_struct+0x8b/0x490 kernel/fork.c:974
 copy_process+0x637/0x4000 kernel/fork.c:2084
 kernel_clone+0x21b/0x620 kernel/fork.c:2671
 kernel_thread+0x150/0x1d0 kernel/fork.c:2731
 create_kthread kernel/kthread.c:399 [inline]
 kthreadd+0x57c/0x750 kernel/kthread.c:746
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
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
 truncate_inode_pages_range+0x472/0x17f0 mm/truncate.c:373
 kill_bdev block/bdev.c:76 [inline]
 blkdev_flush_mapping+0x153/0x2c0 block/bdev.c:662
 blkdev_put_whole block/bdev.c:693 [inline]
 blkdev_put+0x4a5/0x730 block/bdev.c:953
 deactivate_locked_super+0xa7/0xf0 fs/super.c:332
 cleanup_mnt+0x494/0x520 fs/namespace.c:1186
 task_work_run+0x243/0x300 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop+0x124/0x150 kernel/entry/common.c:171
 exit_to_user_mode_prepare+0xb2/0x140 kernel/entry/common.c:203
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x26/0x60 kernel/entry/common.c:296
 do_syscall_64+0x49/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffffc9000cad7800: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc9000cad7880: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffc9000cad7900: f3 f3 f3 f3 f3 f3 f3 f3 00 00 00 00 00 00 00 00
                            ^
 ffffc9000cad7980: 00 00 00 00 00 00 00 00 00 00 00 00 f1 f1 f1 f1
 ffffc9000cad7a00: 00 00 f3 f3 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
