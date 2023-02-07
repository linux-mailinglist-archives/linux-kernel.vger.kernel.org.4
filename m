Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1135368D0BE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 08:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjBGHnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 02:43:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjBGHnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 02:43:19 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19F012847
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 23:43:17 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id q12-20020a6b8e0c000000b0071d8eef7c67so8613146iod.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 23:43:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1DGdCdam5a3F4isznYNFYgnOx4xFh2P4WSHIUOaM6cw=;
        b=LNE3QC6kmmDC1UZpW+Jv/JCFp6oGeHwEaJqCegjouZAx2FY4E7cNjnNnUm7RFJp/zH
         lRY7tw7I40EUJJVfiJkssFu3n3U6ib6c8W8aWVLrsnL/fvsTIJGk4tF88CvrdBvAEaxY
         TA2KWWR6N+UkcIt2sqFUNDryP9U4pqYDANHyB7+W2Z4zsKYuCOnB2nxu0W0jX2fE/Sm2
         LBtE5hwt+DI1XwSYL157Fhwb0RLDV8lU3zCxwdDogROIQtYeLcn2ow2KOb6RZqic4HBJ
         BMhzjWDd2aewEfwT2HuJp7mzhnFPigHN76u1tUySLt92UU0ixKXQjTlVESxRV3wkhZFp
         GCUA==
X-Gm-Message-State: AO0yUKXJ0bmzw7D+nAJDLoJMos2P8Arw8Ym5O0RALjwLPfPiPRSOKs9t
        x2NIUzjIJyDIH8XSA/gvJ/5k/ojy9itrBxIFDGE6RIt5G8sP
X-Google-Smtp-Source: AK7set8IdP5qz1eyesJuuNzjkP+qQZE0e5dbaOK0aD4R+bg48/NPZGx1DhGmFsU1RlTTNfqKae4WzgQ8zW9Y8YgL+mVNH0jUtmk0
MIME-Version: 1.0
X-Received: by 2002:a05:6638:528:b0:3be:cc15:cfcc with SMTP id
 j8-20020a056638052800b003becc15cfccmr1584303jar.80.1675755797238; Mon, 06 Feb
 2023 23:43:17 -0800 (PST)
Date:   Mon, 06 Feb 2023 23:43:17 -0800
In-Reply-To: <20230207072656.1175-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000065a2f05f4174d84@google.com>
Subject: Re: [syzbot] kernel BUG in process_one_work
From:   syzbot <syzbot+c0998868487c1f7e05e5@syzkaller.appspotmail.com>
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
kernel BUG in __bio_release_pages

 do_splice_direct+0x1ab/0x280 fs/splice.c:974
 do_sendfile+0xb19/0x12c0 fs/read_write.c:1255
 __do_sys_sendfile64 fs/read_write.c:1323 [inline]
 __se_sys_sendfile64 fs/read_write.c:1309 [inline]
 __x64_sys_sendfile64+0x1d0/0x210 fs/read_write.c:1309
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
------------[ cut here ]------------
kernel BUG at include/linux/mm.h:868!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 1760 Comm: kworker/1:2 Not tainted 6.2.0-rc6-next-20230203-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/12/2023
Workqueue: ipv6_addrconf addrconf_dad_work
RIP: 0010:put_page_testzero include/linux/mm.h:868 [inline]
RIP: 0010:folio_put_testzero include/linux/mm.h:874 [inline]
RIP: 0010:folio_put include/linux/mm.h:1303 [inline]
RIP: 0010:put_page include/linux/mm.h:1373 [inline]
RIP: 0010:bio_release_page block/blk.h:437 [inline]
RIP: 0010:__bio_release_pages+0x546/0x610 block/bio.c:1179
Code: 04 24 48 83 e8 01 48 89 04 24 48 89 44 24 30 e9 0c fe ff ff e8 4b 6f 8b fd 48 8b 7c 24 30 48 c7 c6 40 72 a4 8a e8 0a 17 c4 fd <0f> 0b 48 8b 7c 24 08 e8 1e 72 da fd e9 f2 fa ff ff 48 8b 7c 24 08
RSP: 0018:ffffc900001e0ca0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffffea0001f32000 RCX: 0000000000000100
RDX: ffff888021ff9d40 RSI: ffffffff83f8fb66 RDI: 0000000000000000
RBP: dffffc0000000000 R08: 0000000000000001 R09: ffffffff8e751757
R10: fffffbfff1cea2ea R11: 0000000000000001 R12: 0000000000000000
R13: ffff88802af8ba00 R14: ffffea0001f32034 R15: 0000000000000002
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055ba0a633950 CR3: 0000000075f9d000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 bio_release_pages include/linux/bio.h:493 [inline]
 iomap_dio_bio_end_io+0x373/0x5e0 fs/iomap/direct-io.c:185
 bio_endio+0x62d/0x7f0 block/bio.c:1615
 req_bio_endio block/blk-mq.c:794 [inline]
 blk_update_request+0x3a5/0x1430 block/blk-mq.c:926
 scsi_end_request+0x7a/0xa20 drivers/scsi/scsi_lib.c:537
 scsi_io_completion+0x177/0x1f80 drivers/scsi/scsi_lib.c:975
 scsi_complete+0x126/0x3b0 drivers/scsi/scsi_lib.c:1439
 blk_complete_reqs+0xad/0xe0 block/blk-mq.c:1131
 __do_softirq+0x2e3/0xae3 kernel/softirq.c:571
 do_softirq.part.0+0xde/0x130 kernel/softirq.c:472
 </IRQ>
 <TASK>
 do_softirq kernel/softirq.c:464 [inline]
 __local_bh_enable_ip+0x106/0x130 kernel/softirq.c:396
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 rcu_read_unlock_bh include/linux/rcupdate.h:843 [inline]
 ip6_finish_output2+0x5be/0x1590 net/ipv6/ip6_output.c:135
 __ip6_finish_output net/ipv6/ip6_output.c:195 [inline]
 ip6_finish_output+0x694/0x1170 net/ipv6/ip6_output.c:206
 NF_HOOK_COND include/linux/netfilter.h:291 [inline]
 ip6_output+0x1f1/0x540 net/ipv6/ip6_output.c:227
 dst_output include/net/dst.h:444 [inline]
 NF_HOOK include/linux/netfilter.h:302 [inline]
 ndisc_send_skb+0xa63/0x1850 net/ipv6/ndisc.c:508
 ndisc_send_ns+0xaa/0x130 net/ipv6/ndisc.c:666
 addrconf_dad_work+0xbf4/0x1390 net/ipv6/addrconf.c:4176
 process_one_work+0x9bf/0x1820 kernel/workqueue.c:2390
 worker_thread+0x669/0x1090 kernel/workqueue.c:2537
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:put_page_testzero include/linux/mm.h:868 [inline]
RIP: 0010:folio_put_testzero include/linux/mm.h:874 [inline]
RIP: 0010:folio_put include/linux/mm.h:1303 [inline]
RIP: 0010:put_page include/linux/mm.h:1373 [inline]
RIP: 0010:bio_release_page block/blk.h:437 [inline]
RIP: 0010:__bio_release_pages+0x546/0x610 block/bio.c:1179
Code: 04 24 48 83 e8 01 48 89 04 24 48 89 44 24 30 e9 0c fe ff ff e8 4b 6f 8b fd 48 8b 7c 24 30 48 c7 c6 40 72 a4 8a e8 0a 17 c4 fd <0f> 0b 48 8b 7c 24 08 e8 1e 72 da fd e9 f2 fa ff ff 48 8b 7c 24 08
RSP: 0018:ffffc900001e0ca0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffffea0001f32000 RCX: 0000000000000100
RDX: ffff888021ff9d40 RSI: ffffffff83f8fb66 RDI: 0000000000000000
RBP: dffffc0000000000 R08: 0000000000000001 R09: ffffffff8e751757
R10: fffffbfff1cea2ea R11: 0000000000000001 R12: 0000000000000000
R13: ffff88802af8ba00 R14: ffffea0001f32034 R15: 0000000000000002
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055ba0a633950 CR3: 0000000075f9d000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


Tested on:

commit:         4fafd969 Add linux-next specific files for 20230203
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1218216d480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d2fba7d42502ca4
dashboard link: https://syzkaller.appspot.com/bug?extid=c0998868487c1f7e05e5
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=153c325b480000

