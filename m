Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37BD672F005
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 01:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234813AbjFMXg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 19:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbjFMXg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 19:36:57 -0400
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EB81727
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 16:36:55 -0700 (PDT)
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-76c6c1b16d2so771696339f.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 16:36:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686699415; x=1689291415;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qpzsuVrNoglwA7vam832+fL4Or5CLbaAmcZOxQ4ezY8=;
        b=YQO1aLC6LsMaANN1GgaS6aXh8JwvWRb4r0dRThaCCc+cQSXAmKe/XPIxCzHWOKf4Eg
         YY6Zd/93JfGRHK57MwCGP6sqjBa26M9kCn7wxiRcfth0ve58JRjUbfEjA2dT2NzEAz34
         wGW2btouD0s3y56jnCtGyMWd+biMBSWv3LFOjXi2sKU+FK4aQjrbr8tax1Dd04DMBYZw
         /3aJ0r1cHL8BEa95uISRseUOIKb3c5qNMbZSv2glOW839LtpEawqRm44DxzmJrk+kWFf
         j8odUcKmecOwA8PqjrUT05QOd73++WCkmEqKk0M+L8bsq5wzefxGMsJHZ7V7A29CWP9C
         Eglg==
X-Gm-Message-State: AC+VfDzIbjDnVZv489GDQP9oCd4ucXOkFK1ExNYfxUgt2/zWdUqPKdMg
        EyjX7fd8pXHlF/dHWEZWIo+MBMQmM1n0J3Sg4piCFzvb36sp
X-Google-Smtp-Source: ACHHUZ5p0PUhsHjUdEm3xNlS191eQu7h67/ihxJbBXYCXrNqfCjlaPNKoRP/Gd7tH/aX450c1u2zszknknxab5IJwvlQXkN8EAeW
MIME-Version: 1.0
X-Received: by 2002:a02:228b:0:b0:41d:70ff:9254 with SMTP id
 o133-20020a02228b000000b0041d70ff9254mr6168071jao.3.1686699415331; Tue, 13
 Jun 2023 16:36:55 -0700 (PDT)
Date:   Tue, 13 Jun 2023 16:36:55 -0700
In-Reply-To: <0000000000009612bc05fe07c73f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007e6d7505fe0b4f4b@google.com>
Subject: Re: [syzbot] [hams?] memory leak in nr_create (3)
From:   syzbot <syzbot+d327a1f3b12e1e206c16@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com, ralf@linux-mips.org,
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    fb054096aea0 Merge tag 'mm-hotfixes-stable-2023-06-12-12-2..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17042a9d280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=62c3855f0661c072
dashboard link: https://syzkaller.appspot.com/bug?extid=d327a1f3b12e1e206c16
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=166d8d2d280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=102f213b280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/193c8ae2af09/disk-fb054096.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/eaa8cc7d62e7/vmlinux-fb054096.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4209ce6abb1d/bzImage-fb054096.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d327a1f3b12e1e206c16@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff8881160a5800 (size 2048):
  comm "syz-executor386", pid 5102, jiffies 4294948540 (age 23.020s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    06 00 07 40 00 00 00 00 00 00 00 00 00 00 00 00  ...@............
  backtrace:
    [<ffffffff8154621a>] __do_kmalloc_node mm/slab_common.c:965 [inline]
    [<ffffffff8154621a>] __kmalloc+0x4a/0x120 mm/slab_common.c:979
    [<ffffffff83dbed6d>] kmalloc include/linux/slab.h:563 [inline]
    [<ffffffff83dbed6d>] sk_prot_alloc+0xcd/0x1b0 net/core/sock.c:2035
    [<ffffffff83dc14e6>] sk_alloc+0x36/0x300 net/core/sock.c:2088
    [<ffffffff843df034>] nr_create+0x84/0x1c0 net/netrom/af_netrom.c:438
    [<ffffffff83db741e>] __sock_create+0x1de/0x300 net/socket.c:1547
    [<ffffffff83dbaa32>] sock_create net/socket.c:1598 [inline]
    [<ffffffff83dbaa32>] __sys_socket_create net/socket.c:1635 [inline]
    [<ffffffff83dbaa32>] __sys_socket_create net/socket.c:1620 [inline]
    [<ffffffff83dbaa32>] __sys_socket+0xa2/0x190 net/socket.c:1663
    [<ffffffff83dbab3e>] __do_sys_socket net/socket.c:1676 [inline]
    [<ffffffff83dbab3e>] __se_sys_socket net/socket.c:1674 [inline]
    [<ffffffff83dbab3e>] __x64_sys_socket+0x1e/0x30 net/socket.c:1674
    [<ffffffff84a17749>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84a17749>] do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

write to /proc/sys/kernel/hung_task_check_interval_secs failed: No such file or directory
write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such file or directory
BUG: memory leak
unreferenced object 0xffff8881115ddde0 (size 32):
  comm "syz-executor386", pid 5003, jiffies 4294947794 (age 35.370s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff81545b34>] kmalloc_trace+0x24/0x90 mm/slab_common.c:1057
    [<ffffffff83de7abc>] kmalloc include/linux/slab.h:559 [inline]
    [<ffffffff83de7abc>] kzalloc include/linux/slab.h:680 [inline]
    [<ffffffff83de7abc>] net_alloc net/core/net_namespace.c:422 [inline]
    [<ffffffff83de7abc>] copy_net_ns+0xdc/0x450 net/core/net_namespace.c:476
    [<ffffffff812bf009>] create_new_namespaces+0x199/0x4f0 kernel/nsproxy.c:110
    [<ffffffff812bf9bf>] unshare_nsproxy_namespaces+0x9f/0x120 kernel/nsproxy.c:228
    [<ffffffff81279ae2>] ksys_unshare+0x302/0x600 kernel/fork.c:3441
    [<ffffffff81279df6>] __do_sys_unshare kernel/fork.c:3512 [inline]
    [<ffffffff81279df6>] __se_sys_unshare kernel/fork.c:3510 [inline]
    [<ffffffff81279df6>] __x64_sys_unshare+0x16/0x20 kernel/fork.c:3510
    [<ffffffff84a17749>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84a17749>] do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff888109e8a600 (size 512):
  comm "syz-executor386", pid 5003, jiffies 4294947794 (age 35.370s)
  hex dump (first 32 bytes):
    00 98 e8 09 81 88 ff ff 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 ea ff ff ff ff ff ff ff  ................
  backtrace:
    [<ffffffff8154621a>] __do_kmalloc_node mm/slab_common.c:965 [inline]
    [<ffffffff8154621a>] __kmalloc+0x4a/0x120 mm/slab_common.c:979
    [<ffffffff8176619f>] kmalloc include/linux/slab.h:563 [inline]
    [<ffffffff8176619f>] kzalloc include/linux/slab.h:680 [inline]
    [<ffffffff8176619f>] __register_sysctl_table+0x7f/0xac0 fs/proc/proc_sysctl.c:1376
    [<ffffffff83f75c50>] netfilter_log_sysctl_init net/netfilter/nf_log.c:490 [inline]
    [<ffffffff83f75c50>] nf_log_net_init+0xc0/0x1e0 net/netfilter/nf_log.c:539
    [<ffffffff83de6184>] ops_init+0x54/0x1d0 net/core/net_namespace.c:136
    [<ffffffff83de64d2>] setup_net+0x1d2/0x3f0 net/core/net_namespace.c:339
    [<ffffffff83de7bed>] copy_net_ns+0x20d/0x450 net/core/net_namespace.c:491
    [<ffffffff812bf009>] create_new_namespaces+0x199/0x4f0 kernel/nsproxy.c:110
    [<ffffffff812bf9bf>] unshare_nsproxy_namespaces+0x9f/0x120 kernel/nsproxy.c:228
    [<ffffffff81279ae2>] ksys_unshare+0x302/0x600 kernel/fork.c:3441
    [<ffffffff81279df6>] __do_sys_unshare kernel/fork.c:3512 [inline]
    [<ffffffff81279df6>] __se_sys_unshare kernel/fork.c:3510 [inline]
    [<ffffffff81279df6>] __x64_sys_unshare+0x16/0x20 kernel/fork.c:3510
    [<ffffffff84a17749>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84a17749>] do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff88810e12b400 (size 256):
  comm "syz-executor386", pid 5003, jiffies 4294947794 (age 35.370s)
  hex dump (first 32 bytes):
    78 b4 12 0e 81 88 ff ff 00 00 00 00 00 00 00 00  x...............
    00 00 00 00 00 00 00 00 ea ff ff ff ff ff ff ff  ................
  backtrace:
    [<ffffffff8154621a>] __do_kmalloc_node mm/slab_common.c:965 [inline]
    [<ffffffff8154621a>] __kmalloc+0x4a/0x120 mm/slab_common.c:979
    [<ffffffff81766883>] kmalloc include/linux/slab.h:563 [inline]
    [<ffffffff81766883>] kzalloc include/linux/slab.h:680 [inline]
    [<ffffffff81766883>] new_dir fs/proc/proc_sysctl.c:970 [inline]
    [<ffffffff81766883>] get_subdir fs/proc/proc_sysctl.c:1014 [inline]
    [<ffffffff81766883>] sysctl_mkdir_p fs/proc/proc_sysctl.c:1307 [inline]
    [<ffffffff81766883>] __register_sysctl_table+0x763/0xac0 fs/proc/proc_sysctl.c:1392
    [<ffffffff83f75c50>] netfilter_log_sysctl_init net/netfilter/nf_log.c:490 [inline]
    [<ffffffff83f75c50>] nf_log_net_init+0xc0/0x1e0 net/netfilter/nf_log.c:539
    [<ffffffff83de6184>] ops_init+0x54/0x1d0 net/core/net_namespace.c:136
    [<ffffffff83de64d2>] setup_net+0x1d2/0x3f0 net/core/net_namespace.c:339
    [<ffffffff83de7bed>] copy_net_ns+0x20d/0x450 net/core/net_namespace.c:491
    [<ffffffff812bf009>] create_new_namespaces+0x199/0x4f0 kernel/nsproxy.c:110
    [<ffffffff812bf9bf>] unshare_nsproxy_namespaces+0x9f/0x120 kernel/nsproxy.c:228
    [<ffffffff81279ae2>] ksys_unshare+0x302/0x600 kernel/fork.c:3441
    [<ffffffff81279df6>] __do_sys_unshare kernel/fork.c:3512 [inline]
    [<ffffffff81279df6>] __se_sys_unshare kernel/fork.c:3510 [inline]
    [<ffffffff81279df6>] __x64_sys_unshare+0x16/0x20 kernel/fork.c:3510
    [<ffffffff84a17749>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84a17749>] do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff88810b613180 (size 192):
  comm "syz-executor386", pid 5003, jiffies 4294947794 (age 35.370s)
  hex dump (first 32 bytes):
    00 1a 62 0a 81 88 ff ff 00 00 00 00 00 00 00 00  ..b.............
    00 00 00 00 00 00 00 00 ea ff ff ff ff ff ff ff  ................
  backtrace:
    [<ffffffff8154621a>] __do_kmalloc_node mm/slab_common.c:965 [inline]
    [<ffffffff8154621a>] __kmalloc+0x4a/0x120 mm/slab_common.c:979
    [<ffffffff8176619f>] kmalloc include/linux/slab.h:563 [inline]
    [<ffffffff8176619f>] kzalloc include/linux/slab.h:680 [inline]
    [<ffffffff8176619f>] __register_sysctl_table+0x7f/0xac0 fs/proc/proc_sysctl.c:1376
    [<ffffffff83decbae>] sysctl_core_net_init+0x8e/0x130 net/core/sysctl_net_core.c:715
    [<ffffffff83de6184>] ops_init+0x54/0x1d0 net/core/net_namespace.c:136
    [<ffffffff83de64d2>] setup_net+0x1d2/0x3f0 net/core/net_namespace.c:339
    [<ffffffff83de7bed>] copy_net_ns+0x20d/0x450 net/core/net_namespace.c:491
    [<ffffffff812bf009>] create_new_namespaces+0x199/0x4f0 kernel/nsproxy.c:110
    [<ffffffff812bf9bf>] unshare_nsproxy_namespaces+0x9f/0x120 kernel/nsproxy.c:228
    [<ffffffff81279ae2>] ksys_unshare+0x302/0x600 kernel/fork.c:3441
    [<ffffffff81279df6>] __do_sys_unshare kernel/fork.c:3512 [inline]
    [<ffffffff81279df6>] __se_sys_unshare kernel/fork.c:3510 [inline]
    [<ffffffff81279df6>] __x64_sys_unshare+0x16/0x20 kernel/fork.c:3510
    [<ffffffff84a17749>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84a17749>] do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd



---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
