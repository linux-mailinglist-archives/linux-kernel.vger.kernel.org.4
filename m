Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB4E6426BE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 11:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbiLEKfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 05:35:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiLEKfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 05:35:41 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93F2120B9
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 02:35:39 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id w15-20020a056e021a6f00b00303520bff1dso4248816ilv.20
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 02:35:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4NVD0/lHTGy5BssM6fI6VE7z/hPQ17efuLuI55z+OiA=;
        b=4XUy1r9ZBFwEX3eqJchJQivcKWOSWFg9mML7vhYFSRI8JZx61bBJGd7BHi5VuMpayb
         0coAFw2WJ71QkRXBAXQsvQt1ff6m2M2I4csM46hoqd2dmNZuToIMkOYrWrXuOTCJAdeM
         1o0JbULvcQ+aMpT8iKSrMitm2CJX4sBOU0hhlGYwHFYF0aoRkRkWhGFejl+Oav9fgqrf
         mjiekG1Ta+wZq0Hvr2eMz3ComBZx4XAl4IZ2sjFdjYXRx8XrhsPTQ/wmDFmhS/YyWsF1
         suItcIdtPdcTECyYoj5fq+s9zALXHOw69VHePmbsrIvkZLRABj2akrCqQfGuaLaSqX2S
         N1Gg==
X-Gm-Message-State: ANoB5pnUAT2pMZ1XEWuT0fW+IpCAfwFqoKywjYGSo19Jc6thJoVI5H+L
        CRkK1ucUlrDBaA9fiAwin8YqCqSbF4P+193igiEAtQhQLuWX
X-Google-Smtp-Source: AA0mqf6G9KH4mw2tIFGWLsWZlR+LgQqIR2sSpsm+S+/xbBsdCXIP1aO7crsqkxa0gkJQYazCPjiRC1HTtyyfLUtnaSSlGkG93SGi
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1251:b0:303:1c15:2818 with SMTP id
 j17-20020a056e02125100b003031c152818mr14652184ilq.87.1670236539074; Mon, 05
 Dec 2022 02:35:39 -0800 (PST)
Date:   Mon, 05 Dec 2022 02:35:39 -0800
In-Reply-To: <000000000000abbde005ef113644@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009a423705ef123f9a@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in xfs_qm_dqfree_one
From:   syzbot <syzbot+912776840162c13db1a3@syzkaller.appspotmail.com>
To:     djwong@kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    0ba09b173387 Revert "mm: align larger anonymous mappings o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15550c47880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2325e409a9a893e1
dashboard link: https://syzkaller.appspot.com/bug?extid=912776840162c13db1a3
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=128c9e23880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9758ec2c06f4/disk-0ba09b17.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/06781dbfd581/vmlinux-0ba09b17.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3d44a22d15fa/bzImage-0ba09b17.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/335889b2d730/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+912776840162c13db1a3@syzkaller.appspotmail.com

XFS (loop1): Quotacheck: Done.
syz-executor.1 (4657): drop_caches: 2
==================================================================
BUG: KASAN: use-after-free in xfs_dquot_type fs/xfs/xfs_dquot.h:136 [inline]
BUG: KASAN: use-after-free in xfs_qm_dqfree_one+0x12f/0x170 fs/xfs/xfs_qm.c:1604
Read of size 1 at addr ffff888079a6aa58 by task syz-executor.1/4657

CPU: 1 PID: 4657 Comm: syz-executor.1 Not tainted 6.1.0-rc7-syzkaller-00211-g0ba09b173387 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 print_address_description+0x74/0x340 mm/kasan/report.c:284
 print_report+0x107/0x1f0 mm/kasan/report.c:395
 kasan_report+0xcd/0x100 mm/kasan/report.c:495
 xfs_dquot_type fs/xfs/xfs_dquot.h:136 [inline]
 xfs_qm_dqfree_one+0x12f/0x170 fs/xfs/xfs_qm.c:1604
 xfs_qm_shrink_scan+0x351/0x410 fs/xfs/xfs_qm.c:523
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
RIP: 0033:0x7fc3e3c8c0d9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc3e4a9a168 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007fc3e3dabf80 RCX: 00007fc3e3c8c0d9
RDX: 0000000020002080 RSI: 0000000000000004 RDI: 0000000000000006
RBP: 00007fc3e3ce7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000870 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fffcb98dc7f R14: 00007fc3e4a9a300 R15: 0000000000022000
 </TASK>

Allocated by task 4642:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x3d/0x60 mm/kasan/common.c:52
 __kasan_slab_alloc+0x65/0x70 mm/kasan/common.c:325
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slab.h:737 [inline]
 slab_alloc_node mm/slub.c:3398 [inline]
 slab_alloc mm/slub.c:3406 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3413 [inline]
 kmem_cache_alloc+0x1cc/0x300 mm/slub.c:3422
 kmem_cache_zalloc include/linux/slab.h:679 [inline]
 xfs_dquot_alloc+0x36/0x600 fs/xfs/xfs_dquot.c:475
 xfs_qm_dqread+0x8a/0x1d0 fs/xfs/xfs_dquot.c:659
 xfs_qm_dqget+0x27d/0x4f0 fs/xfs/xfs_dquot.c:870
 xfs_qm_vop_dqalloc+0x9bf/0xca0 fs/xfs/xfs_qm.c:1704
 xfs_setattr_nonsize+0x3c2/0xfd0 fs/xfs/xfs_iops.c:702
 xfs_vn_setattr+0x2f5/0x340 fs/xfs/xfs_iops.c:1022
 notify_change+0xe38/0x10f0 fs/attr.c:420
 chown_common+0x586/0x8f0 fs/open.c:736
 do_fchownat+0x165/0x240 fs/open.c:767
 __do_sys_chown fs/open.c:787 [inline]
 __se_sys_chown fs/open.c:785 [inline]
 __x64_sys_chown+0x7e/0x90 fs/open.c:785
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 3677:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x3d/0x60 mm/kasan/common.c:52
 kasan_save_free_info+0x27/0x40 mm/kasan/generic.c:511
 ____kasan_slab_free+0xd6/0x120 mm/kasan/common.c:236
 kasan_slab_free include/linux/kasan.h:177 [inline]
 slab_free_hook mm/slub.c:1724 [inline]
 slab_free_freelist_hook+0x12e/0x1a0 mm/slub.c:1750
 slab_free mm/slub.c:3661 [inline]
 kmem_cache_free+0x94/0x1d0 mm/slub.c:3683
 xfs_qm_dqpurge+0x4f7/0x660 fs/xfs/xfs_qm.c:177
 xfs_qm_dquot_walk+0x249/0x490 fs/xfs/xfs_qm.c:87
 xfs_qm_dqpurge_all fs/xfs/xfs_qm.c:193 [inline]
 xfs_qm_unmount+0x71/0x100 fs/xfs/xfs_qm.c:205
 xfs_unmountfs+0xc5/0x1e0 fs/xfs/xfs_mount.c:1059
 xfs_fs_put_super+0x6e/0x2d0 fs/xfs/xfs_super.c:1115
 generic_shutdown_super+0x130/0x310 fs/super.c:492
 kill_block_super+0x79/0xd0 fs/super.c:1428
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

The buggy address belongs to the object at ffff888079a6aa40
 which belongs to the cache xfs_dquot of size 704
The buggy address is located 24 bytes inside of
 704-byte region [ffff888079a6aa40, ffff888079a6ad00)

The buggy address belongs to the physical page:
page:ffffea0001e69a00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x79a68
head:ffffea0001e69a00 order:2 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 0000000000000000 dead000000000122 ffff88814660f000
raw: 0000000000000000 0000000080130013 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 33, tgid 33 (kworker/u4:2), ts 336553992665, free_ts 335702258247
 prep_new_page mm/page_alloc.c:2539 [inline]
 get_page_from_freelist+0x742/0x7c0 mm/page_alloc.c:4291
 __alloc_pages+0x259/0x560 mm/page_alloc.c:5558
 alloc_slab_page+0xbd/0x190 mm/slub.c:1794
 allocate_slab+0x5e/0x4b0 mm/slub.c:1939
 new_slab mm/slub.c:1992 [inline]
 ___slab_alloc+0x782/0xe20 mm/slub.c:3180
 __slab_alloc mm/slub.c:3279 [inline]
 slab_alloc_node mm/slub.c:3364 [inline]
 slab_alloc mm/slub.c:3406 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3413 [inline]
 kmem_cache_alloc+0x24c/0x300 mm/slub.c:3422
 kmem_cache_zalloc include/linux/slab.h:679 [inline]
 xfs_dquot_alloc+0x36/0x600 fs/xfs/xfs_dquot.c:475
 xfs_qm_dqread+0x8a/0x1d0 fs/xfs/xfs_dquot.c:659
 xfs_qm_dqget+0x27d/0x4f0 fs/xfs/xfs_dquot.c:870
 xfs_qm_quotacheck_dqadjust+0xb7/0x380 fs/xfs/xfs_qm.c:1077
 xfs_qm_dqusage_adjust+0x4bd/0x630 fs/xfs/xfs_qm.c:1189
 xfs_iwalk_ag_recs+0x425/0x620 fs/xfs/xfs_iwalk.c:220
 xfs_iwalk_run_callbacks+0x20f/0x410 fs/xfs/xfs_iwalk.c:376
 xfs_iwalk_ag+0xaa5/0xb80 fs/xfs/xfs_iwalk.c:482
 xfs_iwalk_ag_work+0xf5/0x1a0 fs/xfs/xfs_iwalk.c:624
 xfs_pwork_work+0x7f/0x180 fs/xfs/xfs_pwork.c:47
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1459 [inline]
 free_pcp_prepare+0x80c/0x8f0 mm/page_alloc.c:1509
 free_unref_page_prepare mm/page_alloc.c:3387 [inline]
 free_unref_page+0x7d/0x5f0 mm/page_alloc.c:3483
 __stack_depot_save+0x430/0x4a0 lib/stackdepot.c:506
 kasan_save_stack mm/kasan/common.c:46 [inline]
 kasan_set_track+0x52/0x60 mm/kasan/common.c:52
 kasan_save_free_info+0x27/0x40 mm/kasan/generic.c:511
 ____kasan_slab_free+0xd6/0x120 mm/kasan/common.c:236
 kasan_slab_free include/linux/kasan.h:177 [inline]
 slab_free_hook mm/slub.c:1724 [inline]
 slab_free_freelist_hook+0x12e/0x1a0 mm/slub.c:1750
 slab_free mm/slub.c:3661 [inline]
 __kmem_cache_free+0x71/0x110 mm/slub.c:3674
 memcg_free_slab_cgroups mm/slab.h:456 [inline]
 unaccount_slab mm/slab.h:645 [inline]
 __free_slab+0xf0/0x320 mm/slub.c:2015
 qlist_free_all+0x2b/0x70 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x169/0x180 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0x1f/0x70 mm/kasan/common.c:302
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slab.h:737 [inline]
 slab_alloc_node mm/slub.c:3398 [inline]
 __kmem_cache_alloc_node+0x1d7/0x310 mm/slub.c:3437
 __do_kmalloc_node mm/slab_common.c:954 [inline]
 __kmalloc+0x9e/0x1a0 mm/slab_common.c:968
 kmalloc include/linux/slab.h:558 [inline]
 tomoyo_realpath_from_path+0xcd/0x5f0 security/tomoyo/realpath.c:251
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path_perm+0x227/0x670 security/tomoyo/file.c:822

Memory state around the buggy address:
 ffff888079a6a900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888079a6a980: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>ffff888079a6aa00: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
                                                    ^
 ffff888079a6aa80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888079a6ab00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

