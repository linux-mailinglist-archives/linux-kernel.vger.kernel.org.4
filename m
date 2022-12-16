Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A8364E7F0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 08:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiLPHxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 02:53:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLPHx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 02:53:28 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B0C20986
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 23:53:27 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id r25-20020a6bfc19000000b006e002cb217fso1022002ioh.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 23:53:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WhcDqMiG4ZK6gbccHslwH85L4eFPa5Yfo+DfYrRRhuc=;
        b=zPn/qV1SNV1Q1IkcnRHIO/9EQQHDbAOkHJn5QZzZMuzYtRZtSiH/BGWRqvCR91ywsh
         d0RgZRWLFlbeGXuvIUfCtXXZjvUKSyb6VIt4f2GlaFYTbSZ8eexeRI9iHe60f8j47jY3
         X6T+KyWkMKo0GA5hKJyufxeVcHNE0bLHJdYt/xjns+zZ7MmPPC8mPM8+B+pB+UbVq3Fz
         bV2jXq3zeWgsftGqlNqfOX/01hs5maUuXjCYhz5HLQZnLGWCyEBYd9yHVRWQz3Wj7wuO
         IrZbzGi2NhGPQcx+OPWh0ZP5XnL4EcyfTnZp5z/QraKvlfC1hFsU3caLJtcp2norxJyC
         umzA==
X-Gm-Message-State: ANoB5pkbQLVlqne4ZypuoZu7aHw+eRac4/3EYUEPuTOO8t6qPhS7Ujem
        pC+Ihp0KcsnNa77gVimsKn6zNVDpY2bFWEFfiSEppKb+fYFS
X-Google-Smtp-Source: AA0mqf7kiSq/CkPtA4+A8AzfTiY4e11uaWwphHRD+7AudPTMf1A//RDe3z7r9GZ8P+6SttJu7LLI5QeYmQjiEamkpWtaQD/yGGf3
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:cae:b0:302:edb1:6f9 with SMTP id
 14-20020a056e020cae00b00302edb106f9mr20777161ilg.23.1671177206438; Thu, 15
 Dec 2022 23:53:26 -0800 (PST)
Date:   Thu, 15 Dec 2022 23:53:26 -0800
In-Reply-To: <20221215235133.1097-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bf24a905efed43b0@google.com>
Subject: Re: [syzbot] WARNING in do_mkdirat
From:   syzbot <syzbot+919c5a9be8433b8bf201@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in do_mkdirat

------------[ cut here ]------------
DEBUG_RWSEMS_WARN_ON((rwsem_owner(sem) != current) && !rwsem_test_oflags(sem, RWSEM_NONSPINNABLE)): count = 0x0, magic = 0xffff888075e8e310, owner = 0x0, curr 0xffff8880264b8000, list empty
WARNING: CPU: 0 PID: 6864 at kernel/locking/rwsem.c:1361 __up_write kernel/locking/rwsem.c:1360 [inline]
WARNING: CPU: 0 PID: 6864 at kernel/locking/rwsem.c:1361 up_write+0x4f9/0x580 kernel/locking/rwsem.c:1615
Modules linked in:
CPU: 1 PID: 6864 Comm: syz-executor.0 Not tainted 6.1.0-syzkaller-11674-g84e57d292203-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:__up_write kernel/locking/rwsem.c:1360 [inline]
RIP: 0010:up_write+0x4f9/0x580 kernel/locking/rwsem.c:1615
Code: c7 a0 ab ed 8a 48 c7 c6 40 ae ed 8a 48 8b 54 24 28 48 8b 4c 24 18 4d 89 e0 4c 8b 4c 24 30 31 c0 53 e8 fb 5b e8 ff 48 83 c4 08 <0f> 0b e9 6b fd ff ff 48 c7 c1 58 c4 96 8e 80 e1 07 80 c1 03 38 c1
RSP: 0018:ffffc90003a07d40 EFLAGS: 00010292
RAX: 6d7329e6d3b7db00 RBX: ffffffff8aedac80 RCX: ffff8880264b8000
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc90003a07e10 R08: ffffffff816f274d R09: fffff52000740f61
R10: fffff52000740f61 R11: 1ffff92000740f60 R12: 0000000000000000
R13: ffff888075e8e310 R14: 1ffff92000740fb0 R15: dffffc0000000000
FS:  00007f0ff93ff700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0ff9421000 CR3: 0000000028be2000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 inode_unlock include/linux/fs.h:761 [inline]
 done_path_create fs/namei.c:3857 [inline]
 do_mkdirat+0x2c0/0x530 fs/namei.c:4064
 __do_sys_mkdirat fs/namei.c:4076 [inline]
 __se_sys_mkdirat fs/namei.c:4074 [inline]
 __x64_sys_mkdirat+0x85/0x90 fs/namei.c:4074
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f0ff868c0d9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0ff93ff168 EFLAGS: 00000246 ORIG_RAX: 0000000000000102
RAX: ffffffffffffffda RBX: 00007f0ff87ac050 RCX: 00007f0ff868c0d9
RDX: 0000000000000000 RSI: 0000000020000200 RDI: 0000000000000004
RBP: 00007f0ff86e7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc260c3b4f R14: 00007f0ff93ff300 R15: 0000000000022000
 </TASK>


Tested on:

commit:         84e57d29 Merge tag 'exfat-for-6.2-rc1' of git://git.ke..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=10f17063880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b427d4cd32f6b2b
dashboard link: https://syzkaller.appspot.com/bug?extid=919c5a9be8433b8bf201
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15617063880000

