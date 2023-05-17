Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62786706162
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 09:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjEQHkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 03:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjEQHkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 03:40:05 -0400
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48579196
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 00:40:04 -0700 (PDT)
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-33156204adcso7461865ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 00:40:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684309203; x=1686901203;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=69VsXeyPuZfUkl/0X2g0yMrT/XXVKTEkT0F6vVJIoGg=;
        b=Hnv36IzO/PtaKAC3TNAqEFLnhnB7c+PrrGPBA/BQeWZ03UwJbRuEtWPQ1fXPlVKlF2
         PkG6P8/OKerkaJuyzQzU95shIL9LfqAM0z23pYprTvb4dy5tj5RSeAPAy8xcbgJ9j1IX
         NeXZBn7nftywuUjhWhn5Fyd+6F8QJz1wqPt9j/11WJp6CBhdm/G4T8adu/vY+X1xv2aT
         JAsIrdMw7XwVvnjUSJDWZtX0ItjiMxDOgIiGhYjIHU9+v5wu409rVg321YTl2K3rYgdK
         YckaojeG2B4xURkQykhyifRCi1tfKYjVsxLzmXgPL2kgxsdT5NMKtobPhqrL/LqEm9T/
         Kb/Q==
X-Gm-Message-State: AC+VfDzMwJdohMlYB3XltcIN20NH5b3mWDV/ZO1cNJDGchpcU8TCuq88
        /jtSjy7nViybUBT+E3QUCjG/u0iiJIYESygof+nGqYMndQl6
X-Google-Smtp-Source: ACHHUZ7uskBz3KEz7qbkJs6uORi9CJzYHEMEhlHZvYV40zrittXllcU++Vbq85REdlNAiZ3qfDXLBq0MwFp2Cbd2vn6N40ahhpHN
MIME-Version: 1.0
X-Received: by 2002:a92:dd07:0:b0:331:57f3:6af3 with SMTP id
 n7-20020a92dd07000000b0033157f36af3mr1019476ilm.1.1684309203665; Wed, 17 May
 2023 00:40:03 -0700 (PDT)
Date:   Wed, 17 May 2023 00:40:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c6de2a05fbdecbbb@google.com>
Subject: [syzbot] [kernel?] linux-next test error: UBSAN: array-index-out-of-bounds
 in alloc_pid
From:   syzbot <syzbot+ac3b41786a2d0565b6d5@syzkaller.appspotmail.com>
To:     brauner@kernel.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    065efa589871 Add linux-next specific files for 20230517
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17f27bb2280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=821eeb02ef201bcc
dashboard link: https://syzkaller.appspot.com/bug?extid=ac3b41786a2d0565b6d5
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/dbbd691e9e5a/disk-065efa58.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e5b9541c3979/vmlinux-065efa58.xz
kernel image: https://storage.googleapis.com/syzbot-assets/44cf3f3aaabb/bzImage-065efa58.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ac3b41786a2d0565b6d5@syzkaller.appspotmail.com

================================================================================
UBSAN: array-index-out-of-bounds in kernel/pid.c:244:15
index 1 is out of range for type 'upid [1]'
CPU: 1 PID: 5002 Comm: syz-executor.0 Not tainted 6.4.0-rc2-next-20230517-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/28/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x136/0x150 lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:217 [inline]
 __ubsan_handle_out_of_bounds+0xd5/0x140 lib/ubsan.c:348
 alloc_pid+0xbe5/0xdd0 kernel/pid.c:244
 copy_process+0x45da/0x7660 kernel/fork.c:2522
 kernel_clone+0xeb/0x890 kernel/fork.c:2914
 __do_sys_clone+0xba/0x100 kernel/fork.c:3057
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f23be089e9b
Code: ed 0f 85 60 01 00 00 64 4c 8b 0c 25 10 00 00 00 45 31 c0 4d 8d 91 d0 02 00 00 31 d2 31 f6 bf 11 00 20 01 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 89 00 00 00 41 89 c5 85 c0 0f 85 90 00 00
RSP: 002b:00007ffe5c64b680 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 00007ffe5c64bcd8 RCX: 00007f23be089e9b
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000555557393400
R10: 00005555573936d0 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe5c64b770 R14: 00007f23be1ac9d8 R15: 000000000000000c
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
