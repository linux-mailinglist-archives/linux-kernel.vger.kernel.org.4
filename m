Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D3F65D58E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 15:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239430AbjADOZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 09:25:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236451AbjADOZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 09:25:00 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C624CAA
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 06:24:58 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id o22-20020a6b5a16000000b006e2d564944aso9665012iob.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 06:24:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bR92wtnOeIWIwRqsWxpYxUXY5W/bvIRYZT8TdYe+PtU=;
        b=VshQGf4Hal59c0byWC22sQSDJaZkygQ38EEGHupIao5s2dpwHcPLkjcfqbDkp643Xs
         9DmBNAGfqjgz7+QnA8jb+LcjjehugWMBZ5qF1x5fl6FlS9SWiCbVK9gavZaApHmmPLPJ
         jiBOYtTbu7uVGstNalxl3BpoFu0IZ5w96mOuuIn4G9H+h9YdNikj+2Zqd2rqctY6Qtdj
         +eyHsDdzxxVN0VFbtYsTrj6nwm9AOLZVj85e+5V6Rm34gfysgyhNl89wa9hKCWaG4bY6
         vrVfVZXanVhsUYN5v0F2L/J8SAF4TNbgvaMuI3gsN0n3qy9MtpmQ3gUoxeiiqLwDXSKb
         sj6Q==
X-Gm-Message-State: AFqh2kq6SXVPnHAdAM7uDPONCrgYbaYOwp7TxI31eXb3HotT4XvytJ42
        8BNEwnhkiXtQLSXm1HCEB4pySly8rZWlgsu9xg0/WeiPBW27
X-Google-Smtp-Source: AMrXdXtxj7kDt2YNuznIprhpef/X0PywBUDLvhWyDVvKc92HgQOzfbExrWbaICsDMM18jBgsqN9ks7xkDuC1WF40QBIRweZ9V26T
MIME-Version: 1.0
X-Received: by 2002:a05:6638:329b:b0:38a:1799:8730 with SMTP id
 f27-20020a056638329b00b0038a17998730mr4213995jav.149.1672842296673; Wed, 04
 Jan 2023 06:24:56 -0800 (PST)
Date:   Wed, 04 Jan 2023 06:24:56 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dbce4e05f170f289@google.com>
Subject: [syzbot] [hfs?] WARNING in hfs_write_inode
From:   syzbot <syzbot+7bb7cd3595533513a9e7@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, arnd@arndb.de,
        christian.brauner@ubuntu.com, damien.lemoal@opensource.wdc.com,
        jlayton@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        torvalds@linux-foundation.org, willy@infradead.org
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

HEAD commit:    c8451c141e07 Merge tag 'acpi-6.2-rc2' of git://git.kernel...
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13c7c8b2480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=60208ff8fae87ede
dashboard link: https://syzkaller.appspot.com/bug?extid=7bb7cd3595533513a9e7
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10beaa7c480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=117c1a2a480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3bf54f63556a/disk-c8451c14.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e05385cdce2b/vmlinux-c8451c14.xz
kernel image: https://storage.googleapis.com/syzbot-assets/78ecaed069cb/bzImage-c8451c14.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/9bbf851f8c00/mount_0.gz

The issue was bisected to:

commit 55d1cbbbb29e6656c662ee8f73ba1fc4777532eb
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Tue Nov 9 02:35:04 2021 +0000

    hfs/hfsplus: use WARN_ON for sanity check

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16aa6992480000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15aa6992480000
console output: https://syzkaller.appspot.com/x/log.txt?x=11aa6992480000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7bb7cd3595533513a9e7@syzkaller.appspotmail.com
Fixes: 55d1cbbbb29e ("hfs/hfsplus: use WARN_ON for sanity check")

------------[ cut here ]------------
WARNING: CPU: 0 PID: 55 at fs/hfs/inode.c:489 hfs_write_inode+0x8bb/0x9e0 fs/hfs/inode.c:489
Modules linked in:
CPU: 0 PID: 55 Comm: kworker/u4:4 Not tainted 6.2.0-rc1-syzkaller-00084-gc8451c141e07 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Workqueue: writeback wb_workfn (flush-7:0)
RIP: 0010:hfs_write_inode+0x8bb/0x9e0 fs/hfs/inode.c:489
Code: 24 c8 00 00 00 48 8d 90 74 ff ff ff 48 8d 70 a6 e8 9a f5 ff ff e9 ec fc ff ff 41 bc fb ff ff ff e9 04 fd ff ff e8 35 90 37 ff <0f> 0b e9 bf fb ff ff e8 29 90 37 ff 0f 0b e9 b9 fe ff ff e8 cd 77
RSP: 0018:ffffc9000201f6e8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 1ffff92000403edf RCX: 0000000000000000
RDX: ffff888018518040 RSI: ffffffff8248e35b RDI: 0000000000000005
RBP: ffff88807639a198 R08: 0000000000000005 R09: 0000000000000065
R10: 0000000000000050 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000050 R14: ffffc9000201f728 R15: 0000000000000082
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc010a2a68 CR3: 000000001db0d000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 write_inode fs/fs-writeback.c:1451 [inline]
 __writeback_single_inode+0xcfc/0x1440 fs/fs-writeback.c:1663
 writeback_sb_inodes+0x54d/0xf90 fs/fs-writeback.c:1889
 wb_writeback+0x2c5/0xd70 fs/fs-writeback.c:2063
 wb_do_writeback fs/fs-writeback.c:2206 [inline]
 wb_workfn+0x2e0/0x12f0 fs/fs-writeback.c:2246
 process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
 worker_thread+0x669/0x1090 kernel/workqueue.c:2436
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
