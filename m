Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17FE36491F5
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 03:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiLKCa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 21:30:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiLKCaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 21:30:24 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8C913DD7
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 18:30:23 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id n15-20020a056e021baf00b0030387c2e1d3so2680710ili.5
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 18:30:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jr7i5486uETck+UY0GMFZlLlPLjqEHWzxTw1wxlA8pI=;
        b=bLRZxVyHh4zXsnVIi8T9WD0R603iDwVyrQbGkyQtMJmy2kvcpWkqjrPj/Xl/Ei/aw8
         MclpJeitdnrdpR3+2woKSEMnLZlngiweyHNThm9VMfTK32X85hPRf8Oj25zAFsxHf502
         reabKjcboWLV5iXvC+DxxXM41bjDI8hGP2YjMsqXors8CUUxjXaIHCuwu074ibpvMf6Z
         k+7tydouLPXxNYjI52KltglBdsoz5Yo+8TAa0xtFJU9uLmITMC2sBsE8+jWR++p7R4cy
         +EOOHMs5n+/0m1kQBYz+i/pYF/qX7dkKe7s+/A1uDno3K55RWr16f7p+IwQmfyuMg+kA
         5vsw==
X-Gm-Message-State: ANoB5plfEeqewf+bW/29JNX15gAf/FbomiGm7d4mfnFu4GMocE0GWEZv
        YwxNlBlUrRM8MciBjE10e0zFFM5sLNA12F4qOPAuWGRu1Jcx
X-Google-Smtp-Source: AA0mqf4sTskBPa4+cAEdSxj+MdwXSl+yQd5WEai2YH40ow3ECAo67XzUrtZoAKT2hurH01ZMEmPvZDM2xASFHTLwucmNP/JO+c/T
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:6c3:b0:303:2b9c:60b7 with SMTP id
 p3-20020a056e0206c300b003032b9c60b7mr17810422ils.126.1670725822183; Sat, 10
 Dec 2022 18:30:22 -0800 (PST)
Date:   Sat, 10 Dec 2022 18:30:22 -0800
In-Reply-To: <20221211002908.2210-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000025ff8d05ef842be6@google.com>
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
WARNING in done_path_create

------------[ cut here ]------------
DEBUG_RWSEMS_WARN_ON((rwsem_owner(sem) != current) && !rwsem_test_oflags(sem, RWSEM_NONSPINNABLE)): count = 0x0, magic = 0xffff88807217f1d0, owner = 0x0, curr 0xffff88807ce13a80, list empty
WARNING: CPU: 0 PID: 4220 at kernel/locking/rwsem.c:1361 __up_write kernel/locking/rwsem.c:1360 [inline]
WARNING: CPU: 0 PID: 4220 at kernel/locking/rwsem.c:1361 up_write+0x4f9/0x580 kernel/locking/rwsem.c:1615
Modules linked in:
CPU: 0 PID: 4220 Comm: syz-executor.0 Not tainted 6.1.0-rc8-syzkaller-00152-g3ecc37918c80-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:__up_write kernel/locking/rwsem.c:1360 [inline]
RIP: 0010:up_write+0x4f9/0x580 kernel/locking/rwsem.c:1615
Code: c7 c0 a3 ed 8a 48 c7 c6 60 a6 ed 8a 48 8b 54 24 28 48 8b 4c 24 18 4d 89 e0 4c 8b 4c 24 30 31 c0 53 e8 ab 7c e8 ff 48 83 c4 08 <0f> 0b e9 6b fd ff ff 48 c7 c1 58 4d 76 8e 80 e1 07 80 c1 03 38 c1
RSP: 0018:ffffc90006d9fd20 EFLAGS: 00010292
RAX: 41e4cc6daa410d00 RBX: ffffffff8aeda4a0 RCX: ffff88807ce13a80
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc90006d9fdf8 R08: ffffffff816e5c7d R09: fffff52000db3f5d
R10: fffff52000db3f5d R11: 1ffff92000db3f5c R12: 0000000000000000
R13: ffff88807217f1d0 R14: 1ffff92000db3fac R15: dffffc0000000000
FS:  00007f3cd55fe700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055b468143950 CR3: 0000000074553000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 inode_unlock include/linux/fs.h:762 [inline]
 done_path_create+0xc4/0x150 fs/namei.c:3857
 do_mkdirat+0x254/0x440 fs/namei.c:4064
 __do_sys_mkdirat fs/namei.c:4076 [inline]
 __se_sys_mkdirat fs/namei.c:4074 [inline]
 __x64_sys_mkdirat+0x85/0x90 fs/namei.c:4074
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f3cde48c0d9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f3cd55fe168 EFLAGS: 00000246 ORIG_RAX: 0000000000000102
RAX: ffffffffffffffda RBX: 00007f3cde5ac050 RCX: 00007f3cde48c0d9
RDX: 0000000000000000 RSI: 0000000020000200 RDI: 0000000000000004
RBP: 00007f3cde4e7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc1510851f R14: 00007f3cd55fe300 R15: 0000000000022000
 </TASK>


Tested on:

commit:         3ecc3791 Merge tag 'media/v6.1-4' of git://git.kernel...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=152559eb880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d58e7fe7f9cf5e24
dashboard link: https://syzkaller.appspot.com/bug?extid=919c5a9be8433b8bf201
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14e9477d880000

