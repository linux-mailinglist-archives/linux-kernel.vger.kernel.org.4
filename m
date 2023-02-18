Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D5169BA57
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 15:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjBROG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 09:06:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBROGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 09:06:24 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCBB8A6C
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 06:06:23 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id z17-20020a056602123100b007447572f3f8so290938iot.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 06:06:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=brnSa+0cpBeyuIS4U9CqkArAtbQGDNWTJue8yTH9UQs=;
        b=lvvUn4AN8tDqvMbqAlln7eWCA1NuoAZ0xaqTRKSxpUKn5VkaKjQNZkkwS4wKHcYfVx
         Be6LsGeMMmHIM5gjNGg57erJjum8iL4o9WCbp7ZApFzVUX9hSRu2upksIon7p0S6jHcV
         OB7EZ6HkeK6GIzm9ZlmByUDo1Q/7EcAZv6JIpacumurM+A17O6vydaluUwu9JKwHsMjn
         mlpQwTioM+nqd3qbhq/pnnBJn32DSqjMWCL3ITLLR2cXAcMHjQP0fO82OeqZ2fSO+WVJ
         ZOTDvx5XTVdAlJJYqlI8QnN4ySSG+gKIVYF5GQ6aJ+DSb7SP+FF2R2omIwYyKNpe6Y2S
         r17Q==
X-Gm-Message-State: AO0yUKW+kBLoyCDXXVGWM6aXswq85RtxJsUOpsRdRMzj/WzvWTQ134Wi
        4beiIf5+dgc7rie+hedD/lbarXb1k+FQbucnQowAyLSB6TEw
X-Google-Smtp-Source: AK7set/o4S0Dgau2VHe35LWm98cDlS6M+vV4ywpYPXD8JBXgkXvI1u1SkDMNqqEkctIPwyww2Lfok5gaGRaA4ruh21mAz/Wt9APN
MIME-Version: 1.0
X-Received: by 2002:a6b:6f0f:0:b0:73b:1230:331b with SMTP id
 k15-20020a6b6f0f000000b0073b1230331bmr1384630ioc.97.1676729183287; Sat, 18
 Feb 2023 06:06:23 -0800 (PST)
Date:   Sat, 18 Feb 2023 06:06:23 -0800
In-Reply-To: <20230218135137.2025-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005ac21205f4f9ef6f@google.com>
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
BUG: KASAN: vmalloc-out-of-bounds in __ebt_unregister_table+0xf43/0xfc0 net/bridge/netfilter/ebtables.c:1178
Read of size 4 at addr ffffc90003263000 by task kworker/u4:6/3167

CPU: 0 PID: 3167 Comm: kworker/u4:6 Not tainted 6.2.0-rc8-syzkaller-00083-g3ac88fa4605e-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/21/2023
Workqueue: netns cleanup_net
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd1/0x138 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:306 [inline]
 print_report+0x15e/0x45d mm/kasan/report.c:417
 kasan_report+0xbf/0x1f0 mm/kasan/report.c:517
 __ebt_unregister_table+0xf43/0xfc0 net/bridge/netfilter/ebtables.c:1178
 ebt_unregister_table+0x35/0x40 net/bridge/netfilter/ebtables.c:1382
 ops_exit_list+0xb0/0x170 net/core/net_namespace.c:169
 cleanup_net+0x4ee/0xb10 net/core/net_namespace.c:613
 process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
 worker_thread+0x669/0x1090 kernel/workqueue.c:2436
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>

Memory state around the buggy address:
 ffffc90003262f00: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc90003262f80: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
>ffffc90003263000: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
                   ^
 ffffc90003263080: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc90003263100: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
==================================================================


Tested on:

commit:         3ac88fa4 Merge tag 'net-6.2-final' of git://git.kernel..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12fc4f6f480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fe56f7d193926860
dashboard link: https://syzkaller.appspot.com/bug?extid=f61594de72d6705aea03
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=173470f0c80000

