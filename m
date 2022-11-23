Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5740635969
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 11:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237329AbiKWKNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 05:13:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236623AbiKWKM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 05:12:28 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04757748C8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 02:02:20 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id q6-20020a056e020c2600b00302664fc72cso12603633ilg.14
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 02:02:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fFbSFfCQ0pynMpSYKqpammQ3BIw/9i9t9M4x/+m738Y=;
        b=m3xfrHqYn+ib/EtY51CvvvLMq7palYP6tDcRQK3Jm+lcmMRsBVa49nB6CGGET4/YFb
         /U0gDrUBdIlQDIp8N2k6eE1w5+fFCLe/iymoLDmaMhZS79CVFHjPYHmTtUUdpz6aGtaS
         j6Pr15Lt2KJ9htn7EDG+aNYoYryI9fS/zzpr98pKj+kAv6FvBUeu1YByktT12xoLURkE
         Ft4QizVXcSuSQdpJ32uzVNfiWcPXKWgGzhwfFaQvfhHVBZ1JSsOHGQoebcEmMQr7SZ1h
         4CLuBo0fFOSYbt/kBVx+tcARzDNjgTa3VQFe4nR7wE7yviA2pSm9+cSovNQR0rcFyDje
         zyiQ==
X-Gm-Message-State: ANoB5pnaKMCWgYCeTsirZD2P9X7bAEJcpjmcuD0TdozMc5qHHoGqw0Ub
        ld6ctW1ODxn9f/AluPR1OV1cBzUXYmvZnfARNNnPJlL1RJC1
X-Google-Smtp-Source: AA0mqf6EqFvZh+TsxLmy9SXESM+IDC7UEkpjAEe9KxxnnK0DeCV9bRn7EXdAj9FU4bjHwzZmetKgzes+CW3rb0OwqfZEnpOXSy7T
MIME-Version: 1.0
X-Received: by 2002:a92:c909:0:b0:300:f3e3:c652 with SMTP id
 t9-20020a92c909000000b00300f3e3c652mr3385471ilp.125.1669197739400; Wed, 23
 Nov 2022 02:02:19 -0800 (PST)
Date:   Wed, 23 Nov 2022 02:02:19 -0800
In-Reply-To: <20221123084759.5431-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000051300605ee2062ed@google.com>
Subject: Re: [syzbot] possible deadlock in mnt_want_write_file
From:   syzbot <syzbot+1047e42179f502f2b0a2@syzkaller.appspotmail.com>
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
kernel BUG in do_journal_begin_r

REISERFS (device loop0): journal params: device loop0, size 512, journal first block 18, max trans len 256, max batch 225, max commit age 30, max trans age 30
REISERFS (device loop0): checking transaction log (loop0)
REISERFS (device loop0): Using tea hash to sort names
REISERFS (device loop0): Created .reiserfs_priv - reserved for xattr storage.
------------[ cut here ]------------
kernel BUG at fs/reiserfs/journal.c:3039!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 5794 Comm: syz-executor.0 Not tainted 6.1.0-rc6-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:do_journal_begin_r+0x105b/0x1070 fs/reiserfs/journal.c:3039
Code: ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 22 ff ff ff 48 89 df e8 a6 eb b2 ff e9 15 ff ff ff e8 bc d3 5e ff 0f 0b e8 b5 d3 5e ff <0f> 0b e8 2e 6f 6a 08 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 55
RSP: 0018:ffffc900095cf5e0 EFLAGS: 00010293
RAX: ffffffff822bc4bb RBX: 000000001100e5be RCX: ffff88807d299d40
RDX: 0000000000000000 RSI: 000000001100e5be RDI: 0000000000000100
RBP: ffffc900095cf788 R08: ffffffff822bb592 R09: fffffbfff1d2f2de
R10: fffffbfff1d2f2de R11: 1ffffffff1d2f2dd R12: ffff88807a6c6678
R13: ffffc9000ac11214 R14: dffffc0000000000 R15: 0000000000000100
FS:  00007fd0ac76a700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd0abba8000 CR3: 000000007980d000 CR4: 00000000003506e0
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
RIP: 0033:0x7fd0aba8c189
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd0ac76a168 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 00007fd0abbabf80 RCX: 00007fd0aba8c189
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000040
RBP: 00007fd0abae7b01 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffeb4434c9f R14: 00007fd0ac76a300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:do_journal_begin_r+0x105b/0x1070 fs/reiserfs/journal.c:3039
Code: ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 22 ff ff ff 48 89 df e8 a6 eb b2 ff e9 15 ff ff ff e8 bc d3 5e ff 0f 0b e8 b5 d3 5e ff <0f> 0b e8 2e 6f 6a 08 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 55
RSP: 0018:ffffc900095cf5e0 EFLAGS: 00010293
RAX: ffffffff822bc4bb RBX: 000000001100e5be RCX: ffff88807d299d40
RDX: 0000000000000000 RSI: 000000001100e5be RDI: 0000000000000100
RBP: ffffc900095cf788 R08: ffffffff822bb592 R09: fffffbfff1d2f2de
R10: fffffbfff1d2f2de R11: 1ffffffff1d2f2dd R12: ffff88807a6c6678
R13: ffffc9000ac11214 R14: dffffc0000000000 R15: 0000000000000100
FS:  00007fd0ac76a700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd0abba8000 CR3: 000000007980d000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


Tested on:

commit:         eb708140 Linux 6.1-rc6
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14428075880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8cdf448d3b35234
dashboard link: https://syzkaller.appspot.com/bug?extid=1047e42179f502f2b0a2
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=153b4afd880000

