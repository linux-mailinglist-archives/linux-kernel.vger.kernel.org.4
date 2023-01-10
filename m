Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603F96642F2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 15:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbjAJOPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 09:15:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbjAJOPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 09:15:35 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0628270B
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 06:15:34 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id y5-20020a056e021be500b0030bc4f23f0aso8451189ilv.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 06:15:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=COnmbLew20zkF+FzyZfgdF3WSpoxS9ODMLIOlwN5k7U=;
        b=NmQcMeWkMRjx5zbkjPYURbGgkQpHDQwbOBPAq/PgRQqJa8HaQtW6suAzm/Jf+zJWKg
         fvXIWiD49NO8PMczpeiFZ9Y7b9JpTw4aazi3+ixysUHBL6fsP6ZdbwWx1RHJT5V2rCxE
         M4Wor0dMiAnARfmYEQs9TDvq6QlXQtiSIikKdrxQ4n+PCGaWvCq8Jrhn/u9lIEYUzh9v
         hBE7Pc5938JXmf39/WXJH6YLcyhTR77ZIp5QU4rarW+WbddJGxwWcBaTGuAuEYvHiXjh
         S5LhoY+oI9B9MO33OCpaJX1Jf7XHp4CZqxEcvc/S+kmgF2fIk8CD9Bj4a0Jglv8eWaSt
         tr8w==
X-Gm-Message-State: AFqh2koXc7v1VIfUHEXcJF7Cjtms3v5P4fN5x/iS0NBLtv2HiorEIdvE
        COPL6SPFSBkN3pePqbGqgw+xUIf1kQfIkXfII9YBCkS5LSSo
X-Google-Smtp-Source: AMrXdXtoxKkczxMUSPqKSsvlZ1PfFu37a3s2GnuDNQHwv/sMQmwAAkPep5UMh37l28i2MT5V4xUA7BFp7RVMInhQdXui48qgpjjD
MIME-Version: 1.0
X-Received: by 2002:a92:4a11:0:b0:30b:b565:2b9e with SMTP id
 m17-20020a924a11000000b0030bb5652b9emr5797624ilf.158.1673360134151; Tue, 10
 Jan 2023 06:15:34 -0800 (PST)
Date:   Tue, 10 Jan 2023 06:15:34 -0800
In-Reply-To: <000000000000d677c405f1e4e1e6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000060a8bf05f1e9843b@google.com>
Subject: Re: [syzbot] WARNING in vma_complete
From:   syzbot <syzbot+ea4b1a683ce48cd567b1@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    435bf71af3a0 Add linux-next specific files for 20230110
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=177d1036480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2de08b99ad4f49c
dashboard link: https://syzkaller.appspot.com/bug?extid=ea4b1a683ce48cd567b1
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1437baa4480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8541d2e988c8/disk-435bf71a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/09d8d0545d93/vmlinux-435bf71a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f99de1e244bf/bzImage-435bf71a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ea4b1a683ce48cd567b1@syzkaller.appspotmail.com

R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc0a0d41ff R14: 00007f7a0d952300 R15: 0000000000022000
 </TASK>
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5109 at mm/mmap.c:170 vma_iter_store mm/mmap.c:170 [inline]
WARNING: CPU: 0 PID: 5109 at mm/mmap.c:170 vma_complete.cold+0x9/0x2fb mm/mmap.c:634
Modules linked in:
CPU: 1 PID: 5109 Comm: syz-executor.0 Not tainted 6.2.0-rc3-next-20230110-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:vma_iter_store mm/mmap.c:170 [inline]
RIP: 0010:vma_complete.cold+0x9/0x2fb mm/mmap.c:634
Code: 37 00 48 c1 ea 03 48 c1 e0 2a 80 3c 02 00 74 08 48 89 ef e8 4f e3 10 f8 4c 8b 6d 00 e9 ce b3 ff f7 48 89 34 24 e8 fd f5 c2 f7 <0f> 0b 48 8b 34 24 4c 89 f2 48 c7 c7 e0 53 58 8a e8 45 d9 fe ff 49
RSP: 0018:ffffc90003ed7ae0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffc90003ed7b88 RCX: 0000000000000000
RDX: ffff8880262fba80 RSI: ffffffff89bec7c3 RDI: 0000000000000006
RBP: ffffc90003ed7d58 R08: 0000000000000006 R09: 0000000020003000
R10: 0000000021000000 R11: 0000000000094001 R12: ffff88801dcd88c0
R13: ffff888029118000 R14: 0000000020003000 R15: ffffc90003ed7d60
FS:  00007f7a0d952700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055ad2e343118 CR3: 000000007884b000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __split_vma+0x61d/0x740 mm/mmap.c:2273
 split_vma+0xc6/0x110 mm/mmap.c:2300
 mlock_fixup+0x56a/0x810 mm/mlock.c:436
 apply_vma_lock_flags+0x23d/0x350 mm/mlock.c:506
 do_mlock+0x25a/0x6d0 mm/mlock.c:601
 __do_sys_mlock2 mm/mlock.c:628 [inline]
 __se_sys_mlock2 mm/mlock.c:618 [inline]
 __x64_sys_mlock2+0xc1/0x100 mm/mlock.c:618
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f7a0cc8c0c9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7a0d952168 EFLAGS: 00000246 ORIG_RAX: 0000000000000145
RAX: ffffffffffffffda RBX: 00007f7a0cdabf80 RCX: 00007f7a0cc8c0c9
RDX: 0000000000000000 RSI: 0000000000003000 RDI: 0000000020000000
RBP: 00007f7a0cce7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc0a0d41ff R14: 00007f7a0d952300 R15: 0000000000022000
 </TASK>

