Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B826C69B919
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 10:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjBRJ2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 04:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBRJ2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 04:28:22 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF00211EF
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 01:28:21 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id v13-20020a92c80d000000b003159a0109ceso881911iln.12
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 01:28:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=co8hJ/WZbt1XO0idDjgfJacuecOeH77n3T8P38Z042c=;
        b=UZVtjwrberzLh00T0xpC1VrgkF8+s8EaijJoIaFoi2gsFlIw2bmW7Mbb7gwljbDIiQ
         s/UCSa0zj6LrYBqTbONwZuu2or675+iDglv7kq3myrX+f7k46Qz7q2JfZuB7d1KlAW/8
         RD3f6iQRwtDWBUMq+i5hjaI7Gu/a+XXhHQwkQ0xXmd563UqIcFkw7aT8FfW569ZG7UCK
         8w14iXz7KWhKKy8202Qgj1/K7B0so8EYQwbnWbeha/cWYOmOxnxc7aKge4Rq0avZtyIh
         ga7u/xlRKJX/w5ec/wFt3sznUyHdiYoBY92xTfqpyzvDV6tJ4UlXQhQLbsiiLGR81lOc
         x6Ug==
X-Gm-Message-State: AO0yUKXmUBXIVTe/UrbZ3foTjR6U10DCYNTWUkIZdBgYE+GV4DvI/f4d
        ihoIOOtfmM+wcRZcLUto7Kn3gaLqqLPB/JrLO7CP+qzvlHwH
X-Google-Smtp-Source: AK7set8PPMM55SLG4o7QIQ7Ec6ZOFrLdL9L8APOOp6KPOjD/Eb71fjtmUCbpZvjxwBVwfItTMG51yIhu1iXg3rbcGRTKSuljDo8/
MIME-Version: 1.0
X-Received: by 2002:a6b:4419:0:b0:721:ff34:9ab8 with SMTP id
 r25-20020a6b4419000000b00721ff349ab8mr174179ioa.26.1676712501108; Sat, 18 Feb
 2023 01:28:21 -0800 (PST)
Date:   Sat, 18 Feb 2023 01:28:21 -0800
In-Reply-To: <20230218091350.1928-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000004e79305f4f60dda@google.com>
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
KASAN: vmalloc-out-of-bounds Read in ebt_unregister_table

==================================================================
BUG: KASAN: vmalloc-out-of-bounds in __ebt_unregister_table net/bridge/netfilter/ebtables.c:1168 [inline]
BUG: KASAN: vmalloc-out-of-bounds in ebt_unregister_table+0xc08/0xcf0 net/bridge/netfilter/ebtables.c:1370
Read of size 4 at addr ffffc90003173000 by task kworker/u4:0/9

CPU: 1 PID: 9 Comm: kworker/u4:0 Not tainted 6.2.0-rc8-syzkaller-00083-g3ac88fa4605e-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/21/2023
Workqueue: netns cleanup_net
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd1/0x138 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:306 [inline]
 print_report+0x15e/0x45d mm/kasan/report.c:417
 kasan_report+0xbf/0x1f0 mm/kasan/report.c:517
 __ebt_unregister_table net/bridge/netfilter/ebtables.c:1168 [inline]
 ebt_unregister_table+0xc08/0xcf0 net/bridge/netfilter/ebtables.c:1370
 ops_exit_list+0xb0/0x170 net/core/net_namespace.c:169
 cleanup_net+0x4ee/0xb10 net/core/net_namespace.c:613
 process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
 worker_thread+0x669/0x1090 kernel/workqueue.c:2436
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>

Memory state around the buggy address:
 ffffc90003172f00: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc90003172f80: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
>ffffc90003173000: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
                   ^
 ffffc90003173080: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc90003173100: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
==================================================================


Tested on:

commit:         3ac88fa4 Merge tag 'net-6.2-final' of git://git.kernel..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11ebf6cf480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fe56f7d193926860
dashboard link: https://syzkaller.appspot.com/bug?extid=f61594de72d6705aea03
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=139e35d7480000

