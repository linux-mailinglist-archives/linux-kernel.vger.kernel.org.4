Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E19655890
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 06:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbiLXF6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 00:58:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiLXF6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 00:58:32 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4259311A05
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 21:58:31 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id h9-20020a92c269000000b00303494c4f3eso3667217ild.15
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 21:58:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ccPAkKh6VRAWfW9CvYc2pSlVZ7nRt/UwqQWtOX0Glo=;
        b=FMxnbc9bv5CCLdV5gk2vH8IPJ52xYWj4OF9Zddax6EsdOo+UcmnXTai04JHa5BipCC
         OPtZwie2z3aRoQVvTiNOFgtCacqpgvXVgBkdDAYvWs/B3D1uzsWUyTg08HnL4GY6GjAQ
         NkXlaq8rtz1dPVZJQWsTX4qUAEefwIkmiT/Dpaow7/o5HMeXcav75ZJbVpBw61eoLh6D
         WR54UluxY8UNDy3Vn+HIlvJTLg3bUkyD+k8eQDdvuRb9S5oCIfVT9m7jeqLkt95pKMar
         aoee/fF9p4IPEd0KFLX28Mfg9yz0ULYqsu6lDyMysDsvKtFm+F41/rHO5cauFI4s10DI
         Acrg==
X-Gm-Message-State: AFqh2ko2ODlSuIlciKMNrcy7437HEFkOa80bgloAlXPyek+bBMkIGExr
        YBIR0mRA99jg/iLsdIESW0OVO1xZMH/Blb4FiZm/EyLcJVIr
X-Google-Smtp-Source: AMrXdXsajYZzj1x4h9Ao4zBDfUwXaavd+cCjSmrFcalRPO3mKAJ6sNxMLsjbjz3yx4tUg6RY7/rTVYkoLx7E+Q6kSqL8SpVqbujL
MIME-Version: 1.0
X-Received: by 2002:a6b:f801:0:b0:6e3:134:3a97 with SMTP id
 o1-20020a6bf801000000b006e301343a97mr887582ioh.64.1671861510633; Fri, 23 Dec
 2022 21:58:30 -0800 (PST)
Date:   Fri, 23 Dec 2022 21:58:30 -0800
In-Reply-To: <000000000000abc46005e9f9e943@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007483a605f08c97a2@google.com>
Subject: Re: [syzbot] [jfs?] kernel BUG in txUnlock
From:   syzbot <syzbot+a63afa301d1258d09267@syzkaller.appspotmail.com>
To:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    a5541c0811a0 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=11fbab64480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cbd4e584773e9397
dashboard link: https://syzkaller.appspot.com/bug?extid=a63afa301d1258d09267
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1779a650480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16346274480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4b7702208fb9/disk-a5541c08.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9ec0153ec051/vmlinux-a5541c08.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6f8725ad290a/Image-a5541c08.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/4aaac3b4e5ee/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a63afa301d1258d09267@syzkaller.appspotmail.com

BUG at fs/jfs/jfs_txnmgr.c:926 assert(mp->nohomeok > 0)
------------[ cut here ]------------
kernel BUG at fs/jfs/jfs_txnmgr.c:926!
Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 90 Comm: jfsCommit Not tainted 6.1.0-rc8-syzkaller-33330-ga5541c0811a0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : txUnlock+0x6f4/0x738 fs/jfs/jfs_txnmgr.c:926
lr : txUnlock+0x6f4/0x738 fs/jfs/jfs_txnmgr.c:926
sp : ffff80000fe93d30
x29: ffff80000fe93d70 x28: ffff800012902000 x27: 0000000000000002
x26: ffff80000efd4308 x25: ffff80000efd4000 x24: ffff0000cd24d000
x23: ffff80000efd4000 x22: 0000000000000048 x21: ffff80000efd42b4
x20: ffff80000efd4000 x19: 0000000000000000 x18: 00000000000000c0
x17: ffff80000dda8198 x16: ffff80000dbe6158 x15: ffff0000c0fd1a40
x14: 0000000000000000 x13: 00000000ffffffff x12: ffff0000c0fd1a40
x11: ff808000081c4d64 x10: 0000000000000000 x9 : 1da0f0d83d883600
x8 : 1da0f0d83d883600 x7 : ffff80000c091ebc x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : ffff0001fefddcd0 x1 : 0000000100000000 x0 : 0000000000000037
Call trace:
 txUnlock+0x6f4/0x738 fs/jfs/jfs_txnmgr.c:926
 txLazyCommit fs/jfs/jfs_txnmgr.c:2677 [inline]
 jfs_lazycommit+0x228/0x4b8 fs/jfs/jfs_txnmgr.c:2727
 kthread+0x12c/0x158 kernel/kthread.c:376
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:863
Code: 910d7021 91288c63 528073c2 94cbec2c (d4210000) 
---[ end trace 0000000000000000 ]---

