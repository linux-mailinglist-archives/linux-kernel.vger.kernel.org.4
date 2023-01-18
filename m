Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37561671541
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 08:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjARHoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 02:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbjARHm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 02:42:28 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C2010D4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 23:06:23 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id h24-20020a056e021d9800b0030be8a5dd68so24650525ila.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 23:06:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xoLVD7DSv10r8m9BhvDHnO2YyQGVzS0+5ft4DDuxF0g=;
        b=q+ib++z4MjmRM7XpvUW3hB68lzxJ7jDZtiQPtMqbeuTZ+jU9UGu/Nwx5N1WWBOnimt
         EIZu9OlPlNIP7r28gwf/dSWpNq+8JZuaBRBGR7oSLnvPtW8Muq1LQCh+e6T/KHpuXgEW
         FHDPkDaTiB63TZ87hbJcITxkY9L4nt+GtEcZbhCT43z+a7PSldvKa0Bx5mm7ffoPaSlI
         PcDSOZl+hq8wkj8T3ifnujH0dR/PyqYWrxPBdfw4031nv5m+xlvFkkUQHu/0EpbJ/1w8
         NgH+VW0Q+lKzVpPrRR7Eyu5vdewN1pFcbicZm7QoKPiZwylN4mW/61/UbWCesT9lY+f9
         l3cQ==
X-Gm-Message-State: AFqh2krM2pRJiWNapg+LgQMFsHrRXPsaQviAVc1s3bOC4QTR9NERWyzT
        hTYzuIy9QN2lX8lVjpq5pYk9iTQNoGnEMIMn1tG1RWA4wH5/
X-Google-Smtp-Source: AMrXdXuydZc7a8azcHLNp4H8q/6tuxHNHkD2zDF3mMPSwz7NEZwJpFD+/WMi6shFmNLCOVlBxD506WsMkhmM7ezmhaRyvo0gyxUl
MIME-Version: 1.0
X-Received: by 2002:a05:6638:41a4:b0:38a:3770:2fa2 with SMTP id
 az36-20020a05663841a400b0038a37702fa2mr536114jab.208.1674025582441; Tue, 17
 Jan 2023 23:06:22 -0800 (PST)
Date:   Tue, 17 Jan 2023 23:06:22 -0800
In-Reply-To: <20230118055330.2780-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002fbfee05f2847467@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in snd_pcm_post_stop
From:   syzbot <syzbot+e29d28728f38190cecfc@syzkaller.appspotmail.com>
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
WARNING in io_ring_exit_work

------------[ cut here ]------------
WARNING: CPU: 1 PID: 75 at io_uring/io_uring.c:2977 io_ring_exit_work+0x320/0xc80 io_uring/io_uring.c:2977
Modules linked in:
CPU: 0 PID: 75 Comm: kworker/u4:4 Not tainted 6.2.0-rc3-next-20230112-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/12/2023
Workqueue: events_unbound io_ring_exit_work
RIP: 0010:io_ring_exit_work+0x320/0xc80 io_uring/io_uring.c:2977
Code: 40 8c e8 57 f4 02 f8 48 8b 05 f0 59 74 02 31 ff 4c 8b 74 24 10 49 29 c6 4c 89 f6 e8 8e 21 b5 f7 4d 85 f6 79 10 e8 b4 24 b5 f7 <0f> 0b 48 c7 44 24 08 70 17 00 00 e8 a4 24 b5 f7 48 8b 74 24 08 48
RSP: 0018:ffffc900020afbd0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88807e004838 RCX: 0000000000000000
RDX: ffff888018ca57c0 RSI: ffffffff89cc982c RDI: 0000000000000007
RBP: ffff88807e004000 R08: 0000000000000007 R09: 0000000000000000
R10: fffffffffffffff9 R11: 0000000000000000 R12: dffffc0000000000
R13: ffff88807e004040 R14: fffffffffffffff9 R15: ffff88807e0043c8
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055a8f42b70c0 CR3: 000000000c571000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 process_one_work+0x9bf/0x1750 kernel/workqueue.c:2293
 worker_thread+0x669/0x1090 kernel/workqueue.c:2440
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>


Tested on:

commit:         0a093b28 Add linux-next specific files for 20230112
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=111bfc46480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=835f3591019836d5
dashboard link: https://syzkaller.appspot.com/bug?extid=e29d28728f38190cecfc
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=111aca96480000

