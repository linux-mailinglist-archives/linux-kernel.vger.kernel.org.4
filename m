Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802625EADF9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 19:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbiIZRTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 13:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbiIZRSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 13:18:41 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E53DDDAF
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 09:32:40 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id n23-20020a056602341700b00689fc6dbfd6so4152485ioz.8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 09:32:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=s23SmX4DPK8K98xVQRMtibV5VTt2dCr5aGGI/kcQ0ko=;
        b=Aj3J0BKLI4xrJ8ysjzJ4WjYrY9wgOfshRtzCMW69JYb4B4mbygKIV9rcxTLlo2UHHa
         92Rj690uSPPaJNt4KcHV/SeueUhlkzhfkbIgU2qHA5QjRdrjuHv4Sr7syl5OUj1vALpQ
         VUCBjDBnMk6I8uW8jRHR577Yq83qSwxGDrFcY1UclDtotlTFg22Ciu9zGHB2BjpN2Cjn
         mEOEpLGrH5EjQDHzEycLvcAhzRYsneSBcviaHBUiilLwdlQwQlyoYyH5qHqK/b6isLlc
         kOJXPLv7pl3dWlZRtI93o6tWe34j/jmIWdBfiG6UDRasrI1+xZO1JgSnXye4TQlG7ltm
         8hIA==
X-Gm-Message-State: ACrzQf3mYIdyyzEFsJMD+xO4ZTVSqWKUa+02i8pI486cWmEEMngoA2z6
        zJD2IEVRQUfBqslD86H5HEkktYLt3Ps+AShEh4b1Dmu8l6bs
X-Google-Smtp-Source: AMsMyM47amV/fN6sUXZQTdQ4UlVRNhOS6wvQ6HTaHjF9nWnF5IuXDlj7JcEj2Y+9t9n/aTE6oPw6B28sOzORfIEXwdiG9VF5uMFw
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12ca:b0:2f6:5f42:8a1b with SMTP id
 i10-20020a056e0212ca00b002f65f428a1bmr10517434ilm.109.1664209956008; Mon, 26
 Sep 2022 09:32:36 -0700 (PDT)
Date:   Mon, 26 Sep 2022 09:32:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000427b1a05e997130a@google.com>
Subject: [syzbot] UBSAN: shift-out-of-bounds in diAlloc
From:   syzbot <syzbot+9cd47a3d9ebd6776eb03@syzkaller.appspotmail.com>
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

HEAD commit:    3db61221f4e8 Merge tag 'io_uring-6.0-2022-09-23' of git://..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1017fb54880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c221af36f6d1d811
dashboard link: https://syzkaller.appspot.com/bug?extid=9cd47a3d9ebd6776eb03
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12bbd0d4880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=153195ef080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9cd47a3d9ebd6776eb03@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 66104
================================================================================
UBSAN: shift-out-of-bounds in fs/jfs/jfs_imap.c:1357:9
shift exponent 218103809 is too large for 64-bit type 'u64' (aka 'unsigned long long')
CPU: 1 PID: 3607 Comm: syz-executor161 Not tainted 6.0.0-rc6-syzkaller-00291-g3db61221f4e8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:151 [inline]
 __ubsan_handle_shift_out_of_bounds+0x33d/0x3b0 lib/ubsan.c:322
 diAlloc+0x141a/0x1700 fs/jfs/jfs_imap.c:1357
 ialloc+0x8c/0xa80 fs/jfs/jfs_inode.c:56
 jfs_create+0x13a/0xb10 fs/jfs/namei.c:92
 lookup_open fs/namei.c:3413 [inline]
 open_last_lookups fs/namei.c:3481 [inline]
 path_openat+0x12d0/0x2df0 fs/namei.c:3688
 do_filp_open+0x264/0x4f0 fs/namei.c:3718
 do_sys_openat2+0x124/0x4e0 fs/open.c:1313
 do_sys_open fs/open.c:1329 [inline]
 __do_sys_creat fs/open.c:1405 [inline]
 __se_sys_creat fs/open.c:1399 [inline]
 __x64_sys_creat+0x11f/0x160 fs/open.c:1399
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f60b0aa1f09
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc52136898 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f60b0aa1f09
RDX: 00007f60b0a60403 RSI: 0000000000000000 RDI: 0000000020000040
RBP: 00007f60b0a616d0 R08: 0000000000000000 R09: 0000000000000000
R10: 00007ffc52136760 R11: 0000000000000246 R12: 00000000f8008000
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
