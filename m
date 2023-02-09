Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74314690118
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 08:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjBIHTZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 9 Feb 2023 02:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjBIHTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 02:19:11 -0500
Received: from mail-io1-xd45.google.com (mail-io1-xd45.google.com [IPv6:2607:f8b0:4864:20::d45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD42D11EBA
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 23:18:49 -0800 (PST)
Received: by mail-io1-xd45.google.com with SMTP id d8-20020a6b6e08000000b00722d8d9c432so767191ioh.19
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 23:18:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oMvUq306uZxzl0z8HrClM7cnw5iSAQE5OzrYYNvmOWU=;
        b=1KBBG7lRpOGwKGKj5aVjC4N1DyCQBNgJ6IEcwwFKdAq/Gq02o/yxy+7QLJXQNyWaK8
         PEmxmsb98cgkkfxJrD+1+9D1HGDJx92mathgFADRxBtpanst8zSktnVaMBsDjwa2u6Lu
         KhyjkoEE/4nbNDy0Q0zkaiBNcHfxW1MEJqcyf8M6WpI/Fvs8YszMGmBTpa71N2icqizi
         ostr7DxC9LIaQTjO/GJIZWyeb88XiXbGVYB329zGi6u1duO4yLy4bS/ck5Mf6ucCp2nj
         F3PgxzAijGH1DTI4t++Z/PwqC6kxyLqYcCFxhNLTDt3GyAuXiBTpgFcOUGhGevO/aLrs
         IA4Q==
X-Gm-Message-State: AO0yUKVnwgo97vfrXqt7/7sMSv1C0TsUSBJMGSeM9El1FjoBn0Fosf4d
        rI1ZDrQ3ovN1tw2dIULMW5k/LSOREyt8cLO2QpFg7ICxOdjz
X-Google-Smtp-Source: AK7set+l8uDBXinZzg5uE9oElXzI2PWbfyN6cfZK34wki17AYtPDo2mDEPgxOeoO9rW0q5LDb8yUSFiZ2nlio429F/q2Cxv+uSVL
MIME-Version: 1.0
X-Received: by 2002:a02:ad08:0:b0:3a9:611a:928b with SMTP id
 s8-20020a02ad08000000b003a9611a928bmr6751050jan.55.1675926978792; Wed, 08 Feb
 2023 23:16:18 -0800 (PST)
Date:   Wed, 08 Feb 2023 23:16:18 -0800
In-Reply-To: <20230209061936.2127-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003d940905f43f2864@google.com>
Subject: Re: [syzbot] INFO: rcu detected stall in ext4_file_write_iter (6)
From:   syzbot <syzbot+b9564ba6e8e00694511b@syzkaller.appspotmail.com>
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

ExtendedConfig ASPM ClockPM MSI]
[    2.704971][    T1] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended configuration space under this bridge
[    2.721274][    T1] PCI host bridge to bus 0000:00
[    2.722257][    T1] pci_bus 0000:00: Unknown NUMA node; performance will be reduced
[    2.723618][    T1] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    2.725109][    T1] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    2.726984][    T1] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    2.727782][    T1] pci_bus 0000:00: root bus resource [mem 0xc0000000-0xfebfefff window]
[    2.729339][    T1] pci_bus 0000:00: root bus resource [bus 00-ff]
[    2.730963][    T1] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000
[    2.739900][    T1] pci 0000:00:01.0: [8086:7110] type 00 class 0x060100
[    2.771630][    T1] pci 0000:00:01.3: [8086:7113] type 00 class 0x068000
[    2.799785][    T1] pci 0000:00:01.3: quirk: [io  0xb000-0xb03f] claimed by PIIX4 ACPI
[    2.805032][    T1] pci 0000:00:03.0: [1af4:1004] type 00 class 0x000000
[    2.817461][    T1] pci 0000:00:03.0: reg 0x10: [io  0xc000-0xc03f]
[    2.824197][    T1] pci 0000:00:03.0: reg 0x14: [mem 0xfe800000-0xfe80007f]
[    2.850249][    T1] pci 0000:00:04.0: [1af4:1000] type 00 class 0x020000
[    2.860971][    T1] pci 0000:00:04.0: reg 0x10: [io  0xc040-0xc07f]
[    2.869561][    T1] pci 0000:00:04.0: reg 0x14: [mem 0xfe801000-0xfe80107f]
[    2.893212][    T1] pci 0000:00:05.0: [1ae0:a002] type 00 class 0x030000
[    2.907509][    T1] pci 0000:00:05.0: reg 0x10: [mem 0xfe000000-0xfe7fffff]
[    2.938174][    T1] pci 0000:00:05.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    2.944947][    T1] pci 0000:00:06.0: [1af4:1002] type 00 class 0x00ff00
[    2.955123][    T1] pci 0000:00:06.0: reg 0x10: [io  0xc080-0xc09f]
[    2.962448][    T1] pci 0000:00:06.0: reg 0x14: [mem 0xfe802000-0xfe80207f]
[    2.988501][    T1] pci 0000:00:07.0: [1af4:1005] type 00 class 0x00ff00
[    2.999322][    T1] pci 0000:00:07.0: reg 0x10: [io  0xc0a0-0xc0bf]
[    3.006863][    T1] pci 0000:00:07.0: reg 0x14: [mem 0xfe803000-0xfe80303f]
[    3.054017][    T1] ACPI: PCI: Interrupt link LNKA configured for IRQ 10
[    3.061314][    T1] ACPI: PCI: Interrupt link LNKB configured for IRQ 10
[    3.070348][    T1] ACPI: PCI: Interrupt link LNKC configured for IRQ 11
[    3.078101][    T1] ACPI: PCI: Interrupt link LNKD configured for IRQ 11
[    3.084571][    T1] ACPI: PCI: Interrupt link LNKS configured for IRQ 9
[    3.100822][    T1] iommu: Default domain type: Translated 
[    3.102824][    T1] iommu: DMA domain TLB invalidation policy: lazy mode 
[    3.110275][    T1] SCSI subsystem initialized
[    3.114447][    T1] ACPI: bus type USB registered
[    3.116457][    T1] usbcore: registered new interface driver usbfs
[    3.117993][    T1] usbcore: registered new interface driver hub
[    3.119852][    T1] usbcore: registered new device driver usb
[    3.122466][    T1] mc: Linux media interface: v0.10
[    3.123533][    T1] videodev: Linux video capture interface: v2.00
[    3.125526][    T1] pps_core: LinuxPPS API ver. 1 registered
[    3.126906][    T1] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    3.127854][    T1] PTP clock support registered
[    3.130020][    T1] EDAC MC: Ver: 3.0.0
[    3.135116][    T1] Advanced Linux Sound Architecture Driver Initialized.
[    3.143220][    T1] Bluetooth: Core ver 2.22
[    3.144600][    T1] NET: Registered PF_BLUETOOTH protocol family
[    3.145633][    T1] Bluetooth: HCI device and connection manager initialized
[    3.147881][    T1] Bluetooth: HCI socket layer initialized
[    3.149539][    T1] Bluetooth: L2CAP socket layer initialized
[    3.150683][    T1] Bluetooth: SCO socket layer initialized
[    3.151990][    T1] NET: Registered PF_ATMPVC protocol family
[    3.153007][    T1] NET: Registered PF_ATMSVC protocol family
[    3.154497][    T1] NetLabel: Initializing
[    3.155425][    T1] NetLabel:  domain hash size = 128
[    3.156282][    T1] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    3.158252][    T1] NetLabel:  unlabeled traffic allowed by default
[    3.160111][    T1] nfc: nfc_init: NFC Core ver 0.1
[    3.160111][    T1] NET: Registered PF_NFC protocol family
[    3.160111][    T1] PCI: Using ACPI for IRQ routing
[    3.160111][    T1] pci 0000:00:05.0: vgaarb: setting as boot VGA device
[    3.160111][    T1] pci 0000:00:05.0: vgaarb: bridge control possible
[    3.161322][    T1] pci 0000:00:05.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    3.163054][    T1] vgaarb: loaded
[    3.177757][    T1] clocksource: Switched to clocksource kvm-clock
[    3.187013][    T1] VFS: Disk quotas dquot_6.6.0
[    3.187770][    C0] ------------[ cut here ]------------
[    3.188101][    T1] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    3.188708][    C0] jts hrtimer tick_sched_timer+0x0/0x120 runs more than 20 ticks
[    3.190632][    T1] FS-Cache: Loaded
[    3.191689][    C0] WARNING: CPU: 0 PID: 10 at kernel/time/hrtimer.c:1693 __hrtimer_run_queues+0xf76/0x1200
[    3.193672][    T1] CacheFiles: Loaded
[    3.193967][    C0] Modules linked in:
[    3.195296][    C0] CPU: 0 PID: 10 Comm: kworker/u4:0 Not tainted 6.2.0-rc6-next-20230203-syzkaller #0
[    3.195308][    T1] TOMOYO: 2.6.0
[    3.196864][    C0] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/21/2023
[    3.196881][    C0] Workqueue: eval_map_wq eval_map_work_func
[    3.197481][    T1] Mandatory Access Control activated.
[    3.201064][    T1] AppArmor: AppArmor Filesystem Enabled
[    3.197760][    C0] 
[    3.197760][    C0] RIP: 0010:__hrtimer_run_queues+0xf76/0x1200
[    3.202884][    T1] pnp: PnP ACPI init
[    3.197760][    C0] Code: 96 10 00 e9 1e f3 ff ff bd 01 00 00 00 e8 72 9a 10 00 48 8b 74 24 28 48 c7 c7 c0 d5 4e 8a c6 05 5e e1 eb 0c 01 e8 3a 2b d8 ff <0f> 0b e8 53 9a 10 00 31 ff 89 ee e8 5a 96 10 00 40 84 ed 0f 84 e3
[    3.197760][    C0] RSP: 0000:ffffc90000007de0 EFLAGS: 00010082
[    3.197760][    C0] RAX: 0000000000000000 RBX: ffffffff8e7519c0 RCX: 0000000000000000
[    3.197760][    C0] RDX: ffff888016699d40 RSI: ffffffff814c0217 RDI: 0000000000000001
[    3.197760][    C0] RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
[    3.197760][    C0] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8880b982b968
[    3.197760][    C0] R13: ffff8880b982b880 R14: ffff8880b982c120 R15: ffff8880b982b800
[    3.197760][    C0] FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
[    3.197760][    C0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.197760][    C0] CR2: ffff88823ffff000 CR3: 000000000c56f000 CR4: 00000000003506f0
[    3.197760][    C0] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    3.197760][    C0] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    3.197760][    C0] Call Trace:
[    3.197760][    C0]  <IRQ>
[    3.197760][    C0]  ? tick_sched_do_timer+0x470/0x470
[    3.223647][    T1] pnp: PnP ACPI: found 7 devices
[    3.197760][    C0]  ? retrigger_next_event+0x3b0/0x3b0
[    3.197760][    C0]  ? ktime_get_update_offsets_now+0x3ef/0x5c0
[    3.197760][    C0]  hrtimer_interrupt+0x320/0x7b0
[    3.197760][    C0]  __sysvec_apic_timer_interrupt+0x180/0x660
[    3.197760][    C0]  sysvec_apic_timer_interrupt+0x92/0xc0
[    3.197760][    C0]  </IRQ>
[    3.197760][    C0]  <TASK>
[    3.197760][    C0]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[    3.197760][    C0] RIP: 0010:trace_event_eval_update+0x3a8/0xf70
[    3.197760][    C0] Code: f7 ff 45 84 ed 0f 85 81 05 00 00 e8 e2 d8 f7 ff 89 de bf 5f 00 00 00 e8 e6 d4 f7 ff 80 fb 5f 0f 84 67 05 00 00 e8 c8 d8 f7 ff <4c> 8d 6d 01 4c 89 e8 4c 89 ea 48 c1 e8 03 83 e2 07 42 0f b6 04 38
[    3.197760][    C0] RSP: 0000:ffffc900000f7c40 EFLAGS: 00000293
[    3.237854][    C0] RAX: 0000000000000000 RBX: 0000000000000020 RCX: 0000000000000000
[    3.237854][    C0] RDX: ffff888016699d40 RSI: ffffffff818c96e8 RDI: 0000000000000001
[    3.237854][    C0] RBP: ffffffff8cf1cb8c R08: 0000000000000001 R09: 000000000000005f
[    3.237854][    C0] R10: 0000000000000020 R11: 495353415022202c R12: 0000000000000029
[    3.237854][    C0] R13: 0000000000000000 R14: 0000000000000000 R15: dffffc0000000000
[    3.237854][    C0]  ? trace_event_eval_update+0x3a8/0xf70
[    3.237854][    C0]  eval_map_work_func+0x3c/0x50
[    3.237854][    C0]  process_one_work+0x9bf/0x1820
[    3.237854][    C0]  ? pwq_dec_nr_in_flight+0x2a0/0x2a0
[    3.237854][    C0]  ? rcu_read_lock_sched_held+0x3e/0x70
[    3.237854][    C0]  ? spin_bug+0x1c0/0x1c0
[    3.237854][    C0]  ? lock_acquire+0x32/0xc0
[    3.237854][    C0]  ? worker_thread+0x16d/0x1090
[    3.237854][    C0]  worker_thread+0x669/0x1090
[    3.237854][    C0]  ? process_one_work+0x1820/0x1820
[    3.237854][    C0]  kthread+0x2e8/0x3a0
[    3.237854][    C0]  ? kthread_complete_and_exit+0x40/0x40
[    3.237854][    C0]  ret_from_fork+0x1f/0x30
[    3.237854][    C0]  </TASK>
[    3.237854][    C0] Kernel panic - not syncing: kernel: panic_on_warn set ...
[    3.237854][    C0] CPU: 0 PID: 10 Comm: kworker/u4:0 Not tainted 6.2.0-rc6-next-20230203-syzkaller #0
[    3.237854][    C0] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/21/2023
[    3.237854][    C0] Workqueue: eval_map_wq eval_map_work_func
[    3.237854][    C0] Call Trace:
[    3.237854][    C0]  <IRQ>
[    3.237854][    C0]  dump_stack_lvl+0xd9/0x150
[    3.237854][    C0]  panic+0x61b/0x6c0
[    3.237854][    C0]  ? panic_smp_self_stop+0x90/0x90
[    3.237854][    C0]  ? show_trace_log_lvl+0x285/0x390
[    3.237854][    C0]  ? __hrtimer_run_queues+0xf76/0x1200
[    3.237854][    C0]  check_panic_on_warn+0xb1/0xc0
[    3.237854][    C0]  __warn+0xf2/0x4f0
[    3.237854][    C0]  ? __hrtimer_run_queues+0xf76/0x1200
[    3.237854][    C0]  report_bug+0x2da/0x500
[    3.237854][    C0]  handle_bug+0x3c/0x70
[    3.237854][    C0]  exc_invalid_op+0x18/0x50
[    3.237854][    C0]  asm_exc_invalid_op+0x1a/0x20
[    3.237854][    C0] RIP: 0010:__hrtimer_run_queues+0xf76/0x1200
[    3.237854][    C0] Code: 96 10 00 e9 1e f3 ff ff bd 01 00 00 00 e8 72 9a 10 00 48 8b 74 24 28 48 c7 c7 c0 d5 4e 8a c6 05 5e e1 eb 0c 01 e8 3a 2b d8 ff <0f> 0b e8 53 9a 10 00 31 ff 89 ee e8 5a 96 10 00 40 84 ed 0f 84 e3
[    3.237854][    C0] RSP: 0000:ffffc90000007de0 EFLAGS: 00010082
[    3.237854][    C0] RAX: 0000000000000000 RBX: ffffffff8e7519c0 RCX: 0000000000000000
[    3.237854][    C0] RDX: ffff888016699d40 RSI: ffffffff814c0217 RDI: 0000000000000001
[    3.237854][    C0] RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
[    3.237854][    C0] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8880b982b968
[    3.237854][    C0] R13: ffff8880b982b880 R14: ffff8880b982c120 R15: ffff8880b982b800
[    3.237854][    C0]  ? __warn_printk+0x187/0x310
[    3.237854][    C0]  ? tick_sched_do_timer+0x470/0x470
[    3.237854][    C0]  ? retrigger_next_event+0x3b0/0x3b0
[    3.237854][    C0]  ? ktime_get_update_offsets_now+0x3ef/0x5c0
[    3.237854][    C0]  hrtimer_interrupt+0x320/0x7b0
[    3.237854][    C0]  __sysvec_apic_timer_interrupt+0x180/0x660
[    3.237854][    C0]  sysvec_apic_timer_interrupt+0x92/0xc0
[    3.237854][    C0]  </IRQ>
[    3.237854][    C0]  <TASK>
[    3.237854][    C0]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[    3.237854][    C0] RIP: 0010:trace_event_eval_update+0x3a8/0xf70
[    3.237854][    C0] Code: f7 ff 45 84 ed 0f 85 81 05 00 00 e8 e2 d8 f7 ff 89 de bf 5f 00 00 00 e8 e6 d4 f7 ff 80 fb 5f 0f 84 67 05 00 00 e8 c8 d8 f7 ff <4c> 8d 6d 01 4c 89 e8 4c 89 ea 48 c1 e8 03 83 e2 07 42 0f b6 04 38
[    3.237854][    C0] RSP: 0000:ffffc900000f7c40 EFLAGS: 00000293
[    3.237854][    C0] RAX: 0000000000000000 RBX: 0000000000000020 RCX: 0000000000000000
[    3.237854][    C0] RDX: ffff888016699d40 RSI: ffffffff818c96e8 RDI: 0000000000000001
[    3.237854][    C0] RBP: ffffffff8cf1cb8c R08: 0000000000000001 R09: 000000000000005f
[    3.237854][    C0] R10: 0000000000000020 R11: 495353415022202c R12: 0000000000000029
[    3.237854][    C0] R13: 0000000000000000 R14: 0000000000000000 R15: dffffc0000000000
[    3.237854][    C0]  ? trace_event_eval_update+0x3a8/0xf70
[    3.237854][    C0]  eval_map_work_func+0x3c/0x50
[    3.237854][    C0]  process_one_work+0x9bf/0x1820
[    3.237854][    C0]  ? pwq_dec_nr_in_flight+0x2a0/0x2a0
[    3.237854][    C0]  ? rcu_read_lock_sched_held+0x3e/0x70
[    3.237854][    C0]  ? spin_bug+0x1c0/0x1c0
[    3.237854][    C0]  ? lock_acquire+0x32/0xc0
[    3.237854][    C0]  ? worker_thread+0x16d/0x1090
[    3.237854][    C0]  worker_thread+0x669/0x1090
[    3.237854][    C0]  ? process_one_work+0x1820/0x1820
[    3.237854][    C0]  kthread+0x2e8/0x3a0
[    3.237854][    C0]  ? kthread_complete_and_exit+0x40/0x40
[    3.237854][    C0]  ret_from_fork+0x1f/0x30
[    3.237854][    C0]  </TASK>
[    3.237854][    C0] Rebooting in 86400 seconds..


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
GOMODCACHE="/syzkaller/jobs-2/linux/gopath/pkg/mod"
GONOPROXY=""
GONOSUMDB=""
GOOS="linux"
GOPATH="/syzkaller/jobs-2/linux/gopath"
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
GOMOD="/syzkaller/jobs-2/linux/gopath/src/github.com/google/syzkaller/go.mod"
CGO_CFLAGS="-g -O2"
CGO_CPPFLAGS=""
CGO_CXXFLAGS="-g -O2"
CGO_FFLAGS="-g -O2"
CGO_LDFLAGS="-g -O2"
PKG_CONFIG="pkg-config"
GOGCCFLAGS="-fPIC -m64 -pthread -fmessage-length=0 -fdebug-prefix-map=/tmp/go-build909161844=/tmp/go-build -gno-record-gcc-switches"

git status (err=<nil>)
HEAD detached at 1b2f701aa
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
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=1b2f701aa9a17abb7e27c7c1170d26398febf247 -X 'github.com/google/syzkaller/prog.gitRevisionDate=20230203-112454'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer github.com/google/syzkaller/syz-fuzzer
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=1b2f701aa9a17abb7e27c7c1170d26398febf247 -X 'github.com/google/syzkaller/prog.gitRevisionDate=20230203-112454'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=1b2f701aa9a17abb7e27c7c1170d26398febf247 -X 'github.com/google/syzkaller/prog.gitRevisionDate=20230203-112454'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wframe-larger-than=16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-format-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -static-pie -fpermissive -w -DGOOS_linux=1 -DGOARCH_amd64=1 \
	-DHOSTGOOS_linux=1 -DGIT_REVISION=\"1b2f701aa9a17abb7e27c7c1170d26398febf247\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=16d60afb480000


Tested on:

commit:         4fafd969 Add linux-next specific files for 20230203
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d2fba7d42502ca4
dashboard link: https://syzkaller.appspot.com/bug?extid=b9564ba6e8e00694511b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1343af13480000

