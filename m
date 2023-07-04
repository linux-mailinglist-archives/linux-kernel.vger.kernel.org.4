Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84402746DCE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 11:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjGDJlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 05:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbjGDJkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 05:40:37 -0400
Received: from mail-pf1-f205.google.com (mail-pf1-f205.google.com [209.85.210.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05AC2D4F
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 02:38:29 -0700 (PDT)
Received: by mail-pf1-f205.google.com with SMTP id d2e1a72fcca58-682abcb2fdeso227412b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 02:38:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688463476; x=1691055476;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=azSqcnqtvoXPhv8yvd/aLp/S/SWoO7oZsZz2Umspmyk=;
        b=DB3cvOuObj302RdJcE1XTACEKdmdPqbob1vaGuTfd3Q8bu70RP4IcBusxtSF28ZFME
         erLs0z3gWzfvy4k5ZSZUSiQjic3Uvwv/nw1JsZRP4JQbGZ1OUu9mKqNgwNYo1SHUVnaq
         L+YNaE/dq3B8Fd4313OMrY6N0fWL09UezfWxVT0rcBuu6XId9FH+gAWZQIJAustcI9gC
         vYm2H3nWHi+fs+ma4mpkUoTu+PqKGDsASFqGvfSZT2PCDAlIvCyWzj5e6y/l6XUUv+vK
         Ejdt6UcjwhL1U06Cdf5zb/L+qRm4t75Jhvd2wwAItowyyIpEeeAg/yFyeV+rmplaCquT
         g6RA==
X-Gm-Message-State: ABy/qLYV+3ywNCNGS4atfwNO0nAmc5LblF4KgZR4wzfZcr1fJGPeuTQq
        HhZflOOD/6Bb9ZBIMUatxCmNnzOzwSQ6+QKUe6U9KLJTV+Iq
X-Google-Smtp-Source: APBJJlHH6QR6XFxrsE/c3/5Y1wQ6vHorElxRPJQGWW2PvgqQjsIzQMjuReU8Ju4ZD0drZ5Buj/E6k8omsKDLE3iqk8Hd9I2oZB3P
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:b46:b0:674:a3be:2773 with SMTP id
 p6-20020a056a000b4600b00674a3be2773mr17206454pfo.5.1688463476208; Tue, 04 Jul
 2023 02:37:56 -0700 (PDT)
Date:   Tue, 04 Jul 2023 02:37:56 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b73abf05ffa60902@google.com>
Subject: [syzbot] [mm?] WARNING in __gup_longterm_locked
From:   syzbot <syzbot+6cf44e127903fdf9d929@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    f8566aa4f176 Merge tag 'x86-urgent-2023-07-01' of git://gi..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15ebe50b280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7406f415f386e786
dashboard link: https://syzkaller.appspot.com/bug?extid=6cf44e127903fdf9d929
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12e5b04f280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=102dff80a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/08033ccab6ef/disk-f8566aa4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/04c5c8c7e53a/vmlinux-f8566aa4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/942a1c157a92/bzImage-f8566aa4.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6cf44e127903fdf9d929@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5001 at mm/gup.c:1173 __get_user_pages+0xd49/0x1080 mm/gup.c:1173
Modules linked in:
CPU: 1 PID: 5001 Comm: syz-executor229 Not tainted 6.4.0-syzkaller-10062-gf8566aa4f176 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
RIP: 0010:__get_user_pages+0xd49/0x1080 mm/gup.c:1173
Code: 89 f8 48 c1 e8 03 80 3c 08 00 0f 85 bc 02 00 00 48 8b 44 24 20 48 8b 80 c0 00 00 00 48 8d 1c e8 e9 ad f7 ff ff e8 37 19 c3 ff <0f> 0b e9 32 f6 ff ff e8 2b 19 c3 ff 0f 0b e8 24 19 c3 ff 44 89 ed
RSP: 0018:ffffc90003a3f558 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000100 RCX: 0000000000000000
RDX: ffff888020630000 RSI: ffffffff81c1b599 RDI: 0000000000000007
RBP: 0000000020006000 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000100 R11: 0000000000000001 R12: ffff888018796100
R13: 0000000000210002 R14: ffff888076f55580 R15: 0000000000000000
FS:  0000555556272300(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000664740 CR3: 0000000029be1000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __get_user_pages_locked mm/gup.c:1456 [inline]
 __gup_longterm_locked+0x6f9/0x23e0 mm/gup.c:2150
 internal_get_user_pages_fast+0x16e6/0x32f0 mm/gup.c:3148
 get_user_pages_fast+0xa8/0xf0 mm/gup.c:3226
 __iov_iter_get_pages_alloc+0x28c/0x1950 lib/iov_iter.c:1111
 iov_iter_get_pages2+0xa8/0x100 lib/iov_iter.c:1151
 iter_to_pipe fs/splice.c:1402 [inline]
 vmsplice_to_pipe fs/splice.c:1492 [inline]
 __do_sys_vmsplice+0x50c/0xaa0 fs/splice.c:1556
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f2a6e4e4b69
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdb0cc72d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000116
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f2a6e4e4b69
RDX: 0000000000000001 RSI: 00000000200000c0 RDI: 0000000000000004
RBP: 00007f2a6e4a8d10 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000246 R12: 00007f2a6e4a8da0
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
