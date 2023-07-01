Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 396DE74480A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 10:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjGAI3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 04:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbjGAI3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 04:29:07 -0400
Received: from mail-pf1-f207.google.com (mail-pf1-f207.google.com [209.85.210.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8E8183
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 01:29:04 -0700 (PDT)
Received: by mail-pf1-f207.google.com with SMTP id d2e1a72fcca58-666edb72db2so2406845b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jul 2023 01:29:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688200144; x=1690792144;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n2zqYb3bq8vh5YXOrKy7ljeLQ1ET7GZzXQL1D1Y4ntc=;
        b=kTOdk2WvlPNdXFfERbGQzn27nK44B6cqG8wFA47ct/ltesqz94LAtj9oPAMhc46K/t
         b3pXpAKw1WzvuUs34tzI3791V4bfQuimvfC9k5XaxLSbhBtCW/QNC9uMS5ESQFeZOGcM
         G4V21d/7DLs1/Ll3Sz5y3xUqArGkzGiYut4o1EMTzLCkdg+e3s9YBSB2JwGwtoz2P4AZ
         k+Kq+g1zhFkFyKDWofuypS1flAVi9u5Qss3pH07D1rQjH71f0vE1P49aJrOarGac3sA8
         q7Q5zdBngtESgYwHYDbI+P24oUU0v6RUYu4qUPGb+WoitH1IYzC46B1xh01jXqF6KFYr
         YQ8g==
X-Gm-Message-State: ABy/qLbWDDbKfgF8kj5SYwdQGiQnQOx1mDPW92815DEJ4rR3MVYqZR1t
        ArcnH1XCP6UMbr6j9l0DSpC7T85wdt9MQO+P9LweviY0RfqJ3wzdgw==
X-Google-Smtp-Source: APBJJlEIG7PNckSWA6x/kUL5CB00BHdQH9ZpAXCgvsszVECyZeBmCQ7RgS6PSJivQ9zKimvXJWEVjs6qsNhnyhjSQe/fUl+q0dPT
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:c94:b0:682:140c:2459 with SMTP id
 a20-20020a056a000c9400b00682140c2459mr6500910pfv.0.1688200144092; Sat, 01 Jul
 2023 01:29:04 -0700 (PDT)
Date:   Sat, 01 Jul 2023 01:29:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e6068305ff68b9c5@google.com>
Subject: [syzbot] [kernel?] linux-next boot error: BUG: sleeping function
 called from invalid context in cpu_bugs_smt_update
From:   syzbot <syzbot+bdc9ec9be68959140dbf@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        peterz@infradead.org, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
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

HEAD commit:    53cdf865f90b Add linux-next specific files for 20230627
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12a6f567280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=83c17849d18e7a86
dashboard link: https://syzkaller.appspot.com/bug?extid=bdc9ec9be68959140dbf
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cba2655c9221/disk-53cdf865.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1ef013cfe943/vmlinux-53cdf865.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f533d84244ee/bzImage-53cdf865.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bdc9ec9be68959140dbf@syzkaller.appspotmail.com

smpboot: CPU0: Intel(R) Xeon(R) CPU @ 2.20GHz (family: 0x6, model: 0x4f, stepping: 0x0)
RCU Tasks: Setting shift to 1 and lim to 1 rcu_task_cb_adjust=1.
RCU Tasks Trace: Setting shift to 1 and lim to 1 rcu_task_cb_adjust=1.
Running RCU-tasks wait API self tests
Performance Events: unsupported p6 CPU model 79 no PMU driver, software events only.
signal: max sigframe size: 1776
rcu: Hierarchical SRCU implementation.
rcu: 	Max phase no-delay instances is 1000.
NMI watchdog: Perf NMI watchdog permanently disabled
smp: Bringing up secondary CPUs ...
smpboot: x86: Booting SMP configuration:
.... node  #0, CPUs:      #1
BUG: sleeping function called from invalid context at kernel/locking/mutex.c:580
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1, name: swapper/0
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
1 lock held by swapper/0/1:
 #0: ffffffff8c849728 (cpu_add_remove_lock){+.+.}-{3:3}, at: cpu_maps_update_begin kernel/cpu.c:469 [inline]
 #0: ffffffff8c849728 (cpu_add_remove_lock){+.+.}-{3:3}, at: cpu_up kernel/cpu.c:1696 [inline]
 #0: ffffffff8c849728 (cpu_add_remove_lock){+.+.}-{3:3}, at: cpu_up+0xbc/0x200 kernel/cpu.c:1679
Preemption disabled at:
[<ffffffff81363069>] wakeup_secondary_cpu_via_init arch/x86/kernel/smpboot.c:888 [inline]
[<ffffffff81363069>] do_boot_cpu arch/x86/kernel/smpboot.c:1087 [inline]
[<ffffffff81363069>] native_kick_ap+0x969/0x1030 arch/x86/kernel/smpboot.c:1124
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.4.0-next-20230627-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x136/0x150 lib/dump_stack.c:106
 __might_resched+0x358/0x580 kernel/sched/core.c:10189
 __mutex_lock_common kernel/locking/mutex.c:580 [inline]
 __mutex_lock+0x9f/0x1350 kernel/locking/mutex.c:747
 cpu_bugs_smt_update+0x1b/0x440 arch/x86/kernel/cpu/bugs.c:1633
 arch_smt_update+0x9/0x10 arch/x86/kernel/cpu/common.c:2326
 _cpu_up+0x3d0/0x940 kernel/cpu.c:1674
 cpu_up kernel/cpu.c:1707 [inline]
 cpu_up+0xfe/0x200 kernel/cpu.c:1679
 cpuhp_bringup_mask+0xdc/0x210 kernel/cpu.c:1773
 cpuhp_bringup_cpus_parallel kernel/cpu.c:1837 [inline]
 bringup_nonboot_cpus+0x15f/0x1a0 kernel/cpu.c:1848
 smp_init+0x32/0x150 kernel/smp.c:969
 kernel_init_freeable+0x425/0xba0 init/main.c:1540
 kernel_init+0x1e/0x2c0 init/main.c:1437
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
BUG: scheduling while atomic: swapper/0/1/0x00000002
3 locks held by swapper/0/1:
 #0: ffffffff8c849728 (cpu_add_remove_lock){+.+.}-{3:3}, at: cpu_maps_update_begin kernel/cpu.c:469 [inline]
 #0: ffffffff8c849728 (cpu_add_remove_lock){+.+.}-{3:3}, at: cpu_up kernel/cpu.c:1696 [inline]
 #0: ffffffff8c849728 (cpu_add_remove_lock){+.+.}-{3:3}, at: cpu_up+0xbc/0x200 kernel/cpu.c:1679
 #1: ffffffff8c849670 (cpu_hotplug_lock){++++}-{0:0}, at: cpus_write_lock kernel/cpu.c:507 [inline]
 #1: ffffffff8c849670 (cpu_hotplug_lock){++++}-{0:0}, at: _cpu_up+0x66/0x940 kernel/cpu.c:1619
 #2: ffffffff8c9970a8 (sparse_irq_lock){+.+.}-{3:3}, at: cpuhp_bringup_ap+0x65/0x340 kernel/cpu.c:798
Modules linked in:
Preemption disabled at:
[<ffffffff81363069>] wakeup_secondary_cpu_via_init arch/x86/kernel/smpboot.c:888 [inline]
[<ffffffff81363069>] do_boot_cpu arch/x86/kernel/smpboot.c:1087 [inline]
[<ffffffff81363069>] native_kick_ap+0x969/0x1030 arch/x86/kernel/smpboot.c:1124


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
