Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39C6E69B1DC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 18:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjBQRgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 12:36:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjBQRfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 12:35:55 -0500
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553D56F7C3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 09:35:50 -0800 (PST)
Received: by mail-il1-f207.google.com with SMTP id c9-20020a92dc89000000b003152ca1c48aso667808iln.21
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 09:35:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MEfTQWD+Xd9NO9abt6Gu9FLHicfehK5yJjw31ImtgaU=;
        b=hkNTf1KtGVxZc04RK7XmafesL4Nb6PN2x58dINZ8FVTZtXxy8LyfQHal+3mDcrj5Qx
         xIseFgl498p4EL73OY/sYfuUIvj/JFje7HFDNMW2xZV+C5sOKAPWWK8aqrFXaRvV42hF
         tJS2POOp+7P8NwTcii5FHc/SeAkM6QtfetQH16mkR6Joti2CFV/p2K4DAKvfAl+xZo8K
         Yvf9d01SAyiypbaea2dg96eLcVw7sm0ezVu66PfrS10NMeQiFC3fNCNs54YFFVCrr+LU
         XvOwMsXvNfxj93ju4Z+GhEActkx208iSCyEUWN6kE/slgUUnskHnTrQV2khVq6GY/Mv0
         Tfcg==
X-Gm-Message-State: AO0yUKVr7niVL2wS1nVYMwwaDxcHskqnC6100/b9KfJ7G5mMjnjk6xqv
        DJ70/RSUTWXWHHZhXWW3QM+L1Fhx2Coc+vE1weoWz0H2utBY
X-Google-Smtp-Source: AK7set8tb2VWTHjWtZjW2lm8L7mdmsXsFIPQ3gizAf4gyMxNmT/l8Z72k6QNZsAclUlRTeGcVhlrkAY74b+j3ukma6SM1GqgHK0I
MIME-Version: 1.0
X-Received: by 2002:a05:6638:229a:b0:3c4:e84b:2a40 with SMTP id
 y26-20020a056638229a00b003c4e84b2a40mr637363jas.6.1676655349622; Fri, 17 Feb
 2023 09:35:49 -0800 (PST)
Date:   Fri, 17 Feb 2023 09:35:49 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000866d0e05f4e8be87@google.com>
Subject: [syzbot] [bridge?] [coreteam?] KASAN: vmalloc-out-of-bounds Read in __ebt_unregister_table
From:   syzbot <syzbot+f61594de72d6705aea03@syzkaller.appspotmail.com>
To:     bridge@lists.linux-foundation.org, coreteam@netfilter.org,
        davem@davemloft.net, edumazet@google.com, fw@strlen.de,
        kadlec@netfilter.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, pabeni@redhat.com,
        pablo@netfilter.org, razor@blackwall.org, roopa@nvidia.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    3ac88fa4605e Merge tag 'net-6.2-final' of git://git.kernel..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12986e58c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fe56f7d193926860
dashboard link: https://syzkaller.appspot.com/bug?extid=f61594de72d6705aea03
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14123acf480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=143058d7480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/37b6278f1cdc/disk-3ac88fa4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0a0d5eb58ca1/vmlinux-3ac88fa4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6c92dbf4b7ab/bzImage-3ac88fa4.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f61594de72d6705aea03@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: vmalloc-out-of-bounds in __ebt_unregister_table+0xc00/0xcd0 net/bridge/netfilter/ebtables.c:1168
Read of size 4 at addr ffffc90005425000 by task kworker/u4:4/74

CPU: 0 PID: 74 Comm: kworker/u4:4 Not tainted 6.2.0-rc8-syzkaller-00083-g3ac88fa4605e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/21/2023
Workqueue: netns cleanup_net
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd1/0x138 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:306 [inline]
 print_report+0x15e/0x45d mm/kasan/report.c:417
 kasan_report+0xbf/0x1f0 mm/kasan/report.c:517
 __ebt_unregister_table+0xc00/0xcd0 net/bridge/netfilter/ebtables.c:1168
 ebt_unregister_table+0x35/0x40 net/bridge/netfilter/ebtables.c:1372
 ops_exit_list+0xb0/0x170 net/core/net_namespace.c:169
 cleanup_net+0x4ee/0xb10 net/core/net_namespace.c:613
 process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
 worker_thread+0x669/0x1090 kernel/workqueue.c:2436
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>

Memory state around the buggy address:
 ffffc90005424f00: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc90005424f80: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
>ffffc90005425000: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
                   ^
 ffffc90005425080: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc90005425100: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
