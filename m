Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9638F70BB00
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 12:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233082AbjEVK5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 06:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233126AbjEVKy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 06:54:59 -0400
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A2A189
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 03:52:07 -0700 (PDT)
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-763c3442563so220340739f.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 03:52:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684752716; x=1687344716;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hdR0MEUa+/dN3T1llAyCVOtP8CVJRUGCVFTvkqGJ6YU=;
        b=RK51UVV5uxU8tFvb957Njmo36nZkHvoVoXjo0lhtKvRY3DGCcVcul67rAjNQ8Z8Vnw
         9f9p2BPoNqUnu1xUtBjfB+Aga10bEKox45CldEVsJU/Tk+vqWypTa7EG13E/33wdY2xc
         +FQEFa7pRy3Qs2WglDRTZo6D7N55tMCPhQgseTTltRr380cs4w0jZJt+wd7oee47ilsJ
         PqjyOKpaPxf3PMiVys0V6a1BZhml7Lyw6d4tT0N9S1B35G8MQOym08/kY/woiwI48GG/
         EueU8ugUkSnNKaGon9aYih+9rlzfX+M763QIxn14Z1+W0LqOmxVUPWgH2wHHGds+nny4
         alng==
X-Gm-Message-State: AC+VfDyRKaQ93ckIZng75vlnWZ2oQOU6My7/pAPI5iMV5KUeGxfoR3VL
        SwpNJXHOu31EFAi8KUbTo7EdZ+GnfaNuvFG2kcteeyFXNf/M
X-Google-Smtp-Source: ACHHUZ683lyLHfBAvXYCsC5Pw/IIouYZXuM+c3UjFxmGuUvZsUVB2SpeLVF4Q96Z2g3FzUh8eKIUJkmPuKG4UtooyYHAeDsDwJVN
MIME-Version: 1.0
X-Received: by 2002:a6b:dd0d:0:b0:74c:8243:9290 with SMTP id
 f13-20020a6bdd0d000000b0074c82439290mr5292590ioc.4.1684752716738; Mon, 22 May
 2023 03:51:56 -0700 (PDT)
Date:   Mon, 22 May 2023 03:51:56 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000037341d05fc460fa6@google.com>
Subject: [syzbot] [net?] KASAN: invalid-access Read in __packet_get_status
From:   syzbot <syzbot+64b0f633159fde08e1f1@syzkaller.appspotmail.com>
To:     bpf@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com, willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    2d1bcbc6cd70 Merge tag 'probes-fixes-v6.4-rc1' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=154b8fa1280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=51dd28037b2a55f
dashboard link: https://syzkaller.appspot.com/bug?extid=64b0f633159fde08e1f1
compiler:       aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12b6382e280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17fd0aee280000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/384ffdcca292/non_bootable_disk-2d1bcbc6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d2e21a43e11e/vmlinux-2d1bcbc6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/49e0b029f9af/Image-2d1bcbc6.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+64b0f633159fde08e1f1@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: invalid-access in __packet_get_status+0x70/0xe0 net/packet/af_packet.c:438
Read at addr f7ff000006e00000 by task dhcpcd/3009
Pointer tag: [f7], memory tag: [f0]

CPU: 0 PID: 3009 Comm: dhcpcd Not tainted 6.4.0-rc2-syzkaller-00163-g2d1bcbc6cd70 #0
Hardware name: linux,dummy-virt (DT)
Call trace:
 dump_backtrace+0x94/0xec arch/arm64/kernel/stacktrace.c:233
 show_stack+0x18/0x24 arch/arm64/kernel/stacktrace.c:240
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x48/0x60 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:351 [inline]
 print_report+0xd8/0x5f4 mm/kasan/report.c:462
 kasan_report+0x7c/0x9c mm/kasan/report.c:572
 __do_kernel_fault+0x174/0x1c0 arch/arm64/mm/fault.c:320
 do_bad_area arch/arm64/mm/fault.c:479 [inline]
 do_tag_check_fault+0x78/0x8c arch/arm64/mm/fault.c:791
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:867
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:367
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:427
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 __packet_get_status+0x70/0xe0 net/packet/af_packet.c:438
 packet_lookup_frame net/packet/af_packet.c:524 [inline]
 packet_current_rx_frame net/packet/af_packet.c:1117 [inline]
 tpacket_rcv+0x29c/0xbbc net/packet/af_packet.c:2355
 deliver_skb net/core/dev.c:2173 [inline]
 dev_queue_xmit_nit+0x110/0x2c8 net/core/dev.c:2243
 xmit_one net/core/dev.c:3574 [inline]
 dev_hard_start_xmit+0x78/0x148 net/core/dev.c:3594
 sch_direct_xmit+0x90/0x1e4 net/sched/sch_generic.c:342
 __dev_xmit_skb net/core/dev.c:3805 [inline]
 __dev_queue_xmit+0x468/0xd40 net/core/dev.c:4210
 dev_queue_xmit include/linux/netdevice.h:3085 [inline]
 packet_xmit+0xd8/0x14c net/packet/af_packet.c:276
 packet_snd net/packet/af_packet.c:3081 [inline]
 packet_sendmsg+0xeec/0x13d0 net/packet/af_packet.c:3113
 sock_sendmsg_nosec net/socket.c:724 [inline]
 sock_sendmsg+0x54/0x60 net/socket.c:747
 sock_write_iter+0x94/0xf0 net/socket.c:1140
 call_write_iter include/linux/fs.h:1868 [inline]
 do_iter_readv_writev+0xb8/0x144 fs/read_write.c:735
 do_iter_write+0x94/0x214 fs/read_write.c:860
 vfs_writev+0xac/0x170 fs/read_write.c:933
 do_writev+0x118/0x130 fs/read_write.c:976
 __do_sys_writev fs/read_write.c:1049 [inline]
 __se_sys_writev fs/read_write.c:1046 [inline]
 __arm64_sys_writev+0x20/0x2c fs/read_write.c:1046
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0xcc/0xec arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x38/0xa4 arch/arm64/kernel/syscall.c:193
 el0_svc+0x2c/0xb0 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0xb8/0xbc arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591

The buggy address belongs to the physical page:
page:0000000070ed64fe refcount:9 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0x46e00
head:0000000070ed64fe order:3 entire_mapcount:0 nr_pages_mapped:8 pincount:0
flags: 0x1ffc20006010000(head|arch_2|arch_3|node=0|zone=0|lastcpupid=0x7ff|kasantag=0x8)
page_type: 0x0()
raw: 01ffc20006010000 0000000000000000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 0000000900000000 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff000006dffe00: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
 ffff000006dfff00: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
>ffff000006e00000: f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0
                   ^
 ffff000006e00100: f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0
 ffff000006e00200: f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
