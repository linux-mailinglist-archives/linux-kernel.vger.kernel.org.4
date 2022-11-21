Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615AB633015
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 23:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbiKUW6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 17:58:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbiKUW5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 17:57:53 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF05CE0ED
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 14:57:41 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id j7-20020a056e02154700b003025b3c0ea3so9599719ilu.10
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 14:57:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XLpjlYOpL38kGF9PGdFC21P0et3GA8VA5X/IkxZlIiQ=;
        b=sNaFVgnI3sOvPKRuwxQ13WQ0tADMZIEsZKH+z7HuNvp7YgSJOBC5WX0RXGeqnbyaHT
         ADJAyOd7G4e2s/qG6wZ+o+RsVy3u1es/CFK82a2i9EtwnxtBKXKLb5ct3UkoZTXMU7u2
         4orQ2SDKPPNTbP1VA/5iL9bazxiAt5sOZGMIsz/iEqSnP9nro2K0d9Eeu9GxPAL5F/8J
         2uGn+NbCcuVJAhwbEL3LEzRD/3ID58P7lC5tK3q6qQdn8tqBRmma4RER4FD1ZhCyvaj7
         5qZLIi5trrQzCHJHccHkevZNpyzKRzGTKMw0NqMg96g4he8MqlrKtcZHd4rKrZdeVkUi
         C40A==
X-Gm-Message-State: ANoB5plfj/rD/85vijp0d2NpXkkpO1lAAvhECgPaz22tiqy1dXfu0Vfr
        K2uv89cbplsOR1cnJ9DLwhVytV8uerwEXsmXSIEwXvAoUk6I
X-Google-Smtp-Source: AA0mqf4Fbo6tItRMluhBMJbI6Ppx4UJTN2qHgecQXWtw1bikiqhga32Hurr/RUgf8ZBx22nUw+C5ljrpQymfq2bBkvM091eVwbLj
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:11a3:b0:302:a9a5:d608 with SMTP id
 3-20020a056e0211a300b00302a9a5d608mr1595386ilj.141.1669071460668; Mon, 21 Nov
 2022 14:57:40 -0800 (PST)
Date:   Mon, 21 Nov 2022 14:57:40 -0800
In-Reply-To: <00000000000022a65705ec7f923c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000849c3e05ee02fb3e@google.com>
Subject: Re: [syzbot] kernel BUG in do_journal_begin_r
From:   syzbot <syzbot+2da5e132dd0268a9c0e4@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, axboe@kernel.dk, bvanassche@acm.org,
        jack@suse.cz, jlayton@kernel.org, linux-kernel@vger.kernel.org,
        neilb@suse.de, reiserfs-devel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, willy@infradead.org,
        yi.zhang@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    eb7081409f94 Linux 6.1-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11137619880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8cdf448d3b35234
dashboard link: https://syzkaller.appspot.com/bug?extid=2da5e132dd0268a9c0e4
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15a83ed9880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=103fad21880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4a019f55c517/disk-eb708140.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/eb36e890aa8b/vmlinux-eb708140.xz
kernel image: https://storage.googleapis.com/syzbot-assets/feee2c23ec64/bzImage-eb708140.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/536f992f8112/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2da5e132dd0268a9c0e4@syzkaller.appspotmail.com

REISERFS (device loop3): Using tea hash to sort names
REISERFS (device loop3): Created .reiserfs_priv - reserved for xattr storage.
------------[ cut here ]------------
kernel BUG at fs/reiserfs/journal.c:3039!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 4827 Comm: syz-executor196 Not tainted 6.1.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:do_journal_begin_r+0x105b/0x1070 fs/reiserfs/journal.c:3039
Code: ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 22 ff ff ff 48 89 df e8 a6 eb b2 ff e9 15 ff ff ff e8 bc d3 5e ff 0f 0b e8 b5 d3 5e ff <0f> 0b e8 2e 6f 6a 08 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 55
RSP: 0018:ffffc900059375e0 EFLAGS: 00010293
RAX: ffffffff822bc4bb RBX: 000000001100e4cd RCX: ffff888022068000
RDX: 0000000000000000 RSI: 000000001100e4cd RDI: 0000000000000100
RBP: ffffc90005937788 R08: ffffffff822bb592 R09: fffffbfff1d2f2de
R10: fffffbfff1d2f2de R11: 1ffffffff1d2f2dd R12: ffff888020ee6678
R13: ffffc90005db1214 R14: dffffc0000000000 R15: 0000000000000100
FS:  00005555568fe3c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fce06f4e410 CR3: 000000007bce2000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 journal_begin+0x14b/0x350 fs/reiserfs/journal.c:3255
 reiserfs_create+0x2c3/0x660 fs/reiserfs/namei.c:661
 lookup_open fs/namei.c:3413 [inline]
 open_last_lookups fs/namei.c:3481 [inline]
 path_openat+0x12d0/0x2df0 fs/namei.c:3710
 do_filp_open+0x264/0x4f0 fs/namei.c:3740
 do_sys_openat2+0x124/0x4e0 fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_creat fs/open.c:1402 [inline]
 __se_sys_creat fs/open.c:1396 [inline]
 __x64_sys_creat+0x11f/0x160 fs/open.c:1396
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fce06ed4c39
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdabc25c18 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fce06ed4c39
RDX: 00007fce06e8a733 RSI: 0000000000000000 RDI: 0000000020000380
RBP: 0000000000000000 R08: 00000000000010f0 R09: 0000000000000003
R10: 00007ffdabc25ae0 R11: 0000000000000246 R12: 00007ffdabc25c48
R13: 00007ffdabc25c80 R14: 00007ffdabc25c60 R15: 0000000000000060
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:do_journal_begin_r+0x105b/0x1070 fs/reiserfs/journal.c:3039
Code: ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 22 ff ff ff 48 89 df e8 a6 eb b2 ff e9 15 ff ff ff e8 bc d3 5e ff 0f 0b e8 b5 d3 5e ff <0f> 0b e8 2e 6f 6a 08 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 55
RSP: 0018:ffffc900059375e0 EFLAGS: 00010293

RAX: ffffffff822bc4bb RBX: 000000001100e4cd RCX: ffff888022068000
RDX: 0000000000000000 RSI: 000000001100e4cd RDI: 0000000000000100
RBP: ffffc90005937788 R08: ffffffff822bb592 R09: fffffbfff1d2f2de
R10: fffffbfff1d2f2de R11: 1ffffffff1d2f2dd R12: ffff888020ee6678
R13: ffffc90005db1214 R14: dffffc0000000000 R15: 0000000000000100
FS:  00005555568fe3c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fce06f4e410 CR3: 000000007bce2000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

