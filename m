Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8350D6B5725
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 01:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjCKA4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 19:56:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjCKAyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 19:54:37 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6FC31219F9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 16:52:53 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id y2-20020a929502000000b0031707c6b348so3529878ilh.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 16:52:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678495954;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ED3Lin7pjjoMQKKlq87nbDb5qRkLm7D1/zsYFauf6Vk=;
        b=18DseaohZor2hgAb54BfggwbHbPOvbfchdmTIdVOsTO/7dSt2YTlz5DByITi8l5aJ1
         DRGP3NlTOYtuGxeK4wAiH0DehwYBTtppRY5WzVkFnY3PSz+jQ/HG1fFTIEaPIkwvNoKA
         N1fiGOMkZpcQw0mVhhulPLbouuP57dFzfl1PYnE5tRNcmd2zP3baF1/DXAtW9oq99oCq
         pq/Mc1t20Bq770WKslwYP27M/+Kh83iALi9iW+ZtCYPdL74OpGlPr21v+OH1RBjC5T+V
         er2TA8KKUYYBZHs4JQMBrsKaLFgcamTECiDbNlowL7fy49ukg9cYsoqvszHaYAbamcpl
         dvEA==
X-Gm-Message-State: AO0yUKWvkqKhyI3/0earh+oCdPExeoUvNrogCokORm+I4Z7H+O14191M
        7zDoMV/fBII7aqvurdZ+S5mIhzuD7GkVae5kxNjbApl3pYNr
X-Google-Smtp-Source: AK7set9tTx0avff0Dvj8qwoQW8hZ69vKWh3fUohYeoEmy9M4Fmd64JKuBZ7UGZH+ldGWiM+KVHaeOvDj29jG/pfxTjd8XZ0RCL/r
MIME-Version: 1.0
X-Received: by 2002:a02:94ab:0:b0:3ad:65e:e489 with SMTP id
 x40-20020a0294ab000000b003ad065ee489mr13158690jah.1.1678495954657; Fri, 10
 Mar 2023 16:52:34 -0800 (PST)
Date:   Fri, 10 Mar 2023 16:52:34 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000226a6105f6954b47@google.com>
Subject: [syzbot] [mm?] kernel BUG in hpage_collapse_scan_file
From:   syzbot <syzbot+9578faa5475acb35fa50@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    857f1268a591 Merge tag 'objtool-core-2023-03-02' of git://..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=168e1032c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f763d89e26d3d4c4
dashboard link: https://syzkaller.appspot.com/bug?extid=9578faa5475acb35fa50
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=179e4e12c80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=119cce98c80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b3b7a7e333f1/disk-857f1268.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5940be1cf171/vmlinux-857f1268.xz
kernel image: https://storage.googleapis.com/syzbot-assets/986015398e4a/bzImage-857f1268.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9578faa5475acb35fa50@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at mm/khugepaged.c:1823!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 5097 Comm: syz-executor220 Not tainted 6.2.0-syzkaller-13154-g857f1268a591 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/16/2023
RIP: 0010:collapse_file mm/khugepaged.c:1823 [inline]
RIP: 0010:hpage_collapse_scan_file+0x67c8/0x7580 mm/khugepaged.c:2233
Code: 00 00 89 de e8 c9 66 a3 ff 31 ff 89 de e8 c0 66 a3 ff 45 84 f6 0f 85 28 0d 00 00 e8 22 64 a3 ff e9 dc f7 ff ff e8 18 64 a3 ff <0f> 0b f3 0f 1e fa e8 0d 64 a3 ff e9 93 f6 ff ff f3 0f 1e fa 4c 89
RSP: 0018:ffffc90003dff4e0 EFLAGS: 00010093
RAX: ffffffff81e95988 RBX: 00000000000001c1 RCX: ffff8880205b3a80
RDX: 0000000000000000 RSI: 00000000000001c0 RDI: 00000000000001c1
RBP: ffffc90003dff830 R08: ffffffff81e90e67 R09: fffffbfff1a433c3
R10: 0000000000000000 R11: dffffc0000000001 R12: 0000000000000000
R13: ffffc90003dff6c0 R14: 00000000000001c0 R15: 0000000000000000
FS:  00007fdbae5ee700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fdbae6901e0 CR3: 000000007b2dd000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 madvise_collapse+0x721/0xf50 mm/khugepaged.c:2693
 madvise_vma_behavior mm/madvise.c:1086 [inline]
 madvise_walk_vmas mm/madvise.c:1260 [inline]
 do_madvise+0x9e5/0x4680 mm/madvise.c:1439
 __do_sys_madvise mm/madvise.c:1452 [inline]
 __se_sys_madvise mm/madvise.c:1450 [inline]
 __x64_sys_madvise+0xa5/0xb0 mm/madvise.c:1450
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fdbae65dc39
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fdbae5ee2f8 EFLAGS: 00000246 ORIG_RAX: 000000000000001c
RAX: ffffffffffffffda RBX: 00007fdbae6e64b8 RCX: 00007fdbae65dc39
RDX: 0000000000000019 RSI: 000000000060005f RDI: 0000000020000000
RBP: 00007fdbae6e64b0 R08: 0000000000000001 R09: 0000000000000033
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fdbae5ee300
R13: 0000000000000001 R14: 00007fdbae5ee400 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:collapse_file mm/khugepaged.c:1823 [inline]
RIP: 0010:hpage_collapse_scan_file+0x67c8/0x7580 mm/khugepaged.c:2233
Code: 00 00 89 de e8 c9 66 a3 ff 31 ff 89 de e8 c0 66 a3 ff 45 84 f6 0f 85 28 0d 00 00 e8 22 64 a3 ff e9 dc f7 ff ff e8 18 64 a3 ff <0f> 0b f3 0f 1e fa e8 0d 64 a3 ff e9 93 f6 ff ff f3 0f 1e fa 4c 89
RSP: 0018:ffffc90003dff4e0 EFLAGS: 00010093
RAX: ffffffff81e95988 RBX: 00000000000001c1 RCX: ffff8880205b3a80
RDX: 0000000000000000 RSI: 00000000000001c0 RDI: 00000000000001c1
RBP: ffffc90003dff830 R08: ffffffff81e90e67 R09: fffffbfff1a433c3
R10: 0000000000000000 R11: dffffc0000000001 R12: 0000000000000000
R13: ffffc90003dff6c0 R14: 00000000000001c0 R15: 0000000000000000
FS:  00007fdbae5ee700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fdbae6901e0 CR3: 000000007b2dd000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
