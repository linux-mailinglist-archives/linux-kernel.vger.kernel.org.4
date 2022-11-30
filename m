Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828C863E273
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 22:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiK3VEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 16:04:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiK3VEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 16:04:47 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E928564A
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 13:04:46 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id y5-20020a056602120500b006cf628c14ddso12207881iot.15
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 13:04:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=89sbABjXCnZH4rHUsQouUWbZShKKn3HNAgo04khDjF0=;
        b=dgPk9hGwthnOec0ym3tKPAbwG3XpjteEKK/dwBiEmNexWaiHxYWUNWsq+6MlLCcQ7V
         ijxuuQj+zd0mTL7t5iw13Qs4zQj3aCjdXF56/vK/6Er6dDxNdyJs8iQ5VWyEiDcglc51
         ZeoHzzd8z7zPcfuVe2xPyNC/urWgB0WIyRbParYXi2p9JcHxlu0mTChWRwdI5wT2ie8u
         1uf2BPIW/MOZ1ICh0SNEHvKURr8vbb5C1IMH0pTUqTeqStz2+8jEfDMnIYoRpVe3cMJH
         MQ0PkVoDLRraZpLn3JD5Malv1fNRH0L6sTeBtlYTqjS/ljdtqy7Kz7mq7NqWBb3IXJpu
         I+dg==
X-Gm-Message-State: ANoB5pkIaPSffnKz4P8XpjlXPpTb5DWrnYaullz+s7Wk9P8O4QlCDkqY
        fyqUCHB1btKj1Vmk+b2TAw2umAB5TW7fVLERXkokz04NSWkx
X-Google-Smtp-Source: AA0mqf43jZ4g690rvZr5Mo8EMdXW7RO1NQl7RA76ZsUPzBqq85HRrsiZAApQss8r9zOAZjigK6n8LSvyLVDvNcJSksggnLgWEPPu
MIME-Version: 1.0
X-Received: by 2002:a92:dc90:0:b0:303:17f1:4187 with SMTP id
 c16-20020a92dc90000000b0030317f14187mr7208843iln.132.1669842286075; Wed, 30
 Nov 2022 13:04:46 -0800 (PST)
Date:   Wed, 30 Nov 2022 13:04:46 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004ae78f05eeb6747e@google.com>
Subject: [syzbot] kernel panic: stack is corrupted in hfs_cat_create
From:   syzbot <syzbot+d529529a4a1ae87f439d@syzkaller.appspotmail.com>
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

HEAD commit:    6d464646530f Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=10c6a755880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=23eec5c79c22aaf8
dashboard link: https://syzkaller.appspot.com/bug?extid=d529529a4a1ae87f439d
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1096a7fd880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12c3064b880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f22d29413625/disk-6d464646.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/389f0a5f1a4a/vmlinux-6d464646.xz
kernel image: https://storage.googleapis.com/syzbot-assets/48ddb02d82da/Image-6d464646.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/4feb79cebaef/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d529529a4a1ae87f439d@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 64
Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: hfs_cat_create+0x358/0x358
CPU: 0 PID: 3072 Comm: syz-executor321 Not tainted 6.1.0-rc6-syzkaller-32662-g6d464646530f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
Call trace:
 dump_backtrace+0x1c4/0x1f0 arch/arm64/kernel/stacktrace.c:156
 show_stack+0x2c/0x54 arch/arm64/kernel/stacktrace.c:163
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x104/0x16c lib/dump_stack.c:106
 dump_stack+0x1c/0x58 lib/dump_stack.c:113
 panic+0x218/0x508 kernel/panic.c:274
 warn_bogus_irq_restore+0x0/0x40 kernel/panic.c:703
 hfs_cat_build_record+0x0/0x130
 0x50006f3faf19523b
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
