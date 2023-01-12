Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61ED76679EE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 16:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240613AbjALPyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 10:54:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240665AbjALPxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 10:53:37 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0728A40858
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 07:42:35 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id s26-20020a5e981a000000b007045ace9e1cso5226137ioj.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 07:42:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=73zgsQZSGNVjBtVNsQd1D+mhH1mS4NzzkHjq2jqpcJo=;
        b=XX2iXtaGrA7+NJ3n1nn2coJmJJrjzszcHpqK4qEv2WGHPuFEFX8puyS+WRJH/ctI50
         o7c6QbbqlAEuXap2NxrkyGkq34tdjWhYgQqqjbF79XkxmsHUfIYvEHs747bb9kE75yWq
         EyizgQI9Ihy2NzUR1ONk3ZrLfiKlE+TWNEPRxCbTEPXRCAYSz/bl7mVJcJASryE+zXoB
         MR0x7NI9ok0rODdm1GY9qytc7l9/yhTjfciU1sshNRJs3y7viW+GcndU0UZurwXZMnsq
         fYj6P4BJHBvjDmPDegYfXeHawQKrODq3I3e4SqDXArvboq7xp/jm2AtFgHgade24kWsR
         VKWA==
X-Gm-Message-State: AFqh2kp2QOWnEEbAkxUKqaTI4SAkqUMOqlyi6VyUoqWJZdDr49Ndxlyc
        vnAuLhVwMw9zbJHX4k/6px4dLGCmKJLBN/ifmTnnS+J3MCTL
X-Google-Smtp-Source: AMrXdXvoFCQD0DAd3p9KhspCAOJuAGyGRBZyq9MTEG5E0Fr8Bnm/9RfNd+IhcojNr+0y6Q08XMDx68G3Qm/Yykz7L3B2UdhkRxPN
MIME-Version: 1.0
X-Received: by 2002:a92:c681:0:b0:30d:a7d5:d8f4 with SMTP id
 o1-20020a92c681000000b0030da7d5d8f4mr2436390ilg.65.1673538154401; Thu, 12 Jan
 2023 07:42:34 -0800 (PST)
Date:   Thu, 12 Jan 2023 07:42:34 -0800
In-Reply-To: <0000000000005ea9dd05f20e5b48@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000036161105f212f794@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in snd_rawmidi_poll
From:   syzbot <syzbot+e3ec01fd2d18c9264c3b@syzkaller.appspotmail.com>
To:     alsa-devel-owner@alsa-project.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, perex@perex.cz,
        syzkaller-bugs@googlegroups.com, tiwai@suse.com
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

HEAD commit:    0a093b2893c7 Add linux-next specific files for 20230112
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=170d2a91480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=835f3591019836d5
dashboard link: https://syzkaller.appspot.com/bug?extid=e3ec01fd2d18c9264c3b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1755a902480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12b3995a480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8111a570d6cb/disk-0a093b28.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ecc135b7fc9a/vmlinux-0a093b28.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ca8d73b446ea/bzImage-0a093b28.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e3ec01fd2d18c9264c3b@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in snd_rawmidi_poll+0x559/0x680 sound/core/rawmidi.c:1655
Read of size 8 at addr ffff88801dff4dc8 by task syz-executor387/5079

CPU: 0 PID: 5079 Comm: syz-executor387 Not tainted 6.2.0-rc3-next-20230112-syzkaller #0
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
 io_poll_task_func+0x3a6/0x1220 io_uring/poll.c:327
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
RIP: 0033:0x7fa2db0434a9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 81 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa2dafd0308 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00007fa2db0c7438 RCX: 00007fa2db0434a9
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007fa2db0c7438
RBP: 00007fa2db0c7430 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fa2db095004
R13: 0000000000000005 R14: 00007fa2dafd0400 R15: 0000000000022000
 </TASK>

Allocated by task 5078:
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

Freed by task 5079:
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

The buggy address belongs to the object at ffff88801dff4dc0
 which belongs to the cache kmalloc-32 of size 32
The buggy address is located 8 bytes inside of
 32-byte region [ffff88801dff4dc0, ffff88801dff4de0)

The buggy address belongs to the physical page:
page:ffffea000077fd00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1dff4
anon flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffff888012441500 0000000000000000 dead000000000001
raw: 0000000000000000 0000000080400040 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12c40(GFP_NOFS|__GFP_NOWARN|__GFP_NORETRY), pid 4439, tgid 4439 (udevadm), ts 18106124833, free_ts 13090785320
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
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path_perm+0x22d/0x430 security/tomoyo/file.c:822
 security_inode_getattr+0xd3/0x140 security/security.c:1375
 vfs_getattr fs/stat.c:167 [inline]
 vfs_statx+0x16e/0x430 fs/stat.c:242
 vfs_fstatat+0x90/0xb0 fs/stat.c:276
 __do_sys_newfstatat+0x8a/0x110 fs/stat.c:446
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
 ffff88801dff4c80: fa fb fb fb fc fc fc fc 00 00 00 00 fc fc fc fc
 ffff88801dff4d00: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
>ffff88801dff4d80: 00 00 00 05 fc fc fc fc fa fb fb fb fc fc fc fc
                                              ^
 ffff88801dff4e00: fa fb fb fb fc fc fc fc 00 00 00 00 fc fc fc fc
 ffff88801dff4e80: 00 00 00 00 fc fc fc fc fb fb fb fb fc fc fc fc
==================================================================

