Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9AC75EE6BB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 22:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233996AbiI1Unn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 16:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233134AbiI1Unl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 16:43:41 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52EF88E9A5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 13:43:40 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id s15-20020a056e021a0f00b002f1760d1437so10662196ild.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 13:43:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=nstnZIDjGjtGExNjTIDmjV9nq6K+84XmwWh9HIHAZLg=;
        b=ti/7yamnMrptiQdnLYYb5BiGM9q5oRO1cZKm1aVVoh3qEcsSe0oN3pXVhrYDFY1seT
         hIgjFwn2qwcE/QARa0hRYFnWkUQOvktr4OPpmvdr/5CNjppsV549JyHYeZE41o/Yx/R6
         gRRljLDGLlaJDkFWkla+v9LUT1vWSeRoc3iADrs+RNCKRVc+wpz4xIkCxjh5yjj+yPyR
         Yn3t0p3DSUHSaliIja0AbfX7Zhlg1nNLOIOKXk1JUgu11H9q1xVKW8KMYsvM7kAh0hSq
         Udr4rSfV9EOct/BzZa3MfAyodOcnJIrLXcCRJY1GVaEvS0h/2xRurncQ9NZrBMuByrKR
         YIzg==
X-Gm-Message-State: ACrzQf0CKrKj9GvZZZqsEIOsAXSLZNRAeF4PFeeS3VG5E9zIt4EIDQaC
        J8PlXDy8VPLF9Yp9wFJEtDUYlVA7MuU5FLPOOorW5sgkETij
X-Google-Smtp-Source: AMsMyM4uZ5DgjycIi3Jt1GAyaf9KJQOhVWRAICGi/t0+htTcLLtl6tYx7Povvsh1wpXNiTkQ2Zw4+rmUdmqm6yTQYpgTErwEZw9L
MIME-Version: 1.0
X-Received: by 2002:a92:c6c9:0:b0:2f6:d00c:8ab0 with SMTP id
 v9-20020a92c6c9000000b002f6d00c8ab0mr13392756ilm.85.1664397819685; Wed, 28
 Sep 2022 13:43:39 -0700 (PDT)
Date:   Wed, 28 Sep 2022 13:43:39 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ceb2fa05e9c2d0e3@google.com>
Subject: [syzbot] UBSAN: shift-out-of-bounds in dbAllocAG
From:   syzbot <syzbot+15342c1aa6a00fb7a438@syzkaller.appspotmail.com>
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

HEAD commit:    3800a713b607 Merge tag 'mm-hotfixes-stable-2022-09-26' of ..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1513bdc4880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ba0d23aa7e1ffaf5
dashboard link: https://syzkaller.appspot.com/bug?extid=15342c1aa6a00fb7a438
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14e7836c880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16fc20e0880000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+15342c1aa6a00fb7a438@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 97743
================================================================================
UBSAN: shift-out-of-bounds in fs/jfs/jfs_dmap.c:1313:21
shift exponent 8345714 is too large for 64-bit type 's64' (aka 'long long')
CPU: 1 PID: 3614 Comm: syz-executor252 Not tainted 6.0.0-rc7-syzkaller-00029-g3800a713b607 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:151 [inline]
 __ubsan_handle_shift_out_of_bounds+0x33d/0x3b0 lib/ubsan.c:322
 dbAllocAG+0xf3d/0x1100 fs/jfs/jfs_dmap.c:1313
 dbAlloc+0x661/0xc90 fs/jfs/jfs_dmap.c:858
 diNewIAG fs/jfs/jfs_imap.c:2500 [inline]
 diAllocExt fs/jfs/jfs_imap.c:1898 [inline]
 diAllocAG+0xaf6/0x1f80 fs/jfs/jfs_imap.c:1662
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
RIP: 0033:0x7f533bcccf49
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffffbdf0e58 EFLAGS: 00000246 ORIG_RAX: 0000000000000053
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f533bcccf49
RDX: 00007f533bc8b443 RSI: 0000000000000000 RDI: 00000000200052c0
RBP: 00007f533bc8c710 R08: 0000000000000000 R09: 0000000000000000
R10: 00007ffffbdf0d20 R11: 0000000000000246 R12: 00000000f8008000
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
