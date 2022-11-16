Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0100462B26E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 05:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbiKPEkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 23:40:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbiKPEkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 23:40:35 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F2831FA2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 20:40:34 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id d19-20020a056e020c1300b00300b5a12c44so12499584ile.15
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 20:40:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f7xsjgNaLtKC+H7h7M8hw9jnie4+9d38st734rg2yCA=;
        b=mhppwoQqDBW1AkdKoWnGvbAhYVyjx2Halia7GLIRcibWIeiQ2qG1p4119SUyi6EkcC
         cq1OzojVxNrkIlERgZux7So0hw6r/TRdWjoQXaLt++h4IuxbaVQ6ijihFlnApI7C9FOr
         mLNcjJOXuxJgw9mUzUFlApd4CjMsnHo5yLvHtww2KNegyvkT17M718oajy2iN3faiSoA
         Go3BvJy4ztvwV1emgQyRrlZcOHxg2EUH4PQfowmqp9NCk+wRA0PWOXeSPQHSZdpADSDy
         B6LHydE7BXKjOAeqFauzPbMxdRA03CVJmC1GESFprCVOdAf3SsWUK7CCE4N4CMKt+cdM
         6aUQ==
X-Gm-Message-State: ANoB5pkmWwbP0q4v0RT6vSLaiDFkXYNCKhFzwgnXViqjcAK4rJ4lYxPg
        JvpeJNRUzz6Fv5HLW57oyziMeSZaH2wKvMY4f+nJJy3x98ra
X-Google-Smtp-Source: AA0mqf4N2rOQBbAPZqNaquIWnlW8rhqXf/zHOvrC5LdufI7S2xxhbgWRdzbDB8LppknvM93iM/iflSTWd+f0uRPVzBP6A3/a4iFB
MIME-Version: 1.0
X-Received: by 2002:a6b:f308:0:b0:6c7:affe:7a12 with SMTP id
 m8-20020a6bf308000000b006c7affe7a12mr8531799ioh.124.1668573633560; Tue, 15
 Nov 2022 20:40:33 -0800 (PST)
Date:   Tue, 15 Nov 2022 20:40:33 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b5c7dc05ed8f124c@google.com>
Subject: [syzbot] BUG: corrupted list in dst_init
From:   syzbot <syzbot+ebd1a02208026c9e5722@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com
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

HEAD commit:    1621b6eaebf7 Merge branch 'for-next/fixes' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=16c34435880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=606e57fd25c5c6cc
dashboard link: https://syzkaller.appspot.com/bug?extid=ebd1a02208026c9e5722
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1508d766880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=114bd8e6880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/82aa7741098d/disk-1621b6ea.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f6be08c4e4c2/vmlinux-1621b6ea.xz
kernel image: https://storage.googleapis.com/syzbot-assets/296b6946258a/Image-1621b6ea.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ebd1a02208026c9e5722@syzkaller.appspotmail.com

list_add corruption. next->prev should be prev (ffff0000ce522608), but was 0000000000000000. (next=ffff0000cde85e00).
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:29!
Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 3036 Comm: kworker/1:4 Not tainted 6.1.0-rc4-syzkaller-31872-g1621b6eaebf7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
Workqueue: mld mld_ifc_work
pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __list_add_valid+0x9c/0xb8 lib/list_debug.c:27
lr : __list_add_valid+0x9c/0xb8 lib/list_debug.c:27
sp : ffff800012bfba40
x29: ffff800012bfba40 x28: 00007bfdfe1edc60 x27: 0000000000000015
x26: ffff0000ce5225b0 x25: ffff0000c3d82d70 x24: ffff0000ce522000
x23: ffff0000cde85e00 x22: ffff0000c3f5cd80 x21: ffff0000ce522608
x20: 0000000000000000 x19: ffff0000ce5225b8 x18: 00000000000000c0
x17: 3830363232356563 x16: ffff80000db1a158 x15: ffff0000c4f44ec0
x14: 0000000000000000 x13: 00000000ffffffff x12: ffff0000c4f44ec0
x11: ff808000081c06c8 x10: 0000000000000000 x9 : 6e082120c18aba00
x8 : 6e082120c18aba00 x7 : ffff80000c01775c x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : ffff0001fefddcc8 x1 : 0000000100000001 x0 : 0000000000000075
Call trace:
 __list_add_valid+0x9c/0xb8 lib/list_debug.c:27
 __list_add include/linux/list.h:69 [inline]
 list_add include/linux/list.h:88 [inline]
 ref_tracker_alloc+0x118/0x280 lib/ref_tracker.c:95
 __netdev_tracker_alloc include/linux/netdevice.h:3995 [inline]
 netdev_hold include/linux/netdevice.h:4024 [inline]
 dst_init+0x98/0x17c net/core/dst.c:52
 dst_alloc+0x118/0x158 net/core/dst.c:96
 ip6_dst_alloc net/ipv6/route.c:344 [inline]
 icmp6_dst_alloc+0x54/0x22c net/ipv6/route.c:3261
 mld_sendpack+0x348/0x864 net/ipv6/mcast.c:1809
 mld_send_cr+0x4e8/0x5a8 net/ipv6/mcast.c:2121
 mld_ifc_work+0x38/0x290 net/ipv6/mcast.c:2653
 process_one_work+0x2d8/0x504 kernel/workqueue.c:2289
 worker_thread+0x340/0x610 kernel/workqueue.c:2436
 kthread+0x12c/0x158 kernel/kthread.c:376
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:863
Code: b001b0e0 9132ac00 aa0803e1 94a8304b (d4210000) 
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
