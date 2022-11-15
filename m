Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8934762AE98
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 23:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbiKOWt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 17:49:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238658AbiKOWtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 17:49:05 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9A72A726
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 14:48:46 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id j20-20020a056e02219400b00300a22a7fe0so12049669ila.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 14:48:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PZRfM6paNEn42pAs04dPr3vwwNPVW+jfdJDbudmuBF8=;
        b=bBrwmo+plPSQr3b6G8my57GZkAARmo37b+9mcAIZwdBwJhl81ioyEUnp/CqOtSq8wf
         xuVfq7Ck96RuGakx+eqg3NeHwrZ43YMRaOkIWr2I3I+WQpI1QS2hYWYdPuasFIdk5MIQ
         SrEh+DaiQEmAQFP4r3N9sCSP90NkjPs9cje0jlvbWbg2Nt4hvCG5pfQIx9WDtfu66ngo
         PhBd/kk07HAga3bU6Pz3mNpdhgEjq9mGmMjtE9KDx/PLBHZba7BCS98SnnXlyzjlZK24
         55SrZeIzFt7osGOWWvB2yQUtIgmqpLa6OBqCUONB5S9AbGmP8qyOcOWmz6i4TBrA1SPx
         e/aQ==
X-Gm-Message-State: ANoB5plG+WaiLEkuwkRLrTqINO0VJXloIrxPd1wyivwy0EAt+N+OP80B
        HtcBY3qdMSA5orTLxiy03n5r3C+VkelJJyx9l7k+AnzOXB31
X-Google-Smtp-Source: AA0mqf64SsyDvKMeHVrnmD2z2kZ6HxREsRlr2vB/TICdBf9yS30rH4ziUvUrHFck6VW5E3nJZVUmsVN1O+gMHT+6dOWJtgZ0JvAY
MIME-Version: 1.0
X-Received: by 2002:a6b:c88f:0:b0:6bb:e329:fcd7 with SMTP id
 y137-20020a6bc88f000000b006bbe329fcd7mr8676971iof.206.1668552525732; Tue, 15
 Nov 2022 14:48:45 -0800 (PST)
Date:   Tue, 15 Nov 2022 14:48:45 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000095e1b405ed8a284a@google.com>
Subject: [syzbot] kernel panic: stack is corrupted in __blk_flush_plug
From:   syzbot <syzbot+fade8a8e2bdc29b3a90b@syzkaller.appspotmail.com>
To:     broonie@kernel.org, catalin.marinas@arm.com,
        kaleshsingh@google.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, madvenka@linux.microsoft.com,
        mark.rutland@arm.com, maz@kernel.org,
        syzkaller-bugs@googlegroups.com, will@kernel.org
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

HEAD commit:    9e4ce762f0e7 Merge branches 'for-next/acpi', 'for-next/asm..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1502ad35880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=20ffacc1ce1c99b5
dashboard link: https://syzkaller.appspot.com/bug?extid=fade8a8e2bdc29b3a90b
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14f33159880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13e33ef1880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a70eb29add74/disk-9e4ce762.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/769d096516a8/vmlinux-9e4ce762.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9309615f51d5/Image-9e4ce762.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/0332fee8ec34/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fade8a8e2bdc29b3a90b@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 8226
ntfs3: loop0: Mark volume as dirty due to NTFS errors
ntfs3: loop0: Failed to load $Extend.
Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: __blk_flush_plug+0x1a4/0x1a4
CPU: 0 PID: 4370 Comm: syz-executor220 Not tainted 6.1.0-rc5-syzkaller-32254-g9e4ce762f0e7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
Call trace:
 dump_backtrace+0x1c4/0x1f0 arch/arm64/kernel/stacktrace.c:156
 show_stack+0x2c/0x54 arch/arm64/kernel/stacktrace.c:163
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x104/0x16c lib/dump_stack.c:106
 dump_stack+0x1c/0x58 lib/dump_stack.c:113
 panic+0x218/0x508 kernel/panic.c:274
 warn_bogus_irq_restore+0x0/0x40 kernel/panic.c:703
 blk_finish_plug+0x0/0x54
SMP: stopping secondary CPUs
Kernel Offset: disabled
CPU features: 0x00000,040e0108,4c017203
Memory Limit: none
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
