Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F51872EB5F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 20:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240355AbjFMS6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 14:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240595AbjFMS6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 14:58:12 -0400
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8BBB5;
        Tue, 13 Jun 2023 11:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1686682692; x=1718218692;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=99Ry+JANkUA7HY3zQALU3ZGK2YVNo3ZvwuUiJUhJAUg=;
  b=HBRbphHHLCpncBzserGkYiQy9z+06uh9aCHLnM/4I+cD4hlHwmMTmmFb
   UDx2qW7WZbC6iTI8iN7NHPH/2MVcS1u3fDwG2nFR571dMyQxurkHwIZo3
   qOjJA5mfraQXQF8r2UePz85m4N9NUxYbpXwhPSmnpbmch6oj+FbilyQ6i
   U=;
X-IronPort-AV: E=Sophos;i="6.00,240,1681171200"; 
   d="scan'208";a="220442874"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-e651a362.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 18:58:11 +0000
Received: from EX19MTAUWB002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1d-m6i4x-e651a362.us-east-1.amazon.com (Postfix) with ESMTPS id 55C63805C7;
        Tue, 13 Jun 2023 18:58:08 +0000 (UTC)
Received: from EX19D002UWC004.ant.amazon.com (10.13.138.186) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 13 Jun 2023 18:58:07 +0000
Received: from [192.168.4.185] (10.187.170.24) by
 EX19D002UWC004.ant.amazon.com (10.13.138.186) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 13 Jun 2023 18:58:06 +0000
Message-ID: <c4724b40-89f6-5aa7-720d-c4a4af57cf45@amazon.com>
Date:   Tue, 13 Jun 2023 11:58:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: Observing RCU stalls in kernel 5.4/5.10/5.15/6.1 stable trees
Content-Language: en-US
From:   "Bhatnagar, Rishabh" <risbhat@amazon.com>
To:     <bigeasy@linutronix.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "sashal@kernel.org" <sashal@kernel.org>, <luizcap@amazon.com>,
        <abuehaze@amazon.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <12c6f9a3-d087-b824-0d05-0d18c9bc1bf3@amazon.com>
In-Reply-To: <12c6f9a3-d087-b824-0d05-0d18c9bc1bf3@amazon.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.187.170.24]
X-ClientProxiedBy: EX19D039UWA001.ant.amazon.com (10.13.139.110) To
 EX19D002UWC004.ant.amazon.com (10.13.138.186)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/13/23 11:49 AM, Bhatnagar, Rishabh wrote:
> Hi Sebastian/Greg
>
> We are seeing RCU stall warnings from recent stable tree updates:
> 5.4.243, 5.10.180, 5.15.113, 6.1.31 onwards.
> This is seen in the upstream stable trees without any downstream patches.
>
> The issue is seen few minutes after booting without any workload.
> We launch hundred's of virtual instances and this shows up in 1-2 
> instances, so its hard to reproduce.
> Attaching a few stack traces below.
>
> The issue can be seen on virtual and baremetal instances.
> Another interesting point is we only see this on x86 based instances.
> We also did test this on linux-mainline but were not able to reproduce 
> the issue.
> So maybe there's a fixup or related commit that has gone in?
>
> We tried bisecting the stable trees and found that after reverting the
> below commit we couldn't reproduce this in any of the kernels 
> consistently.
>
> tick/common: Align tick period with the HZ tick. [ Upstream commit
> e9523a0d81899361214d118ad60ef76f0e92f71d ]
>
>
> Not exactly sure how this commit is affecting all stable kernels.
> Can you take a look at this issue and share your insight?
>
> A few example stack traces of the observed RCU stall.
>
> Seen in kernel-5.10.181:
>
> rcu: INFO: rcu_sched self-detected stall on CPU
> rcu: 37-....: (1818 ticks this GP) idle=cf2/1/0x4000000000000000
> softirq=151/151 fqs=7245
>   (t=14809 jiffies g=-759 q=3290)
> NMI backtrace for cpu 37
> Hardware name: Xen HVM domU, BIOS 4.11.amazon 08/24/2006
> Call Trace:
>   <IRQ>
>   dump_stack+0x57/0x70
>   ? lapic_can_unplug_cpu.cold+0x3a/0x3a
>   nmi_cpu_backtrace.cold+0x32/0x68
>   nmi_trigger_cpumask_backtrace+0xdf/0xe6
>   rcu_dump_cpu_stacks+0xa5/0xd7
>   print_cpu_stall.cold+0xa4/0x149
>   check_cpu_stall+0xee/0x210
>   rcu_pending+0x26/0xc0
>   rcu_sched_clock_irq+0x43/0x110
>   update_process_times+0x8c/0xc0
>   tick_periodic+0x27/0x80
>   tick_handle_periodic+0x20/0x70
>   xen_timer_interrupt+0x1e/0x30
>   __handle_irq_event_percpu+0x3d/0x160
>   handle_irq_event_percpu+0x31/0x80
>   handle_percpu_irq+0x37/0x60
>   generic_handle_irq+0x4b/0x60
>   evtchn_2l_handle_events+0x26d/0x280
>   __xen_evtchn_do_upcall+0x66/0xb0
>   __sysvec_xen_hvm_callback+0x22/0x30
>   asm_call_irq_on_stack+0x12/0x20
>   </IRQ>
>   sysvec_xen_hvm_callback+0x72/0x80
>   asm_sysvec_xen_hvm_callback+0x12/0x20
> RIP: 0010:_raw_spin_unlock_irqrestore+0xe/0x20
> RSP: 0000:ffffc900188ffa28 EFLAGS: 00000246
>   pci_conf1_read+0xa4/0x100
>   pci_bus_read_config_byte+0x3f/0x70
>   __pci_find_next_cap_ttl+0x3b/0xd0
>   pci_find_capability+0x71/0xa0
>   pci_pm_init+0x6c/0x1c0
>   ? pci_allocate_vc_save_buffers+0x6d/0x8b
>   pci_device_add+0xb0/0x1b0
>   pci_scan_single_device+0xbd/0xf0
>   pci_scan_slot+0x53/0x120
>   pci_scan_child_bus_extend+0x3a/0x2a0
>   acpi_pci_root_create+0x20c/0x26a
>   pci_acpi_scan_root+0x19a/0x1c0
>   ? negotiate_os_control+0xdd/0x2b9
>   acpi_pci_root_add.cold+0x59/0x1b0
>   acpi_bus_attach+0xee/0x210
>   acpi_bus_attach+0x63/0x210
>   acpi_bus_attach+0x63/0x210
>   acpi_bus_scan+0x43/0x90
>   ? acpi_bus_init+0x15f/0x15f
>   acpi_scan_init+0x10e/0x1b4
>   acpi_init+0xba/0x11d
>   ? intel_idle_init+0x2a2/0x2a2
>   do_one_initcall+0x44/0x1c4
>   do_initcalls+0xc6/0xdf
>   kernel_init_freeable+0x14d/0x198
>   ? rest_init+0xb4/0xb4
>   kernel_init+0xa/0x11c
>   ret_from_fork+0x22/0x30
>
> Seen in kernel-5.4.246:
>
> NMI backtrace for cpu 7
> CPU: 7 PID: 1 Comm: swapper/0 Not tainted 5.4.246 #1
> Hardware name: Amazon EC2 m5.2xlarge/, BIOS 1.0 10/16/2017
> RIP: 0010:lapic_next_deadline+0x26/0x40
> RSP: 0000:ffffc900001ecf98 EFLAGS: 00000002
> Call Trace:
>  <NMI>
>  ? nmi_cpu_backtrace+0x4c/0x90
>  ? nmi_cpu_backtrace_handler+0xd/0x20
>  ? nmi_handle+0x71/0x160
>  ? default_do_nmi+0x4e/0x100
>  ? do_nmi+0x15b/0x190
>  ? end_repeat_nmi+0x16/0x62
>  ? lapic_next_deadline+0x26/0x40
>  ? lapic_next_deadline+0x26/0x40
>  ? lapic_next_deadline+0x26/0x40
>  </NMI>
>  <IRQ>
>  clockevents_program_event+0xcf/0x100
>  tick_handle_periodic+0x48/0x60
>  smp_apic_timer_interrupt+0x6a/0x130
>  apic_timer_interrupt+0xf/0x20
>  </IRQ>
>  ? vprintk_emit+0x19b/0x280
>  ? printk+0x52/0x6e
>  ? pci_hp_add+0x189/0x300
>  ? acpiphp_register_hotplug_slot+0xe0/0xf0
>  ? acpiphp_add_context+0x3b1/0x460
>  ? acpi_ns_walk_namespace+0x108/0x220
>  ? acpiphp_put_context.part.12+0x30/0x30
>  ? acpi_walk_namespace+0xc8/0xf0
>  ? kmem_cache_alloc_trace+0x1f8/0x210
>  ? acpiphp_enumerate_slots+0x172/0x250
>  ? acpi_pci_add_bus+0x50/0xd0
>  ? pci_register_host_bridge+0x22b/0x460
>  ? pci_create_root_bus+0x87/0xb0
>  ? acpi_pci_root_create+0x128/0x290
>  ? pci_acpi_scan_root+0x14a/0x1b0
>  ? acpi_pci_root_add+0x1ff/0x580
>  ? acpi_evaluate_integer+0x52/0x90
>  ? set_debug_rodata+0x2f/0x2f
>  ? acpi_bus_attach+0x144/0x1d0
>  ? acpi_bus_attach+0x80/0x1d0
>  ? acpi_bus_attach+0x80/0x1d0
>  ? acpi_sleep_proc_init+0x24/0x24
>  ? acpi_sleep_proc_init+0x24/0x24
>  ? acpi_bus_scan+0x43/0x90
>  ? acpi_scan_init+0xf1/0x235
>  ? acpi_sleep_proc_init+0x24/0x24
>  ? acpi_init+0x2e9/0x349
>  ? do_one_initcall+0x46/0x200
>  ? kernel_init_freeable+0x1db/0x286
>  ? rest_init+0xb0/0xb0
>  ? kernel_init+0xa/0x110
>  ? ret_from_fork+0x35/0x40
>
>
> Seen in 5.10.183:
>
> rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> acpiphp: Slot [19] registered
> rcu:     3-....: (349 ticks this GP) idle=936/1/0x4000000000000000 
> softirq=94/94 fqs=151
>  (detected by 0, t=14752 jiffies, g=-1063, q=591)
> Sending NMI from CPU 0 to CPUs 3:
> NMI backtrace for cpu 3
> CPU: 3 PID: 1 Comm: swapper/0 Not tainted 5.10.183 #1
> Hardware name: Amazon EC2 m5.2xlarge/, BIOS 1.0 10/16/2017
> RIP: 0010:io_serial_in+0x14/0x20
> RSP: 0000:ffffbc9640017720 EFLAGS: 00000006
> PKRU: 55555554
> Call Trace:
>  <NMI>
>  ? nmi_cpu_backtrace+0x57/0xb0
>  ? nmi_cpu_backtrace_handler+0xd/0x20
>  ? nmi_handle+0x62/0x130
>  ? default_do_nmi+0x49/0x100
>  ? exc_nmi+0x152/0x170
>  ? end_repeat_nmi+0x16/0x67
>  ? mem16_serial_in+0x10/0x20
>  ? io_serial_in+0x14/0x20
>  ? io_serial_in+0x14/0x20
>  ? io_serial_in+0x14/0x20
>  </NMI>
>  serial8250_console_write+0x8e/0x310
>  ? record_print_text+0xbf/0x150
>  console_unlock+0x485/0x4c0
>  vprintk_emit+0xe4/0x240
>  printk+0x52/0x72
>  ? pci_hp_add+0x18d/0x300
>  acpiphp_register_hotplug_slot+0xe4/0x100
>  acpiphp_add_context+0x3b5/0x460
>  acpi_ns_walk_namespace+0x10c/0x220
>  ? acpiphp_put_context.part.13+0x30/0x30
>  ? acpiphp_put_context.part.13+0x30/0x30
>  acpi_walk_namespace+0xd4/0xf0
>  ? kmem_cache_alloc_trace+0x3be/0x400
>  acpiphp_enumerate_slots+0x175/0x260
>  acpi_pci_add_bus+0x50/0xe0
>  pci_register_host_bridge+0x233/0x4d0
>  ? complete_all+0x2a/0x40
>  pci_create_root_bus+0x87/0xc0
>  acpi_pci_root_create+0x128/0x2a0
>  pci_acpi_scan_root+0x14e/0x1b0
>  acpi_pci_root_add+0x203/0x580
>  ? acpi_evaluate_integer+0x52/0x90
>  ? rdinit_setup+0x2f/0x2f
>  acpi_bus_attach+0x148/0x1d0
>  acpi_bus_attach+0x84/0x1d0
>  acpi_bus_attach+0x84/0x1d0
>  ? acpi_sleep_proc_init+0x24/0x24
>  ? acpi_sleep_proc_init+0x24/0x24
>  acpi_bus_scan+0x43/0x90
>  acpi_scan_init+0xff/0x247
>  ? acpi_sleep_proc_init+0x24/0x24
>  acpi_init+0x2e9/0x34d
>  do_one_initcall+0x44/0x1e0
>  kernel_init_freeable+0x229/0x286
>  ? rest_init+0xc0/0xc0
>  kernel_init+0xa/0x120
>  ret_from_fork+0x22/0x30
>
> Thanks
> Rishabh
CCing stable kernel list.
