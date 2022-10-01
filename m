Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7AF5F1C73
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 15:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiJANoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 09:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiJANn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 09:43:56 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AF889AE7
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 06:43:38 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id z4-20020a921a44000000b002f8da436b83so5367481ill.19
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 06:43:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=Yn53jOnNkTa041/6YnLzg0QSYrC9JHdqvbazYAZgSDw=;
        b=S9RkU7EySLn2k6yZFVQPv8u3y8eFj5XXGYwfnyBs+pecUo3PNEIiY2NhNDUJJrkhws
         rqSTNlJ1aU+cG9wQnKFnCs1uAU8SYEs59L/kd+1EyBxvSRf1Cj2n6+bqET0j6NCh5c9J
         BF7SvLtCHQUyrZHIF8jlWNXl9burjIgWECIqwYAGyMOOJvcity80usAADXgFLyjqlD8I
         Z4+4RW8Ieo6t+231ELnfr4i7GNnuctEKozjk74qkwnN1J0nyk5331VLQr32ySghyLdgR
         vWMoLkcFAuGRw6KREn98kBBKXI6Y7d+2XoJOO7j5ObNKJ+qNO2CGrndQXXA9kArW3TX7
         cM5Q==
X-Gm-Message-State: ACrzQf3XQUGHmUPwFa4p26nWaRxyEqd8oijP04jyDswVBPMKU6F7rYpO
        0w9qHtexIP87jQfpvMZI3OrqMxdQlTAu6scfbenKFrQ9jtaJ
X-Google-Smtp-Source: AMsMyM5utzk8G+mpPclB6FcGAfOIVMGo/Uhg0nMD876BKK4atF2KEsEtQjCrMFpwlch1xev7mFAD4feyhEaZKb/Jde2IM0xhEf5v
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a03:b0:2f6:7b78:dae2 with SMTP id
 s3-20020a056e021a0300b002f67b78dae2mr6026536ild.284.1664631818200; Sat, 01
 Oct 2022 06:43:38 -0700 (PDT)
Date:   Sat, 01 Oct 2022 06:43:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000034ae0f05e9f94c79@google.com>
Subject: [syzbot] KASAN: use-after-free Read in jfs_lazycommit
From:   syzbot <syzbot+885a4f3281b8d99c48d8@syzkaller.appspotmail.com>
To:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        shaggy@kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    3800a713b607 Merge tag 'mm-hotfixes-stable-2022-09-26' of ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=126aa1ff080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a1992c90769e07
dashboard link: https://syzkaller.appspot.com/bug?extid=885a4f3281b8d99c48d8
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+885a4f3281b8d99c48d8@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in jfs_lazycommit+0xa39/0xb70 fs/jfs/jfs_txnmgr.c:2730
Read of size 4 at addr ffff888061559694 by task jfsCommit/152

CPU: 2 PID: 152 Comm: jfsCommit Not tainted 6.0.0-rc7-syzkaller-00029-g3800a713b607 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:317 [inline]
 print_report.cold+0x2ba/0x6e9 mm/kasan/report.c:433
 kasan_report+0xb1/0x1e0 mm/kasan/report.c:495
 jfs_lazycommit+0xa39/0xb70 fs/jfs/jfs_txnmgr.c:2730
 kthread+0x2e4/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>

Allocated by task 7752:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:437 [inline]
 ____kasan_kmalloc mm/kasan/common.c:516 [inline]
 ____kasan_kmalloc mm/kasan/common.c:475 [inline]
 __kasan_kmalloc+0xa6/0xd0 mm/kasan/common.c:525
 kasan_kmalloc include/linux/kasan.h:234 [inline]
 kmem_cache_alloc_trace+0x25a/0x460 mm/slab.c:3559
 kmalloc include/linux/slab.h:600 [inline]
 kzalloc include/linux/slab.h:733 [inline]
 jfs_fill_super+0xd9/0xc70 fs/jfs/super.c:495
 mount_bdev+0x34d/0x410 fs/super.c:1400
 legacy_get_tree+0x105/0x220 fs/fs_context.c:610
 vfs_get_tree+0x89/0x2f0 fs/super.c:1530
 do_new_mount fs/namespace.c:3040 [inline]
 path_mount+0x1326/0x1e20 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 3724:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track+0x21/0x30 mm/kasan/common.c:45
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:370
 ____kasan_slab_free mm/kasan/common.c:367 [inline]
 ____kasan_slab_free+0x13d/0x1a0 mm/kasan/common.c:329
 kasan_slab_free include/linux/kasan.h:200 [inline]
 __cache_free mm/slab.c:3418 [inline]
 kfree+0x173/0x390 mm/slab.c:3786
 generic_shutdown_super+0x14c/0x400 fs/super.c:491
 kill_block_super+0x97/0xf0 fs/super.c:1427
 deactivate_locked_super+0x94/0x160 fs/super.c:332
 deactivate_super+0xad/0xd0 fs/super.c:363
 cleanup_mnt+0x2ae/0x3d0 fs/namespace.c:1186
 task_work_run+0xdd/0x1a0 kernel/task_work.c:177
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:169 [inline]
 exit_to_user_mode_prepare+0x23c/0x250 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:294
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Last potentially related work creation:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 __kasan_record_aux_stack+0x7e/0x90 mm/kasan/generic.c:348
 kvfree_call_rcu+0x74/0x940 kernel/rcu/tree.c:3322
 drop_sysctl_table+0x3c0/0x4e0 fs/proc/proc_sysctl.c:1716
 unregister_sysctl_table fs/proc/proc_sysctl.c:1754 [inline]
 unregister_sysctl_table+0xc0/0x190 fs/proc/proc_sysctl.c:1729
 mpls_dev_sysctl_unregister net/mpls/af_mpls.c:1441 [inline]
 mpls_dev_notify+0x5c7/0x9b0 net/mpls/af_mpls.c:1653
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:87
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:1945
 call_netdevice_notifiers_extack net/core/dev.c:1983 [inline]
 call_netdevice_notifiers net/core/dev.c:1997 [inline]
 unregister_netdevice_many+0xa62/0x1980 net/core/dev.c:10862
 ip_tunnel_delete_nets+0x39f/0x5b0 net/ipv4/ip_tunnel.c:1126
 ops_exit_list+0x125/0x170 net/core/net_namespace.c:168
 cleanup_net+0x4ea/0xb00 net/core/net_namespace.c:595
 process_one_work+0x991/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e4/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306

Second to last potentially related work creation:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 __kasan_record_aux_stack+0x7e/0x90 mm/kasan/generic.c:348
 kvfree_call_rcu+0x74/0x940 kernel/rcu/tree.c:3322
 drop_sysctl_table+0x3c0/0x4e0 fs/proc/proc_sysctl.c:1716
 unregister_sysctl_table fs/proc/proc_sysctl.c:1754 [inline]
 unregister_sysctl_table+0xc0/0x190 fs/proc/proc_sysctl.c:1729
 __devinet_sysctl_unregister net/ipv4/devinet.c:2609 [inline]
 devinet_sysctl_unregister net/ipv4/devinet.c:2637 [inline]
 inetdev_destroy net/ipv4/devinet.c:327 [inline]
 inetdev_event+0xcaa/0x1610 net/ipv4/devinet.c:1602
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:87
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:1945
 call_netdevice_notifiers_extack net/core/dev.c:1983 [inline]
 call_netdevice_notifiers net/core/dev.c:1997 [inline]
 unregister_netdevice_many+0xa62/0x1980 net/core/dev.c:10862
 ip6_tnl_exit_batch_net+0x5f5/0x890 net/ipv6/ip6_tunnel.c:2312
 ops_exit_list+0x125/0x170 net/core/net_namespace.c:168
 cleanup_net+0x4ea/0xb00 net/core/net_namespace.c:595
 process_one_work+0x991/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e4/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306

The buggy address belongs to the object at ffff888061559600
 which belongs to the cache kmalloc-256 of size 256
The buggy address is located 148 bytes inside of
 256-byte region [ffff888061559600, ffff888061559700)

The buggy address belongs to the physical page:
page:ffffea0001855640 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff888061559400 pfn:0x61559
flags: 0x4fff00000000200(slab|node=1|zone=1|lastcpupid=0x7ff)
raw: 04fff00000000200 ffffea0001ad0108 ffff888040000640 ffff888011840500
raw: ffff888061559400 ffff888061559000 0000000100000005 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x140cc0(GFP_USER|__GFP_COMP), pid 5358, tgid 5356 (syz-executor.1), ts 311368910485, free_ts 310980461997
 prep_new_page mm/page_alloc.c:2532 [inline]
 get_page_from_freelist+0x109b/0x2ce0 mm/page_alloc.c:4283
 __alloc_pages+0x1c7/0x510 mm/page_alloc.c:5549
 __alloc_pages_node include/linux/gfp.h:243 [inline]
 kmem_getpages mm/slab.c:1363 [inline]
 cache_grow_begin+0x75/0x360 mm/slab.c:2569
 fallback_alloc+0x1e2/0x2d0 mm/slab.c:3112
 __do_cache_alloc mm/slab.c:3253 [inline]
 slab_alloc mm/slab.c:3287 [inline]
 __do_kmalloc mm/slab.c:3684 [inline]
 __kmalloc+0x2da/0x4a0 mm/slab.c:3695
 kmalloc include/linux/slab.h:605 [inline]
 kzalloc include/linux/slab.h:733 [inline]
 new_dir fs/proc/proc_sysctl.c:978 [inline]
 get_subdir fs/proc/proc_sysctl.c:1022 [inline]
 __register_sysctl_table+0x9eb/0x10a0 fs/proc/proc_sysctl.c:1373
 neigh_sysctl_register+0x2c8/0x5e0 net/core/neighbour.c:3855
 addrconf_sysctl_register+0xb6/0x1d0 net/ipv6/addrconf.c:7126
 ipv6_add_dev+0xae3/0x1390 net/ipv6/addrconf.c:450
 addrconf_notify+0x6f9/0x1c10 net/ipv6/addrconf.c:3528
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:87
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:1945
 call_netdevice_notifiers_extack net/core/dev.c:1983 [inline]
 call_netdevice_notifiers net/core/dev.c:1997 [inline]
 register_netdevice+0x1127/0x1680 net/core/dev.c:10103
 register_netdev+0x2d/0x50 net/core/dev.c:10196
 sit_init_net+0x350/0xa30 net/ipv6/sit.c:1915
 ops_init+0xaf/0x470 net/core/net_namespace.c:135
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
 free_page_and_swap_cache+0x253/0x2c0 mm/swap_state.c:296
 __tlb_remove_table arch/x86/include/asm/tlb.h:34 [inline]
 __tlb_remove_table_free mm/mmu_gather.c:114 [inline]
 tlb_remove_table_rcu+0x85/0xe0 mm/mmu_gather.c:169
 rcu_do_batch kernel/rcu/tree.c:2245 [inline]
 rcu_core+0x7b5/0x1890 kernel/rcu/tree.c:2505
 __do_softirq+0x1d3/0x9c6 kernel/softirq.c:571

Memory state around the buggy address:
 ffff888061559580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888061559600: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888061559680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                         ^
 ffff888061559700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888061559780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
