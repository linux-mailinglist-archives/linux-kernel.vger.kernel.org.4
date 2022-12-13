Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2098A64B81F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 16:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235457AbiLMPKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 10:10:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236068AbiLMPKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 10:10:18 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A56A475;
        Tue, 13 Dec 2022 07:10:14 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id d20so18206119edn.0;
        Tue, 13 Dec 2022 07:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5VSxiIilsl8ET4d1/OVk2k9dwYZeqMK9fkxwGGddCfY=;
        b=cravYJ7HRl3yi06wrLWys1kbf2h2fxPSjpOjltpcIyR+488uITgThHlTrroWYDGCMX
         HW8VSLFrmt6NStK0p5Sp2Ex0cIqFslymUEOT0O/w85UeKmMi/mlyG/ch+9ppq3KrgmeG
         Iiw7gq4gJcVSyGVzJXeaU02oT9+9AQ9G3WLS6eHZmSV6KVp5Xi7qHxxr2hcbkoahUcas
         2C+x3JgY1NgvS7PzDsngECH6+JWGyXr2C/WmUY684YlluDrtVmtFkddgYV7pJPAYhMVH
         huIfsi2hB23NBqHMjWUVlIlkvPXX85yO2O90J9Zp6dRaSW6VjIGtZpLOUmnKjigAFyI7
         j+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5VSxiIilsl8ET4d1/OVk2k9dwYZeqMK9fkxwGGddCfY=;
        b=UBL8wj5T2OVb0zDdXyrSfmpXvi07jGEAJYCHYj7f5/j24akOIiuwTIkCKGHWfKBIcL
         0zkiqEh/eXRALe69Jcn3cudo+DhCzTAWxWI9faFWXCLNyskSPGgpriRFjYudmNu14Kky
         X4lTQTjNYukFlVwp6Lq4crlm/MWltGO4JpGT051Ri/jv9RNRX77FUIDNKlO0HnGO6fNv
         Q0IMgv9e52h2KHkU1arR6OKMsWpSn0fdQw2TvMPhRIEohYKoWcUF+z2o1W9VdUHpUqvT
         NmE2nPMy0IUVWTQwPAxcC2lYBg5Vgnfxw7L4G8y7BU4xiKZJprFSAy3ui0XN3ExtfB5T
         yW1w==
X-Gm-Message-State: ANoB5pmv9EZNXUHuA3kfd69BgsoGdfJVmWGu3ARQ9VqpGA1LkezXT16y
        UTTk4qCfkeZRxtW1xKhsR1xcEsrg0Ax3RpkrlEs+j8Pa3ihVVLs9
X-Google-Smtp-Source: AA0mqf499dh/vG7FebxGNlDGv1F+e7c7jq6kZ0fSht6GmRvawfMPADR2ghw2gTTmctb0E7tnDHpldHWDZmKA5wXqHjI=
X-Received: by 2002:a05:6402:528f:b0:461:9cbd:8fba with SMTP id
 en15-20020a056402528f00b004619cbd8fbamr63665083edb.19.1670944212366; Tue, 13
 Dec 2022 07:10:12 -0800 (PST)
MIME-Version: 1.0
From:   Wei Chen <harperchen1110@gmail.com>
Date:   Tue, 13 Dec 2022 23:09:36 +0800
Message-ID: <CAO4mrfcX8J73DWunmdYjf_SK5TyLfp9W9rmESTj57PCkG2qkBw@mail.gmail.com>
Subject: possible deadlock in __ata_sff_interrupt
To:     damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux Developer,

Recently, when using our tool to fuzz kernel, the following crash was triggered.

HEAD commit: 094226ad94f4 Linux v6.1-rc5
git tree: upstream
compiler: clang 12.0.1
console output:
https://drive.google.com/file/d/1QZttkbuLed4wp6U32UR6TpxfY_HHCIqQ/view?usp=share_link
kernel config: https://drive.google.com/file/d/1TdPsg_5Zon8S2hEFpLBWjb8Tnd2KA5WJ/view?usp=share_link

Unfortunately, I didn't have a reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: Wei Chen <harperchen1110@gmail.com>

=====================================================
WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
6.1.0-rc5 #40 Not tainted
-----------------------------------------------------
syz-executor.0/27911 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
ffff888076cc4f30 (&new->fa_lock){....}-{2:2}, at: kill_fasync_rcu
fs/fcntl.c:996 [inline]
ffff888076cc4f30 (&new->fa_lock){....}-{2:2}, at:
kill_fasync+0x13b/0x430 fs/fcntl.c:1017

and this task is already holding:
ffff8880144dec18 (&host->lock){-.-.}-{2:2}, at:
ata_scsi_queuecmd+0x7a/0x130 drivers/ata/libata-scsi.c:4048
which would create a new lock dependency:
 (&host->lock){-.-.}-{2:2} -> (&new->fa_lock){....}-{2:2}

but this new dependency connects a HARDIRQ-irq-safe lock:
 (&host->lock){-.-.}-{2:2}

... which became HARDIRQ-irq-safe at:
  lock_acquire+0x17f/0x430 kernel/locking/lockdep.c:5668
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0xb3/0x100 kernel/locking/spinlock.c:162
  __ata_sff_interrupt+0x23/0x710 drivers/ata/libata-sff.c:1540
  __handle_irq_event_percpu+0x1f7/0x620 kernel/irq/handle.c:158
  handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
  handle_irq_event+0x83/0x1e0 kernel/irq/handle.c:210
  handle_edge_irq+0x245/0xbe0 kernel/irq/chip.c:819
  generic_handle_irq_desc include/linux/irqdesc.h:158 [inline]
  handle_irq arch/x86/kernel/irq.c:231 [inline]
  __common_interrupt+0xce/0x1e0 arch/x86/kernel/irq.c:250
  common_interrupt+0x9f/0xc0 arch/x86/kernel/irq.c:240
  asm_common_interrupt+0x22/0x40 arch/x86/include/asm/idtentry.h:640
  __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:160 [inline]
  _raw_spin_unlock_irq+0x25/0x40 kernel/locking/spinlock.c:202
  process_one_work+0x83c/0x11a0 kernel/workqueue.c:2289
  worker_thread+0xa6c/0x1290 kernel/workqueue.c:2436
  kthread+0x266/0x300 kernel/kthread.c:376
  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306

to a HARDIRQ-irq-unsafe lock:
 (tasklist_lock){.+.+}-{2:2}

... which became HARDIRQ-irq-unsafe at:
...
  lock_acquire+0x17f/0x430 kernel/locking/lockdep.c:5668
  __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
  _raw_read_lock+0x32/0x40 kernel/locking/spinlock.c:228
  do_wait+0x224/0x9d0 kernel/exit.c:1533
  kernel_wait+0xe4/0x230 kernel/exit.c:1723
  call_usermodehelper_exec_sync kernel/umh.c:140 [inline]
  call_usermodehelper_exec_work+0xb4/0x220 kernel/umh.c:167
  process_one_work+0x83c/0x11a0 kernel/workqueue.c:2289
  worker_thread+0xa6c/0x1290 kernel/workqueue.c:2436
  kthread+0x266/0x300 kernel/kthread.c:376
  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306

other info that might help us debug this:

Chain exists of:
  &host->lock --> &new->fa_lock --> tasklist_lock

 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(tasklist_lock);
                               local_irq_disable();
                               lock(&host->lock);
                               lock(&new->fa_lock);
  <Interrupt>
    lock(&host->lock);

 *** DEADLOCK ***

3 locks held by syz-executor.0/27911:
 #0: ffffffff8cd20b60 (rcu_read_lock){....}-{1:2}, at:
rcu_lock_acquire+0x9/0x30 include/linux/rcupdate.h:304
 #1: ffff8880144dec18 (&host->lock){-.-.}-{2:2}, at:
ata_scsi_queuecmd+0x7a/0x130 drivers/ata/libata-scsi.c:4048
 #2: ffffffff8cd20b60 (rcu_read_lock){....}-{1:2}, at:
rcu_lock_acquire+0x5/0x30 include/linux/rcupdate.h:303

the dependencies between HARDIRQ-irq-safe lock and the holding lock:
-> (&host->lock){-.-.}-{2:2} {
   IN-HARDIRQ-W at:
                    lock_acquire+0x17f/0x430 kernel/locking/lockdep.c:5668
                    __raw_spin_lock_irqsave
include/linux/spinlock_api_smp.h:110 [inline]
                    _raw_spin_lock_irqsave+0xb3/0x100
kernel/locking/spinlock.c:162
                    __ata_sff_interrupt+0x23/0x710 drivers/ata/libata-sff.c:1540
                    __handle_irq_event_percpu+0x1f7/0x620
kernel/irq/handle.c:158
                    handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
                    handle_irq_event+0x83/0x1e0 kernel/irq/handle.c:210
                    handle_edge_irq+0x245/0xbe0 kernel/irq/chip.c:819
                    generic_handle_irq_desc include/linux/irqdesc.h:158 [inline]
                    handle_irq arch/x86/kernel/irq.c:231 [inline]
                    __common_interrupt+0xce/0x1e0 arch/x86/kernel/irq.c:250
                    common_interrupt+0x9f/0xc0 arch/x86/kernel/irq.c:240
                    asm_common_interrupt+0x22/0x40
arch/x86/include/asm/idtentry.h:640
                    __raw_spin_unlock_irq
include/linux/spinlock_api_smp.h:160 [inline]
                    _raw_spin_unlock_irq+0x25/0x40 kernel/locking/spinlock.c:202
                    process_one_work+0x83c/0x11a0 kernel/workqueue.c:2289
                    worker_thread+0xa6c/0x1290 kernel/workqueue.c:2436
                    kthread+0x266/0x300 kernel/kthread.c:376
                    ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
   IN-SOFTIRQ-W at:
                    lock_acquire+0x17f/0x430 kernel/locking/lockdep.c:5668
                    __raw_spin_lock_irqsave
include/linux/spinlock_api_smp.h:110 [inline]
                    _raw_spin_lock_irqsave+0xb3/0x100
kernel/locking/spinlock.c:162
                    __ata_sff_interrupt+0x23/0x710 drivers/ata/libata-sff.c:1540
                    __handle_irq_event_percpu+0x1f7/0x620
kernel/irq/handle.c:158
                    handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
                    handle_irq_event+0x83/0x1e0 kernel/irq/handle.c:210
                    handle_edge_irq+0x245/0xbe0 kernel/irq/chip.c:819
                    generic_handle_irq_desc include/linux/irqdesc.h:158 [inline]
                    handle_irq arch/x86/kernel/irq.c:231 [inline]
                    __common_interrupt+0xce/0x1e0 arch/x86/kernel/irq.c:250
                    common_interrupt+0x4a/0xc0 arch/x86/kernel/irq.c:240
                    asm_common_interrupt+0x22/0x40
arch/x86/include/asm/idtentry.h:640
                    __raw_spin_unlock_irq
include/linux/spinlock_api_smp.h:160 [inline]
                    _raw_spin_unlock_irq+0x25/0x40 kernel/locking/spinlock.c:202
                    __run_timers+0x922/0x970 kernel/time/timer.c:1792
                    run_timer_softirq+0x63/0xf0 kernel/time/timer.c:1803
                    __do_softirq+0x277/0x73a kernel/softirq.c:571
                    __irq_exit_rcu+0xcf/0x150 kernel/softirq.c:650
                    irq_exit_rcu+0x5/0x20 kernel/softirq.c:662
                    sysvec_apic_timer_interrupt+0x91/0xb0
arch/x86/kernel/apic/apic.c:1107
                    asm_sysvec_apic_timer_interrupt+0x16/0x20
arch/x86/include/asm/idtentry.h:649
                    __raw_spin_unlock_irqrestore
include/linux/spinlock_api_smp.h:152 [inline]
                    _raw_spin_unlock_irqrestore+0xbc/0x120
kernel/locking/spinlock.c:194
                    spin_unlock_irqrestore include/linux/spinlock.h:405 [inline]
                    ata_scsi_queuecmd+0xc6/0x130 drivers/ata/libata-scsi.c:4058
                    scsi_dispatch_cmd drivers/scsi/scsi_lib.c:1524 [inline]
                    scsi_queue_rq+0x1ea6/0x2ec0 drivers/scsi/scsi_lib.c:1760
                    blk_mq_dispatch_rq_list+0x104f/0x2ca0 block/blk-mq.c:1992
                    __blk_mq_do_dispatch_sched block/blk-mq-sched.c:173 [inline]
                    blk_mq_do_dispatch_sched+0x820/0xe60
block/blk-mq-sched.c:187
                    __blk_mq_sched_dispatch_requests+0x39b/0x490
                    blk_mq_sched_dispatch_requests+0xef/0x160
block/blk-mq-sched.c:339
                    __blk_mq_run_hw_queue+0x1cf/0x260 block/blk-mq.c:2110
                    process_one_work+0x83c/0x11a0 kernel/workqueue.c:2289
                    worker_thread+0xa6c/0x1290 kernel/workqueue.c:2436
                    kthread+0x266/0x300 kernel/kthread.c:376
                    ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
   INITIAL USE at:
                   lock_acquire+0x17f/0x430 kernel/locking/lockdep.c:5668
                   __raw_spin_lock_irqsave
include/linux/spinlock_api_smp.h:110 [inline]
                   _raw_spin_lock_irqsave+0xb3/0x100
kernel/locking/spinlock.c:162
                   ata_dev_init drivers/ata/libata-core.c:5202 [inline]
                   ata_link_init+0x236/0x890 drivers/ata/libata-core.c:5247
                   ata_port_alloc+0x3ce/0x470 drivers/ata/libata-core.c:5322
                   ata_host_alloc+0x198/0x2c0 drivers/ata/libata-core.c:5433
                   ata_host_alloc_pinfo+0x27/0x430
drivers/ata/libata-core.c:5476
                   ata_pci_sff_prepare_host+0x40/0xe0
drivers/ata/libata-sff.c:2305
                   ata_pci_bmdma_prepare_host+0x20/0x70
drivers/ata/libata-sff.c:3210
                   piix_init_one+0x628/0x1ed0 drivers/ata/ata_piix.c:1704
                   local_pci_probe drivers/pci/pci-driver.c:324 [inline]
                   pci_call_probe drivers/pci/pci-driver.c:392 [inline]
                   __pci_device_probe drivers/pci/pci-driver.c:417 [inline]
                   pci_device_probe+0x4fe/0xa60 drivers/pci/pci-driver.c:460
                   call_driver_probe+0x96/0x250
                   really_probe+0x237/0xaf0 drivers/base/dd.c:639
                   __driver_probe_device+0x1f8/0x3e0 drivers/base/dd.c:778
                   driver_probe_device+0x50/0x240 drivers/base/dd.c:808
                   __driver_attach+0x2b6/0x5b0 drivers/base/dd.c:1190
                   bus_for_each_dev+0x168/0x1d0 drivers/base/bus.c:301
                   bus_add_driver+0x32f/0x600 drivers/base/bus.c:618
                   driver_register+0x2e9/0x3e0 drivers/base/driver.c:246
                   piix_init+0x1b/0x41 drivers/ata/ata_piix.c:1774
                   do_one_initcall+0x1a7/0x400 init/main.c:1303
                   do_initcall_level+0x168/0x218 init/main.c:1376
                   do_initcalls+0x4b/0x8c init/main.c:1392
                   kernel_init_freeable+0x428/0x5d8 init/main.c:1631
                   kernel_init+0x19/0x2b0 init/main.c:1519
                   ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 }
 ... key      at: [<ffffffff9114fc40>] ata_host_alloc.__key+0x0/0x40

the dependencies between the lock to be acquired
 and HARDIRQ-irq-unsafe lock:
  -> (tasklist_lock){.+.+}-{2:2} {
     HARDIRQ-ON-R at:
                        lock_acquire+0x17f/0x430 kernel/locking/lockdep.c:5668
                        __raw_read_lock
include/linux/rwlock_api_smp.h:150 [inline]
                        _raw_read_lock+0x32/0x40 kernel/locking/spinlock.c:228
                        do_wait+0x224/0x9d0 kernel/exit.c:1533
                        kernel_wait+0xe4/0x230 kernel/exit.c:1723
                        call_usermodehelper_exec_sync kernel/umh.c:140 [inline]
                        call_usermodehelper_exec_work+0xb4/0x220
kernel/umh.c:167
                        process_one_work+0x83c/0x11a0 kernel/workqueue.c:2289
                        worker_thread+0xa6c/0x1290 kernel/workqueue.c:2436
                        kthread+0x266/0x300 kernel/kthread.c:376
                        ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
     SOFTIRQ-ON-R at:
                        lock_acquire+0x17f/0x430 kernel/locking/lockdep.c:5668
                        __raw_read_lock
include/linux/rwlock_api_smp.h:150 [inline]
                        _raw_read_lock+0x32/0x40 kernel/locking/spinlock.c:228
                        do_wait+0x224/0x9d0 kernel/exit.c:1533
                        kernel_wait+0xe4/0x230 kernel/exit.c:1723
                        call_usermodehelper_exec_sync kernel/umh.c:140 [inline]
                        call_usermodehelper_exec_work+0xb4/0x220
kernel/umh.c:167
                        process_one_work+0x83c/0x11a0 kernel/workqueue.c:2289
                        worker_thread+0xa6c/0x1290 kernel/workqueue.c:2436
                        kthread+0x266/0x300 kernel/kthread.c:376
                        ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
     INITIAL USE at:
                       lock_acquire+0x17f/0x430 kernel/locking/lockdep.c:5668
                       __raw_write_lock_irq
include/linux/rwlock_api_smp.h:195 [inline]
                       _raw_write_lock_irq+0xae/0xf0
kernel/locking/spinlock.c:326
                       copy_process+0x37cf/0x6200 kernel/fork.c:2387
                       kernel_clone+0x212/0x610 kernel/fork.c:2671
                       user_mode_thread+0x12d/0x190 kernel/fork.c:2747
                       rest_init+0x21/0x270 init/main.c:694
                       start_kernel+0x0/0x540 init/main.c:890
                       start_kernel+0x49a/0x540 init/main.c:1145
                       secondary_startup_64_no_verify+0xcf/0xdb
     INITIAL READ USE at:
                            lock_acquire+0x17f/0x430
kernel/locking/lockdep.c:5668
                            __raw_read_lock
include/linux/rwlock_api_smp.h:150 [inline]
                            _raw_read_lock+0x32/0x40
kernel/locking/spinlock.c:228
                            do_wait+0x224/0x9d0 kernel/exit.c:1533
                            kernel_wait+0xe4/0x230 kernel/exit.c:1723
                            call_usermodehelper_exec_sync
kernel/umh.c:140 [inline]
                            call_usermodehelper_exec_work+0xb4/0x220
kernel/umh.c:167
                            process_one_work+0x83c/0x11a0
kernel/workqueue.c:2289
                            worker_thread+0xa6c/0x1290 kernel/workqueue.c:2436
                            kthread+0x266/0x300 kernel/kthread.c:376
                            ret_from_fork+0x1f/0x30
arch/x86/entry/entry_64.S:306
   }
   ... key      at: [<ffffffff8ca0a058>] tasklist_lock+0x18/0x40
   ... acquired at:
   lock_acquire+0x17f/0x430 kernel/locking/lockdep.c:5668
   __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
   _raw_read_lock+0x32/0x40 kernel/locking/spinlock.c:228
   send_sigio+0xbe/0x300 fs/fcntl.c:792
   kill_fasync_rcu fs/fcntl.c:1003 [inline]
   kill_fasync+0x1e4/0x430 fs/fcntl.c:1017
   __receive_buf drivers/tty/n_tty.c:1629 [inline]
   n_tty_receive_buf_common+0xaac/0x1370 drivers/tty/n_tty.c:1711
   tiocsti drivers/tty/tty_io.c:2286 [inline]
   tty_ioctl+0xda7/0x1710 drivers/tty/tty_io.c:2685
   vfs_ioctl fs/ioctl.c:51 [inline]
   __do_sys_ioctl fs/ioctl.c:870 [inline]
   __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:856
   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
   do_syscall_64+0x3d/0x90 arch/x86/entry/common.c:80
   entry_SYSCALL_64_after_hwframe+0x63/0xcd

 -> (&f->f_owner.lock){....}-{2:2} {
    INITIAL USE at:
                     lock_acquire+0x17f/0x430 kernel/locking/lockdep.c:5668
                     __raw_write_lock_irq
include/linux/rwlock_api_smp.h:195 [inline]
                     _raw_write_lock_irq+0xae/0xf0 kernel/locking/spinlock.c:326
                     f_modown+0x38/0x340 fs/fcntl.c:91
                     __tty_fasync drivers/tty/tty_io.c:2237 [inline]
                     tty_fasync+0x24a/0x340 drivers/tty/tty_io.c:2252
                     setfl fs/fcntl.c:73 [inline]
                     do_fcntl+0xe6c/0x1350 fs/fcntl.c:340
                     __do_sys_fcntl fs/fcntl.c:454 [inline]
                     __se_sys_fcntl+0xd5/0x1b0 fs/fcntl.c:439
                     do_syscall_x64 arch/x86/entry/common.c:50 [inline]
                     do_syscall_64+0x3d/0x90 arch/x86/entry/common.c:80
                     entry_SYSCALL_64_after_hwframe+0x63/0xcd
    INITIAL READ USE at:
                          lock_acquire+0x17f/0x430 kernel/locking/lockdep.c:5668
                          __raw_read_lock_irq
include/linux/rwlock_api_smp.h:169 [inline]
                          _raw_read_lock_irq+0xb6/0x100
kernel/locking/spinlock.c:244
                          f_getown_ex fs/fcntl.c:212 [inline]
                          do_fcntl+0x1a5/0x1350 fs/fcntl.c:380
                          __do_sys_fcntl fs/fcntl.c:454 [inline]
                          __se_sys_fcntl+0xd5/0x1b0 fs/fcntl.c:439
                          do_syscall_x64 arch/x86/entry/common.c:50 [inline]
                          do_syscall_64+0x3d/0x90 arch/x86/entry/common.c:80
                          entry_SYSCALL_64_after_hwframe+0x63/0xcd
  }
  ... key      at: [<ffffffff90e590c0>] __alloc_file.__key+0x0/0x10
  ... acquired at:
   lock_acquire+0x17f/0x430 kernel/locking/lockdep.c:5668
   __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:160 [inline]
   _raw_read_lock_irqsave+0xbb/0x100 kernel/locking/spinlock.c:236
   send_sigio+0x2f/0x300 fs/fcntl.c:778
   kill_fasync_rcu fs/fcntl.c:1003 [inline]
   kill_fasync+0x1e4/0x430 fs/fcntl.c:1017
   sock_wake_async+0x133/0x150
   rcu_read_unlock include/linux/rcupdate.h:767 [inline]
   sk_wake_async+0x12e/0x200 include/net/sock.h:2525
   sock_def_error_report+0x154/0x200 net/core/sock.c:3264
   smc_fback_forward_wakeup+0x1b6/0x500 net/smc/af_smc.c:786
   smc_fback_error_report+0x90/0xb0 net/smc/af_smc.c:838
   sk_error_report+0x3b/0xb0 net/core/sock.c:345
   tcp_validate_incoming+0x1509/0x1fc0 net/ipv4/tcp_input.c:5805
   tcp_rcv_state_process+0x513/0x2610 net/ipv4/tcp_input.c:6520
   tcp_v4_do_rcv+0x691/0xa10 net/ipv4/tcp_ipv4.c:1704
   sk_backlog_rcv include/net/sock.h:1109 [inline]
   __release_sock+0x106/0x3a0 net/core/sock.c:2906
   release_sock+0x5d/0x1c0 net/core/sock.c:3462
   sk_stream_wait_memory+0x6d9/0xe20 net/core/stream.c:145
   tcp_sendmsg_locked+0x1888/0x4540 net/ipv4/tcp.c:1445
   tcp_sendmsg+0x2c/0x40 net/ipv4/tcp.c:1483
   sock_sendmsg_nosec net/socket.c:714 [inline]
   sock_sendmsg net/socket.c:734 [inline]
   ____sys_sendmsg+0x558/0x8a0 net/socket.c:2482
   ___sys_sendmsg net/socket.c:2536 [inline]
   __sys_sendmmsg+0x360/0x6c0 net/socket.c:2622
   __do_sys_sendmmsg net/socket.c:2651 [inline]
   __se_sys_sendmmsg net/socket.c:2648 [inline]
   __x64_sys_sendmmsg+0x9c/0xb0 net/socket.c:2648
   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
   do_syscall_64+0x3d/0x90 arch/x86/entry/common.c:80
   entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> (&new->fa_lock){....}-{2:2} {
   INITIAL USE at:
                   lock_acquire+0x17f/0x430 kernel/locking/lockdep.c:5668
                   __raw_write_lock_irq
include/linux/rwlock_api_smp.h:195 [inline]
                   _raw_write_lock_irq+0xae/0xf0 kernel/locking/spinlock.c:326
                   fasync_remove_entry+0xff/0x1d0 fs/fcntl.c:873
                   sock_fasync+0x86/0xf0 net/socket.c:1390
                   __fput+0x751/0x8c0 fs/file_table.c:317
                   task_work_run+0x243/0x300 kernel/task_work.c:179
                   resume_user_mode_work
include/linux/resume_user_mode.h:49 [inline]
                   exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
                   exit_to_user_mode_prepare+0x1f2/0x210
kernel/entry/common.c:203
                   __syscall_exit_to_user_mode_work
kernel/entry/common.c:285 [inline]
                   syscall_exit_to_user_mode+0x26/0x60 kernel/entry/common.c:296
                   do_syscall_64+0x4c/0x90 arch/x86/entry/common.c:86
                   entry_SYSCALL_64_after_hwframe+0x63/0xcd
   INITIAL READ USE at:
                        lock_acquire+0x17f/0x430 kernel/locking/lockdep.c:5668
                        __raw_read_lock_irqsave
include/linux/rwlock_api_smp.h:160 [inline]
                        _raw_read_lock_irqsave+0xbb/0x100
kernel/locking/spinlock.c:236
                        kill_fasync_rcu fs/fcntl.c:996 [inline]
                        kill_fasync+0x13b/0x430 fs/fcntl.c:1017
                        sock_wake_async+0x133/0x150
                        rcu_read_unlock include/linux/rcupdate.h:767 [inline]
                        sk_wake_async+0x12e/0x200 include/net/sock.h:2525
                        sock_def_error_report+0x154/0x200 net/core/sock.c:3264
                        smc_fback_forward_wakeup+0x1b6/0x500
net/smc/af_smc.c:786
                        smc_fback_error_report+0x90/0xb0 net/smc/af_smc.c:838
                        sk_error_report+0x3b/0xb0 net/core/sock.c:345
                        tcp_validate_incoming+0x1509/0x1fc0
net/ipv4/tcp_input.c:5805
                        tcp_rcv_state_process+0x513/0x2610
net/ipv4/tcp_input.c:6520
                        tcp_v4_do_rcv+0x691/0xa10 net/ipv4/tcp_ipv4.c:1704
                        sk_backlog_rcv include/net/sock.h:1109 [inline]
                        __release_sock+0x106/0x3a0 net/core/sock.c:2906
                        release_sock+0x5d/0x1c0 net/core/sock.c:3462
                        sk_stream_wait_memory+0x6d9/0xe20 net/core/stream.c:145
                        tcp_sendmsg_locked+0x1888/0x4540 net/ipv4/tcp.c:1445
                        tcp_sendmsg+0x2c/0x40 net/ipv4/tcp.c:1483
                        sock_sendmsg_nosec net/socket.c:714 [inline]
                        sock_sendmsg net/socket.c:734 [inline]
                        ____sys_sendmsg+0x558/0x8a0 net/socket.c:2482
                        ___sys_sendmsg net/socket.c:2536 [inline]
                        __sys_sendmmsg+0x360/0x6c0 net/socket.c:2622
                        __do_sys_sendmmsg net/socket.c:2651 [inline]
                        __se_sys_sendmmsg net/socket.c:2648 [inline]
                        __x64_sys_sendmmsg+0x9c/0xb0 net/socket.c:2648
                        do_syscall_x64 arch/x86/entry/common.c:50 [inline]
                        do_syscall_64+0x3d/0x90 arch/x86/entry/common.c:80
                        entry_SYSCALL_64_after_hwframe+0x63/0xcd
 }
 ... key      at: [<ffffffff90e59f80>] fasync_insert_entry.__key+0x0/0x40
 ... acquired at:
   lock_acquire+0x17f/0x430 kernel/locking/lockdep.c:5668
   __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:160 [inline]
   _raw_read_lock_irqsave+0xbb/0x100 kernel/locking/spinlock.c:236
   kill_fasync_rcu fs/fcntl.c:996 [inline]
   kill_fasync+0x13b/0x430 fs/fcntl.c:1017
   sg_rq_end_io+0x604/0xf50 drivers/scsi/sg.c:1403
   __blk_mq_end_request+0x2c7/0x380 block/blk-mq.c:1011
   scsi_end_request+0x4ed/0x9c0 drivers/scsi/scsi_lib.c:576
   scsi_io_completion+0xc25/0x27a0 drivers/scsi/scsi_lib.c:985
   ata_scsi_simulate+0x336e/0x3dd0 drivers/ata/libata-scsi.c:4190
   __ata_scsi_queuecmd+0x20b/0x1020 drivers/ata/libata-scsi.c:4009
   ata_scsi_queuecmd+0xa0/0x130 drivers/ata/libata-scsi.c:4052
   scsi_dispatch_cmd drivers/scsi/scsi_lib.c:1524 [inline]
   scsi_queue_rq+0x1ea6/0x2ec0 drivers/scsi/scsi_lib.c:1760
   blk_mq_dispatch_rq_list+0x104f/0x2ca0 block/blk-mq.c:1992
   __blk_mq_sched_dispatch_requests+0x382/0x490 block/blk-mq-sched.c:306
   blk_mq_sched_dispatch_requests+0xef/0x160 block/blk-mq-sched.c:339
   __blk_mq_run_hw_queue+0x1cf/0x260 block/blk-mq.c:2110
   blk_mq_sched_insert_request+0x1e2/0x430 block/blk-mq-sched.c:458
   blk_execute_rq_nowait+0x2e8/0x3b0 block/blk-mq.c:1305
   sg_common_write+0x8c0/0x1970 drivers/scsi/sg.c:832
   sg_new_write+0x61f/0x860 drivers/scsi/sg.c:770
   sg_ioctl_common drivers/scsi/sg.c:935 [inline]
   sg_ioctl+0x1c51/0x2be0 drivers/scsi/sg.c:1159
   vfs_ioctl fs/ioctl.c:51 [inline]
   __do_sys_ioctl fs/ioctl.c:870 [inline]
   __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:856
   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
   do_syscall_64+0x3d/0x90 arch/x86/entry/common.c:80
   entry_SYSCALL_64_after_hwframe+0x63/0xcd


stack backtrace:
CPU: 0 PID: 27911 Comm: syz-executor.0 Not tainted 6.1.0-rc5 #40
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 print_bad_irq_dependency kernel/locking/lockdep.c:2611 [inline]
 check_irq_usage kernel/locking/lockdep.c:2850 [inline]
 check_prev_add kernel/locking/lockdep.c:3101 [inline]
 check_prevs_add+0x4e5f/0x5b70 kernel/locking/lockdep.c:3216
 validate_chain kernel/locking/lockdep.c:3831 [inline]
 __lock_acquire+0x4411/0x6070 kernel/locking/lockdep.c:5055
 lock_acquire+0x17f/0x430 kernel/locking/lockdep.c:5668
 __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:160 [inline]
 _raw_read_lock_irqsave+0xbb/0x100 kernel/locking/spinlock.c:236
 kill_fasync_rcu fs/fcntl.c:996 [inline]
 kill_fasync+0x13b/0x430 fs/fcntl.c:1017
 sg_rq_end_io+0x604/0xf50 drivers/scsi/sg.c:1403
 __blk_mq_end_request+0x2c7/0x380 block/blk-mq.c:1011
 scsi_end_request+0x4ed/0x9c0 drivers/scsi/scsi_lib.c:576
 scsi_io_completion+0xc25/0x27a0 drivers/scsi/scsi_lib.c:985
 ata_scsi_simulate+0x336e/0x3dd0 drivers/ata/libata-scsi.c:4190
 __ata_scsi_queuecmd+0x20b/0x1020 drivers/ata/libata-scsi.c:4009
 ata_scsi_queuecmd+0xa0/0x130 drivers/ata/libata-scsi.c:4052
 scsi_dispatch_cmd drivers/scsi/scsi_lib.c:1524 [inline]
 scsi_queue_rq+0x1ea6/0x2ec0 drivers/scsi/scsi_lib.c:1760
 blk_mq_dispatch_rq_list+0x104f/0x2ca0 block/blk-mq.c:1992
 __blk_mq_sched_dispatch_requests+0x382/0x490 block/blk-mq-sched.c:306
 blk_mq_sched_dispatch_requests+0xef/0x160 block/blk-mq-sched.c:339
 __blk_mq_run_hw_queue+0x1cf/0x260 block/blk-mq.c:2110
 blk_mq_sched_insert_request+0x1e2/0x430 block/blk-mq-sched.c:458
 blk_execute_rq_nowait+0x2e8/0x3b0 block/blk-mq.c:1305
 sg_common_write+0x8c0/0x1970 drivers/scsi/sg.c:832
 sg_new_write+0x61f/0x860 drivers/scsi/sg.c:770
 sg_ioctl_common drivers/scsi/sg.c:935 [inline]
 sg_ioctl+0x1c51/0x2be0 drivers/scsi/sg.c:1159
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0x90 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f153dc8bded
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f153ede2c58 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f153ddabf80 RCX: 00007f153dc8bded
RDX: 0000000020000440 RSI: 0000000000002285 RDI: 0000000000000006
RBP: 00007f153dcf8ce0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f153ddabf80
R13: 00007ffc72e5108f R14: 00007ffc72e51230 R15: 00007f153ede2dc0
 </TASK>

Best,
Wei
