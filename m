Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3EA69BE4D
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 03:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjBSC5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 21:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBSC52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 21:57:28 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4754711153
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 18:57:27 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id q5-20020a92ca45000000b00315e1caf725so96086ilo.10
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 18:57:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J6UaVKljUMpCwUZkZDlJeRfFfNmgfNWCv9pMKaW7Rp8=;
        b=DoVZgWBhCRPAxTxEXLaKH+MHkVyEBHdaliJ7HL9xdMAAJtBoGFV8lFXDx247OL6elY
         b3iHPrvRKvSFWksZIGchkNnFo9+WDUJrwh4fpsZAu0wKjlhec+sJMfcTf6eqTqdt7jJY
         9HQo3gYnqYUqq+1aN1fk7iuzYzNzEpOQRl4svLfIfDxzhnIGe4W6+JrxYh0fuMQQhi8H
         n+Fh0/CJLpFh6ZeCM8BwUDYpZftE+1uDhOP2C6DazK8M6onHQZU8RV9TVXBT9hpQK9/q
         eD1/upZfEfvEfuovngoTt9i1Qzipu8BFTY5hCQ5V6zAGMHQsVWeYarnHnv7SAHHjSNsI
         i0Kg==
X-Gm-Message-State: AO0yUKUvNBylutV1iYuT7lCDx74Kg97AyM4+v6qdm9jdp8W3B3Jri09H
        Ye4kHyk4xM9m90hnvZLzYvwwlFHgqSNHjUxAVGXLNucMaM2v
X-Google-Smtp-Source: AK7set8pjbUfWB4P+jzg2jDJoik+FjYkukoBgbG4Dc++m/oJpUbHVx8udq0fd34V0wz/pABlo2LhpkZ/1cCLQixhuGMmTDQ+xXu8
MIME-Version: 1.0
X-Received: by 2002:a6b:f214:0:b0:707:a84b:1b76 with SMTP id
 q20-20020a6bf214000000b00707a84b1b76mr1667149ioh.42.1676775446637; Sat, 18
 Feb 2023 18:57:26 -0800 (PST)
Date:   Sat, 18 Feb 2023 18:57:26 -0800
In-Reply-To: <20230219024213.2103-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dd74e205f504b459@google.com>
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
BUG: KASAN: vmalloc-out-of-bounds in __ebt_unregister_table+0xf4a/0xfc0 net/bridge/netfilter/ebtables.c:1201
Read of size 4 at addr ffffc90002d9c000 by task kworker/u4:4/74

CPU: 1 PID: 74 Comm: kworker/u4:4 Not tainted 6.2.0-rc8-syzkaller-00083-g3ac88fa4605e-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/21/2023
Workqueue: netns cleanup_net
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd1/0x138 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:306 [inline]
 print_report+0x15e/0x45d mm/kasan/report.c:417
 kasan_report+0xbf/0x1f0 mm/kasan/report.c:517
 __ebt_unregister_table+0xf4a/0xfc0 net/bridge/netfilter/ebtables.c:1201
 ebt_unregister_table+0x35/0x40 net/bridge/netfilter/ebtables.c:1405
 ops_exit_list+0xb0/0x170 net/core/net_namespace.c:169
 cleanup_net+0x4ee/0xb10 net/core/net_namespace.c:613
 process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
 worker_thread+0x669/0x1090 kernel/workqueue.c:2436
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>

Memory state around the buggy address:
 ffffc90002d9bf00: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc90002d9bf80: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
>ffffc90002d9c000: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
                   ^
 ffffc90002d9c080: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc90002d9c100: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
==================================================================


Tested on:

commit:         3ac88fa4 Merge tag 'net-6.2-final' of git://git.kernel..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17733430c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fe56f7d193926860
dashboard link: https://syzkaller.appspot.com/bug?extid=f61594de72d6705aea03
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=161cf127480000

