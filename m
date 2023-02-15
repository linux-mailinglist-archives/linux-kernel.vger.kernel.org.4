Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8521B69855E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 21:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjBOUQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 15:16:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjBOUQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 15:16:02 -0500
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88AA2D14D
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 12:15:58 -0800 (PST)
Received: by mail-il1-f205.google.com with SMTP id s12-20020a056e021a0c00b0030efd0ed890so43321ild.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 12:15:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aGJcTiHWrNKcFZ/FgYQDSHGLDwlxXSUlxi8IsS9UpjM=;
        b=Bjq9FBmiJSaMpoEy0F4n5JeevhwL7lMGpsDOOQIwSR2a4UBd0iT8NhYtbXuQjzLFFy
         gTtyX1MoHP/NCFbon8J0pyRJ8SsT4NM6kii8M94Bj7Rq2Jw/K7Fjs4fAW6TdNW/lvDy/
         qGv1hQr+hfgmgMJyEq0uGVXqRo+QuMSZE5EK2OwQjpnfM401Ong2avZquWsZC1aWmFmH
         fqssKN6yrBWbpute9AWy9eb4GY/nmTUVMPPs65oYwZPB1Q4uyuCcW1bFyTdn1upTZz9l
         bgHyKerxv5IhN07478Kkx9rzn05mKLA/VBntsG9AP2bhRvJGHUbayJEKpZc1GDLGDfAL
         ze1A==
X-Gm-Message-State: AO0yUKUxK1rcxkU/SZ4aTqPLlXT3qeHfeyDbCUIFT9EGyLuQ/2H3PNX+
        Hd17NfVoA1nriGJSieJMLSH9SoVFu1Z37QKLBJYXs20T4H68
X-Google-Smtp-Source: AK7set86i67dgAHYMXiQrl4jCFk5zyk/kVFx65aTW8VBAM0Flhxmc4ILyIoNouAVn2FLO0hKbWr+idG8IS0MjFFGK8gUMP3Dj/2m
MIME-Version: 1.0
X-Received: by 2002:a5e:c009:0:b0:73b:1230:331c with SMTP id
 u9-20020a5ec009000000b0073b1230331cmr1063621iol.98.1676492158111; Wed, 15 Feb
 2023 12:15:58 -0800 (PST)
Date:   Wed, 15 Feb 2023 12:15:58 -0800
In-Reply-To: <000000000000a8c57205f1450921@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008d9bd305f4c2bf45@google.com>
Subject: Re: [syzbot] [f2fs?] kernel BUG in f2fs_abort_atomic_write
From:   syzbot <syzbot+9b7be0f1263ed2dbfbba@syzkaller.appspotmail.com>
To:     chao@kernel.org, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    e1c04510f521 Merge tag 'pm-6.2-rc9' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=172c6577480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d9381ac81f4ac15
dashboard link: https://syzkaller.appspot.com/bug?extid=9b7be0f1263ed2dbfbba
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=138e3977480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c3d836334e11/disk-e1c04510.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4cab8c36cdb8/vmlinux-e1c04510.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7f796941fe64/bzImage-e1c04510.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/d6504ac6876e/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9b7be0f1263ed2dbfbba@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/inode.c:1763!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 5237 Comm: syz-executor.0 Not tainted 6.2.0-rc8-syzkaller-00021-ge1c04510f521 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/21/2023
RIP: 0010:iput+0x68/0x80 fs/inode.c:1763
Code: ff 83 e3 40 48 89 de e8 b6 b6 9b ff 48 85 db 75 14 e8 dc b9 9b ff 48 89 ef e8 24 f7 ff ff 5b 5d e9 cd b9 9b ff e8 c8 b9 9b ff <0f> 0b e8 31 cd e9 ff eb c5 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f
RSP: 0018:ffffc90004ddfbe0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000040 RCX: 0000000000000000
RDX: ffff88801e0f9d40 RSI: ffffffff81e54e48 RDI: 0000000000000007
RBP: ffff888072e68000 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000040 R11: 0000000000000000 R12: ffff888072e278e0
R13: 0000000000000000 R14: ffff888072e68000 R15: 0000000000000000
FS:  00007f2cbc74c700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2cb2b58000 CR3: 0000000027d2f000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 f2fs_abort_atomic_write+0xea/0x4f0 fs/f2fs/segment.c:196
 f2fs_ioc_commit_atomic_write+0x19f/0x260 fs/f2fs/file.c:2157
 __f2fs_ioctl+0x26f0/0xaaf0 fs/f2fs/file.c:4154
 f2fs_ioctl+0x18e/0x220 fs/f2fs/file.c:4242
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x197/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f2cbba8c0f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2cbc74c168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f2cbbbac050 RCX: 00007f2cbba8c0f9
RDX: 0000000000000000 RSI: 000000000000f502 RDI: 0000000000000004
RBP: 00007f2cbbae7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fffc60048ef R14: 00007f2cbc74c300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:iput+0x68/0x80 fs/inode.c:1763
Code: ff 83 e3 40 48 89 de e8 b6 b6 9b ff 48 85 db 75 14 e8 dc b9 9b ff 48 89 ef e8 24 f7 ff ff 5b 5d e9 cd b9 9b ff e8 c8 b9 9b ff <0f> 0b e8 31 cd e9 ff eb c5 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f
RSP: 0018:ffffc90004ddfbe0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000040 RCX: 0000000000000000
RDX: ffff88801e0f9d40 RSI: ffffffff81e54e48 RDI: 0000000000000007
RBP: ffff888072e68000 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000040 R11: 0000000000000000 R12: ffff888072e278e0
R13: 0000000000000000 R14: ffff888072e68000 R15: 0000000000000000
FS:  00007f2cbc74c700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2cbc74c718 CR3: 0000000027d2f000 CR4: 0000000000350ee0

