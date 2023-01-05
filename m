Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A383C65F156
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 17:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233450AbjAEQnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 11:43:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbjAEQng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 11:43:36 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F8544C41
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 08:43:35 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id z9-20020a6be009000000b006e0577c3686so10981520iog.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 08:43:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jNTz1hkBS1l8MvXBQfTTOWlvzPcDywW7mv6gEQd1HTQ=;
        b=TKenySqt298p01STzPoitHI4+IfCsuQ9lMtZsgLvlRS+yifTv7Msrh6PqpxEjChlfn
         HamYVWEog++ZjunJagYI/d6CrHRri7Fxq+nGZwz+0FgETnWr+VGrJOCEp+S3D+rSzRsX
         +zPQbtTKD8hbgLxKLaN8wNGhS16dWCLID07WYAqQBkB07nLmMgrOGT9FHmq6wizpGNqj
         +qlqHGKbgnjMIN1mB53MhgV9GFlnWzuamsAZ5/Br383KueFrdvjm/wOdTvJ2tkwOT1Yg
         G1W8fOTMA5BxHG1s7gLQIoJi+V1fUtkq0vb6vBS/9mEqTl9t6ZipgJ/uLmCcBbC6qMRK
         E66Q==
X-Gm-Message-State: AFqh2koh8dQsKyqSl2ELmMix1iEM6zTDeuy0Vpre5Jie8JEKsYJ1fL02
        goLyf0gikFWIxkvzsSL9A/z7lv9QnFGAzHZ1sJOuyJyQOTWQ
X-Google-Smtp-Source: AMrXdXsx8X7qj/Ibya7mq7Ee1wAykpVkPg4g7GkP5M15CMiQiGAQ3c2zK+tlsfCsXtrr6zZo+Fh04DVRl84I6vpjXVSz3bdAbn/G
MIME-Version: 1.0
X-Received: by 2002:a5d:89d9:0:b0:6ec:f32a:ee58 with SMTP id
 a25-20020a5d89d9000000b006ecf32aee58mr3391984iot.65.1672937014625; Thu, 05
 Jan 2023 08:43:34 -0800 (PST)
Date:   Thu, 05 Jan 2023 08:43:34 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007d126605f187002a@google.com>
Subject: [syzbot] [udf?] KASAN: null-ptr-deref Write in udf_fiiter_add_entry
From:   syzbot <syzbot+b1b66db80fe98b733c58@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, gorcunov@gmail.com, jack@suse.com,
        jack@suse.cz, linux-kernel@vger.kernel.org, penberg@cs.helsinki.fi,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    c76083fac3ba Add linux-next specific files for 20221226
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=104afeb2480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c217c755f1884ab6
dashboard link: https://syzkaller.appspot.com/bug?extid=b1b66db80fe98b733c58
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=136ca714480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16fcd5da480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e388f26357fd/disk-c76083fa.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e24f0bae36d5/vmlinux-c76083fa.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a5a69a059716/bzImage-c76083fa.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/bb457662f7c3/mount_0.gz

The issue was bisected to:

commit 869e9be21b1c67010d215c83c38b32f6cbd080cc
Author: Jan Kara <jack@suse.cz>
Date:   Tue Dec 20 11:38:45 2022 +0000

    udf: Allocate name buffer in directory iterator on heap

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15ce5eb2480000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17ce5eb2480000
console output: https://syzkaller.appspot.com/x/log.txt?x=13ce5eb2480000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b1b66db80fe98b733c58@syzkaller.appspotmail.com
Fixes: 869e9be21b1c ("udf: Allocate name buffer in directory iterator on heap")

RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007fcd6a74ea39
RDX: 0000000000000000 RSI: 0000000000141043 RDI: 00000000200000c0
RBP: 00007ffc262fb620 R08: 0000000000000002 R09: 00007ffc262fb630
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000004
R13: 00007ffc262fb660 R14: 00007ffc262fb640 R15: 0000000000000008
 </TASK>
==================================================================
BUG: KASAN: null-ptr-deref in udf_fiiter_add_entry+0x75b/0x10d0 fs/udf/namei.c:316
Write of size 4 at addr 0000000000000000 by task syz-executor153/5085

CPU: 0 PID: 5085 Comm: syz-executor153 Not tainted 6.2.0-rc1-next-20221226-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd1/0x138 lib/dump_stack.c:106
 kasan_report+0xc0/0xf0 mm/kasan/report.c:517
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0x141/0x190 mm/kasan/generic.c:189
 memcpy+0x3d/0x60 mm/kasan/shadow.c:66
 udf_fiiter_add_entry+0x75b/0x10d0 fs/udf/namei.c:316
 udf_add_nondir+0xda/0x360 fs/udf/namei.c:349
 udf_create+0x12c/0x180 fs/udf/namei.c:384
 lookup_open.isra.0+0xee7/0x1270 fs/namei.c:3413
 open_last_lookups fs/namei.c:3481 [inline]
 path_openat+0x975/0x2a50 fs/namei.c:3711
 do_filp_open+0x1ba/0x410 fs/namei.c:3741
 do_sys_openat2+0x16d/0x4c0 fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_open fs/open.c:1334 [inline]
 __se_sys_open fs/open.c:1330 [inline]
 __x64_sys_open+0x11d/0x1c0 fs/open.c:1330
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fcd6a74ea39
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc262fb5f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007fcd6a74ea39
RDX: 0000000000000000 RSI: 0000000000141043 RDI: 00000000200000c0
RBP: 00007ffc262fb620 R08: 0000000000000002 R09: 00007ffc262fb630
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000004
R13: 00007ffc262fb660 R14: 00007ffc262fb640 R15: 0000000000000008
 </TASK>
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
