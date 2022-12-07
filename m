Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2366462B4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 21:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiLGUsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 15:48:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiLGUrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 15:47:43 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E470A2AEC
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 12:47:35 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id t2-20020a6b6402000000b006dea34ad528so14219007iog.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 12:47:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xfNaKa2Q6Dxio2+kzEH8IXgw2KHdb6DNTDuqymdug6o=;
        b=i9VVB1+MecRXJTYxXB9aZBt+HCe+oHR7kzJpzRoe2n3XBk3ygR0HivsZ44nDgOsMfj
         1LHYb2HisrI1ybc2BXNZ4Z5ye4SI5MYoPssJ2MQfL/Fwvu5DAjbHiYKwqRNdN3Zck28m
         D0cSYtT/nvcc6j7Z1EcFeF8bE8w3bJK7e8ZbiZzk2MD8jdwnTmoA96Ac0N+sY+/6wgId
         9w+mKev/2F6r4W7NyrYDxooKAA1KM/8mCyX4EWFxN1SDZ13XATzpnSmcrcRegAwTSa/k
         KuJNyA6jCJUqLQYiwfio+fnYxvZNZubfP78rdLTdceULhZ/st3vuMikgtynVHVHXwhP/
         rgow==
X-Gm-Message-State: ANoB5pmK916OKw1LxyYotgprwRvtWYIX1qstCQRk97LdT06whxXWuwOe
        qeO5rGlBT8Y3V3dyA1XojEL41wRltNOEDwfxlSWUlzK8MP2K
X-Google-Smtp-Source: AA0mqf7ZuM64318il2XMLMCR7zdirTdZRcd8l+QJuEAAS1OwFrckjmz7LV2aiUsEi5LsL4Gif90bVO//lpsRz/W66+SGvvq8m4CV
MIME-Version: 1.0
X-Received: by 2002:a02:241c:0:b0:38a:5b87:24e2 with SMTP id
 f28-20020a02241c000000b0038a5b8724e2mr4026058jaa.159.1670446054920; Wed, 07
 Dec 2022 12:47:34 -0800 (PST)
Date:   Wed, 07 Dec 2022 12:47:34 -0800
In-Reply-To: <000000000000decafe05ef372b92@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b85cdf05ef430758@google.com>
Subject: Re: [syzbot] possible deadlock in ovl_fallocate
From:   syzbot <syzbot+38a94e1872470e3450a6@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
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

HEAD commit:    591cd61541b9 Add linux-next specific files for 20221207
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1044bbad880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8b2d3e63e054c24f
dashboard link: https://syzkaller.appspot.com/bug?extid=38a94e1872470e3450a6
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15236fe3880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=178313f3880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bc862c01ec56/disk-591cd615.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8f9b93f8ed2f/vmlinux-591cd615.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9d5cb636d548/bzImage-591cd615.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+38a94e1872470e3450a6@syzkaller.appspotmail.com

============================================
WARNING: possible recursive locking detected
6.1.0-rc8-next-20221207-syzkaller #0 Not tainted
--------------------------------------------
syz-executor169/5069 is trying to acquire lock:
ffff8880750fa480 (&ovl_i_mutex_key[depth]){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:756 [inline]
ffff8880750fa480 (&ovl_i_mutex_key[depth]){+.+.}-{3:3}, at: ovl_remove_privs_unlocked fs/overlayfs/file.c:519 [inline]
ffff8880750fa480 (&ovl_i_mutex_key[depth]){+.+.}-{3:3}, at: ovl_fallocate+0x15c/0x270 fs/overlayfs/file.c:546

but task is already holding lock:
ffff8880750fa480 (&ovl_i_mutex_key[depth]){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:756 [inline]
ffff8880750fa480 (&ovl_i_mutex_key[depth]){+.+.}-{3:3}, at: ovl_fallocate+0x9f/0x270 fs/overlayfs/file.c:535

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&ovl_i_mutex_key[depth]);
  lock(&ovl_i_mutex_key[depth]);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

2 locks held by syz-executor169/5069:
 #0: ffff88802b1d6460 (sb_writers#9){.+.+}-{0:0}, at: ksys_fallocate fs/open.c:346 [inline]
 #0: ffff88802b1d6460 (sb_writers#9){.+.+}-{0:0}, at: __do_sys_fallocate fs/open.c:354 [inline]
 #0: ffff88802b1d6460 (sb_writers#9){.+.+}-{0:0}, at: __se_sys_fallocate fs/open.c:352 [inline]
 #0: ffff88802b1d6460 (sb_writers#9){.+.+}-{0:0}, at: __x64_sys_fallocate+0xd3/0x140 fs/open.c:352
 #1: ffff8880750fa480 (&ovl_i_mutex_key[depth]){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:756 [inline]
 #1: ffff8880750fa480 (&ovl_i_mutex_key[depth]){+.+.}-{3:3}, at: ovl_fallocate+0x9f/0x270 fs/overlayfs/file.c:535

stack backtrace:
CPU: 1 PID: 5069 Comm: syz-executor169 Not tainted 6.1.0-rc8-next-20221207-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd1/0x138 lib/dump_stack.c:106
 print_deadlock_bug kernel/locking/lockdep.c:2990 [inline]
 check_deadlock kernel/locking/lockdep.c:3033 [inline]
 validate_chain kernel/locking/lockdep.c:3818 [inline]
 __lock_acquire.cold+0x116/0x3a7 kernel/locking/lockdep.c:5055
 lock_acquire kernel/locking/lockdep.c:5668 [inline]
 lock_acquire+0x1e3/0x630 kernel/locking/lockdep.c:5633
 down_write+0x94/0x220 kernel/locking/rwsem.c:1562
 inode_lock include/linux/fs.h:756 [inline]
 ovl_remove_privs_unlocked fs/overlayfs/file.c:519 [inline]
 ovl_fallocate+0x15c/0x270 fs/overlayfs/file.c:546
 vfs_fallocate+0x48b/0xe00 fs/open.c:323
 ksys_fallocate fs/open.c:346 [inline]
 __do_sys_fallocate fs/open.c:354 [inline]
 __se_sys_fallocate fs/open.c:352 [inline]
 __x64_sys_fallocate+0xd3/0x140 fs/open.c:352
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fa3d1605c29
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffccc67e118 EFLAGS: 00000246 ORIG_RAX: 000000000000011d
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fa3d1605c29
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007fa3d15c9dd0 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000001000f4 R11: 0000000000000246 R12: 00007fa3d15c9e60
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

