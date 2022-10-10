Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC35E5F9CE9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 12:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbiJJKho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 06:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbiJJKhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 06:37:38 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B52B5B079;
        Mon, 10 Oct 2022 03:37:34 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id x20so3763024ual.6;
        Mon, 10 Oct 2022 03:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lJePhEkcfvtqVjXyTYAsPmZGrg5dUsoJJb0cOc77+/k=;
        b=GDqA5eRqlre63tZl505lHxN5zGa7/f2sLW0ujfkDHfz//u/p6u6G1uMGzurl9zM3aM
         SeoVa0GmvN4WD7A8uO8P16tK2txGduDeSMa/rgjY83c/Qs/KlbEl3s2Zc5pCoGQhKV+Z
         u+Dg6IeQknQWlfq3oUVq9NLo5NQyGEHBFQHpihJtBbaGCZF1wSdk25pL1mnMAHblTgEs
         H0E6FaSS4wQ8GplRUH+vdc4O18z2jsHyIFjRIJNkOKkndESAB0EZa/lSpPWsUGVDk9fm
         sXw7Jz+AsYK+WrwKOVcO86a+qtDEvFwDReeIlIOYVVk6TAvSLnvaTAm/xh6K5uHvrxzp
         tVow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lJePhEkcfvtqVjXyTYAsPmZGrg5dUsoJJb0cOc77+/k=;
        b=veIlSM/LpTrDnaRRak3jOi+kYBOdL75rXhfGgFQgpjDkqpBsD2FIP0vvAhyhpGW5Xp
         Spar70yjPQMfGSBs+UW9ECYmuESFxLaFHlY/SvIU0exlWtQagHh3X1X3E9M1rRwT6gF6
         xL1GvslPLi6cKIuEnzTha1lMCqLceYJ6ahQ7p8bMlnoTk9n++vdzxgZRdgxHIzgPXjsq
         /9+ykVPZb8PfVms5OReVrkTZUdTADDF7loUwoVzR3xCLzVQQBKolly0g+yVqZx5IQcha
         y53g9BmBxjNHYx6uoboK8O9aBbhvZzy1LUKRtD6zGQUaVTPlyPMPD9JHb0bLbJgHpgWv
         ugNg==
X-Gm-Message-State: ACrzQf2gLo2hFBx5embc20QMDbxlmix9f7LG9ipRw+5kG6H/Iar9rpx5
        Ez4cPYnRBhi6YBTVor450tWlrCHKFUOnmPAoGDWhL2IChow=
X-Google-Smtp-Source: AMsMyM5PXbJkndHQvPNNPLlpyEBE1LN5HZCkYN61XqMDOHTL/CnsGhnaqRBzlLyslJflSV0RQj+bHb8aD1AoIXWttjg=
X-Received: by 2002:ab0:6f4e:0:b0:3de:f8f0:7fa0 with SMTP id
 r14-20020ab06f4e000000b003def8f07fa0mr6382975uat.110.1665398253547; Mon, 10
 Oct 2022 03:37:33 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000007a8f9705eaa8d07c@google.com>
In-Reply-To: <0000000000007a8f9705eaa8d07c@google.com>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Mon, 10 Oct 2022 19:37:16 +0900
Message-ID: <CAKFNMo=1QtyeBNzdNn2yg=R_2h5ay=7VJY_oyBftWn++CMiRgg@mail.gmail.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in nilfs_load_inode_block
To:     syzbot <syzbot+4c7f4fefd5b2716a11ee@syzkaller.appspotmail.com>
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

On Mon, Oct 10, 2022 at 4:07 PM syzbot wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    a6afa4199d3d Merge tag 'mailbox-v6.1' of git://git.linaro...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1507bb68880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d19f5d16783f901
> dashboard link: https://syzkaller.appspot.com/bug?extid=4c7f4fefd5b2716a11ee
> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/12e24d042ff9/disk-a6afa419.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/4862ae4e2edf/vmlinux-a6afa419.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+4c7f4fefd5b2716a11ee@syzkaller.appspotmail.com
>
> ==================================================================
> BUG: KASAN: use-after-free in nilfs_load_inode_block+0x124/0x290 fs/nilfs2/inode.c:995
> Read of size 8 at addr ffff8880254e0830 by task syz-executor.2/3637
>
> CPU: 1 PID: 3637 Comm: syz-executor.2 Not tainted 6.0.0-syzkaller-09039-ga6afa4199d3d #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
>  print_address_description+0x65/0x4b0 mm/kasan/report.c:317
>  print_report+0x108/0x1f0 mm/kasan/report.c:433
>  kasan_report+0xc3/0xf0 mm/kasan/report.c:495
>  nilfs_load_inode_block+0x124/0x290 fs/nilfs2/inode.c:995
>  __nilfs_mark_inode_dirty+0x82/0x250 fs/nilfs2/inode.c:1072
>  nilfs_mark_inode_dirty fs/nilfs2/nilfs.h:288 [inline]
>  nilfs_evict_inode+0x162/0x3d0 fs/nilfs2/inode.c:917
>  evict+0x2a4/0x620 fs/inode.c:664
>  nilfs_dispose_list+0x554/0x610 fs/nilfs2/segment.c:795
>  nilfs_detach_log_writer+0xb0e/0xbd0 fs/nilfs2/segment.c:2824
>  nilfs_put_super+0x4b/0x150 fs/nilfs2/super.c:468
>  generic_shutdown_super+0x130/0x310 fs/super.c:491
>  kill_block_super+0x79/0xd0 fs/super.c:1427
>  deactivate_locked_super+0xa7/0xf0 fs/super.c:331
>  cleanup_mnt+0x4ce/0x560 fs/namespace.c:1186
>  task_work_run+0x146/0x1c0 kernel/task_work.c:177
>  resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
>  exit_to_user_mode_loop+0x124/0x150 kernel/entry/common.c:169
>  exit_to_user_mode_prepare+0xb2/0x140 kernel/entry/common.c:201
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
>  syscall_exit_to_user_mode+0x26/0x60 kernel/entry/common.c:294
>  do_syscall_64+0x49/0xb0 arch/x86/entry/common.c:86
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f6d8ba8ba17
> Code: ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffe20b71b08 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f6d8ba8ba17
> RDX: 00007ffe20b71bdc RSI: 000000000000000a RDI: 00007ffe20b71bd0
> RBP: 00007ffe20b71bd0 R08: 00000000ffffffff R09: 00007ffe20b719a0
> R10: 0000555555f2b8b3 R11: 0000000000000246 R12: 00007f6d8bae45f6
> R13: 00007ffe20b72c90 R14: 0000555555f2b810 R15: 00007ffe20b72cd0
>  </TASK>
>
> Allocated by task 10634:
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
> Freed by task 3637:
>  kasan_save_stack mm/kasan/common.c:38 [inline]
>  kasan_set_track+0x3d/0x60 mm/kasan/common.c:45
>  kasan_set_free_info+0x1f/0x40 mm/kasan/generic.c:370
>  ____kasan_slab_free+0xd8/0x120 mm/kasan/common.c:367
>  kasan_slab_free include/linux/kasan.h:200 [inline]
>  slab_free_hook mm/slub.c:1759 [inline]
>  slab_free_freelist_hook+0x12e/0x1a0 mm/slub.c:1785
>  slab_free mm/slub.c:3539 [inline]
>  kfree+0xda/0x210 mm/slub.c:4567
>  nilfs_segctor_destroy fs/nilfs2/segment.c:2747 [inline]
>  nilfs_detach_log_writer+0x8d5/0xbd0 fs/nilfs2/segment.c:2810
>  nilfs_put_super+0x4b/0x150 fs/nilfs2/super.c:468
>  generic_shutdown_super+0x130/0x310 fs/super.c:491
>  kill_block_super+0x79/0xd0 fs/super.c:1427
>  deactivate_locked_super+0xa7/0xf0 fs/super.c:331
>  cleanup_mnt+0x4ce/0x560 fs/namespace.c:1186
>  task_work_run+0x146/0x1c0 kernel/task_work.c:177
>  resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
>  exit_to_user_mode_loop+0x124/0x150 kernel/entry/common.c:169
>  exit_to_user_mode_prepare+0xb2/0x140 kernel/entry/common.c:201
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
>  syscall_exit_to_user_mode+0x26/0x60 kernel/entry/common.c:294
>  do_syscall_64+0x49/0xb0 arch/x86/entry/common.c:86
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> Last potentially related work creation:
>  kasan_save_stack+0x2b/0x50 mm/kasan/common.c:38
>  __kasan_record_aux_stack+0xaf/0xc0 mm/kasan/generic.c:348
>  kvfree_call_rcu+0x112/0x880 kernel/rcu/tree.c:3341
>  drop_sysctl_table+0x307/0x480 fs/proc/proc_sysctl.c:1716
>  drop_sysctl_table+0x319/0x480 fs/proc/proc_sysctl.c:1719
>  unregister_sysctl_table+0x87/0x140 fs/proc/proc_sysctl.c:1754
>  neigh_sysctl_unregister+0x74/0x90 net/core/neighbour.c:3871
>  devinet_sysctl_unregister net/ipv4/devinet.c:2638 [inline]
>  inetdev_destroy net/ipv4/devinet.c:327 [inline]
>  inetdev_event+0x7f9/0x14a0 net/ipv4/devinet.c:1602
>  notifier_call_chain kernel/notifier.c:87 [inline]
>  raw_notifier_call_chain+0xe7/0x170 kernel/notifier.c:455
>  call_netdevice_notifiers_info net/core/dev.c:1945 [inline]
>  call_netdevice_notifiers_extack net/core/dev.c:1983 [inline]
>  call_netdevice_notifiers net/core/dev.c:1997 [inline]
>  unregister_netdevice_many+0x107e/0x1aa0 net/core/dev.c:10843
>  default_device_exit_batch+0x570/0x5e0 net/core/dev.c:11337
>  ops_exit_list net/core/net_namespace.c:167 [inline]
>  cleanup_net+0x80c/0xc50 net/core/net_namespace.c:594
>  process_one_work+0x877/0xdb0 kernel/workqueue.c:2289
>  worker_thread+0xb14/0x1330 kernel/workqueue.c:2436
>  kthread+0x266/0x300 kernel/kthread.c:376
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
>
> The buggy address belongs to the object at ffff8880254e0800
>  which belongs to the cache kmalloc-256 of size 256
> The buggy address is located 48 bytes inside of
>  256-byte region [ffff8880254e0800, ffff8880254e0900)
>
> The buggy address belongs to the physical page:
> page:ffffea0000953800 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x254e0
> head:ffffea0000953800 order:1 compound_mapcount:0 compound_pincount:0
> flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
> raw: 00fff00000010200 ffffea00009f7680 dead000000000003 ffff888012041b40
> raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 3639, tgid 3639 (syz-executor.5), ts 112861784086, free_ts 112850605269
>  prep_new_page mm/page_alloc.c:2532 [inline]
>  get_page_from_freelist+0x742/0x7c0 mm/page_alloc.c:4283
>  __alloc_pages+0x259/0x560 mm/page_alloc.c:5549
>  alloc_slab_page+0x70/0xf0 mm/slub.c:1829
>  allocate_slab+0x5e/0x520 mm/slub.c:1974
>  new_slab mm/slub.c:2034 [inline]
>  ___slab_alloc+0x3ee/0xc40 mm/slub.c:3036
>  __slab_alloc mm/slub.c:3123 [inline]
>  slab_alloc_node mm/slub.c:3214 [inline]
>  slab_alloc mm/slub.c:3256 [inline]
>  __kmalloc+0x2bd/0x370 mm/slub.c:4425
>  kmalloc include/linux/slab.h:605 [inline]
>  kzalloc include/linux/slab.h:733 [inline]
>  new_dir fs/proc/proc_sysctl.c:978 [inline]
>  get_subdir fs/proc/proc_sysctl.c:1022 [inline]
>  __register_sysctl_table+0xb63/0x11e0 fs/proc/proc_sysctl.c:1373
>  __devinet_sysctl_register+0x1db/0x2a0 net/ipv4/devinet.c:2586
>  devinet_sysctl_register+0x139/0x1a0 net/ipv4/devinet.c:2626
>  inetdev_init+0x28f/0x4c0 net/ipv4/devinet.c:279
>  inetdev_event+0x282/0x14a0 net/ipv4/devinet.c:1534
>  notifier_call_chain kernel/notifier.c:87 [inline]
>  raw_notifier_call_chain+0xe7/0x170 kernel/notifier.c:455
>  call_netdevice_notifiers_info net/core/dev.c:1945 [inline]
>  call_netdevice_notifiers_extack net/core/dev.c:1983 [inline]
>  call_netdevice_notifiers+0x14e/0x1d0 net/core/dev.c:1997
>  register_netdevice+0x1316/0x1790 net/core/dev.c:10086
>  ipcaif_newlink+0x1e7/0x4c0 net/caif/chnl_net.c:455
>  rtnl_newlink_create net/core/rtnetlink.c:3364 [inline]
>  __rtnl_newlink net/core/rtnetlink.c:3581 [inline]
>  rtnl_newlink+0x147d/0x1fa0 net/core/rtnetlink.c:3594
> page last free stack trace:
>  reset_page_owner include/linux/page_owner.h:24 [inline]
>  free_pages_prepare mm/page_alloc.c:1449 [inline]
>  free_pcp_prepare+0x812/0x900 mm/page_alloc.c:1499
>  free_unref_page_prepare mm/page_alloc.c:3380 [inline]
>  free_unref_page+0x7d/0x5f0 mm/page_alloc.c:3476
>  free_slab mm/slub.c:2073 [inline]
>  discard_slab mm/slub.c:2079 [inline]
>  __unfreeze_partials+0x1ab/0x200 mm/slub.c:2553
>  put_cpu_partial+0x106/0x170 mm/slub.c:2629
>  qlist_free_all+0x2b/0x70 mm/kasan/quarantine.c:187
>  kasan_quarantine_reduce+0x169/0x180 mm/kasan/quarantine.c:294
>  __kasan_slab_alloc+0x2f/0xd0 mm/kasan/common.c:447
>  kasan_slab_alloc include/linux/kasan.h:224 [inline]
>  slab_post_alloc_hook mm/slab.h:727 [inline]
>  slab_alloc_node mm/slub.c:3248 [inline]
>  slab_alloc mm/slub.c:3256 [inline]
>  kmem_cache_alloc_trace+0x1de/0x310 mm/slub.c:3287
>  kmalloc include/linux/slab.h:600 [inline]
>  kzalloc include/linux/slab.h:733 [inline]
>  kobject_uevent_env+0x33a/0x8e0 lib/kobject_uevent.c:524
>  __kobject_del+0xcd/0x300 lib/kobject.c:585
>  kobject_cleanup+0x25d/0x470 lib/kobject.c:664
>  net_rx_queue_update_kobjects+0x455/0x4c0 net/core/net-sysfs.c:1128
>  netif_set_real_num_rx_queues+0xf9/0x1d0 net/core/dev.c:2941
>  veth_init_queues+0x108/0x170 drivers/net/veth.c:1692
>  veth_newlink+0xa6f/0xd10 drivers/net/veth.c:1813
>  rtnl_newlink_create net/core/rtnetlink.c:3364 [inline]
>  __rtnl_newlink net/core/rtnetlink.c:3581 [inline]
>  rtnl_newlink+0x147d/0x1fa0 net/core/rtnetlink.c:3594
>
> Memory state around the buggy address:
>  ffff8880254e0700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff8880254e0780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> >ffff8880254e0800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                                      ^
>  ffff8880254e0880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff8880254e0900: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
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

#syz dup: KASAN: use-after-free Read in nilfs_segctor_confirm

Looks like the same UAF bug as above according to the stack trace.

The bugfix for this is the patch titled "nilfs2: fix use-after-free
bug of struct nilfs_root", which is now queued in mm-hotfixes-unstable
branch of -mm tree.

Thanks,
Ryusuke Konishi
