Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0783E5F3F0D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiJDJAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiJDJAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:00:51 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27D918E16
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 02:00:50 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id h10-20020a056e021d8a00b002f99580de6cso5630027ila.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 02:00:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=xqdyea8zNXSLysP69+RS3i6tEiW68qL39ci7tqDECjE=;
        b=Z7C9OI1iqDDtBuVVLDHka0suY4V1DRLaM+DEBfiKPXQisMYZc3LxtHB6f+/2UiA1K3
         /JuRuKdO/L5fAK82JCfE72myrZxCT2Fn9zKbgFhFZhml65KTbClYms0mNJJYEdE6TO+y
         UqWI5d+rCt57kqh0FMzAWwWFekRnh/crAA1yVEmZHbOEWEtpckGRizr5xJsYfJEnno4g
         PQV6mPFsEllWLdxzGoJCSwD/POKvywUybCCeRTDup+yrt/0p0mKvtx+d5+O2x04oSiz1
         7zIaSwrX+OJuUUQhuvy0vOaGdCH0AEP2VLMsOEnMP8L7u+1sryuGStdeRXig7E5coFvV
         oGIw==
X-Gm-Message-State: ACrzQf20GoYGzUY0AodWY4bexvc7yUkK8LQxKLbZm8yZHt4RAvDGiRh5
        1R2Z/+SAL+AOlf23IHIL+PtSLjHmve0fl1jN66vo5WBmXYAK
X-Google-Smtp-Source: AMsMyM4YGJ+zb3S6oI8nPoTroSqIQwW7Wk/p/FwFADn70OwBhRL2WxFBz3LwlSNyZLXx/8SKneTYz2WulvuOeLwPHd5ofbV9QXWl
MIME-Version: 1.0
X-Received: by 2002:a05:6638:345b:b0:35a:21be:e7 with SMTP id
 q27-20020a056638345b00b0035a21be00e7mr11855651jav.311.1664874050091; Tue, 04
 Oct 2022 02:00:50 -0700 (PDT)
Date:   Tue, 04 Oct 2022 02:00:50 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005a02da05ea31b295@google.com>
Subject: [syzbot] UBSAN: shift-out-of-bounds in dbSplit
From:   syzbot <syzbot+8c777e17f74c66068ffa@syzkaller.appspotmail.com>
To:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        shaggy@kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    b357fd1c2afc Merge tag 'usb-6.0-final' of git://git.kernel..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=114398a2880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ba0d23aa7e1ffaf5
dashboard link: https://syzkaller.appspot.com/bug?extid=8c777e17f74c66068ffa
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=162d1932880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16e43e24880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c3f38889d41b/disk-b357fd1c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8b4dacf1eadb/vmlinux-b357fd1c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8c777e17f74c66068ffa@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
================================================================================
UBSAN: shift-out-of-bounds in fs/jfs/jfs_dmap.c:2606:11
shift exponent 109 is too large for 32-bit type 'int'
CPU: 0 PID: 3606 Comm: syz-executor363 Not tainted 6.0.0-rc7-syzkaller-00239-gb357fd1c2afc #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:151 [inline]
 __ubsan_handle_shift_out_of_bounds+0x33d/0x3b0 lib/ubsan.c:322
 dbSplit+0x1e6/0x1f0 fs/jfs/jfs_dmap.c:2606
 dbAllocBits+0x532/0x9c0 fs/jfs/jfs_dmap.c:2158
 dbAllocDmap fs/jfs/jfs_dmap.c:1999 [inline]
 dbAllocNear+0x26a/0x390 fs/jfs/jfs_dmap.c:1228
 dbAlloc+0xa12/0xc90 fs/jfs/jfs_dmap.c:813
 diNewExt+0xaad/0x3e00 fs/jfs/jfs_imap.c:2251
 diAllocExt fs/jfs/jfs_imap.c:1945 [inline]
 diAllocAG+0xc6a/0x1f80 fs/jfs/jfs_imap.c:1662
 diAlloc+0x3dd/0x1700 fs/jfs/jfs_imap.c:1583
 ialloc+0x8c/0xa80 fs/jfs/jfs_inode.c:56
 jfs_mkdir+0x141/0xb00 fs/jfs/namei.c:225
 vfs_mkdir+0x3b3/0x590 fs/namei.c:4013
 do_mkdirat+0x279/0x550 fs/namei.c:4038
 __do_sys_mkdir fs/namei.c:4058 [inline]
 __se_sys_mkdir fs/namei.c:4056 [inline]
 __x64_sys_mkdir+0x6a/0x80 fs/namei.c:4056
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f622558edc9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff59147288 EFLAGS: 00000246 ORIG_RAX: 0000000000000053
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f622558edc9
RDX: 00007f622554d2c3 RSI: 0000000000000000 RDI: 00000000200052c0
RBP: 00007f622554e590 R08: 0000555555b3d2c0 R09: 0000000000000000
R10: 00007fff59147150 R11: 0000000000000246 R12: 00000000f8008000
R13: 0000000000000000 R14: 00080000000000fc R15: 0000000000000000
 </TASK>
================================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
