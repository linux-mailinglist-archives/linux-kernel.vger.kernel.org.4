Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E476647CCB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 05:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiLIDqd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 8 Dec 2022 22:46:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiLIDqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 22:46:31 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D05B2EDC
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 19:46:27 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id a11-20020a92c54b000000b003034a80704fso2939012ilj.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 19:46:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bAZw2Qmxg8o+J9FIOKrHigGeUaR83SHkp16R3g6LJ5U=;
        b=yRUoGbBoFAJq0RNOkGsFaCr5qu15qvWql+aq64htvX4qlYFqEtk9Uows+vIlLe4kvK
         Gr+ZRptKUa6eMC7z51jH2+VD/+8VhCVdw7r2HO8VrpBkKMXm/XG6N9MLgzaVWGnIAbJx
         FXDLlVorxoXocE4gY9W9fEBRPfwSNrAvG5Hhv4p+iDNYZ2YQViv6DgQxzOavJ+ZG1Fwl
         WyzxJLWDEhHgI2Yam23gWafT5Or7SzgCHITAoIA3OrRajhnPWHb22u/XqEF0JINWKmWQ
         ZMokWbkPU6vqAOsshZTI8HuLh4RPoN/SDe1Xpbjr6QEvR6Arnz9PnA7LTlRHNllmy83C
         FL7w==
X-Gm-Message-State: ANoB5pmF9Zu3V0th2swDssDmzqK9YdApHHZFYks1UVMkZ0ymeztjQDR6
        jYA9umpGtSt4CmCPYK6BaXbA9TtnPe0xxnS3vC5toN7EB8KT
X-Google-Smtp-Source: AA0mqf7NsH0cUUo2CZBys81maH0y44gtfyiNqAypWI+gccpgOlJE8XzNZ/t86kGoMFxRitFuRCiZReh0S2h1Iw1M7xTxjk3gKesL
MIME-Version: 1.0
X-Received: by 2002:a02:6019:0:b0:374:b974:8bac with SMTP id
 i25-20020a026019000000b00374b9748bacmr37282289jac.59.1670557586523; Thu, 08
 Dec 2022 19:46:26 -0800 (PST)
Date:   Thu, 08 Dec 2022 19:46:26 -0800
In-Reply-To: <20221209030750.1743-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000085901e05ef5cffda@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in rxrpc_destroy_all_locals
From:   syzbot <syzbot+1eb4232fca28c0a6d1c2@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

1] IPsec XFRM device driver
[   10.391370][    T1] NET: Registered PF_INET6 protocol family
[   10.401430][    T1] Segment Routing with IPv6
[   10.402451][    T1] RPL Segment Routing with IPv6
[   10.403552][    T1] In-situ OAM (IOAM) with IPv6
[   10.404513][    T1] mip6: Mobile IPv6
[   10.408666][    T1] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[   10.414909][    T1] ip6_gre: GRE over IPv6 tunneling driver
[   10.418561][    T1] NET: Registered PF_PACKET protocol family
[   10.420016][    T1] NET: Registered PF_KEY protocol family
[   10.421217][    T1] Bridge firewalling registered
[   10.422716][    T1] NET: Registered PF_X25 protocol family
[   10.423756][    T1] X25: Linux Version 0.2
[   10.464058][    T1] NET: Registered PF_NETROM protocol family
[   10.504639][    T1] NET: Registered PF_ROSE protocol family
[   10.506106][    T1] NET: Registered PF_AX25 protocol family
[   10.508103][    T1] can: controller area network core
[   10.509722][    T1] NET: Registered PF_CAN protocol family
[   10.510710][    T1] can: raw protocol
[   10.511327][    T1] can: broadcast manager protocol
[   10.512447][    T1] can: netlink gateway - max_hops=1
[   10.513228][    T1] can: SAE J1939
[   10.514598][    T1] can: isotp protocol
[   10.515523][    T1] Bluetooth: RFCOMM TTY layer initialized
[   10.517265][    T1] Bluetooth: RFCOMM socket layer initialized
[   10.518316][    T1] Bluetooth: RFCOMM ver 1.11
[   10.519103][    T1] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   10.520174][    T1] Bluetooth: BNEP filters: protocol multicast
[   10.521428][    T1] Bluetooth: BNEP socket layer initialized
[   10.522281][    T1] Bluetooth: CMTP (CAPI Emulation) ver 1.0
[   10.523367][    T1] Bluetooth: CMTP socket layer initialized
[   10.524213][    T1] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[   10.525212][    T1] Bluetooth: HIDP socket layer initialized
[   10.529275][    T1] NET: Registered PF_RXRPC protocol family
[   10.530339][    T1] Key type rxrpc registered
[   10.531082][    T1] Key type rxrpc_s registered
[   10.532752][    T1] NET: Registered PF_KCM protocol family
[   10.534825][    T1] lec:lane_module_init: lec.c: initialized
[   10.537240][    T1] mpoa:atm_mpoa_init: mpc.c: initialized
[   10.539560][    T1] l2tp_core: L2TP core driver, V2.0
[   10.541140][    T1] l2tp_ppp: PPPoL2TP kernel driver, V2.0
[   10.542715][    T1] l2tp_ip: L2TP IP encapsulation support (L2TPv3)
[   10.544849][    T1] l2tp_netlink: L2TP netlink interface
[   10.546686][    T1] l2tp_eth: L2TP ethernet pseudowire support (L2TPv3)
[   10.549082][    T1] l2tp_ip6: L2TP IP encapsulation support for IPv6 (L2TPv3)
[   10.550677][    T1] NET: Registered PF_PHONET protocol family
[   10.552447][    T1] 8021q: 802.1Q VLAN Support v1.8
[   10.565308][    T1] DCCP: Activated CCID 2 (TCP-like)
[   10.567991][    T1] DCCP: Activated CCID 3 (TCP-Friendly Rate Control)
[   10.570250][    T1] sctp: Hash tables configured (bind 32/56)
[   10.573190][    T1] NET: Registered PF_RDS protocol family
[   10.574970][    T1] Registered RDS/infiniband transport
[   10.577010][    T1] Registered RDS/tcp transport
[   10.578040][    T1] tipc: Activated (version 2.0.0)
[   10.580751][    T1] NET: Registered PF_TIPC protocol family
[   10.582721][    T1] tipc: Started in single node mode
[   10.584345][    T1] NET: Registered PF_SMC protocol family
[   10.585878][    T1] 9pnet: Installing 9P2000 support
[   10.588031][    T1] NET: Registered PF_CAIF protocol family
[   10.594274][    T1] NET: Registered PF_IEEE802154 protocol family
[   10.596365][    T1] Key type dns_resolver registered
[   10.598569][    T1] Key type ceph registered
[   10.600505][    T1] libceph: loaded (mon/osd proto 15/24)
[   10.603175][    T1] batman_adv: B.A.T.M.A.N. advanced 2022.3 (compatibility version 15) loaded
[   10.606338][    T1] openvswitch: Open vSwitch switching datapath
[   10.610563][    T1] NET: Registered PF_VSOCK protocol family
[   10.612883][    T1] mpls_gso: MPLS GSO support
[   10.632582][    T1] IPI shorthand broadcast: enabled
[   10.634432][    T1] AVX2 version of gcm_enc/dec engaged.
[   10.636283][    T1] AES CTR mode by8 optimization enabled
[   11.036331][ T3320] ------------[ cut here ]------------
[   11.036432][ T3320] WARNING: CPU: 1 PID: 3320 at kernel/rcu/tree_plugin.h:269 rcu_note_context_switch+0x913/0x1870
[   11.036432][ T3320] Modules linked in:
[   11.036432][ T3320] CPU: 1 PID: 3320 Comm: kworker/u4:0 Not tainted 6.1.0-rc8-next-20221207-syzkaller-dirty #0
[   11.036432][ T3320] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
[   11.036432][ T3320] RIP: 0010:rcu_note_context_switch+0x913/0x1870
[   11.036432][ T3320] Code: 7b 11 00 0f 85 f8 06 00 00 45 85 ff 0f 84 9b f8 ff ff 8b 05 ef 39 53 10 8d 50 01 83 f8 64 89 15 e3 39 53 10 0f 8e 83 f8 ff ff <0f> 0b e9 7c f8 ff ff 48 8d 7b 20 c6 43 11 00 48 b8 00 00 00 00 00
[   11.036432][ T3320] RSP: 0000:ffffc9000e2bf3d0 EFLAGS: 00010002
[   11.057837][ T3320] RAX: 0000000000000065 RBX: ffff8880b993c440 RCX: 0000000000000000
[   11.059836][ T3320] RDX: 0000000000000066 RSI: 0000000000000004 RDI: 0000000000000001
[   11.062326][ T3320] RBP: 0000000000000001 R08: 0000000000000000 R09: ffffffff8c79be43
[   11.064438][ T3320] R10: fffffbfff18f37c8 R11: ffffffff8c79bf00 R12: ffffffff8c79be40
[   11.066489][ T3320] R13: ffff8880b993c460 R14: ffff8880b993c451 R15: 0000000000000001
[   11.068944][ T3320] FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
[   11.071125][ T3320] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   11.073264][ T3320] CR2: 0000000000000000 CR3: 000000000c48e000 CR4: 00000000003506e0
[   11.073264][ T3320] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   11.078150][ T3320] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   11.080625][ T3320] Call Trace:
[   11.082027][ T3320]  <TASK>
[   11.083007][ T3320]  ? lockdep_hardirqs_off+0x94/0xd0
[   11.083007][ T3320]  ? preempt_schedule_notrace+0x5f/0xe0
[   11.083007][ T3320]  __schedule+0x24c/0x5450
[   11.083007][ T3320]  ? asm_sysvec_reschedule_ipi+0x1a/0x20
[   11.083007][ T3320]  ? pvclock_clocksource_read+0xd4/0x530
[   11.083007][ T3320]  ? io_schedule_timeout+0x150/0x150
[   11.083007][ T3320]  ? preempt_schedule_notrace_thunk+0x1a/0x20
[   11.083007][ T3320]  preempt_schedule_notrace+0x5f/0xe0
[   11.083007][ T3320]  preempt_schedule_notrace_thunk+0x1a/0x20
[   11.083007][ T3320]  ? sched_clock_local+0x139/0x1d0
[   11.083007][ T3320]  sched_clock_cpu+0x20d/0x2b0
[   11.083007][ T3320]  ? save_stack+0xbb/0x1e0
[   11.083007][ T3320]  ? prepare_to_wait+0x380/0x380
[   11.083007][ T3320]  ? __alloc_pages+0x1cb/0x5b0
[   11.083007][ T3320]  ? alloc_pages+0x1aa/0x270
[   11.083007][ T3320]  ? allocate_slab+0x25f/0x350
[   11.083007][ T3320]  ? ___slab_alloc+0xa91/0x1400
[   11.083007][ T3320]  ? __slab_alloc.constprop.0+0x56/0xa0
[   11.083007][ T3320]  ? kmem_cache_alloc+0x379/0x430
[   11.083007][ T3320]  ? mas_alloc_nodes+0x429/0x810
[   11.083007][ T3320]  ? mas_preallocate+0x1bb/0x360
[   11.083007][ T3320]  __set_page_owner_handle+0x2ab/0x3b0
[   11.083007][ T3320]  __set_page_owner+0x48/0x60
[   11.083007][ T3320]  get_page_from_freelist+0x119c/0x2ce0
[   11.083007][ T3320]  ? __lock_acquire+0x166e/0x56d0
[   11.083007][ T3320]  ? __zone_watermark_ok+0x460/0x460
[   11.083007][ T3320]  ? prepare_alloc_pages+0x178/0x570
[   11.083007][ T3320]  __alloc_pages+0x1cb/0x5b0
[   11.083007][ T3320]  ? __alloc_pages_slowpath.constprop.0+0x23d0/0x23d0
[   11.083007][ T3320]  alloc_pages+0x1aa/0x270
[   11.083007][ T3320]  allocate_slab+0x25f/0x350
[   11.083007][ T3320]  ___slab_alloc+0xa91/0x1400
[   11.083007][ T3320]  ? mas_alloc_nodes+0x429/0x810
[   11.083007][ T3320]  ? mas_alloc_nodes+0x429/0x810
[   11.083007][ T3320]  __slab_alloc.constprop.0+0x56/0xa0
[   11.083007][ T3320]  ? mas_alloc_nodes+0x429/0x810
[   11.083007][ T3320]  kmem_cache_alloc+0x379/0x430
[   11.083007][ T3320]  mas_alloc_nodes+0x429/0x810
[   11.083007][ T3320]  mas_preallocate+0x1bb/0x360
[   11.083007][ T3320]  vma_link+0xa6/0x290
[   11.083007][ T3320]  ? vma_mas_store+0x3f0/0x3f0
[   11.083007][ T3320]  insert_vm_struct+0x1e5/0x400
[   11.083007][ T3320]  ? exit_mmap+0x7b0/0x7b0
[   11.083007][ T3320]  ? kmem_cache_alloc+0x234/0x430
[   11.083007][ T3320]  alloc_bprm+0x4e1/0x900
[   11.146529][ T3320]  kernel_execve+0xaf/0x500
[   11.148464][ T3320]  call_usermodehelper_exec_async+0x2e7/0x580
[   11.149019][ T3320]  ? umh_complete+0x90/0x90
[   11.149019][ T3320]  ret_from_fork+0x1f/0x30
[   11.149019][ T3320]  </TASK>
[   11.149019][ T3320] Kernel panic - not syncing: kernel: panic_on_warn set ...
[   11.149019][ T3320] CPU: 1 PID: 3320 Comm: kworker/u4:0 Not tainted 6.1.0-rc8-next-20221207-syzkaller-dirty #0
[   11.149019][ T3320] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
[   11.149019][ T3320] Call Trace:
[   11.149019][ T3320]  <TASK>
[   11.149019][ T3320]  dump_stack_lvl+0xd1/0x138
[   11.149019][ T3320]  panic+0x2cc/0x626
[   11.149019][ T3320]  ? panic_print_sys_info.part.0+0x110/0x110
[   11.149019][ T3320]  ? rcu_note_context_switch+0x913/0x1870
[   11.149019][ T3320]  check_panic_on_warn.cold+0x19/0x35
[   11.149019][ T3320]  __warn+0xf2/0x1a0
[   11.149019][ T3320]  ? rcu_note_context_switch+0x913/0x1870
[   11.149019][ T3320]  report_bug+0x1c0/0x210
[   11.149019][ T3320]  handle_bug+0x3c/0x70
[   11.149019][ T3320]  exc_invalid_op+0x18/0x50
[   11.149019][ T3320]  asm_exc_invalid_op+0x1a/0x20
[   11.176555][ T3320] RIP: 0010:rcu_note_context_switch+0x913/0x1870
[   11.176561][ T3320] Code: 7b 11 00 0f 85 f8 06 00 00 45 85 ff 0f 84 9b f8 ff ff 8b 05 ef 39 53 10 8d 50 01 83 f8 64 89 15 e3 39 53 10 0f 8e 83 f8 ff ff <0f> 0b e9 7c f8 ff ff 48 8d 7b 20 c6 43 11 00 48 b8 00 00 00 00 00
[   11.184084][ T3320] RSP: 0000:ffffc9000e2bf3d0 EFLAGS: 00010002
[   11.186302][ T3320] RAX: 0000000000000065 RBX: ffff8880b993c440 RCX: 0000000000000000
[   11.188128][ T3320] RDX: 0000000000000066 RSI: 0000000000000004 RDI: 0000000000000001
[   11.189513][ T3320] RBP: 0000000000000001 R08: 0000000000000000 R09: ffffffff8c79be43
[   11.189513][ T3320] R10: fffffbfff18f37c8 R11: ffffffff8c79bf00 R12: ffffffff8c79be40
[   11.189513][ T3320] R13: ffff8880b993c460 R14: ffff8880b993c451 R15: 0000000000000001
[   11.189513][ T3320]  ? lockdep_hardirqs_off+0x94/0xd0
[   11.189513][ T3320]  ? preempt_schedule_notrace+0x5f/0xe0
[   11.189513][ T3320]  __schedule+0x24c/0x5450
[   11.189513][ T3320]  ? asm_sysvec_reschedule_ipi+0x1a/0x20
[   11.189513][ T3320]  ? pvclock_clocksource_read+0xd4/0x530
[   11.189513][ T3320]  ? io_schedule_timeout+0x150/0x150
[   11.189513][ T3320]  ? preempt_schedule_notrace_thunk+0x1a/0x20
[   11.206531][ T3320]  preempt_schedule_notrace+0x5f/0xe0
[   11.206531][ T3320]  preempt_schedule_notrace_thunk+0x1a/0x20
[   11.206531][ T3320]  ? sched_clock_local+0x139/0x1d0
[   11.206531][ T3320]  sched_clock_cpu+0x20d/0x2b0
[   11.206531][ T3320]  ? save_stack+0xbb/0x1e0
[   11.206531][ T3320]  ? prepare_to_wait+0x380/0x380
[   11.206531][ T3320]  ? __alloc_pages+0x1cb/0x5b0
[   11.206531][ T3320]  ? alloc_pages+0x1aa/0x270
[   11.206531][ T3320]  ? allocate_slab+0x25f/0x350
[   11.206531][ T3320]  ? ___slab_alloc+0xa91/0x1400
[   11.206531][ T3320]  ? __slab_alloc.constprop.0+0x56/0xa0
[   11.206531][ T3320]  ? kmem_cache_alloc+0x379/0x430
[   11.206531][ T3320]  ? mas_alloc_nodes+0x429/0x810
[   11.206531][ T3320]  ? mas_preallocate+0x1bb/0x360
[   11.206531][ T3320]  __set_page_owner_handle+0x2ab/0x3b0
[   11.206531][ T3320]  __set_page_owner+0x48/0x60
[   11.206531][ T3320]  get_page_from_freelist+0x119c/0x2ce0
[   11.206531][ T3320]  ? __lock_acquire+0x166e/0x56d0
[   11.206531][ T3320]  ? __zone_watermark_ok+0x460/0x460
[   11.206531][ T3320]  ? prepare_alloc_pages+0x178/0x570
[   11.234792][ T3320]  __alloc_pages+0x1cb/0x5b0
[   11.236054][ T3320]  ? __alloc_pages_slowpath.constprop.0+0x23d0/0x23d0
[   11.236054][ T3320]  alloc_pages+0x1aa/0x270
[   11.236054][ T3320]  allocate_slab+0x25f/0x350
[   11.236054][ T3320]  ___slab_alloc+0xa91/0x1400
[   11.236054][ T3320]  ? mas_alloc_nodes+0x429/0x810
[   11.236054][ T3320]  ? mas_alloc_nodes+0x429/0x810
[   11.236054][ T3320]  __slab_alloc.constprop.0+0x56/0xa0
[   11.236054][ T3320]  ? mas_alloc_nodes+0x429/0x810
[   11.236054][ T3320]  kmem_cache_alloc+0x379/0x430
[   11.236054][ T3320]  mas_alloc_nodes+0x429/0x810
[   11.236054][ T3320]  mas_preallocate+0x1bb/0x360
[   11.236054][ T3320]  vma_link+0xa6/0x290
[   11.236054][ T3320]  ? vma_mas_store+0x3f0/0x3f0
[   11.236054][ T3320]  insert_vm_struct+0x1e5/0x400
[   11.236054][ T3320]  ? exit_mmap+0x7b0/0x7b0
[   11.236054][ T3320]  ? kmem_cache_alloc+0x234/0x430
[   11.236054][ T3320]  alloc_bprm+0x4e1/0x900
[   11.236054][ T3320]  kernel_execve+0xaf/0x500
[   11.236054][ T3320]  call_usermodehelper_exec_async+0x2e7/0x580
[   11.236054][ T3320]  ? umh_complete+0x90/0x90
[   11.236054][ T3320]  ret_from_fork+0x1f/0x30
[   11.236054][ T3320]  </TASK>
[   11.236054][ T3320] Kernel Offset: disabled
[   11.236054][ T3320] Rebooting in 86400 seconds..


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
GOGCCFLAGS="-fPIC -m64 -pthread -fmessage-length=0 -fdebug-prefix-map=/tmp/go-build1709421499=/tmp/go-build -gno-record-gcc-switches"

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
https://syzkaller.appspot.com/x/error.txt?x=1263316d880000


Tested on:

commit:         591cd615 Add linux-next specific files for 20221207
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=8b2d3e63e054c24f
dashboard link: https://syzkaller.appspot.com/bug?extid=1eb4232fca28c0a6d1c2
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11621467880000

