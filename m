Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2F96D7259
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 04:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236706AbjDECW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 22:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236683AbjDECWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 22:22:25 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38143C03
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 19:22:24 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id g7-20020a056602242700b00758e7dbd0dbso21817314iob.16
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 19:22:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680661344; x=1683253344;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BPlfqNJb0MuOXniXGOJCymczVPdMXSLBi1uLs3OhJHM=;
        b=nvttsPvluxvhpVYgHwpk+EnHR6KKABjM1XJCF6q9oBXJhWd3W5h1nSIKLiVUuFZ8I1
         /+rYcVsKIEK8FPsDcCGalAaKCr0xsEjbfZM0fyGS6wZad+BoeNBSobcekCP0f3LQ1IK3
         ostS8auGbNtRqP68S/fSTHCMTmTIZgt2uEuyP7FVhG5KEHvBrVSyXV3wdiWZpzgWN9Hc
         OPIR3wo1oRHy9qQnsZp0TQSnKmShhCHY/+LSsEiDSZRuChaQm6sauue5uf5yCOcfqOtj
         xgMW8QX+K0vJR1krsArDQusZrxfCsOoz30/dNQb5oIs8Qg8YPXb11tl39jMZFp4m43es
         N0VA==
X-Gm-Message-State: AAQBX9fXi2nkISC5U/VYDwoUiYdP1V+hAmhdsLgr3bJU70vsNo0szaQN
        EItWa6UUDMvW2SaEcpWNDQXRu8LcHHMLMQ+CW9f1+K8V15gN
X-Google-Smtp-Source: AKy350aN6RhvA2Pl9+qSEJuf/hNX0guh2EfiqAZuaEAPKxAPoMK0OUQQqndff6qcBySEZFYFHTY1rcll3M86FikcqN546AnfSfE4
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3708:b0:3ec:46d4:e15 with SMTP id
 k8-20020a056638370800b003ec46d40e15mr788946jav.3.1680661344032; Tue, 04 Apr
 2023 19:22:24 -0700 (PDT)
Date:   Tue, 04 Apr 2023 19:22:24 -0700
In-Reply-To: <20230405015423.732-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000661f3105f88d76ad@google.com>
Subject: Re: [syzbot] [kernfs?] WARNING in kernfs_remove_by_name_ns (3)
From:   syzbot <syzbot+93cbdd0ab421adc5275d@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in kernfs_remove_by_name_ns

R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffebd636f0f R14: 00007f02791c2300 R15: 0000000000022000
 </TASK>
kobject_add_internal failed for qgroups (error: -12 parent: 395ef67a-297e-477c-816d-cd80a5b93e5d)
------------[ cut here ]------------
kernfs: can not remove 'enabled', no directory
WARNING: CPU: 0 PID: 5606 at fs/kernfs/dir.c:1649 kernfs_remove_by_name_ns+0xf8/0x150 fs/kernfs/dir.c:1648
Modules linked in:
CPU: 0 PID: 5606 Comm: syz-executor.0 Not tainted 6.3.0-rc5-syzkaller-00022-g76f598ba7d8e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/30/2023
RIP: 0010:kernfs_remove_by_name_ns+0xf8/0x150 fs/kernfs/dir.c:1648
Code: ff 03 48 89 df e8 d8 ef ff ff 48 89 df e8 70 94 ff ff 31 db eb 27 e8 f7 84 72 ff 48 c7 c7 80 97 f9 8a 4c 89 e6 e8 58 9c 3a ff <0f> 0b bb fe ff ff ff eb 12 e8 da 84 72 ff bb fe ff ff ff 4c 89 f7
RSP: 0018:ffffc900052e7b00 EFLAGS: 00010246
RAX: 52e2f0e0665e4a00 RBX: ffffffff8d44b9a0 RCX: ffff888023018000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: dffffc0000000000 R08: ffffffff81527c82 R09: fffff52000a5ced9
R10: 0000000000000000 R11: dffffc0000000001 R12: ffffffff8b2a3960
R13: 0000000000000000 R14: ffffffff8b2a3900 R15: 0000000000000000
FS:  00007f02791c2700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbb3bcd1d94 CR3: 000000002a4f4000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 kernfs_remove_by_name include/linux/kernfs.h:618 [inline]
 remove_files fs/sysfs/group.c:28 [inline]
 sysfs_remove_group+0xfe/0x2a0 fs/sysfs/group.c:288
 sysfs_remove_groups+0x54/0xa0 fs/sysfs/group.c:312
 __kobject_del+0x84/0x310 lib/kobject.c:587
 kobject_del+0x45/0x60 lib/kobject.c:619
 btrfs_sysfs_del_qgroups+0x1cd/0x230 fs/btrfs/sysfs.c:2258
 btrfs_sysfs_add_qgroups+0x392/0x3c0 fs/btrfs/sysfs.c:2297
 btrfs_quota_enable+0x235/0x1f40 fs/btrfs/qgroup.c:991
 btrfs_ioctl_quota_ctl+0x141/0x180 fs/btrfs/ioctl.c:3682
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl+0xf1/0x160 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f027848c0f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f02791c2168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f02785abf80 RCX: 00007f027848c0f9
RDX: 0000000020000000 RSI: 00000000c0109428 RDI: 0000000000000004
RBP: 00007f02791c21d0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffebd636f0f R14: 00007f02791c2300 R15: 0000000000022000
 </TASK>


Tested on:

commit:         76f598ba Merge tag 'for-linus' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=114c8ba3c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d9a438ce47536f0c
dashboard link: https://syzkaller.appspot.com/bug?extid=93cbdd0ab421adc5275d
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
