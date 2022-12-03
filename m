Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32AAA641872
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 19:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiLCSei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 13:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbiLCSeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 13:34:36 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E5B1E3E8
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 10:34:35 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id h21-20020a05660224d500b006debd7dedccso7199650ioe.9
        for <linux-kernel@vger.kernel.org>; Sat, 03 Dec 2022 10:34:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1aN+NkYKYxpamQlRXBG9BbxIc5LgrFtYGNZM6QlMFtw=;
        b=z9kikcslcDTn24CxgZzlEwm8SGaIhW9Cgl3bruHMCp3Fx0tVzGUC39L247R6EER+Kx
         kus/lbnBy4q1BSAI0IDR+SB+L4cnd4T2XaRd5+kKVwEh1OMDa3Ux9ecexivgVs0pjpqL
         mjw6CyMISh42vmIrVyWCcod01qfCnedTocz5vi+Vmr9Gu3A/o//Fa8YMIMktwSQqWIks
         NglPz0jNkY/HwIIJDWtlO9mGAzA5W171oZ37zejGcYo2+9AZX4NHzajGvqk2sMVN7KSe
         LYwgw71Ir0T0GUciVF802ZMSYC5IJvzz6ow7g3IpKmFGrk4aJBstbzisQJ5CXAmkYRie
         UoZA==
X-Gm-Message-State: ANoB5pnTbwHemNYD4jyPif15tq6DiAx97gm49ycMuN5aXULsOUjTxH/X
        G1P7QkgTbMxTLFqXXPdpOaya1ScTT2IQsNitaZVLPgew+aAp
X-Google-Smtp-Source: AA0mqf6THlLkd49y/WAFWQSFCo+sTcwXr1nxcbLzt1nZEuncRT03huGaUHQa8x0yM6wd2flU0RHzem99jgdGNxpylzFojXFHLUtA
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:c82:b0:302:a9a5:d60f with SMTP id
 b2-20020a056e020c8200b00302a9a5d60fmr26633935ile.238.1670092474399; Sat, 03
 Dec 2022 10:34:34 -0800 (PST)
Date:   Sat, 03 Dec 2022 10:34:34 -0800
In-Reply-To: <00000000000043463e05ee9c4277@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000adc1e005eef0b4b5@google.com>
Subject: Re: [syzbot] WARNING in journal_end
From:   syzbot <syzbot+d43f346675e449548021@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, bvanassche@acm.org,
        damien.lemoal@opensource.wdc.com, jlayton@kernel.org,
        linux-kernel@vger.kernel.org, reiserfs-devel@vger.kernel.org,
        song@kernel.org, syzkaller-bugs@googlegroups.com,
        willy@infradead.org, yi.zhang@huawei.com
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

HEAD commit:    97ee9d1c1696 Merge tag 'block-6.1-2022-12-02' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1659ac47880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2325e409a9a893e1
dashboard link: https://syzkaller.appspot.com/bug?extid=d43f346675e449548021
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=103c1f4b880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6a6a9ff34dfa/disk-97ee9d1c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2a01a4182c2b/vmlinux-97ee9d1c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4371158e8c25/bzImage-97ee9d1c.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/151849cdad37/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d43f346675e449548021@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 3846 at fs/reiserfs/journal.c:3395 journal_end+0x210/0x2d0
Modules linked in:
CPU: 0 PID: 3846 Comm: syz-executor.4 Not tainted 6.1.0-rc7-syzkaller-00190-g97ee9d1c1696 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:journal_end+0x210/0x2d0 fs/reiserfs/journal.c:3395
Code: 89 f6 e8 a3 f5 b2 ff 48 b8 00 00 00 00 00 fc ff df 41 8a 04 07 84 c0 0f 85 a0 00 00 00 c7 03 00 00 00 00 eb 30 e8 e0 d0 5e ff <0f> 0b b8 fb ff ff ff eb 24 e8 d2 d0 5e ff 4c 89 f7 31 f6 48 83 c4
RSP: 0018:ffffc90004fff498 EFLAGS: 00010293
RAX: ffffffff822bc950 RBX: 0000000000000000 RCX: ffff8880741c9d40
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90004fff554 R08: ffffffff822bc84b R09: ffffc90004fff548
R10: fffff520009ffeaf R11: 1ffff920009ffea9 R12: ffff8880741caf18
R13: 1ffff1100e8395e3 R14: ffffc90004fff540 R15: 1ffff920009ffeaa
FS:  00007fb0b0a3f700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055c7b7c3f018 CR3: 000000007f927000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 reiserfs_truncate_file+0x47c/0x790 fs/reiserfs/inode.c:2311
 reiserfs_setattr+0xc4d/0x11a0 fs/reiserfs/inode.c:3395
 notify_change+0xe38/0x10f0 fs/attr.c:420
 do_truncate+0x1fb/0x2e0 fs/open.c:65
 handle_truncate fs/namei.c:3216 [inline]
 do_open fs/namei.c:3561 [inline]
 path_openat+0x2770/0x2df0 fs/namei.c:3714
 do_filp_open+0x264/0x4f0 fs/namei.c:3741
 do_sys_openat2+0x124/0x4e0 fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_creat fs/open.c:1402 [inline]
 __se_sys_creat fs/open.c:1396 [inline]
 __x64_sys_creat+0x11f/0x160 fs/open.c:1396
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fb0afc8c0d9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb0b0a3f168 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 00007fb0afdac050 RCX: 00007fb0afc8c0d9
RDX: 0000000000000000 RSI: 0000000000000100 RDI: 0000000020000080
RBP: 00007fb0afce7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fffc1e1e46f R14: 00007fb0b0a3f300 R15: 0000000000022000
 </TASK>

