Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F1C7454F3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 07:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjGCFh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 01:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjGCFhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 01:37:03 -0400
Received: from mail-pj1-f80.google.com (mail-pj1-f80.google.com [209.85.216.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6271FFA
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 22:36:04 -0700 (PDT)
Received: by mail-pj1-f80.google.com with SMTP id 98e67ed59e1d1-262e04a6f5aso4012582a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jul 2023 22:36:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688362551; x=1690954551;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G07eNYXZVQBu1aaWjBImsvGy+41He/VOhgutSbvriqs=;
        b=JRq0s+nxGhvCIoLow/6x5pEvdl3USMgJ+Nf32Q3zBihUBQj3vNGj3kIRxTAD3ShRCI
         TLky6cZzqLkyB8XfiAfcxDuMw6JFci6r4BGdHVmu9cXCC58Ayi6LkrFCNVDWLuxs/lZ3
         3A1G8rNtF9APpqQ5ZtYzi71+Kd9NJai8eMHqhhJyuPqaiyMTQ6oreioBnyVrQ2nAy/h1
         XxoDurFsqQr9NxxeOHMcreApKsBtqbkSyZsIxr7ufTx7ZlCYqw7cqoS1fiaP0vb10xrd
         WBLaqhCpWp4OhXo34+ndGaqmDfroHtOukGcU2ouEZ2U2UoOct60gEp1H3xAuZSiyqAbg
         AR0A==
X-Gm-Message-State: ABy/qLaNifkxjIa+UMr/4jN+pnxnlhOJxVCyLqT7WPQErqjwaXKCWDrW
        hsP88hjBAI/ZRN28GbBZnKFy8or9qnJ2MhvRGsBR9vjj75p3
X-Google-Smtp-Source: APBJJlFi+4VVk02P2ZotLw3xKlO56q0sqWSrjFMT7bfm99gBfb7tCcDJ6hpXuI++x7/4JnptX7Yq+dO7KNvs6xX+Ph/YwdOmWRT3
MIME-Version: 1.0
X-Received: by 2002:a17:90a:df88:b0:263:39c1:d0b2 with SMTP id
 p8-20020a17090adf8800b0026339c1d0b2mr6719572pjv.5.1688362550867; Sun, 02 Jul
 2023 22:35:50 -0700 (PDT)
Date:   Sun, 02 Jul 2023 22:35:50 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000018bd0d05ff8e8ab2@google.com>
Subject: [syzbot] [kernel?] net-next test error: UBSAN: array-index-out-of-bounds
 in alloc_pid
From:   syzbot <syzbot+f02ef87ef8bbb97026bd@syzkaller.appspotmail.com>
To:     brauner@kernel.org, davem@davemloft.net, kuba@kernel.org,
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

HEAD commit:    3a8a670eeeaa Merge tag 'net-next-6.5' of git://git.kernel...
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1391a15f280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=924167e3666ff54c
dashboard link: https://syzkaller.appspot.com/bug?extid=f02ef87ef8bbb97026bd
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/580f71d6d107/disk-3a8a670e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7d94a5879cd1/vmlinux-3a8a670e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4ef3ba2a581e/bzImage-3a8a670e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f02ef87ef8bbb97026bd@syzkaller.appspotmail.com

================================================================================
UBSAN: array-index-out-of-bounds in kernel/pid.c:244:15
index 1 is out of range for type 'upid [1]'
CPU: 0 PID: 5002 Comm: syz-executor.0 Not tainted 6.4.0-syzkaller-04247-g3a8a670eeeaa #0
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
RIP: 0033:0x7f8d13e89fab
Code: ed 0f 85 60 01 00 00 64 4c 8b 0c 25 10 00 00 00 45 31 c0 4d 8d 91 d0 02 00 00 31 d2 31 f6 bf 11 00 20 01 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 89 00 00 00 41 89 c5 85 c0 0f 85 90 00 00
RSP: 002b:00007ffd13d711a0 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 00007ffd13d717f8 RCX: 00007f8d13e89fab
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
RBP: 0000000000000000 R08: 0000000000000000 R09: 00005555557cb400
R10: 00005555557cb6d0 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd13d71290 R14: 00007f8d13fac9d8 R15: 000000000000000c
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
