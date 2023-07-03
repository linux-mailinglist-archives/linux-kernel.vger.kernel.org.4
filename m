Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC357455C9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 09:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjGCHOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 03:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjGCHOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 03:14:18 -0400
Received: from mail-pl1-f206.google.com (mail-pl1-f206.google.com [209.85.214.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0948D1
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 00:14:17 -0700 (PDT)
Received: by mail-pl1-f206.google.com with SMTP id d9443c01a7336-1b81fc6c729so40891805ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 00:14:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688368457; x=1690960457;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FiushiSfg6f9PKpxdTF+RiXQTOLM60T0zS1Udr4o8yA=;
        b=UC749tdrzh9FMFoTfuxhVmvef9KeNSd4ImVlNTf0GUK6Aei2yx6exnLWEIP2Ff0QlH
         55AnQ0g9+LQ6aTw7Ix/cslNhIulzOAF5ORRZmLdK1Z/foQMo/UhyqayTqEPG/9HEwsrU
         Z0pa5WHVZBMsoobjK9GkVz/UsJqqzlwLEoeWkj9zeKAsc+Enagh+xzXpApkXRok86PRl
         SQGtopUa3ebwjh4nRJeZZEaJVCSl2UF7NG0Rmu8A1tCIdEXDGGcjc4VuatoJlhbwhgfA
         oKoJbB+YZeV0OLmhW1jpUf1+FhIKf/i3IkAgOD1u+yE+HXicHIrESKwx6WZv5JK6sKAm
         UzDQ==
X-Gm-Message-State: ABy/qLauNyJxWG9GzGb1+11TDfx2XMhOOFcO8C7SDFHSPsYKLaetNj5i
        t07wqvrTFG7Kk3c6wtwcgYBCDjn2Fx6ZT+eFXasfKEbCbMvW
X-Google-Smtp-Source: APBJJlE8iI+mnF0+rk8ncXvJoianUpb+0iOKs4AHlJw840u+vHHx1cGSy9kO6Yu2ghFzy5lQAcT8p2HVnAoYixfzXZkegu/rmvqV
MIME-Version: 1.0
X-Received: by 2002:a17:903:2906:b0:1b8:95fc:d18 with SMTP id
 lh6-20020a170903290600b001b895fc0d18mr1569876plb.8.1688368457213; Mon, 03 Jul
 2023 00:14:17 -0700 (PDT)
Date:   Mon, 03 Jul 2023 00:14:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000246c3f05ff8fea48@google.com>
Subject: [syzbot] [kernel?] bpf-next test error: UBSAN: array-index-out-of-bounds
 in alloc_pid
From:   syzbot <syzbot+319a9b09e5de1ecae1e1@syzkaller.appspotmail.com>
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

HEAD commit:    c20f9cef725b Merge branch 'libbpf: add netfilter link atta..
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=127adbfb280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=924167e3666ff54c
dashboard link: https://syzkaller.appspot.com/bug?extid=319a9b09e5de1ecae1e1
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bf9c9608a1e0/disk-c20f9cef.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3bde4e994bd0/vmlinux-c20f9cef.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5d80f8634183/bzImage-c20f9cef.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+319a9b09e5de1ecae1e1@syzkaller.appspotmail.com

================================================================================
UBSAN: array-index-out-of-bounds in kernel/pid.c:244:15
index 1 is out of range for type 'upid [1]'
CPU: 0 PID: 5004 Comm: syz-executor.0 Not tainted 6.4.0-syzkaller-04259-gc20f9cef725b #0
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
RIP: 0033:0x7ff043489fab
Code: ed 0f 85 60 01 00 00 64 4c 8b 0c 25 10 00 00 00 45 31 c0 4d 8d 91 d0 02 00 00 31 d2 31 f6 bf 11 00 20 01 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 89 00 00 00 41 89 c5 85 c0 0f 85 90 00 00
RSP: 002b:00007ffdc29faa70 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 00007ffdc29fb0c8 RCX: 00007ff043489fab
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000555555ae9400
R10: 0000555555ae96d0 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffdc29fab60 R14: 00007ff0435ac9d8 R15: 000000000000000c
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
