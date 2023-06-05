Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4762E722700
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 15:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbjFENK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 09:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233916AbjFENKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 09:10:43 -0400
Received: from er-systems.de (er-systems.de [IPv6:2a01:4f8:261:3c41::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679C9E6B
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 06:10:31 -0700 (PDT)
Received: from localhost.localdomain (localhost [127.0.0.1])
        by er-systems.de (Postfix) with ESMTP id 398EEECDAD2;
        Mon,  5 Jun 2023 15:10:25 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Received: from localhost (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by er-systems.de (Postfix) with ESMTPS id 179FDECDAC4;
        Mon,  5 Jun 2023 15:10:25 +0200 (CEST)
Date:   Mon, 5 Jun 2023 15:10:24 +0200 (CEST)
From:   Thomas Voegtle <tv@lio96.de>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
cc:     linux-kernel@vger.kernel.org, Hyunwoo Kim <imv4bel@gmail.com>
Subject: Re: Sometimes DVB broken with commit 6769a0b7ee0c3b
In-Reply-To: <20230605111715.4c0ba2ed@sal.lan>
Message-ID: <2ca39b5c-bb19-fb6b-3c79-8ec3cb345ff5@lio96.de>
References: <da5382ad-09d6-20ac-0d53-611594b30861@lio96.de> <20230605111715.4c0ba2ed@sal.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Virus-Status: No
X-Virus-Checker-Version: clamassassin 1.2.4 with clamdscan / ClamAV 0.103.8/26929/Mon Jun  5 09:34:01 2023
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Jun 2023, Mauro Carvalho Chehab wrote:

> Em Tue, 30 May 2023 13:12:57 +0200 (CEST)
> Thomas Voegtle <tv@lio96.de> escreveu:
>
>> Hello,
>>
>>
>> I have the problem that sometimes my DVB card does not initialize
>> properly booting Linux 6.4-rc4.
>> This is not always, maybe in 3 out of 4 attempts.
>> When this happens somehow you don't see anything special in dmesg, but the
>> card just doesn't work.
>
> Can you paste the full dmesg?

Sorry for the sloppy bug report, I could have sent that right away.
See below.

>
>>
>> Reverting this helps:
>> commit 6769a0b7ee0c3b31e1b22c3fadff2bfb642de23f
>> Author: Hyunwoo Kim <imv4bel@gmail.com>
>> Date:   Thu Nov 17 04:59:22 2022 +0000
>>
>>      media: dvb-core: Fix use-after-free on race condition at dvb_frontend
>
> What do you mean by helps? Does it fix it every time, or it just
> reduces the number of init problems?

Reverting fixes it for me. So every boot ist ok.



[    0.000000] microcode: updated early: 0x9 -> 0x28, date = 2019-11-12
[    0.000000] Linux version 6.4.0-rc5-i5 (thomas@maggie) (gcc (SUSE Linux) 7.5.0, GNU ld (GNU Binutils; SUSE Linux Enterprise 15) 2.39.0.20220810-150100.7.40) #249 SMP PREEMPT_DYNAMIC Mon Jun  5 00:00:20 CEST 2023
[    0.000000] Command line: BOOT_IMAGE=/boot/selfkernel-test root=/dev/sda3 resume=/dev/sda1 console=ttyS0,115200N8 panic=30 no_console_suspend
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
[    0.000000] signal: max sigframe size: 1360
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009d7ff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009d800-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000bc186fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bc187000-0x00000000bc18dfff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000bc18e000-0x00000000bc8e1fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bc8e2000-0x00000000bcb1efff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000bcb1f000-0x00000000cc5a1fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000cc5a2000-0x00000000cc629fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000cc62a000-0x00000000cc66cfff] usable
[    0.000000] BIOS-e820: [mem 0x00000000cc66d000-0x00000000cc713fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000cc714000-0x00000000ccffefff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ccfff000-0x00000000ccffffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000cf800000-0x00000000df9fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed03fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000031f5fffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.7 present.
[    0.000000] DMI: To Be Filled By O.E.M. To Be Filled By O.E.M./H81 Pro BTC R2.0, BIOS P1.20 07/22/2014
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 3199.065 MHz processor
[    0.000433] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000435] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000442] last_pfn = 0x31f600 max_arch_pfn = 0x400000000
[    0.000446] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT 
[    0.000628] e820: update [mem 0xcf800000-0xffffffff] usable ==> reserved
[    0.000631] last_pfn = 0xcd000 max_arch_pfn = 0x400000000
[    0.000642] Using GB pages for direct mapping
[    0.001172] ACPI: Early table checksum verification disabled
[    0.001174] ACPI: RSDP 0x00000000000F0490 000024 (v02 ALASKA)
[    0.001177] ACPI: XSDT 0x00000000CC6F1078 000074 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.001182] ACPI: FACP 0x00000000CC6FB5B8 00010C (v05 ALASKA A M I    01072009 AMI  00010013)
[    0.001186] ACPI: DSDT 0x00000000CC6F1188 00A430 (v02 ALASKA A M I    00000120 INTL 20091112)
[    0.001188] ACPI: FACS 0x00000000CC712080 000040
[    0.001190] ACPI: APIC 0x00000000CC6FB6C8 000072 (v03 ALASKA A M I    01072009 AMI  00010013)
[    0.001192] ACPI: FPDT 0x00000000CC6FB740 000044 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.001194] ACPI: SSDT 0x00000000CC6FB788 000539 (v01 PmRef  Cpu0Ist  00003000 INTL 20051117)
[    0.001197] ACPI: SSDT 0x00000000CC6FBCC8 000AD8 (v01 PmRef  CpuPm    00003000 INTL 20051117)
[    0.001199] ACPI: MCFG 0x00000000CC6FC7A0 00003C (v01 ALASKA A M I    01072009 MSFT 00000097)
[    0.001201] ACPI: HPET 0x00000000CC6FC7E0 000038 (v01 ALASKA A M I    01072009 AMI. 00000005)
[    0.001203] ACPI: SSDT 0x00000000CC6FC818 00036D (v01 SataRe SataTabl 00001000 INTL 20091112)
[    0.001205] ACPI: SSDT 0x00000000CC6FCB88 003493 (v01 SaSsdt SaSsdt   00003000 INTL 20091112)
[    0.001208] ACPI: AAFT 0x00000000CC700020 0002BB (v01 ALASKA OEMAAFT  01072009 MSFT 00000097)
[    0.001209] ACPI: Reserving FACP table memory at [mem 0xcc6fb5b8-0xcc6fb6c3]
[    0.001211] ACPI: Reserving DSDT table memory at [mem 0xcc6f1188-0xcc6fb5b7]
[    0.001211] ACPI: Reserving FACS table memory at [mem 0xcc712080-0xcc7120bf]
[    0.001212] ACPI: Reserving APIC table memory at [mem 0xcc6fb6c8-0xcc6fb739]
[    0.001213] ACPI: Reserving FPDT table memory at [mem 0xcc6fb740-0xcc6fb783]
[    0.001213] ACPI: Reserving SSDT table memory at [mem 0xcc6fb788-0xcc6fbcc0]
[    0.001214] ACPI: Reserving SSDT table memory at [mem 0xcc6fbcc8-0xcc6fc79f]
[    0.001214] ACPI: Reserving MCFG table memory at [mem 0xcc6fc7a0-0xcc6fc7db]
[    0.001215] ACPI: Reserving HPET table memory at [mem 0xcc6fc7e0-0xcc6fc817]
[    0.001216] ACPI: Reserving SSDT table memory at [mem 0xcc6fc818-0xcc6fcb84]
[    0.001216] ACPI: Reserving SSDT table memory at [mem 0xcc6fcb88-0xcc70001a]
[    0.001217] ACPI: Reserving AAFT table memory at [mem 0xcc700020-0xcc7002da]
[    0.001236] Zone ranges:
[    0.001237]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.001238]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.001239]   Normal   [mem 0x0000000100000000-0x000000031f5fffff]
[    0.001240] Movable zone start for each node
[    0.001241] Early memory node ranges
[    0.001241]   node   0: [mem 0x0000000000001000-0x000000000009cfff]
[    0.001242]   node   0: [mem 0x0000000000100000-0x00000000bc186fff]
[    0.001243]   node   0: [mem 0x00000000bc18e000-0x00000000bc8e1fff]
[    0.001244]   node   0: [mem 0x00000000bcb1f000-0x00000000cc5a1fff]
[    0.001245]   node   0: [mem 0x00000000cc62a000-0x00000000cc66cfff]
[    0.001245]   node   0: [mem 0x00000000ccfff000-0x00000000ccffffff]
[    0.001246]   node   0: [mem 0x0000000100000000-0x000000031f5fffff]
[    0.001247] Initmem setup node 0 [mem 0x0000000000001000-0x000000031f5fffff]
[    0.001251] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.001271] On node 0, zone DMA: 99 pages in unavailable ranges
[    0.006516] On node 0, zone DMA32: 7 pages in unavailable ranges
[    0.006975] On node 0, zone DMA32: 573 pages in unavailable ranges
[    0.006978] On node 0, zone DMA32: 136 pages in unavailable ranges
[    0.007000] On node 0, zone DMA32: 2450 pages in unavailable ranges
[    0.022748] On node 0, zone Normal: 12288 pages in unavailable ranges
[    0.022772] On node 0, zone Normal: 2560 pages in unavailable ranges
[    0.022785] Reserving Intel graphics memory at [mem 0xcfa00000-0xdf9fffff]
[    0.022859] ACPI: PM-Timer IO Port: 0x1808
[    0.022864] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[    0.022873] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
[    0.022876] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.022877] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.022880] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.022881] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    0.022884] TSC deadline timer available
[    0.022885] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
[    0.022897] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.022898] PM: hibernation: Registered nosave memory: [mem 0x0009d000-0x0009dfff]
[    0.022899] PM: hibernation: Registered nosave memory: [mem 0x0009e000-0x0009ffff]
[    0.022900] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000dffff]
[    0.022900] PM: hibernation: Registered nosave memory: [mem 0x000e0000-0x000fffff]
[    0.022901] PM: hibernation: Registered nosave memory: [mem 0xbc187000-0xbc18dfff]
[    0.022903] PM: hibernation: Registered nosave memory: [mem 0xbc8e2000-0xbcb1efff]
[    0.022904] PM: hibernation: Registered nosave memory: [mem 0xcc5a2000-0xcc629fff]
[    0.022905] PM: hibernation: Registered nosave memory: [mem 0xcc66d000-0xcc713fff]
[    0.022905] PM: hibernation: Registered nosave memory: [mem 0xcc714000-0xccffefff]
[    0.022906] PM: hibernation: Registered nosave memory: [mem 0xcd000000-0xcf7fffff]
[    0.022907] PM: hibernation: Registered nosave memory: [mem 0xcf800000-0xdf9fffff]
[    0.022908] PM: hibernation: Registered nosave memory: [mem 0xdfa00000-0xf7ffffff]
[    0.022908] PM: hibernation: Registered nosave memory: [mem 0xf8000000-0xfbffffff]
[    0.022909] PM: hibernation: Registered nosave memory: [mem 0xfc000000-0xfebfffff]
[    0.022909] PM: hibernation: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
[    0.022910] PM: hibernation: Registered nosave memory: [mem 0xfec01000-0xfecfffff]
[    0.022910] PM: hibernation: Registered nosave memory: [mem 0xfed00000-0xfed03fff]
[    0.022911] PM: hibernation: Registered nosave memory: [mem 0xfed04000-0xfed1bfff]
[    0.022911] PM: hibernation: Registered nosave memory: [mem 0xfed1c000-0xfed1ffff]
[    0.022912] PM: hibernation: Registered nosave memory: [mem 0xfed20000-0xfedfffff]
[    0.022912] PM: hibernation: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
[    0.022913] PM: hibernation: Registered nosave memory: [mem 0xfee01000-0xfeffffff]
[    0.022913] PM: hibernation: Registered nosave memory: [mem 0xff000000-0xffffffff]
[    0.022915] [mem 0xdfa00000-0xf7ffffff] available for PCI devices
[    0.022917] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.026905] setup_percpu: NR_CPUS:4 nr_cpumask_bits:4 nr_cpu_ids:4 nr_node_ids:1
[    0.027198] percpu: Embedded 44 pages/cpu s150952 r0 d29272 u524288
[    0.027203] pcpu-alloc: s150952 r0 d29272 u524288 alloc=1*2097152
[    0.027205] pcpu-alloc: [0] 0 1 2 3 
[    0.027214] Kernel command line: BOOT_IMAGE=/boot/selfkernel-test root=/dev/sda3 resume=/dev/sda1 console=ttyS0,115200N8 panic=30 no_console_suspend
[    0.027263] Unknown kernel command line parameters "BOOT_IMAGE=/boot/selfkernel-test", will be passed to user space.
[    0.027287] random: crng init done
[    0.027288] printk: log_buf_len individual max cpu contribution: 131072 bytes
[    0.027288] printk: log_buf_len total cpu_extra contributions: 393216 bytes
[    0.027289] printk: log_buf_len min size: 262144 bytes
[    0.027988] printk: log_buf_len: 1048576 bytes
[    0.027989] printk: early log buf free: 252104(96%)
[    0.029834] Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
[    0.030769] Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
[    0.030811] Built 1 zonelists, mobility grouping on.  Total pages: 3014075
[    0.030814] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.030815] software IO TLB: area num 4.
[    0.072795] Memory: 11931968K/12248312K available (14336K kernel code, 1662K rwdata, 3784K rodata, 1296K init, 1304K bss, 316084K reserved, 0K cma-reserved)
[    0.072872] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.072879] Kernel/User page tables isolation: enabled
[    0.072907] Dynamic Preempt: full
[    0.072927] rcu: Preemptible hierarchical RCU implementation.
[    0.072929] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
[    0.072936] NR_IRQS: 4352, nr_irqs: 456, preallocated irqs: 16
[    0.073088] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.074518] Console: colour VGA+ 80x25
[    0.074537] printk: console [ttyS0] enabled
[    1.101201] ACPI: Core revision 20230331
[    1.105197] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484882848 ns
[    1.114329] APIC: Switch to symmetric I/O mode setup
[    1.119655] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    1.142329] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x2e1cd6e91ff, max_idle_ns: 440795256577 ns
[    1.152838] Calibrating delay loop (skipped), value calculated using timer frequency.. 6398.13 BogoMIPS (lpj=12796260)
[    1.156835] pid_max: default: 32768 minimum: 301
[    1.160888] Mount-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    1.164864] Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    1.168942] CPU0: Thermal monitoring enabled (TM1)
[    1.172860] process: using mwait in idle threads
[    1.176837] Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 1024
[    1.180835] Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 1024, 1GB 4
[    1.184837] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    1.188836] Spectre V2 : Mitigation: Retpolines
[    1.192835] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    1.196835] Spectre V2 : Spectre v2 / SpectreRSB : Filling RSB on VMEXIT
[    1.200835] Spectre V2 : Enabling Restricted Speculation for firmware calls
[    1.204836] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    1.208835] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
[    1.212836] MDS: Mitigation: Clear CPU buffers
[    1.216835] MMIO Stale Data: Unknown: No mitigations
[    1.220835] SRBDS: Mitigation: Microcode
[    1.234922] Freeing SMP alternatives memory: 40K
[    1.237072] smpboot: CPU0: Intel(R) Core(TM) i5-4570 CPU @ 3.20GHz (family: 0x6, model: 0x3c, stepping: 0x3)
[    1.240911] Performance Events: PEBS fmt2+, Haswell events, 16-deep LBR, full-width counters, Intel PMU driver.
[    1.244837] ... version:                3
[    1.248835] ... bit width:              48
[    1.252835] ... generic registers:      8
[    1.256835] ... value mask:             0000ffffffffffff
[    1.260835] ... max period:             00007fffffffffff
[    1.264835] ... fixed-purpose events:   3
[    1.268835] ... event mask:             00000007000000ff
[    1.272936] Estimated ratio of average max frequency by base frequency (times 1024): 1088
[    1.276848] rcu: Hierarchical SRCU implementation.
[    1.280836] rcu: 	Max phase no-delay instances is 1000.
[    1.285105] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    1.288879] smp: Bringing up secondary CPUs ...
[    1.292898] x86: Booting SMP configuration:
[    1.296837] .... node  #0, CPUs:      #1 #2 #3
[    1.302444] smp: Brought up 1 node, 4 CPUs
[    1.308840] smpboot: Max logical packages: 1
[    1.312836] smpboot: Total of 4 processors activated (25592.52 BogoMIPS)
[    1.317741] devtmpfs: initialized
[    1.320949] ACPI: PM: Registering ACPI NVS region [mem 0xbc187000-0xbc18dfff] (28672 bytes)
[    1.324837] ACPI: PM: Registering ACPI NVS region [mem 0xcc66d000-0xcc713fff] (684032 bytes)
[    1.328877] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    1.332836] futex hash table entries: 1024 (order: 4, 65536 bytes, linear)
[    1.336886] PM: RTC time: 12:45:27, date: 2023-06-05
[    1.340861] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    1.344955] thermal_sys: Registered thermal governor 'fair_share'
[    1.344956] thermal_sys: Registered thermal governor 'bang_bang'
[    1.348835] thermal_sys: Registered thermal governor 'step_wise'
[    1.352835] thermal_sys: Registered thermal governor 'user_space'
[    1.356844] cpuidle: using governor ladder
[    1.364837] cpuidle: using governor menu
[    1.368866] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    1.372842] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000-0xfbffffff] (base 0xf8000000)
[    1.376837] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved as E820 entry
[    1.380839] pmd_set_huge: Cannot satisfy [mem 0xf8000000-0xf8200000] with a huge-page mapping due to MTRR override.
[    1.384865] PCI: Using configuration type 1 for base access
[    1.388883] core: PMU erratum BJ122, BV98, HSD29 workaround disabled, HT off
[    1.392939] cryptd: max_cpu_qlen set to 1000
[    1.396863] ACPI: Added _OSI(Module Device)
[    1.400836] ACPI: Added _OSI(Processor Device)
[    1.404835] ACPI: Added _OSI(3.0 _SCP Extensions)
[    1.408835] ACPI: Added _OSI(Processor Aggregator Device)
[    1.422077] ACPI: 5 ACPI AML tables successfully acquired and loaded
[    1.425527] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    1.429107] ACPI: Dynamic OEM Table Load:
[    1.432838] ACPI: SSDT 0xFFFF9097801A0000 0003D3 (v01 PmRef  Cpu0Cst  00003001 INTL 20051117)
[    1.437413] ACPI: Dynamic OEM Table Load:
[    1.440838] ACPI: SSDT 0xFFFF9097809E9800 0005AA (v01 PmRef  ApIst    00003000 INTL 20051117)
[    1.445453] ACPI: Dynamic OEM Table Load:
[    1.448837] ACPI: SSDT 0xFFFF909780915200 000119 (v01 PmRef  ApCst    00003000 INTL 20051117)
[    1.454017] ACPI: Interpreter enabled
[    1.456857] ACPI: PM: (supports S0 S3 S4 S5)
[    1.460835] ACPI: Using IOAPIC for interrupt routing
[    1.464887] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    1.468835] PCI: Using E820 reservations for host bridge windows
[    1.473112] ACPI: Enabled 9 GPEs in block 00 to 3F
[    1.486842] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3e])
[    1.488846] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    1.492954] acpi PNP0A08:00: _OSC: platform does not support [PME LTR]
[    1.496964] acpi PNP0A08:00: _OSC: OS now controls [AER PCIeCapability]
[    1.500837] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
[    1.505192] PCI host bridge to bus 0000:00
[    1.508836] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    1.512835] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    1.516835] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    1.520835] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000e7fff window]
[    1.524835] pci_bus 0000:00: root bus resource [mem 0xdfa00000-0xfeafffff window]
[    1.528835] pci_bus 0000:00: root bus resource [bus 00-3e]
[    1.532847] pci 0000:00:00.0: [8086:0c00] type 00 class 0x060000
[    1.536886] pci 0000:00:01.0: [8086:0c01] type 01 class 0x060400
[    1.540864] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    1.544888] pci 0000:00:02.0: [8086:0412] type 00 class 0x030000
[    1.548840] pci 0000:00:02.0: reg 0x10: [mem 0xf0000000-0xf03fffff 64bit]
[    1.552838] pci 0000:00:02.0: reg 0x18: [mem 0xe0000000-0xefffffff 64bit pref]
[    1.556837] pci 0000:00:02.0: reg 0x20: [io  0xf000-0xf03f]
[    1.560844] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    1.564897] pci 0000:00:03.0: [8086:0c0c] type 00 class 0x040300
[    1.568840] pci 0000:00:03.0: reg 0x10: [mem 0xf0814000-0xf0817fff 64bit]
[    1.572913] pci 0000:00:14.0: [8086:8c31] type 00 class 0x0c0330
[    1.576848] pci 0000:00:14.0: reg 0x10: [mem 0xf0800000-0xf080ffff 64bit]
[    1.580884] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    1.584909] pci 0000:00:16.0: [8086:8c3a] type 00 class 0x078000
[    1.588849] pci 0000:00:16.0: reg 0x10: [mem 0xf081e000-0xf081e00f 64bit]
[    1.592887] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    1.596882] pci 0000:00:1a.0: [8086:8c2d] type 00 class 0x0c0320
[    1.600848] pci 0000:00:1a.0: reg 0x10: [mem 0xf081c000-0xf081c3ff]
[    1.604907] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
[    1.608895] pci 0000:00:1b.0: [8086:8c20] type 00 class 0x040300
[    1.612848] pci 0000:00:1b.0: reg 0x10: [mem 0xf0810000-0xf0813fff 64bit]
[    1.616895] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    1.620891] pci 0000:00:1c.0: [8086:8c10] type 01 class 0x060400
[    1.624900] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    1.629041] pci 0000:00:1c.3: [8086:8c16] type 01 class 0x060400
[    1.632900] pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
[    1.637031] pci 0000:00:1c.5: [8086:8c1a] type 01 class 0x060400
[    1.640900] pci 0000:00:1c.5: PME# supported from D0 D3hot D3cold
[    1.645034] pci 0000:00:1d.0: [8086:8c26] type 00 class 0x0c0320
[    1.648848] pci 0000:00:1d.0: reg 0x10: [mem 0xf081b000-0xf081b3ff]
[    1.652908] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    1.656903] pci 0000:00:1f.0: [8086:8c5c] type 00 class 0x060100
[    1.660987] pci 0000:00:1f.2: [8086:8c02] type 00 class 0x010601
[    1.664844] pci 0000:00:1f.2: reg 0x10: [io  0xf0b0-0xf0b7]
[    1.668840] pci 0000:00:1f.2: reg 0x14: [io  0xf0a0-0xf0a3]
[    1.672840] pci 0000:00:1f.2: reg 0x18: [io  0xf090-0xf097]
[    1.676840] pci 0000:00:1f.2: reg 0x1c: [io  0xf080-0xf083]
[    1.680840] pci 0000:00:1f.2: reg 0x20: [io  0xf060-0xf07f]
[    1.684840] pci 0000:00:1f.2: reg 0x24: [mem 0xf081a000-0xf081a7ff]
[    1.688863] pci 0000:00:1f.2: PME# supported from D3hot
[    1.692887] pci 0000:00:1f.3: [8086:8c22] type 00 class 0x0c0500
[    1.696848] pci 0000:00:1f.3: reg 0x10: [mem 0xf0819000-0xf08190ff 64bit]
[    1.700851] pci 0000:00:1f.3: reg 0x20: [io  0xf040-0xf05f]
[    1.704903] pci 0000:00:01.0: PCI bridge to [bus 01]
[    1.708880] pci 0000:02:00.0: [144d:a808] type 00 class 0x010802
[    1.712857] pci 0000:02:00.0: reg 0x10: [mem 0xf0700000-0xf0703fff 64bit]
[    1.716995] pci 0000:02:00.0: 4.000 Gb/s available PCIe bandwidth, limited by 5.0 GT/s PCIe x1 link at 0000:00:1c.0 (capable of 31.504 Gb/s with 8.0 GT/s PCIe x4 link)
[    1.720914] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    1.724838] pci 0000:00:1c.0:   bridge window [mem 0xf0700000-0xf07fffff]
[    1.728900] pci 0000:03:00.0: [14f1:8880] type 00 class 0x040000
[    1.732890] pci 0000:03:00.0: reg 0x10: [mem 0xf0400000-0xf05fffff 64bit]
[    1.737119] pci 0000:03:00.0: supports D1 D2
[    1.740835] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    1.756874] pci 0000:00:1c.3: PCI bridge to [bus 03]
[    1.760838] pci 0000:00:1c.3:   bridge window [mem 0xf0400000-0xf05fffff]
[    1.764940] pci 0000:04:00.0: [10ec:8168] type 00 class 0x020000
[    1.768877] pci 0000:04:00.0: reg 0x10: [io  0xe000-0xe0ff]
[    1.772864] pci 0000:04:00.0: reg 0x18: [mem 0xf0604000-0xf0604fff 64bit]
[    1.776887] pci 0000:04:00.0: reg 0x20: [mem 0xf0600000-0xf0603fff 64bit pref]
[    1.781055] pci 0000:04:00.0: supports D1 D2
[    1.784835] pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    1.789007] pci 0000:00:1c.5: PCI bridge to [bus 04]
[    1.792837] pci 0000:00:1c.5:   bridge window [io  0xe000-0xefff]
[    1.796837] pci 0000:00:1c.5:   bridge window [mem 0xf0600000-0xf06fffff]
[    1.800852] pci_bus 0000:00: on NUMA node 0
[    1.801512] ACPI: PCI: Interrupt link LNKA configured for IRQ 11
[    1.804875] ACPI: PCI: Interrupt link LNKB configured for IRQ 11
[    1.808872] ACPI: PCI: Interrupt link LNKC configured for IRQ 5
[    1.812872] ACPI: PCI: Interrupt link LNKD configured for IRQ 10
[    1.816872] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
[    1.820835] ACPI: PCI: Interrupt link LNKE disabled
[    1.824872] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[    1.828835] ACPI: PCI: Interrupt link LNKF disabled
[    1.832872] ACPI: PCI: Interrupt link LNKG configured for IRQ 5
[    1.836872] ACPI: PCI: Interrupt link LNKH configured for IRQ 10
[    1.841056] SCSI subsystem initialized
[    1.844840] libata version 3.00 loaded.
[    1.844852] ACPI: bus type USB registered
[    1.848841] usbcore: registered new interface driver usbfs
[    1.852838] usbcore: registered new interface driver hub
[    1.856838] usbcore: registered new device driver usb
[    1.860842] mc: Linux media interface: v0.10
[    1.864838] videodev: Linux video capture interface: v2.00
[    1.868851] Advanced Linux Sound Architecture Driver Initialized.
[    1.872892] PCI: Using ACPI for IRQ routing
[    1.878048] PCI: pci_cache_line_size set to 64 bytes
[    1.878084] e820: reserve RAM buffer [mem 0x0009d800-0x0009ffff]
[    1.878085] e820: reserve RAM buffer [mem 0xbc187000-0xbfffffff]
[    1.878086] e820: reserve RAM buffer [mem 0xbc8e2000-0xbfffffff]
[    1.878087] e820: reserve RAM buffer [mem 0xcc5a2000-0xcfffffff]
[    1.878088] e820: reserve RAM buffer [mem 0xcc66d000-0xcfffffff]
[    1.878089] e820: reserve RAM buffer [mem 0xcd000000-0xcfffffff]
[    1.878090] e820: reserve RAM buffer [mem 0x31f600000-0x31fffffff]
[    1.878101] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    1.880834] pci 0000:00:02.0: vgaarb: bridge control possible
[    1.880834] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    1.880838] vgaarb: loaded
[    1.883591] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    1.884835] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    1.890854] clocksource: Switched to clocksource tsc-early
[    1.894378] pnp: PnP ACPI init
[    1.897484] system 00:00: [mem 0xfed40000-0xfed44fff] has been reserved
[    1.904214] system 00:01: [io  0x0680-0x069f] has been reserved
[    1.910132] system 00:01: [io  0xffff] has been reserved
[    1.915442] system 00:01: [io  0xffff] has been reserved
[    1.920747] system 00:01: [io  0xffff] has been reserved
[    1.926050] system 00:01: [io  0x1c00-0x1cfe] has been reserved
[    1.931961] system 00:01: [io  0x1d00-0x1dfe] has been reserved
[    1.937873] system 00:01: [io  0x1e00-0x1efe] has been reserved
[    1.943792] system 00:01: [io  0x1f00-0x1ffe] has been reserved
[    1.949712] system 00:01: [io  0x1800-0x18fe] has been reserved
[    1.955622] system 00:01: [io  0x164e-0x164f] has been reserved
[    1.961586] system 00:03: [io  0x1854-0x1857] has been reserved
[    1.967565] system 00:04: [io  0x0290-0x029f] has been reserved
[    1.973598] system 00:05: [io  0x04d0-0x04d1] has been reserved
[    1.979641] pnp 00:06: [dma 0 disabled]
[    1.979827] pnp 00:07: [dma 0 disabled]
[    1.980160] system 00:08: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    1.986772] system 00:08: [mem 0xfed10000-0xfed17fff] has been reserved
[    1.993382] system 00:08: [mem 0xfed18000-0xfed18fff] has been reserved
[    1.999985] system 00:08: [mem 0xfed19000-0xfed19fff] has been reserved
[    2.006590] system 00:08: [mem 0xf8000000-0xfbffffff] has been reserved
[    2.013195] system 00:08: [mem 0xfed20000-0xfed3ffff] has been reserved
[    2.019797] system 00:08: [mem 0xfed90000-0xfed93fff] has been reserved
[    2.026403] system 00:08: [mem 0xfed45000-0xfed8ffff] has been reserved
[    2.033007] system 00:08: [mem 0xff000000-0xffffffff] has been reserved
[    2.039609] system 00:08: [mem 0xfee00000-0xfeefffff] could not be reserved
[    2.046561] system 00:08: [mem 0xf7fef000-0xf7feffff] has been reserved
[    2.053167] system 00:08: [mem 0xf7ff0000-0xf7ff0fff] has been reserved
[    2.059985] pnp: PnP ACPI: found 9 devices
[    2.069366] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    2.078273] NET: Registered PF_INET protocol family
[    2.083260] IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    2.093164] tcp_listen_portaddr_hash hash table entries: 8192 (order: 5, 131072 bytes, linear)
[    2.101789] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    2.109528] TCP established hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[    2.117713] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes, linear)
[    2.125373] TCP: Hash tables configured (established 131072 bind 65536)
[    2.131996] UDP hash table entries: 8192 (order: 6, 262144 bytes, linear)
[    2.138802] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes, linear)
[    2.146063] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    2.151728] pci 0000:00:01.0: PCI bridge to [bus 01]
[    2.156694] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    2.161656] pci 0000:00:1c.0:   bridge window [mem 0xf0700000-0xf07fffff]
[    2.168445] pci 0000:00:1c.3: PCI bridge to [bus 03]
[    2.173409] pci 0000:00:1c.3:   bridge window [mem 0xf0400000-0xf05fffff]
[    2.180198] pci 0000:00:1c.5: PCI bridge to [bus 04]
[    2.185160] pci 0000:00:1c.5:   bridge window [io  0xe000-0xefff]
[    2.191253] pci 0000:00:1c.5:   bridge window [mem 0xf0600000-0xf06fffff]
[    2.198043] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    2.204216] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    2.210387] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    2.217252] pci_bus 0000:00: resource 7 [mem 0x000d0000-0x000e7fff window]
[    2.224115] pci_bus 0000:00: resource 8 [mem 0xdfa00000-0xfeafffff window]
[    2.230980] pci_bus 0000:02: resource 1 [mem 0xf0700000-0xf07fffff]
[    2.237236] pci_bus 0000:03: resource 1 [mem 0xf0400000-0xf05fffff]
[    2.243494] pci_bus 0000:04: resource 0 [io  0xe000-0xefff]
[    2.249058] pci_bus 0000:04: resource 1 [mem 0xf0600000-0xf06fffff]
[    2.279784] pci 0000:00:1a.0: quirk_usb_early_handoff+0x0/0x690 took 23671 usecs
[    2.311782] pci 0000:00:1d.0: quirk_usb_early_handoff+0x0/0x690 took 24018 usecs
[    2.319189] PCI: CLS 64 bytes, default 64
[    2.323211] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    2.329640] software IO TLB: mapped [mem 0x00000000c85a2000-0x00000000cc5a2000] (64MB)
[    2.337598] RAPL PMU: API unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
[    2.345510] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[    2.351247] RAPL PMU: hw unit of domain package 2^-14 Joules
[    2.356897] RAPL PMU: hw unit of domain dram 2^-14 Joules
[    2.362288] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
[    2.368466] workingset: timestamp_bits=62 max_order=22 bucket_order=0
[    2.375026] ntfs: driver 2.1.32 [Flags: R/O].
[    2.379384] ntfs3: Max link count 4000
[    2.383131] ntfs3: Read-only LZX/Xpress compression included
[    2.388785] fuse: init (API version 7.38)
[    2.402034] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
[    2.409419] io scheduler mq-deadline registered
[    2.414547] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    2.422905] ACPI: button: Power Button [PWRB]
[    2.427282] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    2.435751] ACPI: button: Power Button [PWRF]
[    2.440475] Serial: 8250/16550 driver, 32 ports, IRQ sharing disabled
[    2.446972] 00:06: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    2.454420] 00:07: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
[    2.462419] Non-volatile memory driver v1.3
[    2.466657] ACPI: bus type drm_connector registered
[    2.471635] stackdepot: allocating hash table of 1048576 entries via kvcalloc
[    2.479296] i915 0000:00:02.0: [drm] PipeC fused off
[    2.484367] i915 0000:00:02.0: vgaarb: deactivate vga console
[    2.490465] Console: switching to colour dummy device 80x25
[    2.496758] i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=io+mem:owns=io+mem
[    2.513919] [drm] Initialized i915 1.6.0 20201103 for 0000:00:02.0 on minor 0
[    2.522036] ACPI: video: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[    2.529690] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input2
[    2.538852] i915 0000:00:02.0: [drm] DRM_I915_DEBUG_RUNTIME_PM enabled
[    2.545591] ACPI Warning: SystemIO range 0x0000000000001828-0x000000000000182F conflicts with OpRegion 0x0000000000001800-0x000000000000187F (\PMIO) (20230331/utaddress-213)
[    2.550069] i915 0000:00:02.0: [drm] Cannot find any crtc or sizes
[    2.561045] ACPI: OSL: Resource conflict; ACPI support missing from driver?
[    2.574175] ACPI Warning: SystemIO range 0x0000000000001C40-0x0000000000001C4F conflicts with OpRegion 0x0000000000001C00-0x0000000000001FFF (\GPR2) (20230331/utaddress-213)
[    2.589056] i915 0000:00:02.0: [drm] Cannot find any crtc or sizes
[    2.589625] ACPI Warning: SystemIO range 0x0000000000001C40-0x0000000000001C4F conflicts with OpRegion 0x0000000000001C00-0x0000000000001FFF (\GPR) (20230331/utaddress-213)
[    2.598120] i915 0000:00:02.0: [drm] Cannot find any crtc or sizes
[    2.611153] ACPI: OSL: Resource conflict; ACPI support missing from driver?
[    2.624273] ACPI Warning: SystemIO range 0x0000000000001C30-0x0000000000001C3F conflicts with OpRegion 0x0000000000001C00-0x0000000000001FFF (\GPR2) (20230331/utaddress-213)
[    2.639719] ACPI Warning: SystemIO range 0x0000000000001C30-0x0000000000001C3F conflicts with OpRegion 0x0000000000001C00-0x0000000000001C3F (\GPRL) (20230331/utaddress-213)
[    2.655170] ACPI Warning: SystemIO range 0x0000000000001C30-0x0000000000001C3F conflicts with OpRegion 0x0000000000001C00-0x0000000000001FFF (\GPR) (20230331/utaddress-213)
[    2.670528] ACPI: OSL: Resource conflict; ACPI support missing from driver?
[    2.677478] ACPI Warning: SystemIO range 0x0000000000001C00-0x0000000000001C2F conflicts with OpRegion 0x0000000000001C00-0x0000000000001FFF (\GPR2) (20230331/utaddress-213)
[    2.692922] ACPI Warning: SystemIO range 0x0000000000001C00-0x0000000000001C2F conflicts with OpRegion 0x0000000000001C00-0x0000000000001C3F (\GPRL) (20230331/utaddress-213)
[    2.708367] ACPI Warning: SystemIO range 0x0000000000001C00-0x0000000000001C2F conflicts with OpRegion 0x0000000000001C00-0x0000000000001FFF (\GPR) (20230331/utaddress-213)
[    2.723733] ACPI: OSL: Resource conflict; ACPI support missing from driver?
[    2.730683] lpc_ich: Resource conflict(s) found affecting gpio_ich
[    2.736884] rdac: device handler registered
[    2.741118] hp_sw: device handler registered
[    2.745384] emc: device handler registered
[    2.749533] alua: device handler registered
[    2.753904] ahci 0000:00:1f.2: version 3.0
[    2.753985] nvme nvme0: pci function 0000:02:00.0
[    2.754018] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 4 ports 6 Gbps 0x1 impl SATA mode
[    2.766773] ahci 0000:00:1f.2: flags: 64bit ncq pm led clo pio slum part ems 
[    2.770858] nvme nvme0: Shutdown timeout set to 8 seconds
[    2.774170] scsi host0: ahci
[    2.782312] scsi host1: ahci
[    2.785314] scsi host2: ahci
[    2.788318] scsi host3: ahci
[    2.791217] ata1: SATA max UDMA/133 abar m2048@0xf081a000 port 0xf081a100 irq 29
[    2.792411] nvme nvme0: 4/0/0 default/read/poll queues
[    2.798606] ata2: DUMMY
[    2.798606] ata3: DUMMY
[    2.798607] ata4: DUMMY
[    2.812093] r8169 0000:04:00.0 eth0: RTL8168g/8111g, 70:85:c2:47:3d:50, XID 4c0, IRQ 35
[    2.820096] r8169 0000:04:00.0 eth0: jumbo features [frames: 9194 bytes, tx checksumming: ko]
[    2.828692] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    2.833918] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
[    2.841614]  nvme0n1: p1
[    2.842367] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x0000000000009810
[    2.853372] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    2.853372] ehci-pci 0000:00:1a.0: EHCI Host Controller
[    2.853377] ehci-pci 0000:00:1a.0: new USB bus registered, assigned bus number 2
[    2.858598] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 3
[    2.863836] ehci-pci 0000:00:1a.0: debug port 2
[    2.871216] xhci_hcd 0000:00:14.0: Host supports USB 3.0 SuperSpeed
[    2.882503] ehci-pci 0000:00:1a.0: irq 16, io mem 0xf081c000
[    2.883160] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.04
[    2.903290] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.903742] ehci-pci 0000:00:1a.0: USB 2.0 started, EHCI 1.00
[    2.910509] usb usb1: Product: xHCI Host Controller
[    2.910510] usb usb1: Manufacturer: Linux 6.4.0-rc5-i5 xhci-hcd
[    2.927038] usb usb1: SerialNumber: 0000:00:14.0
[    2.931820] hub 1-0:1.0: USB hub found
[    2.935574] hub 1-0:1.0: 10 ports detected
[    2.940419] usb usb3: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.04
[    2.948679] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.955898] usb usb3: Product: xHCI Host Controller
[    2.960775] usb usb3: Manufacturer: Linux 6.4.0-rc5-i5 xhci-hcd
[    2.966740] usb usb3: SerialNumber: 0000:00:14.0
[    2.971498] hub 3-0:1.0: USB hub found
[    2.975255] hub 3-0:1.0: 2 ports detected
[    2.979480] usbcore: registered new interface driver usb-storage
[    2.979626] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.04
[    2.985593] i8042: PNP: No PS/2 controller found.
[    2.993745] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.998639] input: PC Speaker as /devices/platform/pcspkr/input/input3
[    3.005661] usb usb2: Product: EHCI Host Controller
[    3.005662] usb usb2: Manufacturer: Linux 6.4.0-rc5-i5 ehci_hcd
[    3.005663] usb usb2: SerialNumber: 0000:00:1a.0
[    3.005769] hub 2-0:1.0: USB hub found
[    3.012332] rtc_cmos 00:02: RTC can wake from S4
[    3.017068] hub 2-0:1.0: 2 ports detected
[    3.023268] rtc_cmos 00:02: registered as rtc0
[    3.027729] ehci-pci 0000:00:1d.0: EHCI Host Controller
[    3.031485] rtc_cmos 00:02: setting system clock to 2023-06-05T12:45:29 UTC (1685969129)
[    3.035964] ehci-pci 0000:00:1d.0: new USB bus registered, assigned bus number 4
[    3.039977] rtc_cmos 00:02: alarms up to one month, y3k, 242 bytes nvram, hpet irqs
[    3.044417] ehci-pci 0000:00:1d.0: debug port 2
[    3.049769] cx23885: cx23885 driver version 0.0.4 loaded
[    3.049813] i801_smbus 0000:00:1f.3: SPD Write Disable is set
[    3.049828] i801_smbus 0000:00:1f.3: SMBus using PCI interrupt
[    3.050219] i2c i2c-6: 2/2 memory slots populated (from DMI)
[    3.050541] i2c i2c-6: Successfully instantiated SPD at 0x50
[    3.061638] ehci-pci 0000:00:1d.0: irq 23, io mem 0xf081b000
[    3.065249] cx23885: CORE cx23885[0]: subsystem: 0070:c138, board: Hauppauge WinTV-HVR4400/HVR5500 [card=38,autodetected]
[    3.087745] ehci-pci 0000:00:1d.0: USB 2.0 started, EHCI 1.00
[    3.123231] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    3.127827] usb usb4: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.04
[    3.135150] ata1.00: ATA-8: ST31000524AS, JC4B, max UDMA/133
[    3.142220] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.142222] usb usb4: Product: EHCI Host Controller
[    3.142223] usb usb4: Manufacturer: Linux 6.4.0-rc5-i5 ehci_hcd
[    3.147882] ata1.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth 32)
[    3.155099] usb usb4: SerialNumber: 0000:00:1d.0
[    3.161348] ata1.00: configured for UDMA/133
[    3.165994] hub 4-0:1.0: USB hub found
[    3.172583] scsi 0:0:0:0: Direct-Access     ATA      ST31000524AS     JC4B PQ: 0 ANSI: 5
[    3.177117] hub 4-0:1.0: 2 ports detected
[    3.197375] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    3.197375] sd 0:0:0:0: [sda] 1953525168 512-byte logical blocks: (1.00 TB/932 GiB)
[    3.197381] sd 0:0:0:0: [sda] Write Protect is off
[    3.215132] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    3.215140] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    3.224181] sd 0:0:0:0: [sda] Preferred minimum I/O size 512 bytes
[    3.287789] usb 2-1: new high-speed USB device number 2 using ehci-pci
[    3.294343]  sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 >
[    3.300239] sd 0:0:0:0: [sda] Attached SCSI disk
[    3.399789] tsc: Refined TSC clocksource calibration: 3199.071 MHz
[    3.405970] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2e1cdc1a1cd, max_idle_ns: 440795258279 ns
[    3.415987] clocksource: Switched to clocksource tsc
[    3.443742] usb 4-1: new high-speed USB device number 2 using ehci-pci
[    3.443790] tveeprom: Hauppauge model 121029, rev B3F5, serial# 4035236800
[    3.457139] tveeprom: MAC address is 00:0d:fe:84:d3:c0
[    3.462277] tveeprom: tuner model is NXP 18271C2 (idx 155, type 54)
[    3.468543] tveeprom: TV standards PAL(B/G) PAL(I) SECAM(L/L') PAL(D/D1/K) ATSC/DVB Digital (eeprom 0xf4)
[    3.468566] usb 2-1: New USB device found, idVendor=8087, idProduct=8008, bcdDevice= 0.05
[    3.478101] tveeprom: audio processor is CX23888 (idx 40)
[    3.478102] tveeprom: decoder processor is CX23888 (idx 34)
[    3.486271] usb 2-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    3.497311] hub 2-1:1.0: USB hub found
[    3.504377] tveeprom: has radio, has IR receiver, has no IR transmitter
[    3.504378] cx23885: cx23885[0]: hauppauge eeprom: model=121029
[    3.504398] tea5767_autodetection: not probed - driver disabled by Kconfig
[    3.520688] hub 2-1:1.0: 4 ports detected
[    3.527536] tuner: 8-0060: Tuner -1 found with type(s) Radio TV.
[    3.537560] tda18271 8-0060: creating new instance
[    3.544404] tda18271: TDA18271HD/C1 detected @ 8-0060
[    3.604216] usb 4-1: New USB device found, idVendor=8087, idProduct=8000, bcdDevice= 0.05
[    3.612393] usb 4-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    3.619884] hub 4-1:1.0: USB hub found
[    3.623674] hub 4-1:1.0: 6 ports detected
[    3.825133] cx23885: cx23885[0]: registered device video0 [v4l2]
[    3.831235] cx23885: cx23885[0]: registered device vbi0
[    3.836683] cx23885: cx23885[0]: alsa: registered ALSA audio device
[    3.836685] cx23885: cx23885_dvb_register() allocating 1 frontend(s)
[    3.843038] cx23885: cx23885[0]: cx23885 based dvb card
[    3.849720] tda10071 7-0005: NXP TDA10071 successfully identified
[    3.856166] a8293 7-000b: Allegro A8293 SEC successfully attached
[    3.862599] dvbdev: DVB: registering new adapter (cx23885[0])
[    3.868344] cx23885 0000:03:00.0: DVB: registering adapter 0 frontend 0 (NXP TDA10071)...
[    3.876816] cx23885: cx23885_dvb_register() allocating 1 frontend(s)
[    3.883164] cx23885: cx23885[0]: cx23885 based dvb card
[    3.891025] si2165 7-0064: Detected Silicon Labs Si2165-D (type 7, rev 3)
[    3.897812] tda18271 8-0060: attaching existing instance
[    3.903460] dvbdev: DVB: registering new adapter (cx23885[0])
[    3.909197] cx23885 0000:03:00.0: DVB: registering adapter 1 frontend 0 (Silicon Labs Si2165 DVB-T DVB-C)...
[    3.919161] cx23885: cx23885_dev_checkrevision() Hardware revision = 0xd0
[    3.925943] cx23885: cx23885[0]/0: found at 0000:03:00.0, rev: 4, irq: 19, latency: 0, mmio: 0xf0400000
[    3.935357] usbcore: registered new interface driver dvb_usb_ttusb2
[    3.942690] nct6775: Found NCT6776D/F or compatible chip at 0x2e:0x290
[    3.950462] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) initialised: dm-devel@redhat.com
[    3.958911] intel_pstate: Intel P-state driver initializing
[    3.964696] hid: raw HID events driver (C) Jiri Kosina
[    3.969838] usbcore: registered new interface driver usbhid
[    3.975400] usbhid: USB HID core driver
[    3.979247] intel_rapl_common: Found RAPL domain package
[    3.984573] intel_rapl_common: Found RAPL domain core
[    3.989625] intel_rapl_common: Found RAPL domain uncore
[    3.994859] intel_rapl_common: Found RAPL domain dram
[    4.000417] snd_hda_intel 0000:00:03.0: bound 0000:00:02.0 (ops i915_audio_component_bind_ops)
[    4.009210] NET: Registered PF_PACKET protocol family
[    4.011976] snd_hda_codec_generic hdaudioC1D0: autoconfig for Generic: line_outs=0 (0x0/0x0/0x0/0x0/0x0) type:line
[    4.020923] snd_hda_codec_generic hdaudioC2D0: autoconfig for Generic: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:line
[    4.024615] snd_hda_codec_generic hdaudioC1D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[    4.035020] snd_hda_codec_generic hdaudioC2D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[    4.042942] snd_hda_codec_generic hdaudioC1D0:    hp_outs=0 (0x0/0x0/0x0/0x0/0x0)
[    4.050861] snd_hda_codec_generic hdaudioC2D0:    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
[    4.058341] snd_hda_codec_generic hdaudioC1D0:    mono: mono_out=0x0
[    4.065907] snd_hda_codec_generic hdaudioC2D0:    mono: mono_out=0x0
[    4.072260] snd_hda_codec_generic hdaudioC1D0:    dig-out=0x3/0x0
[    4.078612] snd_hda_codec_generic hdaudioC2D0:    dig-out=0x1e/0x0
[    4.084704] snd_hda_codec_generic hdaudioC1D0:    inputs:
[    4.090884] snd_hda_codec_generic hdaudioC2D0:    inputs:
[    4.096918] input: HDA Intel HDMI HDMI as /devices/pci0000:00/0000:00:03.0/sound/card1/input4
[    4.101683] snd_hda_codec_generic hdaudioC2D0:      Front Mic=0x19
[    4.101684] snd_hda_codec_generic hdaudioC2D0:      Rear Mic=0x18
[    4.101685] snd_hda_codec_generic hdaudioC2D0:      Line=0x1a
[    4.128345] microcode: Microcode Update Driver: v2.2.
[    4.128349] IPI shorthand broadcast: enabled
[    4.136662] input: HDA Intel PCH Rear Mic as /devices/pci0000:00/0000:00:1b.0/sound/card2/input5
[    4.137678] AVX2 version of gcm_enc/dec engaged.
[    4.146540] input: HDA Intel PCH Line as /devices/pci0000:00/0000:00:1b.0/sound/card2/input6
[    4.159612] input: HDA Intel PCH Line Out as /devices/pci0000:00/0000:00:1b.0/sound/card2/input7
[    4.168661] AES CTR mode by8 optimization enabled
[    4.174964] sched_clock: Marking stable (3121648350, 1051717731)->(4566843066, -393476985)
[    4.184300] Key type .fscrypt registered
[    4.188222] Key type fscrypt-provisioning registered
[    4.193380] PM:   Magic number: 11:881:783
[    4.212130] PM: Image not found (code -22)
[    4.212136] clk: Disabling unused clocks
[    4.216063] ALSA device list:
[    4.219028]   #0: Conexant CX23885 at cx23885[0]
[    4.223641]   #1: HDA Intel HDMI at 0xf0814000 irq 37
[    4.228686]   #2: HDA Intel PCH at 0xf0810000 irq 38
[    4.298045] EXT4-fs (sda3): mounted filesystem f1a941a6-7522-44e7-bf5c-7d00b8d909da ro with ordered data mode. Quota mode: disabled.
[    4.309958] VFS: Mounted root (ext4 filesystem) readonly on device 8:3.
[    4.332773] devtmpfs: mounted
[    4.336036] Freeing unused kernel image (initmem) memory: 1296K
[    4.341987] Write protecting the kernel read-only data: 18432k
[    4.348000] Freeing unused kernel image (rodata/data gap) memory: 312K
[    4.402995] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    4.409431] x86/mm: Checking user space page tables
[    4.449023] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    4.455458] Run /sbin/init as init process
[    4.459546]   with arguments:
[    4.459548]     /sbin/init
[    4.459548]   with environment:
[    4.459549]     HOME=/
[    4.459549]     TERM=linux
[    4.459550]     BOOT_IMAGE=/boot/selfkernel-test
[    5.605677] systemd[1]: Failed to look up module alias 'autofs4': Function not implemented
[    5.698854] systemd[1]: systemd 249.14+suse.166.g1bfa716e7f running in system mode (+PAM +AUDIT +SELINUX +APPARMOR -IMA -SMACK +SECCOMP +GCRYPT +GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LIBFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD -XKBCOMMON +UTMP +SYSVINIT default-hierarchy=hybrid)
[    5.731237] systemd[1]: Detected architecture x86-64.
[    5.785648] systemd[1]: Hostname set to <maggie>.
[    5.856815] memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=1 'systemd'
[    5.994861] systemd-sysv-generator[99]: SysV service '/etc/init.d/boot.local' lacks a native systemd unit file. Automatically generating a unit file for compatibility. Please update package to include a native systemd unit file, in order to make it more safe and robust.
[    7.354530] systemd[1]: Binding to IPv6 address not available since kernel does not support IPv6.
[    7.363406] systemd[1]: Binding to IPv6 address not available since kernel does not support IPv6.
[    7.586068] systemd[1]: Queued start job for default target Graphical Interface.
[    7.593967] systemd[1]: Created slice Slice /system/getty.
[    7.616100] systemd[1]: Created slice Slice /system/modprobe.
[    7.636104] systemd[1]: Created slice Slice /system/serial-getty.
[    7.660341] systemd[1]: Created slice Slice /system/systemd-fsck.
[    7.684115] systemd[1]: Created slice User and Session Slice.
[    7.704059] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
[    7.728006] systemd[1]: Condition check resulted in Arbitrary Executable File Formats File System Automount Point being skipped.
[    7.739685] systemd[1]: Reached target Local Encrypted Volumes.
[    7.760065] systemd[1]: Reached target Remote File Systems.
[    7.779961] systemd[1]: Reached target Slice Units.
[    7.800006] systemd[1]: Reached target Local Verity Protected Volumes.
[    7.824258] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    7.848329] systemd[1]: Listening on LVM2 poll daemon socket.
[    7.877533] systemd[1]: Listening on RPCbind Server Activation Socket.
[    7.899985] systemd[1]: Reached target RPC Port Mapper.
[    7.930654] systemd[1]: Listening on Syslog Socket.
[    7.952188] systemd[1]: Listening on initctl Compatibility Named Pipe.
[    7.976354] systemd[1]: Listening on Journal Socket (/dev/log).
[    8.000385] systemd[1]: Listening on Journal Socket.
[    8.042368] systemd[1]: Listening on udev Control Socket.
[    8.064283] systemd[1]: Listening on udev Kernel Socket.
[    8.084315] systemd[1]: Condition check resulted in Huge Pages File System being skipped.
[    8.111944] systemd[1]: Mounting POSIX Message Queue File System...
[    8.136601] systemd[1]: Mounting Kernel Debug File System...
[    8.155979] systemd[1]: Condition check resulted in Kernel Trace File System being skipped.
[    8.164438] systemd[1]: Condition check resulted in Load AppArmor profiles being skipped.
[    8.172736] systemd[1]: Condition check resulted in Create List of Static Device Nodes being skipped.
[    8.182741] systemd[1]: Starting Monitoring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling...
[    8.227987] systemd[1]: Starting Load Kernel Module configfs...
[    8.248796] systemd[1]: Starting Load Kernel Module drm...
[    8.268779] systemd[1]: Starting Load Kernel Module fuse...
[    8.288717] systemd[1]: Starting File System Check on Root Device...
[    8.312160] systemd[1]: systemd-journald.service: unit configures an IP firewall, but the local system does not support BPF/cgroup firewalling.
[    8.325024] systemd[1]: (This warning is only shown for the first unit using IP firewalling.)
[    8.334023] systemd[1]: Starting Journal Service...
[    8.439979] systemd[1]: Starting Load Kernel Modules...
[    8.446089] systemd[1]: Starting Coldplug All udev Devices...
[    8.453525] systemd[1]: Mounted POSIX Message Queue File System.
[    8.459885] systemd[1]: Mounted Kernel Debug File System.
[    8.466782] systemd[1]: Finished Monitoring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling.
[    8.478242] systemd[1]: modprobe@configfs.service: Deactivated successfully.
[    8.486607] systemd[1]: Finished Load Kernel Module configfs.
[    8.493813] systemd[1]: modprobe@drm.service: Deactivated successfully.
[    8.501739] systemd[1]: Finished Load Kernel Module drm.
[    8.508507] systemd[1]: modprobe@fuse.service: Deactivated successfully.
[    8.516530] systemd[1]: Finished Load Kernel Module fuse.
[    8.523743] systemd[1]: Mounting FUSE Control File System...
[    8.530352] systemd[1]: Condition check resulted in Kernel Configuration File System being skipped.
[    8.541062] systemd[1]: Started Journal Service.
[    8.701896] EXT4-fs (sda3): re-mounted f1a941a6-7522-44e7-bf5c-7d00b8d909da r/w. Quota mode: disabled.
[    8.796001] systemd-journald[109]: Received client request to flush runtime journal.
[   10.520382] EXT4-fs (nvme0n1p1): mounted filesystem 6a1fdeb2-9c11-4b6e-b094-f9912f93ed6e r/w with ordered data mode. Quota mode: disabled.
[   11.145566] Adding 2097148k swap on /dev/sda1.  Priority:42 extents:1 across:2097148k 
[   11.676245] EXT4-fs (sda5): barriers disabled
[   11.683334] EXT4-fs (sda5): mounted filesystem f0a60cb8-6068-445a-9b56-c6a2ebf6a9ae r/w with writeback data mode. Quota mode: disabled.
[   11.827591] EXT4-fs (sda6): barriers disabled
[   11.835822] EXT4-fs (sda6): mounted filesystem 850ca36a-137b-41f8-9f4c-c40db5b692fe r/w with writeback data mode. Quota mode: disabled.
[   19.427801] Generic FE-GE Realtek PHY r8169-0-400:00: attached PHY driver (mii_bus:phy_addr=r8169-0-400:00, irq=MAC)
[   19.635847] r8169 0000:04:00.0 eth0: Link is Down
[   22.207053] r8169 0000:04:00.0 eth0: Link is Up - 1Gbps/Full - flow control rx/tx
[   26.332149] tda10071 7-0005: found a 'NXP TDA10071' in cold state, will try to load a firmware
[   26.340779] tda10071 7-0005: downloading firmware from file 'dvb-fe-tda10071.fw'
[  989.277402] INFO: task vdr:743 blocked for more than 491 seconds.
[  989.283504]       Not tainted 6.4.0-rc5-i5 #249
[  989.288036] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  989.295860] task:vdr             state:D stack:0     pid:743   ppid:711    flags:0x00004002
[  989.295865] Call Trace:
[  989.295867]  <TASK>
[  989.295869]  __schedule+0x2ea/0x12d0
[  989.295877]  ? asm_sysvec_apic_timer_interrupt+0x16/0x20
[  989.295881]  schedule+0x57/0xc0
[  989.295884]  schedule_preempt_disabled+0xc/0x20
[  989.295887]  __mutex_lock.isra.16+0x237/0x480
[  989.295891]  ? dvb_get_property.isra.10+0x1bc/0xa50
[  989.295898]  ? dvb_frontend_stop+0x36/0x180
[  989.338777]  dvb_frontend_stop+0x36/0x180
[  989.338781]  dvb_frontend_open+0x2f1/0x470
[  989.338784]  dvb_device_open+0x81/0xf0
[  989.338804]  ? exact_lock+0x20/0x20
[  989.338808]  chrdev_open+0x7f/0x1c0
[  989.338811]  ? generic_permission+0x1a2/0x230
[  989.338813]  ? link_path_walk.part.63+0x340/0x380
[  989.338815]  ? exact_lock+0x20/0x20
[  989.338817]  do_dentry_open+0x18e/0x450
[  989.374030]  path_openat+0xca5/0xe00
[  989.374031]  ? terminate_walk+0xec/0x100
[  989.374034]  ? path_lookupat+0x93/0x140
[  989.374036]  do_filp_open+0xc0/0x140
[  989.374038]  ? __call_rcu_common.constprop.91+0x92/0x240
[  989.374041]  ? __check_object_size+0x147/0x260
[  989.374043]  ? __check_object_size+0x147/0x260
[  989.374045]  ? alloc_fd+0xbb/0x180
[  989.374048]  ? do_sys_openat2+0x243/0x310
[  989.374050]  do_sys_openat2+0x243/0x310
[  989.374052]  do_sys_open+0x52/0x80
[  989.374055]  do_syscall_64+0x5b/0x80
[  989.421335]  ? __task_pid_nr_ns+0x92/0xa0
[  989.421337]  ? syscall_exit_to_user_mode+0x20/0x40
[  989.421339]  ? do_syscall_64+0x67/0x80
[  989.421341]  ? syscall_exit_to_user_mode+0x20/0x40
[  989.421343]  ? do_syscall_64+0x67/0x80
[  989.421345]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  989.421348] RIP: 0033:0x7fe895d067e3
[  989.421349] RSP: 002b:00007fff933c2ba0 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
[  989.421351] RAX: ffffffffffffffda RBX: 00007fff933c2c10 RCX: 00007fe895d067e3
[  989.421352] RDX: 0000000000000802 RSI: 00005594acdce160 RDI: 00000000ffffff9c
[  989.421353] RBP: 0000000000000802 R08: 0000000000000000 R09: 0000000000000000
[  989.421353] R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000001
[  989.421354] R13: 00007fff933c2ca0 R14: 00000000ffffffff R15: 00007fff933c2c90
[  989.421355]  </TASK>

