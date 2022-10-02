Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032FC5F240A
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 18:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiJBQPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 12:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiJBQPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 12:15:19 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B44729CA3;
        Sun,  2 Oct 2022 09:15:13 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id k6so9262310vsc.8;
        Sun, 02 Oct 2022 09:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=wJlej1HM9ab6lOHyqFd26DZnUWyb4gmTLZNj9eVcVHI=;
        b=bvwxlE68oBoN5qNhHFK33aONmX51jZR6/EBvrkCr5Fm5oy/Q0Do6l1YeTzrZmMH455
         NGaB8yYodqcCGP3f053VQz4iAQvENdnFJqwbOABPgphaZqABpwPJHu/mZ7J3YWsfmh2N
         YK886sseOggCl9TMoDPPmzVazII6+oOTXf50qfyyY4daUO30m0iKhHSxVZqVHfNDB0hw
         vDbQsPiX85DUhsW0k3cSvi/E/t+Wr49/PA1kXGxemHjZyuLFpCBN9JD9Sjt8bdQIxCQr
         nXRVCJlxsU6B/F8S1C/dYsJsLBrk7SRBaBvPIcKM22t6nCaCJU9g/C78MuG6cKvc6u9f
         0glA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=wJlej1HM9ab6lOHyqFd26DZnUWyb4gmTLZNj9eVcVHI=;
        b=PC6g+P3Au9tVkqjXZINJZpftE+XuRcxoDxJ9IBLebpdIKRhfQpJzmQi+vxmJ5bMz0d
         Xcn2mMheaR1OykqsivuuUEpkAP+TvI0mV6MSOLsR2yFFcGNFWUU4ujwjK2C1ZTQkIL7K
         b6oAYYaRQpkNjKmHFxeuQ0Tlz15p2SF1H7tF4iV5cqskaU3Mj2+5e+n0emhKFHP6Hf9l
         HWttXhcsJTy5hbsB6I2RyCVIIpwDu1+3wT+e/slbXj2RDAYEdt5T7xULqnwFfN21pnJ2
         PDW3JFHz6tx5hicuTSKKAFEszBuzufzVYhLgzTGp5Mq1Uj0Qi7fw6595lXtgfrJu2ukF
         bFcg==
X-Gm-Message-State: ACrzQf0tRJwDOY+FBczfpPySLoa971Dk7O0QIrx/s7ieLGQM8ZTtsf5R
        n3fvIhbEi2DyNyY/TC6dAB5caqDHmS2KK4RhbH3SwlhcuAKBjw==
X-Google-Smtp-Source: AMsMyM4RKF0OUSlJq5JrIwblWR7ss5EQZJWJG1n2NNNJwOWX1mYqVAacSAfe1k0S2Y6El0clDAKkU7rXm1fQZtlCx4E=
X-Received: by 2002:a67:b20d:0:b0:39b:1c96:7ae with SMTP id
 b13-20020a67b20d000000b0039b1c9607aemr7425454vsf.68.1664727311176; Sun, 02
 Oct 2022 09:15:11 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000b1fdd605e9f95a77@google.com>
In-Reply-To: <000000000000b1fdd605e9f95a77@google.com>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Mon, 3 Oct 2022 01:14:54 +0900
Message-ID: <CAKFNMonx5jw2axur8qXP+Dq+xen3Xg9gm9Yrqfx_Vv3DLk7ciw@mail.gmail.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in nilfs_test_metadata_dirty
To:     syzbot <syzbot+2ff4a42302a8dd97efc6@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-nilfs@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 1, 2022 at 10:47 PM syzbot wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    70575e77839f Merge tag 'for_linus' of git://git.kernel.org..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=15ea1fa8880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ba0d23aa7e1ffaf5
> dashboard link: https://syzkaller.appspot.com/bug?extid=2ff4a42302a8dd97efc6
> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15b897ef080000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=131b8598880000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/d99310e4b1b7/disk-70575e77.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/ef3a5647354c/vmlinux-70575e77.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+2ff4a42302a8dd97efc6@syzkaller.appspotmail.com
>
> loop0: detected capacity change from 0 to 2048
> ==================================================================
> BUG: KASAN: use-after-free in nilfs_test_metadata_dirty+0x39/0x210 fs/nilfs2/segment.c:813
> Read of size 8 at addr ffff88814012ae30 by task syz-executor314/3615
>
> CPU: 0 PID: 3615 Comm: syz-executor314 Not tainted 6.0.0-rc7-syzkaller-00180-g70575e77839f #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
>  print_address_description+0x65/0x4b0 mm/kasan/report.c:317
>  print_report+0x108/0x1f0 mm/kasan/report.c:433
>  kasan_report+0xc3/0xf0 mm/kasan/report.c:495
>  nilfs_test_metadata_dirty+0x39/0x210 fs/nilfs2/segment.c:813
>  nilfs_segctor_confirm+0x78/0x2d0 fs/nilfs2/segment.c:837
>  nilfs_segctor_destroy fs/nilfs2/segment.c:2729 [inline]
>  nilfs_detach_log_writer+0x4c1/0xbd0 fs/nilfs2/segment.c:2810
>  nilfs_put_super+0x4b/0x150 fs/nilfs2/super.c:468
>  generic_shutdown_super+0x128/0x300 fs/super.c:491
>  kill_block_super+0x79/0xd0 fs/super.c:1427
>  deactivate_locked_super+0xa7/0xf0 fs/super.c:332
>  cleanup_mnt+0x4ce/0x560 fs/namespace.c:1186
>  task_work_run+0x146/0x1c0 kernel/task_work.c:177
>  exit_task_work include/linux/task_work.h:38 [inline]
>  do_exit+0x55e/0x20a0 kernel/exit.c:795
>  do_group_exit+0x23b/0x2f0 kernel/exit.c:925
>  __do_sys_exit_group kernel/exit.c:936 [inline]
>  __se_sys_exit_group kernel/exit.c:934 [inline]
>  __x64_sys_exit_group+0x3b/0x40 kernel/exit.c:934
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f7c0b111689
> Code: Unable to access opcode bytes at RIP 0x7f7c0b11165f.
> RSP: 002b:00007ffc6dfe57a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
> RAX: ffffffffffffffda RBX: 00007f7c0b18c3f0 RCX: 00007f7c0b111689
> RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000001
> RBP: 0000000000000001 R08: ffffffffffffffc0 R09: bb1414ac6dfe5827
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f7c0b18c3f0
> R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
>  </TASK>
>
> Allocated by task 3615:
>  kasan_save_stack mm/kasan/common.c:38 [inline]
>  kasan_set_track mm/kasan/common.c:45 [inline]
>  set_alloc_info mm/kasan/common.c:437 [inline]
>  ____kasan_kmalloc+0xcd/0x100 mm/kasan/common.c:516
>  kasan_kmalloc include/linux/kasan.h:234 [inline]
>  kmem_cache_alloc_trace+0x97/0x310 mm/slub.c:3289
>  kmalloc include/linux/slab.h:600 [inline]
>  kzalloc include/linux/slab.h:733 [inline]
>  nilfs_find_or_create_root+0x142/0x4f0 fs/nilfs2/the_nilfs.c:747
>  nilfs_attach_checkpoint+0xcd/0x4a0 fs/nilfs2/super.c:519
>  nilfs_fill_super+0x2e8/0x5d0 fs/nilfs2/super.c:1064
>  nilfs_mount+0x613/0x9b0 fs/nilfs2/super.c:1317
>  legacy_get_tree+0xea/0x180 fs/fs_context.c:610
>  vfs_get_tree+0x88/0x270 fs/super.c:1530
>  do_new_mount+0x289/0xad0 fs/namespace.c:3040
>  do_mount fs/namespace.c:3383 [inline]
>  __do_sys_mount fs/namespace.c:3591 [inline]
>  __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3568
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> Freed by task 3615:
>  kasan_save_stack mm/kasan/common.c:38 [inline]
>  kasan_set_track+0x3d/0x60 mm/kasan/common.c:45
>  kasan_set_free_info+0x1f/0x40 mm/kasan/generic.c:370
>  ____kasan_slab_free+0xd8/0x120 mm/kasan/common.c:367
>  kasan_slab_free include/linux/kasan.h:200 [inline]
>  slab_free_hook mm/slub.c:1759 [inline]
>  slab_free_freelist_hook+0x12e/0x1a0 mm/slub.c:1785
>  slab_free mm/slub.c:3539 [inline]
>  kfree+0xda/0x210 mm/slub.c:4567
>  nilfs_evict_inode+0xe5/0x3d0 fs/nilfs2/inode.c:908
>  evict+0x2a4/0x620 fs/inode.c:665
>  dispose_list fs/inode.c:698 [inline]
>  evict_inodes+0x658/0x700 fs/inode.c:748
>  generic_shutdown_super+0x94/0x300 fs/super.c:480
>  kill_block_super+0x79/0xd0 fs/super.c:1427
>  deactivate_locked_super+0xa7/0xf0 fs/super.c:332
>  cleanup_mnt+0x4ce/0x560 fs/namespace.c:1186
>  task_work_run+0x146/0x1c0 kernel/task_work.c:177
>  exit_task_work include/linux/task_work.h:38 [inline]
>  do_exit+0x55e/0x20a0 kernel/exit.c:795
>  do_group_exit+0x23b/0x2f0 kernel/exit.c:925
>  __do_sys_exit_group kernel/exit.c:936 [inline]
>  __se_sys_exit_group kernel/exit.c:934 [inline]
>  __x64_sys_exit_group+0x3b/0x40 kernel/exit.c:934
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> The buggy address belongs to the object at ffff88814012ae00
>  which belongs to the cache kmalloc-256 of size 256
> The buggy address is located 48 bytes inside of
>  256-byte region [ffff88814012ae00, ffff88814012af00)
>
> The buggy address belongs to the physical page:
> page:ffffea0005004a80 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x14012a
> head:ffffea0005004a80 order:1 compound_mapcount:0 compound_pincount:0
> flags: 0x57ff00000010200(slab|head|node=1|zone=2|lastcpupid=0x7ff)
> raw: 057ff00000010200 ffffea0005004a00 dead000000000003 ffff888012041b40
> raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (swapper/0), ts 6972671988, free_ts 0
>  prep_new_page mm/page_alloc.c:2532 [inline]
>  get_page_from_freelist+0x742/0x7c0 mm/page_alloc.c:4283
>  __alloc_pages+0x259/0x560 mm/page_alloc.c:5549
>  alloc_page_interleave+0x22/0x1c0 mm/mempolicy.c:2103
>  alloc_slab_page+0x70/0xf0 mm/slub.c:1829
>  allocate_slab+0x5e/0x520 mm/slub.c:1974
>  new_slab mm/slub.c:2034 [inline]
>  ___slab_alloc+0x3ee/0xc40 mm/slub.c:3036
>  __slab_alloc mm/slub.c:3123 [inline]
>  slab_alloc_node mm/slub.c:3214 [inline]
>  slab_alloc mm/slub.c:3256 [inline]
>  kmem_cache_alloc_trace+0x25f/0x310 mm/slub.c:3287
>  kmalloc include/linux/slab.h:600 [inline]
>  kzalloc include/linux/slab.h:733 [inline]
>  bus_add_driver+0xde/0x600 drivers/base/bus.c:602
>  driver_register+0x2e9/0x3e0 drivers/base/driver.c:246
>  do_one_initcall+0x1b9/0x3e0 init/main.c:1296
>  do_initcall_level+0x168/0x218 init/main.c:1369
>  do_initcalls+0x4b/0x8c init/main.c:1385
>  kernel_init_freeable+0x3f1/0x57b init/main.c:1623
>  kernel_init+0x19/0x2b0 init/main.c:1512
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
> page_owner free stack trace missing
>
> Memory state around the buggy address:
>  ffff88814012ad00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff88814012ad80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> >ffff88814012ae00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                                      ^
>  ffff88814012ae80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff88814012af00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ==================================================================
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this issue, for details see:
> https://goo.gl/tpsmEJ#testing-patches

#syz dup: KASAN: use-after-free Read in nilfs_segctor_confirm

Based on the analysis so far, this issue is due to the same cause as
the issue above.

Ryusuke Konishi
