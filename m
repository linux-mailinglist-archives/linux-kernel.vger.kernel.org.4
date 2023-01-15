Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D416066B45A
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 23:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjAOWba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 17:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbjAOWb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 17:31:28 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65EE7C64B
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 14:31:27 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id y11-20020a056e02178b00b0030c048d64a7so19899650ilu.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 14:31:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tWj+2JaDOYremkbpXVbCHjf/VpBkcUbEIwAM0KpJeh0=;
        b=wFBAgo9P3HWqVfpRsXn5FAUdNaTpuB2yHg6OwqrhULUIVgsMPNNJhZA7jHDnrqWPfx
         SEGd4Fx29WukY+ew9bBdbfFQvsbTNME/rDWtDz8AxVS3MeF7gQMCjLjX3KMpqVy23Gs6
         lK4gFDBUtRPpAAX5+nrUQZ7WUqRMwquo83o9rq7+6Msgo0+3xcdVgTONl5i6E93uQ214
         iP9qrxVg5GZnM5hteNHrhq1BaC+gnwEbeXRlqFF0uSoriOrF4OzV3oTkulLSfJAfA+BA
         rcpm4VIXVZdb/DooeQurYDScYlPlVzfn91NT/s9+YawyRLvhQ30kStMn+Gw2qXvPooI+
         zEQA==
X-Gm-Message-State: AFqh2krboremDN1oWDZoicKoc+jH8/J8M6WFpzP7P9j1fgcLMfu0sBkp
        FOOlgu6f+49WUc44dmnnwRueW331PGUSB+p9sVW8w2rmJzmB
X-Google-Smtp-Source: AMrXdXu5Kuok1rrbQigarHH4X5EzihJjcMGAEIc7gpapU3Uq4Et262plXR5VpYdzx0OG2G8IRaBcWDtRc+dADdlXPaO67vLIaiL7
MIME-Version: 1.0
X-Received: by 2002:a92:c605:0:b0:30d:c502:a9d3 with SMTP id
 p5-20020a92c605000000b0030dc502a9d3mr1612344ilm.18.1673821886744; Sun, 15 Jan
 2023 14:31:26 -0800 (PST)
Date:   Sun, 15 Jan 2023 14:31:26 -0800
In-Reply-To: <20230115220938.1677-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fa11f805f2550624@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in snd_pcm_post_stop
From:   syzbot <syzbot+e29d28728f38190cecfc@syzkaller.appspotmail.com>
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
KASAN: use-after-free Read in dummy_pcm_prepare

==================================================================
BUG: KASAN: use-after-free in dummy_pcm_prepare+0xae/0xc0 sound/drivers/dummy.c:504
Read of size 8 at addr ffff888077855200 by task syz-executor.0/5606

CPU: 1 PID: 5606 Comm: syz-executor.0 Not tainted 6.2.0-rc3-next-20230112-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd1/0x138 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:306 [inline]
 print_report+0x15e/0x45d mm/kasan/report.c:417
 kasan_report+0xc0/0xf0 mm/kasan/report.c:517
 dummy_pcm_prepare+0xae/0xc0 sound/drivers/dummy.c:504
 snd_pcm_do_prepare+0x6a/0xb0 sound/core/pcm_native.c:1959
 snd_pcm_action_single+0x75/0x130 sound/core/pcm_native.c:1281
 snd_pcm_action_nonatomic+0x12b/0x160 sound/core/pcm_native.c:1400
 snd_pcm_kernel_ioctl+0x264/0x2e0 sound/core/pcm_native.c:3450
 snd_pcm_oss_prepare+0x44/0x220 sound/core/oss/pcm_oss.c:1154
 snd_pcm_oss_make_ready+0x161/0x1b0 sound/core/oss/pcm_oss.c:1182
 snd_pcm_oss_set_trigger.isra.0+0x30f/0x6e0 sound/core/oss/pcm_oss.c:2092
 snd_pcm_oss_poll+0x613/0xab0 sound/core/oss/pcm_oss.c:2878
 vfs_poll include/linux/poll.h:88 [inline]
 io_poll_check_events io_uring/poll.c:279 [inline]
 io_poll_task_func+0x3a6/0x1220 io_uring/poll.c:327
 handle_tw_list+0x253/0x540 io_uring/io_uring.c:1177
 tctx_task_work+0x12e/0x530 io_uring/io_uring.c:1235
 task_work_run+0x16f/0x270 kernel/task_work.c:179
 get_signal+0x1c7/0x24f0 kernel/signal.c:2635
 arch_do_signal_or_restart+0x79/0x5c0 arch/x86/kernel/signal.c:306
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x11f/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
 syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:297
 do_syscall_64+0x46/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7faa7168c0c9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007faa72462168 EFLAGS: 00000246
 ORIG_RAX: 0000000000000000
RAX: fffffffffffffe00 RBX: 00007faa717abf80 RCX: 00007faa7168c0c9
RDX: 0000000000002020 RSI: 00000000200021c0 RDI: 0000000000000006
RBP: 00007faa716e7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd3b035a6f R14: 00007faa72462300 R15: 0000000000022000
 </TASK>

Allocated by task 5606:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:371 [inline]
 ____kasan_kmalloc mm/kasan/common.c:330 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:380
 kmalloc include/linux/slab.h:580 [inline]
 kzalloc include/linux/slab.h:720 [inline]
 dummy_hrtimer_create+0x45/0x190 sound/drivers/dummy.c:456
 dummy_pcm_open+0xd4/0x5a0 sound/drivers/dummy.c:556
 snd_pcm_open_substream+0xa92/0x1820 sound/core/pcm_native.c:2748
 snd_pcm_oss_open_file sound/core/oss/pcm_oss.c:2454 [inline]
 snd_pcm_oss_open.part.0+0x6dc/0x1330 sound/core/oss/pcm_oss.c:2535
 snd_pcm_oss_open+0x44/0x60 sound/core/oss/pcm_oss.c:2499
 soundcore_open+0x452/0x620 sound/sound_core.c:593
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

Freed by task 5605:
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
 dummy_pcm_close+0x93/0xc0 sound/drivers/dummy.c:589
 snd_pcm_release_substream.part.0+0x10e/0x330 sound/core/pcm_native.c:2714
 snd_pcm_release_substream+0x5b/0x70 sound/core/pcm_native.c:2707
 snd_pcm_oss_release_file sound/core/oss/pcm_oss.c:2413 [inline]
 snd_pcm_oss_release_file sound/core/oss/pcm_oss.c:2405 [inline]
 snd_pcm_oss_release+0x175/0x300 sound/core/oss/pcm_oss.c:2592
 __fput+0x27c/0xa90 fs/file_table.c:321
 task_work_run+0x16f/0x270 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 exit_to_user_mode_prepare+0x210/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
 syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:297
 do_syscall_64+0x46/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff888077855200
 which belongs to the cache kmalloc-128 of size 128
The buggy address is located 0 bytes inside of
 128-byte region [ffff888077855200, ffff888077855280)

The buggy address belongs to the physical page:
page:ffffea0001de1540 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x77855
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffff8880124418c0 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x112cc0(GFP_USER|__GFP_NOWARN|__GFP_NORETRY), pid 5553, tgid 5553 (syz-executor.0), ts 119232426868, free_ts 118550967401
 prep_new_page mm/page_alloc.c:2549 [inline]
 get_page_from_freelist+0x11bb/0x2d50 mm/page_alloc.c:4324
 __alloc_pages+0x1cb/0x5c0 mm/page_alloc.c:5590
 __alloc_pages_node include/linux/gfp.h:237 [inline]
 alloc_slab_page mm/slub.c:1853 [inline]
 allocate_slab+0xa7/0x350 mm/slub.c:1998
 new_slab mm/slub.c:2051 [inline]
 ___slab_alloc+0xa91/0x1400 mm/slub.c:3193
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3292
 __slab_alloc_node mm/slub.c:3345 [inline]
 slab_alloc_node mm/slub.c:3442 [inline]
 __kmem_cache_alloc_node+0x136/0x330 mm/slub.c:3491
 __do_kmalloc_node mm/slab_common.c:966 [inline]
 __kmalloc_node+0x4d/0xd0 mm/slab_common.c:974
 kmalloc_array_node include/linux/slab.h:697 [inline]
 kcalloc_node include/linux/slab.h:702 [inline]
 memcg_alloc_slab_cgroups+0x8f/0x150 mm/memcontrol.c:2899
 memcg_slab_post_alloc_hook+0xa9/0x390 mm/slab.h:546
 slab_post_alloc_hook mm/slab.h:777 [inline]
 slab_alloc_node mm/slub.c:3452 [inline]
 slab_alloc mm/slub.c:3460 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3467 [inline]
 kmem_cache_alloc+0x1a7/0x320 mm/slub.c:3476
 copy_sighand kernel/fork.c:1668 [inline]
 copy_process+0x26c4/0x7740 kernel/fork.c:2266
 kernel_clone+0xeb/0x9a0 kernel/fork.c:2687
 __do_sys_clone+0xba/0x100 kernel/fork.c:2828
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1451 [inline]
 free_pcp_prepare+0x4d0/0x910 mm/page_alloc.c:1501
 free_unref_page_prepare mm/page_alloc.c:3387 [inline]
 free_unref_page_list+0x176/0xcd0 mm/page_alloc.c:3528
 release_pages+0xcb1/0x1330 mm/swap.c:1072
 tlb_batch_pages_flush+0xa8/0x1a0 mm/mmu_gather.c:97
 tlb_flush_mmu_free mm/mmu_gather.c:292 [inline]
 tlb_flush_mmu mm/mmu_gather.c:299 [inline]
 tlb_finish_mmu+0x14b/0x7e0 mm/mmu_gather.c:391
 exit_mmap+0x202/0x7c0 mm/mmap.c:3100
 __mmput+0x128/0x4c0 kernel/fork.c:1212
 mmput+0x60/0x70 kernel/fork.c:1234
 exit_mm kernel/exit.c:563 [inline]
 do_exit+0x9ac/0x2a90 kernel/exit.c:854
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1012
 __do_sys_exit_group kernel/exit.c:1023 [inline]
 __se_sys_exit_group kernel/exit.c:1021 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1021
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff888077855100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fc fc
 ffff888077855180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888077855200: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff888077855280: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888077855300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


Tested on:

commit:         0a093b28 Add linux-next specific files for 20230112
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=137d2c5e480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=835f3591019836d5
dashboard link: https://syzkaller.appspot.com/bug?extid=e29d28728f38190cecfc
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14260046480000

