Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E1A6F34E8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 19:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233507AbjEARLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 13:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbjEARJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 13:09:46 -0400
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A5530E6
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 10:06:15 -0700 (PDT)
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-7635a2dd490so391446739f.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 10:06:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682960706; x=1685552706;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LsTGMr+b06aWySt7vwx94agD1ZqSsCQJjB1y6g1Qy0A=;
        b=b5s/nwYjLOJa2abgnBaNRVGXCM+UWiaE2quOSw1a++PZnWqt3nPTdBk5l/9x08tFe0
         elfhx9MN4dpL1/2DQW1Blqx/jOTqqbEhOw4Fi0TVQIiOhADLxKKPoLdk5wwSU/8xk8zS
         5WluVxCDEdZh6jOgNyT03W4y39EO9SRqFcP877odpOLYsltVVGSryY1uInsEyKj8GW0D
         ya6VM0Zsq/ixK30WRuUeotbVi5UM1p1yORSfueHHO+McLC1sOnXpgV/lkSUY+9EAHCGe
         6MEr02lBh/SFIwVrFd3YDZqzZD/l00LTXS5HRtHu1Vyi0GHyMJmJiBVBHl9P6fkqn8dW
         0M1g==
X-Gm-Message-State: AC+VfDzHYtaBwJgh8c+a1NA/+xcfuUluN2PS1u1df3o13hSXU9PdOjkr
        Bjx4vpBp9L/r5KMXUp9vYfomi8INfLSakr4N9d+s53DqOioS
X-Google-Smtp-Source: ACHHUZ6lUoW8rG6obvY3JKL7jjOM6btcBE0aKUnbRWv/8Sn+UAORNua1QCYam+dnD4Y39suylbDImkTJ5tJXd8rDJ7PmxAmtyFT3
MIME-Version: 1.0
X-Received: by 2002:a6b:c41a:0:b0:745:70d7:4962 with SMTP id
 y26-20020a6bc41a000000b0074570d74962mr6593724ioa.0.1682960705960; Mon, 01 May
 2023 10:05:05 -0700 (PDT)
Date:   Mon, 01 May 2023 10:05:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000cd0fb05faa4d351@google.com>
Subject: [syzbot] [iommu?] WARNING in iommufd_test
From:   syzbot <syzbot+94646b0ed2dcbb1f9c2f@syzkaller.appspotmail.com>
To:     iommu@lists.linux.dev, jgg@ziepe.ca, joro@8bytes.org,
        kevin.tian@intel.com, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, syzkaller-bugs@googlegroups.com,
        will@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    58390c8ce1bd Merge tag 'iommu-updates-v6.4' of git://git.k..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=171c01f8280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d56ffc213bf6bf4a
dashboard link: https://syzkaller.appspot.com/bug?extid=94646b0ed2dcbb1f9c2f
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16310d5fc80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=168c5330280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/51c43e265c8a/disk-58390c8c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7c64f4eeaf4d/vmlinux-58390c8c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e5d8f49c4804/bzImage-58390c8c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+94646b0ed2dcbb1f9c2f@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5005 at drivers/iommu/iommufd/selftest.c:762 iommufd_test_check_pages drivers/iommu/iommufd/selftest.c:762 [inline]
WARNING: CPU: 1 PID: 5005 at drivers/iommu/iommufd/selftest.c:762 iommufd_test_access_pages drivers/iommu/iommufd/selftest.c:831 [inline]
WARNING: CPU: 1 PID: 5005 at drivers/iommu/iommufd/selftest.c:762 iommufd_test+0x1bed/0x2c20 drivers/iommu/iommufd/selftest.c:964
Modules linked in:
CPU: 1 PID: 5005 Comm: syz-executor411 Not tainted 6.3.0-syzkaller-12049-g58390c8ce1bd #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
RIP: 0010:iommufd_test_check_pages drivers/iommu/iommufd/selftest.c:762 [inline]
RIP: 0010:iommufd_test_access_pages drivers/iommu/iommufd/selftest.c:831 [inline]
RIP: 0010:iommufd_test+0x1bed/0x2c20 drivers/iommu/iommufd/selftest.c:964
Code: 48 85 db 0f 88 36 0a 00 00 e8 0f fb ed fc 48 89 de bf 01 00 00 00 e8 42 f7 ed fc 48 83 fb 01 0f 84 51 ff ff ff e8 f3 fa ed fc <0f> 0b 41 bf f2 ff ff ff e8 e6 fa ed fc e8 e1 fa ed fc 48 8b 54 24
RSP: 0018:ffffc9000398fcd8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff8880196f0000 RSI: ffffffff849662ad RDI: 0000000000000007
RBP: 0000000000000001 R08: 0000000000000007 R09: 0000000000000001
R10: 0000000000000000 R11: 1ffffffff21a07c8 R12: ffffffffffffff7b
R13: ffff888017a4b410 R14: 0000000000000001 R15: ffffc9000398fd68
FS:  00005555556bf300(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000061cca0 CR3: 0000000017fbd000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 iommufd_fops_ioctl+0x317/0x4b0 drivers/iommu/iommufd/main.c:337
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x197/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fadd8712d79
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff30e101f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fadd8712d79
RDX: 0000000020000280 RSI: 0000000000003ba0 RDI: 0000000000000004
RBP: 00007fadd86d6f20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fadd86d6fb0
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
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
