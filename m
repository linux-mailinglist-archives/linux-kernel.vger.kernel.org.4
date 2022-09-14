Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B145B8DEA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 19:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiINROk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 13:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiINROh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 13:14:37 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154C76167
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 10:14:35 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id e4-20020a5d85c4000000b0068bb3c11e72so9299729ios.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 10:14:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=yH99aNpoXPus2YSVzO88ftQqBGTGzN3j5UFnOiT8ikA=;
        b=tvmf08h4qMHLBqud8eIgqA9QN98lBW5VBGm7TTB2DPH/z6kh5C5/9XA0U8SB+3arX5
         Kqfmht5U0YKu6h52IBuM8bfESPhzX15Dg0acNJ6sl3fwMqg7Ht4ozEvLw5QugtDVYxdd
         neukymoMaQeLyJT9xXceh7ukwEgQBl8h0Ffty4rV2fbp3lXcjSsNVocZuMl2J5AIgDtA
         VN07v0GEnx8Ng+dm0mBy8CQQv8MdHx++h3oZ6jLTziT8iCSZE0prlcKW81vz6tFkVatL
         QYuktc/Is51sQWFPYV0TFhZ3JQ3Q37HtimHUJBATDBCFbQ6t7NerRM/oo04MMnLXCvXW
         7aaA==
X-Gm-Message-State: ACgBeo3gVXfpnIa0Sx8Qbmz5a4eOEu1rk3Qj0vAOWKV38kdccbGUA/rR
        dmc4q4ibnI+JK79MYLCq1JPVBIupFD3dpXNBLlIQuspn9q+C
X-Google-Smtp-Source: AA6agR4aaLsjBm25jXwr5vcbxVekdLEqsBZskTYJjP1iud/yGdDv3CTAqBVXA8kNenQig2nwFA8BYorjBCAfVQcr30oaeaP9IziB
MIME-Version: 1.0
X-Received: by 2002:a92:6912:0:b0:2ea:fa2e:462d with SMTP id
 e18-20020a926912000000b002eafa2e462dmr15025303ilc.155.1663175674437; Wed, 14
 Sep 2022 10:14:34 -0700 (PDT)
Date:   Wed, 14 Sep 2022 10:14:34 -0700
In-Reply-To: <0000000000000149eb05dd3de8cc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000462c3d05e8a643e0@google.com>
Subject: Re: [syzbot] KASAN: slab-out-of-bounds Read in ntfs_iget5
From:   syzbot <syzbot+b4084c18420f9fad0b4f@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        nathan@kernel.org, ndesaulniers@google.com, ntfs3@lists.linux.dev,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    a6b443748715 Merge branch 'for-next/core', remote-tracking..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=15625dbf080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=14bf9ec0df433b27
dashboard link: https://syzkaller.appspot.com/bug?extid=b4084c18420f9fad0b4f
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1482f778880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10d9e35d080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b4084c18420f9fad0b4f@syzkaller.appspotmail.com

ntfs3: loop0: Different NTFS' sector size (4096) and media sector size (512)
ntfs3: loop0: RAW NTFS volume: Filesystem size 0.00 Gb > volume size 0.00 Gb. Mount in read-only
Unable to handle kernel paging request at virtual address dead4ead00000010
Mem abort info:
  ESR = 0x0000000096000004
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x04: level 0 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000004
  CM = 0, WnR = 0
[dead4ead00000010] address between user and kernel address ranges
Internal error: Oops: 96000004 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 3051 Comm: syz-executor281 Not tainted 6.0.0-rc4-syzkaller-17255-ga6b443748715 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : ntfs_iget5+0x88/0x138c fs/ntfs3/inode.c:502
lr : ntfs_iget5+0x78/0x138c fs/ntfs3/inode.c:500
sp : ffff80001275ba40
x29: ffff80001275bae0 x28: ffff0000cb374000 x27: ffff0000c90ce000
x26: ffff80001275bb70 x25: 0000000000000024 x24: ffff80000c1300b4
x23: ffff0000cb3761a8 x22: ffff0000ca8c8250 x21: ffff0000ca8c9708
x20: 0000000000000002 x19: ffff0000ca8c1a30 x18: 00000000000000c0
x17: ffff80000dd3a698 x16: ffff80000db78658 x15: ffff0000c71eb500
x14: ffff80000dd3a698 x13: ffff80000db78658 x12: ffff0000c71eb500
x11: ff80800008bf1798 x10: 0000000000000000 x9 : ffff0000c71eb500
x8 : dead4ead00000000 x7 : ffff8000085eb4a0 x6 : 0000000000000000
x5 : 0000000000000020 x4 : ffff80001275b690 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 ntfs_iget5+0x88/0x138c fs/ntfs3/inode.c:502
 ntfs_fill_super+0xbe8/0x14a4 fs/ntfs/super.c:2902
 get_tree_bdev+0x1e8/0x2a0 fs/super.c:1323
 ntfs_fs_get_tree+0x28/0x38 fs/ntfs3/super.c:1358
 vfs_get_tree+0x40/0x140 fs/super.c:1530
 do_new_mount+0x1dc/0x4e4 fs/namespace.c:3040
 path_mount+0x358/0x914 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __arm64_sys_mount+0x2f8/0x408 fs/namespace.c:3568
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:624
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:642
 el0t_64_sync+0x18c/0x190
Code: 37180194 d108c268 f9400108 79400f54 (79402115) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	37180194 	tbnz	w20, #3, 0x30
   4:	d108c268 	sub	x8, x19, #0x230
   8:	f9400108 	ldr	x8, [x8]
   c:	79400f54 	ldrh	w20, [x26, #6]
* 10:	79402115 	ldrh	w21, [x8, #16] <-- trapping instruction

