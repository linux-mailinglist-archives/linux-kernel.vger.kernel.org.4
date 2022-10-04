Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F290D5F3EC7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 10:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbiJDItr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 04:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbiJDItn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 04:49:43 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC1E6442
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 01:49:42 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id g10-20020a056e021e0a00b002f9db676704so3811737ila.14
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 01:49:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=Ov633MB31Y2VOAOMdCgRKWrmst3Y5v5tG/2ltJeamAI=;
        b=Y3SN97sTUvxz5R8aYpSw9E47V8t87Ef30K56Us65rIvdhO59Ivt5xSZ8V0wnRbFqTK
         Z64A9nqGm6K/a6u1bcVEb+SD0w/Ek6Pv/+SwJ5rbBqVNp9hlYtI21yMnK5+NbDfWf/1c
         tKJbAXBHXYGhoBX1QnYEJX0C+Q+HbTJrO7lofAmnkEpO2GU3YpIn+RrqzAodz7XtfjgD
         3hhhGqGzAP/AIu3QeObhiHgI0NpctWGvLoucqQ98/RSagBNCI/d7OOc+CYOa/T5FXyb5
         VePPfKUQPB1S79B7z5/bQUoSrTo5VPxIlnLPStIa4kgFQ69Ohkn5uOoV/mcpI1TOwpxk
         v8ZQ==
X-Gm-Message-State: ACrzQf3PX3LPwlq3D2pWpbN+Tkc5rMSL9kTU/xv5O4brHo5WngUSFm1q
        s/fqlzQGsWx+r6nabnyLjx3IyiZFKCD4XOU+14P77DdKwdJd
X-Google-Smtp-Source: AMsMyM5EXrGrERFsAzsN11cZBpcyv8Z2EHVGq6ZQfYSeVQIZ/iV8kcWiGrtG+auHvwdL1MGQQ7oONDUwpNsrUxrnqU3vtykm8oV3
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:164d:b0:2f1:869c:c45b with SMTP id
 v13-20020a056e02164d00b002f1869cc45bmr10221711ilu.212.1664873381905; Tue, 04
 Oct 2022 01:49:41 -0700 (PDT)
Date:   Tue, 04 Oct 2022 01:49:41 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000086502505ea318af1@google.com>
Subject: [syzbot] UBSAN: shift-out-of-bounds in diNewExt
From:   syzbot <syzbot+e7c25a1325c6112704be@syzkaller.appspotmail.com>
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

HEAD commit:    4fe89d07dcc2 Linux 6.0
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=172dd9e0880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=48b99eaecc2b324f
dashboard link: https://syzkaller.appspot.com/bug?extid=e7c25a1325c6112704be
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=128aee24880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15e61f70880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ce1d9b74a5e0/disk-4fe89d07.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/06e7c02fa7ba/vmlinux-4fe89d07.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e7c25a1325c6112704be@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
================================================================================
UBSAN: shift-out-of-bounds in fs/jfs/jfs_imap.c:2177:9
shift exponent 3328 is too large for 64-bit type '__u64' (aka 'unsigned long long')
CPU: 0 PID: 3614 Comm: syz-executor410 Not tainted 6.0.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:151 [inline]
 __ubsan_handle_shift_out_of_bounds+0x33d/0x3b0 lib/ubsan.c:322
 diNewExt+0x3788/0x3e00 fs/jfs/jfs_imap.c:2177
 diAllocExt fs/jfs/jfs_imap.c:1945 [inline]
 diAllocAG+0xc6a/0x1f80 fs/jfs/jfs_imap.c:1662
 diAlloc+0x3dd/0x1700 fs/jfs/jfs_imap.c:1583
 ialloc+0x8c/0xa80 fs/jfs/jfs_inode.c:56
 jfs_mkdir+0x141/0xb00 fs/jfs/namei.c:225
 vfs_mkdir+0x3b3/0x590 fs/namei.c:4013
 do_mkdirat+0x279/0x550 fs/namei.c:4038
 __do_sys_mkdirat fs/namei.c:4053 [inline]
 __se_sys_mkdirat fs/namei.c:4051 [inline]
 __x64_sys_mkdirat+0x85/0x90 fs/namei.c:4051
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f6d98413009
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff6e1be1f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000102
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f6d98413009
RDX: 0000000000000000 RSI: 0000000020000540 RDI: 0000000000000003
RBP: 00007f6d983d27d0 R08: 0000000000000000 R09: 00007f6d983d27d0
R10: 000000000000002e R11: 0000000000000246 R12: 00000000f8008000
R13: 0000000000000000 R14: 00080000000000f8 R15: 0000000000000000
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
