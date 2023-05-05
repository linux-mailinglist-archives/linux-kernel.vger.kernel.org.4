Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF01E6F80FD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 12:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbjEEKn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 06:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbjEEKnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 06:43:55 -0400
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885F1E41
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 03:43:54 -0700 (PDT)
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-333f4f66d4dso203865ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 03:43:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683283434; x=1685875434;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oEnh3nWr/jgBwZcwvzTL4Lq9OTSItRiA+fMs85OZJww=;
        b=deBlF8wSzW2TyTdHiy2IMmcrpGsDE8d9sWFW/+1mAk/NAMQwldxD8PvbqvkKuuQ5XI
         hVS00dAhfbMhiQ55VYt53XVG5HInzYo/9ZX/lfZOlv2fpByAjaXrFUUYRJ4BlYFs+P9l
         F4DnlNbQR70m+Fym/dA9wgHCbEo+rMafyYrNpUjLAu2uyuLI4012BEzTVeoE25RnBD1A
         JNzH5nUC1X2vrqI6U8ocHwh5ZdVYaopKXYXLlx/6MMwfDPpDgAMEXPTuOZodi2baYaCi
         oNEPXvLVfoMf3DkhqMIM21PVUBxHA42HcDABm6W7+wI96Yfe3JFF+HjMDka6HPFQ/g3Z
         n8+g==
X-Gm-Message-State: AC+VfDzNoidw08Z0jhIcNdVrukEdcawdILqs5Dyn+CuwUMPzL7pfeC5F
        G4SSkMpwalyF8yXgI++cjOWuvOG58QqgMQbdtlbj2HJLHGPX
X-Google-Smtp-Source: ACHHUZ7X7jpOh7h12Uz0/x52atjY2bRuppz6KBb8jysGbxq2CVoHOWqmQ/WEXgrvockG7hKuRaJMQpJi0N7beHsQ4c8Vc+gAU3K7
MIME-Version: 1.0
X-Received: by 2002:a92:cc88:0:b0:32b:7258:70f1 with SMTP id
 x8-20020a92cc88000000b0032b725870f1mr523087ilo.6.1683283433853; Fri, 05 May
 2023 03:43:53 -0700 (PDT)
Date:   Fri, 05 May 2023 03:43:53 -0700
In-Reply-To: <00000000000016552c05f1d7e734@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000219cf005faeff735@google.com>
Subject: Re: [syzbot] [mm?] WARNING in shmem_evict_inode
From:   syzbot <syzbot+3d4aa0d3e784b29b1520@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    3c4aa4434377 Merge tag 'ceph-for-6.4-rc1' of https://githu..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12b6d904280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c1d541e02d3faec
dashboard link: https://syzkaller.appspot.com/bug?extid=3d4aa0d3e784b29b1520
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14d1973c280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8f7290c9ee9a/disk-3c4aa443.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/750ee3ca09db/vmlinux-3c4aa443.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5839788c2cab/bzImage-3c4aa443.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3d4aa0d3e784b29b1520@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 6362 at mm/shmem.c:1186 shmem_evict_inode+0x873/0xb60 mm/shmem.c:1186
Modules linked in:
CPU: 0 PID: 6362 Comm: syz-executor.1 Not tainted 6.3.0-syzkaller-13091-g3c4aa4434377 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
RIP: 0010:shmem_evict_inode+0x873/0xb60 mm/shmem.c:1186
Code: 89 fe e8 70 1c ca ff 45 85 ff 75 ab e8 46 20 ca ff 48 8b 74 24 18 48 8b 7c 24 20 e8 a7 de a7 ff e9 fc fd ff ff e8 2d 20 ca ff <0f> 0b e9 a0 f8 ff ff e8 21 20 ca ff 4c 89 ea 48 b8 00 00 00 00 00
RSP: 0018:ffffc9000b147858 EFLAGS: 00010293
RAX: 0000000000000000 RBX: fffffffffffff840 RCX: 0000000000000000
RDX: ffff88807c94e040 RSI: ffffffff81b95ec3 RDI: 0000000000000007
RBP: ffffc9000b147950 R08: 0000000000000007 R09: 0000000000000000
R10: fffffffffffff840 R11: 0000000000000000 R12: ffff888076f85450
R13: ffff888076f854a0 R14: ffff888076f85380 R15: ffff888076f85390
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7087f5e108 CR3: 000000007c6b6000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 evict+0x2ed/0x6b0 fs/inode.c:665
 iput_final fs/inode.c:1747 [inline]
 iput.part.0+0x50a/0x740 fs/inode.c:1773
 iput+0x5c/0x80 fs/inode.c:1763
 dentry_unlink_inode+0x2b1/0x460 fs/dcache.c:401
 __dentry_kill+0x3c0/0x640 fs/dcache.c:607
 dentry_kill fs/dcache.c:733 [inline]
 dput+0x865/0xe10 fs/dcache.c:913
 __fput+0x3cc/0xa90 fs/file_table.c:329
 task_work_run+0x16f/0x270 kernel/task_work.c:179
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xad3/0x2960 kernel/exit.c:871
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1021
 get_signal+0x2315/0x25b0 kernel/signal.c:2874
 arch_do_signal_or_restart+0x79/0x5c0 arch/x86/kernel/signal.c:306
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x11f/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
 syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:297
 do_syscall_64+0x46/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7efe7028c169
Code: Unable to access opcode bytes at 0x7efe7028c13f.
RSP: 002b:00007efe70fe2168 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: 0000000000116000 RBX: 00007efe703abf80 RCX: 00007efe7028c169
RDX: 00000000fffffd2c RSI: 0000000020000000 RDI: 0000000000000004
RBP: 00007efe702e7ca1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc607e699f R14: 00007efe70fe2300 R15: 0000000000022000
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
