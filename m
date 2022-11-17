Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D82E62D895
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 11:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239444AbiKQKy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 05:54:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239410AbiKQKxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 05:53:21 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824865B85A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 02:53:17 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id a15-20020a056e0208af00b00300806a52b6so971802ilt.22
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 02:53:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w6CLodQKWDUJPKbdKwqg+PIfc9tIm/vugNt67SeEXWc=;
        b=HSoYddTvKhZVOUEdWf0BMLjO+sezjeZAB2xsE/KHPj8XIR0uDCiDb9CjRwZCbuRmxQ
         dGZup3Jh8pptQEcltJVbkTuetXsVO11psANmRPF67c89OraqrDppoM3MEGOgTHb9TVqW
         yl3xmDPtXJk/GRjXtCYds1FKuu7T5m4gmdD9T1MJZZNEPexQ2SMSjc0SnIMmM2IwBD7B
         qPrrDxLVijjjFMecCFJGvOIAuJufMj1+FuSOhvaer/nveUzJwBvAGQzhfj8C/i2qXHnz
         //dWUOpNEAEHSLevqiZLNxbdcarLkAG/sBn0dwULmbDt+ylFwJV6Aq5cCpumy3LujAw/
         UZYg==
X-Gm-Message-State: ANoB5plMWtYER/Ju02Y7XQC4km6NLqOmBTkb7uSQ2JUE//UJPC7Faa5X
        d41mU2vQX1im/Nx91KcfkW7Gs2epHHObIO4NImiNxNTwReFz
X-Google-Smtp-Source: AA0mqf7lI8dtPVstMIXa1wbfMoReX0b3hbm4s4Yu0oo/G2WwZrQsqNELK+8sDTTJVo4WaGo9l5A/eyDKjyeTRRKPCBCJGI8j/Ie+
MIME-Version: 1.0
X-Received: by 2002:a6b:f414:0:b0:6d1:88ee:a64f with SMTP id
 i20-20020a6bf414000000b006d188eea64fmr1019803iog.61.1668682396847; Thu, 17
 Nov 2022 02:53:16 -0800 (PST)
Date:   Thu, 17 Nov 2022 02:53:16 -0800
In-Reply-To: <20221117095316.3682-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000081d4bc05eda8651b@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in netdev_core_pick_tx
From:   syzbot <syzbot+10a7a8ca6e94600110ec@syzkaller.appspotmail.com>
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
WARNING in default_device_exit_batch

device veth1_macvtap left promiscuous mode
device veth0_macvtap left promiscuous mode
device veth1_vlan left promiscuous mode
device veth0_vlan left promiscuous mode
bond6 (unregistering): Released all slaves
------------[ cut here ]------------
WARNING: CPU: 0 PID: 45 at net/core/dev.c:10770 unregister_netdevice_many+0x1421/0x1950
Modules linked in:
CPU: 1 PID: 45 Comm: kworker/u4:2 Not tainted 5.18.0-rc7-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Workqueue: netns cleanup_net
RIP: 0010:unregister_netdevice_many+0x1421/0x1950 net/core/dev.c:10770
Code: 74 08 48 89 df e8 7f 68 ae f9 48 8b 1b 48 89 5c 24 40 4c 39 fb 0f 84 0c 01 00 00 e8 a9 80 5d f9 e9 64 f6 ff ff e8 9f 80 5d f9 <0f> 0b e9 2a ff ff ff e8 93 80 5d f9 0f 0b e9 7a ff ff ff e8 87 80
RSP: 0018:ffffc90000b678e0 EFLAGS: 00010293
RAX: ffffffff88289461 RBX: ffff888016ea00a0 RCX: ffff888017138000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc90000b67a50 R08: ffffffff88289345 R09: fffffbfff1b74a89
R10: fffffbfff1b74a89 R11: 1ffffffff1b74a88 R12: ffff888023fb8e80
R13: 0000000000000002 R14: dffffc0000000000 R15: ffffc90000b67ae0
FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc044717a70 CR3: 0000000074978000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 default_device_exit_batch+0x660/0x6d0 net/core/dev.c:11241
 ops_exit_list net/core/net_namespace.c:167 [inline]
 cleanup_net+0x80c/0xc50 net/core/net_namespace.c:594
 process_one_work+0x81c/0xd10 kernel/workqueue.c:2289
 worker_thread+0xb14/0x1330 kernel/workqueue.c:2436
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30
 </TASK>


Tested on:

commit:         42226c98 Linux 5.18-rc7
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16c9e702880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d84df8e1a4c4d5a4
dashboard link: https://syzkaller.appspot.com/bug?extid=10a7a8ca6e94600110ec
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=134b9a95880000

