Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D055F045D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 07:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiI3F4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 01:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbiI3F4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 01:56:40 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824E8169E57
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 22:56:39 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id s15-20020a056e021a0f00b002f1760d1437so2760883ild.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 22:56:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=4wWdf138A7pdg5MpUUe8dBDc4hWujJ+GzsjAvjYsmOc=;
        b=MXqEzEM+YhgyCawWsXrgDZEjAjXFIBY8KuE5OEd6MohUUfJU1cW+T6K7dDRADvdLz2
         CH8lqAAqprfLUYyPLTta4ClwrybwkS71veui1qt/axMpN8pAGJlap2utZsEWsEVQIT9v
         fvdMu/YrXHkHMFetEZLD/HNi8PB5e1qAVYcxHMEOmT0HY7wswmOBII8CcbT3UpGYbECl
         lxtRWytD1SCIYCGLUkEm6qdlap43SVxejV9n1y10VGEChkCCz3FRXYXMmvP0C/bXs2BC
         ClMAH08tJI+oDOyPxu2+JC0k/n/XMgmxtl8W9Fn1Hx9nhRO5NDYhBKsuVi/YdAQx15qT
         kQ/A==
X-Gm-Message-State: ACrzQf1853oqKOUhTTDbEsVA1ofoSSNgEwoyBKF+0/0tbHrbvN9XpUgo
        G1Zf+kkY6tx6PoUTdYeuqCSOLWK6kZghDgEJAxaOumn7YjfZ
X-Google-Smtp-Source: AMsMyM6IMe7SXYJPz72ZcLJ2BLun6xkwsr1LirQt34HDfykJqxB+CbZMG1tkvFe8ggJcjvYcEk2yp2Yd/kyiqAnpTrYcuE89Qr11
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2185:b0:35a:80c:c648 with SMTP id
 s5-20020a056638218500b0035a080cc648mr4136166jaj.209.1664517398942; Thu, 29
 Sep 2022 22:56:38 -0700 (PDT)
Date:   Thu, 29 Sep 2022 22:56:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000495a9305e9dea876@google.com>
Subject: [syzbot] WARNING in change_pte_range
From:   syzbot <syzbot+2c2bb573a9524a95e787@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    511cce163b75 Merge tag 'net-6.0-rc8' of git://git.kernel.o..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=155eade4880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4520785fccee9b40
dashboard link: https://syzkaller.appspot.com/bug?extid=2c2bb573a9524a95e787
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14ecac35080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15668b38880000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2c2bb573a9524a95e787@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 3607 at include/linux/swapops.h:323 change_pte_range+0x11f4/0x1ab0 mm/mprotect.c:271
Modules linked in:
CPU: 0 PID: 3607 Comm: syz-executor171 Not tainted 6.0.0-rc7-syzkaller-00130-g511cce163b75 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
RIP: 0010:make_pte_marker_entry include/linux/swapops.h:323 [inline]
RIP: 0010:make_pte_marker include/linux/swapops.h:346 [inline]
RIP: 0010:change_pte_range+0x11f4/0x1ab0 mm/mprotect.c:271
Code: e8 c1 02 bd ff 4c 8b 74 24 18 49 bd 00 00 00 00 00 fc ff df e9 8d fc ff ff e8 a8 02 bd ff 0f 0b e9 72 f4 ff ff e8 9c 02 bd ff <0f> 0b 48 8d 9c 24 00 01 00 00 48 c1 eb 03 42 80 3c 2b 00 74 0d 48
RSP: 0018:ffffc9000399f580 EFLAGS: 00010293
RAX: ffffffff81cc93c4 RBX: 0000000000000000 RCX: ffff88801fdfbb00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc9000399f728 R08: ffffffff81cc8706 R09: ffffed10045001a1
R10: ffffed10045001a1 R11: 1ffff110045001a0 R12: 000000002063d000
R13: dffffc0000000000 R14: ffff888027d251e8 R15: ffff888027d251e8
FS:  000055555742e300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000005d84c8 CR3: 000000007a01e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 change_pmd_range mm/mprotect.c:409 [inline]
 change_pud_range mm/mprotect.c:438 [inline]
 change_p4d_range mm/mprotect.c:459 [inline]
 change_protection_range mm/mprotect.c:483 [inline]
 change_protection+0xc1f/0x16d0 mm/mprotect.c:505
 uffd_wp_range mm/userfaultfd.c:718 [inline]
 mwriteprotect_range+0x50c/0x5a0 mm/userfaultfd.c:768
 userfaultfd_writeprotect fs/userfaultfd.c:1827 [inline]
 userfaultfd_ioctl+0x2733/0x3230 fs/userfaultfd.c:1999
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fbc63941bb9
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff43ddba98 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fbc63941bb9
RDX: 00000000200000c0 RSI: 00000000c018aa06 RDI: 0000000000000003
RBP: 00007fbc63905d60 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fbc63905df0
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
