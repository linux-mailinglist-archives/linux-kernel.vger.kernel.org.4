Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8475BBD68
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 12:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiIRKYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 06:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiIRKYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 06:24:19 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C0E167F4
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 03:24:16 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id d6-20020a056e020be600b002dcc7977592so17363246ilu.17
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 03:24:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Zi/if1Z/uiBRAE46Fu4c7TXoJHQDRNoavB19umOUukg=;
        b=Ha5ECWJdqveGovaZWIV4YdscsZM7EN7KZcdLXdsds06NAy6taAc/Ekr+GGqGROw5ML
         1JdSmSjmCYTDdDlA1lXWOm/C+OAiYq0zdIx10EuoYObE8b9JbsJcojJU5v39USuF5Dik
         JnxdPcYxP4sLgLkwq45EUbkmRFOwCl8chWZ8WekEZLa39Gpo/5nLc31sOIrE752lodA/
         hotpdJ3TMPAJUYkGQ9UzqHPp3S7TzCzl+3fdSNK1J7sexy04ZZK8aEcW9fewGxTAgcDS
         1+gSw6InPAzMzT3cqt7Ok7LvoMl1lKqX/lIrrQevWVwf0XHDQDVKBoF6DqIz7P41xpOJ
         3/QQ==
X-Gm-Message-State: ACrzQf2pzcGHLcmtrFdsCNtLrtQIcqjcO3A5i0w0KZi++aeL8/wwiNWB
        JSYKzg+kmGVoWg+lcNyEBZCwbWvGwzbpxsNg0mZ6g0WJHWZi
X-Google-Smtp-Source: AMsMyM5Q2Ses7UVsQsK3yO3bzv1MWjxURoEqO+rAbO/gwJFoBjZ4tqQk2TkcaLiDHJ872SfEhdz5GQ1w89UCK8cbj7xj89VuVatU
MIME-Version: 1.0
X-Received: by 2002:a6b:d80b:0:b0:6a0:d510:9d81 with SMTP id
 y11-20020a6bd80b000000b006a0d5109d81mr5142548iob.16.1663496656003; Sun, 18
 Sep 2022 03:24:16 -0700 (PDT)
Date:   Sun, 18 Sep 2022 03:24:15 -0700
In-Reply-To: <20220918094405.890-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004428d505e8f0ffe4@google.com>
Subject: Re: [syzbot] BUG: soft lockup in tx
From:   syzbot <syzbot+5e87db90e68fbc4707c6@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in handle_tx

ieee802154 phy0 wpan0: encryption failed: -22
ieee802154 phy1 wpan1: encryption failed: -22
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1377 at drivers/net/caif/caif_serial.c:225 handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
Modules linked in:
CPU: 0 PID: 1377 Comm: aoe_tx0 Not tainted 6.0.0-rc4-syzkaller-00071-ga6b443748715-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
lr : handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
sp : ffff80001477bc10
x29: ffff80001477bc10 x28: ffff80000f103000 x27: ffff80000d2bb000
x26: 0000000000000000 x25: 0000000000000fff x24: 00000000ffffbc03
x23: ffff0000cf09c200 x22: 00000000ffffbc02 x21: ffff0000cf296cb0
x20: ffff0000cf23e800 x19: ffff0000cf296c80 x18: 00000000000000c0
x17: ffff80000dd3a698 x16: ffff80000db78658 x15: ffff0000c6271a80
x14: 0000000000000028 x13: 00000000ffffffff x12: ffff0000c6271a80
x11: ff80800009e7d314 x10: 0000000000000000 x9 : ffff800009e7d314
x8 : ffff0000c6271a80 x7 : ffff8000098f58f0 x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000002 x1 : 00000000ffffbc02 x0 : 00000000ffffbc03
Call trace:
 handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
 caif_xmit+0xa4/0xe0 drivers/net/caif/caif_serial.c:285
 __netdev_start_xmit include/linux/netdevice.h:4819 [inline]
 netdev_start_xmit include/linux/netdevice.h:4833 [inline]
 xmit_one net/core/dev.c:3590 [inline]
 dev_hard_start_xmit+0xd4/0x1ec net/core/dev.c:3606
 __dev_queue_xmit+0x78c/0xc88 net/core/dev.c:4256
 dev_queue_xmit include/linux/netdevice.h:3008 [inline]
 tx+0x74/0x118 drivers/block/aoe/aoenet.c:63
 kthread+0x90/0x154 kernel/kthread.c:357
 kthread+0x12c/0x158 kernel/kthread.c:376
 ret_from_fork+0x10/0x20
irq event stamp: 43337
hardirqs last  enabled at (43336): [<ffff80000bfc5e38>] __exit_to_kernel_mode arch/arm64/kernel/entry-common.c:84 [inline]
hardirqs last  enabled at (43336): [<ffff80000bfc5e38>] exit_to_kernel_mode+0xe8/0x118 arch/arm64/kernel/entry-common.c:94
hardirqs last disabled at (43337): [<ffff80000bfc3cc4>] el1_dbg+0x24/0x5c arch/arm64/kernel/entry-common.c:395
softirqs last  enabled at (1392): [<ffff80000b207b84>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (1396): [<ffff80000b207b50>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1377 at drivers/net/caif/caif_serial.c:225 handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
Modules linked in:
CPU: 0 PID: 1377 Comm: aoe_tx0 Tainted: G        W          6.0.0-rc4-syzkaller-00071-ga6b443748715-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
lr : handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
sp : ffff80001477bc10
x29: ffff80001477bc10 x28: ffff80000f103000 x27: ffff80000d2bb000
x26: 0000000000000000 x25: 0000000000000fff x24: 00000000ffffbc08
x23: ffff0000cf09c200 x22: 00000000ffffbc02 x21: ffff0000cf296cb0
x20: ffff0000cf23e800 x19: ffff0000cf296c80 x18: 00000000000000c0
x17: ffff80000dd3a698 x16: ffff80000db78658 x15: ffff0000c6271a80
x14: 0000000000000028 x13: 00000000ffffffff x12: ffff0000c6271a80
x11: ff80800009e7d314 x10: 0000000000000000 x9 : ffff800009e7d314
x8 : ffff0000c6271a80 x7 : ffff8000098f58f0 x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000002 x1 : 00000000ffffbc02 x0 : 00000000ffffbc08
Call trace:
 handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
 caif_xmit+0xa4/0xe0 drivers/net/caif/caif_serial.c:285
 __netdev_start_xmit include/linux/netdevice.h:4819 [inline]
 netdev_start_xmit include/linux/netdevice.h:4833 [inline]
 xmit_one net/core/dev.c:3590 [inline]
 dev_hard_start_xmit+0xd4/0x1ec net/core/dev.c:3606
 __dev_queue_xmit+0x78c/0xc88 net/core/dev.c:4256
 dev_queue_xmit include/linux/netdevice.h:3008 [inline]
 tx+0x74/0x118 drivers/block/aoe/aoenet.c:63
 kthread+0x90/0x154 kernel/kthread.c:357
 kthread+0x12c/0x158 kernel/kthread.c:376
 ret_from_fork+0x10/0x20
irq event stamp: 43345
hardirqs last  enabled at (43344): [<ffff80000bfd660c>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (43344): [<ffff80000bfd660c>] _raw_spin_unlock_irqrestore+0x48/0x8c kernel/locking/spinlock.c:194
hardirqs last disabled at (43345): [<ffff80000bfc3cc4>] el1_dbg+0x24/0x5c arch/arm64/kernel/entry-common.c:395
softirqs last  enabled at (1392): [<ffff80000b207b84>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (1396): [<ffff80000b207b50>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1377 at drivers/net/caif/caif_serial.c:225 handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
Modules linked in:
CPU: 0 PID: 1377 Comm: aoe_tx0 Tainted: G        W          6.0.0-rc4-syzkaller-00071-ga6b443748715-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
lr : handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
sp : ffff80001477bc10
x29: ffff80001477bc10 x28: ffff80000f103000 x27: ffff80000d2bb000
x26: 0000000000000000 x25: 0000000000000fff x24: 00000000ffffbc0e
x23: ffff0000cf09c200 x22: 00000000ffffbc02 x21: ffff0000cf296cb0
x20: ffff0000cf23e800 x19: ffff0000cf296c80 x18: 00000000000000c0
x17: ffff80000dd3a698 x16: ffff80000db78658 x15: ffff0000c6271a80
x14: 0000000000000028 x13: 00000000ffffffff x12: ffff0000c6271a80
x11: ff80800009e7d314 x10: 0000000000000000 x9 : ffff800009e7d314
x8 : ffff0000c6271a80 x7 : ffff8000098f58f0 x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000002 x1 : 00000000ffffbc02 x0 : 00000000ffffbc0e
Call trace:
 handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
 caif_xmit+0xa4/0xe0 drivers/net/caif/caif_serial.c:285
 __netdev_start_xmit include/linux/netdevice.h:4819 [inline]
 netdev_start_xmit include/linux/netdevice.h:4833 [inline]
 xmit_one net/core/dev.c:3590 [inline]
 dev_hard_start_xmit+0xd4/0x1ec net/core/dev.c:3606
 __dev_queue_xmit+0x78c/0xc88 net/core/dev.c:4256
 dev_queue_xmit include/linux/netdevice.h:3008 [inline]
 tx+0x74/0x118 drivers/block/aoe/aoenet.c:63
 kthread+0x90/0x154 kernel/kthread.c:357
 kthread+0x12c/0x158 kernel/kthread.c:376
 ret_from_fork+0x10/0x20
irq event stamp: 43353
hardirqs last  enabled at (43352): [<ffff80000bfd660c>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (43352): [<ffff80000bfd660c>] _raw_spin_unlock_irqrestore+0x48/0x8c kernel/locking/spinlock.c:194
hardirqs last disabled at (43353): [<ffff80000bfc3cc4>] el1_dbg+0x24/0x5c arch/arm64/kernel/entry-common.c:395
softirqs last  enabled at (1392): [<ffff80000b207b84>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (1396): [<ffff80000b207b50>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1377 at drivers/net/caif/caif_serial.c:225 handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
Modules linked in:
CPU: 0 PID: 1377 Comm: aoe_tx0 Tainted: G        W          6.0.0-rc4-syzkaller-00071-ga6b443748715-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
lr : handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
sp : ffff80001477bc10
x29: ffff80001477bc10 x28: ffff80000f103000 x27: ffff80000d2bb000
x26: 0000000000000000 x25: 0000000000000fff x24: 00000000ffffbc13
x23: ffff0000cf09c200 x22: 00000000ffffbc02 x21: ffff0000cf296cb0
x20: ffff0000cf23e800 x19: ffff0000cf296c80 x18: 00000000000000c0
x17: ffff80000dd3a698 x16: ffff80000db78658 x15: ffff0000c6271a80
x14: 0000000000000028 x13: 00000000ffffffff x12: ffff0000c6271a80
x11: ff80800009e7d314 x10: 0000000000000000 x9 : ffff800009e7d314
x8 : ffff0000c6271a80 x7 : ffff8000098f58f0 x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000002 x1 : 00000000ffffbc02 x0 : 00000000ffffbc13
Call trace:
 handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
 caif_xmit+0xa4/0xe0 drivers/net/caif/caif_serial.c:285
 __netdev_start_xmit include/linux/netdevice.h:4819 [inline]
 netdev_start_xmit include/linux/netdevice.h:4833 [inline]
 xmit_one net/core/dev.c:3590 [inline]
 dev_hard_start_xmit+0xd4/0x1ec net/core/dev.c:3606
 __dev_queue_xmit+0x78c/0xc88 net/core/dev.c:4256
 dev_queue_xmit include/linux/netdevice.h:3008 [inline]
 tx+0x74/0x118 drivers/block/aoe/aoenet.c:63
 kthread+0x90/0x154 kernel/kthread.c:357
 kthread+0x12c/0x158 kernel/kthread.c:376
 ret_from_fork+0x10/0x20
irq event stamp: 43361
hardirqs last  enabled at (43360): [<ffff80000bfd660c>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (43360): [<ffff80000bfd660c>] _raw_spin_unlock_irqrestore+0x48/0x8c kernel/locking/spinlock.c:194
hardirqs last disabled at (43361): [<ffff80000bfc3cc4>] el1_dbg+0x24/0x5c arch/arm64/kernel/entry-common.c:395
softirqs last  enabled at (1392): [<ffff80000b207b84>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (1396): [<ffff80000b207b50>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1377 at drivers/net/caif/caif_serial.c:225 handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
Modules linked in:
CPU: 0 PID: 1377 Comm: aoe_tx0 Tainted: G        W          6.0.0-rc4-syzkaller-00071-ga6b443748715-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
lr : handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
sp : ffff80001477bc10
x29: ffff80001477bc10 x28: ffff80000f103000 x27: ffff80000d2bb000
x26: 0000000000000000 x25: 0000000000000fff x24: 00000000ffffbc19
x23: ffff0000cf09c200 x22: 00000000ffffbc02 x21: ffff0000cf296cb0
x20: ffff0000cf23e800 x19: ffff0000cf296c80 x18: 00000000000000c0
x17: ffff80000dd3a698 x16: ffff80000db78658 x15: ffff0000c6271a80
x14: 0000000000000028 x13: 00000000ffffffff x12: ffff0000c6271a80
x11: ff80800009e7d314 x10: 0000000000000000 x9 : ffff800009e7d314
x8 : ffff0000c6271a80 x7 : ffff8000098f58f0 x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000002 x1 : 00000000ffffbc02 x0 : 00000000ffffbc19
Call trace:
 handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
 caif_xmit+0xa4/0xe0 drivers/net/caif/caif_serial.c:285
 __netdev_start_xmit include/linux/netdevice.h:4819 [inline]
 netdev_start_xmit include/linux/netdevice.h:4833 [inline]
 xmit_one net/core/dev.c:3590 [inline]
 dev_hard_start_xmit+0xd4/0x1ec net/core/dev.c:3606
 __dev_queue_xmit+0x78c/0xc88 net/core/dev.c:4256
 dev_queue_xmit include/linux/netdevice.h:3008 [inline]
 tx+0x74/0x118 drivers/block/aoe/aoenet.c:63
 kthread+0x90/0x154 kernel/kthread.c:357
 kthread+0x12c/0x158 kernel/kthread.c:376
 ret_from_fork+0x10/0x20
irq event stamp: 43369
hardirqs last  enabled at (43368): [<ffff80000bfd660c>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (43368): [<ffff80000bfd660c>] _raw_spin_unlock_irqrestore+0x48/0x8c kernel/locking/spinlock.c:194
hardirqs last disabled at (43369): [<ffff80000bfc3cc4>] el1_dbg+0x24/0x5c arch/arm64/kernel/entry-common.c:395
softirqs last  enabled at (1392): [<ffff80000b207b84>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (1396): [<ffff80000b207b50>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1377 at drivers/net/caif/caif_serial.c:225 handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
Modules linked in:
CPU: 0 PID: 1377 Comm: aoe_tx0 Tainted: G        W          6.0.0-rc4-syzkaller-00071-ga6b443748715-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
lr : handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
sp : ffff80001477bc10
x29: ffff80001477bc10 x28: ffff80000f103000 x27: ffff80000d2bb000
x26: 0000000000000000 x25: 0000000000000fff x24: 00000000ffffbc1e
x23: ffff0000cf09c200 x22: 00000000ffffbc02 x21: ffff0000cf296cb0
x20: ffff0000cf23e800 x19: ffff0000cf296c80 x18: 00000000000000c0
x17: ffff80000dd3a698 x16: ffff80000db78658 x15: ffff0000c6271a80
x14: 0000000000000028 x13: 00000000ffffffff x12: ffff0000c6271a80
x11: ff80800009e7d314 x10: 0000000000000000 x9 : ffff800009e7d314
x8 : ffff0000c6271a80 x7 : ffff8000098f58f0 x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000002 x1 : 00000000ffffbc02 x0 : 00000000ffffbc1e
Call trace:
 handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
 caif_xmit+0xa4/0xe0 drivers/net/caif/caif_serial.c:285
 __netdev_start_xmit include/linux/netdevice.h:4819 [inline]
 netdev_start_xmit include/linux/netdevice.h:4833 [inline]
 xmit_one net/core/dev.c:3590 [inline]
 dev_hard_start_xmit+0xd4/0x1ec net/core/dev.c:3606
 __dev_queue_xmit+0x78c/0xc88 net/core/dev.c:4256
 dev_queue_xmit include/linux/netdevice.h:3008 [inline]
 tx+0x74/0x118 drivers/block/aoe/aoenet.c:63
 kthread+0x90/0x154 kernel/kthread.c:357
 kthread+0x12c/0x158 kernel/kthread.c:376
 ret_from_fork+0x10/0x20
irq event stamp: 43377
hardirqs last  enabled at (43376): [<ffff80000bfd660c>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (43376): [<ffff80000bfd660c>] _raw_spin_unlock_irqrestore+0x48/0x8c kernel/locking/spinlock.c:194
hardirqs last disabled at (43377): [<ffff80000bfc3cc4>] el1_dbg+0x24/0x5c arch/arm64/kernel/entry-common.c:395
softirqs last  enabled at (1392): [<ffff80000b207b84>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (1396): [<ffff80000b207b50>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1377 at drivers/net/caif/caif_serial.c:225 handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
Modules linked in:
CPU: 0 PID: 1377 Comm: aoe_tx0 Tainted: G        W          6.0.0-rc4-syzkaller-00071-ga6b443748715-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
lr : handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
sp : ffff80001477bc10
x29: ffff80001477bc10 x28: ffff80000f103000 x27: ffff80000d2bb000
x26: 0000000000000000 x25: 0000000000000fff x24: 00000000ffffbc24
x23: ffff0000cf09c200 x22: 00000000ffffbc02 x21: ffff0000cf296cb0
x20: ffff0000cf23e800 x19: ffff0000cf296c80 x18: 00000000000000c0
x17: ffff80000dd3a698 x16: ffff80000db78658 x15: ffff0000c6271a80
x14: 0000000000000028 x13: 00000000ffffffff x12: ffff0000c6271a80
x11: ff80800009e7d314 x10: 0000000000000000 x9 : ffff800009e7d314
x8 : ffff0000c6271a80 x7 : ffff8000098f58f0 x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000002 x1 : 00000000ffffbc02 x0 : 00000000ffffbc24
Call trace:
 handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
 caif_xmit+0xa4/0xe0 drivers/net/caif/caif_serial.c:285
 __netdev_start_xmit include/linux/netdevice.h:4819 [inline]
 netdev_start_xmit include/linux/netdevice.h:4833 [inline]
 xmit_one net/core/dev.c:3590 [inline]
 dev_hard_start_xmit+0xd4/0x1ec net/core/dev.c:3606
 __dev_queue_xmit+0x78c/0xc88 net/core/dev.c:4256
 dev_queue_xmit include/linux/netdevice.h:3008 [inline]
 tx+0x74/0x118 drivers/block/aoe/aoenet.c:63
 kthread+0x90/0x154 kernel/kthread.c:357
 kthread+0x12c/0x158 kernel/kthread.c:376
 ret_from_fork+0x10/0x20
irq event stamp: 43385
hardirqs last  enabled at (43384): [<ffff80000bfd660c>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (43384): [<ffff80000bfd660c>] _raw_spin_unlock_irqrestore+0x48/0x8c kernel/locking/spinlock.c:194
hardirqs last disabled at (43385): [<ffff80000bfc3cc4>] el1_dbg+0x24/0x5c arch/arm64/kernel/entry-common.c:395
softirqs last  enabled at (1392): [<ffff80000b207b84>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (1396): [<ffff80000b207b50>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1377 at drivers/net/caif/caif_serial.c:225 handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
Modules linked in:
CPU: 0 PID: 1377 Comm: aoe_tx0 Tainted: G        W          6.0.0-rc4-syzkaller-00071-ga6b443748715-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
lr : handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
sp : ffff80001477bc10
x29: ffff80001477bc10 x28: ffff80000f103000 x27: ffff80000d2bb000
x26: 0000000000000000 x25: 0000000000000fff x24: 00000000ffffbc29
x23: ffff0000cf09c200 x22: 00000000ffffbc02 x21: ffff0000cf296cb0
x20: ffff0000cf23e800 x19: ffff0000cf296c80 x18: 00000000000000c0
x17: ffff80000dd3a698 x16: ffff80000db78658 x15: ffff0000c6271a80
x14: 0000000000000028 x13: 00000000ffffffff x12: ffff0000c6271a80
x11: ff80800009e7d314 x10: 0000000000000000 x9 : ffff800009e7d314
x8 : ffff0000c6271a80 x7 : ffff8000098f58f0 x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000002 x1 : 00000000ffffbc02 x0 : 00000000ffffbc29
Call trace:
 handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
 caif_xmit+0xa4/0xe0 drivers/net/caif/caif_serial.c:285
 __netdev_start_xmit include/linux/netdevice.h:4819 [inline]
 netdev_start_xmit include/linux/netdevice.h:4833 [inline]
 xmit_one net/core/dev.c:3590 [inline]
 dev_hard_start_xmit+0xd4/0x1ec net/core/dev.c:3606
 __dev_queue_xmit+0x78c/0xc88 net/core/dev.c:4256
 dev_queue_xmit include/linux/netdevice.h:3008 [inline]
 tx+0x74/0x118 drivers/block/aoe/aoenet.c:63
 kthread+0x90/0x154 kernel/kthread.c:357
 kthread+0x12c/0x158 kernel/kthread.c:376
 ret_from_fork+0x10/0x20
irq event stamp: 43393
hardirqs last  enabled at (43392): [<ffff80000bfd660c>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (43392): [<ffff80000bfd660c>] _raw_spin_unlock_irqrestore+0x48/0x8c kernel/locking/spinlock.c:194
hardirqs last disabled at (43393): [<ffff80000bfc3cc4>] el1_dbg+0x24/0x5c arch/arm64/kernel/entry-common.c:395
softirqs last  enabled at (1392): [<ffff80000b207b84>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (1396): [<ffff80000b207b50>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1377 at drivers/net/caif/caif_serial.c:225 handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
Modules linked in:
CPU: 0 PID: 1377 Comm: aoe_tx0 Tainted: G        W          6.0.0-rc4-syzkaller-00071-ga6b443748715-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
lr : handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
sp : ffff80001477bc10
x29: ffff80001477bc10 x28: ffff80000f103000 x27: ffff80000d2bb000
x26: 0000000000000000 x25: 0000000000000fff x24: 00000000ffffbc2f
x23: ffff0000cf09c200 x22: 00000000ffffbc02 x21: ffff0000cf296cb0
x20: ffff0000cf23e800 x19: ffff0000cf296c80 x18: 00000000000000c0
x17: ffff80000dd3a698 x16: ffff80000db78658 x15: ffff0000c6271a80
x14: 0000000000000028 x13: 00000000ffffffff x12: ffff0000c6271a80
x11: ff80800009e7d314 x10: 0000000000000000 x9 : ffff800009e7d314
x8 : ffff0000c6271a80 x7 : ffff8000098f58f0 x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000002 x1 : 00000000ffffbc02 x0 : 00000000ffffbc2f
Call trace:
 handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
 caif_xmit+0xa4/0xe0 drivers/net/caif/caif_serial.c:285
 __netdev_start_xmit include/linux/netdevice.h:4819 [inline]
 netdev_start_xmit include/linux/netdevice.h:4833 [inline]
 xmit_one net/core/dev.c:3590 [inline]
 dev_hard_start_xmit+0xd4/0x1ec net/core/dev.c:3606
 __dev_queue_xmit+0x78c/0xc88 net/core/dev.c:4256
 dev_queue_xmit include/linux/netdevice.h:3008 [inline]
 tx+0x74/0x118 drivers/block/aoe/aoenet.c:63
 kthread+0x90/0x154 kernel/kthread.c:357
 kthread+0x12c/0x158 kernel/kthread.c:376
 ret_from_fork+0x10/0x20
irq event stamp: 43401
hardirqs last  enabled at (43400): [<ffff80000bfd660c>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (43400): [<ffff80000bfd660c>] _raw_spin_unlock_irqrestore+0x48/0x8c kernel/locking/spinlock.c:194
hardirqs last disabled at (43401): [<ffff80000bfc3cc4>] el1_dbg+0x24/0x5c arch/arm64/kernel/entry-common.c:395
softirqs last  enabled at (1392): [<ffff80000b207b84>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (1396): [<ffff80000b207b50>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1377 at drivers/net/caif/caif_serial.c:225 handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
Modules linked in:
CPU: 0 PID: 1377 Comm: aoe_tx0 Tainted: G        W          6.0.0-rc4-syzkaller-00071-ga6b443748715-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
lr : handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
sp : ffff80001477bc10
x29: ffff80001477bc10 x28: ffff80000f103000 x27: ffff80000d2bb000
x26: 0000000000000000 x25: 0000000000000fff x24: 00000000ffffbc34
x23: ffff0000cf09c200 x22: 00000000ffffbc02 x21: ffff0000cf296cb0
x20: ffff0000cf23e800 x19: ffff0000cf296c80 x18: 00000000000000c0
x17: ffff80000dd3a698 x16: ffff80000db78658 x15: ffff0000c6271a80
x14: 0000000000000028 x13: 00000000ffffffff x12: ffff0000c6271a80
x11: ff80800009e7d314 x10: 0000000000000000 x9 : ffff800009e7d314
x8 : ffff0000c6271a80 x7 : ffff8000098f58f0 x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000002 x1 : 00000000ffffbc02 x0 : 00000000ffffbc34
Call trace:
 handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
 caif_xmit+0xa4/0xe0 drivers/net/caif/caif_serial.c:285
 __netdev_start_xmit include/linux/netdevice.h:4819 [inline]
 netdev_start_xmit include/linux/netdevice.h:4833 [inline]
 xmit_one net/core/dev.c:3590 [inline]
 dev_hard_start_xmit+0xd4/0x1ec net/core/dev.c:3606
 __dev_queue_xmit+0x78c/0xc88 net/core/dev.c:4256
 dev_queue_xmit include/linux/netdevice.h:3008 [inline]
 tx+0x74/0x118 drivers/block/aoe/aoenet.c:63
 kthread+0x90/0x154 kernel/kthread.c:357
 kthread+0x12c/0x158 kernel/kthread.c:376
 ret_from_fork+0x10/0x20
irq event stamp: 43409
hardirqs last  enabled at (43408): [<ffff80000bfd660c>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (43408): [<ffff80000bfd660c>] _raw_spin_unlock_irqrestore+0x48/0x8c kernel/locking/spinlock.c:194
hardirqs last disabled at (43409): [<ffff80000bfc3cc4>] el1_dbg+0x24/0x5c arch/arm64/kernel/entry-common.c:395
softirqs last  enabled at (1392): [<ffff80000b207b84>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (1396): [<ffff80000b207b50>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1377 at drivers/net/caif/caif_serial.c:225 handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
Modules linked in:
CPU: 0 PID: 1377 Comm: aoe_tx0 Tainted: G        W          6.0.0-rc4-syzkaller-00071-ga6b443748715-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
lr : handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
sp : ffff80001477bc10
x29: ffff80001477bc10 x28: ffff80000f103000 x27: ffff80000d2bb000
x26: 0000000000000000 x25: 0000000000000fff x24: 00000000ffffbc3a
x23: ffff0000cf09c200 x22: 00000000ffffbc02 x21: ffff0000cf296cb0
x20: ffff0000cf23e800 x19: ffff0000cf296c80 x18: 00000000000000c0
x17: ffff80000dd3a698 x16: ffff80000db78658 x15: ffff0000c6271a80
x14: 0000000000000028 x13: 00000000ffffffff x12: ffff0000c6271a80
x11: ff80800009e7d314 x10: 0000000000000000 x9 : ffff800009e7d314
x8 : ffff0000c6271a80 x7 : ffff8000098f58f0 x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000002 x1 : 00000000ffffbc02 x0 : 00000000ffffbc3a
Call trace:
 handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
 caif_xmit+0xa4/0xe0 drivers/net/caif/caif_serial.c:285
 __netdev_start_xmit include/linux/netdevice.h:4819 [inline]
 netdev_start_xmit include/linux/netdevice.h:4833 [inline]
 xmit_one net/core/dev.c:3590 [inline]
 dev_hard_start_xmit+0xd4/0x1ec net/core/dev.c:3606
 __dev_queue_xmit+0x78c/0xc88 net/core/dev.c:4256
 dev_queue_xmit include/linux/netdevice.h:3008 [inline]
 tx+0x74/0x118 drivers/block/aoe/aoenet.c:63
 kthread+0x90/0x154 kernel/kthread.c:357
 kthread+0x12c/0x158 kernel/kthread.c:376
 ret_from_fork+0x10/0x20
irq event stamp: 43417
hardirqs last  enabled at (43416): [<ffff80000bfd660c>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (43416): [<ffff80000bfd660c>] _raw_spin_unlock_irqrestore+0x48/0x8c kernel/locking/spinlock.c:194
hardirqs last disabled at (43417): [<ffff80000bfc3cc4>] el1_dbg+0x24/0x5c arch/arm64/kernel/entry-common.c:395
softirqs last  enabled at (1392): [<ffff80000b207b84>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (1396): [<ffff80000b207b50>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1377 at drivers/net/caif/caif_serial.c:225 handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
Modules linked in:
CPU: 0 PID: 1377 Comm: aoe_tx0 Tainted: G        W          6.0.0-rc4-syzkaller-00071-ga6b443748715-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
lr : handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
sp : ffff80001477bc10
x29: ffff80001477bc10 x28: ffff80000f103000 x27: ffff80000d2bb000
x26: 0000000000000000 x25: 0000000000000fff x24: 00000000ffffbc40
x23: ffff0000cf09c200 x22: 00000000ffffbc02 x21: ffff0000cf296cb0
x20: ffff0000cf23e800 x19: ffff0000cf296c80 x18: 00000000000000c0
x17: ffff80000dd3a698 x16: ffff80000db78658 x15: ffff0000c6271a80
x14: 0000000000000028 x13: 00000000ffffffff x12: ffff0000c6271a80
x11: ff80800009e7d314 x10: 0000000000000000 x9 : ffff800009e7d314
x8 : ffff0000c6271a80 x7 : ffff8000098f58f0 x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000002 x1 : 00000000ffffbc02 x0 : 00000000ffffbc40
Call trace:
 handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
 caif_xmit+0xa4/0xe0 drivers/net/caif/caif_serial.c:285
 __netdev_start_xmit include/linux/netdevice.h:4819 [inline]
 netdev_start_xmit include/linux/netdevice.h:4833 [inline]
 xmit_one net/core/dev.c:3590 [inline]
 dev_hard_start_xmit+0xd4/0x1ec net/core/dev.c:3606
 __dev_queue_xmit+0x78c/0xc88 net/core/dev.c:4256
 dev_queue_xmit include/linux/netdevice.h:3008 [inline]
 tx+0x74/0x118 drivers/block/aoe/aoenet.c:63
 kthread+0x90/0x154 kernel/kthread.c:357
 kthread+0x12c/0x158 kernel/kthread.c:376
 ret_from_fork+0x10/0x20
irq event stamp: 43425
hardirqs last  enabled at (43424): [<ffff80000bfd660c>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (43424): [<ffff80000bfd660c>] _raw_spin_unlock_irqrestore+0x48/0x8c kernel/locking/spinlock.c:194
hardirqs last disabled at (43425): [<ffff80000bfc3cc4>] el1_dbg+0x24/0x5c arch/arm64/kernel/entry-common.c:395
softirqs last  enabled at (1392): [<ffff80000b207b84>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (1396): [<ffff80000b207b50>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1377 at drivers/net/caif/caif_serial.c:225 handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
Modules linked in:
CPU: 0 PID: 1377 Comm: aoe_tx0 Tainted: G        W          6.0.0-rc4-syzkaller-00071-ga6b443748715-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
lr : handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
sp : ffff80001477bc10
x29: ffff80001477bc10 x28: ffff80000f103000 x27: ffff80000d2bb000
x26: 0000000000000000 x25: 0000000000000fff x24: 00000000ffffbc45
x23: ffff0000cf09c200 x22: 00000000ffffbc02 x21: ffff0000cf296cb0
x20: ffff0000cf23e800 x19: ffff0000cf296c80 x18: 00000000000000c0
x17: ffff80000dd3a698 x16: ffff80000db78658 x15: ffff0000c6271a80
x14: 0000000000000028 x13: 00000000ffffffff x12: ffff0000c6271a80
x11: ff80800009e7d314 x10: 0000000000000000 x9 : ffff800009e7d314
x8 : ffff0000c6271a80 x7 : ffff8000098f58f0 x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000002 x1 : 00000000ffffbc02 x0 : 00000000ffffbc45
Call trace:
 handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
 caif_xmit+0xa4/0xe0 drivers/net/caif/caif_serial.c:285
 __netdev_start_xmit include/linux/netdevice.h:4819 [inline]
 netdev_start_xmit include/linux/netdevice.h:4833 [inline]
 xmit_one net/core/dev.c:3590 [inline]
 dev_hard_start_xmit+0xd4/0x1ec net/core/dev.c:3606
 __dev_queue_xmit+0x78c/0xc88 net/core/dev.c:4256
 dev_queue_xmit include/linux/netdevice.h:3008 [inline]
 tx+0x74/0x118 drivers/block/aoe/aoenet.c:63
 kthread+0x90/0x154 kernel/kthread.c:357
 kthread+0x12c/0x158 kernel/kthread.c:376
 ret_from_fork+0x10/0x20
irq event stamp: 43433
hardirqs last  enabled at (43432): [<ffff80000bfd660c>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (43432): [<ffff80000bfd660c>] _raw_spin_unlock_irqrestore+0x48/0x8c kernel/locking/spinlock.c:194
hardirqs last disabled at (43433): [<ffff80000bfc3cc4>] el1_dbg+0x24/0x5c arch/arm64/kernel/entry-common.c:395
softirqs last  enabled at (1392): [<ffff80000b207b84>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (1396): [<ffff80000b207b50>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1377 at drivers/net/caif/caif_serial.c:225 handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
Modules linked in:
CPU: 0 PID: 1377 Comm: aoe_tx0 Tainted: G        W          6.0.0-rc4-syzkaller-00071-ga6b443748715-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
lr : handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
sp : ffff80001477bc10
x29: ffff80001477bc10 x28: ffff80000f103000 x27: ffff80000d2bb000
x26: 0000000000000000 x25: 0000000000000fff x24: 00000000ffffbc4a
x23: ffff0000cf09c200 x22: 00000000ffffbc02 x21: ffff0000cf296cb0
x20: ffff0000cf23e800 x19: ffff0000cf296c80 x18: 00000000000000c0
x17: ffff80000dd3a698 x16: ffff80000db78658 x15: ffff0000c6271a80
x14: 0000000000000028 x13: 00000000ffffffff x12: ffff0000c6271a80
x11: ff80800009e7d314 x10: 0000000000000000 x9 : ffff800009e7d314
x8 : ffff0000c6271a80 x7 : ffff8000098f58f0 x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000002 x1 : 00000000ffffbc02 x0 : 00000000ffffbc4a
Call trace:
 handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
 caif_xmit+0xa4/0xe0 drivers/net/caif/caif_serial.c:285
 __netdev_start_xmit include/linux/netdevice.h:4819 [inline]
 netdev_start_xmit include/linux/netdevice.h:4833 [inline]
 xmit_one net/core/dev.c:3590 [inline]
 dev_hard_start_xmit+0xd4/0x1ec net/core/dev.c:3606
 __dev_queue_xmit+0x78c/0xc88 net/core/dev.c:4256
 dev_queue_xmit include/linux/netdevice.h:3008 [inline]
 tx+0x74/0x118 drivers/block/aoe/aoenet.c:63
 kthread+0x90/0x154 kernel/kthread.c:357
 kthread+0x12c/0x158 kernel/kthread.c:376
 ret_from_fork+0x10/0x20
irq event stamp: 43441
hardirqs last  enabled at (43440): [<ffff80000bfd660c>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (43440): [<ffff80000bfd660c>] _raw_spin_unlock_irqrestore+0x48/0x8c kernel/locking/spinlock.c:194
hardirqs last disabled at (43441): [<ffff80000bfc3cc4>] el1_dbg+0x24/0x5c arch/arm64/kernel/entry-common.c:395
softirqs last  enabled at (1392): [<ffff80000b207b84>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (1396): [<ffff80000b207b50>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1377 at drivers/net/caif/caif_serial.c:225 handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
Modules linked in:
CPU: 0 PID: 1377 Comm: aoe_tx0 Tainted: G        W          6.0.0-rc4-syzkaller-00071-ga6b443748715-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
lr : handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
sp : ffff80001477bc10
x29: ffff80001477bc10 x28: ffff80000f103000 x27: ffff80000d2bb000
x26: 0000000000000000 x25: 0000000000000fff x24: 00000000ffffbc50
x23: ffff0000cf09c200 x22: 00000000ffffbc02 x21: ffff0000cf296cb0
x20: ffff0000cf23e800 x19: ffff0000cf296c80 x18: 00000000000000c0
x17: ffff80000dd3a698 x16: ffff80000db78658 x15: ffff0000c6271a80
x14: 0000000000000028 x13: 00000000ffffffff x12: ffff0000c6271a80
x11: ff80800009e7d314 x10: 0000000000000000 x9 : ffff800009e7d314
x8 : ffff0000c6271a80 x7 : ffff8000098f58f0 x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000002 x1 : 00000000ffffbc02 x0 : 00000000ffffbc50
Call trace:
 handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
 caif_xmit+0xa4/0xe0 drivers/net/caif/caif_serial.c:285
 __netdev_start_xmit include/linux/netdevice.h:4819 [inline]
 netdev_start_xmit include/linux/netdevice.h:4833 [inline]
 xmit_one net/core/dev.c:3590 [inline]
 dev_hard_start_xmit+0xd4/0x1ec net/core/dev.c:3606
 __dev_queue_xmit+0x78c/0xc88 net/core/dev.c:4256
 dev_queue_xmit include/linux/netdevice.h:3008 [inline]
 tx+0x74/0x118 drivers/block/aoe/aoenet.c:63
 kthread+0x90/0x154 kernel/kthread.c:357
 kthread+0x12c/0x158 kernel/kthread.c:376
 ret_from_fork+0x10/0x20
irq event stamp: 43449
hardirqs last  enabled at (43448): [<ffff80000bfd660c>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (43448): [<ffff80000bfd660c>] _raw_spin_unlock_irqrestore+0x48/0x8c kernel/locking/spinlock.c:194
hardirqs last disabled at (43449): [<ffff80000bfc3cc4>] el1_dbg+0x24/0x5c arch/arm64/kernel/entry-common.c:395
softirqs last  enabled at (1392): [<ffff80000b207b84>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (1396): [<ffff80000b207b50>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1377 at drivers/net/caif/caif_serial.c:225 handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
Modules linked in:
CPU: 0 PID: 1377 Comm: aoe_tx0 Tainted: G        W          6.0.0-rc4-syzkaller-00071-ga6b443748715-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
lr : handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
sp : ffff80001477bc10
x29: ffff80001477bc10 x28: ffff80000f103000 x27: ffff80000d2bb000
x26: 0000000000000000 x25: 0000000000000fff x24: 00000000ffffbc56
x23: ffff0000cf09c200 x22: 00000000ffffbc02 x21: ffff0000cf296cb0
x20: ffff0000cf23e800 x19: ffff0000cf296c80 x18: 00000000000000c0
x17: ffff80000dd3a698 x16: ffff80000db78658 x15: ffff0000c6271a80
x14: 0000000000000028 x13: 00000000ffffffff x12: ffff0000c6271a80
x11: ff80800009e7d314 x10: 0000000000000000 x9 : ffff800009e7d314
x8 : ffff0000c6271a80 x7 : ffff8000098f58f0 x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000002 x1 : 00000000ffffbc02 x0 : 00000000ffffbc56
Call trace:
 handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
 caif_xmit+0xa4/0xe0 drivers/net/caif/caif_serial.c:285
 __netdev_start_xmit include/linux/netdevice.h:4819 [inline]
 netdev_start_xmit include/linux/netdevice.h:4833 [inline]
 xmit_one net/core/dev.c:3590 [inline]
 dev_hard_start_xmit+0xd4/0x1ec net/core/dev.c:3606
 __dev_queue_xmit+0x78c/0xc88 net/core/dev.c:4256
 dev_queue_xmit include/linux/netdevice.h:3008 [inline]
 tx+0x74/0x118 drivers/block/aoe/aoenet.c:63
 kthread+0x90/0x154 kernel/kthread.c:357
 kthread+0x12c/0x158 kernel/kthread.c:376
 ret_from_fork+0x10/0x20
irq event stamp: 43457
hardirqs last  enabled at (43456): [<ffff80000bfd660c>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (43456): [<ffff80000bfd660c>] _raw_spin_unlock_irqrestore+0x48/0x8c kernel/locking/spinlock.c:194
hardirqs last disabled at (43457): [<ffff80000bfc3cc4>] el1_dbg+0x24/0x5c arch/arm64/kernel/entry-common.c:395
softirqs last  enabled at (1392): [<ffff80000b207b84>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (1396): [<ffff80000b207b50>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1377 at drivers/net/caif/caif_serial.c:225 handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
Modules linked in:
CPU: 0 PID: 1377 Comm: aoe_tx0 Tainted: G        W          6.0.0-rc4-syzkaller-00071-ga6b443748715-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
lr : handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
sp : ffff80001477bc10
x29: ffff80001477bc10 x28: ffff80000f103000 x27: ffff80000d2bb000
x26: 0000000000000000 x25: 0000000000000fff x24: 00000000ffffbc5b
x23: ffff0000cf09c200 x22: 00000000ffffbc02 x21: ffff0000cf296cb0
x20: ffff0000cf23e800 x19: ffff0000cf296c80 x18: 00000000000000c0
x17: ffff80000dd3a698 x16: ffff80000db78658 x15: ffff0000c6271a80
x14: 0000000000000028 x13: 00000000ffffffff x12: ffff0000c6271a80
x11: ff80800009e7d314 x10: 0000000000000000 x9 : ffff800009e7d314
x8 : ffff0000c6271a80 x7 : ffff8000098f58f0 x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000002 x1 : 00000000ffffbc02 x0 : 00000000ffffbc5b
Call trace:
 handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
 caif_xmit+0xa4/0xe0 drivers/net/caif/caif_serial.c:285
 __netdev_start_xmit include/linux/netdevice.h:4819 [inline]
 netdev_start_xmit include/linux/netdevice.h:4833 [inline]
 xmit_one net/core/dev.c:3590 [inline]
 dev_hard_start_xmit+0xd4/0x1ec net/core/dev.c:3606
 __dev_queue_xmit+0x78c/0xc88 net/core/dev.c:4256
 dev_queue_xmit include/linux/netdevice.h:3008 [inline]
 tx+0x74/0x118 drivers/block/aoe/aoenet.c:63
 kthread+0x90/0x154 kernel/kthread.c:357
 kthread+0x12c/0x158 kernel/kthread.c:376
 ret_from_fork+0x10/0x20
irq event stamp: 43465
hardirqs last  enabled at (43464): [<ffff80000bfd660c>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (43464): [<ffff80000bfd660c>] _raw_spin_unlock_irqrestore+0x48/0x8c kernel/locking/spinlock.c:194
hardirqs last disabled at (43465): [<ffff80000bfc3cc4>] el1_dbg+0x24/0x5c arch/arm64/kernel/entry-common.c:395
softirqs last  enabled at (1392): [<ffff80000b207b84>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (1396): [<ffff80000b207b50>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1377 at drivers/net/caif/caif_serial.c:225 handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
Modules linked in:
CPU: 0 PID: 1377 Comm: aoe_tx0 Tainted: G        W          6.0.0-rc4-syzkaller-00071-ga6b443748715-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
lr : handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
sp : ffff80001477bc10
x29: ffff80001477bc10 x28: ffff80000f103000 x27: ffff80000d2bb000
x26: 0000000000000000 x25: 0000000000000fff x24: 00000000ffffbc61
x23: ffff0000cf09c200 x22: 00000000ffffbc02 x21: ffff0000cf296cb0
x20: ffff0000cf23e800 x19: ffff0000cf296c80 x18: 00000000000000c0
x17: ffff80000dd3a698 x16: ffff80000db78658 x15: ffff0000c6271a80
x14: 0000000000000028 x13: 00000000ffffffff x12: ffff0000c6271a80
x11: ff80800009e7d314 x10: 0000000000000000 x9 : ffff800009e7d314
x8 : ffff0000c6271a80 x7 : ffff8000098f58f0 x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000002 x1 : 00000000ffffbc02 x0 : 00000000ffffbc61
Call trace:
 handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
 caif_xmit+0xa4/0xe0 drivers/net/caif/caif_serial.c:285
 __netdev_start_xmit include/linux/netdevice.h:4819 [inline]
 netdev_start_xmit include/linux/netdevice.h:4833 [inline]
 xmit_one net/core/dev.c:3590 [inline]
 dev_hard_start_xmit+0xd4/0x1ec net/core/dev.c:3606
 __dev_queue_xmit+0x78c/0xc88 net/core/dev.c:4256
 dev_queue_xmit include/linux/netdevice.h:3008 [inline]
 tx+0x74/0x118 drivers/block/aoe/aoenet.c:63
 kthread+0x90/0x154 kernel/kthread.c:357
 kthread+0x12c/0x158 kernel/kthread.c:376
 ret_from_fork+0x10/0x20
irq event stamp: 43473
hardirqs last  enabled at (43472): [<ffff80000bfd660c>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (43472): [<ffff80000bfd660c>] _raw_spin_unlock_irqrestore+0x48/0x8c kernel/locking/spinlock.c:194
hardirqs last disabled at (43473): [<ffff80000bfc3cc4>] el1_dbg+0x24/0x5c arch/arm64/kernel/entry-common.c:395
softirqs last  enabled at (1392): [<ffff80000b207b84>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (1396): [<ffff80000b207b50>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1377 at drivers/net/caif/caif_serial.c:225 handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
Modules linked in:
CPU: 0 PID: 1377 Comm: aoe_tx0 Tainted: G        W          6.0.0-rc4-syzkaller-00071-ga6b443748715-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
lr : handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
sp : ffff80001477bc10
x29: ffff80001477bc10 x28: ffff80000f103000 x27: ffff80000d2bb000
x26: 0000000000000000 x25: 0000000000000fff x24: 00000000ffffbc66
x23: ffff0000cf09c200 x22: 00000000ffffbc02 x21: ffff0000cf296cb0
x20: ffff0000cf23e800 x19: ffff0000cf296c80 x18: 00000000000000c0
x17: ffff80000dd3a698 x16: ffff80000db78658 x15: ffff0000c6271a80
x14: 0000000000000028 x13: 00000000ffffffff x12: ffff0000c6271a80
x11: ff80800009e7d314 x10: 0000000000000000 x9 : ffff800009e7d314
x8 : ffff0000c6271a80 x7 : ffff8000098f58f0 x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000002 x1 : 00000000ffffbc02 x0 : 00000000ffffbc66
Call trace:
 handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
 caif_xmit+0xa4/0xe0 drivers/net/caif/caif_serial.c:285
 __netdev_start_xmit include/linux/netdevice.h:4819 [inline]
 netdev_start_xmit include/linux/netdevice.h:4833 [inline]
 xmit_one net/core/dev.c:3590 [inline]
 dev_hard_start_xmit+0xd4/0x1ec net/core/dev.c:3606
 __dev_queue_xmit+0x78c/0xc88 net/core/dev.c:4256
 dev_queue_xmit include/linux/netdevice.h:3008 [inline]
 tx+0x74/0x118 drivers/block/aoe/aoenet.c:63
 kthread+0x90/0x154 kernel/kthread.c:357
 kthread+0x12c/0x158 kernel/kthread.c:376
 ret_from_fork+0x10/0x20
irq event stamp: 43481
hardirqs last  enabled at (43480): [<ffff80000bfd660c>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (43480): [<ffff80000bfd660c>] _raw_spin_unlock_irqrestore+0x48/0x8c kernel/locking/spinlock.c:194
hardirqs last disabled at (43481): [<ffff80000bfc3cc4>] el1_dbg+0x24/0x5c arch/arm64/kernel/entry-common.c:395
softirqs last  enabled at (1392): [<ffff80000b207b84>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (1396): [<ffff80000b207b50>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1377 at drivers/net/caif/caif_serial.c:225 handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
Modules linked in:
CPU: 0 PID: 1377 Comm: aoe_tx0 Tainted: G        W          6.0.0-rc4-syzkaller-00071-ga6b443748715-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
lr : handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
sp : ffff80001477bc10
x29: ffff80001477bc10 x28: ffff80000f103000 x27: ffff80000d2bb000
x26: 0000000000000000 x25: 0000000000000fff x24: 00000000ffffbc6c
x23: ffff0000cf09c200 x22: 00000000ffffbc02 x21: ffff0000cf296cb0
x20: ffff0000cf23e800 x19: ffff0000cf296c80 x18: 00000000000000c0
x17: ffff80000dd3a698 x16: ffff80000db78658 x15: ffff0000c6271a80
x14: 0000000000000028 x13: 00000000ffffffff x12: ffff0000c6271a80
x11: ff80800009e7d314 x10: 0000000000000000 x9 : ffff800009e7d314
x8 : ffff0000c6271a80 x7 : ffff8000098f58f0 x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000002 x1 : 00000000ffffbc02 x0 : 00000000ffffbc6c
Call trace:
 handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
 caif_xmit+0xa4/0xe0 drivers/net/caif/caif_serial.c:285
 __netdev_start_xmit include/linux/netdevice.h:4819 [inline]
 netdev_start_xmit include/linux/netdevice.h:4833 [inline]
 xmit_one net/core/dev.c:3590 [inline]
 dev_hard_start_xmit+0xd4/0x1ec net/core/dev.c:3606
 __dev_queue_xmit+0x78c/0xc88 net/core/dev.c:4256
 dev_queue_xmit include/linux/netdevice.h:3008 [inline]
 tx+0x74/0x118 drivers/block/aoe/aoenet.c:63
 kthread+0x90/0x154 kernel/kthread.c:357
 kthread+0x12c/0x158 kernel/kthread.c:376
 ret_from_fork+0x10/0x20
irq event stamp: 43489
hardirqs last  enabled at (43488): [<ffff80000bfd660c>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (43488): [<ffff80000bfd660c>] _raw_spin_unlock_irqrestore+0x48/0x8c kernel/locking/spinlock.c:194
hardirqs last disabled at (43489): [<ffff80000bfc3cc4>] el1_dbg+0x24/0x5c arch/arm64/kernel/entry-common.c:395
softirqs last  enabled at (1392): [<ffff80000b207b84>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (1396): [<ffff80000b207b50>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1377 at drivers/net/caif/caif_serial.c:225 handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
Modules linked in:
CPU: 0 PID: 1377 Comm: aoe_tx0 Tainted: G        W          6.0.0-rc4-syzkaller-00071-ga6b443748715-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
lr : handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
sp : ffff80001477bc10
x29: ffff80001477bc10 x28: ffff80000f103000 x27: ffff80000d2bb000
x26: 0000000000000000 x25: 0000000000000fff x24: 00000000ffffbc71
x23: ffff0000cf09c200 x22: 00000000ffffbc02 x21: ffff0000cf296cb0
x20: ffff0000cf23e800 x19: ffff0000cf296c80 x18: 00000000000000c0
x17: ffff80000dd3a698 x16: ffff80000db78658 x15: ffff0000c6271a80
x14: 0000000000000028 x13: 00000000ffffffff x12: ffff0000c6271a80
x11: ff80800009e7d314 x10: 0000000000000000 x9 : ffff800009e7d314
x8 : ffff0000c6271a80 x7 : ffff8000098f58f0 x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000002 x1 : 00000000ffffbc02 x0 : 00000000ffffbc71
Call trace:
 handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
 caif_xmit+0xa4/0xe0 drivers/net/caif/caif_serial.c:285
 __netdev_start_xmit include/linux/netdevice.h:4819 [inline]
 netdev_start_xmit include/linux/netdevice.h:4833 [inline]
 xmit_one net/core/dev.c:3590 [inline]
 dev_hard_start_xmit+0xd4/0x1ec net/core/dev.c:3606
 __dev_queue_xmit+0x78c/0xc88 net/core/dev.c:4256
 dev_queue_xmit include/linux/netdevice.h:3008 [inline]
 tx+0x74/0x118 drivers/block/aoe/aoenet.c:63
 kthread+0x90/0x154 kernel/kthread.c:357
 kthread+0x12c/0x158 kernel/kthread.c:376
 ret_from_fork+0x10/0x20
irq event stamp: 43497
hardirqs last  enabled at (43496): [<ffff80000bfd660c>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (43496): [<ffff80000bfd660c>] _raw_spin_unlock_irqrestore+0x48/0x8c kernel/locking/spinlock.c:194
hardirqs last disabled at (43497): [<ffff80000bfc3cc4>] el1_dbg+0x24/0x5c arch/arm64/kernel/entry-common.c:395
softirqs last  enabled at (1392): [<ffff80000b207b84>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (1396): [<ffff80000b207b50>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1377 at drivers/net/caif/caif_serial.c:225 handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
Modules linked in:
CPU: 0 PID: 1377 Comm: aoe_tx0 Tainted: G        W          6.0.0-rc4-syzkaller-00071-ga6b443748715-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
lr : handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
sp : ffff80001477bc10
x29: ffff80001477bc10 x28: ffff80000f103000 x27: ffff80000d2bb000
x26: 0000000000000000 x25: 0000000000000fff x24: 00000000ffffbc77
x23: ffff0000cf09c200 x22: 00000000ffffbc02 x21: ffff0000cf296cb0
x20: ffff0000cf23e800 x19: ffff0000cf296c80 x18: 00000000000000c0
x17: ffff80000dd3a698 x16: ffff80000db78658 x15: ffff0000c6271a80
x14: 0000000000000028 x13: 00000000ffffffff x12: ffff0000c6271a80
x11: ff80800009e7d314 x10: 0000000000000000 x9 : ffff800009e7d314
x8 : ffff0000c6271a80 x7 : ffff8000098f58f0 x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000002 x1 : 00000000ffffbc02 x0 : 00000000ffffbc77
Call trace:
 handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
 caif_xmit+0xa4/0xe0 drivers/net/caif/caif_serial.c:285
 __netdev_start_xmit include/linux/netdevice.h:4819 [inline]
 netdev_start_xmit include/linux/netdevice.h:4833 [inline]
 xmit_one net/core/dev.c:3590 [inline]
 dev_hard_start_xmit+0xd4/0x1ec net/core/dev.c:3606
 __dev_queue_xmit+0x78c/0xc88 net/core/dev.c:4256
 dev_queue_xmit include/linux/netdevice.h:3008 [inline]
 tx+0x74/0x118 drivers/block/aoe/aoenet.c:63
 kthread+0x90/0x154 kernel/kthread.c:357
 kthread+0x12c/0x158 kernel/kthread.c:376
 ret_from_fork+0x10/0x20
irq event stamp: 43505
hardirqs last  enabled at (43504): [<ffff80000bfd660c>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (43504): [<ffff80000bfd660c>] _raw_spin_unlock_irqrestore+0x48/0x8c kernel/locking/spinlock.c:194
hardirqs last disabled at (43505): [<ffff80000bfc3cc4>] el1_dbg+0x24/0x5c arch/arm64/kernel/entry-common.c:395
softirqs last  enabled at (1392): [<ffff80000b207b84>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (1396): [<ffff80000b207b50>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1377 at drivers/net/caif/caif_serial.c:225 handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
Modules linked in:
CPU: 0 PID: 1377 Comm: aoe_tx0 Tainted: G        W          6.0.0-rc4-syzkaller-00071-ga6b443748715-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
lr : handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
sp : ffff80001477bc10
x29: ffff80001477bc10 x28: ffff80000f103000 x27: ffff80000d2bb000
x26: 0000000000000000 x25: 0000000000000fff x24: 00000000ffffbc7c
x23: ffff0000cf09c200 x22: 00000000ffffbc02 x21: ffff0000cf296cb0
x20: ffff0000cf23e800 x19: ffff0000cf296c80 x18: 00000000000000c0
x17: ffff80000dd3a698 x16: ffff80000db78658 x15: ffff0000c6271a80
x14: 0000000000000028 x13: 00000000ffffffff x12: ffff0000c6271a80
x11: ff80800009e7d314 x10: 0000000000000000 x9 : ffff800009e7d314
x8 : ffff0000c6271a80 x7 : ffff8000098f58f0 x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000002 x1 : 00000000ffffbc02 x0 : 00000000ffffbc7c
Call trace:
 handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
 caif_xmit+0xa4/0xe0 drivers/net/caif/caif_serial.c:285
 __netdev_start_xmit include/linux/netdevice.h:4819 [inline]
 netdev_start_xmit include/linux/netdevice.h:4833 [inline]
 xmit_one net/core/dev.c:3590 [inline]
 dev_hard_start_xmit+0xd4/0x1ec net/core/dev.c:3606
 __dev_queue_xmit+0x78c/0xc88 net/core/dev.c:4256
 dev_queue_xmit include/linux/netdevice.h:3008 [inline]
 tx+0x74/0x118 drivers/block/aoe/aoenet.c:63
 kthread+0x90/0x154 kernel/kthread.c:357
 kthread+0x12c/0x158 kernel/kthread.c:376
 ret_from_fork+0x10/0x20
irq event stamp: 43513
hardirqs last  enabled at (43512): [<ffff80000bfd660c>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (43512): [<ffff80000bfd660c>] _raw_spin_unlock_irqrestore+0x48/0x8c kernel/locking/spinlock.c:194
hardirqs last disabled at (43513): [<ffff80000bfc3cc4>] el1_dbg+0x24/0x5c arch/arm64/kernel/entry-common.c:395
softirqs last  enabled at (1392): [<ffff80000b207b84>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (1396): [<ffff80000b207b50>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1377 at drivers/net/caif/caif_serial.c:225 handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
Modules linked in:
CPU: 0 PID: 1377 Comm: aoe_tx0 Tainted: G        W          6.0.0-rc4-syzkaller-00071-ga6b443748715-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
lr : handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
sp : ffff80001477bc10
x29: ffff80001477bc10 x28: ffff80000f103000 x27: ffff80000d2bb000
x26: 0000000000000000 x25: 0000000000000fff x24: 00000000ffffbc81
x23: ffff0000cf09c200 x22: 00000000ffffbc02 x21: ffff0000cf296cb0
x20: ffff0000cf23e800 x19: ffff0000cf296c80 x18: 00000000000000c0
x17: ffff80000dd3a698 x16: ffff80000db78658 x15: ffff0000c6271a80
x14: 0000000000000028 x13: 00000000ffffffff x12: ffff0000c6271a80
x11: ff80800009e7d314 x10: 0000000000000000 x9 : ffff800009e7d314
x8 : ffff0000c6271a80 x7 : ffff8000098f58f0 x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000002 x1 : 00000000ffffbc02 x0 : 00000000ffffbc81
Call trace:
 handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
 caif_xmit+0xa4/0xe0 drivers/net/caif/caif_serial.c:285
 __netdev_start_xmit include/linux/netdevice.h:4819 [inline]
 netdev_start_xmit include/linux/netdevice.h:4833 [inline]
 xmit_one net/core/dev.c:3590 [inline]
 dev_hard_start_xmit+0xd4/0x1ec net/core/dev.c:3606
 __dev_queue_xmit+0x78c/0xc88 net/core/dev.c:4256
 dev_queue_xmit include/linux/netdevice.h:3008 [inline]
 tx+0x74/0x118 drivers/block/aoe/aoenet.c:63
 kthread+0x90/0x154 kernel/kthread.c:357
 kthread+0x12c/0x158 kernel/kthread.c:376
 ret_from_fork+0x10/0x20
irq event stamp: 43521
hardirqs last  enabled at (43520): [<ffff80000bfd660c>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (43520): [<ffff80000bfd660c>] _raw_spin_unlock_irqrestore+0x48/0x8c kernel/locking/spinlock.c:194
hardirqs last disabled at (43521): [<ffff80000bfc3cc4>] el1_dbg+0x24/0x5c arch/arm64/kernel/entry-common.c:395
softirqs last  enabled at (1392): [<ffff80000b207b84>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (1396): [<ffff80000b207b50>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1377 at drivers/net/caif/caif_serial.c:225 handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
Modules linked in:
CPU: 0 PID: 1377 Comm: aoe_tx0 Tainted: G        W          6.0.0-rc4-syzkaller-00071-ga6b443748715-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
lr : handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
sp : ffff80001477bc10
x29: ffff80001477bc10 x28: ffff80000f103000 x27: ffff80000d2bb000
x26: 0000000000000000 x25: 0000000000000fff x24: 00000000ffffbc87
x23: ffff0000cf09c200 x22: 00000000ffffbc02 x21: ffff0000cf296cb0
x20: ffff0000cf23e800 x19: ffff0000cf296c80 x18: 00000000000000c0
x17: ffff80000dd3a698 x16: ffff80000db78658 x15: ffff0000c6271a80
x14: 0000000000000028 x13: 00000000ffffffff x12: ffff0000c6271a80
x11: ff80800009e7d314 x10: 0000000000000000 x9 : ffff800009e7d314
x8 : ffff0000c6271a80 x7 : ffff8000098f58f0 x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000002 x1 : 00000000ffffbc02 x0 : 00000000ffffbc87
Call trace:
 handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
 caif_xmit+0xa4/0xe0 drivers/net/caif/caif_serial.c:285
 __netdev_start_xmit include/linux/netdevice.h:4819 [inline]
 netdev_start_xmit include/linux/netdevice.h:4833 [inline]
 xmit_one net/core/dev.c:3590 [inline]
 dev_hard_start_xmit+0xd4/0x1ec net/core/dev.c:3606
 __dev_queue_xmit+0x78c/0xc88 net/core/dev.c:4256
 dev_queue_xmit include/linux/netdevice.h:3008 [inline]
 tx+0x74/0x118 drivers/block/aoe/aoenet.c:63
 kthread+0x90/0x154 kernel/kthread.c:357
 kthread+0x12c/0x158 kernel/kthread.c:376
 ret_from_fork+0x10/0x20
irq event stamp: 43529
hardirqs last  enabled at (43528): [<ffff80000bfd660c>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (43528): [<ffff80000bfd660c>] _raw_spin_unlock_irqrestore+0x48/0x8c kernel/locking/spinlock.c:194
hardirqs last disabled at (43529): [<ffff80000bfc3cc4>] el1_dbg+0x24/0x5c arch/arm64/kernel/entry-common.c:395
softirqs last  enabled at (1392): [<ffff80000b207b84>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (1396): [<ffff80000b207b50>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1377 at drivers/net/caif/caif_serial.c:225 handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
Modules linked in:
CPU: 0 PID: 1377 Comm: aoe_tx0 Tainted: G        W          6.0.0-rc4-syzkaller-00071-ga6b443748715-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
lr : handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
sp : ffff80001477bc10
x29: ffff80001477bc10 x28: ffff80000f103000 x27: ffff80000d2bb000
x26: 0000000000000000 x25: 0000000000000fff x24: 00000000ffffbc8c
x23: ffff0000cf09c200 x22: 00000000ffffbc02 x21: ffff0000cf296cb0
x20: ffff0000cf23e800 x19: ffff0000cf296c80 x18: 00000000000000c0
x17: ffff80000dd3a698 x16: ffff80000db78658 x15: ffff0000c6271a80
x14: 0000000000000028 x13: 00000000ffffffff x12: ffff0000c6271a80
x11: ff80800009e7d314 x10: 0000000000000000 x9 : ffff800009e7d314
x8 : ffff0000c6271a80 x7 : ffff8000098f58f0 x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000002 x1 : 00000000ffffbc02 x0 : 00000000ffffbc8c
Call trace:
 handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
 caif_xmit+0xa4/0xe0 drivers/net/caif/caif_serial.c:285
 __netdev_start_xmit include/linux/netdevice.h:4819 [inline]
 netdev_start_xmit include/linux/netdevice.h:4833 [inline]
 xmit_one net/core/dev.c:3590 [inline]
 dev_hard_start_xmit+0xd4/0x1ec net/core/dev.c:3606
 __dev_queue_xmit+0x78c/0xc88 net/core/dev.c:4256
 dev_queue_xmit include/linux/netdevice.h:3008 [inline]
 tx+0x74/0x118 drivers/block/aoe/aoenet.c:63
 kthread+0x90/0x154 kernel/kthread.c:357
 kthread+0x12c/0x158 kernel/kthread.c:376
 ret_from_fork+0x10/0x20
irq event stamp: 43537
hardirqs last  enabled at (43536): [<ffff80000bfd660c>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (43536): [<ffff80000bfd660c>] _raw_spin_unlock_irqrestore+0x48/0x8c kernel/locking/spinlock.c:194
hardirqs last disabled at (43537): [<ffff80000bfc3cc4>] el1_dbg+0x24/0x5c arch/arm64/kernel/entry-common.c:395
softirqs last  enabled at (1392): [<ffff80000b207b84>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (1396): [<ffff80000b207b50>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1377 at drivers/net/caif/caif_serial.c:225 handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
Modules linked in:
CPU: 0 PID: 1377 Comm: aoe_tx0 Tainted: G        W          6.0.0-rc4-syzkaller-00071-ga6b443748715-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
lr : handle_tx+0x1ec/0x380 drivers/net/caif/caif_serial.c:225
sp : ffff80001477bc10
x29: ffff80001477bc10 x28: ffff80000f103000 x27: ffff80000d2bb000


Tested on:

commit:         a6b44374 Merge branch 'for-next/core', remote-tracking..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12c2ce64880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=14bf9ec0df433b27
dashboard link: https://syzkaller.appspot.com/bug?extid=5e87db90e68fbc4707c6
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14a541a0880000

