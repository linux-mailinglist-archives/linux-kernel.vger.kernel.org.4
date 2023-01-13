Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 849B066966F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241261AbjAMMIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:08:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240194AbjAMMHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:07:32 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9017C140DF
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 03:59:22 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id be25-20020a056602379900b006f166af94d6so13179209iob.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 03:59:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I7uTLLRTOJbaDvQLPq/vUYhuwT/SpAyT8M4EGnd2qtg=;
        b=xXgblcoplcrjw7wsOZmjOtVYMUPrPLFZK+BBbCAHXEe/YDKMZPQr4ME92JjtXyvx6G
         JyrTyFR8MZVJOB+Nnw1EVbJ5tWaolJosOiIQUurdFbnyVHfwK90bYyvBXC0H2iHO374W
         7hWgGQWIrA0nIQZRzuYpv6oq9pKwjfxKvLCI7MPi/osU3Q+rGYi1CXgVGlsjulCxZClf
         HTDdgzwYMDbJSDhcXMKuNJhXwtAaFjSuFtboGxcBM3bbREaZQ24AOt4yNQyYcqyr47s9
         rpIAEvt/CzQDU0hOtP6zD7J4wW7odsr88XjJC5rH6x/eDiAvxRt4BM4JhWb2t7+qXo3s
         hvVg==
X-Gm-Message-State: AFqh2ko4XqbljcMtUi0hNFUNFHG7p3+7/jSEzycjBv/xQcGXDwjY56UC
        5LCiwXBx5Ya6j2/cV+m25iz25ZD4YotX529eTj+diGHUi7mS
X-Google-Smtp-Source: AMrXdXuAOYrS2vLUgSbVhcASJGzY7l5m+9VA9fAQK0/rkWcYy448MXhlZoQ5qTthTlt3hWDWCyHsXFnNmTa1lvJ0rHfVgfJe/GWj
MIME-Version: 1.0
X-Received: by 2002:a05:6638:13c1:b0:39d:72ab:a7c5 with SMTP id
 i1-20020a05663813c100b0039d72aba7c5mr8534196jaj.247.1673611161807; Fri, 13
 Jan 2023 03:59:21 -0800 (PST)
Date:   Fri, 13 Jan 2023 03:59:21 -0800
In-Reply-To: <20230113113404.879-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cab25605f223f6ee@google.com>
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
KASAN: use-after-free Read in snd_pcm_oss_poll

==================================================================
BUG: KASAN: use-after-free in snd_pcm_oss_poll+0x91c/0xab0 sound/core/oss/pcm_oss.c:2849
Read of size 8 at addr ffff888017b9dda0 by task syz-executor.0/5602

CPU: 0 PID: 5602 Comm: syz-executor.0 Not tainted 6.2.0-rc3-next-20230112-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd1/0x138 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:306 [inline]
 print_report+0x15e/0x45d mm/kasan/report.c:417
 kasan_report+0xc0/0xf0 mm/kasan/report.c:517
 snd_pcm_oss_poll+0x91c/0xab0 sound/core/oss/pcm_oss.c:2849
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
RIP: 0033:0x7f5fc228c0c9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5fc2f2e168 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: fffffffffffffe00 RBX: 00007f5fc23abf80 RCX: 00007f5fc228c0c9
RDX: 0000000000002020 RSI: 00000000200021c0 RDI: 0000000000000006
RBP: 00007f5fc22e7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff0b78073f R14: 00007f5fc2f2e300 R15: 0000000000022000
 </TASK>

Allocated by task 5602:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:371 [inline]
 ____kasan_kmalloc mm/kasan/common.c:330 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:380
 kmalloc include/linux/slab.h:580 [inline]
 kzalloc include/linux/slab.h:720 [inline]
 snd_pcm_oss_open_file sound/core/oss/pcm_oss.c:2433 [inline]
 snd_pcm_oss_open.part.0+0x558/0x1330 sound/core/oss/pcm_oss.c:2535
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

Freed by task 5601:
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
 snd_pcm_oss_release_file sound/core/oss/pcm_oss.c:2415 [inline]
 snd_pcm_oss_release_file sound/core/oss/pcm_oss.c:2405 [inline]
 snd_pcm_oss_release+0x182/0x300 sound/core/oss/pcm_oss.c:2592
 __fput+0x27c/0xa90 fs/file_table.c:321
 task_work_run+0x16f/0x270 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 exit_to_user_mode_prepare+0x210/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
 syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:297
 do_syscall_64+0x46/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff888017b9dda0
 which belongs to the cache kmalloc-16 of size 16
The buggy address is located 0 bytes inside of
 16-byte region [ffff888017b9dda0, ffff888017b9ddb0)

The buggy address belongs to the physical page:
page:ffffea00005ee740 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff888017b9dd60 pfn:0x17b9d
anon flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffff8880124413c0 0000000000000000 dead000000000001
raw: ffff888017b9dd60 0000000080800076 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 1, tgid 1 (swapper/0), ts 2868545565, free_ts 0
 prep_new_page mm/page_alloc.c:2549 [inline]
 get_page_from_freelist+0x11bb/0x2d50 mm/page_alloc.c:4324
 __alloc_pages+0x1cb/0x5c0 mm/page_alloc.c:5590
 alloc_page_interleave+0x1e/0x200 mm/mempolicy.c:2114
 alloc_pages+0x233/0x270 mm/mempolicy.c:2276
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
 acpi_ns_get_normalized_pathname+0x4d/0x9f drivers/acpi/acpica/nsnames.c:306
 acpi_ex_start_trace_method+0x2e/0x343 drivers/acpi/acpica/extrace.c:176
 acpi_ds_begin_method_execution+0x46/0x7c3 drivers/acpi/acpica/dsmethod.c:304
 acpi_ps_execute_method+0x94/0x620 drivers/acpi/acpica/psxface.c:105
 acpi_ns_evaluate+0x6d4/0x973 drivers/acpi/acpica/nseval.c:205
 acpi_ut_evaluate_object+0xf5/0x3fa drivers/acpi/acpica/uteval.c:60
 acpi_ut_execute_STA+0x86/0x17f drivers/acpi/acpica/uteval.c:223
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888017b9dc80: fb fb fc fc fb fb fc fc 00 00 fc fc 00 00 fc fc
 ffff888017b9dd00: 00 00 fc fc 00 05 fc fc 00 00 fc fc fb fb fc fc
>ffff888017b9dd80: fb fb fc fc fa fb fc fc 00 00 fc fc fa fb fc fc
                               ^
 ffff888017b9de00: fa fb fc fc fb fb fc fc 00 00 fc fc 00 00 fc fc
 ffff888017b9de80: fa fb fc fc 00 00 fc fc fa fb fc fc fb fb fc fc
==================================================================


Tested on:

commit:         0a093b28 Add linux-next specific files for 20230112
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=13dcf65e480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=835f3591019836d5
dashboard link: https://syzkaller.appspot.com/bug?extid=e29d28728f38190cecfc
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16f75c7e480000

