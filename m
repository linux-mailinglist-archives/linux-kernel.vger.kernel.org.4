Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155945B8632
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 12:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiINKWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 06:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiINKWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 06:22:24 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801E57A749
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 03:22:21 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id s18so8713425plr.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 03:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=yMLVDw4FyeKpsdWoUMfIvE+Rw62eR71jlRrHZjEFQlI=;
        b=SEdQ7VeAsELH2MkT5A1xndn2TTQk3C7qNc/vTzfZMSD9uhtANArh8jmU0MDZSJqEJ4
         uTptY8N2qNqNLvXkb275PAYOYj58O3jlj5WksPKeyIpVwMpccTbqXvM3VFWUwJL09jpH
         KSclAB5ryP/kgDvWlQsmhnfyrLmZEPpwyObQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=yMLVDw4FyeKpsdWoUMfIvE+Rw62eR71jlRrHZjEFQlI=;
        b=37e5ctCO8g5mzqbqpZczMmr2cu5TgcmEtfMm8D08Yu9s3yzwrsFv69HoHO31rsWzJr
         YTfVYOGNrVjqawxE3aj00Tb0h9T6DyNE0KS41TOWiNiFZW4RFF1mNWsJ6QB8s++lmUzk
         K5lW97u+d92wCAzMf/obLcnZumJWme2kkPwDEGpEBbdq0PoULRJEIWI0skXfdz8nJNU+
         f8rnJrT9z2dk3HYNMa3YabgzVwLPLQoqEoLqbOtfHvH4DLkNm18NzQymdQrkgA43Emm1
         J2+5ZFrDXt0BVRJyuAKNwFYbzLQEHf7gsNzlw4BML5dCbEKFzAj5YeTlujyMBlNl4UoE
         Gr3A==
X-Gm-Message-State: ACrzQf1lWmpRbEgdvaQ5NVHvut21//8Suw2ds4VXNXk4QG5ctytxZWR8
        ZJafXuQ7BzlIatzf0DGPBRBIrQ==
X-Google-Smtp-Source: AMsMyM5udUJhqVtjfqrE4yZuQ8HgJApHLOJMyKPMXjAfJKCXf5gHcyuifPLSKMsJQvv6bbmZWjti9g==
X-Received: by 2002:a17:90b:4f90:b0:202:9be9:2c92 with SMTP id qe16-20020a17090b4f9000b002029be92c92mr4034202pjb.140.1663150940821;
        Wed, 14 Sep 2022 03:22:20 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:e5f0:cfaf:bc8c:558e])
        by smtp.gmail.com with ESMTPSA id e9-20020a63d949000000b0042a6dde1d66sm9369804pgj.43.2022.09.14.03.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 03:22:19 -0700 (PDT)
Date:   Wed, 14 Sep 2022 19:22:15 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: next: possible circular locking dependency: perf vs printk
Message-ID: <YyGrVxN8HD9Bks0/@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello folks,

The lockdep splat below is pretty interesting. If I understand it
correctly:

 a) perf invokes printk() under ctx lock. printk invokes up() on the
    semapthore, calls into the scheduler, which takes rq and pi locks.

Then we have a reverse path:

 b) scheduler takes rq lock and then invokes perf, which takes ctx lock.


[   14.301661] WARNING: possible circular locking dependency detected
[   14.301662] 6.0.0-rc5-next-20220914+ #79 Tainted: G                 N
[   14.301666] ------------------------------------------------------
[   14.301667] perf-exec/281 is trying to acquire lock:
[   14.301669] ffffffff82340cf8 ((console_sem).lock){-.-.}-{2:2}, at: down_trylock+0xf/0x30
[   14.301696] 
[   14.301696] but task is already holding lock:
[   14.301697] ffff888100b43020 (&ctx->lock){....}-{2:2}, at: perf_event_exec+0xa9/0x590
[   14.301714] 
[   14.301714] which lock already depends on the new lock.
[   14.301714] 
[   14.301715] 
[   14.301715] the existing dependency chain (in reverse order) is:
[   14.301717] 
[   14.301717] -> #3 (&ctx->lock){....}-{2:2}:
[   14.301722]        __lock_acquire+0x4b7/0xa00
[   14.301728]        lock_acquire+0xb1/0x290
[   14.301733]        _raw_spin_lock+0x2c/0x40
[   14.301743]        perf_event_context_sched_out+0x143/0x720
[   14.301750]        __perf_event_task_sched_out+0x50/0x140
[   14.301757]        prepare_task_switch+0x8a/0x1a0
[   14.301765]        __schedule+0x168/0x640
[   14.301770]        schedule+0x57/0xa0
[   14.301775]        io_schedule+0x42/0x70
[   14.301781]        folio_wait_bit_common+0x127/0x300
[   14.301787]        filemap_update_page+0x23b/0x260
[   14.301793]        filemap_get_pages+0x20a/0x340
[   14.301799]        filemap_read+0xc6/0x340
[   14.301805]        __kernel_read+0xe8/0x240
[   14.301813]        search_binary_handler+0x71/0x240
[   14.301821]        exec_binprm+0xac/0x2e0
[   14.301827]        bprm_execve+0x1ac/0x330
[   14.301833]        do_execveat_common.isra.0+0x1ad/0x220
[   14.301839]        __x64_sys_execve+0x32/0x40
[   14.301846]        do_syscall_64+0x34/0x80
[   14.301854]        entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   14.301859] 
[   14.301859] -> #2 (&rq->__lock){-.-.}-{2:2}:
[   14.301865]        __lock_acquire+0x4b7/0xa00
[   14.301869]        lock_acquire+0xb1/0x290
[   14.301873]        _raw_spin_lock_nested+0x2a/0x40
[   14.301880]        raw_spin_rq_lock_nested+0x11/0x20
[   14.301886]        task_fork_fair+0x43/0x150
[   14.301890]        sched_cgroup_fork+0xe3/0x100
[   14.301897]        copy_process+0xf42/0x1730
[   14.301905]        kernel_clone+0x9b/0x410
[   14.301910]        user_mode_thread+0x5b/0x80
[   14.301915]        rest_init+0x1e/0x160
[   14.301920]        arch_call_rest_init+0xa/0x10
[   14.301938]        start_kernel+0x5f9/0x61e
[   14.301943]        secondary_startup_64_no_verify+0xce/0xdb
[   14.301948] 
[   14.301948] -> #1 (&p->pi_lock){-.-.}-{2:2}:
[   14.301954]        __lock_acquire+0x4b7/0xa00
[   14.301958]        lock_acquire+0xb1/0x290
[   14.301962]        _raw_spin_lock_irqsave+0x38/0x50
[   14.301969]        try_to_wake_up+0x53/0x4a0
[   14.301976]        up+0x40/0x60
[   14.301982]        __up_console_sem+0x48/0x60
[   14.301988]        console_unlock+0x132/0x210
[   14.301994]        vprintk_emit+0x12e/0x310
[   14.301999]        _printk+0x58/0x6f
[   14.302006]        addrconf_notify.cold+0x21/0x26
[   14.302014]        raw_notifier_call_chain+0x41/0x60
[   14.302021]        netdev_state_change+0x67/0x90
[   14.302028]        linkwatch_do_dev+0x54/0x70
[   14.302038]        __linkwatch_run_queue+0xe9/0x200
[   14.302043]        linkwatch_event+0x21/0x30
[   14.302047]        process_one_work+0x294/0x560
[   14.302052]        worker_thread+0x4c/0x3c0
[   14.302056]        kthread+0xd4/0x100
[   14.302063]        ret_from_fork+0x1f/0x30
[   14.302067] 
[   14.302067] -> #0 ((console_sem).lock){-.-.}-{2:2}:
[   14.302072]        check_prev_add+0x8f/0xbd0
[   14.302076]        validate_chain+0x571/0x830
[   14.302080]        __lock_acquire+0x4b7/0xa00
[   14.302084]        lock_acquire+0xb1/0x290
[   14.302088]        _raw_spin_lock_irqsave+0x38/0x50
[   14.302095]        down_trylock+0xf/0x30
[   14.302102]        __down_trylock_console_sem+0x23/0x90
[   14.302108]        vprintk_emit+0x107/0x310
[   14.302114]        _printk+0x58/0x6f
[   14.302119]        report_bug.cold+0x10/0x4b
[   14.302126]        handle_bug+0x3c/0x60
[   14.302133]        exc_invalid_op+0x13/0x60
[   14.302137]        asm_exc_invalid_op+0x16/0x20
[   14.302141]        perf_event_update_sibling_time+0x2d/0x100
[   14.302147]        perf_event_set_state+0x8e/0xa0
[   14.302152]        perf_event_exec+0x101/0x590
[   14.302159]        begin_new_exec+0x2d8/0x410
[   14.302165]        load_elf_binary+0x6c4/0xec0
[   14.302171]        search_binary_handler+0xbb/0x240
[   14.302176]        exec_binprm+0xac/0x2e0
[   14.302183]        bprm_execve+0x1ac/0x330
[   14.302188]        do_execveat_common.isra.0+0x1ad/0x220
[   14.302195]        __x64_sys_execve+0x32/0x40
[   14.302201]        do_syscall_64+0x34/0x80
[   14.302208]        entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   14.302217] 
[   14.302217] other info that might help us debug this:
[   14.302217] 
[   14.302218] Chain exists of:
[   14.302218]   (console_sem).lock --> &rq->__lock --> &ctx->lock
[   14.302218] 
[   14.302224]  Possible unsafe locking scenario:
[   14.302224] 
[   14.302225]        CPU0                    CPU1
[   14.302226]        ----                    ----
[   14.302227]   lock(&ctx->lock);
[   14.302229]                                lock(&rq->__lock);
[   14.302232]                                lock(&ctx->lock);
[   14.302234]   lock((console_sem).lock);
[   14.302236] 
[   14.302236]  *** DEADLOCK ***
[   14.302236] 
[   14.302237] 4 locks held by perf-exec/281:
[   14.302241]  #0: ffff888105179808 (&sig->cred_guard_mutex){+.+.}-{3:3}, at: bprm_execve+0x38/0x330
[   14.302253]  #1: ffff8881051798a0 (&sig->exec_update_lock){++++}-{3:3}, at: exec_mmap+0x55/0x220
[   14.302264]  #2: ffff88813bbf0a78 (&cpuctx_lock){....}-{2:2}, at: perf_event_exec+0x98/0x590
[   14.302276]  #3: ffff888100b43020 (&ctx->lock){....}-{2:2}, at: perf_event_exec+0xa9/0x590
[   14.302287] 
[   14.302287] stack backtrace:
[   14.302289] CPU: 7 PID: 281 Comm: perf-exec Tainted: G                 N 6.0.0-rc5-next-20220914+ #79
[   14.302296] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
[   14.302303] Call Trace:
[   14.302306]  <TASK>
[   14.302309]  dump_stack_lvl+0x4c/0x5f
[   14.302318]  check_noncircular+0xfe/0x110
[   14.302325]  ? lock_acquire+0xb1/0x290
[   14.302332]  check_prev_add+0x8f/0xbd0
[   14.302336]  ? rcu_read_lock_sched_held+0x3b/0x70
[   14.302346]  validate_chain+0x571/0x830
[   14.302353]  __lock_acquire+0x4b7/0xa00
[   14.302361]  lock_acquire+0xb1/0x290
[   14.302366]  ? down_trylock+0xf/0x30
[   14.302377]  _raw_spin_lock_irqsave+0x38/0x50
[   14.302385]  ? down_trylock+0xf/0x30
[   14.302392]  down_trylock+0xf/0x30
[   14.302399]  ? _printk+0x58/0x6f
[   14.302404]  __down_trylock_console_sem+0x23/0x90
[   14.302411]  vprintk_emit+0x107/0x310
[   14.302418]  ? perf_event_update_sibling_time+0x2d/0x100
[   14.302425]  _printk+0x58/0x6f
[   14.302432]  ? restore_regs_and_return_to_kernel+0x22/0x22
[   14.302439]  report_bug.cold+0x10/0x4b
[   14.302448]  handle_bug+0x3c/0x60
[   14.302456]  exc_invalid_op+0x13/0x60
[   14.302461]  asm_exc_invalid_op+0x16/0x20
[   14.302466] RIP: 0010:perf_event_update_sibling_time+0x2d/0x100
[   14.302472] Code: 00 00 8b 0d 61 25 2c 01 53 48 89 fb 85 c9 74 1c 65 8b 05 16 92 e8 7e 85 c0 75 11 65 8b 05 27 90 e8 7e 85 c0 0f 84 a0 00 00 00 <0f> 0b 48 39 9b 90 00 00 00 74 02 5b c3 48 8b 43 10 48 83 e8 10 48
[   14.302477] RSP: 0018:ffffc90000defca8 EFLAGS: 00010097
[   14.302482] RAX: 0000000000000000 RBX: ffff888109602fb0 RCX: 0000000000000000
[   14.302486] RDX: 0000000000000000 RSI: ffff888100b430b0 RDI: ffff888105174688
[   14.302489] RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000002
[   14.302492] R10: ffffc90000defb28 R11: 0000000000033c20 R12: ffff888109602fb0
[   14.302495] R13: 0000000000000000 R14: ffff888100b43108 R15: ffff888105173e00
[   14.302505]  ? perf_event_update_sibling_time+0xe5/0x100
[   14.302511]  perf_event_set_state+0x8e/0xa0
[   14.302517]  perf_event_exec+0x101/0x590
[   14.302529]  begin_new_exec+0x2d8/0x410
[   14.302535]  ? load_elf_phdrs+0x6c/0xb0
[   14.302541]  load_elf_binary+0x6c4/0xec0
[   14.302547]  ? find_held_lock+0x2b/0x80
[   14.302555]  ? search_binary_handler+0xb5/0x240
[   14.302561]  ? __lock_release.isra.0+0x61/0x150
[   14.302566]  ? search_binary_handler+0xb5/0x240
[   14.302572]  ? search_binary_handler+0xb5/0x240
[   14.302581]  search_binary_handler+0xbb/0x240
[   14.302588]  exec_binprm+0xac/0x2e0
[   14.302596]  bprm_execve+0x1ac/0x330
[   14.302604]  do_execveat_common.isra.0+0x1ad/0x220
[   14.302613]  __x64_sys_execve+0x32/0x40
[   14.302621]  do_syscall_64+0x34/0x80
[   14.302629]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   14.302633] RIP: 0033:0x7f3d4310c3c7
[   14.302663] Code: Unable to access opcode bytes at RIP 0x7f3d4310c39d.
[   14.302665] RSP: 002b:00007ffd90454038 EFLAGS: 00000202 ORIG_RAX: 000000000000003b
[   14.302671] RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007f3d4310c3c7
[   14.302674] RDX: 00005644b06bfc70 RSI: 00007ffd904592c0 RDI: 00007ffd90454040
[   14.302677] RBP: 00007ffd90454120 R08: 0000000000000fff R09: 00005644b06c00ce
[   14.302680] R10: 00007f3d430466d0 R11: 0000000000000202 R12: 00007ffd904592c0
[   14.302683] R13: 00005644b06bfc70 R14: 00007ffd9045ae4e R15: 00005644b06c00c6
[   14.302693]  </TASK>
[   14.512851] WARNING: CPU: 7 PID: 281 at kernel/events/core.c:655 perf_event_update_sibling_time+0x2d/0x100
[   14.515326] Modules linked in:
[   14.516128] CPU: 7 PID: 281 Comm: perf-exec Tainted: G                 N 6.0.0-rc5-next-20220914+ #79
[   14.518499] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
[   14.520964] RIP: 0010:perf_event_update_sibling_time+0x2d/0x100
[   14.522497] Code: 00 00 8b 0d 61 25 2c 01 53 48 89 fb 85 c9 74 1c 65 8b 05 16 92 e8 7e 85 c0 75 11 65 8b 05 27 90 e8 7e 85 c0 0f 84 a0 00 00 00 <0f> 0b 48 39 9b 90 00 00 00 74 02 5b c3 48 8b 43 10 48 83 e8 10 48
[   14.527303] RSP: 0018:ffffc90000defca8 EFLAGS: 00010097
[   14.528668] RAX: 0000000000000000 RBX: ffff888109602fb0 RCX: 0000000000000000
[   14.530499] RDX: 0000000000000000 RSI: ffff888100b430b0 RDI: ffff888105174688
[   14.532345] RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000002
[   14.534168] R10: ffffc90000defb28 R11: 0000000000033c20 R12: ffff888109602fb0
[   14.536021] R13: 0000000000000000 R14: ffff888100b43108 R15: ffff888105173e00
[   14.537858] FS:  0000000000000000(0000) GS:ffff88813bbc0000(0000) knlGS:0000000000000000
[   14.539950] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   14.541429] CR2: 00007f3d4310c39d CR3: 0000000106080002 CR4: 0000000000770ee0
[   14.543269] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   14.545097] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   14.546927] PKRU: 55555554
[   14.547668] Call Trace:
[   14.548291]  <TASK>
[   14.548851]  perf_event_set_state+0x8e/0xa0
[   14.549939]  perf_event_exec+0x101/0x590
[   14.550953]  begin_new_exec+0x2d8/0x410
[   14.551968]  ? load_elf_phdrs+0x6c/0xb0
[   14.552975]  load_elf_binary+0x6c4/0xec0
[   14.553997]  ? find_held_lock+0x2b/0x80
[   14.555000]  ? search_binary_handler+0xb5/0x240
[   14.556188]  ? __lock_release.isra.0+0x61/0x150
[   14.557371]  ? search_binary_handler+0xb5/0x240
[   14.558540]  ? search_binary_handler+0xb5/0x240
[   14.559725]  search_binary_handler+0xbb/0x240
[   14.560869]  exec_binprm+0xac/0x2e0
[   14.561778]  bprm_execve+0x1ac/0x330
[   14.562705]  do_execveat_common.isra.0+0x1ad/0x220
[   14.563973]  __x64_sys_execve+0x32/0x40
[   14.564964]  do_syscall_64+0x34/0x80
[   14.565902]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   14.567214] RIP: 0033:0x7f3d4310c3c7
[   14.568168] Code: Unable to access opcode bytes at RIP 0x7f3d4310c39d.
[   14.569857] RSP: 002b:00007ffd90454038 EFLAGS: 00000202 ORIG_RAX: 000000000000003b
[   14.571817] RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007f3d4310c3c7
[   14.573656] RDX: 00005644b06bfc70 RSI: 00007ffd904592c0 RDI: 00007ffd90454040
[   14.575510] RBP: 00007ffd90454120 R08: 0000000000000fff R09: 00005644b06c00ce
[   14.577334] R10: 00007f3d430466d0 R11: 0000000000000202 R12: 00007ffd904592c0
[   14.579152] R13: 00005644b06bfc70 R14: 00007ffd9045ae4e R15: 00005644b06c00c6
[   14.580994]  </TASK>
[   14.581573] irq event stamp: 692
[   14.582416] hardirqs last  enabled at (691): [<ffffffff8106e474>] __local_bh_enable_ip+0x74/0xc0
[   14.584704] hardirqs last disabled at (692): [<ffffffff811a120e>] perf_event_exec+0x3fe/0x590
[   14.586886] softirqs last  enabled at (690): [<ffffffff8103018b>] fpu_flush_thread+0xbb/0x100
[   14.589082] softirqs last disabled at (688): [<ffffffff810300d5>] fpu_flush_thread+0x5/0x100
[   14.591246] ---[ end trace 0000000000000000 ]---
