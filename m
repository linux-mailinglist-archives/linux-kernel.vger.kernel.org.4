Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E34064991E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 08:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbiLLHCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 02:02:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbiLLHB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 02:01:57 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60B2BF46
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 23:01:55 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id 7-20020a056e0220c700b0030386f0d0e6so4613481ilq.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 23:01:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R/Ii6yFmO2BXLhgXqntCbiGYTlFrt+rcf8pmcn+zQ9Y=;
        b=Qx5yxrFC/Kn28GF13mp1E/wExD1HUFEh+z7D05BzLDTccAyht3gwTD93I4jjdH8cPN
         ZdI3Txk9x4b0Xa2xEM5eVpkm99AXZieNw9J+nqcguiHwG1TRX8USwTXh+UvwIlzyg17I
         UOhx4Do7o8OvmLBvbej2sq6+wBWFx5dj8boWX8lY4ioTXo7kiityv01ptPxRRyimqfFN
         dM6w2onV7Xky4sPxtqCvwFkzmuvPmFA57cZ4Eaoenp0WIGFuiYoDZpdHOfcHKXCN4T9e
         JFx/rkN6A4ZFwUooV6IvLz+dd2SfDdS1yzJNNsQs2x/qaiK301C8RiEf/gBZUA3F6Nei
         asYA==
X-Gm-Message-State: ANoB5pl5QnIW6rGkgPOkQc84IMURAvwx1YznUDGsjRN8pujlbU7ZVDOH
        ZTiZVIAFTFvnq+7G6N1FF1s5nPDBpHOZ/RWzzyLjV1G/qar0
X-Google-Smtp-Source: AA0mqf6tInURORHqi1Lna0vdH+MSwDcleek1JB2BBZHmdx6TlIe4urP2C12HlxFSUACMxzyMvTu4eUaiyr6tHY3SZSwX4Hwi55EP
MIME-Version: 1.0
X-Received: by 2002:a92:d2c9:0:b0:303:4c12:437b with SMTP id
 w9-20020a92d2c9000000b003034c12437bmr10773526ilg.80.1670828515067; Sun, 11
 Dec 2022 23:01:55 -0800 (PST)
Date:   Sun, 11 Dec 2022 23:01:55 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001f0e5705ef9c14de@google.com>
Subject: [syzbot] KASAN: slab-out-of-bounds Read in udf_get_filelongad
From:   syzbot <syzbot+60f291a24acecb3c2bd5@syzkaller.appspotmail.com>
To:     jack@suse.com, linux-kernel@vger.kernel.org,
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

syzbot found the following issue on:

HEAD commit:    3ecc37918c80 Merge tag 'media/v6.1-4' of git://git.kernel...
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12ade243880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4edf421741552bc3
dashboard link: https://syzkaller.appspot.com/bug?extid=60f291a24acecb3c2bd5
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16f936b7880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=119cda43880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3f930c005326/disk-3ecc3791.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4874d6925017/vmlinux-3ecc3791.xz
kernel image: https://storage.googleapis.com/syzbot-assets/20d788700546/bzImage-3ecc3791.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/bcd8d5227f17/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+60f291a24acecb3c2bd5@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 2048
UDF-fs: INFO Mounting volume 'LinuxUDF', timestamp 2022/11/22 14:59 (1000)
==================================================================
BUG: KASAN: slab-out-of-bounds in udf_get_filelongad+0x138/0x140 fs/udf/directory.c:235
Read of size 4 at addr ffff88801cd9df58 by task syz-executor397/3629

CPU: 0 PID: 3629 Comm: syz-executor397 Not tainted 6.1.0-rc8-syzkaller-00152-g3ecc37918c80 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd1/0x138 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:284 [inline]
 print_report+0x15e/0x45d mm/kasan/report.c:395
 kasan_report+0xbf/0x1f0 mm/kasan/report.c:495
 udf_get_filelongad+0x138/0x140 fs/udf/directory.c:235
 udf_current_aext+0x1d6/0x940 fs/udf/inode.c:2206
 udf_next_aext+0x210/0x410 fs/udf/inode.c:2142
 udf_extend_file fs/udf/inode.c:662 [inline]
 udf_setsize+0xa1e/0x1080 fs/udf/inode.c:1249
 udf_setattr+0x4a8/0x5e0 fs/udf/file.c:281
 notify_change+0xcd4/0x1440 fs/attr.c:420
 do_truncate+0x140/0x200 fs/open.c:65
 do_sys_ftruncate+0x53a/0x730 fs/open.c:193
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fd80d1a9909
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffef9f8c468 EFLAGS: 00000246 ORIG_RAX: 000000000000004d
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fd80d1a9909
RDX: 00007fd80d1a9909 RSI: 0100000000000000 RDI: 0000000000000005
RBP: 00007fd80d1691a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fd80d169230
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

Allocated by task 3629:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:371 [inline]
 ____kasan_kmalloc mm/kasan/common.c:330 [inline]
 __kasan_kmalloc+0xa5/0xb0 mm/kasan/common.c:380
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slab_common.c:955 [inline]
 __kmalloc+0x5a/0xd0 mm/slab_common.c:968
 kmalloc include/linux/slab.h:558 [inline]
 kzalloc include/linux/slab.h:689 [inline]
 tomoyo_init_log+0x128e/0x1ed0 security/tomoyo/audit.c:275
 tomoyo_supervisor+0x354/0xf10 security/tomoyo/common.c:2088
 tomoyo_audit_path_number_log security/tomoyo/file.c:235 [inline]
 tomoyo_path_number_perm+0x3f3/0x550 security/tomoyo/file.c:734
 security_file_ioctl+0x54/0xb0 security/security.c:1554
 __do_sys_ioctl fs/ioctl.c:864 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0xb7/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 3629:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2e/0x40 mm/kasan/generic.c:511
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x160/0x1c0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:177 [inline]
 slab_free_hook mm/slub.c:1724 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1750
 slab_free mm/slub.c:3661 [inline]
 __kmem_cache_free+0xaf/0x3b0 mm/slub.c:3674
 tomoyo_supervisor+0x375/0xf10 security/tomoyo/common.c:2140
 tomoyo_audit_path_number_log security/tomoyo/file.c:235 [inline]
 tomoyo_path_number_perm+0x3f3/0x550 security/tomoyo/file.c:734
 security_file_ioctl+0x54/0xb0 security/security.c:1554
 __do_sys_ioctl fs/ioctl.c:864 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0xb7/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff88801cd9dc00
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 344 bytes to the right of
 512-byte region [ffff88801cd9dc00, ffff88801cd9de00)

The buggy address belongs to the physical page:
page:ffffea0000736700 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1cd9c
head:ffffea0000736700 order:2 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 ffffea00007b0700 dead000000000002 ffff888012041c80
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 209, tgid 209 (kworker/u4:1), ts 5723325076, free_ts 0
 prep_new_page mm/page_alloc.c:2539 [inline]
 get_page_from_freelist+0x10b5/0x2d50 mm/page_alloc.c:4291
 __alloc_pages+0x1cb/0x5b0 mm/page_alloc.c:5558
 alloc_pages+0x1aa/0x270 mm/mempolicy.c:2285
 alloc_slab_page mm/slub.c:1794 [inline]
 allocate_slab+0x25f/0x350 mm/slub.c:1939
 new_slab mm/slub.c:1992 [inline]
 ___slab_alloc+0xa91/0x1400 mm/slub.c:3180
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3279
 slab_alloc_node mm/slub.c:3364 [inline]
 __kmem_cache_alloc_node+0x199/0x3e0 mm/slub.c:3437
 kmalloc_trace+0x26/0x60 mm/slab_common.c:1045
 kmalloc include/linux/slab.h:553 [inline]
 kzalloc include/linux/slab.h:689 [inline]
 alloc_bprm+0x51/0x900 fs/exec.c:1508
 kernel_execve+0xaf/0x500 fs/exec.c:1967
 call_usermodehelper_exec_async+0x2e7/0x580 kernel/umh.c:113
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88801cd9de00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88801cd9de80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88801cd9df00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                                                    ^
 ffff88801cd9df80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88801cd9e000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
