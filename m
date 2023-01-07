Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1CDB6612A9
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 00:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbjAGX6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 18:58:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjAGX6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 18:58:19 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF33C1A048
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 15:58:18 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id o22-20020a6b5a16000000b006e2d564944aso2715933iob.7
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jan 2023 15:58:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7559gJJ9z85wlOl7jqQosrZ1Ew+LqnNTS0vScsJZILk=;
        b=dH/68anAi1LqrGMWMoSVuK4YKQradvynguwiTwaCEQuk5+2cqjGbBKpmwaGOoGZ95a
         Vo42Kq4f77lyZnMBiEeZoIAG7Ta2lTA39JPe8AyLtTQwXN4UjJfpErrPvEUb/zaHiiad
         xvQyaKvVRlicJNuPSI1EM5oNsRXty88R1qpmCfSNy+7RL1SzvDcEU65HwxQLJZFPhe8B
         8J6L4eJ7n3fAfk1dOKAutwzDPNAG6tF1xAKRbTGa1U+M/ON2vA5g10S0jdEusJXhMQVA
         mvhmV/ZqV31zMd5XoZbBnTVFHEh6Fqg3QoivfZXZyZXwUQTYawQEExoT20lkywuOQKuj
         /OPg==
X-Gm-Message-State: AFqh2kqCBzpXdcvM630YsmSKWuhBW4BrTLVVBtDAiasLGoflbW6omgcc
        n0RWJv4jicQc/E+yGIlqD4IhgzHH/04uCflU2OpQmcZmGLat
X-Google-Smtp-Source: AMrXdXsCTUPPAGVcAKtLQRIR2TYSUDls05w0SqRvTxh2CWDoYKkbaF+YGIuU7gFiPTERMrbZDJnlEVDgZ67Y+LjtdzmEOVeoxt0H
MIME-Version: 1.0
X-Received: by 2002:a02:9f97:0:b0:39d:7413:1ac1 with SMTP id
 a23-20020a029f97000000b0039d74131ac1mr4104951jam.75.1673135898074; Sat, 07
 Jan 2023 15:58:18 -0800 (PST)
Date:   Sat, 07 Jan 2023 15:58:18 -0800
In-Reply-To: <20230107234052.5103-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dda7ab05f1b54ec9@google.com>
Subject: Re: [syzbot] BUG: unable to handle kernel paging request in p9_client_disconnect
From:   syzbot <syzbot+ea8b28e8dca42fc3bcbe@syzkaller.appspotmail.com>
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
BUG: unable to handle kernel paging request in rhltable_lookup

Unable to handle kernel paging request at virtual address ffff00082200ccf8
Mem abort info:
  ESR = 0x0000000096000005
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x05: level 1 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000005
  CM = 0, WnR = 0
swapper pgtable: 4k pages, 48-bit VAs, pgdp=00000001c54db000
[ffff00082200ccf8] pgd=180000023fff8003, p4d=180000023fff8003, pud=0000000000000000
Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 13 Comm: kworker/0:1 Not tainted 6.1.0-rc2-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Workqueue: ipv6_addrconf addrconf_dad_work
pstate: 00400005 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : rht_ptr_rcu include/linux/rhashtable.h:369 [inline]
pc : __rhashtable_lookup include/linux/rhashtable.h:599 [inline]
pc : rhltable_lookup+0xd4/0x398 include/linux/rhashtable.h:688
lr : rht_bucket include/linux/rhashtable.h:290 [inline]
lr : __rhashtable_lookup include/linux/rhashtable.h:597 [inline]
lr : rhltable_lookup+0xc8/0x398 include/linux/rhashtable.h:688
sp : ffff800008003d60
x29: ffff800008003d80 x28: ffff80000d95e000 x27: 0000000000000000
x26: 0000000000000002 x25: 0000000000000000 x24: ffff00082200ccf8
x23: ffff80000d95e000 x22: ffff00082200ccf9 x21: ffff0000c920b800
x20: ffff0000c93597b0 x19: ffff0000cb81b834 x18: 00000000000000c9
x17: ffff8001f1cee000 x16: 0000000000000101 x15: 0000000000000100
x14: 0000000000000000 x13: 000000000000000c x12: ffff80000d65f7d0
x11: ff8080000bce0278 x10: 0000000000000000 x9 : ffff80000bce0278
x8 : ffff00082200cc78 x7 : 0000000000000000 x6 : ffff80000bcd9c94
x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000002
x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 rhltable_lookup+0xd4/0x398 include/linux/rhashtable.h:688
 sta_info_hash_lookup net/mac80211/sta_info.c:195 [inline]
 sta_info_get_by_addrs+0x64/0xf8 net/mac80211/sta_info.c:320
 ieee80211_tx_status+0xd8/0x1ac net/mac80211/status.c:1096
 ieee80211_tasklet_handler+0x5c/0x110 net/mac80211/main.c:319
 tasklet_action_common+0x1d4/0x248
 tasklet_action+0x30/0x3c kernel/softirq.c:818
 _stext+0x168/0x37c
 ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:79
 call_on_irq_stack+0x2c/0x54 arch/arm64/kernel/entry.S:889
 do_softirq_own_stack+0x20/0x2c arch/arm64/kernel/irq.c:84
 do_softirq+0xac/0x108 kernel/softirq.c:472
 __local_bh_enable_ip+0x18c/0x1a4 kernel/softirq.c:396
 local_bh_enable+0x28/0x34 include/linux/bottom_half.h:33
 rcu_read_unlock_bh include/linux/rcupdate.h:808 [inline]
 ip6_finish_output2+0xa1c/0xbec net/ipv6/ip6_output.c:135
 __ip6_finish_output net/ipv6/ip6_output.c:195 [inline]
 ip6_finish_output+0x448/0x4c4 net/ipv6/ip6_output.c:206
 NF_HOOK_COND include/linux/netfilter.h:291 [inline]
 ip6_output+0x180/0x2dc net/ipv6/ip6_output.c:227
 dst_output include/net/dst.h:445 [inline]
 NF_HOOK include/linux/netfilter.h:302 [inline]
 ndisc_send_skb+0x6d8/0xa18 net/ipv6/ndisc.c:508
 ndisc_send_ns+0x7c/0xf0 net/ipv6/ndisc.c:666
 addrconf_dad_work+0x2c8/0x504 net/ipv6/addrconf.c:4171
 process_one_work+0x2d8/0x504 kernel/workqueue.c:2289
 worker_thread+0x340/0x610 kernel/workqueue.c:2436
 kthread+0x12c/0x158 kernel/kthread.c:376
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860
Code: 97171ba7 8b384ea8 91020118 b2400316 (f940031a) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	97171ba7 	bl	0xfffffffffc5c6e9c
   4:	8b384ea8 	add	x8, x21, w24, uxtw #3
   8:	91020118 	add	x24, x8, #0x80
   c:	b2400316 	orr	x22, x24, #0x1
* 10:	f940031a 	ldr	x26, [x24] <-- trapping instruction


Tested on:

commit:         247f34f7 Linux 6.1-rc2
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14cef5e6480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa9bed8d6a8992a0
dashboard link: https://syzkaller.appspot.com/bug?extid=ea8b28e8dca42fc3bcbe
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17c87de6480000

