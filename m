Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 005C16F7240
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 21:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjEDTCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 15:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjEDTCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 15:02:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC424C07;
        Thu,  4 May 2023 12:02:01 -0700 (PDT)
Message-ID: <20230504185733.126511787@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683226919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=Owpn3VAzXYYF5pE4nW59O5YtNe6oATS3CJHH6pOEc+Q=;
        b=ydWEHvQKju6ua5QrgIvoNFizD1mp/ScmeGKoSzoDnG7Bbtt8/QnpnQ3+taJ6G0kL830h+i
        7ID/utgQdKCvUYsl6w6CO2W2gJuO8HL9LCU4D0vVfB6YxemlrHUeCt4ToRjPCaRBB5yHoD
        U1z1RXcQdP2U5KMvTNzHXSugPczS5MTUtGDtT8qHk2Yf+N4IEi6AoiUHeLjn63zurjgLOd
        4VlOYXYRkaR1ek5ywemLfh9oakl4kmjQRYWBDRl/UvRYBt4y2JOaZBadJTEhsdykMmsR/p
        RzfI1eYCgw7RPP+JveXpGF8/O3jsZY1WVFPEdOuBnlsQhWH5/KilpYnEwkhH7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683226919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=Owpn3VAzXYYF5pE4nW59O5YtNe6oATS3CJHH6pOEc+Q=;
        b=t9YK5Y1XQbyMkzjkBl9J4dD0O18uiVWSVJxE2v987VhpllLfPD1+SKL0rJE7GDXI8icRF3
        WCaTcXYHj80XrzAw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, David Woodhouse <dwmw2@infradead.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Brian Gerst <brgerst@gmail.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul McKenney <paulmck@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Piotr Gorski <lucjan.lucjanov@gmail.com>,
        Usama Arif <usama.arif@bytedance.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        linux-csky@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Sabin Rapan <sabrapan@amazon.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Subject: [patch V2 00/38] cpu/hotplug, x86: Reworked parallel CPU bringup
Date:   Thu,  4 May 2023 21:01:58 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This is version 2 of the reworked parallel bringup series. Version 1 can be
found here:

   https://lore.kernel.org/lkml/20230414225551.858160935@linutronix.de

Background
----------

The reason why people are interested in parallel bringup is to shorten the
(kexec) reboot time of cloud servers to reduce the downtime of the VM
tenants.

The current fully serialized bringup does the following per AP:

    1) Prepare callbacks (allocate, intialize, create threads)
    2) Kick the AP alive (e.g. INIT/SIPI on x86)
    3) Wait for the AP to report alive state
    4) Let the AP continue through the atomic bringup
    5) Let the AP run the threaded bringup to full online state

There are two significant delays:

    #3 The time for an AP to report alive state in start_secondary() on x86
       has been measured in the range between 350us and 3.5ms depending on
       vendor and CPU type, BIOS microcode size etc.

    #4 The atomic bringup does the microcode update. This has been measured
       to take up to ~8ms on the primary threads depending on the microcode
       patch size to apply.

On a two socket SKL server with 56 cores (112 threads) the boot CPU spends
on current mainline about 800ms busy waiting for the APs to come up and
apply microcode. That's more than 80% of the actual onlining procedure.

By splitting the actual bringup mechanism into two parts this can be
reduced to waiting for the first AP to report alive or if the system is
large enough the first AP is already waiting when the boot CPU finished the
wake-up of the last AP. That reduces the AP bringup time on that SKL from
~800ms to ~80ms.

The actual gain varies wildly depending on the system, CPU, microcode patch
size and other factors.

The V1 cover letter has more details and a deep analysis.

Changes vs. V1:

  1) Switch APIC ID retrieval from CPUID to reading the APIC itself.

     This is required because CPUID based APIC ID retrieval can only
     provide the initial APIC ID, which might have been overruled by the
     firmware. Some AMD APUs come up with APIC ID = initial APIC ID + 0x10,
     so the APIC ID to CPU number lookup would fail miserably if based on
     CPUID. The only requirement is that the actual APIC IDs are consistent
     with the APCI/MADT table.

  2) As a consequence of #1 parallel bootup support for SEV guest has been
     dropped.

     Reading the APIC ID in a SEV guest is done via RDMSR. That RDMSR is
     intercepted and raises #VC which cannot be handled at that point as
     there is no stack and no IDT. There is no GHCB protocol for RDMSR
     like there is for CPUID. Left as an exercise for SEV wizards.

  3) Address review comments from Brian and the fallout reported by the
     kernel robot

  4) Unbreak i386 which exploded when bringing up the secondary CPUs due to
     the unconditinal load_ucode_ap() invocation in start_secondary(). That
     happens because on 32-bit load_ucode_ap() is invoked on the secondary
     CPUs from assembly code before paging is initialized and therefore
     uses physical addresses which are obviously invalid after paging is
     enabled.

  5) Small enhancements and comment updates.

  6) Rebased on Linux tree (1a5304fecee5)

The series applies on Linus tree and is also available from git:

    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git hotplug

Thanks,

	tglx
---
 Documentation/admin-guide/kernel-parameters.txt |   20 
 Documentation/core-api/cpu_hotplug.rst          |   13 
 arch/Kconfig                                    |   23 +
 arch/arm/Kconfig                                |    1 
 arch/arm/include/asm/smp.h                      |    2 
 arch/arm/kernel/smp.c                           |   18 
 arch/arm64/Kconfig                              |    1 
 arch/arm64/include/asm/smp.h                    |    2 
 arch/arm64/kernel/smp.c                         |   14 
 arch/csky/Kconfig                               |    1 
 arch/csky/include/asm/smp.h                     |    2 
 arch/csky/kernel/smp.c                          |    8 
 arch/mips/Kconfig                               |    1 
 arch/mips/cavium-octeon/smp.c                   |    1 
 arch/mips/include/asm/smp-ops.h                 |    1 
 arch/mips/kernel/smp-bmips.c                    |    1 
 arch/mips/kernel/smp-cps.c                      |   14 
 arch/mips/kernel/smp.c                          |    8 
 arch/mips/loongson64/smp.c                      |    1 
 arch/parisc/Kconfig                             |    1 
 arch/parisc/kernel/process.c                    |    4 
 arch/parisc/kernel/smp.c                        |    7 
 arch/riscv/Kconfig                              |    1 
 arch/riscv/include/asm/smp.h                    |    2 
 arch/riscv/kernel/cpu-hotplug.c                 |   14 
 arch/x86/Kconfig                                |   45 --
 arch/x86/include/asm/apic.h                     |    5 
 arch/x86/include/asm/apicdef.h                  |    5 
 arch/x86/include/asm/cpu.h                      |    5 
 arch/x86/include/asm/cpumask.h                  |    5 
 arch/x86/include/asm/processor.h                |    1 
 arch/x86/include/asm/realmode.h                 |    3 
 arch/x86/include/asm/smp.h                      |   24 -
 arch/x86/include/asm/topology.h                 |   23 -
 arch/x86/include/asm/tsc.h                      |    2 
 arch/x86/kernel/acpi/sleep.c                    |    9 
 arch/x86/kernel/apic/apic.c                     |   26 -
 arch/x86/kernel/callthunks.c                    |    4 
 arch/x86/kernel/cpu/amd.c                       |    2 
 arch/x86/kernel/cpu/cacheinfo.c                 |   21 
 arch/x86/kernel/cpu/common.c                    |   50 --
 arch/x86/kernel/cpu/topology.c                  |    3 
 arch/x86/kernel/head_32.S                       |   14 
 arch/x86/kernel/head_64.S                       |   87 +++
 arch/x86/kernel/sev.c                           |    2 
 arch/x86/kernel/smp.c                           |    3 
 arch/x86/kernel/smpboot.c                       |  526 ++++++++----------------
 arch/x86/kernel/topology.c                      |   98 ----
 arch/x86/kernel/tsc.c                           |   20 
 arch/x86/kernel/tsc_sync.c                      |   36 -
 arch/x86/power/cpu.c                            |   37 -
 arch/x86/realmode/init.c                        |    3 
 arch/x86/realmode/rm/trampoline_64.S            |   27 +
 arch/x86/xen/enlighten_hvm.c                    |   11 
 arch/x86/xen/smp_hvm.c                          |   16 
 arch/x86/xen/smp_pv.c                           |   56 +-
 drivers/acpi/processor_idle.c                   |    4 
 include/linux/cpu.h                             |    4 
 include/linux/cpuhotplug.h                      |   17 
 kernel/cpu.c                                    |  396 +++++++++++++++++-
 kernel/smp.c                                    |    2 
 kernel/smpboot.c                                |  163 -------
 62 files changed, 934 insertions(+), 982 deletions(-)
