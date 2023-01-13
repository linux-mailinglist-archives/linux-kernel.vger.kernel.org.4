Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F65D668A87
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 05:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjAMEHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 23:07:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjAMEHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 23:07:18 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E9D39F9C
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 20:07:17 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id b21-20020a5d8d95000000b006fa39fbb94eso12678885ioj.17
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 20:07:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QgXzLI8rY9MdfDvgleA3Z89SXUnD9uwa3G1LxgfbnMM=;
        b=tIZ8y7mzIwIYwTJhNek4AW+9SvmNRptnq4TOEF8WusO5ep/UQFHMytDvvCoHv6m81s
         ADnVmLMOOZtpBgra+lOja1w8IgSQG7v1wbi0MlRPiThu5LFrLA8BNEn+1rhSmf9t/uxF
         UVff6bnGVTzUC1l7FjTAZm4BaBeXIgfICiHaH0c/xUXQDLsHhyMdWe6RMHFHZ9BD1PpR
         oPQRgxRJbt3A0YuUvFu7JPvqPXZTcEo+W3tNsCvo4RLLuy7p6dQ1UH+wAvwxncI3X1XW
         nudkP/vcP9UKva6mpR++PILR57mqaOxNaEo1hPKcoBp2ut3XUPNzWfM8s2Gr/6nOuDmp
         oEag==
X-Gm-Message-State: AFqh2koJhKeQqzbpbyLPoiYK9bK5EFjSAmtoS/fR91qKB+7vtvpsrDeE
        dizC9D1SLJxt/4lzoSchLoEfxMEAJHj1XtC0k/AEfYedBUm1
X-Google-Smtp-Source: AMrXdXuuU1jsKD2riEI0KFIa3GD6CvzW0lKmrbIwBu/evjQGwLjL0tpS+WuXnDi9WDHoFUzFS3V0faC+Pe53UCHMRiaOgkzqEIkZ
MIME-Version: 1.0
X-Received: by 2002:a92:cc84:0:b0:304:c600:b4bd with SMTP id
 x4-20020a92cc84000000b00304c600b4bdmr7104189ilo.252.1673582836555; Thu, 12
 Jan 2023 20:07:16 -0800 (PST)
Date:   Thu, 12 Jan 2023 20:07:16 -0800
In-Reply-To: <20230113033956.636-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000079a97e05f21d5e66@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in snd_rawmidi_poll
From:   syzbot <syzbot+e3ec01fd2d18c9264c3b@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
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

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: use-after-free Read in snd_rawmidi_poll

==================================================================
BUG: KASAN: use-after-free in snd_rawmidi_poll+0x559/0x680 sound/core/rawmidi.c:1655
Read of size 8 at addr ffff8880786086c8 by task syz-executor.0/5598

CPU: 1 PID: 5598 Comm: syz-executor.0 Not tainted 6.2.0-rc3-next-20230112-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd1/0x138 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:306 [inline]
 print_report+0x15e/0x45d mm/kasan/report.c:417
 kasan_report+0xc0/0xf0 mm/kasan/report.c:517
 snd_rawmidi_poll+0x559/0x680 sound/core/rawmidi.c:1655
 vfs_poll include/linux/poll.h:88 [inline]
 io_poll_check_events io_uring/poll.c:279 [inline]
 io_poll_task_func+0x3a6/0x1280 io_uring/poll.c:327
 handle_tw_list+0xa8/0x460 io_uring/io_uring.c:1169
 tctx_task_work+0x12e/0x530 io_uring/io_uring.c:1224
 task_work_run+0x16f/0x270 kernel/task_work.c:179
 get_signal+0x1c7/0x24f0 kernel/signal.c:2635
 arch_do_signal_or_restart+0x79/0x5c0 arch/x86/kernel/signal.c:306
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x11f/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
 syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:297
 do_syscall_64+0x46/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fcda7c8c0c9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fcda6ffe218 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00007fcda7dac058 RCX: 00007fcda7c8c0c9
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007fcda7dac058
RBP: 00007fcda7dac050 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fcda7dac05c
R13: 00007ffc4cac593f R14: 00007fcda6ffe300 R15: 0000000000022000
 </TASK>

Allocated by task 5595:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:371 [inline]
 ____kasan_kmalloc mm/kasan/common.c:330 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:380
 kmalloc include/linux/slab.h:580 [inline]
 snd_rawmidi_open+0x39a/0xb70 sound/core/rawmidi.c:482
 snd_open+0x223/0x460 sound/core/sound.c:169
 chrdev_open+0x26a/0x770 fs/char_dev.c:414
 do_dentry_open+0x6cc/0x13f0 fs/open.c:883
 do_open fs/namei.c:3558 [inline]
 path_openat+0x1bc1/0x2b40 fs/namei.c:3715
 do_filp_open+0x1ba/0x410 fs/namei.c:3742
 do_sys_openat2+0x16d/0x4c0 fs/open.c:1311
 do_sys_open fs/open.c:1327 [inline]
 __do_sys_openat fs/open.c:1343 [inline]
 __se_sys_openat fs/open.c:1338 [inline]
 __x64_sys_openat+0x143/0x1f0 fs/open.c:1338
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 5598:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2e/0x40 mm/kasan/generic.c:518
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x160/0x1c0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:162 [inline]
 slab_free_hook mm/slub.c:1781 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1807
 slab_free mm/slub.c:3787 [inline]
 __kmem_cache_free+0xaf/0x2d0 mm/slub.c:3800
 snd_rawmidi_release+0x6a/0xf0 sound/core/rawmidi.c:619
 __fput+0x27c/0xa90 fs/file_table.c:321
 task_work_run+0x16f/0x270 kernel/task_work.c:179
 get_signal+0x1c7/0x24f0 kernel/signal.c:2635
 arch_do_signal_or_restart+0x79/0x5c0 arch/x86/kernel/signal.c:306
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x11f/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
 syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:297
 do_syscall_64+0x46/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff8880786086c0
 which belongs to the cache kmalloc-32 of size 32
The buggy address is located 8 bytes inside of
 32-byte region [ffff8880786086c0, ffff8880786086e0)

The buggy address belongs to the physical page:
page:ffffea0001e18200 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x78608
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffff888012441500 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000400040 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x112c40(GFP_NOFS|__GFP_NOWARN|__GFP_NORETRY|__GFP_HARDWALL), pid 5107, tgid 5107 (kworker/u4:4), ts 60258926459, free_ts 60222874536
 prep_new_page mm/page_alloc.c:2549 [inline]
 get_page_from_freelist+0x11bb/0x2d50 mm/page_alloc.c:4324
 __alloc_pages+0x1cb/0x5c0 mm/page_alloc.c:5590
 alloc_pages+0x1aa/0x270 mm/mempolicy.c:2281
 alloc_slab_page mm/slub.c:1851 [inline]
 allocate_slab+0x25f/0x350 mm/slub.c:1998
 new_slab mm/slub.c:2051 [inline]
 ___slab_alloc+0xa91/0x1400 mm/slub.c:3193
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3292
 __slab_alloc_node mm/slub.c:3345 [inline]
 slab_alloc_node mm/slub.c:3442 [inline]
 __kmem_cache_alloc_node+0x136/0x330 mm/slub.c:3491
 __do_kmalloc_node mm/slab_common.c:966 [inline]
 __kmalloc+0x4a/0xd0 mm/slab_common.c:980
 kmalloc include/linux/slab.h:584 [inline]
 kzalloc include/linux/slab.h:720 [inline]
 tomoyo_encode2.part.0+0xe9/0x3a0 security/tomoyo/realpath.c:45
 tomoyo_encode2 security/tomoyo/realpath.c:31 [inline]
 tomoyo_encode+0x2c/0x50 security/tomoyo/realpath.c:80
 tomoyo_realpath_from_path+0x185/0x600 security/tomoyo/realpath.c:283
 tomoyo_scan_exec_realpath security/tomoyo/condition.c:243 [inline]
 tomoyo_condition+0x12ba/0x2930 security/tomoyo/condition.c:827
 tomoyo_check_acl+0x1b4/0x440 security/tomoyo/domain.c:177
 tomoyo_execute_permission+0x178/0x4a0 security/tomoyo/file.c:615
 tomoyo_find_next_domain+0x34c/0x1f80 security/tomoyo/domain.c:752
 tomoyo_bprm_check_security security/tomoyo/tomoyo.c:101 [inline]
 tomoyo_bprm_check_security+0x133/0x1c0 security/tomoyo/tomoyo.c:91
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1451 [inline]
 free_pcp_prepare+0x4d0/0x910 mm/page_alloc.c:1501
 free_unref_page_prepare mm/page_alloc.c:3387 [inline]
 free_unref_page+0x1d/0x490 mm/page_alloc.c:3482
 __vunmap+0x7fe/0xc00 mm/vmalloc.c:2746
 free_work+0x5c/0x80 mm/vmalloc.c:100
 process_one_work+0x9bf/0x1750 kernel/workqueue.c:2293
 worker_thread+0x669/0x1090 kernel/workqueue.c:2440
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

Memory state around the buggy address:
 ffff888078608580: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
 ffff888078608600: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
>ffff888078608680: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
                                              ^
 ffff888078608700: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
 ffff888078608780: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
==================================================================


Tested on:

commit:         0a093b28 Add linux-next specific files for 20230112
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10a6692c480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=835f3591019836d5
dashboard link: https://syzkaller.appspot.com/bug?extid=e3ec01fd2d18c9264c3b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17339986480000

