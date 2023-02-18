Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6EE69B823
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 06:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjBRF2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 00:28:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBRF21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 00:28:27 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95E242DC1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 21:28:26 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id f5-20020a056602070500b007407df88db0so1670214iox.23
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 21:28:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QiQ2iFuiOIlVOCV/RHCHymN7CiC9w44gVNhD484zSfE=;
        b=L65P6JZcRizsHt8zTTrs81XJevZG4MpxWBNYaEKpEDWFdDOrU15xqZVIVr4v9DJQwn
         D5cgpQ7oqCE4+liA/2uuXMB5c1Z34ldmaJuM46L/zzTFUDFlGjQ8XoYjB8jHh++majbL
         qnzWJdHFDJq7lfB9BTdzqe/JiHgMdAI3ZyaBpwhykVmT0q+oX+waZGaUHdZm//Bap8oP
         aDT/uiOoo6yHq3E1k2yqlmpbK6TpvLR0Tx8EERfRyM+8Lty/M/yM4jgzS/6Xlvv/xek6
         GuIE5I9CZI84IkHGx6IkV5mgRMcSRIdsvFFZuJ6/LdWUv19E87fQPN7vSHT01+zuB5Vd
         UhRQ==
X-Gm-Message-State: AO0yUKWeD54PKjnk587csmOdxk6ify1hc72Sh4oaNVJAsNIYgawoT6Jg
        qs0F6tnhGU9uEBitx02BjA0hJycR2P1Bo3U7yCrSErW5b66e
X-Google-Smtp-Source: AK7set/HmxhHMrvBP42tQziKXRfzwr03JaDcP3zBEK8e0Q2VBL4Aae4LHHl4y6bzMe1RtS74jJroG9Ova+w1iU74qOgy0XxjS9G2
MIME-Version: 1.0
X-Received: by 2002:a6b:c419:0:b0:71c:1bd4:b768 with SMTP id
 y25-20020a6bc419000000b0071c1bd4b768mr178944ioa.84.1676698106230; Fri, 17 Feb
 2023 21:28:26 -0800 (PST)
Date:   Fri, 17 Feb 2023 21:28:26 -0800
In-Reply-To: <20230218015238.1838-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000047b7c05f4f2b345@google.com>
Subject: Re: [syzbot] [bridge?] [coreteam?] KASAN: vmalloc-out-of-bounds Read
 in __ebt_unregister_table
From:   syzbot <syzbot+f61594de72d6705aea03@syzkaller.appspotmail.com>
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
KASAN: vmalloc-out-of-bounds Read in __ebt_unregister_table

==================================================================
BUG: KASAN: vmalloc-out-of-bounds in __ebt_unregister_table+0xc0d/0xd00 net/bridge/netfilter/ebtables.c:1169
Read of size 4 at addr ffffc9000309c000 by task kworker/u4:5/1164

CPU: 0 PID: 1164 Comm: kworker/u4:5 Not tainted 6.2.0-rc8-syzkaller-00083-g3ac88fa4605e-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/21/2023
Workqueue: netns cleanup_net
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd1/0x138 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:306 [inline]
 print_report+0x15e/0x45d mm/kasan/report.c:417
 kasan_report+0xbf/0x1f0 mm/kasan/report.c:517
 __ebt_unregister_table+0xc0d/0xd00 net/bridge/netfilter/ebtables.c:1169
 ebt_unregister_table+0x3a/0x50 net/bridge/netfilter/ebtables.c:1375
 ops_exit_list+0xb0/0x170 net/core/net_namespace.c:169
 cleanup_net+0x4ee/0xb10 net/core/net_namespace.c:613
 process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
 worker_thread+0x669/0x1090 kernel/workqueue.c:2436
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>

Memory state around the buggy address:
 ffffc9000309bf00: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc9000309bf80: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
>ffffc9000309c000: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
                   ^
 ffffc9000309c080: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc9000309c100: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
==================================================================


Tested on:

commit:         3ac88fa4 Merge tag 'net-6.2-final' of git://git.kernel..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1126d8f7480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fe56f7d193926860
dashboard link: https://syzkaller.appspot.com/bug?extid=f61594de72d6705aea03
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1274f127480000

