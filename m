Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E52633A40
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 11:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbiKVKhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 05:37:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232647AbiKVKgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 05:36:42 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BF225FD
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 02:32:29 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id o10-20020a056e02102a00b003006328df7bso10387598ilj.17
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 02:32:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NVwvyyye4IzMTCDIf124AD2t8Nz7O4DeAigsyGHiMoQ=;
        b=T7KC+7PyToROwd/peePlirl4Ff0V0/D2OOqmS3vH2OCDohVLx6w44hsxnKoaHoQgOx
         b9HWAaT7fUu3yvFaLCTfr1ayji44X+Imeg6spi3fe1jrbY+j9gzwViIpW6e+MGRx5Y05
         Z2Bq7iJOTGUQOZ3WtVCp3mTrruoXhDwBZYKMiNyJ4tY3k9TDDQ5mxb9Y1oskdm19McMt
         UTOMEAUBbQdIY03c+HGOHTNk3HyL9jczj1XiYTfTkkeZMe2QRURD1SW+z2HBJ9DS9Jan
         HgZuSIq7Q9gBMgXBeyjvmtE+gMm3qsIAYZh8d/uuKnIprt7nf6jcOuBzO73tpyp4ckeK
         EBDQ==
X-Gm-Message-State: ANoB5pnwODO0c43M6oo/q7mTxbE3pvI0n+KEpiF++O7vbgG2xNN4Daje
        F1IVrtIznahtsMIE8DMtui0QgYU/p6AQaKsm7Ggbrkhbi+U3
X-Google-Smtp-Source: AA0mqf6O5B+NCRVHJnCf5EJCm9FHnNuYnp3JZlY5CVCNFeL2BQ+wQW/lCfyRrciPvjjeUwhTgiLwsq2d5RtmPXyM1DMSwI/Oq6s5
MIME-Version: 1.0
X-Received: by 2002:a92:c542:0:b0:300:e879:8094 with SMTP id
 a2-20020a92c542000000b00300e8798094mr2284707ilj.153.1669113148658; Tue, 22
 Nov 2022 02:32:28 -0800 (PST)
Date:   Tue, 22 Nov 2022 02:32:28 -0800
In-Reply-To: <20221122101359.5357-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000050dc7805ee0cb085@google.com>
Subject: Re: [syzbot] BUG: MAX_LOCKDEP_ENTRIES too low! (3)
From:   syzbot <syzbot+b04c9ffbbd2f303d00d9@syzkaller.appspotmail.com>
To:     dvyukov@google.com, hdanton@sina.com, linux-kernel@vger.kernel.org,
        penguin-kernel@i-love.sakura.ne.jp, syzkaller-bugs@googlegroups.com
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
BUG: MAX_LOCKDEP_ENTRIES too low!

BUG: MAX_LOCKDEP_ENTRIES too low!
turning off the locking correctness validator.
CPU: 0 PID: 7529 Comm: syz-executor.0 Not tainted 6.1.0-rc5-syzkaller-00128-g9ab000d9ac54-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd1/0x138 lib/dump_stack.c:106
 alloc_list_entry.cold+0x11/0x18 kernel/locking/lockdep.c:1402
 add_lock_to_list kernel/locking/lockdep.c:1423 [inline]
 check_prev_add kernel/locking/lockdep.c:3167 [inline]
 check_prevs_add kernel/locking/lockdep.c:3216 [inline]
 validate_chain kernel/locking/lockdep.c:3831 [inline]
 __lock_acquire+0x3626/0x56d0 kernel/locking/lockdep.c:5055
 lock_acquire kernel/locking/lockdep.c:5668 [inline]
 lock_acquire+0x1e3/0x630 kernel/locking/lockdep.c:5633
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 __queue_work+0x367/0x13b0 kernel/workqueue.c:1474
 __queue_delayed_work+0x1c8/0x270 kernel/workqueue.c:1665
 mod_delayed_work_on+0xe1/0x220 kernel/workqueue.c:1739
 mod_delayed_work include/linux/workqueue.h:533 [inline]
 addrconf_mod_dad_work net/ipv6/addrconf.c:330 [inline]
 addrconf_dad_start net/ipv6/addrconf.c:4065 [inline]
 addrconf_add_linklocal+0x323/0x590 net/ipv6/addrconf.c:3219
 addrconf_addr_gen+0x37e/0x3d0 net/ipv6/addrconf.c:3346
 addrconf_dev_config+0x255/0x410 net/ipv6/addrconf.c:3391
 addrconf_notify+0xee0/0x1c80 net/ipv6/addrconf.c:3635
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:87
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:1945
 call_netdevice_notifiers_extack net/core/dev.c:1983 [inline]
 call_netdevice_notifiers net/core/dev.c:1997 [inline]
 dev_open net/core/dev.c:1473 [inline]
 dev_open+0x136/0x150 net/core/dev.c:1461
 team_port_add drivers/net/team/team.c:1215 [inline]
 team_add_slave+0xa03/0x1b90 drivers/net/team/team.c:1984
 do_set_master+0x1c8/0x220 net/core/rtnetlink.c:2578
 rtnl_newlink_create net/core/rtnetlink.c:3381 [inline]
 __rtnl_newlink+0x13ac/0x17e0 net/core/rtnetlink.c:3581
 rtnl_newlink+0x68/0xa0 net/core/rtnetlink.c:3594
 rtnetlink_rcv_msg+0x43e/0xca0 net/core/rtnetlink.c:6091
 netlink_rcv_skb+0x157/0x430 net/netlink/af_netlink.c:2540
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x547/0x7f0 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x91b/0xe10 net/netlink/af_netlink.c:1921
 sock_sendmsg_nosec net/socket.c:714 [inline]
 sock_sendmsg+0xd3/0x120 net/socket.c:734
 ____sys_sendmsg+0x712/0x8c0 net/socket.c:2482
 ___sys_sendmsg+0x110/0x1b0 net/socket.c:2536
 __sys_sendmsg+0xf7/0x1c0 net/socket.c:2565
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fe80a28c189
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe80af9c168 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fe80a3abf80 RCX: 00007fe80a28c189
RDX: 0000000000000000 RSI: 0000000020000300 RDI: 0000000000000005
RBP: 00007fe80a2e7b01 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd2b4ff61f R14: 00007fe80af9c300 R15: 0000000000022000
 </TASK>
8021q: adding VLAN 0 to HW filter on device batadv1338
team1336: Port device batadv1338 added


Tested on:

commit:         9ab000d9 Merge branch 'nfc-leaks'
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1517350d880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6f4e5e9899396248
dashboard link: https://syzkaller.appspot.com/bug?extid=b04c9ffbbd2f303d00d9
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11451edd880000

