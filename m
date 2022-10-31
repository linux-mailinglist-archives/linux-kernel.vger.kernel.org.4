Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0474E612FB2
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 06:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiJaF32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 01:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiJaF30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 01:29:26 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6619FE4
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 22:29:23 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id i14-20020a056e021d0e00b0030028180f5bso9205993ila.5
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 22:29:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hGQb38DZg5YDKYYcM3EEi6vLLVNkt1wLsoGy/g8eVp4=;
        b=hiN62EVZ5EO/DzhN1E/tqWrSKBV6SV2VKJ5PMnkugvewWrf9h2fq5gNMqB+fDTo1ep
         O6ta90+rMG8njpmysNBWDo1Ixgm9+0S8gmw6LJQxpXOBPG9bfYO3Gjx77bUKhteK5vSx
         JqjC7Qm8uWcEGFcSMv0NKPBhOwdU/cKXo/w66qL9N9WGxC/mdx+5D0uPw+i0BTg2L3mL
         l4fGji/xsRRjUZxjd1l5KcY+ubN37H23AyyHBSRyQdTgBBBHe8oOvqOUG2YLpKJwZphd
         4Lp6DdHt97Sfrj86wUEKxKi0rxV+A9YFtseHiX6Bvrsz/H595CaD7jsv6VhMjM0qcG/L
         tTKg==
X-Gm-Message-State: ACrzQf1dPB3EK/X6yC2F2WNcWL8HxGJ2g0H+toXSimP90hBkJSbbORxg
        cF7qe22M8ykH9BEc9OZwQQXUPna9f36Aa70j/LW0xOKIE76Y
X-Google-Smtp-Source: AMsMyM6FM3fO1MRvuCRpVriGxJ5O5108ZnusAEEO31kdb/ULrK48mG2uHy66mAQYN/q4678Dj21tMUwchSEpkUWpPxMlEJ8rk83k
MIME-Version: 1.0
X-Received: by 2002:a6b:3fd5:0:b0:6d0:b601:a48d with SMTP id
 m204-20020a6b3fd5000000b006d0b601a48dmr1394086ioa.20.1667194162558; Sun, 30
 Oct 2022 22:29:22 -0700 (PDT)
Date:   Sun, 30 Oct 2022 22:29:22 -0700
In-Reply-To: <20221031044301.3651-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d4bc4d05ec4de3e3@google.com>
Subject: Re: [syzbot] KASAN: slab-out-of-bounds Write in dbgfs_rm_context_write
From:   syzbot <syzbot+6087eafb76a94c4ac9eb@syzkaller.appspotmail.com>
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
WARNING in dbgfs_rm_context_write

------------[ cut here ]------------
WARNING: CPU: 0 PID: 4167 at mm/damon/dbgfs.c:928 dbgfs_rm_context mm/damon/dbgfs.c:928 [inline]
WARNING: CPU: 0 PID: 4167 at mm/damon/dbgfs.c:928 dbgfs_rm_context_write+0x40a/0x4d0 mm/damon/dbgfs.c:972
Modules linked in:
CPU: 0 PID: 4167 Comm: syz-executor.0 Not tainted 6.1.0-rc2-syzkaller-00078-g98555239e4c3-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
RIP: 0010:dbgfs_rm_context mm/damon/dbgfs.c:928 [inline]
RIP: 0010:dbgfs_rm_context_write+0x40a/0x4d0 mm/damon/dbgfs.c:972
Code: 03 42 80 3c 30 00 0f 85 d6 00 00 00 48 8b 3b e8 4c 19 ff ff 48 8b 05 a5 83 52 0f 48 89 44 24 08 e9 40 ff ff ff e8 f6 c1 a7 ff <0f> 0b e9 d0 fe ff ff e8 ea c1 a7 ff 48 8b 3c 24 49 c7 c5 f4 ff ff
RSP: 0018:ffffc900049bfcb0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff8880745d0000 RSI: ffffffff81d4da8a RDI: 0000000000000004
RBP: 0000000000000000 R08: 0000000000000004 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
R13: 0000000000000000 R14: dffffc0000000000 R15: ffff888144cb2000
FS:  00007f5b5b5ac700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000002000f000 CR3: 000000006f407000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 full_proxy_write+0x118/0x180 fs/debugfs/file.c:236
 vfs_write+0x2d7/0xdd0 fs/read_write.c:582
 ksys_write+0x127/0x250 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f5b5a88b5a9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5b5b5ac168 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f5b5a9abf80 RCX: 00007f5b5a88b5a9
RDX: 000000000000fe6c RSI: 0000000020000080 RDI: 0000000000000003
RBP: 00007f5b5a8e67b0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe981eb0df R14: 00007f5b5b5ac300 R15: 0000000000022000
 </TASK>


Tested on:

commit:         98555239 Merge tag 'arc-6.1-fixes' of git://git.kernel..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1258d3ce880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a66c6c673fb555e8
dashboard link: https://syzkaller.appspot.com/bug?extid=6087eafb76a94c4ac9eb
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=112688a6880000

