Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513AC5EE6BC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 22:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbiI1Unq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 16:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbiI1Unl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 16:43:41 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB888E4E8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 13:43:40 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id q3-20020a056e0220e300b002f5e648e02eso10714762ilv.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 13:43:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=FuXKMlB5OX/96Z6N3Q9p1maC+BV63ZSr5g9kcKaYejU=;
        b=7s4qQ5UQ8yrvs7W5Xu3VVnOsvb1vyACKsImTVaj3AGG5ET9/UAaiaTvJ14q0BVXp41
         n/vIpI9Q5f0ty2w6QjdvM/j6r3UXr2DqyxqqLeeWKyJOpQScjRVIud+ICBll7xC+is61
         bwyqIxATYdb7blXYnGTFHBS+83EGqjcmVEHf5yjh23yZKvb2vYbp0lE72QJBf6do09m5
         jOaJQ1+acjC2O+I0cuspCyDRFiQFkHPRbDMKPdoqEYyFincqxrxQwkDcDQNGVh3MW9oe
         LMw2AkrCENlJ2oPhoSb3v5mGW3+/lx3CEATivcNjA5roYnhVqO2XJTzmgRISG/1N4LK/
         jtCg==
X-Gm-Message-State: ACrzQf13B10lWUwytQAGaIFXTMW6emv1Pa0E75oZu88sjDYF89Yw883G
        Nvyx3jnOuLfys3jRP2+bF+8V/hStaBZbeGNw6Yq14USAYyqa
X-Google-Smtp-Source: AMsMyM7vDaGN3zSVcbC5DzElDYtWjLvSsww5oi/kuvcDb336ZuFLFCLFir8kHSvSmhnLAtIT78VhRwYLmPg+v6g8FCRjvQnmtDzQ
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:184c:b0:2f1:6961:bcd0 with SMTP id
 b12-20020a056e02184c00b002f16961bcd0mr16120288ilv.168.1664397819435; Wed, 28
 Sep 2022 13:43:39 -0700 (PDT)
Date:   Wed, 28 Sep 2022 13:43:39 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cadfcb05e9c2d04b@google.com>
Subject: [syzbot] KMSAN: kernel-infoleak in vmci_host_unlocked_ioctl (2)
From:   syzbot <syzbot+39be4da489ed2493ba25@syzkaller.appspotmail.com>
To:     arnd@arndb.de, bryantan@vmware.com, glider@google.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        pv-drivers@vmware.com, rjalisatgi@vmware.com,
        syzkaller-bugs@googlegroups.com, vdasa@vmware.com
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

HEAD commit:    466a27efa4f0 x86: kmsan: handle CPU entry area
git tree:       https://github.com/google/kmsan.git master
console+strace: https://syzkaller.appspot.com/x/log.txt?x=144595ef080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=121c7ef28ec597bd
dashboard link: https://syzkaller.appspot.com/bug?extid=39be4da489ed2493ba25
compiler:       clang version 15.0.0 (https://github.com/llvm/llvm-project.git 610139d2d9ce6746b3c617fb3e2f7886272d26ff), GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10afe26c880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=108e0950880000

Downloadable assets:
disk image: https://storage.googleapis.com/757beb3f2001/disk-466a27ef.raw.xz
vmlinux: https://storage.googleapis.com/1219d90ba613/vmlinux-466a27ef.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+39be4da489ed2493ba25@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: kernel-infoleak in instrument_copy_to_user include/linux/instrumented.h:121 [inline]
BUG: KMSAN: kernel-infoleak in _copy_to_user+0xbc/0x100 lib/usercopy.c:33
 instrument_copy_to_user include/linux/instrumented.h:121 [inline]
 _copy_to_user+0xbc/0x100 lib/usercopy.c:33
 copy_to_user include/linux/uaccess.h:169 [inline]
 vmci_host_do_receive_datagram drivers/misc/vmw_vmci/vmci_host.c:431 [inline]
 vmci_host_unlocked_ioctl+0x1cd3/0x5480 drivers/misc/vmw_vmci/vmci_host.c:925
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl+0x222/0x400 fs/ioctl.c:856
 __x64_sys_ioctl+0x92/0xd0 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Uninit was stored to memory at:
 kmemdup+0x89/0xd0 mm/util.c:131
 dg_dispatch_as_host drivers/misc/vmw_vmci/vmci_datagram.c:271 [inline]
 vmci_datagram_dispatch+0x4ee/0x13f0 drivers/misc/vmw_vmci/vmci_datagram.c:339
 qp_notify_peer+0x1fe/0x310 drivers/misc/vmw_vmci/vmci_queue_pair.c:1479
 qp_broker_attach drivers/misc/vmw_vmci/vmci_queue_pair.c:1662 [inline]
 qp_broker_alloc+0x3370/0x3850 drivers/misc/vmw_vmci/vmci_queue_pair.c:1750
 vmci_qp_broker_alloc+0xdf/0x120 drivers/misc/vmw_vmci/vmci_queue_pair.c:1940
 vmci_host_do_alloc_queuepair drivers/misc/vmw_vmci/vmci_host.c:488 [inline]
 vmci_host_unlocked_ioctl+0x3305/0x5480 drivers/misc/vmw_vmci/vmci_host.c:927
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl+0x222/0x400 fs/ioctl.c:856
 __x64_sys_ioctl+0x92/0xd0 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Local variable ev created at:
 qp_notify_peer+0x5a/0x310 drivers/misc/vmw_vmci/vmci_queue_pair.c:1456
 qp_broker_attach drivers/misc/vmw_vmci/vmci_queue_pair.c:1662 [inline]
 qp_broker_alloc+0x3370/0x3850 drivers/misc/vmw_vmci/vmci_queue_pair.c:1750

Bytes 28-31 of 48 are uninitialized
Memory access of size 48 starts at ffff88811768de80
Data copied to user address 0000000020000100

CPU: 0 PID: 3489 Comm: syz-executor851 Not tainted 6.0.0-rc5-syzkaller-48540-g466a27efa4f0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
