Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99DB86F7F27
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 10:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjEEId1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 04:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjEEIdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 04:33:25 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7EF818929
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 01:32:54 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-76640f8deb5so91532139f.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 01:32:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683275549; x=1685867549;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FY1oVG0nSupc0he1hbXBLthUlzEY5zmu3j39rrbGFkw=;
        b=BM2CzzbCsfs7AHKD4C6RZcUbgs0N5vmk4OdetCFTF9I6KKGqfTu6vdLjOSm5DIvJoD
         CcMIT89serxdqZc+Eble2NPTcb/KiIefdlMZ0dtTwAaJkic/hIAC8CNxHYmenb7Wfov2
         CEw5fUklSEoo9TxDi0piVZGey3cJ8+72VNKTPXrcRemzahTnJsICv+KdnKf04Gx3quKT
         2sAOTG6OuTstJ08cPD3RCZEVXOvLSMRdaKg5zRG/4wYmVeU3lTLKD6Hdfqq9/aT1wULw
         uc4QrQUIzaHuwBIT7Y2bt8Mjtc2WN7nKrusfZdf7VFPuLfmbJwy/YyOLVLUqLRj208zd
         b6Kg==
X-Gm-Message-State: AC+VfDyoKviuJyzw6fQTXCgkzQ8M1Gacd2tpO7jHyo6djz1syo9lJeAl
        HIdcmmNodWW2JxJzUZLORahyeNgevFcJvBvwMmS0G97zHuo6
X-Google-Smtp-Source: ACHHUZ7YAK22GI+ner0Ix44sYyMtPe6xEsvPMBEyFB6s9TeyF3gyUP94i7qhOGCscNzTSNTuj0A/w/hhhd7m+qgJqzmUkJq2JNOj
MIME-Version: 1.0
X-Received: by 2002:a6b:ee17:0:b0:760:e308:1070 with SMTP id
 i23-20020a6bee17000000b00760e3081070mr210410ioh.0.1683275549241; Fri, 05 May
 2023 01:32:29 -0700 (PDT)
Date:   Fri, 05 May 2023 01:32:29 -0700
In-Reply-To: <20230505075628.4150-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002bf72005faee211a@google.com>
Subject: Re: [syzbot] [reiserfs?] possible deadlock in open_xa_dir
From:   syzbot <syzbot+8fb64a61fdd96b50f3b8@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
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

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in reiserfs_check_lock_depth

REISERFS (device loop0): checking transaction log (loop0)
REISERFS (device loop0): Using r5 hash to sort names
REISERFS (device loop0): Created .reiserfs_priv - reserved for xattr storage.
------------[ cut here ]------------
WARNING: CPU: 1 PID: 5415 at fs/reiserfs/lock.c:91 reiserfs_check_lock_depth+0x71/0x90
Modules linked in:
CPU: 1 PID: 5415 Comm: syz-executor.0 Not tainted 6.3.0-syzkaller-13164-g78b421b6a7c6-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
RIP: 0010:reiserfs_check_lock_depth+0x71/0x90 fs/reiserfs/lock.c:91
Code: 03 42 0f b6 04 38 84 c0 75 24 41 8b 1e 31 ff 89 de e8 a3 4f 58 ff 85 db 78 0b e8 ea 4b 58 ff 5b 41 5e 41 5f c3 e8 df 4b 58 ff <0f> 0b eb f1 44 89 f1 80 e1 07 80 c1 03 38 c1 7c cf 4c 89 f7 e8 86
RSP: 0018:ffffc9000581f520 EFLAGS: 00010293
RAX: ffffffff82334431 RBX: 00000000ffffffff RCX: ffff888025ed0000
RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 0000000000000000
RBP: ffffc9000581f7b0 R08: ffffffff8233441d R09: ffffed100e877044
R10: 0000000000000000 R11: dffffc0000000001 R12: 1ffff92000b03f05
R13: dffffc0000000000 R14: ffff88807783b0c0 R15: dffffc0000000000
FS:  00007f9491058700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f62321d1ff8 CR3: 000000002a3c7000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 do_journal_end+0x20f/0x4770 fs/reiserfs/journal.c:4018
 reiserfs_create+0x68e/0x710 fs/reiserfs/namei.c:694
 lookup_open fs/namei.c:3492 [inline]
 open_last_lookups fs/namei.c:3560 [inline]
 path_openat+0x13df/0x3170 fs/namei.c:3788
 do_filp_open+0x234/0x490 fs/namei.c:3818
 do_sys_openat2+0x13f/0x500 fs/open.c:1356
 do_sys_open fs/open.c:1372 [inline]
 __do_sys_openat fs/open.c:1388 [inline]
 __se_sys_openat fs/open.c:1383 [inline]
 __x64_sys_openat+0x247/0x290 fs/open.c:1383
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f949028c169
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9491058168 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f94903abf80 RCX: 00007f949028c169
RDX: 000000000000275a RSI: 0000000020000080 RDI: ffffffffffffff9c
RBP: 00007f94902e7ca1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff4aaf8b4f R14: 00007f9491058300 R15: 0000000000022000
 </TASK>


Tested on:

commit:         78b421b6 Merge tag 'linux-watchdog-6.4-rc1' of git://w..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1271004c280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=73a06f6ef2d5b492
dashboard link: https://syzkaller.appspot.com/bug?extid=8fb64a61fdd96b50f3b8
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1194d2f4280000

