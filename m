Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4AD4687733
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 09:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbjBBIWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 03:22:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjBBIWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 03:22:15 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192028349A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 00:22:11 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id h19so1000373vsv.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 00:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=62PxbjedLw6rWW2dCKZCBb5PL29du4RKDlgds9AuSHE=;
        b=q9oN2cXqcaPhjtTnvaGuR3TmsdRQBPyLTIG+an2Bg567wDdjNneoXbr4fwYQzbgyPW
         OnNRe/9PosPnXlpnIOa3maBW/R3lt67NR8gIbtd5Y+344mmt+WgZnDB2kHpE7gr1yUl5
         5Nr4CToTaFQeZdvxfhwoIlMQnNPBx+EeczGoSXXuKYZuWBKuAhGfSnsfdzQj4WDkflv8
         L24q+2vPPKJqjp/n6vFOCsYvlWTP3BWsJ7RTTDYITq4XBqw5NwpWf1LHhETnv9lvqEPp
         QNy+Dx4ZHrXRvwSgCSOPvdK3phJzd/nPLBRRR0C47LvVioYaJg42YIDs2bmaiWBH3yya
         PJmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=62PxbjedLw6rWW2dCKZCBb5PL29du4RKDlgds9AuSHE=;
        b=z89TMrqwgSjTn4Vvk+UZk6/MIsiPNTzoiswFi/OmioowKxB18JKv76l0JvIgOZxJ/2
         Agi68l0a3oRS5yXKn3DAVbwRXORlox+KuTQ+PQ6nntGFbq1tK/XrwTKgzrReQr7011TM
         eVJtnInGRCqRMC2Ad1Wmzyw/cuoRA3V0dfrvh59DdSXxzooPUzkroLDA6RdiMyN8XJxj
         1aURk9aZkOMejxyELBr673rn/YVu21BjL7lTIEa3KmGlqUUgd/7eC+5X0VKFgpwZ5j++
         9FntetOA0QzeeXovybzSYlNDqy2sgTz4DBEn59QwwF92TpqUtS3JqPb0TXv3CsOHfop1
         NW8g==
X-Gm-Message-State: AO0yUKWCRuyXqGyOS5f7F2x6zKNTnqo/8OYPqSm9Pfp+AV2M5WCce4sj
        JvcA+phlqzpwn2Xb2+0QU1M2+AlCwLab5KJsy3tF8zvvdJGo2fv+
X-Google-Smtp-Source: AK7set8japy+h2LIp9RXNY+tsjLBty5R0veXJrTyz5Odx1wmn+bSJo8VzzDWdEjmp6eb3V28RGGyltFU2RPiKWWY9tU=
X-Received: by 2002:a67:e19a:0:b0:3f7:528b:d25f with SMTP id
 e26-20020a67e19a000000b003f7528bd25fmr945877vsl.9.1675326129294; Thu, 02 Feb
 2023 00:22:09 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 2 Feb 2023 13:51:58 +0530
Message-ID: <CA+G9fYtUV+LV0tZHQo_9GuMFD2tZs_AhvRFy_L4E3T0C8SRANA@mail.gmail.com>
Subject: qemu-x86_64: clang: RIP: 0010:sched_clock_cpu
To:     open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following kernel crash noticed on qemu-x86_64 intermittently with Linux next.
qemu-system-x86, installed at version: 7.2

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Boot log:
-----------
<5>[    0.000000] Linux version 6.2.0-rc6-next-20230202
(tuxmake@tuxmake) (Debian clang version 15.0.7, Debian LLD 15.0.7) #1
SMP PREEMPT_DYNAMIC @1675308517
<6>[    0.000000] Command line: console=ttyS0,115200 rootwait
root=/dev/sda debug verbose console_msg_format=syslog earlycon
<6>[    0.000000] x86/fpu: x87 FPU will use FXSAVE
<6>[    0.000000] signal: max sigframe size: 1440
<6>[    0.000000] BIOS-provided physical RAM map:
<6>[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
<6>[    0.000000] BIOS-e820: [mem
0x000000000009fc00-0x000000000009ffff] reserved
<6>[    0.000000] BIOS-e820: [mem
0x00000000000f0000-0x00000000000fffff] reserved
<6>[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000007ffdefff] usable
<6>[    0.000000] BIOS-e820: [mem
0x000000007ffdf000-0x000000007fffffff] reserved
<6>[    0.000000] BIOS-e820: [mem
0x00000000b0000000-0x00000000bfffffff] reserved
<6>[    0.000000] BIOS-e820: [mem
0x00000000fed1c000-0x00000000fed1ffff] reserved
<6>[    0.000000] BIOS-e820: [mem
0x00000000fffc0000-0x00000000ffffffff] reserved
<6>[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000017fffffff] usable
<5>[    0.000000] random: crng init done
<6>[    0.000000] NX (Execute Disable) protection: active
<7>[    0.000000] e820: update [mem 0x00f37c20-0x00f37c2f] usable ==> usable
<7>[    0.000000] e820: update [mem 0x00f37c20-0x00f37c2f] usable ==> usable
<6>[    0.000000] extended physical RAM map:
<6>[    0.000000] reserve setup_data: [mem
0x0000000000000000-0x000000000009fbff] usable
<6>[    0.000000] reserve setup_data: [mem
0x000000000009fc00-0x000000000009ffff] reserved
<6>[    0.000000] reserve setup_data: [mem
0x00000000000f0000-0x00000000000fffff] reserved
<6>[    0.000000] reserve setup_data: [mem
0x0000000000100000-0x0000000000f37c1f] usable
<6>[    0.000000] reserve setup_data: [mem
0x0000000000f37c20-0x0000000000f37c2f] usable
<6>[    0.000000] reserve setup_data: [mem
0x0000000000f37c30-0x000000007ffdefff] usable
<6>[    0.000000] reserve setup_data: [mem
0x000000007ffdf000-0x000000007fffffff] reserved
<6>[    0.000000] reserve setup_data: [mem
0x00000000b0000000-0x00000000bfffffff] reserved
<6>[    0.000000] reserve setup_data: [mem
0x00000000fed1c000-0x00000000fed1ffff] reserved
<6>[    0.000000] reserve setup_data: [mem
0x00000000fffc0000-0x00000000ffffffff] reserved
<6>[    0.000000] reserve setup_data: [mem
0x0000000100000000-0x000000017fffffff] usable
<6>[    0.000000] SMBIOS 2.8 present.
<6>[    0.000000] DMI: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
1.14.0-2 04/01/2014
<6>[    0.000000] tsc: Fast TSC calibration using PIT
<6>[    0.000000] tsc: Detected 2649.953 MHz processor
<7>[    0.001000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
<7>[    0.001000] e820: remove [mem 0x000a0000-0x000fffff] usable
<6>[    0.001000] last_pfn = 0x180000 max_arch_pfn = 0x400000000
<6>[    0.001000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
<6>[    0.001000] last_pfn = 0x7ffdf max_arch_pfn = 0x400000000
<6>[    0.001000] found SMP MP-table at [mem 0x000f5ce0-0x000f5cef]
<6>[    0.001000] ACPI: Early table checksum verification disabled
<6>[    0.001000] ACPI: RSDP 0x00000000000F5B10 000014 (v00 BOCHS )
<6>[    0.001000] ACPI: RSDT 0x000000007FFE2319 000038 (v01 BOCHS
BXPC     00000001 BXPC 00000001)
<6>[    0.001000] ACPI: FACP 0x000000007FFE2109 0000F4 (v03 BOCHS
BXPC     00000001 BXPC 00000001)
<6>[    0.001000] ACPI: DSDT 0x000000007FFE0040 0020C9 (v01 BOCHS
BXPC     00000001 BXPC 00000001)
<6>[    0.001000] ACPI: FACS 0x000000007FFE0000 000040
<6>[    0.001000] ACPI: APIC 0x000000007FFE21FD 000080 (v01 BOCHS
BXPC     00000001 BXPC 00000001)
<6>[    0.001000] ACPI: HPET 0x000000007FFE227D 000038 (v01 BOCHS
BXPC     00000001 BXPC 00000001)
<6>[    0.001000] ACPI: MCFG 0x000000007FFE22B5 00003C (v01 BOCHS
BXPC     00000001 BXPC 00000001)
<6>[    0.001000] ACPI: WAET 0x000000007FFE22F1 000028 (v01 BOCHS
BXPC     00000001 BXPC 00000001)
<6>[    0.001000] ACPI: Reserving FACP table memory at [mem
0x7ffe2109-0x7ffe21fc]
<6>[    0.001000] ACPI: Reserving DSDT table memory at [mem
0x7ffe0040-0x7ffe2108]
<6>[    0.001000] ACPI: Reserving FACS table memory at [mem
0x7ffe0000-0x7ffe003f]
<6>[    0.001000] ACPI: Reserving APIC table memory at [mem
0x7ffe21fd-0x7ffe227c]
<6>[    0.001000] ACPI: Reserving HPET table memory at [mem
0x7ffe227d-0x7ffe22b4]
<6>[    0.001000] ACPI: Reserving MCFG table memory at [mem
0x7ffe22b5-0x7ffe22f0]
<6>[    0.001000] ACPI: Reserving WAET table memory at [mem
0x7ffe22f1-0x7ffe2318]
<6>[    0.001000] No NUMA configuration found
<6>[    0.001000] Faking a node at [mem 0x0000000000000000-0x000000017fffffff]
<6>[    0.001000] NODE_DATA(0) allocated [mem 0x17fffb000-0x17fffefff]
<6>[    0.001000] Zone ranges:
<6>[    0.001000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
<6>[    0.001000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
<6>[    0.001000]   Normal   [mem 0x0000000100000000-0x000000017fffffff]
<6>[    0.001000] Movable zone start for each node
<6>[    0.001000] Early memory node ranges
<6>[    0.001000]   node   0: [mem 0x0000000000001000-0x000000000009efff]
<6>[    0.001000]   node   0: [mem 0x0000000000100000-0x000000007ffdefff]
<6>[    0.001000]   node   0: [mem 0x0000000100000000-0x000000017fffffff]
<6>[    0.001000] Initmem setup node 0 [mem
0x0000000000001000-0x000000017fffffff]
<6>[    0.001000] On node 0, zone DMA: 1 pages in unavailable ranges
<6>[    0.001000] On node 0, zone DMA: 97 pages in unavailable ranges
<6>[    0.001000] On node 0, zone Normal: 33 pages in unavailable ranges
<6>[    0.001000] ACPI: PM-Timer IO Port: 0x608
<6>[    0.001000] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
<6>[    0.001000] IOAPIC[0]: apic_id 0, version 32, address 0xfec00000, GSI 0-23
<6>[    0.001000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
<6>[    0.001000] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
<6>[    0.001000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
<6>[    0.001000] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
<6>[    0.001000] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
<6>[    0.001000] ACPI: Using ACPI (MADT) for SMP configuration information
<6>[    0.001000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
<6>[    0.001000] smpboot: Allowing 2 CPUs, 0 hotplug CPUs
<6>[    0.001000] PM: hibernation: Registered nosave memory: [mem
0x00000000-0x00000fff]
<6>[    0.001000] PM: hibernation: Registered nosave memory: [mem
0x0009f000-0x0009ffff]
<6>[    0.001000] PM: hibernation: Registered nosave memory: [mem
0x000a0000-0x000effff]
<6>[    0.001000] PM: hibernation: Registered nosave memory: [mem
0x000f0000-0x000fffff]
<6>[    0.001000] PM: hibernation: Registered nosave memory: [mem
0x00f37000-0x00f37fff]
<6>[    0.001000] PM: hibernation: Registered nosave memory: [mem
0x00f37000-0x00f37fff]
<6>[    0.001000] PM: hibernation: Registered nosave memory: [mem
0x7ffdf000-0x7fffffff]
<6>[    0.001000] PM: hibernation: Registered nosave memory: [mem
0x80000000-0xafffffff]
<6>[    0.001000] PM: hibernation: Registered nosave memory: [mem
0xb0000000-0xbfffffff]
<6>[    0.001000] PM: hibernation: Registered nosave memory: [mem
0xc0000000-0xfed1bfff]
<6>[    0.001000] PM: hibernation: Registered nosave memory: [mem
0xfed1c000-0xfed1ffff]
<6>[    0.001000] PM: hibernation: Registered nosave memory: [mem
0xfed20000-0xfffbffff]
<6>[    0.001000] PM: hibernation: Registered nosave memory: [mem
0xfffc0000-0xffffffff]
<6>[    0.001000] [mem 0xc0000000-0xfed1bfff] available for PCI devices
<6>[    0.001000] Booting paravirtualized kernel on bare hardware
<6>[    0.001000] clocksource: refined-jiffies: mask: 0xffffffff
max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
<6>[    0.001000] setup_percpu: NR_CPUS:64 nr_cpumask_bits:2
nr_cpu_ids:2 nr_node_ids:1
<6>[    0.001000] percpu: Embedded 54 pages/cpu s183272 r8192 d29720 u1048576
<7>[    0.001000] pcpu-alloc: s183272 r8192 d29720 u1048576 alloc=1*2097152
<7>[    0.001000] pcpu-alloc: [0] 0 1
<6>[    0.001000] Fallback order for Node 0: 0
<6>[    0.001000] Built 1 zonelists, mobility grouping on.  Total pages: 1031902
<6>[    0.001000] Policy zone: Normal
<5>[    0.001000] Kernel command line: console=ttyS0,115200 rootwait
root=/dev/sda debug verbose console_msg_format=syslog earlycon
<5>[    0.001000] Unknown kernel command line parameters \"verbose\",
will be passed to user space.
<6>[    0.001000] Dentry cache hash table entries: 524288 (order: 10,
4194304 bytes, linear)
<6>[    0.001000] Inode-cache hash table entries: 262144 (order: 9,
2097152 bytes, linear)
<6>[    0.001000] mem auto-init: stack:all(zero), heap alloc:off, heap free:off
<6>[    0.001000] software IO TLB: area num 2.
<6>[    0.001000] Memory: 4013356K/4193780K available (22528K kernel
code, 3125K rwdata, 7832K rodata, 3404K init, 1428K bss, 180164K
reserved, 0K cma-reserved)
<6>[    0.001000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
<6>[    0.001000] Kernel/User page tables isolation: enabled
<6>[    0.001000] ftrace: allocating 55888 entries in 219 pages
<6>[    0.001000] ftrace: allocated 219 pages with 6 groups
<6>[    0.001000] Dynamic Preempt: voluntary
<6>[    0.001000] rcu: Preemptible hierarchical RCU implementation.
<6>[    0.001000] rcu: RCU event tracing is enabled.
<6>[    0.001000] rcu: RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=2.
<6>[    0.001000] Trampoline variant of Tasks RCU enabled.
<6>[    0.001000] Rude variant of Tasks RCU enabled.
<6>[    0.001000] rcu: RCU calculated value of scheduler-enlistment
delay is 100 jiffies.
<6>[    0.001000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
<6>[    0.001000] NR_IRQS: 4352, nr_irqs: 440, preallocated irqs: 16
<6>[    0.001000] rcu: srcu_init: Setting srcu_struct sizes based on contention.
<6>[    0.001000] kfence: initialized - using 2097152 bytes for 255
objects at 0x(____ptrval____)-0x(____ptrval____)
<6>[    0.001000] Console: colour VGA+ 80x25
<6>[    0.001000] printk: console [ttyS0] enabled
<6>[    0.001000] ACPI: Core revision 20221020
<6>[    0.001000] clocksource: hpet: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 19112604467 ns
<6>[    0.001000] APIC: Switch to symmetric I/O mode setup
<6>[    0.001000] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
<6>[    0.001000] clocksource: tsc-early: mask: 0xffffffffffffffff
max_cycles: 0x263290d1ca9, max_idle_ns: 440795211992 ns
<6>[    0.297445] Calibrating delay loop (skipped), value calculated
using timer frequency.. 5299.90 BogoMIPS (lpj=2649953)
<6>[    0.299729] pid_max: default: 32768 minimum: 301
<6>[    0.303905] LSM: initializing lsm=capability,integrity,selinux
<6>[    0.306462] SELinux:  Initializing.
<6>[    0.312722] Mount-cache hash table entries: 8192 (order: 4,
65536 bytes, linear)
<6>[    0.313532] Mountpoint-cache hash table entries: 8192 (order: 4,
65536 bytes, linear)
<6>[    0.332453] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
<6>[    0.332625] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
<6>[    0.333005] Spectre V1 : Mitigation: usercopy/swapgs barriers
and __user pointer sanitization
<6>[    0.333286] Spectre V2 : Mitigation: Retpolines
<6>[    0.333363] Spectre V2 : Spectre v2 / SpectreRSB mitigation:
Filling RSB on context switch
<6>[    0.333534] Spectre V2 : Spectre v2 / SpectreRSB : Filling RSB on VMEXIT
<6>[    0.334572] Speculative Store Bypass: Vulnerable
<6>[    0.335662] MDS: Vulnerable: Clear CPU buffers attempted, no microcode
<6>[    0.336014] MMIO Stale Data: Unknown: No mitigations
<6>[    0.500870] Freeing SMP alternatives memory: 60K
<6>[    0.617445] smpboot: CPU0: Intel Core i7 9xx (Nehalem Class Core
i7) (family: 0x6, model: 0x1a, stepping: 0x3)
<6>[    0.624737] cblist_init_generic: Setting adjustable number of
callback queues.
<6>[    0.625270] cblist_init_generic: Setting shift to 1 and lim to 1.
<6>[    0.625623] cblist_init_generic: Setting shift to 1 and lim to 1.
<6>[    0.626734] Performance Events: unsupported p6 CPU model 26 no
PMU driver, software events only.
<6>[    0.629690] rcu: Hierarchical SRCU implementation.
<6>[    0.629951] rcu: Max phase no-delay instances is 400.
<6>[    0.637992] smp: Bringing up secondary CPUs ...
<6>[    0.642064] x86: Booting SMP configuration:
<6>[    0.642311] .... node  #0, CPUs:      #1
<6>[    0.650908] smp: Brought up 1 node, 2 CPUs
<6>[    0.651392] smpboot: Max logical packages: 1
<6>[    0.651593] smpboot: Total of 2 processors activated (10599.81 BogoMIPS)
<6>[    0.669004] devtmpfs: initialized
<6>[    0.678766] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 1911260446275000 ns
<6>[    0.679936] futex hash table entries: 512 (order: 3, 32768 bytes, linear)
<6>[    0.683491] PM: RTC time: 03:40:29, date: 2023-02-02
<6>[    0.688487] NET: Registered PF_NETLINK/PF_ROUTE protocol family
<6>[    0.692216] audit: initializing netlink subsys (disabled)
<5>[    0.694930] audit: type=2000 audit(1675309229.413:1):
state=initialized audit_enabled=0 res=1
<6>[    0.699161] thermal_sys: Registered thermal governor 'step_wise'
<6>[    0.699212] thermal_sys: Registered thermal governor 'user_space'
<6>[    0.701799] cpuidle: using governor menu
<6>[    0.707367] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem
0xb0000000-0xbfffffff] (base 0xb0000000)
<6>[    0.708194] PCI: MMCONFIG at [mem 0xb0000000-0xbfffffff]
reserved as E820 entry
<6>[    0.709753] PCI: Using configuration type 1 for base access
<4>[    0.712151] mtrr: your CPUs had inconsistent fixed MTRR settings
<4>[    0.712466] mtrr: your CPUs had inconsistent variable MTRR settings
<4>[    0.712798] mtrr: your CPUs had inconsistent MTRRdefType settings
<6>[    0.713132] mtrr: probably your BIOS does not setup all CPUs.
<6>[    0.713378] mtrr: corrected configuration.
<6>[    0.716240] kprobes: kprobe jump-optimization is enabled. All
kprobes are optimized if possible.
<6>[    0.827531] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
<6>[    0.827958] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
<6>[    0.838353] cryptd: max_cpu_qlen set to 1000
<6>[    0.845327] ACPI: Added _OSI(Module Device)
<6>[    0.845504] ACPI: Added _OSI(Processor Device)
<6>[    0.845729] ACPI: Added _OSI(3.0 _SCP Extensions)
<6>[    0.845968] ACPI: Added _OSI(Processor Aggregator Device)
<6>[    0.873930] ACPI: 1 ACPI AML tables successfully acquired and loaded
<6>[    1.247570] ACPI: Interpreter enabled
<6>[    1.249881] ACPI: PM: (supports S0 S3 S4 S5)
<6>[    1.250165] ACPI: Using IOAPIC for interrupt routing
<6>[    1.252042] PCI: Using host bridge windows from ACPI; if
necessary, use \"pci=nocrs\" and report a bug
<6>[    1.252509] PCI: Using E820 reservations for host bridge windows
<6>[    1.253976] ACPI: Enabled 2 GPEs in block 00 to 3F
<6>[    1.284181] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
<6>[    1.285105] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig
ASPM ClockPM Segments MSI HPX-Type3]
<6>[    1.287653] acpi PNP0A08:00: _OSC: platform does not support [LTR]
<6>[    1.289108] acpi PNP0A08:00: _OSC: OS now controls [PME PCIeCapability]
<6>[    1.293082] PCI host bridge to bus 0000:00
<6>[    1.293445] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
<6>[    1.293488] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
<6>[    1.293750] pci_bus 0000:00: root bus resource [mem
0x000a0000-0x000bffff window]
<6>[    1.293750] pci_bus 0000:00: root bus resource [mem
0x80000000-0xafffffff window]
<6>[    1.293750] pci_bus 0000:00: root bus resource [mem
0xc0000000-0xfebfffff window]
<6>[    1.294104] pci_bus 0000:00: root bus resource [mem
0x180000000-0x97fffffff window]
<6>[    1.294104] pci_bus 0000:00: root bus resource [bus 00-ff]
<6>[    1.295861] pci 0000:00:00.0: [8086:29c0] type 00 class 0x060000
<6>[    1.300471] pci 0000:00:01.0: [1234:1111] type 00 class 0x030000
<6>[    1.301961] pci 0000:00:01.0: reg 0x10: [mem 0xfd000000-0xfdffffff pref]
<6>[    1.303042] pci 0000:00:01.0: reg 0x18: [mem 0xfebf0000-0xfebf0fff]
<6>[    1.307479] pci 0000:00:01.0: reg 0x30: [mem 0xfebe0000-0xfebeffff pref]
<6>[    1.307479] pci 0000:00:01.0: Video device with shadowed ROM at
[mem 0x000c0000-0x000dffff]
<6>[    1.309491] pci 0000:00:1f.0: [8086:2918] type 00 class 0x060100
<6>[    1.311627] pci 0000:00:1f.0: quirk: [io  0x0600-0x067f] claimed
by ICH6 ACPI/GPIO/TCO
<6>[    1.312879] pci 0000:00:1f.2: [8086:2922] type 00 class 0x010601
<6>[    1.316964] pci 0000:00:1f.2: reg 0x20: [io  0xc040-0xc05f]
<6>[    1.317285] pci 0000:00:1f.2: reg 0x24: [mem 0xfebf1000-0xfebf1fff]
<6>[    1.319523] pci 0000:00:1f.3: [8086:2930] type 00 class 0x0c0500
<6>[    1.321732] pci 0000:00:1f.3: reg 0x20: [io  0x0700-0x073f]
<6>[    1.328162] ACPI: PCI: Interrupt link LNKA configured for IRQ 10
<6>[    1.329626] ACPI: PCI: Interrupt link LNKB configured for IRQ 10
<6>[    1.331740] ACPI: PCI: Interrupt link LNKC configured for IRQ 11
<6>[    1.332751] ACPI: PCI: Interrupt link LNKD configured for IRQ 11
<6>[    1.333664] ACPI: PCI: Interrupt link LNKE configured for IRQ 10
<6>[    1.335806] ACPI: PCI: Interrupt link LNKF configured for IRQ 10
<6>[    1.336348] ACPI: PCI: Interrupt link LNKG configured for IRQ 11
<6>[    1.337873] ACPI: PCI: Interrupt link LNKH configured for IRQ 11
<6>[    1.338445] ACPI: PCI: Interrupt link GSIA configured for IRQ 16
<6>[    1.338835] ACPI: PCI: Interrupt link GSIB configured for IRQ 17
<6>[    1.339679] ACPI: PCI: Interrupt link GSIC configured for IRQ 18
<6>[    1.339679] ACPI: PCI: Interrupt link GSID configured for IRQ 19
<6>[    1.340310] ACPI: PCI: Interrupt link GSIE configured for IRQ 20
<6>[    1.340690] ACPI: PCI: Interrupt link GSIF configured for IRQ 21
<6>[    1.340690] ACPI: PCI: Interrupt link GSIG configured for IRQ 22
<6>[    1.340974] ACPI: PCI: Interrupt link GSIH configured for IRQ 23
<6>[    1.344703] iommu: Default domain type: Translated
<6>[    1.344975] iommu: DMA domain TLB invalidation policy: lazy mode
<5>[    1.347366] SCSI subsystem initialized
<7>[    1.349930] libata version 3.00 loaded.
<6>[    1.351688] ACPI: bus type USB registered
<6>[    1.352717] usbcore: registered new interface driver usbfs
<6>[    1.353753] usbcore: registered new interface driver hub
<6>[    1.354655] usbcore: registered new device driver usb
<6>[    1.355803] mc: Linux media interface: v0.10
<6>[    1.356662] videodev: Linux video capture interface: v2.00
<6>[    1.357561] pps_core: LinuxPPS API ver. 1 registered
<6>[    1.357820] pps_core: Software ver. 5.3.6 - Copyright 2005-2007
Rodolfo Giometti <giometti@linux.it>
<6>[    1.358525] PTP clock support registered
<6>[    1.362513] Advanced Linux Sound Architecture Driver Initialized.
<6>[    1.372066] NetLabel: Initializing
<6>[    1.372265] NetLabel:  domain hash size = 128
<6>[    1.373459] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
<6>[    1.375625] NetLabel:  unlabeled traffic allowed by default
<6>[    1.380702] PCI: Using ACPI for IRQ routing
<7>[    1.388962] PCI: pci_cache_line_size set to 64 bytes
<7>[    1.389937] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
<7>[    1.390562] e820: reserve RAM buffer [mem 0x00f37c20-0x00ffffff]
<7>[    1.391522] e820: reserve RAM buffer [mem 0x7ffdf000-0x7fffffff]
<6>[    1.393731] pci 0000:00:01.0: vgaarb: setting as boot VGA device
<6>[    1.394104] pci 0000:00:01.0: vgaarb: bridge control possible
<6>[    1.394445] pci 0000:00:01.0: vgaarb: VGA device added:
decodes=io+mem,owns=io+mem,locks=none
<6>[    1.394504] vgaarb: loaded
<6>[    1.397539] hpet: 3 channels of 0 reserved for per-cpu timers
<6>[    1.398457] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
<6>[    1.398802] hpet0: 3 comparators, 64-bit 100.000000 MHz counter
<6>[    1.403036] clocksource: Switched to clocksource tsc-early
<5>[    1.522404] VFS: Disk quotas dquot_6.6.0
<6>[    1.522999] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
<6>[    1.527985] pnp: PnP ACPI init
<6>[    1.532852] system 00:05: [mem 0xb0000000-0xbfffffff window] has
been reserved
<6>[    1.536210] pnp: PnP ACPI: found 6 devices
<6>[    1.571883] clocksource: acpi_pm: mask: 0xffffff max_cycles:
0xffffff, max_idle_ns: 2085701024 ns
<6>[    1.572481] NET: Registered PF_INET protocol family
<6>[    1.575414] IP idents hash table entries: 65536 (order: 7,
524288 bytes, linear)
<6>[    1.586173] tcp_listen_portaddr_hash hash table entries: 2048
(order: 3, 32768 bytes, linear)
<6>[    1.586748] Table-perturb hash table entries: 65536 (order: 6,
262144 bytes, linear)
<6>[    1.587180] TCP established hash table entries: 32768 (order: 6,
262144 bytes, linear)
<6>[    1.589141] TCP bind hash table entries: 32768 (order: 8,
1048576 bytes, linear)
<6>[    1.590707] TCP: Hash tables configured (established 32768 bind 32768)
<6>[    1.593001] MPTCP token hash table entries: 4096 (order: 4,
98304 bytes, linear)
<6>[    1.594018] UDP hash table entries: 2048 (order: 4, 65536 bytes, linear)
<6>[    1.594987] UDP-Lite hash table entries: 2048 (order: 4, 65536
bytes, linear)
<6>[    1.597013] NET: Registered PF_UNIX/PF_LOCAL protocol family
<6>[    1.600326] RPC: Registered named UNIX socket transport module.
<6>[    1.600772] RPC: Registered udp transport module.
<6>[    1.601029] RPC: Registered tcp transport module.
<6>[    1.601281] RPC: Registered tcp NFSv4.1 backchannel transport module.
<6>[    1.605424] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
<6>[    1.605875] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
<6>[    1.606193] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
<6>[    1.606688] pci_bus 0000:00: resource 7 [mem 0x80000000-0xafffffff window]
<6>[    1.606798] pci_bus 0000:00: resource 8 [mem 0xc0000000-0xfebfffff window]
<6>[    1.606798] pci_bus 0000:00: resource 9 [mem
0x180000000-0x97fffffff window]
<6>[    1.609557] PCI: CLS 0 bytes, default 64
<6>[    1.610742] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
<6>[    1.611091] software IO TLB: mapped [mem
0x000000007bfdf000-0x000000007ffdf000] (64MB)
<3>[    1.613114] kvm_intel: VMX not supported by CPU 0
<3>[    1.613436] kvm_amd: SVM not supported by CPU 0, not amd or hygon
<6>[    1.619899] CPU feature 'AVX registers' is not supported.
<6>[    1.621775] CPU feature 'AVX registers' is not supported.
<6>[    1.622089] AVX2 instructions are not detected.
<6>[    1.622734] AVX or AES-NI instructions are not detected.
<6>[    1.623674] AVX2 or AES-NI instructions are not detected.
<6>[    1.624149] CPU feature 'AVX registers' is not supported.
<6>[    1.624655] CPU feature 'AVX registers' is not supported.
<6>[    1.626701] PCLMULQDQ-NI instructions are not detected.
<5>[    1.630872] Initialise system trusted keyrings
<6>[    1.633322] workingset: timestamp_bits=40 max_order=20 bucket_order=0
<5>[    1.637708] NFS: Registering the id_resolver key type
<5>[    1.638323] Key type id_resolver registered
<5>[    1.638852] Key type id_legacy registered
<6>[    1.640360] 9p: Installing v9fs 9p2000 file system support
<6>[    1.667147] NET: Registered PF_ALG protocol family
<5>[    1.667850] Key type asymmetric registered
<5>[    1.668157] Asymmetric key parser 'x509' registered
<6>[    1.669766] Block layer SCSI generic (bsg) driver version 0.4
loaded (major 250)
<6>[    1.670939] io scheduler mq-deadline registered
<6>[    1.671219] io scheduler kyber registered
<6>[    1.675517] input: Power Button as
/devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
<6>[    1.679381] ACPI: button: Power Button [PWRF]
<6>[    1.684767] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
<6>[    1.688205] 00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud =
115200) is a 16550A
<6>[    1.695816] Non-volatile memory driver v1.3
<6>[    1.696099] Linux agpgart interface v0.103
<6>[    1.698815] ACPI: bus type drm_connector registered
<6>[    1.720900] loop: module loaded
<7>[    1.723055] ahci 0000:00:1f.2: version 3.0
<6>[    1.729351] ACPI: \_SB_.GSIA: Enabled at IRQ 16
<6>[    1.736086] ahci 0000:00:1f.2: AHCI 0001.0000 32 slots 6 ports
1.5 Gbps 0x3f impl SATA mode
<6>[    1.736725] ahci 0000:00:1f.2: flags: 64bit ncq only
<6>[    1.745185] scsi host0: ahci
<6>[    1.748728] scsi host1: ahci
<6>[    1.750833] scsi host2: ahci
<6>[    1.752925] scsi host3: ahci
<6>[    1.755002] scsi host4: ahci
<6>[    1.757083] scsi host5: ahci
<6>[    1.758338] ata1: SATA max UDMA/133 abar m4096@0xfebf1000 port
0xfebf1100 irq 24
<6>[    1.758838] ata2: SATA max UDMA/133 abar m4096@0xfebf1000 port
0xfebf1180 irq 24
<6>[    1.759173] ata3: SATA max UDMA/133 abar m4096@0xfebf1000 port
0xfebf1200 irq 24
<6>[    1.759595] ata4: SATA max UDMA/133 abar m4096@0xfebf1000 port
0xfebf1280 irq 24
<6>[    1.760913] ata5: SATA max UDMA/133 abar m4096@0xfebf1000 port
0xfebf1300 irq 24
<6>[    1.761631] ata6: SATA max UDMA/133 abar m4096@0xfebf1000 port
0xfebf1380 irq 24
<6>[    1.771733] e100: Intel(R) PRO/100 Network Driver
<6>[    1.772175] e100: Copyright(c) 1999-2006 Intel Corporation
<6>[    1.772493] e1000: Intel(R) PRO/1000 Network Driver
<6>[    1.773017] e1000: Copyright (c) 1999-2006 Intel Corporation.
<6>[    1.773586] e1000e: Intel(R) PRO/1000 Network Driver
<6>[    1.773741] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
<6>[    1.774237] igb: Intel(R) Gigabit Ethernet Network Driver
<6>[    1.774528] igb: Copyright (c) 2007-2014 Intel Corporation.
<6>[    1.775028] sky2: driver version 1.30
<6>[    1.775503] QLogic FastLinQ 4xxxx Core Module qed
<6>[    1.776093] qede init: QLogic FastLinQ 4xxxx Ethernet Driver qede
<6>[    1.777542] usbcore: registered new interface driver asix
<6>[    1.778337] usbcore: registered new interface driver ax88179_178a
<6>[    1.778906] usbcore: registered new interface driver cdc_ether
<6>[    1.779308] usbcore: registered new interface driver net1080
<6>[    1.779658] usbcore: registered new interface driver cdc_subset
<6>[    1.780132] usbcore: registered new interface driver zaurus
<6>[    1.780545] usbcore: registered new interface driver cdc_ncm
<6>[    1.781040] usbcore: registered new interface driver r8153_ecm
<6>[    1.784379] usbcore: registered new interface driver usblp
<6>[    1.784889] usbcore: registered new interface driver usb-storage
<6>[    1.786581] i8042: PNP: PS/2 Controller
[PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
<6>[    1.790178] serio: i8042 KBD port at 0x60,0x64 irq 1
<6>[    1.790747] serio: i8042 AUX port at 0x60,0x64 irq 12
<6>[    1.796000] input: AT Translated Set 2 keyboard as
/devices/platform/i8042/serio0/input/input1
<6>[    1.797829] rtc_cmos 00:04: RTC can wake from S4
<6>[    1.804859] rtc_cmos 00:04: registered as rtc0
<6>[    1.808283] rtc_cmos 00:04: alarms up to one day, y3k, 242 bytes
nvram, hpet irqs
<3>[    1.810430] fail to initialize ptp_kvm
<6>[    1.811759] device-mapper: ioctl: 4.47.0-ioctl (2022-07-28)
initialised: dm-devel@redhat.com
<6>[    1.813409] intel_pstate: CPU model not supported
<6>[    1.820735] i801_smbus 0000:00:1f.3: SMBus using PCI interrupt
<6>[    1.825548] i2c i2c-0: 1/1 memory slots populated (from DMI)
<6>[    1.826237] i2c i2c-0: Memory type 0x07 not supported yet, not
instantiating SPD
<6>[    1.835500] kworker/u4:7 (71) used greatest stack depth: 14152 bytes left
<6>[    1.845347] hid: raw HID events driver (C) Jiri Kosina
<6>[    1.848065] usbcore: registered new interface driver usbhid
<6>[    1.848346] usbhid: USB HID core driver
<6>[    1.858207] Initializing XFRM netlink socket
<6>[    1.859081] NET: Registered PF_INET6 protocol family
<6>[    1.866464] Segment Routing with IPv6
<6>[    1.867010] In-situ OAM (IOAM) with IPv6
<6>[    1.868849] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
<6>[    1.872282] NET: Registered PF_PACKET protocol family
<6>[    1.874292] 9pnet: Installing 9P2000 support
<5>[    1.875187] Key type dns_resolver registered
<6>[    1.878011] IPI shorthand broadcast: enabled
<6>[    1.907425] sched_clock: Marking stable (1627046624,
279445047)->(1932177729, -25686058)
<4>[    1.910655] int3: 0000 [#1] PREEMPT SMP PTI
<4>[    1.911148] CPU: 1 PID: 0 Comm: swapper/1 Not tainted
6.2.0-rc6-next-20230202 #1
<4>[    1.911255] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS 1.14.0-2 04/01/2014
<4>[    1.911400] RIP: 0010:sched_clock_cpu+0x10/0x1a0
<4>[    1.911779] Code: 01 5b 5d c3 cc cc cc cc 66 90 90 90 90 90 90
90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 55 48 89 e5 41 57 41 56
41 54 53 66 <90> e8 0a d6 0b 01 48 89 c3 48 03 1d 90 8a e8 01 48 89 d8
5b 41 5c
<4>[    1.911880] RSP: 0000:ffff98bc800d0f68 EFLAGS: 00000006
<4>[    1.911932] RAX: 00000000613175a9 RBX: ffff8bad3bd1f730 RCX:
0000000000000018
<4>[    1.911950] RDX: 8000000000000000 RSI: 00000001b2045fd2 RDI:
0000000000000001
<4>[    1.911968] RBP: ffff98bc800d0f88 R08: 00257dc7307bee1b R09:
0000000000609b01
<4>[    1.911984] R10: 0000000000000000 R11: ffffffff998fde80 R12:
0000000000000000
<4>[    1.912000] R13: 0000000000000000 R14: 0000000078cce501 R15:
0000000000000000
<4>[    1.912057] FS:  0000000000000000(0000)
GS:ffff8bad3bd00000(0000) knlGS:0000000000000000
<4>[    1.912081] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[    1.912099] CR2: 0000000000000000 CR3: 0000000113a3e000 CR4:
00000000000006e0
<4>[    1.912223] Call Trace:
<4>[    1.912404]  <IRQ>
<4>[    1.912677]  sched_clock_idle_sleep_event+0x14/0x20
<4>[    1.912775]  tick_nohz_irq_exit+0x3e/0x50
<4>[    1.912794]  __irq_exit_rcu+0xb2/0xf0
<4>[    1.912809]  irq_exit_rcu+0x12/0x20
<4>[    1.912838]  sysvec_call_function_single+0x7b/0x90
<4>[    1.912888]  </IRQ>
<4>[    1.912913]  <TASK>
<4>[    1.912919]  asm_sysvec_call_function_single+0x1f/0x30
<4>[    1.913028] RIP: 0010:default_idle+0x17/0x20
<4>[    1.913041] Code: ff ff ff 90 90 90 90 90 90 90 90 90 90 90 90
90 90 90 90 f3 0f 1e fa 55 48 89 e5 eb 07 0f 00 2d 65 4b 2e 00 f3 0f
1e fa fb f4 <fa> 5d c3 cc cc cc cc 66 90 90 90 90 90 90 90 90 90 90 90
90 90 90
<4>[    1.913050] RSP: 0000:ffff98bc8009beb8 EFLAGS: 00000216
<4>[    1.913061] RAX: ffff8bad3bd28020 RBX: ffff8bacc02d8ec0 RCX:
0000000000002e0c
<4>[    1.913068] RDX: 0000000000000000 RSI: 0000000000000001 RDI:
0000000000002e0c
<4>[    1.913075] RBP: ffff98bc8009beb8 R08: 00257dc7307bee1b R09:
0000000000609b01
<4>[    1.913082] R10: 0000000000000000 R11: ffffffff9992e210 R12:
0000000000000000
<4>[    1.913089] R13: 0000000000000000 R14: 0000000000000001 R15:
0000000000000000
<4>[    1.913126]  ? __pfx_native_apic_mem_write+0x10/0x10
<4>[    1.913207]  arch_cpu_idle+0xd/0x20
<4>[    1.913220]  default_idle_call+0x43/0x70
<4>[    1.913232]  do_idle+0xec/0x270
<4>[    1.913250]  cpu_startup_entry+0x21/0x30
<4>[    1.913263]  start_secondary+0x97/0xa0
<4>[    1.913279]  secondary_startup_64_no_verify+0xe1/0xeb
<4>[    1.913314]  </TASK>
<4>[    1.913364] Modules linked in:
<4>[    1.929266] ---[ end trace 0000000000000000 ]---
<4>[    1.929381] RIP: 0010:sched_clock_cpu+0x10/0x1a0
<4>[    1.929435] Code: 01 5b 5d c3 cc cc cc cc 66 90 90 90 90 90 90
90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 55 48 89 e5 41 57 41 56
41 54 53 66 <90> e8 0a d6 0b 01 48 89 c3 48 03 1d 90 8a e8 01 48 89 d8
5b 41 5c
<4>[    1.929449] RSP: 0000:ffff98bc800d0f68 EFLAGS: 00000006
<4>[    1.929468] RAX: 00000000613175a9 RBX: ffff8bad3bd1f730 RCX:
0000000000000018
<4>[    1.929478] RDX: 8000000000000000 RSI: 00000001b2045fd2 RDI:
0000000000000001
<4>[    1.929487] RBP: ffff98bc800d0f88 R08: 00257dc7307bee1b R09:
0000000000609b01
<4>[    1.929497] R10: 0000000000000000 R11: ffffffff998fde80 R12:
0000000000000000
<4>[    1.929511] R13: 0000000000000000 R14: 0000000078cce501 R15:
0000000000000000
<4>[    1.929519] FS:  0000000000000000(0000)
GS:ffff8bad3bd00000(0000) knlGS:0000000000000000
<4>[    1.929532] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[    1.929685] CR2: 0000000000000000 CR3: 0000000113a3e000 CR4:
00000000000006e0
<0>[    1.930109] Kernel panic - not syncing: Fatal exception in interrupt
<4>[    1.931479] int3: 0000 [#2] PREEMPT SMP PTI
<4>[    1.931609] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G      D
      6.2.0-rc6-next-20230202 #1
<4>[    1.931626] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS 1.14.0-2 04/01/2014
<4>[    1.931636] RIP: 0010:sched_clock_cpu+0x10/0x1a0
<4>[    1.931670] Code: 01 5b 5d c3 cc cc cc cc 66 90 90 90 90 90 90
90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 55 48 89 e5 41 57 41 56
41 54 53 66 <90> e8 0a d6 0b 01 48 89 c3 48 03 1d 90 8a e8 01 48 89 d8
5b 41 5c
<4>[    1.931682] RSP: 0000:ffff98bc80003e40 EFLAGS: 00000002
<4>[    1.931697] RAX: 0000000000000000 RBX: ffff8bad3bc2b480 RCX:
00000000fffbc480
<4>[    1.931706] RDX: ffffffffffffadfe RSI: ffffffff9b396e11 RDI:
0000000000000000
<4>[    1.931715] RBP: ffff98bc80003e60 R08: 0000000000000000 R09:
0000000000000000
<4>[    1.931723] R10: 0000000000000001 R11: ffffffff998fde80 R12:
0000000000000086
<4>[    1.931731] R13: 0000000000000000 R14: 0000000000000000 R15:
ffff8bacc02b8000
<4>[    1.931739] FS:  0000000000000000(0000)
GS:ffff8bad3bc00000(0000) knlGS:0000000000000000
<4>[    1.931750] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[    1.931759] CR2: ffff8bad3ffff000 CR3: 0000000113a3e000 CR4:
00000000000006f0
<4>[    1.931769] Call Trace:
<4>[    1.931780]  <IRQ>
<4>[    1.931800]  update_rq_clock+0x31/0x190
<4>[    1.931820]  scheduler_tick+0x82/0x260
<4>[    1.931839]  update_process_times+0x7e/0x90
<4>[    1.931857]  tick_sched_timer+0xcd/0x120
<4>[    1.931875]  ? __pfx_tick_sched_timer+0x10/0x10
<4>[    1.931891]  __hrtimer_run_queues+0x107/0x340
<4>[    1.931915]  hrtimer_interrupt+0xf6/0x390
<4>[    1.931937]  __sysvec_apic_timer_interrupt+0x62/0x190
<4>[    1.931954]  sysvec_apic_timer_interrupt+0x79/0x90
<4>[    1.931975]  </IRQ>
<4>[    1.931981]  <TASK>
<4>[    1.931988]  asm_sysvec_apic_timer_interrupt+0x1f/0x30
<4>[    1.932009] RIP: 0010:sched_init_debug+0xbd/0x1e0
<4>[    1.932030] Code: c7 c1 40 d8 66 9b e8 d2 aa 4e fe 48 8b 15 e3
8c 32 00 48 c7 c7 e2 33 47 9b be a4 01 00 00 48 c7 c1 48 d8 66 9b e8
b3 aa 4e fe <48> 8b 15 c4 8c 32 00 48 c7 c7 85 61 43 9b be a4 01 00 00
48 c7 c1
<4>[    1.932041] RSP: 0000:ffff98bc80013b70 EFLAGS: 00000286
<4>[    1.932053] RAX: ffff8bacc057bc00 RBX: ffffffff9bafc31c RCX:
0000000000000000
<4>[    1.932059] RDX: 0000000000400008 RSI: ffffffff99a888e2 RDI:
ffffffff99a888e2
<4>[    1.932067] RBP: ffff98bc80013b70 R08: ffff98bc80013a28 R09:
ffff8bacc0ac9d58
<4>[    1.932073] R10: 00000000e1682801 R11: ffffffff99eb2780 R12:
ffffffff9b610598
<4>[    1.932081] R13: 0000000000000000 R14: ffffffff9b993ec0 R15:
0000000000000000
<4>[    1.932091]  ? __pfx_sched_init_debug+0x10/0x10
<4>[    1.932108]  ? __pfx_selinux_d_instantiate+0x10/0x10
<4>[    1.932128]  ? up_write+0x52/0xe0
<4>[    1.932143]  ? up_write+0x52/0xe0
<4>[    1.932162]  do_one_initcall+0x122/0x310
<4>[    1.932233]  do_initcall_level+0x83/0xf0
<4>[    1.932254]  do_initcalls+0x44/0x80
<4>[    1.932268]  do_basic_setup+0x1d/0x30
<4>[    1.932282]  kernel_init_freeable+0x104/0x170
<4>[    1.932297]  ? __pfx_kernel_init+0x10/0x10
<4>[    1.932312]  kernel_init+0x1e/0x1a0
<4>[    1.932325]  ret_from_fork+0x2c/0x50
<4>[    1.932352]  </TASK>
<4>[    1.932357] Modules linked in:
<4>[    1.934374] ---[ end trace 0000000000000000 ]---
<4>[    1.934388] RIP: 0010:sched_clock_cpu+0x10/0x1a0
<4>[    1.934411] Code: 01 5b 5d c3 cc cc cc cc 66 90 90 90 90 90 90
90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 55 48 89 e5 41 57 41 56
41 54 53 66 <90> e8 0a d6 0b 01 48 89 c3 48 03 1d 90 8a e8 01 48 89 d8
5b 41 5c
<4>[    1.934423] RSP: 0000:ffff98bc800d0f68 EFLAGS: 00000006
<4>[    1.934436] RAX: 00000000613175a9 RBX: ffff8bad3bd1f730 RCX:
0000000000000018
<4>[    1.934446] RDX: 8000000000000000 RSI: 00000001b2045fd2 RDI:
0000000000000001
<4>[    1.934454] RBP: ffff98bc800d0f88 R08: 00257dc7307bee1b R09:
0000000000609b01
<4>[    1.934463] R10: 0000000000000000 R11: ffffffff998fde80 R12:
0000000000000000
<4>[    1.934472] R13: 0000000000000000 R14: 0000000078cce501 R15:
0000000000000000
<4>[    1.934480] FS:  0000000000000000(0000)
GS:ffff8bad3bc00000(0000) knlGS:0000000000000000
<4>[    1.934491] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[    1.934501] CR2: ffff8bad3ffff000 CR3: 0000000113a3e000 CR4:
00000000000006f0
<0>[    3.679784] Shutting down cpus with NMI
<0>[    3.681021] Kernel Offset: 0x18800000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)


Steps to reproduce:
--------------------------

# To install tuxrun on your system globally:
# sudo pip3 install -U tuxrun==0.34.1
#
# See https://tuxrun.org/ for complete documentation.

tuxrun --runtime podman --device qemu-x86_64 --kernel
https://storage.tuxsuite.com/public/linaro/lkft/builds/2LAKFW7doAV49HcxJiKQ60xIREo/bzImage
--modules https://storage.tuxsuite.com/public/linaro/lkft/builds/2LAKFW7doAV49HcxJiKQ60xIREo/modules.tar.xz
--rootfs https://storage.tuxsuite.com/public/linaro/lkft/oebuilds/2KUrpujJ4nghSfiwhpMYVQGQDJu/images/intel-corei7-64/lkft-tux-image-intel-corei7-64-20230118121043.rootfs.ext4.gz
--parameters SKIPFILE=skipfile-lkft.yaml --image
docker.io/lavasoftware/lava-dispatcher:2023.01 --tests ltp-crypto
--timeouts boot=15 ltp-crypto=30

Build details:
https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2LAKHsiOb4uW3qEwA2XPpvzUPYC
Config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2LAKFW7doAV49HcxJiKQ60xIREo/config

--
Linaro LKFT
https://lkft.linaro.org
