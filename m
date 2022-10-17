Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23EA6005BE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 05:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbiJQDXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 23:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbiJQDXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 23:23:31 -0400
X-Greylist: delayed 1503 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 16 Oct 2022 20:23:29 PDT
Received: from scorn.kernelslacker.org (scorn.kernelslacker.org [IPv6:2600:3c03:e000:2fb::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11AE4DB33
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 20:23:29 -0700 (PDT)
Received: from [2601:196:4600:6634:ae9e:17ff:feb7:72ca] (helo=wopr.kernelslacker.org)
        by scorn.kernelslacker.org with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <davej@codemonkey.org.uk>)
        id 1okGKc-007coP-MK; Sun, 16 Oct 2022 22:58:22 -0400
Received: by wopr.kernelslacker.org (Postfix, from userid 1026)
        id 02DA056008D; Sun, 16 Oct 2022 22:58:21 -0400 (EDT)
Date:   Sun, 16 Oct 2022 22:58:21 -0400
From:   Dave Jones <davej@codemonkey.org.uk>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: 6.1rc1: NFS memcpy warning on mount
Message-ID: <Y0zEzZwhOxTDcBTB@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <CAHk-=wj6y5fipM2A5kEuOO9qm5PBzUY=-m9viEahhtxT09KR_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj6y5fipM2A5kEuOO9qm5PBzUY=-m9viEahhtxT09KR_g@mail.gmail.com>
X-Spam-Note: SpamAssassin invocation failed
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Started getting this during mount on a 6.1rc1 kernel..
not sure which mount it's complaining about, but they're all v3 tcp
mounts on that machine.

[   19.617475] memcpy: detected field-spanning write (size 28) of single field "request.sap" at fs/nfs/super.c:857 (size 18446744073709551615)
[   19.617504] WARNING: CPU: 3 PID: 1300 at fs/nfs/super.c:857 nfs_request_mount.constprop.0.isra.0+0x1c0/0x1f0
[   19.617528] CPU: 3 PID: 1300 Comm: mount.nfs Not tainted 6.1.0-rc1-backup+ #1
[   19.617553] RIP: 0010:nfs_request_mount.constprop.0.isra.0+0x1c0/0x1f0
[   19.617566] Code: 16 81 01 00 75 9b 48 c7 c1 ff ff ff ff 48 c7 c2 a8 a8 82 ab 4c 89 e6 c6 05 36 16 81 01 01 48 c7 c7 a8 3a 81 ab e8 61 1d 9a 00 <0f> 0b 48 8b 3c 24 e9 6c ff ff ff c7 83 20 01 00 00 01 00 00 00 b8
[   19.617593] RSP: 0018:ffffc900027fbd48 EFLAGS: 00010286
[   19.617604] RAX: 0000000000000000 RBX: ffff8881208d5000 RCX: ffff88842fadb7a8
[   19.617617] RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffff88842fadb7a0
[   19.617629] RBP: ffff8881208d5130 R08: 0000000000000000 R09: ffffffffaba5c540
[   19.617641] R10: 0000000000000001 R11: 0000000000000001 R12: 000000000000001c
[   19.617653] R13: 0000000000000001 R14: ffffc900027fbef0 R15: ffff888100b3bea0
[   19.617665] FS:  00007ff793dd6840(0000) GS:ffff88842fac0000(0000) knlGS:0000000000000000
[   19.617679] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   19.617690] CR2: 0000564a1a747468 CR3: 00000001106fb003 CR4: 00000000001706e0
[   19.617703] Call Trace:
[   19.617709]  <TASK>
[   19.617716]  nfs_try_get_tree+0xa1/0x220
[   19.617725]  ? get_nfs_version+0x63/0x130
[   19.617736]  vfs_get_tree+0x1d/0x90
[   19.617746]  ? capable+0x2f/0x50
[   19.617755]  path_mount+0x75c/0xb00
[   19.617766]  __x64_sys_mount+0x19a/0x200
[   19.617775]  do_syscall_64+0x35/0x80
[   19.617785]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
[   19.617796] RIP: 0033:0x7ff7941ac6ea
[   19.617805] Code: 48 8b 0d a9 17 0d 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 76 17 0d 00 f7 d8 64 89 01 48
[   19.617832] RSP: 002b:00007ffd02ae4ce8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
[   19.617846] RAX: ffffffffffffffda RBX: 00007ffd02ae4e70 RCX: 00007ff7941ac6ea
[   19.617858] RDX: 0000564a1a73fb60 RSI: 0000564a1a73fb80 RDI: 0000564a1a741890
[   19.617870] RBP: 00007ff793dd67b8 R08: 0000564a1a73f480 R09: 0000564a1a73f480
[   19.617882] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[   19.617894] R13: 00007ffd02ae4dd0 R14: 0000564a1a7474e0 R15: 0000564a1a7436b0
[   19.617907]  </TASK>
[   19.617913] irq event stamp: 8757
[   19.617920] hardirqs last  enabled at (8769): [<ffffffffaa1397c2>] __up_console_sem+0x52/0x60
[   19.617937] hardirqs last disabled at (8780): [<ffffffffaa1397a7>] __up_console_sem+0x37/0x60
[   19.617952] softirqs last  enabled at (8180): [<ffffffffaabf547a>] sk_common_release+0x5a/0xe0
[   19.617969] softirqs last disabled at (8178): [<ffffffffaabf5456>] sk_common_release+0x36/0xe0
[   19.617984] ---[ end trace 0000000000000000 ]---

	Dave
