Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794FF63BB66
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 09:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbiK2IVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 03:21:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiK2IVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 03:21:42 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967B456D6C
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 00:21:41 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id w27-20020a05660205db00b006dbce8dc263so7979407iox.16
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 00:21:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hzPbScZkJK24zoKRKbiJijafF327q2f4jJuAvi3gIHM=;
        b=X0c3OuFMGwmuukyXFIfFVL9TBcccVhckU0VgbD9XgEz8DZ0bzGzdPx8K3JspfCpO+D
         o1UwnyyklvPoEY5vpz+YOmPGSmTXTUvcJAa6b8uHG7mQPWaxR26MKBAtdQm3e00in2w+
         LRA0C0xTyaFzH3zO2l5oHJrB1kjzfcYmttKjQsFMnPOGS9ObcwoY/E8obQxQ+GMpupxo
         LX11SdDzT1bHkO2ILMf3Du6P7EKqGVHsfTajSvii0D6M8ajNpgju4Y1ebNbRMScK8eUf
         rEHx9AbzioY2drPpo1YR4nbnTSAKSHns+6t86lrFHHdxCR8D7NGVqyEWul4KkIncZhnA
         qefQ==
X-Gm-Message-State: ANoB5pm9zFMzc6k8DcuGPo46ARErQBTTx2qLxXL0x2Z0W9uNchcNt0ec
        cUe1woZAO5kSz5JITKtolHtLFgcn//N0JSoq+ZiXUeoV7BDH
X-Google-Smtp-Source: AA0mqf7d03KkO4hacO3BZKE9g+b8vlxwz2S8JxvxoHBRQ509wRiRdJXsH6yOu372TclvZ3yu4QvThMpIbu7vI2TZ8izzSbsRDQfP
MIME-Version: 1.0
X-Received: by 2002:a02:194a:0:b0:375:81f:bcdf with SMTP id
 b71-20020a02194a000000b00375081fbcdfmr18617980jab.131.1669710100940; Tue, 29
 Nov 2022 00:21:40 -0800 (PST)
Date:   Tue, 29 Nov 2022 00:21:40 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000071ce7305ee97ad81@google.com>
Subject: [syzbot] BUG: sleeping function called from invalid context in __bread_gfp
From:   syzbot <syzbot+5869fb71f59eac925756@syzkaller.appspotmail.com>
To:     hch@infradead.org, linux-kernel@vger.kernel.org,
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

HEAD commit:    9e46a7996732 Add linux-next specific files for 20221125
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16c56e75880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=11e19c740a0b2926
dashboard link: https://syzkaller.appspot.com/bug?extid=5869fb71f59eac925756
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1620f153880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1623a2c3880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/758d818cf966/disk-9e46a799.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f7c8696b40a5/vmlinux-9e46a799.xz
kernel image: https://storage.googleapis.com/syzbot-assets/810f9750b87f/bzImage-9e46a799.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/961b0d30df48/mount_1.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5869fb71f59eac925756@syzkaller.appspotmail.com

loop0: rw=0, sector=13466417, nr_sectors = 1 limit=128
Buffer I/O error on dev loop0, logical block 13466417, async page read
syz-executor314: attempt to access beyond end of device
loop0: rw=0, sector=8073605, nr_sectors = 1 limit=128
Buffer I/O error on dev loop0, logical block 8073605, async page read
BUG: sleeping function called from invalid context at fs/buffer.c:1331
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 5297, name: syz-executor314
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
3 locks held by syz-executor314/5297:
 #0: ffff88802a7b3f20 (&iint->mutex){+.+.}-{3:3}, at: process_measurement+0x3ab/0x18b0 security/integrity/ima/ima_main.c:260
 #1: ffff888076a08328 (mapping.invalidate_lock#3){.+.+}-{3:3}, at: filemap_invalidate_lock_shared include/linux/fs.h:811 [inline]
 #1: ffff888076a08328 (mapping.invalidate_lock#3){.+.+}-{3:3}, at: page_cache_ra_unbounded+0x153/0x5e0 mm/readahead.c:226
 #2: ffffffff8cb64d98 (pointers_lock){.+.+}-{2:2}, at: get_block+0x16b/0x1580 fs/sysv/itree.c:217
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 1 PID: 5297 Comm: syz-executor314 Not tainted 6.1.0-rc6-next-20221125-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd1/0x138 lib/dump_stack.c:106
 __might_resched.cold+0x222/0x26b kernel/sched/core.c:9991
 __getblk_gfp fs/buffer.c:1331 [inline]
 __bread_gfp+0x40/0x330 fs/buffer.c:1367
 sb_bread include/linux/buffer_head.h:338 [inline]
 get_branch+0x2cd/0x640 fs/sysv/itree.c:104
 get_block+0x188/0x1580 fs/sysv/itree.c:218
 block_read_full_folio+0x35b/0x9d0 fs/buffer.c:2271
 read_pages+0x9fb/0xd40 mm/readahead.c:181
 page_cache_ra_unbounded+0x477/0x5e0 mm/readahead.c:270
 do_page_cache_ra mm/readahead.c:300 [inline]
 page_cache_ra_order+0x6ec/0xa00 mm/readahead.c:560
 ondemand_readahead+0x6b3/0x1000 mm/readahead.c:682
 page_cache_sync_ra+0x1c9/0x200 mm/readahead.c:709
 page_cache_sync_readahead include/linux/pagemap.h:1210 [inline]
 filemap_get_pages+0x2ca/0x16b0 mm/filemap.c:2599
 filemap_read+0x315/0xc00 mm/filemap.c:2693
 generic_file_read_iter+0x3b4/0x5a0 mm/filemap.c:2839
 __kernel_read+0x2ca/0x7c0 fs/read_write.c:428
 integrity_kernel_read+0x7f/0xb0 security/integrity/iint.c:199
 ima_calc_file_hash_tfm+0x2aa/0x3b0 security/integrity/ima/ima_crypto.c:485
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:516 [inline]
 ima_calc_file_hash+0x195/0x4a0 security/integrity/ima/ima_crypto.c:573
 ima_collect_measurement+0x538/0x650 security/integrity/ima/ima_api.c:292
 process_measurement+0xd23/0x18b0 security/integrity/ima/ima_main.c:339
 ima_file_check+0xb0/0x100 security/integrity/ima/ima_main.c:519
 do_open fs/namei.c:3559 [inline]
 path_openat+0x15f1/0x2a50 fs/namei.c:3714
 do_filp_open+0x1ba/0x410 fs/namei.c:3741
 do_sys_openat2+0x16d/0x4c0 fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_open fs/open.c:1334 [inline]
 __se_sys_open fs/open.c:1330 [inline]
 __x64_sys_open+0x11d/0x1c0 fs/open.c:1330
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fcd097ed769
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff5d2c1498 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 00007fcd097ed769
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000000
RBP: 00007fcd097ad000 R08: 0000000000009e07 R09: 0000000000000000
R10: 00007fff5d2c1360 R11: 0000000000000246 R12: 00007fcd097ad090
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
syz-executor314: attempt to access beyond end of device
loop0: rw=0, sector=3245518, nr_sectors = 1 limit=128
Buffer I/O error on dev loop0, logical block 3245518, async page read
syz-executor314: attempt to access beyond end of device
loop0: rw=0, sector=8769403, nr_sectors = 1 limit=128
Buffer I/O error on dev loop0, logical block 8769403, async page read


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
