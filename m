Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329AD69BEE4
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 08:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjBSH3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 02:29:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBSH3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 02:29:18 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58D7D500
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 23:29:17 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id m23-20020a6bea17000000b007076e06ba3dso1139248ioc.20
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 23:29:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uor3y+OIZ1/fm+Dzx9qSE82tPDiXgyuaGAioMEv3br0=;
        b=Xh8GJutSlkpwr+Lfyvt2KjmQmwG6qpPcN9VdhbQ3enhkgzQKDgjqw29k32S7/hfA4a
         apmKDEJnQxTtQCfq245C5Q693Zc7rn27JCInAkNxPyBb3FXWcEYK0m9ePnhIHR6tKkua
         XJnaVriR4jmNIh2qBMOfTkNZh8bVrHzPNIY+3c40OEUb/fBOZHPCbYlNegQuvVZszv0V
         p4s8BcLbsitxsnRr+spuQ+MYP2cwkaESk2a3wd72c7nRyi4UwZ7f1RmlIdnlc1B9VpnF
         LvhrYLSTKnLb395ZvdTGln7JbmdGrthCQ6/OPEy+vDmJwngURr4kf5Zid8/ssA8oQvGo
         BHiw==
X-Gm-Message-State: AO0yUKWNM+1cCZyhnuGU26odWWW8yUk74zF2KdfMzYE33ZvJcujaxOT9
        GLlyiD0NGRckLneepajuAOulg8uHh2wPq9YCcsHZd36ZzD0F
X-Google-Smtp-Source: AK7set8baOwb0GB9XtGCBqZHd/WPV+JrUUQaMix04AlIV/JRNpuD7yv7BCf2RgRdtW8LXuEQ12zbPWf4aNmnuMJF0ilbQABb+f9F
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4184:b0:3a7:e46e:b15 with SMTP id
 az4-20020a056638418400b003a7e46e0b15mr4288347jab.2.1676791757270; Sat, 18 Feb
 2023 23:29:17 -0800 (PST)
Date:   Sat, 18 Feb 2023 23:29:17 -0800
In-Reply-To: <20230219071501.2166-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000dfa9605f5088119@google.com>
Subject: Re: [syzbot] [bridge?] [netfilter?] KASAN: vmalloc-out-of-bounds Read
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
BUG: KASAN: vmalloc-out-of-bounds in __ebt_unregister_table+0xc00/0xcd0 net/bridge/netfilter/ebtables.c:1175
Read of size 4 at addr ffffc90003755000 by task kworker/u4:2/41

CPU: 0 PID: 41 Comm: kworker/u4:2 Not tainted 6.2.0-rc8-syzkaller-00083-g3ac88fa4605e-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/21/2023
Workqueue: netns cleanup_net
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd1/0x138 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:306 [inline]
 print_report+0x15e/0x45d mm/kasan/report.c:417
 kasan_report+0xbf/0x1f0 mm/kasan/report.c:517
 __ebt_unregister_table+0xc00/0xcd0 net/bridge/netfilter/ebtables.c:1175
 ebt_unregister_table+0x35/0x40 net/bridge/netfilter/ebtables.c:1383
 ops_exit_list+0xb0/0x170 net/core/net_namespace.c:169
 cleanup_net+0x4ee/0xb10 net/core/net_namespace.c:613
 process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
 worker_thread+0x669/0x1090 kernel/workqueue.c:2436
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>

Memory state around the buggy address:
 ffffc90003754f00: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc90003754f80: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
>ffffc90003755000: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
                   ^
 ffffc90003755080: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc90003755100: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
==================================================================


Tested on:

commit:         3ac88fa4 Merge tag 'net-6.2-final' of git://git.kernel..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15693b58c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fe56f7d193926860
dashboard link: https://syzkaller.appspot.com/bug?extid=f61594de72d6705aea03
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11afbd80c80000

