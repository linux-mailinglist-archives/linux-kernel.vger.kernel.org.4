Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C522650A3F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 11:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbiLSKh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 05:37:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbiLSKhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 05:37:52 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553FABC0E
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 02:37:50 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id p3-20020a6bfa03000000b006df8582e11cso3916046ioh.22
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 02:37:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G7IYf1zi9tm0bYK2kwBxy3ppebnwUTizEeFdotIhA24=;
        b=1pqZVsh17qWc3yXv1/wtujfUCSJqDFl6QOWQ+sr9QTmoBX+m82yNCz//yxqbk3UCpj
         0HoNvF0V2TDy0XdMQHKcMo3gQTm1y9e3QASz8XJuSEtIJ79MLsHbH5s65+LeSq8n0Soh
         w4vlqMWmT6Pw5N5sxCGgFclXF5npafMkjQHkr8UiW6ZaSGwQEhf1awYSIAhx80PpZnJD
         UYWksVxU56SA4olldtaRR8HOIhzMLliE6GgUw3EKInqk3mMGg6vOZgubfgD2Mb88zx+w
         Z0A89zm7SyvX/tvJ9T3ka4KRnZRtqJtKBMqsdYB68/0p4mopFNT3Ia+fZOrbFxYSFDdA
         VY+A==
X-Gm-Message-State: ANoB5pmxdcAUB+OZ2G5pQTj44dMogKb/2ZBOfwLQ3a3k9f3obT1J6bwD
        xsL2iRdtAZ2TTGjuyzA5syYrocjxuCh1n6jUj1eCQQMd06dJ
X-Google-Smtp-Source: AA0mqf79rNmBtbvfBW42V1ex82HBx/H24BMlFL1IAvEW1/59sVEIgOrtaD2HZHhwLajzWGOeke1Ovz1jEsFGioSCxX4XAv0RBUbN
MIME-Version: 1.0
X-Received: by 2002:a5d:8046:0:b0:6de:754e:4427 with SMTP id
 b6-20020a5d8046000000b006de754e4427mr38342932ior.17.1671446269629; Mon, 19
 Dec 2022 02:37:49 -0800 (PST)
Date:   Mon, 19 Dec 2022 02:37:49 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000299cf505f02be9ef@google.com>
Subject: [syzbot] [vfs?] [ntfs3?] [tmpfs?] WARNING in lookup_slow
From:   syzbot <syzbot+7923cf13ed6110fc744d@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org,
        almaz.alexandrovich@paragon-software.com, hughd@google.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, ntfs3@lists.linux.dev,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
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

Hello,

syzbot found the following issue on:

HEAD commit:    84e57d292203 Merge tag 'exfat-for-6.2-rc1' of git://git.ke..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1400b79d880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=35448eec2d733f7a
dashboard link: https://syzkaller.appspot.com/bug?extid=7923cf13ed6110fc744d
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1526a8f7880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13005d9f880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e387d46e5fde/disk-84e57d29.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/edcdbee22654/vmlinux-84e57d29.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f906e9373d31/bzImage-84e57d29.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/7e801c3092a5/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7923cf13ed6110fc744d@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem)): count = 0x0, magic = 0xffff8880725a36d0, owner = 0x0, curr 0xffff888028060000, list empty
WARNING: CPU: 1 PID: 5283 at kernel/locking/rwsem.c:1336 __up_read+0x5ff/0x690 kernel/locking/rwsem.c:1336
Modules linked in:
CPU: 0 PID: 5283 Comm: syz-executor217 Not tainted 6.1.0-syzkaller-11674-g84e57d292203 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:__up_read+0x5ff/0x690 kernel/locking/rwsem.c:1336
Code: 44 d8 48 c7 c7 a0 ab ed 8a 48 c7 c6 40 ac ed 8a 48 8b 54 24 20 4c 89 f1 4d 89 f8 4d 89 e9 31 c0 53 e8 85 61 e8 ff 48 83 c4 08 <0f> 0b 48 bb 00 00 00 00 00 fc ff df 4c 8b 6c 24 18 e9 53 fb ff ff
RSP: 0018:ffffc90003fffa60 EFLAGS: 00010296
RAX: 9113eee468a99100 RBX: ffffffff8aedac80 RCX: ffff888028060000
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc90003fffb38 R08: ffffffff816f274d R09: fffff520007fff05
R10: fffff520007fff05 R11: 1ffff920007fff04 R12: ffff8880725a3728
R13: ffff888028060000 R14: ffff8880725a36d0 R15: 0000000000000000
FS:  00007f6f26a5d700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6f26a5d718 CR3: 000000001d340000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 inode_unlock_shared include/linux/fs.h:771 [inline]
 lookup_slow+0x5e/0x70 fs/namei.c:1703
 walk_component+0x2e1/0x410 fs/namei.c:1993
 lookup_last fs/namei.c:2450 [inline]
 path_lookupat+0x17d/0x450 fs/namei.c:2474
 filename_lookup+0x274/0x650 fs/namei.c:2503
 user_path_at_empty+0x40/0x1a0 fs/namei.c:2876
 user_path_at include/linux/namei.h:57 [inline]
 __do_sys_chdir fs/open.c:514 [inline]
 __se_sys_chdir+0xb8/0x210 fs/open.c:508
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f6f2ecd2659
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 71 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6f26a5d2f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000050
RAX: ffffffffffffffda RBX: 0000000000000032 RCX: 00007f6f2ecd2659
RDX: 00007f6f2ecd2659 RSI: ffffffffffffffb8 RDI: 0000000020000380
RBP: 00007f6f2ed76798 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f6f2ed76790
R13: 00007f6f2ed7679c R14: 6174656d776f6873 R15: 0030656c69662f2e
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
