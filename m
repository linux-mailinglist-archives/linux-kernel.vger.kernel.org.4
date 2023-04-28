Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4DC46F1FAE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 22:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346755AbjD1UwQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 28 Apr 2023 16:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345610AbjD1UwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 16:52:13 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FAB94C27
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 13:52:07 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-32ad2e6cf31so2324595ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 13:52:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682715126; x=1685307126;
        h=content-transfer-encoding:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E/NjsPVieb2u9eUzuZNastdbtfq80Ol69PxzBP/f3iY=;
        b=cgJ7/BrWjCzKq+mZdI1DWdUhtSWcjzbgkLMRoT7STTpeodgsBLn2Uqs6omdCNrBe3N
         MdeVeA8mzYuRujHgoayppCEhW/nkwK40yDJ2UVmTH99pVWdxKGhGMS3pW4BGSQfa10yN
         FoMSNCS6ckfvyVJRy9SSmP7enMGwdTypsyxKW6vDfx+1ROOYSTyyfFnYh8pgxh+3UMke
         dGNkk0IygiSoRGqyjeiwRFeKlx2CsVQWPmUBFKkbMdYFgp9fmrmrg3j3lZtiyKW8rZdX
         w1deIfhBRVaP9pXLCGl91R7Ci8c/oTZLdVNr4Av1Yq3kBtOKX15dvw3cmLgMljiZiFA4
         1Qkg==
X-Gm-Message-State: AC+VfDwSWEfh2ItL7VzDuj3XV5DDpAT+Cg8hiIi8cmQQfRI/KvyBdL8h
        ty8iDfXISnmmI1NnPBGY2V8nE/ybVL2dL9d6R6Mi2nY6uDNReB8=
X-Google-Smtp-Source: ACHHUZ5eoKCTQxu3wUQS8+sKsnRUYLXHc20NPPcCZ+6dRXTx1LY5e4bCPfJfAXRWILIkUzgGVhFC0JWB1ppLbRZvSq5Tyj4uAhJ+
MIME-Version: 1.0
X-Received: by 2002:a02:964c:0:b0:40f:ae69:a144 with SMTP id
 c70-20020a02964c000000b0040fae69a144mr2975216jai.5.1682715126045; Fri, 28 Apr
 2023 13:52:06 -0700 (PDT)
Date:   Fri, 28 Apr 2023 13:52:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000058a08405fa6ba52a@google.com>
Subject: [syzbot] upstream boot error: BUG: unable to handle kernel NULL
 pointer dereference in corrupted
From:   syzbot <syzbot+0f3348b0cb4da6b6072d@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    22b8cc3e78f5 Merge tag 'x86_mm_for_6.4' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11fa5010280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1af34c4cafb72074
dashboard link: https://syzkaller.appspot.com/bug?extid=0f3348b0cb4da6b6072d
compiler:       arm-linux-gnueabi-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0f3348b0cb4da6b6072d@syzkaller.appspotmail.com

Movable zone start for each node
Early memory node ranges
  node   0: [mem 0x0000000080000000-0x00000000ffffffff]
Initmem setup node 0 [mem 0x0000000080000000-0x00000000ffffffff]
percpu: Embedded 19 pages/cpu s47048 r8192 d22584 u77824
Kernel command line: root=/dev/vda console=ttyAMA0  earlyprintk=serial net.ifnames=0 sysctl.kernel.hung_task_all_cpu_backtrace=1 ima_policy=tcb nf-conntrack-ftp.ports=20000 nf-conntrack-tftp.ports=20000 nf-conntrack-sip.ports=20000 nf-conntrack-irc.ports=20000 nf-conntrack-sane.ports=20000 binder.debug_mask=0 rcupdate.rcu_expedited=1 rcupdate.rcu_cpu_stall_cputime=1 no_hash_pointers page_owner=on sysctl.vm.nr_hugepages=4 sysctl.vm.nr_overcommit_hugepages=4 secretmem.enable=1 sysctl.max_rcu_stall_to_panic=1 msr.allow_writes=off coredump_filter=0xffff root=/dev/vda console=ttyAMA0 vmalloc=512M smp.csd_lock_timeout=300000 watchdog_thresh=165 workqueue.watchdog_thresh=420 sysctl.net.core.netdev_unregister_timeout_secs=420 dummy_hcd.num=2 panic_on_warn=1
Unknown kernel command line parameters "earlyprintk=serial page_owner=on", will be passed to user space.
Dentry cache hash table entries: 262144 (order: 8, 1048576 bytes, linear)
Inode-cache hash table entries: 131072 (order: 7, 524288 bytes, linear)
Built 1 zonelists, mobility grouping on.  Total pages: 520868
allocated 2097152 bytes of page_ext
mem auto-init: stack:off, heap alloc:on, heap free:off
software IO TLB: area num 2.
software IO TLB: mapped [mem 0x00000000d9a47000-0x00000000dda47000] (64MB)
Memory: 1954368K/2097152K available (22528K kernel code, 2361K rwdata, 8400K rodata, 2048K init, 867K bss, 126400K reserved, 16384K cma-reserved, 524288K highmem)
SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
trace event string verifier disabled
rcu: Preemptible hierarchical RCU implementation.
rcu: 	RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=2.
rcu: 	RCU callback double-/use-after-free debug is enabled.
	All grace periods are expedited (rcu_expedited).
	Trampoline variant of Tasks RCU enabled.
	Tracing variant of Tasks RCU enabled.
rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
GIC physical location is 0x2c001000
rcu: srcu_init: Setting srcu_struct sizes based on contention.
sched_clock: 32 bits at 24MHz, resolution 41ns, wraps every 89478484971ns
clocksource: arm,sp804: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275 ns
arch_timer: cp15 timer(s) running at 62.50MHz (virt).
clocksource: arch_sys_counter: mask: 0x1ffffffffffffff max_cycles: 0x1cd42e208c, max_idle_ns: 881590405314 ns
sched_clock: 57 bits at 63MHz, resolution 16ns, wraps every 4398046511096ns
Switching to timer-based delay loop, resolution 16ns
Console: colour dummy device 80x30
Calibrating delay loop (skipped), value calculated using timer frequency.. 125.00 BogoMIPS (lpj=625000)
pid_max: default: 32768 minimum: 301
LSM: initializing lsm=lockdown,capability,landlock,yama,safesetid,tomoyo,selinux,bpf,integrity
landlock: Up and running.
Yama: becoming mindful.
TOMOYO Linux initialized
SELinux:  Initializing.
LSM support for eBPF active
stackdepot: allocating hash table of 131072 entries via kvcalloc
Mount-cache hash table entries: 4096 (order: 2, 16384 bytes, linear)
Mountpoint-cache hash table entries: 4096 (order: 2, 16384 bytes, linear)
CPU: Testing write buffer coherency: ok
CPU0: Spectre BHB: enabling loop workaround for all CPUs
CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
8<--- cut here ---
Unable to handle kernel NULL pointer dereference at virtual address 00000206 when execute
[00000206] *pgd=80000080004003, *pmd=00000000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
