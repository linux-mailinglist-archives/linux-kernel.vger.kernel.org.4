Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494C36ADEA7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 13:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbjCGM0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 07:26:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbjCGMZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 07:25:59 -0500
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F885617F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 04:25:42 -0800 (PST)
Received: by mail-io1-f79.google.com with SMTP id i2-20020a5d9e42000000b0074cfcc4ed07so7113130ioi.22
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 04:25:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678191941;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KdhJ/+h1ma2QjcRI282C69n66OwlZ8i2BeR/12hbaTc=;
        b=bQkb7ggSStsjeFCTeSdS1i0yFmjfkQG84hLyiwfpL19e7yfElFT56wqTDh5yZQoHl9
         6sUxtIrEwp3eRQbE/wsQAKV0Nd5Eh/LNnUAtdSKu0lwMoIS0wMTV4ILvivUtRG623wVB
         sfiOFxgkoEVFi9uSYOxosCfblXD6vFMAUKtnQyhlL2o/6mbiNe1mbLxPqRRbaJWV2LMC
         D3onD+mZ+L+33Ab8TPzIluGvsDsUvO7mv688ZtkUou6TlMhdxhGAg0P+U9MQIZcNSs+g
         dLetuYH/RRiWwVAAHGndQhrTNE/DUV0+rdMhVaLdGjhCchhzW1xHvzKYoiMTu4T0f3Gg
         SNfQ==
X-Gm-Message-State: AO0yUKVSksvV7eBmSV/oO4V5FDYDCpXDUPrGuGTu+ph82wrQ29QUiY0y
        IhKQgnNdC/uPWMMJemtCXf/m2o19XEf0MKnqq58Sa4kztAMI
X-Google-Smtp-Source: AK7set/rzEvxhpAWG7X/fwbQjfBQqi4KbxvnLayCvnnVwOhq516MUT+qmCfFoUQ6OqU+SM7NwBcp2DZuXEZjc8LAyv99JJHoVVZv
MIME-Version: 1.0
X-Received: by 2002:a6b:907:0:b0:74c:c0b2:953f with SMTP id
 t7-20020a6b0907000000b0074cc0b2953fmr7225192ioi.3.1678191941356; Tue, 07 Mar
 2023 04:25:41 -0800 (PST)
Date:   Tue, 07 Mar 2023 04:25:41 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000087942f05f64e8201@google.com>
Subject: [syzbot] [kernel?] memory leak in copy_process (5)
From:   syzbot <syzbot+7699d9e5635c10253a27@syzkaller.appspotmail.com>
To:     brauner@kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    2eb29d59ddf0 Merge tag 'drm-next-2023-03-03-1' of git://an..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14b0efacc80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5733ca1757172ad
dashboard link: https://syzkaller.appspot.com/bug?extid=7699d9e5635c10253a27
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14cb6df2c80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=177b81e4c80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5842412a6a16/disk-2eb29d59.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8a7aa4fe354c/vmlinux-2eb29d59.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6f5ae775a65a/bzImage-2eb29d59.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7699d9e5635c10253a27@syzkaller.appspotmail.com

Warning: Permanently added '10.128.0.246' (ECDSA) to the list of known hosts.
executing program
executing program
BUG: memory leak
unreferenced object 0xffff8881053e7f80 (size 128):
  comm "syz-executor242", pid 5066, jiffies 4294946079 (age 13.220s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff812ae26a>] alloc_pid+0x6a/0x560 kernel/pid.c:180
    [<ffffffff812718df>] copy_process+0x169f/0x26c0 kernel/fork.c:2285
    [<ffffffff81272b37>] kernel_clone+0xf7/0x610 kernel/fork.c:2684
    [<ffffffff812730cc>] __do_sys_clone+0x7c/0xb0 kernel/fork.c:2825
    [<ffffffff849ad699>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff849ad699>] do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84a0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
