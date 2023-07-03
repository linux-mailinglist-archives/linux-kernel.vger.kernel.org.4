Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C26745560
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 08:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjGCGT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 02:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjGCGT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 02:19:56 -0400
Received: from mail-pg1-f207.google.com (mail-pg1-f207.google.com [209.85.215.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97CEBF
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 23:19:54 -0700 (PDT)
Received: by mail-pg1-f207.google.com with SMTP id 41be03b00d2f7-528ab71c95cso3742887a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jul 2023 23:19:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688365194; x=1690957194;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CDkahJodiXFcs7gkNv9N8r/9oLwv2oJU5LPEjTK0ILo=;
        b=KffvD6YFEOsrKZOwz3zI0xVJqUEkOUphGQHE79+IwNyPmPfnJ3KNrgLmg4sHVuDFCM
         tqvDI3Gaj3FcKlSvRTQ8oDgXDWyKOqph513oEfO3DH2HdreXSjfhqJ+bFH+ul1o+38Lu
         iFm1RP8G1jpXyP4tXJ54l6GIcHBYj77jb9bWxRYxw75ism5nZ3/ZKIQI9oO88YHoZXcY
         xakSZefbo9MMQF5bmcVZn7Bj50Uk+E8cT96VCmONHaB1VWRe4XbTqnm+Ga+0Z3AMD7o+
         w5B7wWOXo1kgB6cA3ialw39lA/iD/tiVoYY3Z5qYJSBkW9pOUVsqKv9tn+QAYyje+NNe
         rJWg==
X-Gm-Message-State: ABy/qLbqTmK3EkTWTFGpXA6SkXQMByzE4p9jLVeDLpTt0m6/ycwkZB+A
        kq2DUsVt77h5W0uTnTMMG/+X4Pajzcfb8XQgb8y3f3bwTkuf
X-Google-Smtp-Source: APBJJlFu5xVmBSnGMC346Snpkz3WDWRUpn2pz6dgAPpa2yTKyfwoFfuTn7o6+C6Vk05m2W9+04O4akrYgWnQkrsKxKKLT2Emo5D3
MIME-Version: 1.0
X-Received: by 2002:a63:114d:0:b0:55b:3576:c630 with SMTP id
 13-20020a63114d000000b0055b3576c630mr3611112pgr.9.1688365194188; Sun, 02 Jul
 2023 23:19:54 -0700 (PDT)
Date:   Sun, 02 Jul 2023 23:19:54 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a6a01c05ff8f2745@google.com>
Subject: [syzbot] [kernel?] net test error: UBSAN: array-index-out-of-bounds
 in alloc_pid
From:   syzbot <syzbot+3945b679bf589be87530@syzkaller.appspotmail.com>
To:     brauner@kernel.org, davem@davemloft.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    97791d3c6d0a Merge branch 'octeontx2-af-fixes'
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=11b1a6d7280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=924167e3666ff54c
dashboard link: https://syzkaller.appspot.com/bug?extid=3945b679bf589be87530
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2bd5d64db6b8/disk-97791d3c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cd31502424f2/vmlinux-97791d3c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/33c6f22e34ab/bzImage-97791d3c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3945b679bf589be87530@syzkaller.appspotmail.com

================================================================================
UBSAN: array-index-out-of-bounds in kernel/pid.c:244:15
index 1 is out of range for type 'upid [1]'
CPU: 1 PID: 5009 Comm: syz-executor.0 Not tainted 6.4.0-syzkaller-04291-g97791d3c6d0a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x136/0x150 lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:217 [inline]
 __ubsan_handle_out_of_bounds+0xd5/0x140 lib/ubsan.c:348
 alloc_pid+0xbe5/0xdd0 kernel/pid.c:244
 copy_process+0x4589/0x7620 kernel/fork.c:2519
 kernel_clone+0xeb/0x890 kernel/fork.c:2911
 __do_sys_clone+0xba/0x100 kernel/fork.c:3054
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f392b489fab
Code: ed 0f 85 60 01 00 00 64 4c 8b 0c 25 10 00 00 00 45 31 c0 4d 8d 91 d0 02 00 00 31 d2 31 f6 bf 11 00 20 01 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 89 00 00 00 41 89 c5 85 c0 0f 85 90 00 00
RSP: 002b:00007ffca92c9fb0 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 00007ffca92ca608 RCX: 00007f392b489fab
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000555556bf0400
R10: 0000555556bf06d0 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffca92ca0a0 R14: 00007f392b5ac9d8 R15: 000000000000000c
 </TASK>
================================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
