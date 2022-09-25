Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303705E93E2
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 17:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbiIYPUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 11:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiIYPUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 11:20:42 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0384192BC
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 08:20:40 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id l18-20020a056e02067200b002f6af976994so3584217ilt.16
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 08:20:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=TXMgDqqROIoq+nSFi/qehxaZInU9GtmOr944JF3ZWVU=;
        b=TRhXgf3WVGS3p/XpuzlCnBoeknGMk2udfmy+HF5VWB3AtjvKFw6ah3EiuW8ZFBpvb/
         inTd5Q/nmBoszwiZIvrghqoWiEEcMpB69xMCe1UI6nFea9Cqxn5J4h0BUdjBmlBmnJQn
         S01BMCuLy5yW6ewPW+WjElz5ZbbCG/Oo8os0zhLEq9Awg0df5VHm7FaBXPQkLOcEd9GR
         1JNqVeXu0sVzyzDSof7zfcl87j/J8RqvDLJGWO5JIC6HwSZwyOgYpT54qa0S4juXfsQw
         IY5pcydhhmy7aRjDeW045/Ur3EkXffYcAFUwm7KW+ws4jXCny7bO6JKzPPj3Rm2lLXrg
         s5QQ==
X-Gm-Message-State: ACrzQf1/sdH9FK5OvABw45ncR6jlfp9NbLtNnMRTR3MXziaQoIRUK7zD
        BLQ3yECGNDpzosgp5MtFV929ImoAlI/yUanBXUMrW9TVezIA
X-Google-Smtp-Source: AMsMyM6GU4ihBPrwOqRAFdtId77/mGCNVvlkci6UcLmo7cPdN52wx2uK/HU6Hs1e92uMxC0BWSKyDFgAEmOJ5hYTFX1ixyEh3kc4
MIME-Version: 1.0
X-Received: by 2002:a92:ca4b:0:b0:2f8:5122:6bab with SMTP id
 q11-20020a92ca4b000000b002f851226babmr1227585ilo.304.1664119240390; Sun, 25
 Sep 2022 08:20:40 -0700 (PDT)
Date:   Sun, 25 Sep 2022 08:20:40 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000030000a05e981f475@google.com>
Subject: [syzbot] WARNING in nilfs_btree_assign
From:   syzbot <syzbot+31837fe952932efc8fb9@syzkaller.appspotmail.com>
To:     konishi.ryusuke@gmail.com, linux-kernel@vger.kernel.org,
        linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

syzbot found the following issue on:

HEAD commit:    bf682942cd26 Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15f32754880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c221af36f6d1d811
dashboard link: https://syzkaller.appspot.com/bug?extid=31837fe952932efc8fb9
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=178d9754880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17a0e86c880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a27f1315833f/disk-bf682942.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/10067330020a/vmlinux-bf682942.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+31837fe952932efc8fb9@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5419 at fs/nilfs2/btree.c:2275 nilfs_btree_assign+0xa75/0xd00
Modules linked in:
CPU: 1 PID: 5419 Comm: segctord Not tainted 6.0.0-rc6-syzkaller-00210-gbf682942cd26 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
RIP: 0010:nilfs_btree_assign+0xa75/0xd00 fs/nilfs2/btree.c:2275
Code: 00 0f 85 a4 02 00 00 44 89 f8 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d c3 e8 17 03 41 fe 4c 8b 74 24 38 eb a5 e8 0b 03 41 fe <0f> 0b 41 bf fe ff ff ff 4c 8b 74 24 38 eb 91 44 89 f9 80 e1 07 80
RSP: 0018:ffffc900038675a0 EFLAGS: 00010293
RAX: ffffffff83468745 RBX: ffff888062904028 RCX: ffff88801c9ad880
RDX: 0000000000000000 RSI: 00000000fffffffe RDI: 00000000fffffffe
RBP: ffffc900038676d0 R08: ffffffff834680af R09: ffffed100cc669b4
R10: ffffed100cc669b4 R11: 1ffff1100cc669b3 R12: ffff88807be97800
R13: dffffc0000000000 R14: 0000000000000001 R15: 00000000fffffffe
FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000200d9000 CR3: 00000000715c0000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 nilfs_bmap_assign+0x87/0x150 fs/nilfs2/bmap.c:382
 nilfs_segctor_update_payload_blocknr fs/nilfs2/segment.c:1589 [inline]
 nilfs_segctor_assign fs/nilfs2/segment.c:1623 [inline]
 nilfs_segctor_do_construct+0x3a49/0x6fe0 fs/nilfs2/segment.c:2050
 nilfs_segctor_construct+0x143/0x8d0 fs/nilfs2/segment.c:2375
 nilfs_segctor_thread_construct fs/nilfs2/segment.c:2483 [inline]
 nilfs_segctor_thread+0x534/0x1180 fs/nilfs2/segment.c:2566
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
