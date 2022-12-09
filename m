Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13930647C0B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 03:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiLICL3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 8 Dec 2022 21:11:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLICL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 21:11:27 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAAB9580
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 18:11:25 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id i7-20020a056e021b0700b003033a763270so2814705ilv.19
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 18:11:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l+9N817Zw6H2rBmsOwTm0olN87+xxnaT2PQHF7rFdrY=;
        b=G4I3qkZoe9e/DziNP6fHdcWrZcZ3km05l6m4IxE4qDcpz3LJ/GknEFCsAvUnqtpcZf
         V94yIyX6uesyAu4fPb/uuCqy8pfxeGD6vUTmPetbZN0zXXANK9YDRbXxkt3XRKw0E+KQ
         6ed9QSsV83T7Amjx/j+yIyxFU3H599FDcaaPFL1VqCMk8alhnL3l2ltb4nhz2uVUNjMB
         ZWn5cIPzk4vuCfTF39KsfjQuGs6oXqOvRA6kcqi1toDzZNa3QeF1ZKEVxU6S0HxFKwy/
         I9Nga5N/8zHWN0BB8d8/AWA+kQ329TFW1nnKtISWL6MHWA9OpJUgAf84NunF2/lg/V4n
         rC3Q==
X-Gm-Message-State: ANoB5pkcUnTYPS7Pu95mWrt+nbmkn99ZmllBVre3wiPQKo56T9/i+HWG
        vnhNLj24ZNtiExNgiW+59BGQ+W74lbOoWCUAC1elbw6Xh2ux
X-Google-Smtp-Source: AA0mqf6N3sGCGaV782MQzP9gzfff92MiboMOtXHquwHRAN4WlhpSO9XPbqA0d6FWMyIg1c95eJvkSQjQtNiKcKlhxti4LOyolik3
MIME-Version: 1.0
X-Received: by 2002:a5d:97c9:0:b0:6a2:e3df:a40e with SMTP id
 k9-20020a5d97c9000000b006a2e3dfa40emr43789210ios.113.1670551885118; Thu, 08
 Dec 2022 18:11:25 -0800 (PST)
Date:   Thu, 08 Dec 2022 18:11:25 -0800
In-Reply-To: <20221209014756.1672-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b1044d05ef5babad@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in rxrpc_destroy_all_locals
From:   syzbot <syzbot+1eb4232fca28c0a6d1c2@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:


[    2.937831][    T1] usbcore: registered new device driver usb
[    2.940515][    T1] mc: Linux media interface: v0.10
[    2.941771][    T1] videodev: Linux video capture interface: v2.00
[    2.943596][    T1] pps_core: LinuxPPS API ver. 1 registered
[    2.944527][    T1] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    2.946605][    T1] PTP clock support registered
[    2.951547][    T1] EDAC MC: Ver: 3.0.0
[    2.953736][    T1] Advanced Linux Sound Architecture Driver Initialized.
[    2.960050][    T1] Bluetooth: Core ver 2.22
[    2.961238][    T1] NET: Registered PF_BLUETOOTH protocol family
[    2.961612][    T1] Bluetooth: HCI device and connection manager initialized
[    2.962826][    T1] Bluetooth: HCI socket layer initialized
[    2.963825][    T1] Bluetooth: L2CAP socket layer initialized
[    2.964934][    T1] Bluetooth: SCO socket layer initialized
[    2.966318][    T1] NET: Registered PF_ATMPVC protocol family
[    2.967228][    T1] NET: Registered PF_ATMSVC protocol family
[    2.968490][    T1] NetLabel: Initializing
[    2.969303][    T1] NetLabel:  domain hash size = 128
[    2.970195][    T1] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    2.972058][    T1] NetLabel:  unlabeled traffic allowed by default
[    2.981502][    T1] nfc: nfc_init: NFC Core ver 0.1
[    2.982842][    T1] NET: Registered PF_NFC protocol family
[    2.984011][    T1] PCI: Using ACPI for IRQ routing
[    2.985797][    T1] pci 0000:00:05.0: vgaarb: setting as boot VGA device
[    2.987280][    T1] pci 0000:00:05.0: vgaarb: bridge control possible
[    2.988369][    T1] pci 0000:00:05.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    2.989937][    T1] vgaarb: loaded
[    3.000062][    T1] clocksource: Switched to clocksource kvm-clock
[    3.001536][    T1] VFS: Disk quotas dquot_6.6.0
[    3.001536][    T1] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    3.001536][    T1] FS-Cache: Loaded
[    3.002551][    T1] CacheFiles: Loaded
[    3.004084][    T1] TOMOYO: 2.6.0
[    3.004941][    T1] Mandatory Access Control activated.
[    3.009559][    T1] AppArmor: AppArmor Filesystem Enabled
[    3.011128][    T1] pnp: PnP ACPI init
[    3.032175][    T1] pnp: PnP ACPI: found 7 devices
[    3.083183][    T1] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    3.088040][    T1] NET: Registered PF_INET protocol family
[    3.094841][    T1] IP idents hash table entries: 131072 (order: 8, 1048576 bytes, vmalloc)
[    3.110512][    T1] tcp_listen_portaddr_hash hash table entries: 4096 (order: 6, 294912 bytes, vmalloc)
[    3.113663][    T1] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, vmalloc)
[    3.116780][    T1] TCP established hash table entries: 65536 (order: 7, 524288 bytes, vmalloc)
[    3.130478][    T1] TCP bind hash table entries: 65536 (order: 11, 9437184 bytes, vmalloc hugepage)
[    3.142703][    T1] TCP: Hash tables configured (established 65536 bind 65536)
[    3.147597][    T1] MPTCP token hash table entries: 8192 (order: 7, 720896 bytes, vmalloc)
[    3.151843][    T1] UDP hash table entries: 4096 (order: 7, 655360 bytes, vmalloc)
[    3.155822][    T1] UDP-Lite hash table entries: 4096 (order: 7, 655360 bytes, vmalloc)
[    3.159404][    T1] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    3.163440][    T1] RPC: Registered named UNIX socket transport module.
[    3.164606][    T1] RPC: Registered udp transport module.
[    3.165516][    T1] RPC: Registered tcp transport module.
[    3.166414][    T1] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    3.172670][    T1] NET: Registered PF_XDP protocol family
[    3.173679][    T1] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    3.174862][    T1] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    3.175965][    T1] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    3.177141][    T1] pci_bus 0000:00: resource 7 [mem 0xc0000000-0xfebfefff window]
[    3.180502][    T1] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
[    3.182335][    T1] PCI: CLS 0 bytes, default 64
[    3.190078][    T1] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    3.191932][    T1] software IO TLB: mapped [mem 0x00000000b5800000-0x00000000b9800000] (64MB)
[    3.193805][    T1] ACPI: bus type thunderbolt registered
[    3.207806][   T57] kworker/u4:2 (57) used greatest stack depth: 27944 bytes left
[    3.210957][    T1] RAPL PMU: API unit is 2^-32 Joules, 0 fixed counters, 10737418240 ms ovfl timer
[    3.234225][    T1] kvm: already loaded vendor module 'kvm_intel'
[    3.235402][    T1] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x1fb6c613963, max_idle_ns: 440795245426 ns
[    3.238170][    T1] clocksource: Switched to clocksource tsc
[    6.801690][   T11] ------------[ cut here ]------------
[    6.802753][   T11] WARNING: CPU: 1 PID: 11 at kernel/rcu/tree_plugin.h:268 rcu_note_context_switch+0x8fb/0x1840
[    6.804489][   T11] Modules linked in:
[    6.805126][   T11] CPU: 1 PID: 11 Comm: kworker/u4:1 Not tainted 6.1.0-rc8-next-20221207-syzkaller-dirty #0
[    6.806902][   T11] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
[    6.808814][   T11] Workqueue: eval_map_wq tracer_init_tracefs_work_func
[    6.810794][   T11] RIP: 0010:rcu_note_context_switch+0x8fb/0x1840
[    6.811565][   T11] Code: 83 e2 07 85 c9 0f 84 f8 02 00 00 38 d0 7f 08 84 c0 0f 85 ce 08 00 00 80 7b 11 00 0f 85 e0 06 00 00 45 85 ff 0f 84 9b f8 ff ff <0f> 0b e9 94 f8 ff ff 48 8d 7b 20 c6 43 11 00 48 b8 00 00 00 00 00
[    6.811565][   T11] RSP: 0000:ffffc900001076d8 EFLAGS: 00010002
[    6.811565][   T11] RAX: 0000000000000000 RBX: ffff8880b993c440 RCX: 0000000000000000
[    6.811565][   T11] RDX: 0000000000000001 RSI: 0000000000000004 RDI: 0000000000000001
[    6.811565][   T11] RBP: 0000000000000001 R08: 0000000000000000 R09: ffffffff8c79be43
[    6.811565][   T11] R10: fffffbfff18f37c8 R11: ffffffff8c79bf00 R12: ffffffff8c79be40
[    6.811565][   T11] R13: ffff8880b993c460 R14: ffff8880b993c451 R15: 0000000000000001
[    6.811565][   T11] FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
[    6.811565][   T11] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    6.811565][   T11] CR2: 0000000000000000 CR3: 000000000c48e000 CR4: 00000000003506e0
[    6.811565][   T11] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    6.811565][   T11] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    6.811565][   T11] Call Trace:
[    6.811565][   T11]  <TASK>
[    6.811565][   T11]  ? lockdep_hardirqs_off+0x94/0xd0
[    6.811565][   T11]  ? preempt_schedule_notrace+0x5f/0xe0
[    6.811565][   T11]  __schedule+0x24c/0x5450
[    6.811565][   T11]  ? lock_chain_count+0x20/0x20
[    6.811565][   T11]  ? lock_chain_count+0x20/0x20
[    6.811565][   T11]  ? io_schedule_timeout+0x150/0x150
[    6.811565][   T11]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
[    6.811565][   T11]  ? lockdep_hardirqs_on+0x7d/0x100
[    6.811565][   T11]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
[    6.811565][   T11]  ? preempt_schedule_notrace_thunk+0x1a/0x20
[    6.811565][   T11]  preempt_schedule_notrace+0x5f/0xe0
[    6.811565][   T11]  preempt_schedule_notrace_thunk+0x1a/0x20
[    6.811565][   T11]  lock_acquire+0x516/0x630
[    6.811565][   T11]  ? lock_release+0x810/0x810
[    6.811565][   T11]  ? find_held_lock+0x2d/0x110
[    6.811565][   T11]  ? lookup_dcache+0x1e/0x130
[    6.811565][   T11]  __d_lookup+0xa9/0x460
[    6.811565][   T11]  ? __d_lookup+0x67/0x460
[    6.811565][   T11]  d_lookup+0xdc/0x170
[    6.811565][   T11]  lookup_dcache+0x1e/0x130
[    6.811565][   T11]  lookup_one_len+0x154/0x1a0
[    6.811565][   T11]  ? try_lookup_one_len+0x190/0x190
[    6.811565][   T11]  ? down_write_killable+0x250/0x250
[    6.811565][   T11]  ? do_raw_spin_unlock+0x175/0x230
[    6.811565][   T11]  ? mntput+0x10/0x90
[    6.811565][   T11]  start_creating+0x112/0x270
[    6.811565][   T11]  tracefs_create_file+0x98/0x600
[    6.811565][   T11]  trace_create_file+0x33/0x50
[    6.811565][   T11]  event_create_dir+0xaea/0x1330
[    6.811565][   T11]  __trace_early_add_event_dirs+0x7e/0xf0
[    6.811565][   T11]  event_trace_init+0x87/0xfc
[    6.811565][   T11]  tracer_init_tracefs_work_func+0x12/0x2bb
[    6.811565][   T11]  process_one_work+0x9bf/0x1710
[    6.811565][   T11]  ? pwq_dec_nr_in_flight+0x2a0/0x2a0
[    6.811565][   T11]  ? rwlock_bug.part.0+0x90/0x90
[    6.811565][   T11]  ? _raw_spin_lock_irq+0x45/0x50
[    6.811565][   T11]  worker_thread+0x669/0x1090
[    6.811565][   T11]  ? process_one_work+0x1710/0x1710
[    6.811565][   T11]  kthread+0x2e8/0x3a0
[    6.811565][   T11]  ? kthread_complete_and_exit+0x40/0x40
[    6.811565][   T11]  ret_from_fork+0x1f/0x30
[    6.811565][   T11]  </TASK>
[    6.811565][   T11] Kernel panic - not syncing: kernel: panic_on_warn set ...
[    6.811565][   T11] CPU: 1 PID: 11 Comm: kworker/u4:1 Not tainted 6.1.0-rc8-next-20221207-syzkaller-dirty #0
[    6.811565][   T11] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
[    6.811565][   T11] Workqueue: eval_map_wq tracer_init_tracefs_work_func
[    6.811565][   T11] Call Trace:
[    6.811565][   T11]  <TASK>
[    6.811565][   T11]  dump_stack_lvl+0xd1/0x138
[    6.811565][   T11]  panic+0x2cc/0x626
[    6.811565][   T11]  ? panic_print_sys_info.part.0+0x110/0x110
[    6.811565][   T11]  ? rcu_note_context_switch+0x8fb/0x1840
[    6.811565][   T11]  check_panic_on_warn.cold+0x19/0x35
[    6.811565][   T11]  __warn+0xf2/0x1a0
[    6.811565][   T11]  ? rcu_note_context_switch+0x8fb/0x1840
[    6.811565][   T11]  report_bug+0x1c0/0x210
[    6.811565][   T11]  handle_bug+0x3c/0x70
[    6.811565][   T11]  exc_invalid_op+0x18/0x50
[    6.811565][   T11]  asm_exc_invalid_op+0x1a/0x20
[    6.811565][   T11] RIP: 0010:rcu_note_context_switch+0x8fb/0x1840
[    6.811565][   T11] Code: 83 e2 07 85 c9 0f 84 f8 02 00 00 38 d0 7f 08 84 c0 0f 85 ce 08 00 00 80 7b 11 00 0f 85 e0 06 00 00 45 85 ff 0f 84 9b f8 ff ff <0f> 0b e9 94 f8 ff ff 48 8d 7b 20 c6 43 11 00 48 b8 00 00 00 00 00
[    6.811565][   T11] RSP: 0000:ffffc900001076d8 EFLAGS: 00010002
[    6.811565][   T11] RAX: 0000000000000000 RBX: ffff8880b993c440 RCX: 0000000000000000
[    6.811565][   T11] RDX: 0000000000000001 RSI: 0000000000000004 RDI: 0000000000000001
[    6.811565][   T11] RBP: 0000000000000001 R08: 0000000000000000 R09: ffffffff8c79be43
[    6.811565][   T11] R10: fffffbfff18f37c8 R11: ffffffff8c79bf00 R12: ffffffff8c79be40
[    6.811565][   T11] R13: ffff8880b993c460 R14: ffff8880b993c451 R15: 0000000000000001
[    6.811565][   T11]  ? rcu_note_context_switch+0x8b5/0x1840
[    6.811565][   T11]  ? lockdep_hardirqs_off+0x94/0xd0
[    6.811565][   T11]  ? preempt_schedule_notrace+0x5f/0xe0
[    6.811565][   T11]  __schedule+0x24c/0x5450
[    6.811565][   T11]  ? lock_chain_count+0x20/0x20
[    6.811565][   T11]  ? lock_chain_count+0x20/0x20
[    6.811565][   T11]  ? io_schedule_timeout+0x150/0x150
[    6.811565][   T11]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
[    6.811565][   T11]  ? lockdep_hardirqs_on+0x7d/0x100
[    6.811565][   T11]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
[    6.811565][   T11]  ? preempt_schedule_notrace_thunk+0x1a/0x20
[    6.811565][   T11]  preempt_schedule_notrace+0x5f/0xe0
[    6.811565][   T11]  preempt_schedule_notrace_thunk+0x1a/0x20
[    6.811565][   T11]  lock_acquire+0x516/0x630
[    6.811565][   T11]  ? lock_release+0x810/0x810
[    6.811565][   T11]  ? find_held_lock+0x2d/0x110
[    6.811565][   T11]  ? lookup_dcache+0x1e/0x130
[    6.811565][   T11]  __d_lookup+0xa9/0x460
[    6.811565][   T11]  ? __d_lookup+0x67/0x460
[    6.811565][   T11]  d_lookup+0xdc/0x170
[    6.811565][   T11]  lookup_dcache+0x1e/0x130
[    6.811565][   T11]  lookup_one_len+0x154/0x1a0
[    6.811565][   T11]  ? try_lookup_one_len+0x190/0x190
[    6.811565][   T11]  ? down_write_killable+0x250/0x250
[    6.811565][   T11]  ? do_raw_spin_unlock+0x175/0x230
[    6.811565][   T11]  ? mntput+0x10/0x90
[    6.811565][   T11]  start_creating+0x112/0x270
[    6.811565][   T11]  tracefs_create_file+0x98/0x600
[    6.811565][   T11]  trace_create_file+0x33/0x50
[    6.811565][   T11]  event_create_dir+0xaea/0x1330
[    6.811565][   T11]  __trace_early_add_event_dirs+0x7e/0xf0
[    6.811565][   T11]  event_trace_init+0x87/0xfc
[    6.811565][   T11]  tracer_init_tracefs_work_func+0x12/0x2bb
[    6.811565][   T11]  process_one_work+0x9bf/0x1710
[    6.811565][   T11]  ? pwq_dec_nr_in_flight+0x2a0/0x2a0
[    6.811565][   T11]  ? rwlock_bug.part.0+0x90/0x90
[    6.811565][   T11]  ? _raw_spin_lock_irq+0x45/0x50
[    6.811565][   T11]  worker_thread+0x669/0x1090
[    6.811565][   T11]  ? process_one_work+0x1710/0x1710
[    6.811565][   T11]  kthread+0x2e8/0x3a0
[    6.811565][   T11]  ? kthread_complete_and_exit+0x40/0x40
[    6.811565][   T11]  ret_from_fork+0x1f/0x30
[    6.811565][   T11]  </TASK>
[    6.811565][   T11] Kernel Offset: disabled
[    6.811565][   T11] Rebooting in 86400 seconds..


syzkaller build log:
go env (err=<nil>)
GO111MODULE="auto"
GOARCH="amd64"
GOBIN=""
GOCACHE="/syzkaller/.cache/go-build"
GOENV="/syzkaller/.config/go/env"
GOEXE=""
GOEXPERIMENT=""
GOFLAGS=""
GOHOSTARCH="amd64"
GOHOSTOS="linux"
GOINSECURE=""
GOMODCACHE="/syzkaller/jobs/linux/gopath/pkg/mod"
GONOPROXY=""
GONOSUMDB=""
GOOS="linux"
GOPATH="/syzkaller/jobs/linux/gopath"
GOPRIVATE=""
GOPROXY="https://proxy.golang.org,direct"
GOROOT="/usr/local/go"
GOSUMDB="sum.golang.org"
GOTMPDIR=""
GOTOOLDIR="/usr/local/go/pkg/tool/linux_amd64"
GOVCS=""
GOVERSION="go1.17"
GCCGO="gccgo"
AR="ar"
CC="gcc"
CXX="g++"
CGO_ENABLED="1"
GOMOD="/syzkaller/jobs/linux/gopath/src/github.com/google/syzkaller/go.mod"
CGO_CFLAGS="-g -O2"
CGO_CPPFLAGS=""
CGO_CXXFLAGS="-g -O2"
CGO_FFLAGS="-g -O2"
CGO_LDFLAGS="-g -O2"
PKG_CONFIG="pkg-config"
GOGCCFLAGS="-fPIC -m64 -pthread -fmessage-length=0 -fdebug-prefix-map=/tmp/go-build1203642167=/tmp/go-build -gno-record-gcc-switches"

git status (err=<nil>)
HEAD detached at d88f3abb0
nothing to commit, working tree clean


tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:32: run command via tools/syz-env for best compatibility, see:
Makefile:33: https://github.com/google/syzkaller/blob/master/docs/contributing.md#using-syz-env
go list -f '{{.Stale}}' ./sys/syz-sysgen | grep -q false || go install ./sys/syz-sysgen
make .descriptions
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
bin/syz-sysgen
touch .descriptions
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=d88f3abb0873e90df9259d60d5bcd3ad796db6b8 -X 'github.com/google/syzkaller/prog.gitRevisionDate=20221206-135530'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer github.com/google/syzkaller/syz-fuzzer
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=d88f3abb0873e90df9259d60d5bcd3ad796db6b8 -X 'github.com/google/syzkaller/prog.gitRevisionDate=20221206-135530'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=d88f3abb0873e90df9259d60d5bcd3ad796db6b8 -X 'github.com/google/syzkaller/prog.gitRevisionDate=20221206-135530'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wframe-larger-than=16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-format-overflow -static-pie -fpermissive -w -DGOOS_linux=1 -DGOARCH_amd64=1 \
	-DHOSTGOOS_linux=1 -DGIT_REVISION=\"d88f3abb0873e90df9259d60d5bcd3ad796db6b8\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=125dd843880000


Tested on:

commit:         591cd615 Add linux-next specific files for 20221207
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=8b2d3e63e054c24f
dashboard link: https://syzkaller.appspot.com/bug?extid=1eb4232fca28c0a6d1c2
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16a3316d880000

