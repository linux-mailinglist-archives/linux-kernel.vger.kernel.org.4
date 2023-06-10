Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D9472A777
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 03:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjFJBfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 21:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjFJBfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 21:35:00 -0400
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3772A35B8
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 18:34:59 -0700 (PDT)
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-7776b76cc59so288387239f.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 18:34:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686360898; x=1688952898;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f5mNW1xz4ir4K+TXk9/cw5gWevzhG4ajUOaVhJJcyOA=;
        b=IwBU0Nl01orFQCbQYkUdRGHEvfQOwhiSAhV8XIUz5Sl4QTsokyr7Vf9NDU27v7uf2C
         HVzg4FhYKWIgaTEsElRcWNc73sVigocFiXzvkZCH5sSbqHCXGFLYNeM77JjnGMQJZLZB
         7liknpqTsHxAtvzM77gBRZqpjwvD2TDOqS+CA1wdhw8NcnnpgMU8rlN39ehaBXLeDVzg
         vS6Twv/jZLCxFQyHHCgvj4uo7bNFCREbKntL0u2qcHgUkdYxLu8ikHon0wDeqOjD5Gzd
         75fn42jnKBmVPc+fO/u6H3SmMC/0c3FFyqz8wA59k9WqrzuYsi4D0OzgpDK6MPXKdAvc
         GtUw==
X-Gm-Message-State: AC+VfDwolF9SukJvi05Z3Xursp7uGhr8b2XMZXrMsZivIfJZ20n8m1pd
        Tua5Z8IBgeyHdOnAcYH1qf9rUsXGHd02On9zQ/ACcrxpqrSS
X-Google-Smtp-Source: ACHHUZ5N1vcUonkSxJW+D8dcCzxgbSsr5CPIhX6GAEHBCilclWELJoe1diJ0k/xADhZS7sRySaC+1litczGZyL7c0o4OegxSEjMQ
MIME-Version: 1.0
X-Received: by 2002:a02:b187:0:b0:41f:2aa6:8b17 with SMTP id
 t7-20020a02b187000000b0041f2aa68b17mr1307116jah.2.1686360898474; Fri, 09 Jun
 2023 18:34:58 -0700 (PDT)
Date:   Fri, 09 Jun 2023 18:34:58 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000051197705fdbc7e54@google.com>
Subject: [syzbot] [net?] unregister_netdevice: waiting for DEV to become free (8)
From:   syzbot <syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com>
To:     arnd@arndb.de, bridge@lists.linux-foundation.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        nikolay@nvidia.com, pabeni@redhat.com, roopa@nvidia.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    67faabbde36b selftests/bpf: Add missing prototypes for sev..
git tree:       bpf-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1381363b280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5335204dcdecfda
dashboard link: https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=132faf93280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10532add280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/751a0490d875/disk-67faabbd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2c5106cd9f1f/vmlinux-67faabbd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/62c1154294e4/bzImage-67faabbd.xz

The issue was bisected to:

commit ad2f99aedf8fa77f3ae647153284fa63c43d3055
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Tue Jul 27 13:45:16 2021 +0000

    net: bridge: move bridge ioctls out of .ndo_do_ioctl

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=146de6f1280000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=166de6f1280000
console output: https://syzkaller.appspot.com/x/log.txt?x=126de6f1280000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com
Fixes: ad2f99aedf8f ("net: bridge: move bridge ioctls out of .ndo_do_ioctl")

unregister_netdevice: waiting for bridge0 to become free. Usage count = 2
leaked reference.
 __netdev_tracker_alloc include/linux/netdevice.h:4070 [inline]
 netdev_hold include/linux/netdevice.h:4099 [inline]
 dev_ifsioc+0xbc0/0xeb0 net/core/dev_ioctl.c:408
 dev_ioctl+0x250/0x1090 net/core/dev_ioctl.c:605
 sock_do_ioctl+0x15a/0x230 net/socket.c:1215
 sock_ioctl+0x1f8/0x680 net/socket.c:1318
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x197/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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
