Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8F770A898
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 16:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjETOzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 10:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbjETOzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 10:55:51 -0400
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176BB116
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 07:55:49 -0700 (PDT)
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-76c56492fa0so132065339f.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 07:55:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684594548; x=1687186548;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B4iLgFiE+ByV2f7sOeewOAOG3keoQv49WDwj0mKMtes=;
        b=CEvtaTQUkiRhfgL0iHkEzvIkGWe4AcZIDx/qJji+F7cFjx7w8WHU3SXdEIYYYIOliG
         BZt2QRFPOjIt5u10n2Te+QszgBLgsSkDH5lbOPJJge7oGxz4UpiV1B5/39AqcOBsvHu3
         Nv8VXWb0gcdDFJ8xQxn+21ODDSSlqRuJQivKpmcf8f4ZT7QmbgGnriEpHBMuxNdcVG6T
         zCtBrNvYSeZIXfvmH/R2OGduNns3pBiJBV5OhR8+5e3nwn8kPHmriyb6Z7w9XBhGDDD4
         4uevnZnXLoHFXVsnb1n1wFcOB7l/4U3cnl/DW1ik3dhd6fVThq8LPlG2uSriq3DTBC+U
         QNpQ==
X-Gm-Message-State: AC+VfDxhhovK8lqhKT957Hl6GjncAriQNktnkk/UOCPsFiRJj49RTuav
        E2/+4NowH/xW6L9VHE50x16hyST3BdcUzqwRm4ZyptE0HfRD
X-Google-Smtp-Source: ACHHUZ6MYZctwrpUn7LsNALT5EV4xokpPFAsyuy/vH46TlPrn4OrYyY4Gq1POVSTz8mwljInYanMn5hvwwna+CKT8YQp7kTYkl3F
MIME-Version: 1.0
X-Received: by 2002:a02:b1d8:0:b0:41a:c5e3:6bf4 with SMTP id
 u24-20020a02b1d8000000b0041ac5e36bf4mr1714679jah.6.1684594548414; Sat, 20 May
 2023 07:55:48 -0700 (PDT)
Date:   Sat, 20 May 2023 07:55:48 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a6229505fc213b06@google.com>
Subject: [syzbot] [btrfs?] WARNING in btrfs_relocate_block_group
From:   syzbot <syzbot+07a7e6273e07bda9ef8b@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    1b66c114d161 Merge tag 'nfsd-6.4-1' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=160f9dd9280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=94af80bb8ddd23c4
dashboard link: https://syzkaller.appspot.com/bug?extid=07a7e6273e07bda9ef8b
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=122229f9280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2e240bb8f051/disk-1b66c114.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f68505e2033a/vmlinux-1b66c114.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b5b233cfac6d/bzImage-1b66c114.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/92afd11e51ee/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+07a7e6273e07bda9ef8b@syzkaller.appspotmail.com

BTRFS info (device loop0): relocating block group 6881280 flags data|metadata
------------[ cut here ]------------
WARNING: CPU: 1 PID: 5901 at fs/btrfs/relocation.c:4123 btrfs_relocate_block_group+0xcda/0xd70
Modules linked in:
CPU: 1 PID: 5901 Comm: syz-executor.0 Not tainted 6.4.0-rc2-syzkaller-00015-g1b66c114d161 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/28/2023
RIP: 0010:btrfs_relocate_block_group+0xcda/0xd70 fs/btrfs/relocation.c:4123
Code: fe 48 c7 c7 80 2e 2b 8b 48 c7 c6 20 2e 2b 8b ba b1 0f 00 00 e8 b7 c4 10 07 e8 e2 e2 ee fd 0f 0b e9 62 fd ff ff e8 d6 e2 ee fd <0f> 0b e9 b5 fd ff ff e8 ca e2 ee fd 0f 0b e9 08 fe ff ff 44 89 e1
RSP: 0018:ffffc9000ae1fa28 EFLAGS: 00010293
RAX: ffffffff839c99ca RBX: 0000000000190000 RCX: ffff88806f4d0000
RDX: 0000000000000000 RSI: 0000000000190000 RDI: 0000000000000000
RBP: ffff88806d673068 R08: ffffffff839c9778 R09: fffff520015c3f35
R10: 0000000000000000 R11: dffffc0000000001 R12: ffff88806e4e2000
R13: 0000000000000000 R14: ffff88806e750000 R15: ffff88806e750010
FS:  00007fdf35b02700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe4fb4e6000 CR3: 000000002079a000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btrfs_relocate_chunk+0x12c/0x3b0 fs/btrfs/volumes.c:3276
 __btrfs_balance+0x1b06/0x2690 fs/btrfs/volumes.c:4011
 btrfs_balance+0xbdb/0x1120 fs/btrfs/volumes.c:4395
 btrfs_ioctl_balance+0x493/0x7c0 fs/btrfs/ioctl.c:3599
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl+0xf1/0x160 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fdf34e8c169
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fdf35b02168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fdf34fac050 RCX: 00007fdf34e8c169
RDX: 00000000200003c0 RSI: 00000000c4009420 RDI: 0000000000000005
RBP: 00007fdf34ee7ca1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff060f715f R14: 00007fdf35b02300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
