Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C67786D2DF9
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 05:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbjDADhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 23:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbjDADhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 23:37:13 -0400
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226C183F7
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 20:36:54 -0700 (PDT)
Received: by mail-il1-f205.google.com with SMTP id l10-20020a056e0205ca00b00322fdda7261so15427240ils.6
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 20:36:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680320213; x=1682912213;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hwOffVYvisJdV2o5GWhDpDI8kgqhn1tf7ofiQZHvtvs=;
        b=nxByy5SPrzhgPMYx/UwI38dlX74AvQBHdnarUdsarTns8rOx7BBC/lvNriUfZJnhoK
         yFv578HlYym6OvDYXKyzDSQ+a53/9/W5Lq+iPsGk60nD+PQMYCfJEdjcS3/J94t4oBjI
         we5wKqGONi29lqG4cmBb5cFaBuzpkeuMp2jX7UdULi+EziKTq++ME/zHv1+SBEWWg+FO
         sx9AGFlVhR+CMdWOftRI6kR2nKiMOWLOj6LtetYscoOEuNCEstlfZtA0CyDxHoZa7vzj
         +d4nDrAGWKYmItDAWDeJsiQkAP34Itul+F0fm9oCpdhMZ1eFVV9AXXkHZXHl9CoQcxdh
         Khkg==
X-Gm-Message-State: AAQBX9fBXCU3xamnIPxGjx9uHoz1gwWcls2RxqHKi4zzeLEnI/PesSD8
        E2fIAQyz3uV3xrKhVFIguGhLfGETaoKiFF6W9WofFPN6FcLR
X-Google-Smtp-Source: AKy350YNU4INQYRerQ4SAMHbfPVmSpn+4PFSXOtC3QFQju8X6kMwNC1FmOUNLmpgZCBd6ccSDjlhDWYB9Cb9n6RlCjuAjrW73aUN
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4392:b0:40b:2922:8a14 with SMTP id
 bo18-20020a056638439200b0040b29228a14mr615346jab.0.1680320213440; Fri, 31 Mar
 2023 20:36:53 -0700 (PDT)
Date:   Fri, 31 Mar 2023 20:36:53 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006e66d605f83e09bc@google.com>
Subject: [syzbot] [iommu?] WARNING in iommufd_hw_pagetable_detach
From:   syzbot <syzbot+3b81771e32dd5b2f9931@syzkaller.appspotmail.com>
To:     baolu.lu@linux.intel.com, iommu@lists.linux.dev, jgg@nvidia.com,
        jgg@ziepe.ca, joro@8bytes.org, kevin.tian@intel.com,
        linux-kernel@vger.kernel.org, nicolinc@nvidia.com,
        robin.murphy@arm.com, syzkaller-bugs@googlegroups.com,
        will@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.1 required=5.0 tests=FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    4b0f4525dc4f Add linux-next specific files for 20230331
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1540ac7dc80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=85cc4b935a1f7194
dashboard link: https://syzkaller.appspot.com/bug?extid=3b81771e32dd5b2f9931
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12120eb9c80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10ec200dc80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8d06bb015df3/disk-4b0f4525.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6a1c1ebf3724/vmlinux-4b0f4525.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4bb2b8d6cd7d/bzImage-4b0f4525.xz

The issue was bisected to:

commit 9d05029acd4e4c0a85e412bf955dfc5526b9a6c1
Author: Jason Gunthorpe <jgg@nvidia.com>
Date:   Mon Mar 27 18:37:57 2023 +0000

    iommufd: Replace the hwpt->devices list with iommufd_group

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13dbbb71c80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=103bbb71c80000
console output: https://syzkaller.appspot.com/x/log.txt?x=17dbbb71c80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3b81771e32dd5b2f9931@syzkaller.appspotmail.com
Fixes: 9d05029acd4e ("iommufd: Replace the hwpt->devices list with iommufd_group")

iommufd_mock iommufd_mock0: Adding to iommu group 0
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5081 at drivers/iommu/iommufd/device.c:344 iommufd_hw_pagetable_detach+0x2cb/0x480 drivers/iommu/iommufd/device.c:344
Modules linked in:
CPU: 0 PID: 5081 Comm: syz-executor226 Not tainted 6.3.0-rc4-next-20230331-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
RIP: 0010:iommufd_hw_pagetable_detach+0x2cb/0x480 drivers/iommu/iommufd/device.c:344
Code: f2 fc 49 8d 7d 70 be ff ff ff ff e8 cf 2f 76 05 31 ff 41 89 c5 89 c6 e8 63 6d f2 fc 45 85 ed 0f 85 ee fd ff ff e8 35 71 f2 fc <0f> 0b e9 e2 fd ff ff e8 29 71 f2 fc 49 8d bd a0 00 00 00 48 b8 00
RSP: 0018:ffffc90003b0fb30 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88801676da00 RCX: 0000000000000000
RDX: ffff8880279c8000 RSI: ffffffff8490a01b RDI: 0000000000000005
RBP: ffff88801676dab0 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff88801676dc00
R13: 0000000000000000 R14: 0000000000000001 R15: ffff88801676dcc0
FS:  0000555555fa9300(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000188 CR3: 000000002ba93000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 iommufd_hw_pagetable_alloc+0x646/0x800 drivers/iommu/iommufd/hw_pagetable.c:114
 iommufd_device_auto_get_domain drivers/iommu/iommufd/device.c:500 [inline]
 iommufd_device_change_pt+0x570/0xb30 drivers/iommu/iommufd/device.c:553
 iommufd_device_attach+0x27/0xd0 drivers/iommu/iommufd/device.c:591
 iommufd_test_mock_domain drivers/iommu/iommufd/selftest.c:439 [inline]
 iommufd_test+0x81c/0x2ef0 drivers/iommu/iommufd/selftest.c:987
 iommufd_fops_ioctl+0x317/0x4b0 drivers/iommu/iommufd/main.c:351
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x197/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f6a1d59bc89
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe55301508 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f6a1d59bc89
RDX: 00000000200000c0 RSI: 0000000000003ba0 RDI: 0000000000000003
RBP: 00007f6a1d55fe30 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f6a1d55fec0
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
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
