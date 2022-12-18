Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8FCF64FF51
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 16:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbiLRPgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 10:36:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiLRPgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 10:36:42 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA3A64E5
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 07:36:40 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id l13-20020a056e021c0d00b003034e24b866so5364085ilh.22
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 07:36:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2UDRP+rqHDtdAflIvbj6H9tsEQH1tc5gZEcOVjsrbO0=;
        b=JtHB1Ofi3lTAxFk1NZhNWXl3wmIEPpvVpihCybEteasKgvbSCxDpjg06QtK30wJbsi
         nvWDncKq12JWDv3lUQzu7m5bI+K48o1joFkxC54JO2nreTX1cw2M+0fWy+29k2k/lCWB
         0WImPSdWILsFHDmWCAK3BEwnz53jte+nVvjy8cqnFOqISqrJWhG2IVz12jWhQjt4ochM
         ZKfSWRK1+xZUkYTGHgmynUoFduj2GCWK3VS2CcHXogBKfLTYf7CUPU0YEt1drxyqj/Ub
         cgbEaY9qwb5uen9jlQ9yn4Jx7ZHY5oGieMG7je21ldnxShyq49bEHkr06QQ+wUpPe2Yc
         FN8Q==
X-Gm-Message-State: ANoB5plJ46gJfiSw9aw44JVwxk2epWrQlYvOLeXzrQJ7hpfLEh+XqaP1
        D4JXY6w9kmDror7iW2g/4YLCkp5oXZlRBdYg5PS4/iSD8pqV
X-Google-Smtp-Source: AA0mqf4PGPr/gv0WcsIAWq+z4iEzp0kGhKxHD1sNzeEiuKVmH0phnSCjokl2zccdegD6jNVtSm/c9yO8cJNOiQBrfQroBnPrpbYt
MIME-Version: 1.0
X-Received: by 2002:a02:85ab:0:b0:389:fed9:fff2 with SMTP id
 d40-20020a0285ab000000b00389fed9fff2mr20415156jai.123.1671377800186; Sun, 18
 Dec 2022 07:36:40 -0800 (PST)
Date:   Sun, 18 Dec 2022 07:36:40 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000010d44905f01bf8e7@google.com>
Subject: [syzbot] [ntfs3?] BUG: unable to handle kernel NULL pointer
 dereference in ntfs_sparse_cluster
From:   syzbot <syzbot+deb631beeb93bdb2df4c@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        nathan@kernel.org, ndesaulniers@google.com, ntfs3@lists.linux.dev,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
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

HEAD commit:    e2ca6ba6ba01 Merge tag 'mm-stable-2022-12-13' of git://git..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=122e9bc7880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=276eb8ff64eb2c27
dashboard link: https://syzkaller.appspot.com/bug?extid=deb631beeb93bdb2df4c
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10d8601b880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17a09c93880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8aad47431ccd/disk-e2ca6ba6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/382636835ba9/vmlinux-e2ca6ba6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ac62c9f6a7cf/bzImage-e2ca6ba6.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/2d4fa4df0bbf/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+deb631beeb93bdb2df4c@syzkaller.appspotmail.com

BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor instruction fetch in kernel mode
#PF: error_code(0x0010) - not-present page
PGD 217c0067 P4D 217c0067 PUD 1e4e8067 PMD 0 
Oops: 0010 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 5302 Comm: syz-executor244 Not tainted 6.1.0-syzkaller-09941-ge2ca6ba6ba01 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0018:ffffc90003c1fca8 EFLAGS: 00010286
RAX: 0000000000000000 RBX: dffffc0000000000 RCX: ffff8880268b8000
RDX: 0000000000000000 RSI: ffffea0001c79440 RDI: ffff888075eb0478
RBP: ffffea0001c79440 R08: ffffffff81bc12ab R09: fffff9400038f289
R10: fffff9400038f289 R11: 1ffffd400038f288 R12: 0000000000000000
R13: 0000000000010000 R14: 1ffffd400038f288 R15: ffffffffffffffff
FS:  00007f45fe7d4700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 000000002986e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ntfs_sparse_cluster+0x767/0xa90 fs/ntfs3/file.c:335
 ntfs_fallocate+0xbc6/0xfb0 fs/ntfs3/file.c:727
 vfs_fallocate+0x515/0x670 fs/open.c:323
 ksys_fallocate fs/open.c:346 [inline]
 __do_sys_fallocate fs/open.c:354 [inline]
 __se_sys_fallocate fs/open.c:352 [inline]
 __x64_sys_fallocate+0xb9/0x100 fs/open.c:352
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f4606a484c9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f45fe7d4308 EFLAGS: 00000246 ORIG_RAX: 000000000000011d
RAX: ffffffffffffffda RBX: 00007f4606aec6f8 RCX: 00007f4606a484c9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000006
RBP: 00007f4606aec6f0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000010000 R11: 0000000000000246 R12: 00007f4606aec6fc
R13: 00007f4606ab93d8 R14: 0030656c69662f2e R15: 0000000000022000
 </TASK>
Modules linked in:
CR2: 0000000000000000
---[ end trace 0000000000000000 ]---
RIP: 0010:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0018:ffffc90003c1fca8 EFLAGS: 00010286
RAX: 0000000000000000 RBX: dffffc0000000000 RCX: ffff8880268b8000
RDX: 0000000000000000 RSI: ffffea0001c79440 RDI: ffff888075eb0478
RBP: ffffea0001c79440 R08: ffffffff81bc12ab R09: fffff9400038f289
R10: fffff9400038f289 R11: 1ffffd400038f288 R12: 0000000000000000
R13: 0000000000010000 R14: 1ffffd400038f288 R15: ffffffffffffffff
FS:  00007f45fe7d4700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 000000002986e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
