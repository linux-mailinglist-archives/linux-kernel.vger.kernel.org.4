Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7FC668EB4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 08:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241255AbjAMHAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 02:00:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241118AbjAMG7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 01:59:40 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24711CFA
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 22:46:18 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id n8-20020a6bf608000000b007048850aa92so690105ioh.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 22:46:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KfpgCguLL/Sg0wl8a9R7YRbpLxDw04KcDwHAueC8UAQ=;
        b=svn8DyyUW7eX1iIv9Mft+4G32VoDh5jefk6766paoLL89oGkutF/sGEnecB2cpzb67
         2oYkSbXprVgcjO+JQ/XAvIlWtZG481HulpNBpUzDTD5/062bjiw9h7VoGW4CX+f987A5
         GtkDeOdoOYk8+p5tmhQN0W+bZA07YbgDelvPIA5wUf2B7h/CVG1WTaVBm4H1YIr7daUa
         akN6HbIMZ8yN0jEND/vwUl71gGQJYMVnIMJ95V8QJuq7kY1BbZMAqKcRvWlTP0mYVST6
         xpSU8g0MfSCIh1/0cvSL+RQUItTL0oPosoLFmaSUxzjAtFUXQxLYhKcBjn+ChWgFU7IX
         YRQw==
X-Gm-Message-State: AFqh2kru5fObFh5TiyuEcSARYoPKZ4H1UDE4Rxo/oiU8kdCJtIi6vOIO
        got9aHn5HzdfoBFl9dQAhtUiq/sjb00/IiXVSNS7Gfk/wfgT
X-Google-Smtp-Source: AMrXdXvMixTA6h6OcemoIxu6lhJVJHdnwlb/CGipK1S9XhEsv1hFH5VWOrEHaxnES6hV5h6r9wUafBZNyKreH765WUrpiFKEP01T
MIME-Version: 1.0
X-Received: by 2002:a92:1a41:0:b0:302:e38e:761b with SMTP id
 z1-20020a921a41000000b00302e38e761bmr6995773ill.61.1673592377237; Thu, 12 Jan
 2023 22:46:17 -0800 (PST)
Date:   Thu, 12 Jan 2023 22:46:17 -0800
In-Reply-To: <20230113062914.694-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000024eaea05f21f9772@google.com>
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
KASAN: use-after-free Read in io_poll_remove_entries

==================================================================
BUG: KASAN: use-after-free in __lock_acquire+0x3e7f/0x5660 kernel/locking/lockdep.c:4926
Read of size 8 at addr ffff88807e78e268 by task syz-executor.0/5598

CPU: 0 PID: 5598 Comm: syz-executor.0 Not tainted 6.2.0-rc3-next-20230112-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd1/0x138 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:306 [inline]
 print_report+0x15e/0x45d mm/kasan/report.c:417
 kasan_report+0xc0/0xf0 mm/kasan/report.c:517
 __lock_acquire+0x3e7f/0x5660 kernel/locking/lockdep.c:4926
 lock_acquire.part.0+0x11a/0x350 kernel/locking/lockdep.c:5669
 __raw_spin_lock_irq include/linux/spinlock_api_smp.h:119 [inline]
 _raw_spin_lock_irq+0x36/0x50 kernel/locking/spinlock.c:170
 spin_lock_irq include/linux/spinlock.h:375 [inline]
 io_poll_remove_entry io_uring/poll.c:183 [inline]
 io_poll_remove_entries.part.0+0x15e/0x810 io_uring/poll.c:216
 io_poll_remove_entries io_uring/poll.c:196 [inline]
 io_poll_task_func+0x56c/0x1220 io_uring/poll.c:330
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
RIP: 0033:0x7f977d48c0c9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f977e27c218 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00007f977d5ac058 RCX: 00007f977d48c0c9
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007f977d5ac058
RBP: 00007f977d5ac050 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f977d5ac05c
R13: 00007ffef7edfc4f R14: 00007f977e27c300 R15: 0000000000022000
 </TASK>

Allocated by task 5596:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:371 [inline]
 ____kasan_kmalloc mm/kasan/common.c:330 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:380
 kmalloc include/linux/slab.h:580 [inline]
 kzalloc include/linux/slab.h:720 [inline]
 snd_rawmidi_runtime_create sound/core/rawmidi.c:164 [inline]
 open_substream+0xe9/0x8c0 sound/core/rawmidi.c:341
 rawmidi_open_priv+0x591/0x6f0 sound/core/rawmidi.c:394
 snd_rawmidi_open+0x467/0xb70 sound/core/rawmidi.c:492
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
 snd_rawmidi_runtime_free sound/core/rawmidi.c:192 [inline]
 close_substream.part.0+0x21d/0x850 sound/core/rawmidi.c:570
 close_substream sound/core/rawmidi.c:544 [inline]
 rawmidi_release_priv+0x192/0x270 sound/core/rawmidi.c:587
 snd_rawmidi_release+0x87/0x120 sound/core/rawmidi.c:624
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

The buggy address belongs to the object at ffff88807e78e200
 which belongs to the cache kmalloc-256 of size 256
The buggy address is located 104 bytes inside of
 256-byte region [ffff88807e78e200, ffff88807e78e300)

The buggy address belongs to the physical page:
page:ffffea0001f9e380 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7e78e
head:ffffea0001f9e380 order:1 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 ffff888012441b40 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 5542, tgid 5542 (syz-executor.0), ts 112149922863, free_ts 109467087241
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
 new_dir fs/proc/proc_sysctl.c:971 [inline]
 get_subdir fs/proc/proc_sysctl.c:1015 [inline]
 __register_sysctl_table+0x9ef/0x10a0 fs/proc/proc_sysctl.c:1366
 mpls_dev_sysctl_register+0x1b7/0x2d0 net/mpls/af_mpls.c:1421
 mpls_add_dev net/mpls/af_mpls.c:1472 [inline]
 mpls_dev_notify+0x46d/0x990 net/mpls/af_mpls.c:1612
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:87
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:1944
 call_netdevice_notifiers_extack net/core/dev.c:1982 [inline]
 call_netdevice_notifiers net/core/dev.c:1996 [inline]
 register_netdevice+0xfb4/0x1640 net/core/dev.c:10078
 cfg80211_register_netdevice+0x157/0x330 net/wireless/core.c:1397
 ieee80211_if_add+0x1073/0x1960 net/mac80211/iface.c:2198
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1451 [inline]
 free_pcp_prepare+0x4d0/0x910 mm/page_alloc.c:1501
 free_unref_page_prepare mm/page_alloc.c:3387 [inline]
 free_unref_page+0x1d/0x490 mm/page_alloc.c:3482
 qlink_free mm/kasan/quarantine.c:168 [inline]
 qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x192/0x220 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0x63/0x90 mm/kasan/common.c:302
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook mm/slab.h:769 [inline]
 slab_alloc_node mm/slub.c:3452 [inline]
 slab_alloc mm/slub.c:3460 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3467 [inline]
 kmem_cache_alloc+0x175/0x320 mm/slub.c:3476
 getname_flags.part.0+0x50/0x4f0 fs/namei.c:140
 getname_flags include/linux/audit.h:320 [inline]
 getname+0x92/0xd0 fs/namei.c:219
 do_sys_openat2+0xf5/0x4c0 fs/open.c:1305
 do_sys_open fs/open.c:1327 [inline]
 __do_sys_openat fs/open.c:1343 [inline]
 __se_sys_openat fs/open.c:1338 [inline]
 __x64_sys_openat+0x143/0x1f0 fs/open.c:1338
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff88807e78e100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88807e78e180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88807e78e200: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                          ^
 ffff88807e78e280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807e78e300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


Tested on:

commit:         0a093b28 Add linux-next specific files for 20230112
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=140bcf4a480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=835f3591019836d5
dashboard link: https://syzkaller.appspot.com/bug?extid=e3ec01fd2d18c9264c3b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=117f933c480000

