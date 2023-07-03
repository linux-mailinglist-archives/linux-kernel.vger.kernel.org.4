Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B2A7457E9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 11:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjGCJDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 05:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjGCJDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 05:03:53 -0400
Received: from mail-pg1-f208.google.com (mail-pg1-f208.google.com [209.85.215.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D64CC9
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 02:03:52 -0700 (PDT)
Received: by mail-pg1-f208.google.com with SMTP id 41be03b00d2f7-55b82f399f9so2235931a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 02:03:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688375031; x=1690967031;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tt+elPvBU4JSaauKcFdMY/BKO2C966PXSryxnaJxgAY=;
        b=c9HnXJnkZzmOMLYgFrNUoMA1Ycsyq4BX8oDxXEfM5ex4psKQsKO2wefWwGKQMsLnw+
         GrMs+fjtol6sn4e0zEjvvFxvr5kwlFFNp2rLMYTWAFgrrbK2G6oMk9E8q4rK+a94rIkC
         zgqV5+Nq6lA4wJUVHiZCl43cVOqJnd2FiYIDSE+5XBmbo6i7c4bmEh/j2i4ZPOC6QNCf
         2cAaWucc6Os/qrYnA59Zl5WSWizskHy766wpq6Em6k7DCMon7ayod56mb0URj+JDqpCS
         hCqsrbgR8x6RS1M9A6GY+BNuMI0ZPghY2JrElZ9t1KKOQWyM8o8+sGodJDmR/ULexRkc
         bXpg==
X-Gm-Message-State: ABy/qLZKMI3Ises6SR8gfodTLVErqxZbLks6QSGJ6mMNisJYaMJb7Jrq
        TythJcvDLWd2XYDNy2BvFTSLY0uqSVKL2VSgIxjmIhrM1XkT
X-Google-Smtp-Source: APBJJlFA82iW9rXhYehwMgTc99H3wxQH7FsHWh8E3r+gJgbCSfsXtfO2h3ipz6Lcm+KvV2NOGAWCR16G4dlWCacy9xJB6yMXQ0JP
MIME-Version: 1.0
X-Received: by 2002:a63:2485:0:b0:557:5a08:845a with SMTP id
 k127-20020a632485000000b005575a08845amr5834083pgk.12.1688375031497; Mon, 03
 Jul 2023 02:03:51 -0700 (PDT)
Date:   Mon, 03 Jul 2023 02:03:51 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000008b405ff9172af@google.com>
Subject: [syzbot] [kernel?] bpf test error: UBSAN: array-index-out-of-bounds
 in alloc_pid
From:   syzbot <syzbot+b4667b39c6f42e957680@syzkaller.appspotmail.com>
To:     ast@kernel.org, brauner@kernel.org, daniel@iogearbox.net,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    08fc75735fda mlxsw: minimal: fix potential memory leak in ..
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=177e2770a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=924167e3666ff54c
dashboard link: https://syzkaller.appspot.com/bug?extid=b4667b39c6f42e957680
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/05692fe5b2c1/disk-08fc7573.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6409f36b80fa/vmlinux-08fc7573.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c1ed32d53dbe/bzImage-08fc7573.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b4667b39c6f42e957680@syzkaller.appspotmail.com

================================================================================
UBSAN: array-index-out-of-bounds in kernel/pid.c:244:15
index 1 is out of range for type 'upid [1]'
CPU: 0 PID: 5005 Comm: syz-executor.0 Not tainted 6.4.0-syzkaller-04282-g08fc75735fda #0
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
RIP: 0033:0x7fa69b689fab
Code: ed 0f 85 60 01 00 00 64 4c 8b 0c 25 10 00 00 00 45 31 c0 4d 8d 91 d0 02 00 00 31 d2 31 f6 bf 11 00 20 01 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 89 00 00 00 41 89 c5 85 c0 0f 85 90 00 00
RSP: 002b:00007ffd809b1c70 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 00007ffd809b22c8 RCX: 00007fa69b689fab
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000555556466400
R10: 00005555564666d0 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd809b1d60 R14: 00007fa69b7ac9d8 R15: 000000000000000c
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
