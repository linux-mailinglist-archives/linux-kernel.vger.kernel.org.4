Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000E3649BB3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 11:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbiLLKJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 05:09:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbiLLKJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 05:09:07 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565AD2D9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 02:09:03 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670839742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=CtxZK44rK8xrzu7n0COyoJ1eMk41DNWL9G2p7SbgbT0=;
        b=J9vVIAkjGR/njeRCQvZOzBljUcKK1xZa/98w4O/dmoMOE6mULn3Tbt5JelET1I6Hxs6NJk
        95kXsZ26bldFumPORg1zIRxkOg5aemTLw4VNjREzseo/Yn7qagr9PBuwCq+OFcTwOpIP+t
        3mGhXVl5GcxDMqFUSnTpkKD/2VucugRPNIw5SsOrn2tm9RwLiKxyePhtVx+gTG+yDG1pH6
        c7RKgVqc9OKGMOy9/NEiPz8eVqKInlbNswuDA2FBuc5nVIreeqHIMhSRZ+24py2dYTsKEG
        KA5ZcHvHTm4sxQjsspScF6xCTu2CEODr/hqZ9WjKOgR0UglHq49R4bB+6JJXGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670839742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=CtxZK44rK8xrzu7n0COyoJ1eMk41DNWL9G2p7SbgbT0=;
        b=jdCR8s1zSLDfuLsgah1oNxazKs0ajBVkem+oTIMC4FEeZpL1JT4VKMpJ0WlVYAot3A0ZWa
        hjr0wq8mh/m8R0Cg==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/core for v6.2-rc1
References: <167083907785.564878.11381307641454805335.tglx@xen13.tec.linutronix.de>
Message-ID: <167083908037.564878.14292182209678650008.tglx@xen13.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Mon, 12 Dec 2022 11:09:01 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest irq/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2022-12=
-10

up to:  6132a490f9c8: Merge tag 'irqchip-6.2' of git://git.kernel.org/pub/scm=
/linux/kernel/git/maz/arm-platforms into irq/core

Updates for the interrupt core and driver subsystem:

 - Core:

   The bulk is the rework of the MSI subsystem to support per device MSI
   interrupt domains. This solves conceptual problems of the current
   PCI/MSI design which are in the way of providing support for PCI/MSI[-X]
   and the upcoming PCI/IMS mechanism on the same device.

   IMS (Interrupt Message Store] is a new specification which allows device
   manufactures to provide implementation defined storage for MSI messages
   contrary to the uniform and specification defined storage mechanisms for
   PCI/MSI and PCI/MSI-X. IMS not only allows to overcome the size limitations
   of the MSI-X table, but also gives the device manufacturer the freedom to
   store the message in arbitrary places, even in host memory which is shared
   with the device.
  =20
   There have been several attempts to glue this into the current MSI code,
   but after lengthy discussions it turned out that there is a fundamental
   design problem in the current PCI/MSI-X implementation. This needs some
   historical background.
  =20
   When PCI/MSI[-X] support was added around 2003, interrupt management was
   completely different from what we have today in the actively developed
   architectures. Interrupt management was completely architecture specific
   and while there were attempts to create common infrastructure the
   commonalities were rudimentary and just providing shared data structures a=
nd
   interfaces so that drivers could be written in an architecture agnostic
   way.
  =20
   The initial PCI/MSI[-X] support obviously plugged into this model which
   resulted in some basic shared infrastructure in the PCI core code for
   setting up MSI descriptors, which are a pure software construct for holding
   data relevant for a particular MSI interrupt, but the actual association to
   Linux interrupts was completely architecture specific. This model is still
   supported today to keep museum architectures and notorious stranglers
   alive.

   In 2013 Intel tried to add support for hot-pluggable IO/APICs to the kerne=
l,
   which was creating yet another architecture specific mechanism and resulted
   in an unholy mess on top of the existing horrors of x86 interrupt handling.
   The x86 interrupt management code was already an incomprehensible maze of
   indirections between the CPU vector management, interrupt remapping and the
   actual IO/APIC and PCI/MSI[-X] implementation.
  =20
   At roughly the same time ARM struggled with the ever growing SoC specific
   extensions which were glued on top of the architected GIC interrupt
   controller.
  =20
   This resulted in a fundamental redesign of interrupt management and
   provided the today prevailing concept of hierarchical interrupt
   domains. This allowed to disentangle the interactions between x86 vector
   domain and interrupt remapping and also allowed ARM to handle the zoo of
   SoC specific interrupt components in a sane way.
  =20
   The concept of hierarchical interrupt domains aims to encapsulate the
   functionality of particular IP blocks which are involved in interrupt
   delivery so that they become extensible and pluggable. The X86
   encapsulation looks like this:
  =20
                                            |--- device 1
     [Vector]---[Remapping]---[PCI/MSI]--|...
                                            |--- device N
  =20
   where the remapping domain is an optional component and in case that it is
   not available the PCI/MSI[-X] domains have the vector domain as their
   parent. This reduced the required interaction between the domains pretty
   much to the initialization phase where it is obviously required to
   establish the proper parent relation ship in the components of the
   hierarchy.
  =20
   While in most cases the model is strictly representing the chain of IP
   blocks and abstracting them so they can be plugged together to form a
   hierarchy, the design stopped short on PCI/MSI[-X]. Looking at the hardware
   it's clear that the actual PCI/MSI[-X] interrupt controller is not a global
   entity, but strict a per PCI device entity.
  =20
   Here we took a short cut on the hierarchical model and went for the easy
   solution of providing "global" PCI/MSI domains which was possible because
   the PCI/MSI[-X] handling is uniform across the devices. This also allowed
   to keep the existing PCI/MSI[-X] infrastructure mostly unchanged which in
   turn made it simple to keep the existing architecture specific management
   alive.
  =20
   A similar problem was created in the ARM world with support for IP block
   specific message storage. Instead of going all the way to stack a IP block
   specific domain on top of the generic MSI domain this ended in a construct
   which provides a "global" platform MSI domain which allows overriding the
   irq_write_msi_msg() callback per allocation.
  =20
   In course of the lengthy discussions we identified other abuse of the MSI
   infrastructure in wireless drivers, NTB etc. where support for
   implementation specific message storage was just mindlessly glued into the
   existing infrastructure. Some of this just works by chance on particular
   platforms but will fail in hard to diagnose ways when the driver is used
   on platforms where the underlying MSI interrupt management code does not
   expect the creative abuse.
  =20
   Another shortcoming of today's PCI/MSI-X support is the inability to
   allocate or free individual vectors after the initial enablement of
   MSI-X. This results in an works by chance implementation of VFIO (PCI
   pass-through) where interrupts on the host side are not set up upfront to
   avoid resource exhaustion. They are expanded at run-time when the guest
   actually tries to use them. The way how this is implemented is that the
   host disables MSI-X and then re-enables it with a larger number of
   vectors again. That works by chance because most device drivers set up
   all interrupts before the device actually will utilize them. But that's
   not universally true because some drivers allocate a large enough number
   of vectors but do not utilize them until it's actually required,
   e.g. for acceleration support. But at that point other interrupts of the
   device might be in active use and the MSI-X disable/enable dance can
   just result in losing interrupts and therefore hard to diagnose subtle
   problems.
  =20
   Last but not least the "global" PCI/MSI-X domain approach prevents to
   utilize PCI/MSI[-X] and PCI/IMS on the same device due to the fact that IMS
   is not longer providing a uniform storage and configuration model.
  =20
   The solution to this is to implement the missing step and switch from
   global PCI/MSI domains to per device PCI/MSI domains. The resulting
   hierarchy then looks like this:
  =20
                              |--- [PCI/MSI] device 1
     [Vector]---[Remapping]---|...
                              |--- [PCI/MSI] device N
  =20
   which in turn allows to provide support for multiple domains per device:
  =20
                              |--- [PCI/MSI] device 1
                              |--- [PCI/IMS] device 1
     [Vector]---[Remapping]---|...
                              |--- [PCI/MSI] device N
                              |--- [PCI/IMS] device N

   This work converts the MSI and PCI/MSI core and the x86 interrupt
   domains to the new model, provides new interfaces for post-enable
   allocation/free of MSI-X interrupts and the base framework for PCI/IMS.
   PCI/IMS has been verified with the work in progress IDXD driver.

   There is work in progress to convert ARM over which will replace the
   platform MSI train-wreck. The cleanup of VFIO, NTB and other creative
   "solutions" are in the works as well.
=20
 - Drivers:

   - Updates for the LoongArch interrupt chip drivers

   - Support for MTK CIRQv2

   - The usual small fixes and updates all over the place

Thanks,

	tglx

------------------>
Ahmed S. Darwish (22):
      genirq/msi: Add bus token to struct msi_domain_info
      PCI/MSI: Use msi_domain_info:: Bus_token
      PCI/MSI: Let the MSI core free descriptors
      PCI/MSI: Get rid of externs in msi.h
      PCI/MSI: Move mask and unmask helpers to msi.h
      PCI/MSI: Move pci_disable_msi() to api.c
      PCI/MSI: Move pci_enable_msi() API to api.c
      PCI/MSI: Move pci_enable_msix_range() to api.c
      PCI/MSI: Move pci_alloc_irq_vectors() to api.c
      PCI/MSI: Move pci_alloc_irq_vectors_affinity() to api.c
      PCI/MSI: Move pci_irq_vector() to api.c
      PCI/MSI: Move pci_free_irq_vectors() to api.c
      PCI/MSI: Move pci_msix_vec_count() to api.c
      PCI/MSI: Move pci_disable_msix() to api.c
      PCI/MSI: Move pci_irq_get_affinity() to api.c
      PCI/MSI: Move pci_msi_enabled() to api.c
      PCI/MSI: Move pci_msi_restore_state() to api.c
      Documentation: PCI: Add reference to PCI/MSI device driver APIs
      PCI/MSI: Reorder functions in msi.c
      genirq/msi: Make msi_get_virq() device domain aware
      platform-msi: Switch to the domain id aware MSI interfaces
      oc: ti: ti_sci_inta_msi: Switch to domain id aware MSI functions

Aidan MacDonald (1):
      irqchip/sl28cpld: Replace irqchip mask_invert with unmask_base

AngeloGioacchino Del Regno (4):
      dt-bindings: interrupt-controller: mediatek,cirq: Migrate to dt schema
      dt-bindings: interrupt-controller: mediatek,cirq: Document MT8192
      irqchip/irq-mtk-cirq: Move register offsets to const array
      irqchip/irq-mtk-cirq: Add support for System CIRQ on MT8192

Angus Chen (1):
      genirq: Remove unused argument force of irq_set_affinity_deactivated()

Bagas Sanjaya (1):
      PCI/MSI: Use bullet lists in kernel-doc comments of api.c

Christophe JAILLET (1):
      irqchip/gic: Use kstrtobool() instead of strtobool()

Huacai Chen (7):
      irqchip/loongson-htvec: Add ACPI init support
      irqchip/loongson-htvec: Add suspend/resume support
      irqchip/loongson-eiointc: Add suspend/resume support
      irqchip/loongson-pch-pic: Add suspend/resume support
      irqchip/loongson-pch-lpc: Add suspend/resume support
      irqchip/loongarch: Adjust acpi_cascade_irqdomain_init() and sub-routines
      irqchip/loongarch-cpu: Fix a missing prototype warning

Jean Delvare (1):
      irqchip/al-fic: Drop obsolete dependency on COMPILE_TEST

Jianmin Lv (4):
      ACPI / PCI: fix LPIC IRQ model default PCI IRQ polarity
      irqchip/loongson-pch-pic: Fix translate callback for DT path
      irqchip/loongson-pch-pic: Support to set IRQ type for ACPI path
      irqchip/loongson-liointc: Support to set IRQ type for ACPI path

Konrad Dybcio (1):
      irqchip/apple-aic: Mark aic_info structs __initconst

Liu Peibao (3):
      irqchip: loongarch-cpu: add DT support
      dt-bindings: interrupt-controller: add yaml for LoongArch CPU interrupt=
 controller
      irqchip/loongson-liointc: Fix improper error handling in liointc_init()

Randy Dunlap (1):
      genirq/irqreturn: Fix kernel-doc warnings

Samuel Holland (1):
      irqchip/sifive-plic: Support wake IRQs

Sean Anderson (1):
      irqchip/ls-extirq: Fix endianness detection

Shang XiaoJing (1):
      irqchip: gic-pm: Use pm_runtime_resume_and_get() in gic_probe()

Thomas Gleixner (80):
      clocksource/drivers/hyper-v: Include asm/hyperv-tlfs.h not asm/mshyperv=
.h
      PCI/MSI: Check for MSI enabled in __pci_msix_enable()
      iommu/vt-d: Remove bogus check for multi MSI-X
      iommu/amd: Remove bogus check for multi MSI-X
      genirq/msi: Use MSI_DESC_ALL in msi_add_simple_msi_descs()
      genirq/msi: Remove filter from msi_free_descs_free_range()
      genirq/msi: Add missing kernel doc to msi_next_desc()
      genirq/msi: Make __msi_domain_alloc_irqs() static
      genirq/msi: Provide msi_domain_ops:: Post_free()
      powerpc/pseries/msi: Use msi_domain_ops:: Msi_post_free()
      genirq/msi: Make __msi_domain_free_irqs() static
      genirq/irqdomain: Move bus token enum into a seperate header
      PCI/MSI: Get rid of PCI_MSI_IRQ_DOMAIN
      genirq: Get rid of GENERIC_MSI_IRQ_DOMAIN
      PCI/MSI: Sanitize MSI-X checks
      PCI/MSI: Reject multi-MSI early
      PCI/MSI: Reject MSI-X early
      PCI/MSI: Validate MSI-X contiguous restriction early
      PCI/MSI: Remove redundant msi_check() callback
      genirq/msi: Remove msi_domain_ops:: Msi_check()
      x86/apic: Remove X86_IRQ_ALLOC_CONTIGUOUS_VECTORS
      bus: fsl-mc: Remove linux/msi.h includes
      soc: fsl: dpio: Remove linux/msi.h include
      vfio/fsl-mc: Remove linux/msi.h include
      iommu/of: Remove linux/msi.h include
      genirq/msi: Move IRQ_DOMAIN_MSI_NOMASK_QUIRK to MSI flags
      genirq/irqdomain: Make struct irqdomain readable
      genirq/irqdomain: Rename irq_domain::dev to irq_domain:: Pm_dev
      genirq/msi: Create msi_api.h
      genirq/irqdomain: Provide IRQ_DOMAIN_FLAG_MSI_PARENT
      genirq/irqdomain: Provide IRQ_DOMAIN_FLAG_MSI_DEVICE
      genirq/msi: Check for invalid MSI parent domain usage
      genirq/msi: Move xarray into a separate struct and create an array
      genirq/msi: Add pointers for per device irq domains
      genirq/msi: Make MSI descriptor iterators device domain aware
      genirq/msi: Rename msi_add_msi_desc() to msi_insert_msi_desc()
      genirq/msi: Make descriptor allocation device domain aware
      genirq/msi: Make descriptor freeing domain aware
      genirq/msi: Make msi_add_simple_msi_descs() device domain aware
      genirq/msi: Provide new domain id based interfaces for freeing interrup=
ts
      genirq/msi: Provide new domain id allocation functions
      PCI/MSI: Use msi_domain_alloc/free_irqs_all_locked()
      bus: fsl-mc-msi: Switch to domain id aware interfaces
      genirq/msi: Remove unused alloc/free interfaces
      genirq/msi: Rearrange MSI domain flags
      genirq/msi: Provide struct msi_parent_ops
      genirq/msi: Provide data structs for per device domains
      genirq/msi: Add size info to struct msi_domain_info
      genirq/msi: Split msi_create_irq_domain()
      genirq/irqdomain: Add irq_domain:: Dev for per device MSI domains
      genirq/msi: Provide msi_create/free_device_irq_domain()
      genirq/msi: Provide msi_match_device_domain()
      genirq/msi: Add range checking to msi_insert_desc()
      PCI/MSI: Split __pci_write_msi_msg()
      genirq/msi: Provide BUS_DEVICE_PCI_MSI[X]
      PCI/MSI: Add support for per device MSI[X] domains
      x86/apic/vector: Provide MSI parent domain
      PCI/MSI: Remove unused pci_dev_has_special_msi_domain()
      iommu/vt-d: Switch to MSI parent domains
      iommu/amd: Switch to MSI base domains
      x86/apic/msi: Remove arch_create_remap_msi_irq_domain()
      genirq/msi: Provide struct msi_map
      genirq/msi: Provide msi_desc:: Msi_data
      genirq/msi: Provide msi_domain_ops:: Prepare_desc()
      genirq/msi: Provide msi_domain_alloc_irq_at()
      genirq/msi: Provide MSI_FLAG_MSIX_ALLOC_DYN
      PCI/MSI: Split MSI-X descriptor setup
      PCI/MSI: Provide prepare_desc() MSI domain op
      PCI/MSI: Provide post-enable dynamic allocation interfaces for MSI-X
      x86/apic/msi: Enable MSI_FLAG_PCI_MSIX_ALLOC_DYN
      genirq/msi: Provide constants for PCI/IMS support
      PCI/MSI: Provide IMS (Interrupt Message Store) support
      PCI/MSI: Provide pci_ims_alloc/free_irq()
      x86/apic/msi: Enable PCI/IMS
      iommu/vt-d: Enable PCI/IMS
      iommu/amd: Enable PCI/IMS
      irqchip/irq-mvebu-icu: Fix works by chance pointer assignment
      irqchip/gic-v2m: Include arm-gic-common.h
      irqchip/gic-v2m: Mark a few functions __init
      irqchip/ti-sci-inta: Fix kernel doc

Wei Yongjun (1):
      irqchip/wpcm450: Fix memory leak in wpcm450_aic_of_init()

Yang Yingliang (1):
      genirq/irqdesc: Don't try to remove non-existing sysfs files

wangjianli (1):
      irqchip/mips-gic: Drop repeated word in comment

ye xingchen (1):
      irqchip/st: Use device_get_match_data() to simplify the code


 Documentation/PCI/msi-howto.rst                    |   10 +
 .../loongarch,cpu-interrupt-controller.yaml        |   34 +
 .../interrupt-controller/mediatek,cirq.txt         |   33 -
 .../interrupt-controller/mediatek,mtk-cirq.yaml    |   68 ++
 arch/loongarch/include/asm/irq.h                   |    2 +-
 arch/powerpc/platforms/pseries/msi.c               |    7 +-
 arch/um/drivers/Kconfig                            |    1 -
 arch/um/include/asm/pci.h                          |    2 +-
 arch/x86/Kconfig                                   |    1 -
 arch/x86/include/asm/hyperv_timer.h                |    9 +
 arch/x86/include/asm/irq_remapping.h               |    4 -
 arch/x86/include/asm/irqdomain.h                   |    4 +-
 arch/x86/include/asm/mshyperv.h                    |    2 -
 arch/x86/include/asm/msi.h                         |    6 +
 arch/x86/include/asm/pci.h                         |    5 +-
 arch/x86/kernel/apic/msi.c                         |  211 ++--
 arch/x86/kernel/apic/vector.c                      |    4 -
 drivers/acpi/pci_irq.c                             |    6 +-
 drivers/base/Makefile                              |    2 +-
 drivers/base/platform-msi.c                        |    6 +-
 drivers/bus/fsl-mc/Kconfig                         |    2 +-
 drivers/bus/fsl-mc/dprc-driver.c                   |    1 -
 drivers/bus/fsl-mc/fsl-mc-bus.c                    |    1 -
 drivers/bus/fsl-mc/fsl-mc-msi.c                    |   25 +-
 drivers/dma/Kconfig                                |    2 +-
 drivers/dma/qcom/hidma.c                           |    8 +-
 drivers/hv/vmbus_drv.c                             |    1 +
 drivers/iommu/Kconfig                              |    2 +-
 drivers/iommu/amd/amd_iommu_types.h                |    1 -
 drivers/iommu/amd/iommu.c                          |   44 +-
 drivers/iommu/intel/iommu.h                        |    1 -
 drivers/iommu/intel/irq_remapping.c                |   52 +-
 drivers/iommu/of_iommu.c                           |    1 -
 drivers/irqchip/Kconfig                            |    9 +-
 drivers/irqchip/irq-apple-aic.c                    |    6 +-
 drivers/irqchip/irq-gic-pm.c                       |    2 +-
 drivers/irqchip/irq-gic-v2m.c                      |   11 +-
 drivers/irqchip/irq-gic-v3.c                       |    3 +-
 drivers/irqchip/irq-gic.c                          |    7 +-
 drivers/irqchip/irq-loongarch-cpu.c                |   48 +-
 drivers/irqchip/irq-loongson-eiointc.c             |   63 +-
 drivers/irqchip/irq-loongson-htvec.c               |  176 +++-
 drivers/irqchip/irq-loongson-liointc.c             |   37 +-
 drivers/irqchip/irq-loongson-pch-lpc.c             |   25 +
 drivers/irqchip/irq-loongson-pch-pic.c             |   76 +-
 drivers/irqchip/irq-ls-extirq.c                    |    2 +-
 drivers/irqchip/irq-mips-gic.c                     |    2 +-
 drivers/irqchip/irq-mtk-cirq.c                     |   95 +-
 drivers/irqchip/irq-mvebu-icu.c                    |    4 +-
 drivers/irqchip/irq-sifive-plic.c                  |    6 +-
 drivers/irqchip/irq-sl28cpld.c                     |    3 +-
 drivers/irqchip/irq-st.c                           |    7 +-
 drivers/irqchip/irq-ti-sci-inta.c                  |    2 +-
 drivers/irqchip/irq-wpcm450-aic.c                  |    1 +
 drivers/mailbox/Kconfig                            |    2 +-
 drivers/pci/Kconfig                                |    7 +-
 drivers/pci/controller/Kconfig                     |   30 +-
 drivers/pci/controller/dwc/Kconfig                 |   48 +-
 drivers/pci/controller/mobiveil/Kconfig            |    6 +-
 drivers/pci/controller/pci-hyperv.c                |   15 +-
 drivers/pci/msi/Makefile                           |    3 +-
 drivers/pci/msi/api.c                              |  458 ++++++++
 drivers/pci/msi/irqdomain.c                        |  369 +++++--
 drivers/pci/msi/msi.c                              | 1100 ++++++++----------=
--
 drivers/pci/msi/msi.h                              |  114 +-
 drivers/pci/probe.c                                |    2 -
 drivers/perf/Kconfig                               |    2 +-
 drivers/soc/fsl/dpio/dpio-driver.c                 |    1 -
 drivers/soc/ti/Kconfig                             |    2 +-
 drivers/soc/ti/ti_sci_inta_msi.c                   |   12 +-
 drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c             |    1 -
 include/asm-generic/msi.h                          |    4 +-
 include/clocksource/hyperv_timer.h                 |    4 +-
 include/linux/device.h                             |    8 +-
 include/linux/gpio/driver.h                        |    2 +-
 include/linux/irqdomain.h                          |  143 +--
 include/linux/irqdomain_defs.h                     |   31 +
 include/linux/irqreturn.h                          |    8 +-
 include/linux/msi.h                                |  357 +++++--
 include/linux/msi_api.h                            |   73 ++
 include/linux/pci.h                                |   29 +-
 kernel/irq/Kconfig                                 |    7 +-
 kernel/irq/chip.c                                  |    8 +-
 kernel/irq/internals.h                             |    2 +
 kernel/irq/irqdesc.c                               |   15 +-
 kernel/irq/manage.c                                |    4 +-
 kernel/irq/msi.c                                   |  914 +++++++++++++---
 87 files changed, 3388 insertions(+), 1536 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/lo=
ongarch,cpu-interrupt-controller.yaml
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/me=
diatek,cirq.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/me=
diatek,mtk-cirq.yaml
 create mode 100644 arch/x86/include/asm/hyperv_timer.h
 create mode 100644 drivers/pci/msi/api.c
 create mode 100644 include/linux/irqdomain_defs.h
 create mode 100644 include/linux/msi_api.h

diff --git a/Documentation/PCI/msi-howto.rst b/Documentation/PCI/msi-howto.rst
index aa2046af69f7..8ae461e97c54 100644
--- a/Documentation/PCI/msi-howto.rst
+++ b/Documentation/PCI/msi-howto.rst
@@ -285,3 +285,13 @@ to bridges between the PCI root and the device, MSIs are=
 disabled.
 It is also worth checking the device driver to see whether it supports MSIs.
 For example, it may contain calls to pci_alloc_irq_vectors() with the
 PCI_IRQ_MSI or PCI_IRQ_MSIX flags.
+
+
+List of device drivers MSI(-X) APIs
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The PCI/MSI subystem has a dedicated C file for its exported device driver
+APIs =E2=80=94 `drivers/pci/msi/api.c`. The following functions are exported:
+
+.. kernel-doc:: drivers/pci/msi/api.c
+   :export:
diff --git a/Documentation/devicetree/bindings/interrupt-controller/loongarch=
,cpu-interrupt-controller.yaml b/Documentation/devicetree/bindings/interrupt-=
controller/loongarch,cpu-interrupt-controller.yaml
new file mode 100644
index 000000000000..2a1cf885c99d
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/loongarch,cpu-in=
terrupt-controller.yaml
@@ -0,0 +1,34 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/loongarch,cpu-interr=
upt-controller.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LoongArch CPU Interrupt Controller
+
+maintainers:
+  - Liu Peibao <liupeibao@loongson.cn>
+
+properties:
+  compatible:
+    const: loongarch,cpu-interrupt-controller
+
+  '#interrupt-cells':
+    const: 1
+
+  interrupt-controller: true
+
+additionalProperties: false
+
+required:
+  - compatible
+  - '#interrupt-cells'
+  - interrupt-controller
+
+examples:
+  - |
+    interrupt-controller {
+      compatible =3D "loongarch,cpu-interrupt-controller";
+      #interrupt-cells =3D <1>;
+      interrupt-controller;
+    };
diff --git a/Documentation/devicetree/bindings/interrupt-controller/mediatek,=
cirq.txt b/Documentation/devicetree/bindings/interrupt-controller/mediatek,ci=
rq.txt
deleted file mode 100644
index 5865f4f2c69d..000000000000
--- a/Documentation/devicetree/bindings/interrupt-controller/mediatek,cirq.txt
+++ /dev/null
@@ -1,33 +0,0 @@
-* Mediatek 27xx cirq
-
-In Mediatek SOCs, the CIRQ is a low power interrupt controller designed to
-work outside MCUSYS which comprises with Cortex-Ax cores,CCI and GIC.
-The external interrupts (outside MCUSYS) will feed through CIRQ and connect
-to GIC in MCUSYS. When CIRQ is enabled, it will record the edge-sensitive
-interrupts and generate a pulse signal to parent interrupt controller when
-flush command is executed. With CIRQ, MCUSYS can be completely turned off
-to improve the system power consumption without losing interrupts.
-
-Required properties:
-- compatible: should be one of
-  - "mediatek,mt2701-cirq" for mt2701 CIRQ
-  - "mediatek,mt8135-cirq" for mt8135 CIRQ
-  - "mediatek,mt8173-cirq" for mt8173 CIRQ
-  and "mediatek,cirq" as a fallback.
-- interrupt-controller : Identifies the node as an interrupt controller.
-- #interrupt-cells : Use the same format as specified by GIC in arm,gic.txt.
-- reg: Physical base address of the cirq registers and length of memory
-  mapped region.
-- mediatek,ext-irq-range: Identifies external irq number range in different
-  SOCs.
-
-Example:
-	cirq: interrupt-controller@10204000 {
-		compatible =3D "mediatek,mt2701-cirq",
-			     "mediatek,mtk-cirq";
-		interrupt-controller;
-		#interrupt-cells =3D <3>;
-		interrupt-parent =3D <&sysirq>;
-		reg =3D <0 0x10204000 0 0x400>;
-		mediatek,ext-irq-start =3D <32 200>;
-	};
diff --git a/Documentation/devicetree/bindings/interrupt-controller/mediatek,=
mtk-cirq.yaml b/Documentation/devicetree/bindings/interrupt-controller/mediat=
ek,mtk-cirq.yaml
new file mode 100644
index 000000000000..fdcb4d8db818
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/mediatek,mtk-cir=
q.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/mediatek,mtk-cirq.ya=
ml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek System Interrupt Controller
+
+maintainers:
+  - Youlin Pei <youlin.pei@mediatek.com>
+
+description:
+  In MediaTek SoCs, the CIRQ is a low power interrupt controller designed to
+  work outside of MCUSYS which comprises with Cortex-Ax cores, CCI and GIC.
+  The external interrupts (outside MCUSYS) will feed through CIRQ and connect
+  to GIC in MCUSYS. When CIRQ is enabled, it will record the edge-sensitive
+  interrupts and generate a pulse signal to parent interrupt controller when
+  flush command is executed. With CIRQ, MCUSYS can be completely turned off
+  to improve the system power consumption without losing interrupts.
+
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - mediatek,mt2701-cirq
+          - mediatek,mt8135-cirq
+          - mediatek,mt8173-cirq
+          - mediatek,mt8192-cirq
+      - const: mediatek,mtk-cirq
+
+  reg:
+    maxItems: 1
+
+  '#interrupt-cells':
+    const: 3
+
+  interrupt-controller: true
+
+  mediatek,ext-irq-range:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    items:
+      - description: First CIRQ interrupt
+      - description: Last CIRQ interrupt
+    description:
+      Identifies the range of external interrupts in different SoCs
+
+required:
+  - compatible
+  - reg
+  - '#interrupt-cells'
+  - interrupt-controller
+  - mediatek,ext-irq-range
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    cirq: interrupt-controller@10204000 {
+        compatible =3D "mediatek,mt2701-cirq", "mediatek,mtk-cirq";
+        reg =3D <0x10204000 0x400>;
+        #interrupt-cells =3D <3>;
+        interrupt-controller;
+        interrupt-parent =3D <&sysirq>;
+        mediatek,ext-irq-range =3D <32 200>;
+    };
diff --git a/arch/loongarch/include/asm/irq.h b/arch/loongarch/include/asm/ir=
q.h
index d06d4542b634..9d3d36e41afe 100644
--- a/arch/loongarch/include/asm/irq.h
+++ b/arch/loongarch/include/asm/irq.h
@@ -93,7 +93,7 @@ int liointc_acpi_init(struct irq_domain *parent,
 int eiointc_acpi_init(struct irq_domain *parent,
 					struct acpi_madt_eio_pic *acpi_eiointc);
=20
-struct irq_domain *htvec_acpi_init(struct irq_domain *parent,
+int htvec_acpi_init(struct irq_domain *parent,
 					struct acpi_madt_ht_pic *acpi_htvec);
 int pch_lpc_acpi_init(struct irq_domain *parent,
 					struct acpi_madt_lpc_pic *acpi_pchlpc);
diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/ps=
eries/msi.c
index a3a71d37cb9a..3f05507e444d 100644
--- a/arch/powerpc/platforms/pseries/msi.c
+++ b/arch/powerpc/platforms/pseries/msi.c
@@ -447,21 +447,18 @@ static void pseries_msi_ops_msi_free(struct irq_domain =
*domain,
  * RTAS can not disable one MSI at a time. It's all or nothing. Do it
  * at the end after all IRQs have been freed.
  */
-static void pseries_msi_domain_free_irqs(struct irq_domain *domain,
-					 struct device *dev)
+static void pseries_msi_post_free(struct irq_domain *domain, struct device *=
dev)
 {
 	if (WARN_ON_ONCE(!dev_is_pci(dev)))
 		return;
=20
-	__msi_domain_free_irqs(domain, dev);
-
 	rtas_disable_msi(to_pci_dev(dev));
 }
=20
 static struct msi_domain_ops pseries_pci_msi_domain_ops =3D {
 	.msi_prepare	=3D pseries_msi_ops_prepare,
 	.msi_free	=3D pseries_msi_ops_msi_free,
-	.domain_free_irqs =3D pseries_msi_domain_free_irqs,
+	.msi_post_free	=3D pseries_msi_post_free,
 };
=20
 static void pseries_msi_shutdown(struct irq_data *d)
diff --git a/arch/um/drivers/Kconfig b/arch/um/drivers/Kconfig
index 5903e2b598aa..a4f0a19fbe14 100644
--- a/arch/um/drivers/Kconfig
+++ b/arch/um/drivers/Kconfig
@@ -381,7 +381,6 @@ config UML_PCI_OVER_VIRTIO
 	select UML_IOMEM_EMULATION
 	select UML_DMA_EMULATION
 	select PCI_MSI
-	select PCI_MSI_IRQ_DOMAIN
 	select PCI_LOCKLESS_CONFIG
=20
 config UML_PCI_OVER_VIRTIO_DEVICE_ID
diff --git a/arch/um/include/asm/pci.h b/arch/um/include/asm/pci.h
index 34fe4921b5fa..238d2e7faff8 100644
--- a/arch/um/include/asm/pci.h
+++ b/arch/um/include/asm/pci.h
@@ -7,7 +7,7 @@
 /* Generic PCI */
 #include <asm-generic/pci.h>
=20
-#ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
+#ifdef CONFIG_PCI_MSI
 /*
  * This is a bit of an annoying hack, and it assumes we only have
  * the virt-pci (if anything). Which is true, but still.
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 67745ceab0db..64f81a10bfc8 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1109,7 +1109,6 @@ config X86_LOCAL_APIC
 	def_bool y
 	depends on X86_64 || SMP || X86_32_NON_STANDARD || X86_UP_APIC || PCI_MSI
 	select IRQ_DOMAIN_HIERARCHY
-	select PCI_MSI_IRQ_DOMAIN if PCI_MSI
=20
 config X86_IO_APIC
 	def_bool y
diff --git a/arch/x86/include/asm/hyperv_timer.h b/arch/x86/include/asm/hyper=
v_timer.h
new file mode 100644
index 000000000000..388fa81b8f38
--- /dev/null
+++ b/arch/x86/include/asm/hyperv_timer.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_HYPERV_TIMER_H
+#define _ASM_X86_HYPERV_TIMER_H
+
+#include <asm/msr.h>
+
+#define hv_get_raw_timer() rdtsc_ordered()
+
+#endif
diff --git a/arch/x86/include/asm/irq_remapping.h b/arch/x86/include/asm/irq_=
remapping.h
index 7cc49432187f..7a2ed154a5e1 100644
--- a/arch/x86/include/asm/irq_remapping.h
+++ b/arch/x86/include/asm/irq_remapping.h
@@ -44,10 +44,6 @@ extern int irq_remapping_reenable(int);
 extern int irq_remap_enable_fault_handling(void);
 extern void panic_if_irq_remap(const char *msg);
=20
-/* Create PCI MSI/MSIx irqdomain, use @parent as the parent irqdomain. */
-extern struct irq_domain *
-arch_create_remap_msi_irq_domain(struct irq_domain *par, const char *n, int =
id);
-
 /* Get parent irqdomain for interrupt remapping irqdomain */
 static inline struct irq_domain *arch_get_ir_parent_domain(void)
 {
diff --git a/arch/x86/include/asm/irqdomain.h b/arch/x86/include/asm/irqdomai=
n.h
index 125c23b7bad3..30c325c235c0 100644
--- a/arch/x86/include/asm/irqdomain.h
+++ b/arch/x86/include/asm/irqdomain.h
@@ -7,9 +7,7 @@
=20
 #ifdef CONFIG_X86_LOCAL_APIC
 enum {
-	/* Allocate contiguous CPU vectors */
-	X86_IRQ_ALLOC_CONTIGUOUS_VECTORS		=3D 0x1,
-	X86_IRQ_ALLOC_LEGACY				=3D 0x2,
+	X86_IRQ_ALLOC_LEGACY				=3D 0x1,
 };
=20
 extern int x86_fwspec_is_ioapic(struct irq_fwspec *fwspec);
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 61f0c206bff0..6d502f3efb0f 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -19,8 +19,6 @@ typedef int (*hyperv_fill_flush_list_func)(
 		struct hv_guest_mapping_flush_list *flush,
 		void *data);
=20
-#define hv_get_raw_timer() rdtsc_ordered()
-
 void hyperv_vector_handler(struct pt_regs *regs);
=20
 #if IS_ENABLED(CONFIG_HYPERV)
diff --git a/arch/x86/include/asm/msi.h b/arch/x86/include/asm/msi.h
index d71c7e8b738d..935c6d470341 100644
--- a/arch/x86/include/asm/msi.h
+++ b/arch/x86/include/asm/msi.h
@@ -62,4 +62,10 @@ typedef struct x86_msi_addr_hi {
 struct msi_msg;
 u32 x86_msi_msg_get_destid(struct msi_msg *msg, bool extid);
=20
+#define X86_VECTOR_MSI_FLAGS_SUPPORTED					\
+	(MSI_GENERIC_FLAGS_MASK | MSI_FLAG_PCI_MSIX | MSI_FLAG_PCI_MSIX_ALLOC_DYN)
+
+#define X86_VECTOR_MSI_FLAGS_REQUIRED					\
+	(MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS)
+
 #endif /* _ASM_X86_MSI_H */
diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
index 736793d65bcb..b40c462b4af3 100644
--- a/arch/x86/include/asm/pci.h
+++ b/arch/x86/include/asm/pci.h
@@ -21,7 +21,7 @@ struct pci_sysdata {
 #ifdef CONFIG_X86_64
 	void		*iommu;		/* IOMMU private data */
 #endif
-#ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
+#ifdef CONFIG_PCI_MSI
 	void		*fwnode;	/* IRQ domain for MSI assignment */
 #endif
 #if IS_ENABLED(CONFIG_VMD)
@@ -52,7 +52,7 @@ static inline int pci_proc_domain(struct pci_bus *bus)
 }
 #endif
=20
-#ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
+#ifdef CONFIG_PCI_MSI
 static inline void *_pci_root_bus_fwnode(struct pci_bus *bus)
 {
 	return to_pci_sysdata(bus)->fwnode;
@@ -92,6 +92,7 @@ void pcibios_scan_root(int bus);
 struct irq_routing_table *pcibios_get_irq_routing_table(void);
 int pcibios_set_irq_routing(struct pci_dev *dev, int pin, int irq);
=20
+bool pci_dev_has_default_msi_parent_domain(struct pci_dev *dev);
=20
 #define HAVE_PCI_MMAP
 #define arch_can_pci_mmap_wc()	pat_enabled()
diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index 7517eb05bdc1..35d5b8fb18ef 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -142,70 +142,139 @@ msi_set_affinity(struct irq_data *irqd, const struct c=
pumask *mask, bool force)
 	return ret;
 }
=20
-/*
- * IRQ Chip for MSI PCI/PCI-X/PCI-Express Devices,
- * which implement the MSI or MSI-X Capability Structure.
+/**
+ * pci_dev_has_default_msi_parent_domain - Check whether the device has the =
default
+ *					   MSI parent domain associated
+ * @dev:	Pointer to the PCI device
  */
-static struct irq_chip pci_msi_controller =3D {
-	.name			=3D "PCI-MSI",
-	.irq_unmask		=3D pci_msi_unmask_irq,
-	.irq_mask		=3D pci_msi_mask_irq,
-	.irq_ack		=3D irq_chip_ack_parent,
-	.irq_retrigger		=3D irq_chip_retrigger_hierarchy,
-	.irq_set_affinity	=3D msi_set_affinity,
-	.flags			=3D IRQCHIP_SKIP_SET_WAKE |
-				  IRQCHIP_AFFINITY_PRE_STARTUP,
-};
+bool pci_dev_has_default_msi_parent_domain(struct pci_dev *dev)
+{
+	struct irq_domain *domain =3D dev_get_msi_domain(&dev->dev);
=20
-int pci_msi_prepare(struct irq_domain *domain, struct device *dev, int nvec,
-		    msi_alloc_info_t *arg)
+	if (!domain)
+		domain =3D dev_get_msi_domain(&dev->bus->dev);
+	if (!domain)
+		return false;
+
+	return domain =3D=3D x86_vector_domain;
+}
+
+/**
+ * x86_msi_prepare - Setup of msi_alloc_info_t for allocations
+ * @domain:	The domain for which this setup happens
+ * @dev:	The device for which interrupts are allocated
+ * @nvec:	The number of vectors to allocate
+ * @alloc:	The allocation info structure to initialize
+ *
+ * This function is to be used for all types of MSI domains above the x86
+ * vector domain and any intermediates. It is always invoked from the
+ * top level interrupt domain. The domain specific allocation
+ * functionality is determined via the @domain's bus token which allows to
+ * map the X86 specific allocation type.
+ */
+static int x86_msi_prepare(struct irq_domain *domain, struct device *dev,
+			   int nvec, msi_alloc_info_t *alloc)
 {
-	init_irq_alloc_info(arg, NULL);
-	if (to_pci_dev(dev)->msix_enabled) {
-		arg->type =3D X86_IRQ_ALLOC_TYPE_PCI_MSIX;
-	} else {
-		arg->type =3D X86_IRQ_ALLOC_TYPE_PCI_MSI;
-		arg->flags |=3D X86_IRQ_ALLOC_CONTIGUOUS_VECTORS;
+	struct msi_domain_info *info =3D domain->host_data;
+
+	init_irq_alloc_info(alloc, NULL);
+
+	switch (info->bus_token) {
+	case DOMAIN_BUS_PCI_DEVICE_MSI:
+		alloc->type =3D X86_IRQ_ALLOC_TYPE_PCI_MSI;
+		return 0;
+	case DOMAIN_BUS_PCI_DEVICE_MSIX:
+	case DOMAIN_BUS_PCI_DEVICE_IMS:
+		alloc->type =3D X86_IRQ_ALLOC_TYPE_PCI_MSIX;
+		return 0;
+	default:
+		return -EINVAL;
 	}
-
-	return 0;
 }
-EXPORT_SYMBOL_GPL(pci_msi_prepare);
=20
-static struct msi_domain_ops pci_msi_domain_ops =3D {
-	.msi_prepare	=3D pci_msi_prepare,
-};
+/**
+ * x86_init_dev_msi_info - Domain info setup for MSI domains
+ * @dev:		The device for which the domain should be created
+ * @domain:		The (root) domain providing this callback
+ * @real_parent:	The real parent domain of the to initialize domain
+ * @info:		The domain info for the to initialize domain
+ *
+ * This function is to be used for all types of MSI domains above the x86
+ * vector domain and any intermediates. The domain specific functionality
+ * is determined via the @real_parent.
+ */
+static bool x86_init_dev_msi_info(struct device *dev, struct irq_domain *dom=
ain,
+				  struct irq_domain *real_parent, struct msi_domain_info *info)
+{
+	const struct msi_parent_ops *pops =3D real_parent->msi_parent_ops;
+
+	/* MSI parent domain specific settings */
+	switch (real_parent->bus_token) {
+	case DOMAIN_BUS_ANY:
+		/* Only the vector domain can have the ANY token */
+		if (WARN_ON_ONCE(domain !=3D real_parent))
+			return false;
+		info->chip->irq_set_affinity =3D msi_set_affinity;
+		/* See msi_set_affinity() for the gory details */
+		info->flags |=3D MSI_FLAG_NOMASK_QUIRK;
+		break;
+	case DOMAIN_BUS_DMAR:
+	case DOMAIN_BUS_AMDVI:
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		return false;
+	}
+
+	/* Is the target supported? */
+	switch(info->bus_token) {
+	case DOMAIN_BUS_PCI_DEVICE_MSI:
+	case DOMAIN_BUS_PCI_DEVICE_MSIX:
+		break;
+	case DOMAIN_BUS_PCI_DEVICE_IMS:
+		if (!(pops->supported_flags & MSI_FLAG_PCI_IMS))
+			return false;
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		return false;
+	}
+
+	/*
+	 * Mask out the domain specific MSI feature flags which are not
+	 * supported by the real parent.
+	 */
+	info->flags			&=3D pops->supported_flags;
+	/* Enforce the required flags */
+	info->flags			|=3D X86_VECTOR_MSI_FLAGS_REQUIRED;
+
+	/* This is always invoked from the top level MSI domain! */
+	info->ops->msi_prepare		=3D x86_msi_prepare;
+
+	info->chip->irq_ack		=3D irq_chip_ack_parent;
+	info->chip->irq_retrigger	=3D irq_chip_retrigger_hierarchy;
+	info->chip->flags		|=3D IRQCHIP_SKIP_SET_WAKE |
+					   IRQCHIP_AFFINITY_PRE_STARTUP;
=20
-static struct msi_domain_info pci_msi_domain_info =3D {
-	.flags		=3D MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-			  MSI_FLAG_PCI_MSIX,
-	.ops		=3D &pci_msi_domain_ops,
-	.chip		=3D &pci_msi_controller,
-	.handler	=3D handle_edge_irq,
-	.handler_name	=3D "edge",
+	info->handler			=3D handle_edge_irq;
+	info->handler_name		=3D "edge";
+
+	return true;
+}
+
+static const struct msi_parent_ops x86_vector_msi_parent_ops =3D {
+	.supported_flags	=3D X86_VECTOR_MSI_FLAGS_SUPPORTED,
+	.init_dev_msi_info	=3D x86_init_dev_msi_info,
 };
=20
 struct irq_domain * __init native_create_pci_msi_domain(void)
 {
-	struct fwnode_handle *fn;
-	struct irq_domain *d;
-
 	if (disable_apic)
 		return NULL;
=20
-	fn =3D irq_domain_alloc_named_fwnode("PCI-MSI");
-	if (!fn)
-		return NULL;
-
-	d =3D pci_msi_create_irq_domain(fn, &pci_msi_domain_info,
-				      x86_vector_domain);
-	if (!d) {
-		irq_domain_free_fwnode(fn);
-		pr_warn("Failed to initialize PCI-MSI irqdomain.\n");
-	} else {
-		d->flags |=3D IRQ_DOMAIN_MSI_NOMASK_QUIRK;
-	}
-	return d;
+	x86_vector_domain->flags |=3D IRQ_DOMAIN_FLAG_MSI_PARENT;
+	x86_vector_domain->msi_parent_ops =3D &x86_vector_msi_parent_ops;
+	return x86_vector_domain;
 }
=20
 void __init x86_create_pci_msi_domain(void)
@@ -213,41 +282,19 @@ void __init x86_create_pci_msi_domain(void)
 	x86_pci_msi_default_domain =3D x86_init.irqs.create_pci_msi_domain();
 }
=20
-#ifdef CONFIG_IRQ_REMAP
-static struct irq_chip pci_msi_ir_controller =3D {
-	.name			=3D "IR-PCI-MSI",
-	.irq_unmask		=3D pci_msi_unmask_irq,
-	.irq_mask		=3D pci_msi_mask_irq,
-	.irq_ack		=3D irq_chip_ack_parent,
-	.irq_retrigger		=3D irq_chip_retrigger_hierarchy,
-	.flags			=3D IRQCHIP_SKIP_SET_WAKE |
-				  IRQCHIP_AFFINITY_PRE_STARTUP,
-};
-
-static struct msi_domain_info pci_msi_ir_domain_info =3D {
-	.flags		=3D MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-			  MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX,
-	.ops		=3D &pci_msi_domain_ops,
-	.chip		=3D &pci_msi_ir_controller,
-	.handler	=3D handle_edge_irq,
-	.handler_name	=3D "edge",
-};
-
-struct irq_domain *arch_create_remap_msi_irq_domain(struct irq_domain *paren=
t,
-						    const char *name, int id)
+/* Keep around for hyperV */
+int pci_msi_prepare(struct irq_domain *domain, struct device *dev, int nvec,
+		    msi_alloc_info_t *arg)
 {
-	struct fwnode_handle *fn;
-	struct irq_domain *d;
+	init_irq_alloc_info(arg, NULL);
=20
-	fn =3D irq_domain_alloc_named_id_fwnode(name, id);
-	if (!fn)
-		return NULL;
-	d =3D pci_msi_create_irq_domain(fn, &pci_msi_ir_domain_info, parent);
-	if (!d)
-		irq_domain_free_fwnode(fn);
-	return d;
+	if (to_pci_dev(dev)->msix_enabled)
+		arg->type =3D X86_IRQ_ALLOC_TYPE_PCI_MSIX;
+	else
+		arg->type =3D X86_IRQ_ALLOC_TYPE_PCI_MSI;
+	return 0;
 }
-#endif
+EXPORT_SYMBOL_GPL(pci_msi_prepare);
=20
 #ifdef CONFIG_DMAR_TABLE
 /*
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 3e6f6b448f6a..c1efebd27e6c 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -539,10 +539,6 @@ static int x86_vector_alloc_irqs(struct irq_domain *doma=
in, unsigned int virq,
 	if (disable_apic)
 		return -ENXIO;
=20
-	/* Currently vector allocator can't guarantee contiguous allocations */
-	if ((info->flags & X86_IRQ_ALLOC_CONTIGUOUS_VECTORS) && nr_irqs > 1)
-		return -ENOSYS;
-
 	/*
 	 * Catch any attempt to touch the cascade interrupt on a PIC
 	 * equipped system.
diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index 08e15774fb9f..ff30ceca2203 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -387,13 +387,15 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
 	u8 pin;
 	int triggering =3D ACPI_LEVEL_SENSITIVE;
 	/*
-	 * On ARM systems with the GIC interrupt model, level interrupts
+	 * On ARM systems with the GIC interrupt model, or LoongArch
+	 * systems with the LPIC interrupt model, level interrupts
 	 * are always polarity high by specification; PCI legacy
 	 * IRQs lines are inverted before reaching the interrupt
 	 * controller and must therefore be considered active high
 	 * as default.
 	 */
-	int polarity =3D acpi_irq_model =3D=3D ACPI_IRQ_MODEL_GIC ?
+	int polarity =3D acpi_irq_model =3D=3D ACPI_IRQ_MODEL_GIC ||
+		       acpi_irq_model =3D=3D ACPI_IRQ_MODEL_LPIC ?
 				      ACPI_ACTIVE_HIGH : ACPI_ACTIVE_LOW;
 	char *link =3D NULL;
 	char link_desc[16];
diff --git a/drivers/base/Makefile b/drivers/base/Makefile
index 83217d243c25..3079bfe53d04 100644
--- a/drivers/base/Makefile
+++ b/drivers/base/Makefile
@@ -22,7 +22,7 @@ obj-$(CONFIG_REGMAP)	+=3D regmap/
 obj-$(CONFIG_SOC_BUS) +=3D soc.o
 obj-$(CONFIG_PINCTRL) +=3D pinctrl.o
 obj-$(CONFIG_DEV_COREDUMP) +=3D devcoredump.o
-obj-$(CONFIG_GENERIC_MSI_IRQ_DOMAIN) +=3D platform-msi.o
+obj-$(CONFIG_GENERIC_MSI_IRQ) +=3D platform-msi.o
 obj-$(CONFIG_GENERIC_ARCH_TOPOLOGY) +=3D arch_topology.o
 obj-$(CONFIG_GENERIC_ARCH_NUMA) +=3D arch_numa.o
 obj-$(CONFIG_ACPI) +=3D physical_location.o
diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
index 12b044151298..5883e7634a2b 100644
--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -213,7 +213,7 @@ int platform_msi_domain_alloc_irqs(struct device *dev, un=
signed int nvec,
 	if (err)
 		return err;
=20
-	err =3D msi_domain_alloc_irqs(dev->msi.domain, dev, nvec);
+	err =3D msi_domain_alloc_irqs_range(dev, MSI_DEFAULT_DOMAIN, 0, nvec - 1);
 	if (err)
 		platform_msi_free_priv_data(dev);
=20
@@ -227,7 +227,7 @@ EXPORT_SYMBOL_GPL(platform_msi_domain_alloc_irqs);
  */
 void platform_msi_domain_free_irqs(struct device *dev)
 {
-	msi_domain_free_irqs(dev->msi.domain, dev);
+	msi_domain_free_irqs_all(dev, MSI_DEFAULT_DOMAIN);
 	platform_msi_free_priv_data(dev);
 }
 EXPORT_SYMBOL_GPL(platform_msi_domain_free_irqs);
@@ -325,7 +325,7 @@ void platform_msi_device_domain_free(struct irq_domain *d=
omain, unsigned int vir
=20
 	msi_lock_descs(data->dev);
 	irq_domain_free_irqs_common(domain, virq, nr_irqs);
-	msi_free_msi_descs_range(data->dev, MSI_DESC_ALL, virq, virq + nr_irqs - 1);
+	msi_free_msi_descs_range(data->dev, virq, virq + nr_irqs - 1);
 	msi_unlock_descs(data->dev);
 }
=20
diff --git a/drivers/bus/fsl-mc/Kconfig b/drivers/bus/fsl-mc/Kconfig
index b1fd55901c50..9492342e7d13 100644
--- a/drivers/bus/fsl-mc/Kconfig
+++ b/drivers/bus/fsl-mc/Kconfig
@@ -8,7 +8,7 @@
 config FSL_MC_BUS
 	bool "QorIQ DPAA2 fsl-mc bus driver"
 	depends on OF && (ARCH_LAYERSCAPE || (COMPILE_TEST && (ARM || ARM64 || X86_=
LOCAL_APIC || PPC)))
-	select GENERIC_MSI_IRQ_DOMAIN
+	select GENERIC_MSI_IRQ
 	help
 	  Driver to enable the bus infrastructure for the QorIQ DPAA2
 	  architecture.  The fsl-mc bus driver handles discovery of
diff --git a/drivers/bus/fsl-mc/dprc-driver.c b/drivers/bus/fsl-mc/dprc-drive=
r.c
index 5e70f9775a0e..4c84be378bf2 100644
--- a/drivers/bus/fsl-mc/dprc-driver.c
+++ b/drivers/bus/fsl-mc/dprc-driver.c
@@ -11,7 +11,6 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
-#include <linux/msi.h>
 #include <linux/fsl/mc.h>
=20
 #include "fsl-mc-private.h"
diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 6143dbf31f31..774f307844b4 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -17,7 +17,6 @@
 #include <linux/slab.h>
 #include <linux/limits.h>
 #include <linux/bitops.h>
-#include <linux/msi.h>
 #include <linux/dma-mapping.h>
 #include <linux/acpi.h>
 #include <linux/iommu.h>
diff --git a/drivers/bus/fsl-mc/fsl-mc-msi.c b/drivers/bus/fsl-mc/fsl-mc-msi.c
index 0cfe859a4ac4..f3f8af9426c9 100644
--- a/drivers/bus/fsl-mc/fsl-mc-msi.c
+++ b/drivers/bus/fsl-mc/fsl-mc-msi.c
@@ -213,21 +213,8 @@ struct irq_domain *fsl_mc_find_msi_domain(struct device =
*dev)
=20
 int fsl_mc_msi_domain_alloc_irqs(struct device *dev,  unsigned int irq_count)
 {
-	struct irq_domain *msi_domain;
-	int error;
-
-	msi_domain =3D dev_get_msi_domain(dev);
-	if (!msi_domain)
-		return -EINVAL;
-
-	error =3D msi_setup_device_data(dev);
-	if (error)
-		return error;
+	int error =3D msi_setup_device_data(dev);
=20
-	msi_lock_descs(dev);
-	if (msi_first_desc(dev, MSI_DESC_ALL))
-		error =3D -EINVAL;
-	msi_unlock_descs(dev);
 	if (error)
 		return error;
=20
@@ -235,7 +222,7 @@ int fsl_mc_msi_domain_alloc_irqs(struct device *dev,  uns=
igned int irq_count)
 	 * NOTE: Calling this function will trigger the invocation of the
 	 * its_fsl_mc_msi_prepare() callback
 	 */
-	error =3D msi_domain_alloc_irqs(msi_domain, dev, irq_count);
+	error =3D msi_domain_alloc_irqs_range(dev, MSI_DEFAULT_DOMAIN, 0, irq_count=
 - 1);
=20
 	if (error)
 		dev_err(dev, "Failed to allocate IRQs\n");
@@ -244,11 +231,5 @@ int fsl_mc_msi_domain_alloc_irqs(struct device *dev,  un=
signed int irq_count)
=20
 void fsl_mc_msi_domain_free_irqs(struct device *dev)
 {
-	struct irq_domain *msi_domain;
-
-	msi_domain =3D dev_get_msi_domain(dev);
-	if (!msi_domain)
-		return;
-
-	msi_domain_free_irqs(msi_domain, dev);
+	msi_domain_free_irqs_all(dev, MSI_DEFAULT_DOMAIN);
 }
diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 7524b62a8870..25e111ab21f8 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -462,7 +462,7 @@ config MV_XOR_V2
 	select DMA_ENGINE
 	select DMA_ENGINE_RAID
 	select ASYNC_TX_ENABLE_CHANNEL_SWITCH
-	select GENERIC_MSI_IRQ_DOMAIN
+	select GENERIC_MSI_IRQ
 	help
 	  Enable support for the Marvell version 2 XOR engine.
=20
diff --git a/drivers/dma/qcom/hidma.c b/drivers/dma/qcom/hidma.c
index 210f1a9eb441..04d1c33afc12 100644
--- a/drivers/dma/qcom/hidma.c
+++ b/drivers/dma/qcom/hidma.c
@@ -610,7 +610,7 @@ static irqreturn_t hidma_chirq_handler(int chirq, void *a=
rg)
 	return hidma_ll_inthandler(chirq, lldev);
 }
=20
-#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
+#ifdef CONFIG_GENERIC_MSI_IRQ
 static irqreturn_t hidma_chirq_handler_msi(int chirq, void *arg)
 {
 	struct hidma_lldev **lldevp =3D arg;
@@ -671,7 +671,7 @@ static int hidma_sysfs_init(struct hidma_dev *dev)
 	return device_create_file(dev->ddev.dev, dev->chid_attrs);
 }
=20
-#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
+#ifdef CONFIG_GENERIC_MSI_IRQ
 static void hidma_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
 {
 	struct device *dev =3D msi_desc_to_dev(desc);
@@ -687,7 +687,7 @@ static void hidma_write_msi_msg(struct msi_desc *desc, st=
ruct msi_msg *msg)
=20
 static void hidma_free_msis(struct hidma_dev *dmadev)
 {
-#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
+#ifdef CONFIG_GENERIC_MSI_IRQ
 	struct device *dev =3D dmadev->ddev.dev;
 	int i, virq;
=20
@@ -704,7 +704,7 @@ static void hidma_free_msis(struct hidma_dev *dmadev)
 static int hidma_request_msi(struct hidma_dev *dmadev,
 			     struct platform_device *pdev)
 {
-#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
+#ifdef CONFIG_GENERIC_MSI_IRQ
 	int rc, i, virq;
=20
 	rc =3D platform_msi_domain_alloc_irqs(&pdev->dev, HIDMA_MSI_INTS,
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 8b2e413bf19c..1f5d37ad74b9 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -37,6 +37,7 @@
 #include <linux/dma-map-ops.h>
 #include <linux/pci.h>
 #include <clocksource/hyperv_timer.h>
+#include <asm/mshyperv.h>
 #include "hyperv_vmbus.h"
=20
 struct vmbus_dynid {
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index dc5f7a156ff5..8eaf9b72a995 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -389,7 +389,7 @@ config ARM_SMMU_V3
 	depends on ARM64
 	select IOMMU_API
 	select IOMMU_IO_PGTABLE_LPAE
-	select GENERIC_MSI_IRQ_DOMAIN
+	select GENERIC_MSI_IRQ
 	help
 	  Support for implementations of the ARM System MMU architecture
 	  version 3 providing translation support to a PCIe root complex.
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iomm=
u_types.h
index 1d0a70c85333..3d684190b4d5 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -734,7 +734,6 @@ struct amd_iommu {
 	u8 max_counters;
 #ifdef CONFIG_IRQ_REMAP
 	struct irq_domain *ir_domain;
-	struct irq_domain *msi_domain;
=20
 	struct amd_irte_ops *irte_ops;
 #endif
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index d3b39d0416fa..4d28967f910d 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -812,10 +812,10 @@ static void
 amd_iommu_set_pci_msi_domain(struct device *dev, struct amd_iommu *iommu)
 {
 	if (!irq_remapping_enabled || !dev_is_pci(dev) ||
-	    pci_dev_has_special_msi_domain(to_pci_dev(dev)))
+	    !pci_dev_has_default_msi_parent_domain(to_pci_dev(dev)))
 		return;
=20
-	dev_set_msi_domain(dev, iommu->msi_domain);
+	dev_set_msi_domain(dev, iommu->ir_domain);
 }
=20
 #else /* CONFIG_IRQ_REMAP */
@@ -3294,17 +3294,9 @@ static int irq_remapping_alloc(struct irq_domain *doma=
in, unsigned int virq,
=20
 	if (!info)
 		return -EINVAL;
-	if (nr_irqs > 1 && info->type !=3D X86_IRQ_ALLOC_TYPE_PCI_MSI &&
-	    info->type !=3D X86_IRQ_ALLOC_TYPE_PCI_MSIX)
+	if (nr_irqs > 1 && info->type !=3D X86_IRQ_ALLOC_TYPE_PCI_MSI)
 		return -EINVAL;
=20
-	/*
-	 * With IRQ remapping enabled, don't need contiguous CPU vectors
-	 * to support multiple MSI interrupts.
-	 */
-	if (info->type =3D=3D X86_IRQ_ALLOC_TYPE_PCI_MSI)
-		info->flags &=3D ~X86_IRQ_ALLOC_CONTIGUOUS_VECTORS;
-
 	sbdf =3D get_devid(info);
 	if (sbdf < 0)
 		return -EINVAL;
@@ -3656,6 +3648,21 @@ static struct irq_chip amd_ir_chip =3D {
 	.irq_compose_msi_msg	=3D ir_compose_msi_msg,
 };
=20
+static const struct msi_parent_ops amdvi_msi_parent_ops =3D {
+	.supported_flags	=3D X86_VECTOR_MSI_FLAGS_SUPPORTED |
+				  MSI_FLAG_MULTI_PCI_MSI |
+				  MSI_FLAG_PCI_IMS,
+	.prefix			=3D "IR-",
+	.init_dev_msi_info	=3D msi_parent_init_dev_msi_info,
+};
+
+static const struct msi_parent_ops virt_amdvi_msi_parent_ops =3D {
+	.supported_flags	=3D X86_VECTOR_MSI_FLAGS_SUPPORTED |
+				  MSI_FLAG_MULTI_PCI_MSI,
+	.prefix			=3D "vIR-",
+	.init_dev_msi_info	=3D msi_parent_init_dev_msi_info,
+};
+
 int amd_iommu_create_irq_domain(struct amd_iommu *iommu)
 {
 	struct fwnode_handle *fn;
@@ -3663,16 +3670,21 @@ int amd_iommu_create_irq_domain(struct amd_iommu *iom=
mu)
 	fn =3D irq_domain_alloc_named_id_fwnode("AMD-IR", iommu->index);
 	if (!fn)
 		return -ENOMEM;
-	iommu->ir_domain =3D irq_domain_create_tree(fn, &amd_ir_domain_ops, iommu);
+	iommu->ir_domain =3D irq_domain_create_hierarchy(arch_get_ir_parent_domain(=
), 0, 0,
+						       fn, &amd_ir_domain_ops, iommu);
 	if (!iommu->ir_domain) {
 		irq_domain_free_fwnode(fn);
 		return -ENOMEM;
 	}
=20
-	iommu->ir_domain->parent =3D arch_get_ir_parent_domain();
-	iommu->msi_domain =3D arch_create_remap_msi_irq_domain(iommu->ir_domain,
-							     "AMD-IR-MSI",
-							     iommu->index);
+	irq_domain_update_bus_token(iommu->ir_domain,  DOMAIN_BUS_AMDVI);
+	iommu->ir_domain->flags |=3D IRQ_DOMAIN_FLAG_MSI_PARENT;
+
+	if (amd_iommu_np_cache)
+		iommu->ir_domain->msi_parent_ops =3D &virt_amdvi_msi_parent_ops;
+	else
+		iommu->ir_domain->msi_parent_ops =3D &amdvi_msi_parent_ops;
+
 	return 0;
 }
=20
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 92023dff9513..6eadb86b9d19 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -600,7 +600,6 @@ struct intel_iommu {
 #ifdef CONFIG_IRQ_REMAP
 	struct ir_table *ir_table;	/* Interrupt remapping info */
 	struct irq_domain *ir_domain;
-	struct irq_domain *ir_msi_domain;
 #endif
 	struct iommu_device iommu;  /* IOMMU core code handle */
 	int		node;
diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_re=
mapping.c
index 5962bb5027d0..a723f53ba472 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -82,6 +82,7 @@ static const struct irq_domain_ops intel_ir_domain_ops;
=20
 static void iommu_disable_irq_remapping(struct intel_iommu *iommu);
 static int __init parse_ioapics_under_ir(void);
+static const struct msi_parent_ops dmar_msi_parent_ops, virt_dmar_msi_parent=
_ops;
=20
 static bool ir_pre_enabled(struct intel_iommu *iommu)
 {
@@ -230,7 +231,7 @@ static struct irq_domain *map_dev_to_ir(struct pci_dev *d=
ev)
 {
 	struct dmar_drhd_unit *drhd =3D dmar_find_matched_drhd_unit(dev);
=20
-	return drhd ? drhd->iommu->ir_msi_domain : NULL;
+	return drhd ? drhd->iommu->ir_domain : NULL;
 }
=20
 static int clear_entries(struct irq_2_iommu *irq_iommu)
@@ -573,10 +574,14 @@ static int intel_setup_irq_remapping(struct intel_iommu=
 *iommu)
 		pr_err("IR%d: failed to allocate irqdomain\n", iommu->seq_id);
 		goto out_free_fwnode;
 	}
-	iommu->ir_msi_domain =3D
-		arch_create_remap_msi_irq_domain(iommu->ir_domain,
-						 "INTEL-IR-MSI",
-						 iommu->seq_id);
+
+	irq_domain_update_bus_token(iommu->ir_domain,  DOMAIN_BUS_DMAR);
+	iommu->ir_domain->flags |=3D IRQ_DOMAIN_FLAG_MSI_PARENT;
+
+	if (cap_caching_mode(iommu->cap))
+		iommu->ir_domain->msi_parent_ops =3D &virt_dmar_msi_parent_ops;
+	else
+		iommu->ir_domain->msi_parent_ops =3D &dmar_msi_parent_ops;
=20
 	ir_table->base =3D page_address(pages);
 	ir_table->bitmap =3D bitmap;
@@ -620,9 +625,6 @@ static int intel_setup_irq_remapping(struct intel_iommu *=
iommu)
 	return 0;
=20
 out_free_ir_domain:
-	if (iommu->ir_msi_domain)
-		irq_domain_remove(iommu->ir_msi_domain);
-	iommu->ir_msi_domain =3D NULL;
 	irq_domain_remove(iommu->ir_domain);
 	iommu->ir_domain =3D NULL;
 out_free_fwnode:
@@ -644,13 +646,6 @@ static void intel_teardown_irq_remapping(struct intel_io=
mmu *iommu)
 	struct fwnode_handle *fn;
=20
 	if (iommu && iommu->ir_table) {
-		if (iommu->ir_msi_domain) {
-			fn =3D iommu->ir_msi_domain->fwnode;
-
-			irq_domain_remove(iommu->ir_msi_domain);
-			irq_domain_free_fwnode(fn);
-			iommu->ir_msi_domain =3D NULL;
-		}
 		if (iommu->ir_domain) {
 			fn =3D iommu->ir_domain->fwnode;
=20
@@ -1107,7 +1102,7 @@ static int reenable_irq_remapping(int eim)
  */
 void intel_irq_remap_add_device(struct dmar_pci_notify_info *info)
 {
-	if (!irq_remapping_enabled || pci_dev_has_special_msi_domain(info->dev))
+	if (!irq_remapping_enabled || !pci_dev_has_default_msi_parent_domain(info->=
dev))
 		return;
=20
 	dev_set_msi_domain(&info->dev->dev, map_dev_to_ir(info->dev));
@@ -1334,17 +1329,9 @@ static int intel_irq_remapping_alloc(struct irq_domain=
 *domain,
=20
 	if (!info || !iommu)
 		return -EINVAL;
-	if (nr_irqs > 1 && info->type !=3D X86_IRQ_ALLOC_TYPE_PCI_MSI &&
-	    info->type !=3D X86_IRQ_ALLOC_TYPE_PCI_MSIX)
+	if (nr_irqs > 1 && info->type !=3D X86_IRQ_ALLOC_TYPE_PCI_MSI)
 		return -EINVAL;
=20
-	/*
-	 * With IRQ remapping enabled, don't need contiguous CPU vectors
-	 * to support multiple MSI interrupts.
-	 */
-	if (info->type =3D=3D X86_IRQ_ALLOC_TYPE_PCI_MSI)
-		info->flags &=3D ~X86_IRQ_ALLOC_CONTIGUOUS_VECTORS;
-
 	ret =3D irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, arg);
 	if (ret < 0)
 		return ret;
@@ -1445,6 +1432,21 @@ static const struct irq_domain_ops intel_ir_domain_ops=
 =3D {
 	.deactivate =3D intel_irq_remapping_deactivate,
 };
=20
+static const struct msi_parent_ops dmar_msi_parent_ops =3D {
+	.supported_flags	=3D X86_VECTOR_MSI_FLAGS_SUPPORTED |
+				  MSI_FLAG_MULTI_PCI_MSI |
+				  MSI_FLAG_PCI_IMS,
+	.prefix			=3D "IR-",
+	.init_dev_msi_info	=3D msi_parent_init_dev_msi_info,
+};
+
+static const struct msi_parent_ops virt_dmar_msi_parent_ops =3D {
+	.supported_flags	=3D X86_VECTOR_MSI_FLAGS_SUPPORTED |
+				  MSI_FLAG_MULTI_PCI_MSI,
+	.prefix			=3D "vIR-",
+	.init_dev_msi_info	=3D msi_parent_init_dev_msi_info,
+};
+
 /*
  * Support of Interrupt Remapping Unit Hotplug
  */
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 5696314ae69e..00d98f08732f 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -9,7 +9,6 @@
 #include <linux/iommu.h>
 #include <linux/limits.h>
 #include <linux/module.h>
-#include <linux/msi.h>
 #include <linux/of.h>
 #include <linux/of_iommu.h>
 #include <linux/of_pci.h>
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 7ef9f5e696d3..d07568a2c539 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -38,7 +38,7 @@ config ARM_GIC_V3
=20
 config ARM_GIC_V3_ITS
 	bool
-	select GENERIC_MSI_IRQ_DOMAIN
+	select GENERIC_MSI_IRQ
 	default ARM_GIC_V3
=20
 config ARM_GIC_V3_ITS_PCI
@@ -86,7 +86,7 @@ config ALPINE_MSI
=20
 config AL_FIC
 	bool "Amazon's Annapurna Labs Fabric Interrupt Controller"
-	depends on OF || COMPILE_TEST
+	depends on OF
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
 	help
@@ -375,7 +375,7 @@ config MVEBU_ICU
=20
 config MVEBU_ODMI
 	bool
-	select GENERIC_MSI_IRQ_DOMAIN
+	select GENERIC_MSI_IRQ
=20
 config MVEBU_PIC
 	bool
@@ -488,7 +488,7 @@ config IMX_MU_MSI
 	default m if ARCH_MXC
 	select IRQ_DOMAIN
 	select IRQ_DOMAIN_HIERARCHY
-	select GENERIC_MSI_IRQ_DOMAIN
+	select GENERIC_MSI_IRQ
 	help
 	  Provide a driver for the i.MX Messaging Unit block used as a
 	  CPU-to-CPU MSI controller. This requires a specially crafted DT
@@ -576,6 +576,7 @@ config IRQ_LOONGARCH_CPU
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
 	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
+	select LOONGSON_HTVEC
 	select LOONGSON_LIOINTC
 	select LOONGSON_EIOINTC
 	select LOONGSON_PCH_PIC
diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
index 1c2813ad8bbe..ae3437f03e6c 100644
--- a/drivers/irqchip/irq-apple-aic.c
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -248,14 +248,14 @@ struct aic_info {
 	bool fast_ipi;
 };
=20
-static const struct aic_info aic1_info =3D {
+static const struct aic_info aic1_info __initconst =3D {
 	.version	=3D 1,
=20
 	.event		=3D AIC_EVENT,
 	.target_cpu	=3D AIC_TARGET_CPU,
 };
=20
-static const struct aic_info aic1_fipi_info =3D {
+static const struct aic_info aic1_fipi_info __initconst =3D {
 	.version	=3D 1,
=20
 	.event		=3D AIC_EVENT,
@@ -264,7 +264,7 @@ static const struct aic_info aic1_fipi_info =3D {
 	.fast_ipi	=3D true,
 };
=20
-static const struct aic_info aic2_info =3D {
+static const struct aic_info aic2_info __initconst =3D {
 	.version	=3D 2,
=20
 	.irq_cfg	=3D AIC2_IRQ_CFG,
diff --git a/drivers/irqchip/irq-gic-pm.c b/drivers/irqchip/irq-gic-pm.c
index b60e1853593f..3989d16f997b 100644
--- a/drivers/irqchip/irq-gic-pm.c
+++ b/drivers/irqchip/irq-gic-pm.c
@@ -102,7 +102,7 @@ static int gic_probe(struct platform_device *pdev)
=20
 	pm_runtime_enable(dev);
=20
-	ret =3D pm_runtime_get_sync(dev);
+	ret =3D pm_runtime_resume_and_get(dev);
 	if (ret < 0)
 		goto rpm_disable;
=20
diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index 6e1ac330d7a6..f4d7eeb13951 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -24,6 +24,7 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/irqchip/arm-gic.h>
+#include <linux/irqchip/arm-gic-common.h>
=20
 /*
 * MSI_TYPER:
@@ -262,7 +263,7 @@ static struct msi_domain_info gicv2m_pmsi_domain_info =3D=
 {
 	.chip	=3D &gicv2m_pmsi_irq_chip,
 };
=20
-static void gicv2m_teardown(void)
+static void __init gicv2m_teardown(void)
 {
 	struct v2m_data *v2m, *tmp;
=20
@@ -277,7 +278,7 @@ static void gicv2m_teardown(void)
 	}
 }
=20
-static int gicv2m_allocate_domains(struct irq_domain *parent)
+static __init int gicv2m_allocate_domains(struct irq_domain *parent)
 {
 	struct irq_domain *inner_domain, *pci_domain, *plat_domain;
 	struct v2m_data *v2m;
@@ -404,7 +405,7 @@ static int __init gicv2m_init_one(struct fwnode_handle *f=
wnode,
 	return ret;
 }
=20
-static const struct of_device_id gicv2m_device_id[] =3D {
+static __initconst struct of_device_id gicv2m_device_id[] =3D {
 	{	.compatible	=3D "arm,gic-v2m-frame",	},
 	{},
 };
@@ -454,7 +455,7 @@ static int __init gicv2m_of_init(struct fwnode_handle *pa=
rent_handle,
 #ifdef CONFIG_ACPI
 static int acpi_num_msi;
=20
-static struct fwnode_handle *gicv2m_get_fwnode(struct device *dev)
+static __init struct fwnode_handle *gicv2m_get_fwnode(struct device *dev)
 {
 	struct v2m_data *data;
=20
@@ -469,7 +470,7 @@ static struct fwnode_handle *gicv2m_get_fwnode(struct dev=
ice *dev)
 	return data->fwnode;
 }
=20
-static bool acpi_check_amazon_graviton_quirks(void)
+static __init bool acpi_check_amazon_graviton_quirks(void)
 {
 	static struct acpi_table_madt *madt;
 	acpi_status status;
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 34d58567b78d..997104d4338e 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -12,6 +12,7 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/irqdomain.h>
+#include <linux/kstrtox.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
@@ -1171,7 +1172,7 @@ static bool gicv3_nolpi;
=20
 static int __init gicv3_nolpi_cfg(char *buf)
 {
-	return strtobool(buf, &gicv3_nolpi);
+	return kstrtobool(buf, &gicv3_nolpi);
 }
 early_param("irqchip.gicv3_nolpi", gicv3_nolpi_cfg);
=20
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 4c7bae0ec8f9..210bc2f4d555 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -19,6 +19,7 @@
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/kstrtox.h>
 #include <linux/err.h>
 #include <linux/module.h>
 #include <linux/list.h>
@@ -401,8 +402,8 @@ static void gic_irq_print_chip(struct irq_data *d, struct=
 seq_file *p)
 {
 	struct gic_chip_data *gic =3D irq_data_get_irq_chip_data(d);
=20
-	if (gic->domain->dev)
-		seq_printf(p, gic->domain->dev->of_node->name);
+	if (gic->domain->pm_dev)
+		seq_printf(p, gic->domain->pm_dev->of_node->name);
 	else
 		seq_printf(p, "GIC-%d", (int)(gic - &gic_data[0]));
 }
@@ -1332,7 +1333,7 @@ static bool gicv2_force_probe;
=20
 static int __init gicv2_force_probe_cfg(char *buf)
 {
-	return strtobool(buf, &gicv2_force_probe);
+	return kstrtobool(buf, &gicv2_force_probe);
 }
 early_param("irqchip.gicv2_force_probe", gicv2_force_probe_cfg);
=20
diff --git a/drivers/irqchip/irq-loongarch-cpu.c b/drivers/irqchip/irq-loonga=
rch-cpu.c
index 741612ba6a52..9d8f2c406043 100644
--- a/drivers/irqchip/irq-loongarch-cpu.c
+++ b/drivers/irqchip/irq-loongarch-cpu.c
@@ -92,18 +92,34 @@ static const struct irq_domain_ops loongarch_cpu_intc_irq=
_domain_ops =3D {
 	.xlate =3D irq_domain_xlate_onecell,
 };
=20
-static int __init
-liointc_parse_madt(union acpi_subtable_headers *header,
-		       const unsigned long end)
+#ifdef CONFIG_OF
+static int __init cpuintc_of_init(struct device_node *of_node,
+				struct device_node *parent)
+{
+	cpuintc_handle =3D of_node_to_fwnode(of_node);
+
+	irq_domain =3D irq_domain_create_linear(cpuintc_handle, EXCCODE_INT_NUM,
+				&loongarch_cpu_intc_irq_domain_ops, NULL);
+	if (!irq_domain)
+		panic("Failed to add irqdomain for loongarch CPU");
+
+	set_handle_irq(&handle_cpu_irq);
+
+	return 0;
+}
+IRQCHIP_DECLARE(cpu_intc, "loongson,cpu-interrupt-controller", cpuintc_of_in=
it);
+#endif
+
+static int __init liointc_parse_madt(union acpi_subtable_headers *header,
+					const unsigned long end)
 {
 	struct acpi_madt_lio_pic *liointc_entry =3D (struct acpi_madt_lio_pic *)hea=
der;
=20
 	return liointc_acpi_init(irq_domain, liointc_entry);
 }
=20
-static int __init
-eiointc_parse_madt(union acpi_subtable_headers *header,
-		       const unsigned long end)
+static int __init eiointc_parse_madt(union acpi_subtable_headers *header,
+					const unsigned long end)
 {
 	struct acpi_madt_eio_pic *eiointc_entry =3D (struct acpi_madt_eio_pic *)hea=
der;
=20
@@ -112,16 +128,24 @@ eiointc_parse_madt(union acpi_subtable_headers *header,
=20
 static int __init acpi_cascade_irqdomain_init(void)
 {
-	acpi_table_parse_madt(ACPI_MADT_TYPE_LIO_PIC,
-			      liointc_parse_madt, 0);
-	acpi_table_parse_madt(ACPI_MADT_TYPE_EIO_PIC,
-			      eiointc_parse_madt, 0);
+	int r;
+
+	r =3D acpi_table_parse_madt(ACPI_MADT_TYPE_LIO_PIC, liointc_parse_madt, 0);
+	if (r < 0)
+		return r;
+
+	r =3D acpi_table_parse_madt(ACPI_MADT_TYPE_EIO_PIC, eiointc_parse_madt, 0);
+	if (r < 0)
+		return r;
+
 	return 0;
 }
=20
 static int __init cpuintc_acpi_init(union acpi_subtable_headers *header,
 				   const unsigned long end)
 {
+	int ret;
+
 	if (irq_domain)
 		return 0;
=20
@@ -139,9 +163,9 @@ static int __init cpuintc_acpi_init(union acpi_subtable_h=
eaders *header,
 	set_handle_irq(&handle_cpu_irq);
 	acpi_set_irq_model(ACPI_IRQ_MODEL_LPIC, lpic_get_gsi_domain_id);
 	acpi_set_gsi_to_irq_fallback(lpic_gsi_to_irq);
-	acpi_cascade_irqdomain_init();
+	ret =3D acpi_cascade_irqdomain_init();
=20
-	return 0;
+	return ret;
 }
=20
 IRQCHIP_ACPI_DECLARE(cpuintc_v1, ACPI_MADT_TYPE_CORE_PIC,
diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loo=
ngson-eiointc.c
index 16e9af8d8b1e..d15fd38c1756 100644
--- a/drivers/irqchip/irq-loongson-eiointc.c
+++ b/drivers/irqchip/irq-loongson-eiointc.c
@@ -17,6 +17,7 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
+#include <linux/syscore_ops.h>
=20
 #define EIOINTC_REG_NODEMAP	0x14a0
 #define EIOINTC_REG_IPMAP	0x14c0
@@ -301,9 +302,39 @@ static struct irq_domain *acpi_get_vec_parent(int node, =
struct acpi_vector_group
 	return NULL;
 }
=20
-static int __init
-pch_pic_parse_madt(union acpi_subtable_headers *header,
-		       const unsigned long end)
+static int eiointc_suspend(void)
+{
+	return 0;
+}
+
+static void eiointc_resume(void)
+{
+	int i, j;
+	struct irq_desc *desc;
+	struct irq_data *irq_data;
+
+	eiointc_router_init(0);
+
+	for (i =3D 0; i < nr_pics; i++) {
+		for (j =3D 0; j < VEC_COUNT; j++) {
+			desc =3D irq_resolve_mapping(eiointc_priv[i]->eiointc_domain, j);
+			if (desc && desc->handle_irq && desc->handle_irq !=3D handle_bad_irq) {
+				raw_spin_lock(&desc->lock);
+				irq_data =3D &desc->irq_data;
+				eiointc_set_irq_affinity(irq_data, irq_data->common->affinity, 0);
+				raw_spin_unlock(&desc->lock);
+			}
+		}
+	}
+}
+
+static struct syscore_ops eiointc_syscore_ops =3D {
+	.suspend =3D eiointc_suspend,
+	.resume =3D eiointc_resume,
+};
+
+static int __init pch_pic_parse_madt(union acpi_subtable_headers *header,
+					const unsigned long end)
 {
 	struct acpi_madt_bio_pic *pchpic_entry =3D (struct acpi_madt_bio_pic *)head=
er;
 	unsigned int node =3D (pchpic_entry->address >> 44) & 0xf;
@@ -315,9 +346,8 @@ pch_pic_parse_madt(union acpi_subtable_headers *header,
 	return -EINVAL;
 }
=20
-static int __init
-pch_msi_parse_madt(union acpi_subtable_headers *header,
-		       const unsigned long end)
+static int __init pch_msi_parse_madt(union acpi_subtable_headers *header,
+					const unsigned long end)
 {
 	struct acpi_madt_msi_pic *pchmsi_entry =3D (struct acpi_madt_msi_pic *)head=
er;
 	struct irq_domain *parent =3D acpi_get_vec_parent(eiointc_priv[nr_pics - 1]=
->node, msi_group);
@@ -330,17 +360,23 @@ pch_msi_parse_madt(union acpi_subtable_headers *header,
=20
 static int __init acpi_cascade_irqdomain_init(void)
 {
-	acpi_table_parse_madt(ACPI_MADT_TYPE_BIO_PIC,
-			      pch_pic_parse_madt, 0);
-	acpi_table_parse_madt(ACPI_MADT_TYPE_MSI_PIC,
-			      pch_msi_parse_madt, 1);
+	int r;
+
+	r =3D acpi_table_parse_madt(ACPI_MADT_TYPE_BIO_PIC, pch_pic_parse_madt, 0);
+	if (r < 0)
+		return r;
+
+	r =3D acpi_table_parse_madt(ACPI_MADT_TYPE_MSI_PIC, pch_msi_parse_madt, 1);
+	if (r < 0)
+		return r;
+
 	return 0;
 }
=20
 int __init eiointc_acpi_init(struct irq_domain *parent,
 				     struct acpi_madt_eio_pic *acpi_eiointc)
 {
-	int i, parent_irq;
+	int i, ret, parent_irq;
 	unsigned long node_map;
 	struct eiointc_priv *priv;
=20
@@ -380,15 +416,16 @@ int __init eiointc_acpi_init(struct irq_domain *parent,
 	parent_irq =3D irq_create_mapping(parent, acpi_eiointc->cascade);
 	irq_set_chained_handler_and_data(parent_irq, eiointc_irq_dispatch, priv);
=20
+	register_syscore_ops(&eiointc_syscore_ops);
 	cpuhp_setup_state_nocalls(CPUHP_AP_IRQ_LOONGARCH_STARTING,
 				  "irqchip/loongarch/intc:starting",
 				  eiointc_router_init, NULL);
=20
 	acpi_set_vec_parent(acpi_eiointc->node, priv->eiointc_domain, pch_group);
 	acpi_set_vec_parent(acpi_eiointc->node, priv->eiointc_domain, msi_group);
-	acpi_cascade_irqdomain_init();
+	ret =3D acpi_cascade_irqdomain_init();
=20
-	return 0;
+	return ret;
=20
 out_free_handle:
 	irq_domain_free_fwnode(priv->domain_handle);
diff --git a/drivers/irqchip/irq-loongson-htvec.c b/drivers/irqchip/irq-loong=
son-htvec.c
index 60a335d7e64e..fc8bf1f5d41b 100644
--- a/drivers/irqchip/irq-loongson-htvec.c
+++ b/drivers/irqchip/irq-loongson-htvec.c
@@ -16,11 +16,11 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
+#include <linux/syscore_ops.h>
=20
 /* Registers */
 #define HTVEC_EN_OFF		0x20
 #define HTVEC_MAX_PARENT_IRQ	8
-
 #define VEC_COUNT_PER_REG	32
 #define VEC_REG_IDX(irq_id)	((irq_id) / VEC_COUNT_PER_REG)
 #define VEC_REG_BIT(irq_id)	((irq_id) % VEC_COUNT_PER_REG)
@@ -30,8 +30,11 @@ struct htvec {
 	void __iomem		*base;
 	struct irq_domain	*htvec_domain;
 	raw_spinlock_t		htvec_lock;
+	u32			saved_vec_en[HTVEC_MAX_PARENT_IRQ];
 };
=20
+static struct htvec *htvec_priv;
+
 static void htvec_irq_dispatch(struct irq_desc *desc)
 {
 	int i;
@@ -155,64 +158,169 @@ static void htvec_reset(struct htvec *priv)
 	}
 }
=20
-static int htvec_of_init(struct device_node *node,
-				struct device_node *parent)
+static int htvec_suspend(void)
+{
+	int i;
+
+	for (i =3D 0; i < htvec_priv->num_parents; i++)
+		htvec_priv->saved_vec_en[i] =3D readl(htvec_priv->base + HTVEC_EN_OFF + 4 =
* i);
+
+	return 0;
+}
+
+static void htvec_resume(void)
 {
+	int i;
+
+	for (i =3D 0; i < htvec_priv->num_parents; i++)
+		writel(htvec_priv->saved_vec_en[i], htvec_priv->base + HTVEC_EN_OFF + 4 * =
i);
+}
+
+static struct syscore_ops htvec_syscore_ops =3D {
+	.suspend =3D htvec_suspend,
+	.resume =3D htvec_resume,
+};
+
+static int htvec_init(phys_addr_t addr, unsigned long size,
+		int num_parents, int parent_irq[], struct fwnode_handle *domain_handle)
+{
+	int i;
 	struct htvec *priv;
-	int err, parent_irq[8], i;
=20
 	priv =3D kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
=20
+	priv->num_parents =3D num_parents;
+	priv->base =3D ioremap(addr, size);
 	raw_spin_lock_init(&priv->htvec_lock);
-	priv->base =3D of_iomap(node, 0);
-	if (!priv->base) {
-		err =3D -ENOMEM;
-		goto free_priv;
-	}
-
-	/* Interrupt may come from any of the 8 interrupt lines */
-	for (i =3D 0; i < HTVEC_MAX_PARENT_IRQ; i++) {
-		parent_irq[i] =3D irq_of_parse_and_map(node, i);
-		if (parent_irq[i] <=3D 0)
-			break;
=20
-		priv->num_parents++;
-	}
-
-	if (!priv->num_parents) {
-		pr_err("Failed to get parent irqs\n");
-		err =3D -ENODEV;
-		goto iounmap_base;
-	}
-
-	priv->htvec_domain =3D irq_domain_create_linear(of_node_to_fwnode(node),
+	/* Setup IRQ domain */
+	priv->htvec_domain =3D irq_domain_create_linear(domain_handle,
 					(VEC_COUNT_PER_REG * priv->num_parents),
 					&htvec_domain_ops, priv);
 	if (!priv->htvec_domain) {
-		pr_err("Failed to create IRQ domain\n");
-		err =3D -ENOMEM;
-		goto irq_dispose;
+		pr_err("loongson-htvec: cannot add IRQ domain\n");
+		goto iounmap_base;
 	}
=20
 	htvec_reset(priv);
=20
-	for (i =3D 0; i < priv->num_parents; i++)
+	for (i =3D 0; i < priv->num_parents; i++) {
 		irq_set_chained_handler_and_data(parent_irq[i],
 						 htvec_irq_dispatch, priv);
+	}
+
+	htvec_priv =3D priv;
+
+	register_syscore_ops(&htvec_syscore_ops);
=20
 	return 0;
=20
-irq_dispose:
-	for (; i > 0; i--)
-		irq_dispose_mapping(parent_irq[i - 1]);
 iounmap_base:
 	iounmap(priv->base);
-free_priv:
 	kfree(priv);
=20
-	return err;
+	return -EINVAL;
+}
+
+#ifdef CONFIG_OF
+
+static int htvec_of_init(struct device_node *node,
+				struct device_node *parent)
+{
+	int i, err;
+	int parent_irq[8];
+	int num_parents =3D 0;
+	struct resource res;
+
+	if (of_address_to_resource(node, 0, &res))
+		return -EINVAL;
+
+	/* Interrupt may come from any of the 8 interrupt lines */
+	for (i =3D 0; i < HTVEC_MAX_PARENT_IRQ; i++) {
+		parent_irq[i] =3D irq_of_parse_and_map(node, i);
+		if (parent_irq[i] <=3D 0)
+			break;
+
+		num_parents++;
+	}
+
+	err =3D htvec_init(res.start, resource_size(&res),
+			num_parents, parent_irq, of_node_to_fwnode(node));
+	if (err < 0)
+		return err;
+
+	return 0;
 }
=20
 IRQCHIP_DECLARE(htvec, "loongson,htvec-1.0", htvec_of_init);
+
+#endif
+
+#ifdef CONFIG_ACPI
+static int __init pch_pic_parse_madt(union acpi_subtable_headers *header,
+					const unsigned long end)
+{
+	struct acpi_madt_bio_pic *pchpic_entry =3D (struct acpi_madt_bio_pic *)head=
er;
+
+	return pch_pic_acpi_init(htvec_priv->htvec_domain, pchpic_entry);
+}
+
+static int __init pch_msi_parse_madt(union acpi_subtable_headers *header,
+					const unsigned long end)
+{
+	struct acpi_madt_msi_pic *pchmsi_entry =3D (struct acpi_madt_msi_pic *)head=
er;
+
+	return pch_msi_acpi_init(htvec_priv->htvec_domain, pchmsi_entry);
+}
+
+static int __init acpi_cascade_irqdomain_init(void)
+{
+	int r;
+
+	r =3D acpi_table_parse_madt(ACPI_MADT_TYPE_BIO_PIC, pch_pic_parse_madt, 0);
+	if (r < 0)
+		return r;
+
+	r =3D acpi_table_parse_madt(ACPI_MADT_TYPE_MSI_PIC, pch_msi_parse_madt, 0);
+	if (r < 0)
+		return r;
+
+	return 0;
+}
+
+int __init htvec_acpi_init(struct irq_domain *parent,
+				   struct acpi_madt_ht_pic *acpi_htvec)
+{
+	int i, ret;
+	int num_parents, parent_irq[8];
+	struct fwnode_handle *domain_handle;
+
+	if (!acpi_htvec)
+		return -EINVAL;
+
+	num_parents =3D HTVEC_MAX_PARENT_IRQ;
+
+	domain_handle =3D irq_domain_alloc_fwnode(&acpi_htvec->address);
+	if (!domain_handle) {
+		pr_err("Unable to allocate domain handle\n");
+		return -ENOMEM;
+	}
+
+	/* Interrupt may come from any of the 8 interrupt lines */
+	for (i =3D 0; i < HTVEC_MAX_PARENT_IRQ; i++)
+		parent_irq[i] =3D irq_create_mapping(parent, acpi_htvec->cascade[i]);
+
+	ret =3D htvec_init(acpi_htvec->address, acpi_htvec->size,
+			num_parents, parent_irq, domain_handle);
+
+	if (ret =3D=3D 0)
+		ret =3D acpi_cascade_irqdomain_init();
+	else
+		irq_domain_free_fwnode(domain_handle);
+
+	return ret;
+}
+
+#endif
diff --git a/drivers/irqchip/irq-loongson-liointc.c b/drivers/irqchip/irq-loo=
ngson-liointc.c
index 0da8716f8f24..85b754f7f4e6 100644
--- a/drivers/irqchip/irq-loongson-liointc.c
+++ b/drivers/irqchip/irq-loongson-liointc.c
@@ -167,7 +167,12 @@ static int liointc_domain_xlate(struct irq_domain *d, st=
ruct device_node *ctrlr,
 	if (WARN_ON(intsize < 1))
 		return -EINVAL;
 	*out_hwirq =3D intspec[0] - GSI_MIN_CPU_IRQ;
-	*out_type =3D IRQ_TYPE_NONE;
+
+	if (intsize > 1)
+		*out_type =3D intspec[1] & IRQ_TYPE_SENSE_MASK;
+	else
+		*out_type =3D IRQ_TYPE_NONE;
+
 	return 0;
 }
=20
@@ -207,10 +212,13 @@ static int liointc_init(phys_addr_t addr, unsigned long=
 size, int revision,
 					"reg-names", core_reg_names[i]);
=20
 			if (index < 0)
-				goto out_iounmap;
+				continue;
=20
 			priv->core_isr[i] =3D of_iomap(node, index);
 		}
+
+		if (!priv->core_isr[0])
+			goto out_iounmap;
 	}
=20
 	/* Setup IRQ domain */
@@ -349,6 +357,26 @@ IRQCHIP_DECLARE(loongson_liointc_2_0, "loongson,liointc-=
2.0", liointc_of_init);
 #endif
=20
 #ifdef CONFIG_ACPI
+static int __init htintc_parse_madt(union acpi_subtable_headers *header,
+					const unsigned long end)
+{
+	struct acpi_madt_ht_pic *htintc_entry =3D (struct acpi_madt_ht_pic *)header;
+	struct irq_domain *parent =3D irq_find_matching_fwnode(liointc_handle, DOMA=
IN_BUS_ANY);
+
+	return htvec_acpi_init(parent, htintc_entry);
+}
+
+static int __init acpi_cascade_irqdomain_init(void)
+{
+	int r;
+
+	r =3D acpi_table_parse_madt(ACPI_MADT_TYPE_HT_PIC, htintc_parse_madt, 0);
+	if (r < 0)
+		return r;
+
+	return 0;
+}
+
 int __init liointc_acpi_init(struct irq_domain *parent, struct acpi_madt_lio=
_pic *acpi_liointc)
 {
 	int ret;
@@ -365,9 +393,12 @@ int __init liointc_acpi_init(struct irq_domain *parent, =
struct acpi_madt_lio_pic
 		pr_err("Unable to allocate domain handle\n");
 		return -ENOMEM;
 	}
+
 	ret =3D liointc_init(acpi_liointc->address, acpi_liointc->size,
 			   1, domain_handle, NULL);
-	if (ret)
+	if (ret =3D=3D 0)
+		ret =3D acpi_cascade_irqdomain_init();
+	else
 		irq_domain_free_fwnode(domain_handle);
=20
 	return ret;
diff --git a/drivers/irqchip/irq-loongson-pch-lpc.c b/drivers/irqchip/irq-loo=
ngson-pch-lpc.c
index bf2324910a75..9b35492fb6be 100644
--- a/drivers/irqchip/irq-loongson-pch-lpc.c
+++ b/drivers/irqchip/irq-loongson-pch-lpc.c
@@ -13,6 +13,7 @@
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
+#include <linux/syscore_ops.h>
=20
 /* Registers */
 #define LPC_INT_CTL		0x00
@@ -34,6 +35,7 @@ struct pch_lpc {
 	u32			saved_reg_pol;
 };
=20
+static struct pch_lpc *pch_lpc_priv;
 struct fwnode_handle *pch_lpc_handle;
=20
 static void lpc_irq_ack(struct irq_data *d)
@@ -147,6 +149,26 @@ static int pch_lpc_disabled(struct pch_lpc *priv)
 			(readl(priv->base + LPC_INT_STS) =3D=3D 0xffffffff);
 }
=20
+static int pch_lpc_suspend(void)
+{
+	pch_lpc_priv->saved_reg_ctl =3D readl(pch_lpc_priv->base + LPC_INT_CTL);
+	pch_lpc_priv->saved_reg_ena =3D readl(pch_lpc_priv->base + LPC_INT_ENA);
+	pch_lpc_priv->saved_reg_pol =3D readl(pch_lpc_priv->base + LPC_INT_POL);
+	return 0;
+}
+
+static void pch_lpc_resume(void)
+{
+	writel(pch_lpc_priv->saved_reg_ctl, pch_lpc_priv->base + LPC_INT_CTL);
+	writel(pch_lpc_priv->saved_reg_ena, pch_lpc_priv->base + LPC_INT_ENA);
+	writel(pch_lpc_priv->saved_reg_pol, pch_lpc_priv->base + LPC_INT_POL);
+}
+
+static struct syscore_ops pch_lpc_syscore_ops =3D {
+	.suspend =3D pch_lpc_suspend,
+	.resume =3D pch_lpc_resume,
+};
+
 int __init pch_lpc_acpi_init(struct irq_domain *parent,
 					struct acpi_madt_lpc_pic *acpi_pchlpc)
 {
@@ -191,7 +213,10 @@ int __init pch_lpc_acpi_init(struct irq_domain *parent,
 	parent_irq =3D irq_create_fwspec_mapping(&fwspec);
 	irq_set_chained_handler_and_data(parent_irq, lpc_irq_dispatch, priv);
=20
+	pch_lpc_priv =3D priv;
 	pch_lpc_handle =3D irq_handle;
+	register_syscore_ops(&pch_lpc_syscore_ops);
+
 	return 0;
=20
 free_irq_handle:
diff --git a/drivers/irqchip/irq-loongson-pch-pic.c b/drivers/irqchip/irq-loo=
ngson-pch-pic.c
index c01b9c257005..437f1af693d0 100644
--- a/drivers/irqchip/irq-loongson-pch-pic.c
+++ b/drivers/irqchip/irq-loongson-pch-pic.c
@@ -15,6 +15,7 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
+#include <linux/syscore_ops.h>
=20
 /* Registers */
 #define PCH_PIC_MASK		0x20
@@ -42,6 +43,9 @@ struct pch_pic {
 	raw_spinlock_t		pic_lock;
 	u32			vec_count;
 	u32			gsi_base;
+	u32			saved_vec_en[PIC_REG_COUNT];
+	u32			saved_vec_pol[PIC_REG_COUNT];
+	u32			saved_vec_edge[PIC_REG_COUNT];
 };
=20
 static struct pch_pic *pch_pic_priv[MAX_IO_PICS];
@@ -145,6 +149,7 @@ static struct irq_chip pch_pic_irq_chip =3D {
 	.irq_ack		=3D pch_pic_ack_irq,
 	.irq_set_affinity	=3D irq_chip_set_affinity_parent,
 	.irq_set_type		=3D pch_pic_set_type,
+	.flags			=3D IRQCHIP_SKIP_SET_WAKE,
 };
=20
 static int pch_pic_domain_translate(struct irq_domain *d,
@@ -155,15 +160,21 @@ static int pch_pic_domain_translate(struct irq_domain *=
d,
 	struct pch_pic *priv =3D d->host_data;
 	struct device_node *of_node =3D to_of_node(fwspec->fwnode);
=20
-	if (fwspec->param_count < 1)
-		return -EINVAL;
-
 	if (of_node) {
+		if (fwspec->param_count < 2)
+			return -EINVAL;
+
 		*hwirq =3D fwspec->param[0] + priv->ht_vec_base;
 		*type =3D fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
 	} else {
+		if (fwspec->param_count < 1)
+			return -EINVAL;
+
 		*hwirq =3D fwspec->param[0] - priv->gsi_base;
-		*type =3D IRQ_TYPE_NONE;
+		if (fwspec->param_count > 1)
+			*type =3D fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
+		else
+			*type =3D IRQ_TYPE_NONE;
 	}
=20
 	return 0;
@@ -228,6 +239,46 @@ static void pch_pic_reset(struct pch_pic *priv)
 	}
 }
=20
+static int pch_pic_suspend(void)
+{
+	int i, j;
+
+	for (i =3D 0; i < nr_pics; i++) {
+		for (j =3D 0; j < PIC_REG_COUNT; j++) {
+			pch_pic_priv[i]->saved_vec_pol[j] =3D
+				readl(pch_pic_priv[i]->base + PCH_PIC_POL + 4 * j);
+			pch_pic_priv[i]->saved_vec_edge[j] =3D
+				readl(pch_pic_priv[i]->base + PCH_PIC_EDGE + 4 * j);
+			pch_pic_priv[i]->saved_vec_en[j] =3D
+				readl(pch_pic_priv[i]->base + PCH_PIC_MASK + 4 * j);
+		}
+	}
+
+	return 0;
+}
+
+static void pch_pic_resume(void)
+{
+	int i, j;
+
+	for (i =3D 0; i < nr_pics; i++) {
+		pch_pic_reset(pch_pic_priv[i]);
+		for (j =3D 0; j < PIC_REG_COUNT; j++) {
+			writel(pch_pic_priv[i]->saved_vec_pol[j],
+					pch_pic_priv[i]->base + PCH_PIC_POL + 4 * j);
+			writel(pch_pic_priv[i]->saved_vec_edge[j],
+					pch_pic_priv[i]->base + PCH_PIC_EDGE + 4 * j);
+			writel(pch_pic_priv[i]->saved_vec_en[j],
+					pch_pic_priv[i]->base + PCH_PIC_MASK + 4 * j);
+		}
+	}
+}
+
+static struct syscore_ops pch_pic_syscore_ops =3D {
+	.suspend =3D  pch_pic_suspend,
+	.resume =3D  pch_pic_resume,
+};
+
 static int pch_pic_init(phys_addr_t addr, unsigned long size, int vec_base,
 			struct irq_domain *parent_domain, struct fwnode_handle *domain_handle,
 			u32 gsi_base)
@@ -260,6 +311,8 @@ static int pch_pic_init(phys_addr_t addr, unsigned long s=
ize, int vec_base,
 	pch_pic_handle[nr_pics] =3D domain_handle;
 	pch_pic_priv[nr_pics++] =3D priv;
=20
+	register_syscore_ops(&pch_pic_syscore_ops);
+
 	return 0;
=20
 iounmap_base:
@@ -325,9 +378,8 @@ int find_pch_pic(u32 gsi)
 	return -1;
 }
=20
-static int __init
-pch_lpc_parse_madt(union acpi_subtable_headers *header,
-		       const unsigned long end)
+static int __init pch_lpc_parse_madt(union acpi_subtable_headers *header,
+					const unsigned long end)
 {
 	struct acpi_madt_lpc_pic *pchlpc_entry =3D (struct acpi_madt_lpc_pic *)head=
er;
=20
@@ -336,8 +388,12 @@ pch_lpc_parse_madt(union acpi_subtable_headers *header,
=20
 static int __init acpi_cascade_irqdomain_init(void)
 {
-	acpi_table_parse_madt(ACPI_MADT_TYPE_LPC_PIC,
-			      pch_lpc_parse_madt, 0);
+	int r;
+
+	r =3D acpi_table_parse_madt(ACPI_MADT_TYPE_LPC_PIC, pch_lpc_parse_madt, 0);
+	if (r < 0)
+		return r;
+
 	return 0;
 }
=20
@@ -364,7 +420,7 @@ int __init pch_pic_acpi_init(struct irq_domain *parent,
 	}
=20
 	if (acpi_pchpic->id =3D=3D 0)
-		acpi_cascade_irqdomain_init();
+		ret =3D acpi_cascade_irqdomain_init();
=20
 	return ret;
 }
diff --git a/drivers/irqchip/irq-ls-extirq.c b/drivers/irqchip/irq-ls-extirq.c
index d8d48b1f7c29..139f26b0a6ef 100644
--- a/drivers/irqchip/irq-ls-extirq.c
+++ b/drivers/irqchip/irq-ls-extirq.c
@@ -203,7 +203,7 @@ ls_extirq_of_init(struct device_node *node, struct device=
_node *parent)
 	if (ret)
 		goto err_parse_map;
=20
-	priv->big_endian =3D of_device_is_big_endian(parent);
+	priv->big_endian =3D of_device_is_big_endian(node->parent);
 	priv->is_ls1021a_or_ls1043a =3D of_device_is_compatible(node, "fsl,ls1021a-=
extirq") ||
 				      of_device_is_compatible(node, "fsl,ls1043a-extirq");
 	raw_spin_lock_init(&priv->lock);
diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 1ba0f1555c80..1a6a7a672ad7 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -494,7 +494,7 @@ static int gic_irq_domain_map(struct irq_domain *d, unsig=
ned int virq,
 	map =3D GIC_MAP_PIN_MAP_TO_PIN | gic_cpu_pin;
=20
 	/*
-	 * If adding support for more per-cpu interrupts, keep the the
+	 * If adding support for more per-cpu interrupts, keep the
 	 * array in gic_all_vpes_irq_cpu_online() in sync.
 	 */
 	switch (intr) {
diff --git a/drivers/irqchip/irq-mtk-cirq.c b/drivers/irqchip/irq-mtk-cirq.c
index 9bca0918078e..76bc0283e3b9 100644
--- a/drivers/irqchip/irq-mtk-cirq.c
+++ b/drivers/irqchip/irq-mtk-cirq.c
@@ -15,14 +15,41 @@
 #include <linux/slab.h>
 #include <linux/syscore_ops.h>
=20
-#define CIRQ_ACK	0x40
-#define CIRQ_MASK_SET	0xc0
-#define CIRQ_MASK_CLR	0x100
-#define CIRQ_SENS_SET	0x180
-#define CIRQ_SENS_CLR	0x1c0
-#define CIRQ_POL_SET	0x240
-#define CIRQ_POL_CLR	0x280
-#define CIRQ_CONTROL	0x300
+enum mtk_cirq_regoffs_index {
+	CIRQ_STA,
+	CIRQ_ACK,
+	CIRQ_MASK_SET,
+	CIRQ_MASK_CLR,
+	CIRQ_SENS_SET,
+	CIRQ_SENS_CLR,
+	CIRQ_POL_SET,
+	CIRQ_POL_CLR,
+	CIRQ_CONTROL
+};
+
+static const u32 mtk_cirq_regoffs_v1[] =3D {
+	[CIRQ_STA]	=3D 0x0,
+	[CIRQ_ACK]	=3D 0x40,
+	[CIRQ_MASK_SET]	=3D 0xc0,
+	[CIRQ_MASK_CLR]	=3D 0x100,
+	[CIRQ_SENS_SET]	=3D 0x180,
+	[CIRQ_SENS_CLR]	=3D 0x1c0,
+	[CIRQ_POL_SET]	=3D 0x240,
+	[CIRQ_POL_CLR]	=3D 0x280,
+	[CIRQ_CONTROL]	=3D 0x300,
+};
+
+static const u32 mtk_cirq_regoffs_v2[] =3D {
+	[CIRQ_STA]	=3D 0x0,
+	[CIRQ_ACK]	=3D 0x80,
+	[CIRQ_MASK_SET]	=3D 0x180,
+	[CIRQ_MASK_CLR]	=3D 0x200,
+	[CIRQ_SENS_SET]	=3D 0x300,
+	[CIRQ_SENS_CLR]	=3D 0x380,
+	[CIRQ_POL_SET]	=3D 0x480,
+	[CIRQ_POL_CLR]	=3D 0x500,
+	[CIRQ_CONTROL]	=3D 0x600,
+};
=20
 #define CIRQ_EN	0x1
 #define CIRQ_EDGE	0x2
@@ -32,18 +59,32 @@ struct mtk_cirq_chip_data {
 	void __iomem *base;
 	unsigned int ext_irq_start;
 	unsigned int ext_irq_end;
+	const u32 *offsets;
 	struct irq_domain *domain;
 };
=20
 static struct mtk_cirq_chip_data *cirq_data;
=20
-static void mtk_cirq_write_mask(struct irq_data *data, unsigned int offset)
+static void __iomem *mtk_cirq_reg(struct mtk_cirq_chip_data *chip_data,
+				  enum mtk_cirq_regoffs_index idx)
+{
+	return chip_data->base + chip_data->offsets[idx];
+}
+
+static void __iomem *mtk_cirq_irq_reg(struct mtk_cirq_chip_data *chip_data,
+				      enum mtk_cirq_regoffs_index idx,
+				      unsigned int cirq_num)
+{
+	return mtk_cirq_reg(chip_data, idx) + (cirq_num / 32) * 4;
+}
+
+static void mtk_cirq_write_mask(struct irq_data *data, enum mtk_cirq_regoffs=
_index idx)
 {
 	struct mtk_cirq_chip_data *chip_data =3D data->chip_data;
 	unsigned int cirq_num =3D data->hwirq;
 	u32 mask =3D 1 << (cirq_num % 32);
=20
-	writel_relaxed(mask, chip_data->base + offset + (cirq_num / 32) * 4);
+	writel_relaxed(mask, mtk_cirq_irq_reg(chip_data, idx, cirq_num));
 }
=20
 static void mtk_cirq_mask(struct irq_data *data)
@@ -160,6 +201,7 @@ static const struct irq_domain_ops cirq_domain_ops =3D {
 #ifdef CONFIG_PM_SLEEP
 static int mtk_cirq_suspend(void)
 {
+	void __iomem *reg;
 	u32 value, mask;
 	unsigned int irq, hwirq_num;
 	bool pending, masked;
@@ -200,31 +242,34 @@ static int mtk_cirq_suspend(void)
 				continue;
 		}
=20
+		reg =3D mtk_cirq_irq_reg(cirq_data, CIRQ_ACK, i);
 		mask =3D 1 << (i % 32);
-		writel_relaxed(mask, cirq_data->base + CIRQ_ACK + (i / 32) * 4);
+		writel_relaxed(mask, reg);
 	}
=20
 	/* set edge_only mode, record edge-triggerd interrupts */
 	/* enable cirq */
-	value =3D readl_relaxed(cirq_data->base + CIRQ_CONTROL);
+	reg =3D mtk_cirq_reg(cirq_data, CIRQ_CONTROL);
+	value =3D readl_relaxed(reg);
 	value |=3D (CIRQ_EDGE | CIRQ_EN);
-	writel_relaxed(value, cirq_data->base + CIRQ_CONTROL);
+	writel_relaxed(value, reg);
=20
 	return 0;
 }
=20
 static void mtk_cirq_resume(void)
 {
+	void __iomem *reg =3D mtk_cirq_reg(cirq_data, CIRQ_CONTROL);
 	u32 value;
=20
 	/* flush recorded interrupts, will send signals to parent controller */
-	value =3D readl_relaxed(cirq_data->base + CIRQ_CONTROL);
-	writel_relaxed(value | CIRQ_FLUSH, cirq_data->base + CIRQ_CONTROL);
+	value =3D readl_relaxed(reg);
+	writel_relaxed(value | CIRQ_FLUSH, reg);
=20
 	/* disable cirq */
-	value =3D readl_relaxed(cirq_data->base + CIRQ_CONTROL);
+	value =3D readl_relaxed(reg);
 	value &=3D ~(CIRQ_EDGE | CIRQ_EN);
-	writel_relaxed(value, cirq_data->base + CIRQ_CONTROL);
+	writel_relaxed(value, reg);
 }
=20
 static struct syscore_ops mtk_cirq_syscore_ops =3D {
@@ -240,10 +285,19 @@ static void mtk_cirq_syscore_init(void)
 static inline void mtk_cirq_syscore_init(void) {}
 #endif
=20
+static const struct of_device_id mtk_cirq_of_match[] =3D {
+	{ .compatible =3D "mediatek,mt2701-cirq", .data =3D &mtk_cirq_regoffs_v1 },
+	{ .compatible =3D "mediatek,mt8135-cirq", .data =3D &mtk_cirq_regoffs_v1 },
+	{ .compatible =3D "mediatek,mt8173-cirq", .data =3D &mtk_cirq_regoffs_v1 },
+	{ .compatible =3D "mediatek,mt8192-cirq", .data =3D &mtk_cirq_regoffs_v2 },
+	{ /* sentinel */ }
+};
+
 static int __init mtk_cirq_of_init(struct device_node *node,
 				   struct device_node *parent)
 {
 	struct irq_domain *domain, *domain_parent;
+	const struct of_device_id *match;
 	unsigned int irq_num;
 	int ret;
=20
@@ -274,6 +328,13 @@ static int __init mtk_cirq_of_init(struct device_node *n=
ode,
 	if (ret)
 		goto out_unmap;
=20
+	match =3D of_match_node(mtk_cirq_of_match, node);
+	if (!match) {
+		ret =3D -ENODEV;
+		goto out_unmap;
+	}
+	cirq_data->offsets =3D match->data;
+
 	irq_num =3D cirq_data->ext_irq_end - cirq_data->ext_irq_start + 1;
 	domain =3D irq_domain_add_hierarchy(domain_parent, 0,
 					  irq_num, node,
diff --git a/drivers/irqchip/irq-mvebu-icu.c b/drivers/irqchip/irq-mvebu-icu.c
index 497da344717c..3c77acc7ec6a 100644
--- a/drivers/irqchip/irq-mvebu-icu.c
+++ b/drivers/irqchip/irq-mvebu-icu.c
@@ -151,9 +151,9 @@ static int
 mvebu_icu_irq_domain_translate(struct irq_domain *d, struct irq_fwspec *fwsp=
ec,
 			       unsigned long *hwirq, unsigned int *type)
 {
-	struct mvebu_icu_msi_data *msi_data =3D platform_msi_get_host_data(d);
-	struct mvebu_icu *icu =3D platform_msi_get_host_data(d);
 	unsigned int param_count =3D static_branch_unlikely(&legacy_bindings) ? 3 :=
 2;
+	struct mvebu_icu_msi_data *msi_data =3D platform_msi_get_host_data(d);
+	struct mvebu_icu *icu =3D msi_data->icu;
=20
 	/* Check the count of the parameters in dt */
 	if (WARN_ON(fwspec->param_count !=3D param_count)) {
diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-p=
lic.c
index 2f4784860df5..ff47bd0dec45 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -187,7 +187,8 @@ static struct irq_chip plic_edge_chip =3D {
 	.irq_set_affinity =3D plic_set_affinity,
 #endif
 	.irq_set_type	=3D plic_irq_set_type,
-	.flags		=3D IRQCHIP_AFFINITY_PRE_STARTUP,
+	.flags		=3D IRQCHIP_SKIP_SET_WAKE |
+			  IRQCHIP_AFFINITY_PRE_STARTUP,
 };
=20
 static struct irq_chip plic_chip =3D {
@@ -201,7 +202,8 @@ static struct irq_chip plic_chip =3D {
 	.irq_set_affinity =3D plic_set_affinity,
 #endif
 	.irq_set_type	=3D plic_irq_set_type,
-	.flags		=3D IRQCHIP_AFFINITY_PRE_STARTUP,
+	.flags		=3D IRQCHIP_SKIP_SET_WAKE |
+			  IRQCHIP_AFFINITY_PRE_STARTUP,
 };
=20
 static int plic_irq_set_type(struct irq_data *d, unsigned int type)
diff --git a/drivers/irqchip/irq-sl28cpld.c b/drivers/irqchip/irq-sl28cpld.c
index fbb354413ffa..f2172240172c 100644
--- a/drivers/irqchip/irq-sl28cpld.c
+++ b/drivers/irqchip/irq-sl28cpld.c
@@ -65,8 +65,7 @@ static int sl28cpld_intc_probe(struct platform_device *pdev)
 	irqchip->chip.num_irqs =3D ARRAY_SIZE(sl28cpld_irqs);
 	irqchip->chip.num_regs =3D 1;
 	irqchip->chip.status_base =3D base + INTC_IP;
-	irqchip->chip.mask_base =3D base + INTC_IE;
-	irqchip->chip.mask_invert =3D true;
+	irqchip->chip.unmask_base =3D base + INTC_IE;
 	irqchip->chip.ack_base =3D base + INTC_IP;
=20
 	return devm_regmap_add_irq_chip_fwnode(dev, dev_fwnode(dev),
diff --git a/drivers/irqchip/irq-st.c b/drivers/irqchip/irq-st.c
index 801551e46a7b..1b83512b29c6 100644
--- a/drivers/irqchip/irq-st.c
+++ b/drivers/irqchip/irq-st.c
@@ -153,18 +153,13 @@ static int st_irq_syscfg_enable(struct platform_device =
*pdev)
 static int st_irq_syscfg_probe(struct platform_device *pdev)
 {
 	struct device_node *np =3D pdev->dev.of_node;
-	const struct of_device_id *match;
 	struct st_irq_syscfg *ddata;
=20
 	ddata =3D devm_kzalloc(&pdev->dev, sizeof(*ddata), GFP_KERNEL);
 	if (!ddata)
 		return -ENOMEM;
=20
-	match =3D of_match_device(st_irq_syscfg_match, &pdev->dev);
-	if (!match)
-		return -ENODEV;
-
-	ddata->syscfg =3D (unsigned int)match->data;
+	ddata->syscfg =3D (unsigned int) device_get_match_data(&pdev->dev);
=20
 	ddata->regmap =3D syscon_regmap_lookup_by_phandle(np, "st,syscfg");
 	if (IS_ERR(ddata->regmap)) {
diff --git a/drivers/irqchip/irq-ti-sci-inta.c b/drivers/irqchip/irq-ti-sci-i=
nta.c
index 5fdbb4358dd0..a6ecc53d055c 100644
--- a/drivers/irqchip/irq-ti-sci-inta.c
+++ b/drivers/irqchip/irq-ti-sci-inta.c
@@ -168,7 +168,7 @@ static void ti_sci_inta_irq_handler(struct irq_desc *desc)
 /**
  * ti_sci_inta_xlate_irq() - Translate hwirq to parent's hwirq.
  * @inta:	IRQ domain corresponding to Interrupt Aggregator
- * @irq:	Hardware irq corresponding to the above irq domain
+ * @vint_id:	Hardware irq corresponding to the above irq domain
  *
  * Return parent irq number if translation is available else -ENOENT.
  */
diff --git a/drivers/irqchip/irq-wpcm450-aic.c b/drivers/irqchip/irq-wpcm450-=
aic.c
index 0dcbeb1a05a1..91df62a64cd9 100644
--- a/drivers/irqchip/irq-wpcm450-aic.c
+++ b/drivers/irqchip/irq-wpcm450-aic.c
@@ -146,6 +146,7 @@ static int __init wpcm450_aic_of_init(struct device_node =
*node,
 	aic->regs =3D of_iomap(node, 0);
 	if (!aic->regs) {
 		pr_err("Failed to map WPCM450 AIC registers\n");
+		kfree(aic);
 		return -ENOMEM;
 	}
=20
diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 05d6fae800e3..d7af896cbd7b 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -223,7 +223,7 @@ config BCM_FLEXRM_MBOX
 	tristate "Broadcom FlexRM Mailbox"
 	depends on ARM64
 	depends on ARCH_BCM_IPROC || COMPILE_TEST
-	select GENERIC_MSI_IRQ_DOMAIN
+	select GENERIC_MSI_IRQ
 	default m if ARCH_BCM_IPROC
 	help
 	  Mailbox implementation of the Broadcom FlexRM ring manager,
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 55c028af4bd9..9309f2469b41 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -51,11 +51,6 @@ config PCI_MSI
=20
 	   If you don't know what to do here, say Y.
=20
-config PCI_MSI_IRQ_DOMAIN
-	def_bool y
-	depends on PCI_MSI
-	select GENERIC_MSI_IRQ_DOMAIN
-
 config PCI_MSI_ARCH_FALLBACKS
 	bool
=20
@@ -192,7 +187,7 @@ config PCI_LABEL
=20
 config PCI_HYPERV
 	tristate "Hyper-V PCI Frontend"
-	depends on ((X86 && X86_64) || ARM64) && HYPERV && PCI_MSI && PCI_MSI_IRQ_D=
OMAIN && SYSFS
+	depends on ((X86 && X86_64) || ARM64) && HYPERV && PCI_MSI && SYSFS
 	select PCI_HYPERV_INTERFACE
 	help
 	  The PCI device frontend driver allows the kernel to import arbitrary
diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index bfd9bac37e24..1569d9a3ada0 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -19,7 +19,7 @@ config PCI_AARDVARK
 	tristate "Aardvark PCIe controller"
 	depends on (ARCH_MVEBU && ARM64) || COMPILE_TEST
 	depends on OF
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	select PCI_BRIDGE_EMUL
 	help
 	 Add support for Aardvark 64bit PCIe Host Controller. This
@@ -29,7 +29,7 @@ config PCI_AARDVARK
 config PCIE_XILINX_NWL
 	bool "NWL PCIe Core"
 	depends on ARCH_ZYNQMP || COMPILE_TEST
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	help
 	 Say 'Y' here if you want kernel support for Xilinx
 	 NWL PCIe controller. The controller can act as Root Port
@@ -53,7 +53,7 @@ config PCI_IXP4XX
 config PCI_TEGRA
 	bool "NVIDIA Tegra PCIe controller"
 	depends on ARCH_TEGRA || COMPILE_TEST
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	help
 	  Say Y here if you want support for the PCIe host controller found
 	  on NVIDIA Tegra SoCs.
@@ -70,7 +70,7 @@ config PCI_RCAR_GEN2
 config PCIE_RCAR_HOST
 	bool "Renesas R-Car PCIe host controller"
 	depends on ARCH_RENESAS || COMPILE_TEST
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	help
 	  Say Y here if you want PCIe controller support on R-Car SoCs in host
 	  mode.
@@ -99,7 +99,7 @@ config PCI_HOST_GENERIC
 config PCIE_XILINX
 	bool "Xilinx AXI PCIe host bridge support"
 	depends on OF || COMPILE_TEST
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	help
 	  Say 'Y' here if you want kernel to support the Xilinx AXI PCIe
 	  Host Bridge driver.
@@ -124,7 +124,7 @@ config PCI_XGENE
 config PCI_XGENE_MSI
 	bool "X-Gene v1 PCIe MSI feature"
 	depends on PCI_XGENE
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	default y
 	help
 	  Say Y here if you want PCIe MSI support for the APM X-Gene v1 SoC.
@@ -170,7 +170,7 @@ config PCIE_IPROC_BCMA
 config PCIE_IPROC_MSI
 	bool "Broadcom iProc PCIe MSI support"
 	depends on PCIE_IPROC_PLATFORM || PCIE_IPROC_BCMA
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	default ARCH_BCM_IPROC
 	help
 	  Say Y here if you want to enable MSI support for Broadcom's iProc
@@ -186,7 +186,7 @@ config PCIE_ALTERA
 config PCIE_ALTERA_MSI
 	tristate "Altera PCIe MSI feature"
 	depends on PCIE_ALTERA
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	help
 	  Say Y here if you want PCIe MSI support for the Altera FPGA.
 	  This MSI driver supports Altera MSI to GIC controller IP.
@@ -215,7 +215,7 @@ config PCIE_ROCKCHIP_HOST
 	tristate "Rockchip PCIe host controller"
 	depends on ARCH_ROCKCHIP || COMPILE_TEST
 	depends on OF
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	select MFD_SYSCON
 	select PCIE_ROCKCHIP
 	help
@@ -239,7 +239,7 @@ config PCIE_MEDIATEK
 	tristate "MediaTek PCIe controller"
 	depends on ARCH_AIROHA || ARCH_MEDIATEK || COMPILE_TEST
 	depends on OF
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	help
 	  Say Y here if you want to enable PCIe controller support on
 	  MediaTek SoCs.
@@ -247,7 +247,7 @@ config PCIE_MEDIATEK
 config PCIE_MEDIATEK_GEN3
 	tristate "MediaTek Gen3 PCIe controller"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	help
 	  Adds support for PCIe Gen3 MAC controller for MediaTek SoCs.
 	  This PCIe controller is compatible with Gen3, Gen2 and Gen1 speed,
@@ -277,7 +277,7 @@ config PCIE_BRCMSTB
 	depends on ARCH_BRCMSTB || ARCH_BCM2835 || ARCH_BCMBCA || \
 		   BMIPS_GENERIC || COMPILE_TEST
 	depends on OF
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	default ARCH_BRCMSTB || BMIPS_GENERIC
 	help
 	  Say Y here to enable PCIe host controller support for
@@ -285,7 +285,7 @@ config PCIE_BRCMSTB
=20
 config PCI_HYPERV_INTERFACE
 	tristate "Hyper-V PCI Interface"
-	depends on ((X86 && X86_64) || ARM64) && HYPERV && PCI_MSI && PCI_MSI_IRQ_D=
OMAIN
+	depends on ((X86 && X86_64) || ARM64) && HYPERV && PCI_MSI && PCI_MSI
 	help
 	  The Hyper-V PCI Interface is a helper driver allows other drivers to
 	  have a common interface with the Hyper-V PCI frontend driver.
@@ -303,8 +303,6 @@ config PCI_LOONGSON
 config PCIE_MICROCHIP_HOST
 	bool "Microchip AXI PCIe host bridge support"
 	depends on PCI_MSI && OF
-	select PCI_MSI_IRQ_DOMAIN
-	select GENERIC_MSI_IRQ_DOMAIN
 	select PCI_HOST_COMMON
 	help
 	  Say Y here if you want kernel to support the Microchip AXI PCIe
@@ -326,7 +324,7 @@ config PCIE_APPLE
 	tristate "Apple PCIe controller"
 	depends on ARCH_APPLE || COMPILE_TEST
 	depends on OF
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	select PCI_HOST_COMMON
 	help
 	  Say Y here if you want to enable PCIe controller support on Apple
diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/=
Kconfig
index 62ce3abf0f19..f3c462130627 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -21,7 +21,7 @@ config PCI_DRA7XX_HOST
 	tristate "TI DRA7xx PCIe controller Host Mode"
 	depends on SOC_DRA7XX || COMPILE_TEST
 	depends on OF && HAS_IOMEM && TI_PIPE3
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	select PCIE_DW_HOST
 	select PCI_DRA7XX
 	default y if SOC_DRA7XX
@@ -53,7 +53,7 @@ config PCIE_DW_PLAT
=20
 config PCIE_DW_PLAT_HOST
 	bool "Platform bus based DesignWare PCIe Controller - Host mode"
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	select PCIE_DW_HOST
 	select PCIE_DW_PLAT
 	help
@@ -67,7 +67,7 @@ config PCIE_DW_PLAT_HOST
=20
 config PCIE_DW_PLAT_EP
 	bool "Platform bus based DesignWare PCIe Controller - Endpoint mode"
-	depends on PCI && PCI_MSI_IRQ_DOMAIN
+	depends on PCI && PCI_MSI
 	depends on PCI_ENDPOINT
 	select PCIE_DW_EP
 	select PCIE_DW_PLAT
@@ -83,7 +83,7 @@ config PCIE_DW_PLAT_EP
 config PCI_EXYNOS
 	tristate "Samsung Exynos PCIe controller"
 	depends on ARCH_EXYNOS || COMPILE_TEST
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	select PCIE_DW_HOST
 	help
 	  Enables support for the PCIe controller in the Samsung Exynos SoCs
@@ -94,13 +94,13 @@ config PCI_EXYNOS
 config PCI_IMX6
 	bool "Freescale i.MX6/7/8 PCIe controller"
 	depends on ARCH_MXC || COMPILE_TEST
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	select PCIE_DW_HOST
=20
 config PCIE_SPEAR13XX
 	bool "STMicroelectronics SPEAr PCIe controller"
 	depends on ARCH_SPEAR13XX || COMPILE_TEST
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	select PCIE_DW_HOST
 	help
 	  Say Y here if you want PCIe support on SPEAr13XX SoCs.
@@ -111,7 +111,7 @@ config PCI_KEYSTONE
 config PCI_KEYSTONE_HOST
 	bool "PCI Keystone Host Mode"
 	depends on ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	select PCIE_DW_HOST
 	select PCI_KEYSTONE
 	help
@@ -135,7 +135,7 @@ config PCI_KEYSTONE_EP
 config PCI_LAYERSCAPE
 	bool "Freescale Layerscape PCIe controller - Host mode"
 	depends on OF && (ARM || ARCH_LAYERSCAPE || COMPILE_TEST)
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	select PCIE_DW_HOST
 	select MFD_SYSCON
 	help
@@ -160,7 +160,7 @@ config PCI_LAYERSCAPE_EP
 config PCI_HISI
 	depends on OF && (ARM64 || COMPILE_TEST)
 	bool "HiSilicon Hip05 and Hip06 SoCs PCIe controllers"
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	select PCIE_DW_HOST
 	select PCI_HOST_COMMON
 	help
@@ -170,7 +170,7 @@ config PCI_HISI
 config PCIE_QCOM
 	bool "Qualcomm PCIe controller"
 	depends on OF && (ARCH_QCOM || COMPILE_TEST)
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	select PCIE_DW_HOST
 	select CRC8
 	help
@@ -191,7 +191,7 @@ config PCIE_QCOM_EP
 config PCIE_ARMADA_8K
 	bool "Marvell Armada-8K PCIe controller"
 	depends on ARCH_MVEBU || COMPILE_TEST
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	select PCIE_DW_HOST
 	help
 	  Say Y here if you want to enable PCIe controller support on
@@ -205,7 +205,7 @@ config PCIE_ARTPEC6
 config PCIE_ARTPEC6_HOST
 	bool "Axis ARTPEC-6 PCIe controller Host Mode"
 	depends on MACH_ARTPEC6 || COMPILE_TEST
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	select PCIE_DW_HOST
 	select PCIE_ARTPEC6
 	help
@@ -226,7 +226,7 @@ config PCIE_ROCKCHIP_DW_HOST
 	bool "Rockchip DesignWare PCIe controller"
 	select PCIE_DW
 	select PCIE_DW_HOST
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	depends on ARCH_ROCKCHIP || COMPILE_TEST
 	depends on OF
 	help
@@ -236,7 +236,7 @@ config PCIE_ROCKCHIP_DW_HOST
 config PCIE_INTEL_GW
 	bool "Intel Gateway PCIe host controller support"
 	depends on OF && (X86 || COMPILE_TEST)
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	select PCIE_DW_HOST
 	help
 	  Say 'Y' here to enable PCIe Host controller support on Intel
@@ -250,7 +250,7 @@ config PCIE_KEEMBAY
 config PCIE_KEEMBAY_HOST
 	bool "Intel Keem Bay PCIe controller - Host mode"
 	depends on ARCH_KEEMBAY || COMPILE_TEST
-	depends on PCI && PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	select PCIE_DW_HOST
 	select PCIE_KEEMBAY
 	help
@@ -262,7 +262,7 @@ config PCIE_KEEMBAY_HOST
 config PCIE_KEEMBAY_EP
 	bool "Intel Keem Bay PCIe controller - Endpoint mode"
 	depends on ARCH_KEEMBAY || COMPILE_TEST
-	depends on PCI && PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	depends on PCI_ENDPOINT
 	select PCIE_DW_EP
 	select PCIE_KEEMBAY
@@ -275,7 +275,7 @@ config PCIE_KEEMBAY_EP
 config PCIE_KIRIN
 	depends on OF && (ARM64 || COMPILE_TEST)
 	tristate "HiSilicon Kirin series SoCs PCIe controllers"
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	select PCIE_DW_HOST
 	help
 	  Say Y here if you want PCIe controller support
@@ -284,7 +284,7 @@ config PCIE_KIRIN
 config PCIE_HISI_STB
 	bool "HiSilicon STB SoCs PCIe controllers"
 	depends on ARCH_HISI || COMPILE_TEST
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	select PCIE_DW_HOST
 	help
 	  Say Y here if you want PCIe controller support on HiSilicon STB SoCs
@@ -292,7 +292,7 @@ config PCIE_HISI_STB
 config PCI_MESON
 	tristate "MESON PCIe controller"
 	default m if ARCH_MESON
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	select PCIE_DW_HOST
 	help
 	  Say Y here if you want to enable PCI controller support on Amlogic
@@ -306,7 +306,7 @@ config PCIE_TEGRA194
 config PCIE_TEGRA194_HOST
 	tristate "NVIDIA Tegra194 (and later) PCIe controller - Host Mode"
 	depends on ARCH_TEGRA_194_SOC || COMPILE_TEST
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	select PCIE_DW_HOST
 	select PHY_TEGRA194_P2U
 	select PCIE_TEGRA194
@@ -336,7 +336,7 @@ config PCIE_TEGRA194_EP
 config PCIE_VISCONTI_HOST
 	bool "Toshiba Visconti PCIe controllers"
 	depends on ARCH_VISCONTI || COMPILE_TEST
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	select PCIE_DW_HOST
 	help
 	  Say Y here if you want PCIe controller support on Toshiba Visconti SoC.
@@ -346,7 +346,7 @@ config PCIE_UNIPHIER
 	bool "Socionext UniPhier PCIe host controllers"
 	depends on ARCH_UNIPHIER || COMPILE_TEST
 	depends on OF && HAS_IOMEM
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	select PCIE_DW_HOST
 	help
 	  Say Y here if you want PCIe host controller support on UniPhier SoCs.
@@ -365,7 +365,7 @@ config PCIE_UNIPHIER_EP
 config PCIE_AL
 	bool "Amazon Annapurna Labs PCIe controller"
 	depends on OF && (ARM64 || COMPILE_TEST)
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	select PCIE_DW_HOST
 	select PCI_ECAM
 	help
@@ -377,7 +377,7 @@ config PCIE_AL
=20
 config PCIE_FU740
 	bool "SiFive FU740 PCIe host controller"
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	depends on SOC_SIFIVE || COMPILE_TEST
 	select PCIE_DW_HOST
 	help
diff --git a/drivers/pci/controller/mobiveil/Kconfig b/drivers/pci/controller=
/mobiveil/Kconfig
index e4643fb94e78..1d7a07ba9ccd 100644
--- a/drivers/pci/controller/mobiveil/Kconfig
+++ b/drivers/pci/controller/mobiveil/Kconfig
@@ -8,14 +8,14 @@ config PCIE_MOBIVEIL
=20
 config PCIE_MOBIVEIL_HOST
 	bool
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	select PCIE_MOBIVEIL
=20
 config PCIE_MOBIVEIL_PLAT
 	bool "Mobiveil AXI PCIe controller"
 	depends on ARCH_ZYNQMP || COMPILE_TEST
 	depends on OF
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	select PCIE_MOBIVEIL_HOST
 	help
 	  Say Y here if you want to enable support for the Mobiveil AXI PCIe
@@ -25,7 +25,7 @@ config PCIE_MOBIVEIL_PLAT
 config PCIE_LAYERSCAPE_GEN4
 	bool "Freescale Layerscape PCIe Gen4 controller"
 	depends on ARCH_LAYERSCAPE || COMPILE_TEST
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	select PCIE_MOBIVEIL_HOST
 	help
 	  Say Y here if you want PCIe Gen4 controller support on
diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci=
-hyperv.c
index ba64284eaf9f..1dee55d16a4d 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -611,20 +611,7 @@ static unsigned int hv_msi_get_int_vector(struct irq_dat=
a *data)
 	return cfg->vector;
 }
=20
-static int hv_msi_prepare(struct irq_domain *domain, struct device *dev,
-			  int nvec, msi_alloc_info_t *info)
-{
-	int ret =3D pci_msi_prepare(domain, dev, nvec, info);
-
-	/*
-	 * By using the interrupt remapper in the hypervisor IOMMU, contiguous
-	 * CPU vectors is not needed for multi-MSI
-	 */
-	if (info->type =3D=3D X86_IRQ_ALLOC_TYPE_PCI_MSI)
-		info->flags &=3D ~X86_IRQ_ALLOC_CONTIGUOUS_VECTORS;
-
-	return ret;
-}
+#define hv_msi_prepare		pci_msi_prepare
=20
 /**
  * hv_arch_irq_unmask() - "Unmask" the IRQ by setting its current
diff --git a/drivers/pci/msi/Makefile b/drivers/pci/msi/Makefile
index 93ef7b9e404d..839ff72d72a8 100644
--- a/drivers/pci/msi/Makefile
+++ b/drivers/pci/msi/Makefile
@@ -2,6 +2,5 @@
 #
 # Makefile for the PCI/MSI
 obj-$(CONFIG_PCI)			+=3D pcidev_msi.o
-obj-$(CONFIG_PCI_MSI)			+=3D msi.o
-obj-$(CONFIG_PCI_MSI_IRQ_DOMAIN)	+=3D irqdomain.o
+obj-$(CONFIG_PCI_MSI)			+=3D api.o msi.o irqdomain.o
 obj-$(CONFIG_PCI_MSI_ARCH_FALLBACKS)	+=3D legacy.o
diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
new file mode 100644
index 000000000000..b8009aa11f3c
--- /dev/null
+++ b/drivers/pci/msi/api.c
@@ -0,0 +1,458 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCI MSI/MSI-X =E2=80=94 Exported APIs for device drivers
+ *
+ * Copyright (C) 2003-2004 Intel
+ * Copyright (C) Tom Long Nguyen (tom.l.nguyen@intel.com)
+ * Copyright (C) 2016 Christoph Hellwig.
+ * Copyright (C) 2022 Linutronix GmbH
+ */
+
+#include <linux/export.h>
+#include <linux/irq.h>
+
+#include "msi.h"
+
+/**
+ * pci_enable_msi() - Enable MSI interrupt mode on device
+ * @dev: the PCI device to operate on
+ *
+ * Legacy device driver API to enable MSI interrupts mode on device and
+ * allocate a single interrupt vector. On success, the allocated vector
+ * Linux IRQ will be saved at @dev->irq. The driver must invoke
+ * pci_disable_msi() on cleanup.
+ *
+ * NOTE: The newer pci_alloc_irq_vectors() / pci_free_irq_vectors() API
+ * pair should, in general, be used instead.
+ *
+ * Return: 0 on success, errno otherwise
+ */
+int pci_enable_msi(struct pci_dev *dev)
+{
+	int rc =3D __pci_enable_msi_range(dev, 1, 1, NULL);
+	if (rc < 0)
+		return rc;
+	return 0;
+}
+EXPORT_SYMBOL(pci_enable_msi);
+
+/**
+ * pci_disable_msi() - Disable MSI interrupt mode on device
+ * @dev: the PCI device to operate on
+ *
+ * Legacy device driver API to disable MSI interrupt mode on device,
+ * free earlier allocated interrupt vectors, and restore INTx emulation.
+ * The PCI device Linux IRQ (@dev->irq) is restored to its default
+ * pin-assertion IRQ. This is the cleanup pair of pci_enable_msi().
+ *
+ * NOTE: The newer pci_alloc_irq_vectors() / pci_free_irq_vectors() API
+ * pair should, in general, be used instead.
+ */
+void pci_disable_msi(struct pci_dev *dev)
+{
+	if (!pci_msi_enabled() || !dev || !dev->msi_enabled)
+		return;
+
+	msi_lock_descs(&dev->dev);
+	pci_msi_shutdown(dev);
+	pci_free_msi_irqs(dev);
+	msi_unlock_descs(&dev->dev);
+}
+EXPORT_SYMBOL(pci_disable_msi);
+
+/**
+ * pci_msix_vec_count() - Get number of MSI-X interrupt vectors on device
+ * @dev: the PCI device to operate on
+ *
+ * Return: number of MSI-X interrupt vectors available on this device
+ * (i.e., the device's MSI-X capability structure "table size"), -EINVAL
+ * if the device is not MSI-X capable, other errnos otherwise.
+ */
+int pci_msix_vec_count(struct pci_dev *dev)
+{
+	u16 control;
+
+	if (!dev->msix_cap)
+		return -EINVAL;
+
+	pci_read_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, &control);
+	return msix_table_size(control);
+}
+EXPORT_SYMBOL(pci_msix_vec_count);
+
+/**
+ * pci_enable_msix_range() - Enable MSI-X interrupt mode on device
+ * @dev:     the PCI device to operate on
+ * @entries: input/output parameter, array of MSI-X configuration entries
+ * @minvec:  minimum required number of MSI-X vectors
+ * @maxvec:  maximum desired number of MSI-X vectors
+ *
+ * Legacy device driver API to enable MSI-X interrupt mode on device and
+ * configure its MSI-X capability structure as appropriate.  The passed
+ * @entries array must have each of its members "entry" field set to a
+ * desired (valid) MSI-X vector number, where the range of valid MSI-X
+ * vector numbers can be queried through pci_msix_vec_count().  If
+ * successful, the driver must invoke pci_disable_msix() on cleanup.
+ *
+ * NOTE: The newer pci_alloc_irq_vectors() / pci_free_irq_vectors() API
+ * pair should, in general, be used instead.
+ *
+ * Return: number of MSI-X vectors allocated (which might be smaller
+ * than @maxvecs), where Linux IRQ numbers for such allocated vectors
+ * are saved back in the @entries array elements' "vector" field. Return
+ * -ENOSPC if less than @minvecs interrupt vectors are available.
+ * Return -EINVAL if one of the passed @entries members "entry" field
+ * was invalid or a duplicate, or if plain MSI interrupts mode was
+ * earlier enabled on device. Return other errnos otherwise.
+ */
+int pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries,
+			  int minvec, int maxvec)
+{
+	return __pci_enable_msix_range(dev, entries, minvec, maxvec, NULL, 0);
+}
+EXPORT_SYMBOL(pci_enable_msix_range);
+
+/**
+ * pci_msix_can_alloc_dyn - Query whether dynamic allocation after enabling
+ *			    MSI-X is supported
+ *
+ * @dev:	PCI device to operate on
+ *
+ * Return: True if supported, false otherwise
+ */
+bool pci_msix_can_alloc_dyn(struct pci_dev *dev)
+{
+	if (!dev->msix_cap)
+		return false;
+
+	return pci_msi_domain_supports(dev, MSI_FLAG_PCI_MSIX_ALLOC_DYN, DENY_LEGAC=
Y);
+}
+EXPORT_SYMBOL_GPL(pci_msix_can_alloc_dyn);
+
+/**
+ * pci_msix_alloc_irq_at - Allocate an MSI-X interrupt after enabling MSI-X
+ *			   at a given MSI-X vector index or any free vector index
+ *
+ * @dev:	PCI device to operate on
+ * @index:	Index to allocate. If @index =3D=3D MSI_ANY_INDEX this allocates
+ *		the next free index in the MSI-X table
+ * @affdesc:	Optional pointer to an affinity descriptor structure. NULL othe=
rwise
+ *
+ * Return: A struct msi_map
+ *
+ *	On success msi_map::index contains the allocated index (>=3D 0) and
+ *	msi_map::virq contains the allocated Linux interrupt number (> 0).
+ *
+ *	On fail msi_map::index contains the error code and msi_map::virq
+ *	is set to 0.
+ */
+struct msi_map pci_msix_alloc_irq_at(struct pci_dev *dev, unsigned int index,
+				     const struct irq_affinity_desc *affdesc)
+{
+	struct msi_map map =3D { .index =3D -ENOTSUPP };
+
+	if (!dev->msix_enabled)
+		return map;
+
+	if (!pci_msix_can_alloc_dyn(dev))
+		return map;
+
+	return msi_domain_alloc_irq_at(&dev->dev, MSI_DEFAULT_DOMAIN, index, affdes=
c, NULL);
+}
+EXPORT_SYMBOL_GPL(pci_msix_alloc_irq_at);
+
+/**
+ * pci_msix_free_irq - Free an interrupt on a PCI/MSIX interrupt domain
+ *		      which was allocated via pci_msix_alloc_irq_at()
+ *
+ * @dev:	The PCI device to operate on
+ * @map:	A struct msi_map describing the interrupt to free
+ *		as returned from the allocation function.
+ */
+void pci_msix_free_irq(struct pci_dev *dev, struct msi_map map)
+{
+	if (WARN_ON_ONCE(map.index < 0 || map.virq <=3D 0))
+		return;
+	if (WARN_ON_ONCE(!pci_msix_can_alloc_dyn(dev)))
+		return;
+	msi_domain_free_irqs_range(&dev->dev, MSI_DEFAULT_DOMAIN, map.index, map.in=
dex);
+}
+EXPORT_SYMBOL_GPL(pci_msix_free_irq);
+
+/**
+ * pci_disable_msix() - Disable MSI-X interrupt mode on device
+ * @dev: the PCI device to operate on
+ *
+ * Legacy device driver API to disable MSI-X interrupt mode on device,
+ * free earlier-allocated interrupt vectors, and restore INTx.
+ * The PCI device Linux IRQ (@dev->irq) is restored to its default pin
+ * assertion IRQ. This is the cleanup pair of pci_enable_msix_range().
+ *
+ * NOTE: The newer pci_alloc_irq_vectors() / pci_free_irq_vectors() API
+ * pair should, in general, be used instead.
+ */
+void pci_disable_msix(struct pci_dev *dev)
+{
+	if (!pci_msi_enabled() || !dev || !dev->msix_enabled)
+		return;
+
+	msi_lock_descs(&dev->dev);
+	pci_msix_shutdown(dev);
+	pci_free_msi_irqs(dev);
+	msi_unlock_descs(&dev->dev);
+}
+EXPORT_SYMBOL(pci_disable_msix);
+
+/**
+ * pci_alloc_irq_vectors() - Allocate multiple device interrupt vectors
+ * @dev:      the PCI device to operate on
+ * @min_vecs: minimum required number of vectors (must be >=3D 1)
+ * @max_vecs: maximum desired number of vectors
+ * @flags:    One or more of:
+ *
+ *            * %PCI_IRQ_MSIX      Allow trying MSI-X vector allocations
+ *            * %PCI_IRQ_MSI       Allow trying MSI vector allocations
+ *
+ *            * %PCI_IRQ_LEGACY    Allow trying legacy INTx interrupts, if
+ *              and only if @min_vecs =3D=3D 1
+ *
+ *            * %PCI_IRQ_AFFINITY  Auto-manage IRQs affinity by spreading
+ *              the vectors around available CPUs
+ *
+ * Allocate up to @max_vecs interrupt vectors on device. MSI-X irq
+ * vector allocation has a higher precedence over plain MSI, which has a
+ * higher precedence over legacy INTx emulation.
+ *
+ * Upon a successful allocation, the caller should use pci_irq_vector()
+ * to get the Linux IRQ number to be passed to request_threaded_irq().
+ * The driver must call pci_free_irq_vectors() on cleanup.
+ *
+ * Return: number of allocated vectors (which might be smaller than
+ * @max_vecs), -ENOSPC if less than @min_vecs interrupt vectors are
+ * available, other errnos otherwise.
+ */
+int pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
+			  unsigned int max_vecs, unsigned int flags)
+{
+	return pci_alloc_irq_vectors_affinity(dev, min_vecs, max_vecs,
+					      flags, NULL);
+}
+EXPORT_SYMBOL(pci_alloc_irq_vectors);
+
+/**
+ * pci_alloc_irq_vectors_affinity() - Allocate multiple device interrupt
+ *                                    vectors with affinity requirements
+ * @dev:      the PCI device to operate on
+ * @min_vecs: minimum required number of vectors (must be >=3D 1)
+ * @max_vecs: maximum desired number of vectors
+ * @flags:    allocation flags, as in pci_alloc_irq_vectors()
+ * @affd:     affinity requirements (can be %NULL).
+ *
+ * Same as pci_alloc_irq_vectors(), but with the extra @affd parameter.
+ * Check that function docs, and &struct irq_affinity, for more details.
+ */
+int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vec=
s,
+				   unsigned int max_vecs, unsigned int flags,
+				   struct irq_affinity *affd)
+{
+	struct irq_affinity msi_default_affd =3D {0};
+	int nvecs =3D -ENOSPC;
+
+	if (flags & PCI_IRQ_AFFINITY) {
+		if (!affd)
+			affd =3D &msi_default_affd;
+	} else {
+		if (WARN_ON(affd))
+			affd =3D NULL;
+	}
+
+	if (flags & PCI_IRQ_MSIX) {
+		nvecs =3D __pci_enable_msix_range(dev, NULL, min_vecs, max_vecs,
+						affd, flags);
+		if (nvecs > 0)
+			return nvecs;
+	}
+
+	if (flags & PCI_IRQ_MSI) {
+		nvecs =3D __pci_enable_msi_range(dev, min_vecs, max_vecs, affd);
+		if (nvecs > 0)
+			return nvecs;
+	}
+
+	/* use legacy IRQ if allowed */
+	if (flags & PCI_IRQ_LEGACY) {
+		if (min_vecs =3D=3D 1 && dev->irq) {
+			/*
+			 * Invoke the affinity spreading logic to ensure that
+			 * the device driver can adjust queue configuration
+			 * for the single interrupt case.
+			 */
+			if (affd)
+				irq_create_affinity_masks(1, affd);
+			pci_intx(dev, 1);
+			return 1;
+		}
+	}
+
+	return nvecs;
+}
+EXPORT_SYMBOL(pci_alloc_irq_vectors_affinity);
+
+/**
+ * pci_irq_vector() - Get Linux IRQ number of a device interrupt vector
+ * @dev: the PCI device to operate on
+ * @nr:  device-relative interrupt vector index (0-based); has different
+ *       meanings, depending on interrupt mode:
+ *
+ *         * MSI-X     the index in the MSI-X vector table
+ *         * MSI       the index of the enabled MSI vectors
+ *         * INTx      must be 0
+ *
+ * Return: the Linux IRQ number, or -EINVAL if @nr is out of range
+ */
+int pci_irq_vector(struct pci_dev *dev, unsigned int nr)
+{
+	unsigned int irq;
+
+	if (!dev->msi_enabled && !dev->msix_enabled)
+		return !nr ? dev->irq : -EINVAL;
+
+	irq =3D msi_get_virq(&dev->dev, nr);
+	return irq ? irq : -EINVAL;
+}
+EXPORT_SYMBOL(pci_irq_vector);
+
+/**
+ * pci_irq_get_affinity() - Get a device interrupt vector affinity
+ * @dev: the PCI device to operate on
+ * @nr:  device-relative interrupt vector index (0-based); has different
+ *       meanings, depending on interrupt mode:
+ *
+ *         * MSI-X     the index in the MSI-X vector table
+ *         * MSI       the index of the enabled MSI vectors
+ *         * INTx      must be 0
+ *
+ * Return: MSI/MSI-X vector affinity, NULL if @nr is out of range or if
+ * the MSI(-X) vector was allocated without explicit affinity
+ * requirements (e.g., by pci_enable_msi(), pci_enable_msix_range(), or
+ * pci_alloc_irq_vectors() without the %PCI_IRQ_AFFINITY flag). Return a
+ * generic set of CPU IDs representing all possible CPUs available
+ * during system boot if the device is in legacy INTx mode.
+ */
+const struct cpumask *pci_irq_get_affinity(struct pci_dev *dev, int nr)
+{
+	int idx, irq =3D pci_irq_vector(dev, nr);
+	struct msi_desc *desc;
+
+	if (WARN_ON_ONCE(irq <=3D 0))
+		return NULL;
+
+	desc =3D irq_get_msi_desc(irq);
+	/* Non-MSI does not have the information handy */
+	if (!desc)
+		return cpu_possible_mask;
+
+	/* MSI[X] interrupts can be allocated without affinity descriptor */
+	if (!desc->affinity)
+		return NULL;
+
+	/*
+	 * MSI has a mask array in the descriptor.
+	 * MSI-X has a single mask.
+	 */
+	idx =3D dev->msi_enabled ? nr : 0;
+	return &desc->affinity[idx].mask;
+}
+EXPORT_SYMBOL(pci_irq_get_affinity);
+
+/**
+ * pci_ims_alloc_irq - Allocate an interrupt on a PCI/IMS interrupt domain
+ * @dev:	The PCI device to operate on
+ * @icookie:	Pointer to an IMS implementation specific cookie for this
+ *		IMS instance (PASID, queue ID, pointer...).
+ *		The cookie content is copied into the MSI descriptor for the
+ *		interrupt chip callbacks or domain specific setup functions.
+ * @affdesc:	Optional pointer to an interrupt affinity descriptor
+ *
+ * There is no index for IMS allocations as IMS is an implementation
+ * specific storage and does not have any direct associations between
+ * index, which might be a pure software construct, and device
+ * functionality. This association is established by the driver either via
+ * the index - if there is a hardware table - or in case of purely software
+ * managed IMS implementation the association happens via the
+ * irq_write_msi_msg() callback of the implementation specific interrupt
+ * chip, which utilizes the provided @icookie to store the MSI message in
+ * the appropriate place.
+ *
+ * Return: A struct msi_map
+ *
+ *	On success msi_map::index contains the allocated index (>=3D 0) and
+ *	msi_map::virq the allocated Linux interrupt number (> 0).
+ *
+ *	On fail msi_map::index contains the error code and msi_map::virq
+ *	is set to 0.
+ */
+struct msi_map pci_ims_alloc_irq(struct pci_dev *dev, union msi_instance_coo=
kie *icookie,
+				 const struct irq_affinity_desc *affdesc)
+{
+	return msi_domain_alloc_irq_at(&dev->dev, MSI_SECONDARY_DOMAIN, MSI_ANY_IND=
EX,
+				       affdesc, icookie);
+}
+EXPORT_SYMBOL_GPL(pci_ims_alloc_irq);
+
+/**
+ * pci_ims_free_irq - Allocate an interrupt on a PCI/IMS interrupt domain
+ *		      which was allocated via pci_ims_alloc_irq()
+ * @dev:	The PCI device to operate on
+ * @map:	A struct msi_map describing the interrupt to free as
+ *		returned from pci_ims_alloc_irq()
+ */
+void pci_ims_free_irq(struct pci_dev *dev, struct msi_map map)
+{
+	if (WARN_ON_ONCE(map.index < 0 || map.virq <=3D 0))
+		return;
+	msi_domain_free_irqs_range(&dev->dev, MSI_SECONDARY_DOMAIN, map.index, map.=
index);
+}
+EXPORT_SYMBOL_GPL(pci_ims_free_irq);
+
+/**
+ * pci_free_irq_vectors() - Free previously allocated IRQs for a device
+ * @dev: the PCI device to operate on
+ *
+ * Undo the interrupt vector allocations and possible device MSI/MSI-X
+ * enablement earlier done through pci_alloc_irq_vectors_affinity() or
+ * pci_alloc_irq_vectors().
+ */
+void pci_free_irq_vectors(struct pci_dev *dev)
+{
+	pci_disable_msix(dev);
+	pci_disable_msi(dev);
+}
+EXPORT_SYMBOL(pci_free_irq_vectors);
+
+/**
+ * pci_restore_msi_state() - Restore cached MSI(-X) state on device
+ * @dev: the PCI device to operate on
+ *
+ * Write the Linux-cached MSI(-X) state back on device. This is
+ * typically useful upon system resume, or after an error-recovery PCI
+ * adapter reset.
+ */
+void pci_restore_msi_state(struct pci_dev *dev)
+{
+	__pci_restore_msi_state(dev);
+	__pci_restore_msix_state(dev);
+}
+EXPORT_SYMBOL_GPL(pci_restore_msi_state);
+
+/**
+ * pci_msi_enabled() - Are MSI(-X) interrupts enabled system-wide?
+ *
+ * Return: true if MSI has not been globally disabled through ACPI FADT,
+ * PCI bridge quirks, or the "pci=3Dnomsi" kernel command-line option.
+ */
+int pci_msi_enabled(void)
+{
+	return pci_msi_enable;
+}
+EXPORT_SYMBOL(pci_msi_enabled);
diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
index e9cf318e6670..e33bcc872699 100644
--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -14,7 +14,7 @@ int pci_msi_setup_msi_irqs(struct pci_dev *dev, int nvec, i=
nt type)
=20
 	domain =3D dev_get_msi_domain(&dev->dev);
 	if (domain && irq_domain_is_hierarchy(domain))
-		return msi_domain_alloc_irqs_descs_locked(domain, &dev->dev, nvec);
+		return msi_domain_alloc_irqs_all_locked(&dev->dev, MSI_DEFAULT_DOMAIN, nve=
c);
=20
 	return pci_msi_legacy_setup_msi_irqs(dev, nvec, type);
 }
@@ -24,11 +24,12 @@ void pci_msi_teardown_msi_irqs(struct pci_dev *dev)
 	struct irq_domain *domain;
=20
 	domain =3D dev_get_msi_domain(&dev->dev);
-	if (domain && irq_domain_is_hierarchy(domain))
-		msi_domain_free_irqs_descs_locked(domain, &dev->dev);
-	else
+	if (domain && irq_domain_is_hierarchy(domain)) {
+		msi_domain_free_irqs_all_locked(&dev->dev, MSI_DEFAULT_DOMAIN);
+	} else {
 		pci_msi_legacy_teardown_msi_irqs(dev);
-	msi_free_msi_descs(&dev->dev);
+		msi_free_msi_descs(&dev->dev);
+	}
 }
=20
 /**
@@ -63,51 +64,6 @@ static irq_hw_number_t pci_msi_domain_calc_hwirq(struct ms=
i_desc *desc)
 		(pci_domain_nr(dev->bus) & 0xFFFFFFFF) << 27;
 }
=20
-static inline bool pci_msi_desc_is_multi_msi(struct msi_desc *desc)
-{
-	return !desc->pci.msi_attrib.is_msix && desc->nvec_used > 1;
-}
-
-/**
- * pci_msi_domain_check_cap - Verify that @domain supports the capabilities
- *			      for @dev
- * @domain:	The interrupt domain to check
- * @info:	The domain info for verification
- * @dev:	The device to check
- *
- * Returns:
- *  0 if the functionality is supported
- *  1 if Multi MSI is requested, but the domain does not support it
- *  -ENOTSUPP otherwise
- */
-static int pci_msi_domain_check_cap(struct irq_domain *domain,
-				    struct msi_domain_info *info,
-				    struct device *dev)
-{
-	struct msi_desc *desc =3D msi_first_desc(dev, MSI_DESC_ALL);
-
-	/* Special handling to support __pci_enable_msi_range() */
-	if (pci_msi_desc_is_multi_msi(desc) &&
-	    !(info->flags & MSI_FLAG_MULTI_PCI_MSI))
-		return 1;
-
-	if (desc->pci.msi_attrib.is_msix) {
-		if (!(info->flags & MSI_FLAG_PCI_MSIX))
-			return -ENOTSUPP;
-
-		if (info->flags & MSI_FLAG_MSIX_CONTIGUOUS) {
-			unsigned int idx =3D 0;
-
-			/* Check for gaps in the entry indices */
-			msi_for_each_desc(desc, dev, MSI_DESC_ALL) {
-				if (desc->msi_index !=3D idx++)
-					return -ENOTSUPP;
-			}
-		}
-	}
-	return 0;
-}
-
 static void pci_msi_domain_set_desc(msi_alloc_info_t *arg,
 				    struct msi_desc *desc)
 {
@@ -117,7 +73,6 @@ static void pci_msi_domain_set_desc(msi_alloc_info_t *arg,
=20
 static struct msi_domain_ops pci_msi_domain_ops_default =3D {
 	.set_desc	=3D pci_msi_domain_set_desc,
-	.msi_check	=3D pci_msi_domain_check_cap,
 };
=20
 static void pci_msi_domain_update_dom_ops(struct msi_domain_info *info)
@@ -129,8 +84,6 @@ static void pci_msi_domain_update_dom_ops(struct msi_domai=
n_info *info)
 	} else {
 		if (ops->set_desc =3D=3D NULL)
 			ops->set_desc =3D pci_msi_domain_set_desc;
-		if (ops->msi_check =3D=3D NULL)
-			ops->msi_check =3D pci_msi_domain_check_cap;
 	}
 }
=20
@@ -162,8 +115,6 @@ struct irq_domain *pci_msi_create_irq_domain(struct fwnod=
e_handle *fwnode,
 					     struct msi_domain_info *info,
 					     struct irq_domain *parent)
 {
-	struct irq_domain *domain;
-
 	if (WARN_ON(info->flags & MSI_FLAG_LEVEL_CAPABLE))
 		info->flags &=3D ~MSI_FLAG_LEVEL_CAPABLE;
=20
@@ -172,22 +123,297 @@ struct irq_domain *pci_msi_create_irq_domain(struct fw=
node_handle *fwnode,
 	if (info->flags & MSI_FLAG_USE_DEF_CHIP_OPS)
 		pci_msi_domain_update_chip_ops(info);
=20
+	/* Let the core code free MSI descriptors when freeing interrupts */
+	info->flags |=3D MSI_FLAG_FREE_MSI_DESCS;
+
 	info->flags |=3D MSI_FLAG_ACTIVATE_EARLY | MSI_FLAG_DEV_SYSFS;
 	if (IS_ENABLED(CONFIG_GENERIC_IRQ_RESERVATION_MODE))
 		info->flags |=3D MSI_FLAG_MUST_REACTIVATE;
=20
 	/* PCI-MSI is oneshot-safe */
 	info->chip->flags |=3D IRQCHIP_ONESHOT_SAFE;
+	/* Let the core update the bus token */
+	info->bus_token =3D DOMAIN_BUS_PCI_MSI;
=20
-	domain =3D msi_create_irq_domain(fwnode, info, parent);
-	if (!domain)
-		return NULL;
-
-	irq_domain_update_bus_token(domain, DOMAIN_BUS_PCI_MSI);
-	return domain;
+	return msi_create_irq_domain(fwnode, info, parent);
 }
 EXPORT_SYMBOL_GPL(pci_msi_create_irq_domain);
=20
+/*
+ * Per device MSI[-X] domain functionality
+ */
+static void pci_device_domain_set_desc(msi_alloc_info_t *arg, struct msi_des=
c *desc)
+{
+	arg->desc =3D desc;
+	arg->hwirq =3D desc->msi_index;
+}
+
+static void pci_irq_mask_msi(struct irq_data *data)
+{
+	struct msi_desc *desc =3D irq_data_get_msi_desc(data);
+
+	pci_msi_mask(desc, BIT(data->irq - desc->irq));
+}
+
+static void pci_irq_unmask_msi(struct irq_data *data)
+{
+	struct msi_desc *desc =3D irq_data_get_msi_desc(data);
+
+	pci_msi_unmask(desc, BIT(data->irq - desc->irq));
+}
+
+#ifdef CONFIG_GENERIC_IRQ_RESERVATION_MODE
+# define MSI_REACTIVATE		MSI_FLAG_MUST_REACTIVATE
+#else
+# define MSI_REACTIVATE		0
+#endif
+
+#define MSI_COMMON_FLAGS	(MSI_FLAG_FREE_MSI_DESCS |	\
+				 MSI_FLAG_ACTIVATE_EARLY |	\
+				 MSI_FLAG_DEV_SYSFS |		\
+				 MSI_REACTIVATE)
+
+static const struct msi_domain_template pci_msi_template =3D {
+	.chip =3D {
+		.name			=3D "PCI-MSI",
+		.irq_mask		=3D pci_irq_mask_msi,
+		.irq_unmask		=3D pci_irq_unmask_msi,
+		.irq_write_msi_msg	=3D pci_msi_domain_write_msg,
+		.flags			=3D IRQCHIP_ONESHOT_SAFE,
+	},
+
+	.ops =3D {
+		.set_desc		=3D pci_device_domain_set_desc,
+	},
+
+	.info =3D {
+		.flags			=3D MSI_COMMON_FLAGS | MSI_FLAG_MULTI_PCI_MSI,
+		.bus_token		=3D DOMAIN_BUS_PCI_DEVICE_MSI,
+	},
+};
+
+static void pci_irq_mask_msix(struct irq_data *data)
+{
+	pci_msix_mask(irq_data_get_msi_desc(data));
+}
+
+static void pci_irq_unmask_msix(struct irq_data *data)
+{
+	pci_msix_unmask(irq_data_get_msi_desc(data));
+}
+
+static void pci_msix_prepare_desc(struct irq_domain *domain, msi_alloc_info_=
t *arg,
+				  struct msi_desc *desc)
+{
+	/* Don't fiddle with preallocated MSI descriptors */
+	if (!desc->pci.mask_base)
+		msix_prepare_msi_desc(to_pci_dev(desc->dev), desc);
+}
+
+static const struct msi_domain_template pci_msix_template =3D {
+	.chip =3D {
+		.name			=3D "PCI-MSIX",
+		.irq_mask		=3D pci_irq_mask_msix,
+		.irq_unmask		=3D pci_irq_unmask_msix,
+		.irq_write_msi_msg	=3D pci_msi_domain_write_msg,
+		.flags			=3D IRQCHIP_ONESHOT_SAFE,
+	},
+
+	.ops =3D {
+		.prepare_desc		=3D pci_msix_prepare_desc,
+		.set_desc		=3D pci_device_domain_set_desc,
+	},
+
+	.info =3D {
+		.flags			=3D MSI_COMMON_FLAGS | MSI_FLAG_PCI_MSIX |
+					  MSI_FLAG_PCI_MSIX_ALLOC_DYN,
+		.bus_token		=3D DOMAIN_BUS_PCI_DEVICE_MSIX,
+	},
+};
+
+static bool pci_match_device_domain(struct pci_dev *pdev, enum irq_domain_bu=
s_token bus_token)
+{
+	return msi_match_device_irq_domain(&pdev->dev, MSI_DEFAULT_DOMAIN, bus_toke=
n);
+}
+
+static bool pci_create_device_domain(struct pci_dev *pdev, const struct msi_=
domain_template *tmpl,
+				     unsigned int hwsize)
+{
+	struct irq_domain *domain =3D dev_get_msi_domain(&pdev->dev);
+
+	if (!domain || !irq_domain_is_msi_parent(domain))
+		return true;
+
+	return msi_create_device_irq_domain(&pdev->dev, MSI_DEFAULT_DOMAIN, tmpl,
+					    hwsize, NULL, NULL);
+}
+
+/**
+ * pci_setup_msi_device_domain - Setup a device MSI interrupt domain
+ * @pdev:	The PCI device to create the domain on
+ *
+ * Return:
+ *  True when:
+ *	- The device does not have a MSI parent irq domain associated,
+ *	  which keeps the legacy architecture specific and the global
+ *	  PCI/MSI domain models working
+ *	- The MSI domain exists already
+ *	- The MSI domain was successfully allocated
+ *  False when:
+ *	- MSI-X is enabled
+ *	- The domain creation fails.
+ *
+ * The created MSI domain is preserved until:
+ *	- The device is removed
+ *	- MSI is disabled and a MSI-X domain is created
+ */
+bool pci_setup_msi_device_domain(struct pci_dev *pdev)
+{
+	if (WARN_ON_ONCE(pdev->msix_enabled))
+		return false;
+
+	if (pci_match_device_domain(pdev, DOMAIN_BUS_PCI_DEVICE_MSI))
+		return true;
+	if (pci_match_device_domain(pdev, DOMAIN_BUS_PCI_DEVICE_MSIX))
+		msi_remove_device_irq_domain(&pdev->dev, MSI_DEFAULT_DOMAIN);
+
+	return pci_create_device_domain(pdev, &pci_msi_template, 1);
+}
+
+/**
+ * pci_setup_msix_device_domain - Setup a device MSI-X interrupt domain
+ * @pdev:	The PCI device to create the domain on
+ * @hwsize:	The size of the MSI-X vector table
+ *
+ * Return:
+ *  True when:
+ *	- The device does not have a MSI parent irq domain associated,
+ *	  which keeps the legacy architecture specific and the global
+ *	  PCI/MSI domain models working
+ *	- The MSI-X domain exists already
+ *	- The MSI-X domain was successfully allocated
+ *  False when:
+ *	- MSI is enabled
+ *	- The domain creation fails.
+ *
+ * The created MSI-X domain is preserved until:
+ *	- The device is removed
+ *	- MSI-X is disabled and a MSI domain is created
+ */
+bool pci_setup_msix_device_domain(struct pci_dev *pdev, unsigned int hwsize)
+{
+	if (WARN_ON_ONCE(pdev->msi_enabled))
+		return false;
+
+	if (pci_match_device_domain(pdev, DOMAIN_BUS_PCI_DEVICE_MSIX))
+		return true;
+	if (pci_match_device_domain(pdev, DOMAIN_BUS_PCI_DEVICE_MSI))
+		msi_remove_device_irq_domain(&pdev->dev, MSI_DEFAULT_DOMAIN);
+
+	return pci_create_device_domain(pdev, &pci_msix_template, hwsize);
+}
+
+/**
+ * pci_msi_domain_supports - Check for support of a particular feature flag
+ * @pdev:		The PCI device to operate on
+ * @feature_mask:	The feature mask to check for (full match)
+ * @mode:		If ALLOW_LEGACY this grants the feature when there is no irq doma=
in
+ *			associated to the device. If DENY_LEGACY the lack of an irq domain
+ *			makes the feature unsupported
+ */
+bool pci_msi_domain_supports(struct pci_dev *pdev, unsigned int feature_mask,
+			     enum support_mode mode)
+{
+	struct msi_domain_info *info;
+	struct irq_domain *domain;
+	unsigned int supported;
+
+	domain =3D dev_get_msi_domain(&pdev->dev);
+
+	if (!domain || !irq_domain_is_hierarchy(domain))
+		return mode =3D=3D ALLOW_LEGACY;
+
+	if (!irq_domain_is_msi_parent(domain)) {
+		/*
+		 * For "global" PCI/MSI interrupt domains the associated
+		 * msi_domain_info::flags is the authoritive source of
+		 * information.
+		 */
+		info =3D domain->host_data;
+		supported =3D info->flags;
+	} else {
+		/*
+		 * For MSI parent domains the supported feature set
+		 * is avaliable in the parent ops. This makes checks
+		 * possible before actually instantiating the
+		 * per device domain because the parent is never
+		 * expanding the PCI/MSI functionality.
+		 */
+		supported =3D domain->msi_parent_ops->supported_flags;
+	}
+
+	return (supported & feature_mask) =3D=3D feature_mask;
+}
+
+/**
+ * pci_create_ims_domain - Create a secondary IMS domain for a PCI device
+ * @pdev:	The PCI device to operate on
+ * @template:	The MSI info template which describes the domain
+ * @hwsize:	The size of the hardware entry table or 0 if the domain
+ *		is purely software managed
+ * @data:	Optional pointer to domain specific data to be stored
+ *		in msi_domain_info::data
+ *
+ * Return: True on success, false otherwise
+ *
+ * An IMS domain is expected to have the following constraints:
+ *	- The index space is managed by the core code
+ *
+ *	- There is no requirement for consecutive index ranges
+ *
+ *	- The interrupt chip must provide the following callbacks:
+ *		- irq_mask()
+ *		- irq_unmask()
+ *		- irq_write_msi_msg()
+ *
+ *	- The interrupt chip must provide the following optional callbacks
+ *	  when the irq_mask(), irq_unmask() and irq_write_msi_msg() callbacks
+ *	  cannot operate directly on hardware, e.g. in the case that the
+ *	  interrupt message store is in queue memory:
+ *		- irq_bus_lock()
+ *		- irq_bus_unlock()
+ *
+ *	  These callbacks are invoked from preemptible task context and are
+ *	  allowed to sleep. In this case the mandatory callbacks above just
+ *	  store the information. The irq_bus_unlock() callback is supposed
+ *	  to make the change effective before returning.
+ *
+ *	- Interrupt affinity setting is handled by the underlying parent
+ *	  interrupt domain and communicated to the IMS domain via
+ *	  irq_write_msi_msg().
+ *
+ * The domain is automatically destroyed when the PCI device is removed.
+ */
+bool pci_create_ims_domain(struct pci_dev *pdev, const struct msi_domain_tem=
plate *template,
+			   unsigned int hwsize, void *data)
+{
+	struct irq_domain *domain =3D dev_get_msi_domain(&pdev->dev);
+
+	if (!domain || !irq_domain_is_msi_parent(domain))
+		return false;
+
+	if (template->info.bus_token !=3D DOMAIN_BUS_PCI_DEVICE_IMS ||
+	    !(template->info.flags & MSI_FLAG_ALLOC_SIMPLE_MSI_DESCS) ||
+	    !(template->info.flags & MSI_FLAG_FREE_MSI_DESCS) ||
+	    !template->chip.irq_mask || !template->chip.irq_unmask ||
+	    !template->chip.irq_write_msi_msg || template->chip.irq_set_affinity)
+		return false;
+
+	return msi_create_device_irq_domain(&pdev->dev, MSI_SECONDARY_DOMAIN, templ=
ate,
+					    hwsize, data, NULL);
+}
+EXPORT_SYMBOL_GPL(pci_create_ims_domain);
+
 /*
  * Users of the generic MSI infrastructure expect a device to have a single =
ID,
  * so with DMA aliases we have to pick the least-worst compromise. Devices w=
ith
@@ -257,24 +483,3 @@ struct irq_domain *pci_msi_get_device_domain(struct pci_=
dev *pdev)
 					     DOMAIN_BUS_PCI_MSI);
 	return dom;
 }
-
-/**
- * pci_dev_has_special_msi_domain - Check whether the device is handled by
- *				    a non-standard PCI-MSI domain
- * @pdev:	The PCI device to check.
- *
- * Returns: True if the device irqdomain or the bus irqdomain is
- * non-standard PCI/MSI.
- */
-bool pci_dev_has_special_msi_domain(struct pci_dev *pdev)
-{
-	struct irq_domain *dom =3D dev_get_msi_domain(&pdev->dev);
-
-	if (!dom)
-		dom =3D dev_get_msi_domain(&pdev->bus->dev);
-
-	if (!dom)
-		return true;
-
-	return dom->bus_token !=3D DOMAIN_BUS_PCI_MSI;
-}
diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index fdd2ec09651e..1f716624ca56 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -13,82 +13,114 @@
 #include "../pci.h"
 #include "msi.h"
=20
-static int pci_msi_enable =3D 1;
+int pci_msi_enable =3D 1;
 int pci_msi_ignore_mask;
=20
-static noinline void pci_msi_update_mask(struct msi_desc *desc, u32 clear, u=
32 set)
+/**
+ * pci_msi_supported - check whether MSI may be enabled on a device
+ * @dev: pointer to the pci_dev data structure of MSI device function
+ * @nvec: how many MSIs have been requested?
+ *
+ * Look at global flags, the device itself, and its parent buses
+ * to determine if MSI/-X are supported for the device. If MSI/-X is
+ * supported return 1, else return 0.
+ **/
+static int pci_msi_supported(struct pci_dev *dev, int nvec)
 {
-	raw_spinlock_t *lock =3D &to_pci_dev(desc->dev)->msi_lock;
-	unsigned long flags;
+	struct pci_bus *bus;
=20
-	if (!desc->pci.msi_attrib.can_mask)
-		return;
+	/* MSI must be globally enabled and supported by the device */
+	if (!pci_msi_enable)
+		return 0;
=20
-	raw_spin_lock_irqsave(lock, flags);
-	desc->pci.msi_mask &=3D ~clear;
-	desc->pci.msi_mask |=3D set;
-	pci_write_config_dword(msi_desc_to_pci_dev(desc), desc->pci.mask_pos,
-			       desc->pci.msi_mask);
-	raw_spin_unlock_irqrestore(lock, flags);
-}
+	if (!dev || dev->no_msi)
+		return 0;
=20
-static inline void pci_msi_mask(struct msi_desc *desc, u32 mask)
-{
-	pci_msi_update_mask(desc, 0, mask);
-}
+	/*
+	 * You can't ask to have 0 or less MSIs configured.
+	 *  a) it's stupid ..
+	 *  b) the list manipulation code assumes nvec >=3D 1.
+	 */
+	if (nvec < 1)
+		return 0;
=20
-static inline void pci_msi_unmask(struct msi_desc *desc, u32 mask)
-{
-	pci_msi_update_mask(desc, mask, 0);
+	/*
+	 * Any bridge which does NOT route MSI transactions from its
+	 * secondary bus to its primary bus must set NO_MSI flag on
+	 * the secondary pci_bus.
+	 *
+	 * The NO_MSI flag can either be set directly by:
+	 * - arch-specific PCI host bus controller drivers (deprecated)
+	 * - quirks for specific PCI bridges
+	 *
+	 * or indirectly by platform-specific PCI host bridge drivers by
+	 * advertising the 'msi_domain' property, which results in
+	 * the NO_MSI flag when no MSI domain is found for this bridge
+	 * at probe time.
+	 */
+	for (bus =3D dev->bus; bus; bus =3D bus->parent)
+		if (bus->bus_flags & PCI_BUS_FLAGS_NO_MSI)
+			return 0;
+
+	return 1;
 }
=20
-static inline void __iomem *pci_msix_desc_addr(struct msi_desc *desc)
+static void pcim_msi_release(void *pcidev)
 {
-	return desc->pci.mask_base + desc->msi_index * PCI_MSIX_ENTRY_SIZE;
+	struct pci_dev *dev =3D pcidev;
+
+	dev->is_msi_managed =3D false;
+	pci_free_irq_vectors(dev);
 }
=20
 /*
- * This internal function does not flush PCI writes to the device.  All
- * users must ensure that they read from the device before either assuming
- * that the device state is up to date, or returning out of this file.
- * It does not affect the msi_desc::msix_ctrl cache either. Use with care!
+ * Needs to be separate from pcim_release to prevent an ordering problem
+ * vs. msi_device_data_release() in the MSI core code.
  */
-static void pci_msix_write_vector_ctrl(struct msi_desc *desc, u32 ctrl)
+static int pcim_setup_msi_release(struct pci_dev *dev)
 {
-	void __iomem *desc_addr =3D pci_msix_desc_addr(desc);
+	int ret;
=20
-	if (desc->pci.msi_attrib.can_mask)
-		writel(ctrl, desc_addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
-}
+	if (!pci_is_managed(dev) || dev->is_msi_managed)
+		return 0;
=20
-static inline void pci_msix_mask(struct msi_desc *desc)
-{
-	desc->pci.msix_ctrl |=3D PCI_MSIX_ENTRY_CTRL_MASKBIT;
-	pci_msix_write_vector_ctrl(desc, desc->pci.msix_ctrl);
-	/* Flush write to device */
-	readl(desc->pci.mask_base);
+	ret =3D devm_add_action(&dev->dev, pcim_msi_release, dev);
+	if (!ret)
+		dev->is_msi_managed =3D true;
+	return ret;
 }
=20
-static inline void pci_msix_unmask(struct msi_desc *desc)
+/*
+ * Ordering vs. devres: msi device data has to be installed first so that
+ * pcim_msi_release() is invoked before it on device release.
+ */
+static int pci_setup_msi_context(struct pci_dev *dev)
 {
-	desc->pci.msix_ctrl &=3D ~PCI_MSIX_ENTRY_CTRL_MASKBIT;
-	pci_msix_write_vector_ctrl(desc, desc->pci.msix_ctrl);
-}
+	int ret =3D msi_setup_device_data(&dev->dev);
=20
-static void __pci_msi_mask_desc(struct msi_desc *desc, u32 mask)
-{
-	if (desc->pci.msi_attrib.is_msix)
-		pci_msix_mask(desc);
-	else
-		pci_msi_mask(desc, mask);
+	if (!ret)
+		ret =3D pcim_setup_msi_release(dev);
+	return ret;
 }
=20
-static void __pci_msi_unmask_desc(struct msi_desc *desc, u32 mask)
+/*
+ * Helper functions for mask/unmask and MSI message handling
+ */
+
+void pci_msi_update_mask(struct msi_desc *desc, u32 clear, u32 set)
 {
-	if (desc->pci.msi_attrib.is_msix)
-		pci_msix_unmask(desc);
-	else
-		pci_msi_unmask(desc, mask);
+	raw_spinlock_t *lock =3D &to_pci_dev(desc->dev)->msi_lock;
+	unsigned long flags;
+
+	if (!desc->pci.msi_attrib.can_mask)
+		return;
+
+	raw_spin_lock_irqsave(lock, flags);
+	desc->pci.msi_mask &=3D ~clear;
+	desc->pci.msi_mask |=3D set;
+	pci_write_config_dword(msi_desc_to_pci_dev(desc), desc->pci.mask_pos,
+			       desc->pci.msi_mask);
+	raw_spin_unlock_irqrestore(lock, flags);
 }
=20
 /**
@@ -148,6 +180,58 @@ void __pci_read_msi_msg(struct msi_desc *entry, struct m=
si_msg *msg)
 	}
 }
=20
+static inline void pci_write_msg_msi(struct pci_dev *dev, struct msi_desc *d=
esc,
+				     struct msi_msg *msg)
+{
+	int pos =3D dev->msi_cap;
+	u16 msgctl;
+
+	pci_read_config_word(dev, pos + PCI_MSI_FLAGS, &msgctl);
+	msgctl &=3D ~PCI_MSI_FLAGS_QSIZE;
+	msgctl |=3D desc->pci.msi_attrib.multiple << 4;
+	pci_write_config_word(dev, pos + PCI_MSI_FLAGS, msgctl);
+
+	pci_write_config_dword(dev, pos + PCI_MSI_ADDRESS_LO, msg->address_lo);
+	if (desc->pci.msi_attrib.is_64) {
+		pci_write_config_dword(dev, pos + PCI_MSI_ADDRESS_HI,  msg->address_hi);
+		pci_write_config_word(dev, pos + PCI_MSI_DATA_64, msg->data);
+	} else {
+		pci_write_config_word(dev, pos + PCI_MSI_DATA_32, msg->data);
+	}
+	/* Ensure that the writes are visible in the device */
+	pci_read_config_word(dev, pos + PCI_MSI_FLAGS, &msgctl);
+}
+
+static inline void pci_write_msg_msix(struct msi_desc *desc, struct msi_msg =
*msg)
+{
+	void __iomem *base =3D pci_msix_desc_addr(desc);
+	u32 ctrl =3D desc->pci.msix_ctrl;
+	bool unmasked =3D !(ctrl & PCI_MSIX_ENTRY_CTRL_MASKBIT);
+
+	if (desc->pci.msi_attrib.is_virtual)
+		return;
+	/*
+	 * The specification mandates that the entry is masked
+	 * when the message is modified:
+	 *
+	 * "If software changes the Address or Data value of an
+	 * entry while the entry is unmasked, the result is
+	 * undefined."
+	 */
+	if (unmasked)
+		pci_msix_write_vector_ctrl(desc, ctrl | PCI_MSIX_ENTRY_CTRL_MASKBIT);
+
+	writel(msg->address_lo, base + PCI_MSIX_ENTRY_LOWER_ADDR);
+	writel(msg->address_hi, base + PCI_MSIX_ENTRY_UPPER_ADDR);
+	writel(msg->data, base + PCI_MSIX_ENTRY_DATA);
+
+	if (unmasked)
+		pci_msix_write_vector_ctrl(desc, ctrl);
+
+	/* Ensure that the writes are visible in the device */
+	readl(base + PCI_MSIX_ENTRY_DATA);
+}
+
 void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
 {
 	struct pci_dev *dev =3D msi_desc_to_pci_dev(entry);
@@ -155,63 +239,15 @@ void __pci_write_msi_msg(struct msi_desc *entry, struct=
 msi_msg *msg)
 	if (dev->current_state !=3D PCI_D0 || pci_dev_is_disconnected(dev)) {
 		/* Don't touch the hardware now */
 	} else if (entry->pci.msi_attrib.is_msix) {
-		void __iomem *base =3D pci_msix_desc_addr(entry);
-		u32 ctrl =3D entry->pci.msix_ctrl;
-		bool unmasked =3D !(ctrl & PCI_MSIX_ENTRY_CTRL_MASKBIT);
-
-		if (entry->pci.msi_attrib.is_virtual)
-			goto skip;
-
-		/*
-		 * The specification mandates that the entry is masked
-		 * when the message is modified:
-		 *
-		 * "If software changes the Address or Data value of an
-		 * entry while the entry is unmasked, the result is
-		 * undefined."
-		 */
-		if (unmasked)
-			pci_msix_write_vector_ctrl(entry, ctrl | PCI_MSIX_ENTRY_CTRL_MASKBIT);
-
-		writel(msg->address_lo, base + PCI_MSIX_ENTRY_LOWER_ADDR);
-		writel(msg->address_hi, base + PCI_MSIX_ENTRY_UPPER_ADDR);
-		writel(msg->data, base + PCI_MSIX_ENTRY_DATA);
-
-		if (unmasked)
-			pci_msix_write_vector_ctrl(entry, ctrl);
-
-		/* Ensure that the writes are visible in the device */
-		readl(base + PCI_MSIX_ENTRY_DATA);
+		pci_write_msg_msix(entry, msg);
 	} else {
-		int pos =3D dev->msi_cap;
-		u16 msgctl;
-
-		pci_read_config_word(dev, pos + PCI_MSI_FLAGS, &msgctl);
-		msgctl &=3D ~PCI_MSI_FLAGS_QSIZE;
-		msgctl |=3D entry->pci.msi_attrib.multiple << 4;
-		pci_write_config_word(dev, pos + PCI_MSI_FLAGS, msgctl);
-
-		pci_write_config_dword(dev, pos + PCI_MSI_ADDRESS_LO,
-				       msg->address_lo);
-		if (entry->pci.msi_attrib.is_64) {
-			pci_write_config_dword(dev, pos + PCI_MSI_ADDRESS_HI,
-					       msg->address_hi);
-			pci_write_config_word(dev, pos + PCI_MSI_DATA_64,
-					      msg->data);
-		} else {
-			pci_write_config_word(dev, pos + PCI_MSI_DATA_32,
-					      msg->data);
-		}
-		/* Ensure that the writes are visible in the device */
-		pci_read_config_word(dev, pos + PCI_MSI_FLAGS, &msgctl);
+		pci_write_msg_msi(dev, entry, msg);
 	}
=20
-skip:
 	entry->msg =3D *msg;
=20
 	if (entry->write_msi_msg)
 		entry->write_msi_msg(entry, entry->write_msi_msg_data);
-
 }
=20
 void pci_write_msi_msg(unsigned int irq, struct msi_msg *msg)
@@ -222,15 +258,8 @@ void pci_write_msi_msg(unsigned int irq, struct msi_msg =
*msg)
 }
 EXPORT_SYMBOL_GPL(pci_write_msi_msg);
=20
-static void free_msi_irqs(struct pci_dev *dev)
-{
-	pci_msi_teardown_msi_irqs(dev);
=20
-	if (dev->msix_base) {
-		iounmap(dev->msix_base);
-		dev->msix_base =3D NULL;
-	}
-}
+/* PCI/MSI specific functionality */
=20
 static void pci_intx_for_msi(struct pci_dev *dev, int enable)
 {
@@ -249,118 +278,6 @@ static void pci_msi_set_enable(struct pci_dev *dev, int=
 enable)
 	pci_write_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, control);
 }
=20
-/*
- * Architecture override returns true when the PCI MSI message should be
- * written by the generic restore function.
- */
-bool __weak arch_restore_msi_irqs(struct pci_dev *dev)
-{
-	return true;
-}
-
-static void __pci_restore_msi_state(struct pci_dev *dev)
-{
-	struct msi_desc *entry;
-	u16 control;
-
-	if (!dev->msi_enabled)
-		return;
-
-	entry =3D irq_get_msi_desc(dev->irq);
-
-	pci_intx_for_msi(dev, 0);
-	pci_msi_set_enable(dev, 0);
-	if (arch_restore_msi_irqs(dev))
-		__pci_write_msi_msg(entry, &entry->msg);
-
-	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &control);
-	pci_msi_update_mask(entry, 0, 0);
-	control &=3D ~PCI_MSI_FLAGS_QSIZE;
-	control |=3D (entry->pci.msi_attrib.multiple << 4) | PCI_MSI_FLAGS_ENABLE;
-	pci_write_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, control);
-}
-
-static void pci_msix_clear_and_set_ctrl(struct pci_dev *dev, u16 clear, u16 =
set)
-{
-	u16 ctrl;
-
-	pci_read_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, &ctrl);
-	ctrl &=3D ~clear;
-	ctrl |=3D set;
-	pci_write_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, ctrl);
-}
-
-static void __pci_restore_msix_state(struct pci_dev *dev)
-{
-	struct msi_desc *entry;
-	bool write_msg;
-
-	if (!dev->msix_enabled)
-		return;
-
-	/* route the table */
-	pci_intx_for_msi(dev, 0);
-	pci_msix_clear_and_set_ctrl(dev, 0,
-				PCI_MSIX_FLAGS_ENABLE | PCI_MSIX_FLAGS_MASKALL);
-
-	write_msg =3D arch_restore_msi_irqs(dev);
-
-	msi_lock_descs(&dev->dev);
-	msi_for_each_desc(entry, &dev->dev, MSI_DESC_ALL) {
-		if (write_msg)
-			__pci_write_msi_msg(entry, &entry->msg);
-		pci_msix_write_vector_ctrl(entry, entry->pci.msix_ctrl);
-	}
-	msi_unlock_descs(&dev->dev);
-
-	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);
-}
-
-void pci_restore_msi_state(struct pci_dev *dev)
-{
-	__pci_restore_msi_state(dev);
-	__pci_restore_msix_state(dev);
-}
-EXPORT_SYMBOL_GPL(pci_restore_msi_state);
-
-static void pcim_msi_release(void *pcidev)
-{
-	struct pci_dev *dev =3D pcidev;
-
-	dev->is_msi_managed =3D false;
-	pci_free_irq_vectors(dev);
-}
-
-/*
- * Needs to be separate from pcim_release to prevent an ordering problem
- * vs. msi_device_data_release() in the MSI core code.
- */
-static int pcim_setup_msi_release(struct pci_dev *dev)
-{
-	int ret;
-
-	if (!pci_is_managed(dev) || dev->is_msi_managed)
-		return 0;
-
-	ret =3D devm_add_action(&dev->dev, pcim_msi_release, dev);
-	if (!ret)
-		dev->is_msi_managed =3D true;
-	return ret;
-}
-
-/*
- * Ordering vs. devres: msi device data has to be installed first so that
- * pcim_msi_release() is invoked before it on device release.
- */
-static int pci_setup_msi_context(struct pci_dev *dev)
-{
-	int ret =3D msi_setup_device_data(&dev->dev);
-
-	if (!ret)
-		ret =3D pcim_setup_msi_release(dev);
-	return ret;
-}
-
 static int msi_setup_msi_desc(struct pci_dev *dev, int nvec,
 			      struct irq_affinity_desc *masks)
 {
@@ -395,7 +312,7 @@ static int msi_setup_msi_desc(struct pci_dev *dev, int nv=
ec,
 	if (desc.pci.msi_attrib.can_mask)
 		pci_read_config_dword(dev, desc.pci.mask_pos, &desc.pci.msi_mask);
=20
-	return msi_add_msi_desc(&dev->dev, &desc);
+	return msi_insert_msi_desc(&dev->dev, &desc);
 }
=20
 static int msi_verify_entries(struct pci_dev *dev)
@@ -434,6 +351,10 @@ static int msi_capability_init(struct pci_dev *dev, int =
nvec,
 	struct msi_desc *entry;
 	int ret;
=20
+	/* Reject multi-MSI early on irq domain enabled architectures */
+	if (nvec > 1 && !pci_msi_domain_supports(dev, MSI_FLAG_MULTI_PCI_MSI, ALLOW=
_LEGACY))
+		return 1;
+
 	/*
 	 * Disable MSI during setup in the hardware, but mark it enabled
 	 * so that setup code can evaluate it.
@@ -472,7 +393,7 @@ static int msi_capability_init(struct pci_dev *dev, int n=
vec,
=20
 err:
 	pci_msi_unmask(entry, msi_multi_mask(entry));
-	free_msi_irqs(dev);
+	pci_free_msi_irqs(dev);
 fail:
 	dev->msi_enabled =3D 0;
 unlock:
@@ -481,19 +402,165 @@ static int msi_capability_init(struct pci_dev *dev, in=
t nvec,
 	return ret;
 }
=20
-static void __iomem *msix_map_region(struct pci_dev *dev,
-				     unsigned int nr_entries)
+int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
+			   struct irq_affinity *affd)
 {
-	resource_size_t phys_addr;
-	u32 table_offset;
-	unsigned long flags;
-	u8 bir;
+	int nvec;
+	int rc;
=20
-	pci_read_config_dword(dev, dev->msix_cap + PCI_MSIX_TABLE,
-			      &table_offset);
-	bir =3D (u8)(table_offset & PCI_MSIX_TABLE_BIR);
-	flags =3D pci_resource_flags(dev, bir);
-	if (!flags || (flags & IORESOURCE_UNSET))
+	if (!pci_msi_supported(dev, minvec) || dev->current_state !=3D PCI_D0)
+		return -EINVAL;
+
+	/* Check whether driver already requested MSI-X IRQs */
+	if (dev->msix_enabled) {
+		pci_info(dev, "can't enable MSI (MSI-X already enabled)\n");
+		return -EINVAL;
+	}
+
+	if (maxvec < minvec)
+		return -ERANGE;
+
+	if (WARN_ON_ONCE(dev->msi_enabled))
+		return -EINVAL;
+
+	nvec =3D pci_msi_vec_count(dev);
+	if (nvec < 0)
+		return nvec;
+	if (nvec < minvec)
+		return -ENOSPC;
+
+	if (nvec > maxvec)
+		nvec =3D maxvec;
+
+	rc =3D pci_setup_msi_context(dev);
+	if (rc)
+		return rc;
+
+	if (!pci_setup_msi_device_domain(dev))
+		return -ENODEV;
+
+	for (;;) {
+		if (affd) {
+			nvec =3D irq_calc_affinity_vectors(minvec, nvec, affd);
+			if (nvec < minvec)
+				return -ENOSPC;
+		}
+
+		rc =3D msi_capability_init(dev, nvec, affd);
+		if (rc =3D=3D 0)
+			return nvec;
+
+		if (rc < 0)
+			return rc;
+		if (rc < minvec)
+			return -ENOSPC;
+
+		nvec =3D rc;
+	}
+}
+
+/**
+ * pci_msi_vec_count - Return the number of MSI vectors a device can send
+ * @dev: device to report about
+ *
+ * This function returns the number of MSI vectors a device requested via
+ * Multiple Message Capable register. It returns a negative errno if the
+ * device is not capable sending MSI interrupts. Otherwise, the call succeeds
+ * and returns a power of two, up to a maximum of 2^5 (32), according to the
+ * MSI specification.
+ **/
+int pci_msi_vec_count(struct pci_dev *dev)
+{
+	int ret;
+	u16 msgctl;
+
+	if (!dev->msi_cap)
+		return -EINVAL;
+
+	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &msgctl);
+	ret =3D 1 << ((msgctl & PCI_MSI_FLAGS_QMASK) >> 1);
+
+	return ret;
+}
+EXPORT_SYMBOL(pci_msi_vec_count);
+
+/*
+ * Architecture override returns true when the PCI MSI message should be
+ * written by the generic restore function.
+ */
+bool __weak arch_restore_msi_irqs(struct pci_dev *dev)
+{
+	return true;
+}
+
+void __pci_restore_msi_state(struct pci_dev *dev)
+{
+	struct msi_desc *entry;
+	u16 control;
+
+	if (!dev->msi_enabled)
+		return;
+
+	entry =3D irq_get_msi_desc(dev->irq);
+
+	pci_intx_for_msi(dev, 0);
+	pci_msi_set_enable(dev, 0);
+	if (arch_restore_msi_irqs(dev))
+		__pci_write_msi_msg(entry, &entry->msg);
+
+	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &control);
+	pci_msi_update_mask(entry, 0, 0);
+	control &=3D ~PCI_MSI_FLAGS_QSIZE;
+	control |=3D (entry->pci.msi_attrib.multiple << 4) | PCI_MSI_FLAGS_ENABLE;
+	pci_write_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, control);
+}
+
+void pci_msi_shutdown(struct pci_dev *dev)
+{
+	struct msi_desc *desc;
+
+	if (!pci_msi_enable || !dev || !dev->msi_enabled)
+		return;
+
+	pci_msi_set_enable(dev, 0);
+	pci_intx_for_msi(dev, 1);
+	dev->msi_enabled =3D 0;
+
+	/* Return the device with MSI unmasked as initial states */
+	desc =3D msi_first_desc(&dev->dev, MSI_DESC_ALL);
+	if (!WARN_ON_ONCE(!desc))
+		pci_msi_unmask(desc, msi_multi_mask(desc));
+
+	/* Restore dev->irq to its default pin-assertion IRQ */
+	dev->irq =3D desc->pci.msi_attrib.default_irq;
+	pcibios_alloc_irq(dev);
+}
+
+/* PCI/MSI-X specific functionality */
+
+static void pci_msix_clear_and_set_ctrl(struct pci_dev *dev, u16 clear, u16 =
set)
+{
+	u16 ctrl;
+
+	pci_read_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, &ctrl);
+	ctrl &=3D ~clear;
+	ctrl |=3D set;
+	pci_write_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, ctrl);
+}
+
+static void __iomem *msix_map_region(struct pci_dev *dev,
+				     unsigned int nr_entries)
+{
+	resource_size_t phys_addr;
+	u32 table_offset;
+	unsigned long flags;
+	u8 bir;
+
+	pci_read_config_dword(dev, dev->msix_cap + PCI_MSIX_TABLE,
+			      &table_offset);
+	bir =3D (u8)(table_offset & PCI_MSIX_TABLE_BIR);
+	flags =3D pci_resource_flags(dev, bir);
+	if (!flags || (flags & IORESOURCE_UNSET))
 		return NULL;
=20
 	table_offset &=3D PCI_MSIX_TABLE_OFFSET;
@@ -502,36 +569,58 @@ static void __iomem *msix_map_region(struct pci_dev *de=
v,
 	return ioremap(phys_addr, nr_entries * PCI_MSIX_ENTRY_SIZE);
 }
=20
-static int msix_setup_msi_descs(struct pci_dev *dev, void __iomem *base,
-				struct msix_entry *entries, int nvec,
-				struct irq_affinity_desc *masks)
+/**
+ * msix_prepare_msi_desc - Prepare a half initialized MSI descriptor for ope=
ration
+ * @dev:	The PCI device for which the descriptor is prepared
+ * @desc:	The MSI descriptor for preparation
+ *
+ * This is separate from msix_setup_msi_descs() below to handle dynamic
+ * allocations for MSI-X after initial enablement.
+ *
+ * Ideally the whole MSI-X setup would work that way, but there is no way to
+ * support this for the legacy arch_setup_msi_irqs() mechanism and for the
+ * fake irq domains like the x86 XEN one. Sigh...
+ *
+ * The descriptor is zeroed and only @desc::msi_index and @desc::affinity
+ * are set. When called from msix_setup_msi_descs() then the is_virtual
+ * attribute is initialized as well.
+ *
+ * Fill in the rest.
+ */
+void msix_prepare_msi_desc(struct pci_dev *dev, struct msi_desc *desc)
+{
+	desc->nvec_used				=3D 1;
+	desc->pci.msi_attrib.is_msix		=3D 1;
+	desc->pci.msi_attrib.is_64		=3D 1;
+	desc->pci.msi_attrib.default_irq	=3D dev->irq;
+	desc->pci.mask_base			=3D dev->msix_base;
+	desc->pci.msi_attrib.can_mask		=3D !pci_msi_ignore_mask &&
+						  !desc->pci.msi_attrib.is_virtual;
+
+	if (desc->pci.msi_attrib.can_mask) {
+		void __iomem *addr =3D pci_msix_desc_addr(desc);
+
+		desc->pci.msix_ctrl =3D readl(addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
+	}
+}
+
+static int msix_setup_msi_descs(struct pci_dev *dev, struct msix_entry *entr=
ies,
+				int nvec, struct irq_affinity_desc *masks)
 {
 	int ret =3D 0, i, vec_count =3D pci_msix_vec_count(dev);
 	struct irq_affinity_desc *curmsk;
 	struct msi_desc desc;
-	void __iomem *addr;
=20
 	memset(&desc, 0, sizeof(desc));
=20
-	desc.nvec_used			=3D 1;
-	desc.pci.msi_attrib.is_msix	=3D 1;
-	desc.pci.msi_attrib.is_64	=3D 1;
-	desc.pci.msi_attrib.default_irq	=3D dev->irq;
-	desc.pci.mask_base		=3D base;
-
 	for (i =3D 0, curmsk =3D masks; i < nvec; i++, curmsk++) {
 		desc.msi_index =3D entries ? entries[i].entry : i;
 		desc.affinity =3D masks ? curmsk : NULL;
 		desc.pci.msi_attrib.is_virtual =3D desc.msi_index >=3D vec_count;
-		desc.pci.msi_attrib.can_mask =3D !pci_msi_ignore_mask &&
-					       !desc.pci.msi_attrib.is_virtual;
=20
-		if (desc.pci.msi_attrib.can_mask) {
-			addr =3D pci_msix_desc_addr(&desc);
-			desc.pci.msix_ctrl =3D readl(addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
-		}
+		msix_prepare_msi_desc(dev, &desc);
=20
-		ret =3D msi_add_msi_desc(&dev->dev, &desc);
+		ret =3D msi_insert_msi_desc(&dev->dev, &desc);
 		if (ret)
 			break;
 	}
@@ -562,9 +651,8 @@ static void msix_mask_all(void __iomem *base, int tsize)
 		writel(ctrl, base + PCI_MSIX_ENTRY_VECTOR_CTRL);
 }
=20
-static int msix_setup_interrupts(struct pci_dev *dev, void __iomem *base,
-				 struct msix_entry *entries, int nvec,
-				 struct irq_affinity *affd)
+static int msix_setup_interrupts(struct pci_dev *dev, struct msix_entry *ent=
ries,
+				 int nvec, struct irq_affinity *affd)
 {
 	struct irq_affinity_desc *masks =3D NULL;
 	int ret;
@@ -573,7 +661,7 @@ static int msix_setup_interrupts(struct pci_dev *dev, voi=
d __iomem *base,
 		masks =3D irq_create_affinity_masks(nvec, affd);
=20
 	msi_lock_descs(&dev->dev);
-	ret =3D msix_setup_msi_descs(dev, base, entries, nvec, masks);
+	ret =3D msix_setup_msi_descs(dev, entries, nvec, masks);
 	if (ret)
 		goto out_free;
=20
@@ -590,7 +678,7 @@ static int msix_setup_interrupts(struct pci_dev *dev, voi=
d __iomem *base,
 	goto out_unlock;
=20
 out_free:
-	free_msi_irqs(dev);
+	pci_free_msi_irqs(dev);
 out_unlock:
 	msi_unlock_descs(&dev->dev);
 	kfree(masks);
@@ -611,7 +699,6 @@ static int msix_setup_interrupts(struct pci_dev *dev, voi=
d __iomem *base,
 static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entr=
ies,
 				int nvec, struct irq_affinity *affd)
 {
-	void __iomem *base;
 	int ret, tsize;
 	u16 control;
=20
@@ -629,15 +716,13 @@ static int msix_capability_init(struct pci_dev *dev, st=
ruct msix_entry *entries,
 	pci_read_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, &control);
 	/* Request & Map MSI-X table region */
 	tsize =3D msix_table_size(control);
-	base =3D msix_map_region(dev, tsize);
-	if (!base) {
+	dev->msix_base =3D msix_map_region(dev, tsize);
+	if (!dev->msix_base) {
 		ret =3D -ENOMEM;
 		goto out_disable;
 	}
=20
-	dev->msix_base =3D base;
-
-	ret =3D msix_setup_interrupts(dev, base, entries, nvec, affd);
+	ret =3D msix_setup_interrupts(dev, entries, nvec, affd);
 	if (ret)
 		goto out_disable;
=20
@@ -652,7 +737,7 @@ static int msix_capability_init(struct pci_dev *dev, stru=
ct msix_entry *entries,
 	 * which takes the MSI-X mask bits into account even
 	 * when MSI-X is disabled, which prevents MSI delivery.
 	 */
-	msix_mask_all(base, tsize);
+	msix_mask_all(dev->msix_base, tsize);
 	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);
=20
 	pcibios_free_irq(dev);
@@ -665,236 +750,82 @@ static int msix_capability_init(struct pci_dev *dev, s=
truct msix_entry *entries,
 	return ret;
 }
=20
-/**
- * pci_msi_supported - check whether MSI may be enabled on a device
- * @dev: pointer to the pci_dev data structure of MSI device function
- * @nvec: how many MSIs have been requested?
- *
- * Look at global flags, the device itself, and its parent buses
- * to determine if MSI/-X are supported for the device. If MSI/-X is
- * supported return 1, else return 0.
- **/
-static int pci_msi_supported(struct pci_dev *dev, int nvec)
-{
-	struct pci_bus *bus;
-
-	/* MSI must be globally enabled and supported by the device */
-	if (!pci_msi_enable)
-		return 0;
-
-	if (!dev || dev->no_msi)
-		return 0;
-
-	/*
-	 * You can't ask to have 0 or less MSIs configured.
-	 *  a) it's stupid ..
-	 *  b) the list manipulation code assumes nvec >=3D 1.
-	 */
-	if (nvec < 1)
-		return 0;
-
-	/*
-	 * Any bridge which does NOT route MSI transactions from its
-	 * secondary bus to its primary bus must set NO_MSI flag on
-	 * the secondary pci_bus.
-	 *
-	 * The NO_MSI flag can either be set directly by:
-	 * - arch-specific PCI host bus controller drivers (deprecated)
-	 * - quirks for specific PCI bridges
-	 *
-	 * or indirectly by platform-specific PCI host bridge drivers by
-	 * advertising the 'msi_domain' property, which results in
-	 * the NO_MSI flag when no MSI domain is found for this bridge
-	 * at probe time.
-	 */
-	for (bus =3D dev->bus; bus; bus =3D bus->parent)
-		if (bus->bus_flags & PCI_BUS_FLAGS_NO_MSI)
-			return 0;
-
-	return 1;
-}
-
-/**
- * pci_msi_vec_count - Return the number of MSI vectors a device can send
- * @dev: device to report about
- *
- * This function returns the number of MSI vectors a device requested via
- * Multiple Message Capable register. It returns a negative errno if the
- * device is not capable sending MSI interrupts. Otherwise, the call succeeds
- * and returns a power of two, up to a maximum of 2^5 (32), according to the
- * MSI specification.
- **/
-int pci_msi_vec_count(struct pci_dev *dev)
-{
-	int ret;
-	u16 msgctl;
-
-	if (!dev->msi_cap)
-		return -EINVAL;
-
-	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &msgctl);
-	ret =3D 1 << ((msgctl & PCI_MSI_FLAGS_QMASK) >> 1);
-
-	return ret;
-}
-EXPORT_SYMBOL(pci_msi_vec_count);
-
-static void pci_msi_shutdown(struct pci_dev *dev)
-{
-	struct msi_desc *desc;
-
-	if (!pci_msi_enable || !dev || !dev->msi_enabled)
-		return;
-
-	pci_msi_set_enable(dev, 0);
-	pci_intx_for_msi(dev, 1);
-	dev->msi_enabled =3D 0;
-
-	/* Return the device with MSI unmasked as initial states */
-	desc =3D msi_first_desc(&dev->dev, MSI_DESC_ALL);
-	if (!WARN_ON_ONCE(!desc))
-		pci_msi_unmask(desc, msi_multi_mask(desc));
-
-	/* Restore dev->irq to its default pin-assertion IRQ */
-	dev->irq =3D desc->pci.msi_attrib.default_irq;
-	pcibios_alloc_irq(dev);
-}
-
-void pci_disable_msi(struct pci_dev *dev)
-{
-	if (!pci_msi_enable || !dev || !dev->msi_enabled)
-		return;
-
-	msi_lock_descs(&dev->dev);
-	pci_msi_shutdown(dev);
-	free_msi_irqs(dev);
-	msi_unlock_descs(&dev->dev);
-}
-EXPORT_SYMBOL(pci_disable_msi);
-
-/**
- * pci_msix_vec_count - return the number of device's MSI-X table entries
- * @dev: pointer to the pci_dev data structure of MSI-X device function
- * This function returns the number of device's MSI-X table entries and
- * therefore the number of MSI-X vectors device is capable of sending.
- * It returns a negative errno if the device is not capable of sending MSI-X
- * interrupts.
- **/
-int pci_msix_vec_count(struct pci_dev *dev)
-{
-	u16 control;
-
-	if (!dev->msix_cap)
-		return -EINVAL;
-
-	pci_read_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, &control);
-	return msix_table_size(control);
-}
-EXPORT_SYMBOL(pci_msix_vec_count);
-
-static int __pci_enable_msix(struct pci_dev *dev, struct msix_entry *entries,
-			     int nvec, struct irq_affinity *affd, int flags)
+static bool pci_msix_validate_entries(struct pci_dev *dev, struct msix_entry=
 *entries,
+				      int nvec, int hwsize)
 {
-	int nr_entries;
+	bool nogap;
 	int i, j;
=20
-	if (!pci_msi_supported(dev, nvec) || dev->current_state !=3D PCI_D0)
-		return -EINVAL;
+	if (!entries)
+		return true;
=20
-	nr_entries =3D pci_msix_vec_count(dev);
-	if (nr_entries < 0)
-		return nr_entries;
-	if (nvec > nr_entries && !(flags & PCI_IRQ_VIRTUAL))
-		return nr_entries;
+	nogap =3D pci_msi_domain_supports(dev, MSI_FLAG_MSIX_CONTIGUOUS, DENY_LEGAC=
Y);
=20
-	if (entries) {
-		/* Check for any invalid entries */
-		for (i =3D 0; i < nvec; i++) {
-			if (entries[i].entry >=3D nr_entries)
-				return -EINVAL;		/* invalid entry */
-			for (j =3D i + 1; j < nvec; j++) {
-				if (entries[i].entry =3D=3D entries[j].entry)
-					return -EINVAL;	/* duplicate entry */
-			}
-		}
-	}
+	for (i =3D 0; i < nvec; i++) {
+		/* Entry within hardware limit? */
+		if (entries[i].entry >=3D hwsize)
+			return false;
=20
-	/* Check whether driver already requested for MSI IRQ */
-	if (dev->msi_enabled) {
-		pci_info(dev, "can't enable MSI-X (MSI IRQ already assigned)\n");
-		return -EINVAL;
+		/* Check for duplicate entries */
+		for (j =3D i + 1; j < nvec; j++) {
+			if (entries[i].entry =3D=3D entries[j].entry)
+				return false;
+		}
+		/* Check for unsupported gaps */
+		if (nogap && entries[i].entry !=3D i)
+			return false;
 	}
-	return msix_capability_init(dev, entries, nvec, affd);
+	return true;
 }
=20
-static void pci_msix_shutdown(struct pci_dev *dev)
+int __pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries,=
 int minvec,
+			    int maxvec, struct irq_affinity *affd, int flags)
 {
-	struct msi_desc *desc;
+	int hwsize, rc, nvec =3D maxvec;
=20
-	if (!pci_msi_enable || !dev || !dev->msix_enabled)
-		return;
+	if (maxvec < minvec)
+		return -ERANGE;
=20
-	if (pci_dev_is_disconnected(dev)) {
-		dev->msix_enabled =3D 0;
-		return;
+	if (dev->msi_enabled) {
+		pci_info(dev, "can't enable MSI-X (MSI already enabled)\n");
+		return -EINVAL;
 	}
=20
-	/* Return the device with MSI-X masked as initial states */
-	msi_for_each_desc(desc, &dev->dev, MSI_DESC_ALL)
-		pci_msix_mask(desc);
-
-	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE, 0);
-	pci_intx_for_msi(dev, 1);
-	dev->msix_enabled =3D 0;
-	pcibios_alloc_irq(dev);
-}
+	if (WARN_ON_ONCE(dev->msix_enabled))
+		return -EINVAL;
=20
-void pci_disable_msix(struct pci_dev *dev)
-{
-	if (!pci_msi_enable || !dev || !dev->msix_enabled)
-		return;
+	/* Check MSI-X early on irq domain enabled architectures */
+	if (!pci_msi_domain_supports(dev, MSI_FLAG_PCI_MSIX, ALLOW_LEGACY))
+		return -ENOTSUPP;
=20
-	msi_lock_descs(&dev->dev);
-	pci_msix_shutdown(dev);
-	free_msi_irqs(dev);
-	msi_unlock_descs(&dev->dev);
-}
-EXPORT_SYMBOL(pci_disable_msix);
+	if (!pci_msi_supported(dev, nvec) || dev->current_state !=3D PCI_D0)
+		return -EINVAL;
=20
-static int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxve=
c,
-				  struct irq_affinity *affd)
-{
-	int nvec;
-	int rc;
+	hwsize =3D pci_msix_vec_count(dev);
+	if (hwsize < 0)
+		return hwsize;
=20
-	if (!pci_msi_supported(dev, minvec) || dev->current_state !=3D PCI_D0)
+	if (!pci_msix_validate_entries(dev, entries, nvec, hwsize))
 		return -EINVAL;
=20
-	/* Check whether driver already requested MSI-X IRQs */
-	if (dev->msix_enabled) {
-		pci_info(dev, "can't enable MSI (MSI-X already enabled)\n");
-		return -EINVAL;
+	if (hwsize < nvec) {
+		/* Keep the IRQ virtual hackery working */
+		if (flags & PCI_IRQ_VIRTUAL)
+			hwsize =3D nvec;
+		else
+			nvec =3D hwsize;
 	}
=20
-	if (maxvec < minvec)
-		return -ERANGE;
-
-	if (WARN_ON_ONCE(dev->msi_enabled))
-		return -EINVAL;
-
-	nvec =3D pci_msi_vec_count(dev);
-	if (nvec < 0)
-		return nvec;
 	if (nvec < minvec)
 		return -ENOSPC;
=20
-	if (nvec > maxvec)
-		nvec =3D maxvec;
-
 	rc =3D pci_setup_msi_context(dev);
 	if (rc)
 		return rc;
=20
+	if (!pci_setup_msix_device_domain(dev, hwsize))
+		return -ENODEV;
+
 	for (;;) {
 		if (affd) {
 			nvec =3D irq_calc_affinity_vectors(minvec, nvec, affd);
@@ -902,7 +833,7 @@ static int __pci_enable_msi_range(struct pci_dev *dev, in=
t minvec, int maxvec,
 				return -ENOSPC;
 		}
=20
-		rc =3D msi_capability_init(dev, nvec, affd);
+		rc =3D msix_capability_init(dev, entries, nvec, affd);
 		if (rc =3D=3D 0)
 			return nvec;
=20
@@ -915,214 +846,67 @@ static int __pci_enable_msi_range(struct pci_dev *dev,=
 int minvec, int maxvec,
 	}
 }
=20
-/* deprecated, don't use */
-int pci_enable_msi(struct pci_dev *dev)
-{
-	int rc =3D __pci_enable_msi_range(dev, 1, 1, NULL);
-	if (rc < 0)
-		return rc;
-	return 0;
-}
-EXPORT_SYMBOL(pci_enable_msi);
-
-static int __pci_enable_msix_range(struct pci_dev *dev,
-				   struct msix_entry *entries, int minvec,
-				   int maxvec, struct irq_affinity *affd,
-				   int flags)
+void __pci_restore_msix_state(struct pci_dev *dev)
 {
-	int rc, nvec =3D maxvec;
-
-	if (maxvec < minvec)
-		return -ERANGE;
-
-	if (WARN_ON_ONCE(dev->msix_enabled))
-		return -EINVAL;
-
-	rc =3D pci_setup_msi_context(dev);
-	if (rc)
-		return rc;
+	struct msi_desc *entry;
+	bool write_msg;
=20
-	for (;;) {
-		if (affd) {
-			nvec =3D irq_calc_affinity_vectors(minvec, nvec, affd);
-			if (nvec < minvec)
-				return -ENOSPC;
-		}
+	if (!dev->msix_enabled)
+		return;
=20
-		rc =3D __pci_enable_msix(dev, entries, nvec, affd, flags);
-		if (rc =3D=3D 0)
-			return nvec;
+	/* route the table */
+	pci_intx_for_msi(dev, 0);
+	pci_msix_clear_and_set_ctrl(dev, 0,
+				PCI_MSIX_FLAGS_ENABLE | PCI_MSIX_FLAGS_MASKALL);
=20
-		if (rc < 0)
-			return rc;
-		if (rc < minvec)
-			return -ENOSPC;
+	write_msg =3D arch_restore_msi_irqs(dev);
=20
-		nvec =3D rc;
+	msi_lock_descs(&dev->dev);
+	msi_for_each_desc(entry, &dev->dev, MSI_DESC_ALL) {
+		if (write_msg)
+			__pci_write_msi_msg(entry, &entry->msg);
+		pci_msix_write_vector_ctrl(entry, entry->pci.msix_ctrl);
 	}
-}
+	msi_unlock_descs(&dev->dev);
=20
-/**
- * pci_enable_msix_range - configure device's MSI-X capability structure
- * @dev: pointer to the pci_dev data structure of MSI-X device function
- * @entries: pointer to an array of MSI-X entries
- * @minvec: minimum number of MSI-X IRQs requested
- * @maxvec: maximum number of MSI-X IRQs requested
- *
- * Setup the MSI-X capability structure of device function with a maximum
- * possible number of interrupts in the range between @minvec and @maxvec
- * upon its software driver call to request for MSI-X mode enabled on its
- * hardware device function. It returns a negative errno if an error occurs.
- * If it succeeds, it returns the actual number of interrupts allocated and
- * indicates the successful configuration of MSI-X capability structure
- * with new allocated MSI-X interrupts.
- **/
-int pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries,
-		int minvec, int maxvec)
-{
-	return __pci_enable_msix_range(dev, entries, minvec, maxvec, NULL, 0);
+	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);
 }
-EXPORT_SYMBOL(pci_enable_msix_range);
=20
-/**
- * pci_alloc_irq_vectors_affinity - allocate multiple IRQs for a device
- * @dev:		PCI device to operate on
- * @min_vecs:		minimum number of vectors required (must be >=3D 1)
- * @max_vecs:		maximum (desired) number of vectors
- * @flags:		flags or quirks for the allocation
- * @affd:		optional description of the affinity requirements
- *
- * Allocate up to @max_vecs interrupt vectors for @dev, using MSI-X or MSI
- * vectors if available, and fall back to a single legacy vector
- * if neither is available.  Return the number of vectors allocated,
- * (which might be smaller than @max_vecs) if successful, or a negative
- * error code on error. If less than @min_vecs interrupt vectors are
- * available for @dev the function will fail with -ENOSPC.
- *
- * To get the Linux IRQ number used for a vector that can be passed to
- * request_irq() use the pci_irq_vector() helper.
- */
-int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vec=
s,
-				   unsigned int max_vecs, unsigned int flags,
-				   struct irq_affinity *affd)
+void pci_msix_shutdown(struct pci_dev *dev)
 {
-	struct irq_affinity msi_default_affd =3D {0};
-	int nvecs =3D -ENOSPC;
-
-	if (flags & PCI_IRQ_AFFINITY) {
-		if (!affd)
-			affd =3D &msi_default_affd;
-	} else {
-		if (WARN_ON(affd))
-			affd =3D NULL;
-	}
+	struct msi_desc *desc;
=20
-	if (flags & PCI_IRQ_MSIX) {
-		nvecs =3D __pci_enable_msix_range(dev, NULL, min_vecs, max_vecs,
-						affd, flags);
-		if (nvecs > 0)
-			return nvecs;
-	}
+	if (!pci_msi_enable || !dev || !dev->msix_enabled)
+		return;
=20
-	if (flags & PCI_IRQ_MSI) {
-		nvecs =3D __pci_enable_msi_range(dev, min_vecs, max_vecs, affd);
-		if (nvecs > 0)
-			return nvecs;
+	if (pci_dev_is_disconnected(dev)) {
+		dev->msix_enabled =3D 0;
+		return;
 	}
=20
-	/* use legacy IRQ if allowed */
-	if (flags & PCI_IRQ_LEGACY) {
-		if (min_vecs =3D=3D 1 && dev->irq) {
-			/*
-			 * Invoke the affinity spreading logic to ensure that
-			 * the device driver can adjust queue configuration
-			 * for the single interrupt case.
-			 */
-			if (affd)
-				irq_create_affinity_masks(1, affd);
-			pci_intx(dev, 1);
-			return 1;
-		}
-	}
+	/* Return the device with MSI-X masked as initial states */
+	msi_for_each_desc(desc, &dev->dev, MSI_DESC_ALL)
+		pci_msix_mask(desc);
=20
-	return nvecs;
+	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE, 0);
+	pci_intx_for_msi(dev, 1);
+	dev->msix_enabled =3D 0;
+	pcibios_alloc_irq(dev);
 }
-EXPORT_SYMBOL(pci_alloc_irq_vectors_affinity);
=20
-/**
- * pci_free_irq_vectors - free previously allocated IRQs for a device
- * @dev:		PCI device to operate on
- *
- * Undoes the allocations and enabling in pci_alloc_irq_vectors().
- */
-void pci_free_irq_vectors(struct pci_dev *dev)
-{
-	pci_disable_msix(dev);
-	pci_disable_msi(dev);
-}
-EXPORT_SYMBOL(pci_free_irq_vectors);
+/* Common interfaces */
=20
-/**
- * pci_irq_vector - return Linux IRQ number of a device vector
- * @dev:	PCI device to operate on
- * @nr:		Interrupt vector index (0-based)
- *
- * @nr has the following meanings depending on the interrupt mode:
- *   MSI-X:	The index in the MSI-X vector table
- *   MSI:	The index of the enabled MSI vectors
- *   INTx:	Must be 0
- *
- * Return: The Linux interrupt number or -EINVAl if @nr is out of range.
- */
-int pci_irq_vector(struct pci_dev *dev, unsigned int nr)
+void pci_free_msi_irqs(struct pci_dev *dev)
 {
-	unsigned int irq;
-
-	if (!dev->msi_enabled && !dev->msix_enabled)
-		return !nr ? dev->irq : -EINVAL;
+	pci_msi_teardown_msi_irqs(dev);
=20
-	irq =3D msi_get_virq(&dev->dev, nr);
-	return irq ? irq : -EINVAL;
+	if (dev->msix_base) {
+		iounmap(dev->msix_base);
+		dev->msix_base =3D NULL;
+	}
 }
-EXPORT_SYMBOL(pci_irq_vector);
-
-/**
- * pci_irq_get_affinity - return the affinity of a particular MSI vector
- * @dev:	PCI device to operate on
- * @nr:		device-relative interrupt vector index (0-based).
- *
- * @nr has the following meanings depending on the interrupt mode:
- *   MSI-X:	The index in the MSI-X vector table
- *   MSI:	The index of the enabled MSI vectors
- *   INTx:	Must be 0
- *
- * Return: A cpumask pointer or NULL if @nr is out of range
- */
-const struct cpumask *pci_irq_get_affinity(struct pci_dev *dev, int nr)
-{
-	int idx, irq =3D pci_irq_vector(dev, nr);
-	struct msi_desc *desc;
=20
-	if (WARN_ON_ONCE(irq <=3D 0))
-		return NULL;
-
-	desc =3D irq_get_msi_desc(irq);
-	/* Non-MSI does not have the information handy */
-	if (!desc)
-		return cpu_possible_mask;
-
-	/* MSI[X] interrupts can be allocated without affinity descriptor */
-	if (!desc->affinity)
-		return NULL;
-
-	/*
-	 * MSI has a mask array in the descriptor.
-	 * MSI-X has a single mask.
-	 */
-	idx =3D dev->msi_enabled ? nr : 0;
-	return &desc->affinity[idx].mask;
-}
-EXPORT_SYMBOL(pci_irq_get_affinity);
+/* Misc. infrastructure */
=20
 struct pci_dev *msi_desc_to_pci_dev(struct msi_desc *desc)
 {
@@ -1134,15 +918,3 @@ void pci_no_msi(void)
 {
 	pci_msi_enable =3D 0;
 }
-
-/**
- * pci_msi_enabled - is MSI enabled?
- *
- * Returns true if MSI has not been disabled by the command-line option
- * pci=3Dnomsi.
- **/
-int pci_msi_enabled(void)
-{
-	return pci_msi_enable;
-}
-EXPORT_SYMBOL(pci_msi_enabled);
diff --git a/drivers/pci/msi/msi.h b/drivers/pci/msi/msi.h
index dbeff066bedd..ee53cf079f4e 100644
--- a/drivers/pci/msi/msi.h
+++ b/drivers/pci/msi/msi.h
@@ -5,24 +5,70 @@
=20
 #define msix_table_size(flags)	((flags & PCI_MSIX_FLAGS_QSIZE) + 1)
=20
-extern int pci_msi_setup_msi_irqs(struct pci_dev *dev, int nvec, int type);
-extern void pci_msi_teardown_msi_irqs(struct pci_dev *dev);
+int pci_msi_setup_msi_irqs(struct pci_dev *dev, int nvec, int type);
+void pci_msi_teardown_msi_irqs(struct pci_dev *dev);
=20
-#ifdef CONFIG_PCI_MSI_ARCH_FALLBACKS
-extern int pci_msi_legacy_setup_msi_irqs(struct pci_dev *dev, int nvec, int =
type);
-extern void pci_msi_legacy_teardown_msi_irqs(struct pci_dev *dev);
-#else
-static inline int pci_msi_legacy_setup_msi_irqs(struct pci_dev *dev, int nve=
c, int type)
+/* Mask/unmask helpers */
+void pci_msi_update_mask(struct msi_desc *desc, u32 clear, u32 set);
+
+static inline void pci_msi_mask(struct msi_desc *desc, u32 mask)
 {
-	WARN_ON_ONCE(1);
-	return -ENODEV;
+	pci_msi_update_mask(desc, 0, mask);
 }
=20
-static inline void pci_msi_legacy_teardown_msi_irqs(struct pci_dev *dev)
+static inline void pci_msi_unmask(struct msi_desc *desc, u32 mask)
 {
-	WARN_ON_ONCE(1);
+	pci_msi_update_mask(desc, mask, 0);
+}
+
+static inline void __iomem *pci_msix_desc_addr(struct msi_desc *desc)
+{
+	return desc->pci.mask_base + desc->msi_index * PCI_MSIX_ENTRY_SIZE;
+}
+
+/*
+ * This internal function does not flush PCI writes to the device.  All
+ * users must ensure that they read from the device before either assuming
+ * that the device state is up to date, or returning out of this file.
+ * It does not affect the msi_desc::msix_ctrl cache either. Use with care!
+ */
+static inline void pci_msix_write_vector_ctrl(struct msi_desc *desc, u32 ctr=
l)
+{
+	void __iomem *desc_addr =3D pci_msix_desc_addr(desc);
+
+	if (desc->pci.msi_attrib.can_mask)
+		writel(ctrl, desc_addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
+}
+
+static inline void pci_msix_mask(struct msi_desc *desc)
+{
+	desc->pci.msix_ctrl |=3D PCI_MSIX_ENTRY_CTRL_MASKBIT;
+	pci_msix_write_vector_ctrl(desc, desc->pci.msix_ctrl);
+	/* Flush write to device */
+	readl(desc->pci.mask_base);
+}
+
+static inline void pci_msix_unmask(struct msi_desc *desc)
+{
+	desc->pci.msix_ctrl &=3D ~PCI_MSIX_ENTRY_CTRL_MASKBIT;
+	pci_msix_write_vector_ctrl(desc, desc->pci.msix_ctrl);
+}
+
+static inline void __pci_msi_mask_desc(struct msi_desc *desc, u32 mask)
+{
+	if (desc->pci.msi_attrib.is_msix)
+		pci_msix_mask(desc);
+	else
+		pci_msi_mask(desc, mask);
+}
+
+static inline void __pci_msi_unmask_desc(struct msi_desc *desc, u32 mask)
+{
+	if (desc->pci.msi_attrib.is_msix)
+		pci_msix_unmask(desc);
+	else
+		pci_msi_unmask(desc, mask);
 }
-#endif
=20
 /*
  * PCI 2.3 does not specify mask bits for each MSI interrupt.  Attempting to
@@ -37,3 +83,47 @@ static inline __attribute_const__ u32 msi_multi_mask(struc=
t msi_desc *desc)
 		return 0xffffffff;
 	return (1 << (1 << desc->pci.msi_attrib.multi_cap)) - 1;
 }
+
+void msix_prepare_msi_desc(struct pci_dev *dev, struct msi_desc *desc);
+
+/* Subsystem variables */
+extern int pci_msi_enable;
+
+/* MSI internal functions invoked from the public APIs */
+void pci_msi_shutdown(struct pci_dev *dev);
+void pci_msix_shutdown(struct pci_dev *dev);
+void pci_free_msi_irqs(struct pci_dev *dev);
+int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec, stru=
ct irq_affinity *affd);
+int __pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries,=
 int minvec,
+			    int maxvec,  struct irq_affinity *affd, int flags);
+void __pci_restore_msi_state(struct pci_dev *dev);
+void __pci_restore_msix_state(struct pci_dev *dev);
+
+/* irq_domain related functionality */
+
+enum support_mode {
+	ALLOW_LEGACY,
+	DENY_LEGACY,
+};
+
+bool pci_msi_domain_supports(struct pci_dev *dev, unsigned int feature_mask,=
 enum support_mode mode);
+bool pci_setup_msi_device_domain(struct pci_dev *pdev);
+bool pci_setup_msix_device_domain(struct pci_dev *pdev, unsigned int hwsize);
+
+/* Legacy (!IRQDOMAIN) fallbacks */
+
+#ifdef CONFIG_PCI_MSI_ARCH_FALLBACKS
+int pci_msi_legacy_setup_msi_irqs(struct pci_dev *dev, int nvec, int type);
+void pci_msi_legacy_teardown_msi_irqs(struct pci_dev *dev);
+#else
+static inline int pci_msi_legacy_setup_msi_irqs(struct pci_dev *dev, int nve=
c, int type)
+{
+	WARN_ON_ONCE(1);
+	return -ENODEV;
+}
+
+static inline void pci_msi_legacy_teardown_msi_irqs(struct pci_dev *dev)
+{
+	WARN_ON_ONCE(1);
+}
+#endif
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b66fa42c4b1f..fdd7e56ddf40 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -842,7 +842,6 @@ static struct irq_domain *pci_host_bridge_msi_domain(stru=
ct pci_bus *bus)
 	if (!d)
 		d =3D pci_host_bridge_acpi_msi_domain(bus);
=20
-#ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
 	/*
 	 * If no IRQ domain was found via the OF tree, try looking it up
 	 * directly through the fwnode_handle.
@@ -854,7 +853,6 @@ static struct irq_domain *pci_host_bridge_msi_domain(stru=
ct pci_bus *bus)
 			d =3D irq_find_matching_fwnode(fwnode,
 						     DOMAIN_BUS_PCI_MSI);
 	}
-#endif
=20
 	return d;
 }
diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index 341010f20b77..692ffd56f5cc 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -93,7 +93,7 @@ config ARM_PMU_ACPI
 config ARM_SMMU_V3_PMU
 	 tristate "ARM SMMUv3 Performance Monitors Extension"
 	 depends on (ARM64 && ACPI) || (COMPILE_TEST && 64BIT)
-	 depends on GENERIC_MSI_IRQ_DOMAIN
+	 depends on GENERIC_MSI_IRQ
 	   help
 	   Provides support for the ARM SMMUv3 Performance Monitor Counter
 	   Groups (PMCG), which provide monitoring of transactions passing
diff --git a/drivers/soc/fsl/dpio/dpio-driver.c b/drivers/soc/fsl/dpio/dpio-d=
river.c
index 5a2edc48dd79..74eace3109a1 100644
--- a/drivers/soc/fsl/dpio/dpio-driver.c
+++ b/drivers/soc/fsl/dpio/dpio-driver.c
@@ -10,7 +10,6 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
-#include <linux/msi.h>
 #include <linux/dma-mapping.h>
 #include <linux/delay.h>
 #include <linux/io.h>
diff --git a/drivers/soc/ti/Kconfig b/drivers/soc/ti/Kconfig
index 7e2fb1c16af1..e9a597e4bdc8 100644
--- a/drivers/soc/ti/Kconfig
+++ b/drivers/soc/ti/Kconfig
@@ -98,6 +98,6 @@ endif # SOC_TI
=20
 config TI_SCI_INTA_MSI_DOMAIN
 	bool
-	select GENERIC_MSI_IRQ_DOMAIN
+	select GENERIC_MSI_IRQ
 	help
 	  Driver to enable Interrupt Aggregator specific MSI Domain.
diff --git a/drivers/soc/ti/ti_sci_inta_msi.c b/drivers/soc/ti/ti_sci_inta_ms=
i.c
index 991c78b34745..b9251e1d9a5c 100644
--- a/drivers/soc/ti/ti_sci_inta_msi.c
+++ b/drivers/soc/ti/ti_sci_inta_msi.c
@@ -73,13 +73,13 @@ static int ti_sci_inta_msi_alloc_descs(struct device *dev,
 	for (set =3D 0; set < res->sets; set++) {
 		for (i =3D 0; i < res->desc[set].num; i++, count++) {
 			msi_desc.msi_index =3D res->desc[set].start + i;
-			if (msi_add_msi_desc(dev, &msi_desc))
+			if (msi_insert_msi_desc(dev, &msi_desc))
 				goto fail;
 		}
=20
 		for (i =3D 0; i < res->desc[set].num_sec; i++, count++) {
 			msi_desc.msi_index =3D res->desc[set].start_sec + i;
-			if (msi_add_msi_desc(dev, &msi_desc))
+			if (msi_insert_msi_desc(dev, &msi_desc))
 				goto fail;
 		}
 	}
@@ -93,13 +93,8 @@ int ti_sci_inta_msi_domain_alloc_irqs(struct device *dev,
 				      struct ti_sci_resource *res)
 {
 	struct platform_device *pdev =3D to_platform_device(dev);
-	struct irq_domain *msi_domain;
 	int ret, nvec;
=20
-	msi_domain =3D dev_get_msi_domain(dev);
-	if (!msi_domain)
-		return -EINVAL;
-
 	if (pdev->id < 0)
 		return -ENODEV;
=20
@@ -114,7 +109,8 @@ int ti_sci_inta_msi_domain_alloc_irqs(struct device *dev,
 		goto unlock;
 	}
=20
-	ret =3D msi_domain_alloc_irqs_descs_locked(msi_domain, dev, nvec);
+	/* Use alloc ALL as it's unclear whether there are gaps in the indices */
+	ret =3D msi_domain_alloc_irqs_all_locked(dev, MSI_DEFAULT_DOMAIN, nvec);
 	if (ret)
 		dev_err(dev, "Failed to allocate IRQs %d\n", ret);
 unlock:
diff --git a/drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c b/drivers/vfio/fsl-mc/vfi=
o_fsl_mc_intr.c
index 7b428eac3d3e..64d01f3fb13d 100644
--- a/drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c
+++ b/drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c
@@ -8,7 +8,6 @@
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/eventfd.h>
-#include <linux/msi.h>
=20
 #include "linux/fsl/mc.h"
 #include "vfio_fsl_mc_private.h"
diff --git a/include/asm-generic/msi.h b/include/asm-generic/msi.h
index bf910d47e900..124c734ca5d9 100644
--- a/include/asm-generic/msi.h
+++ b/include/asm-generic/msi.h
@@ -4,7 +4,7 @@
=20
 #include <linux/types.h>
=20
-#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
+#ifdef CONFIG_GENERIC_MSI_IRQ
=20
 #ifndef NUM_MSI_ALLOC_SCRATCHPAD_REGS
 # define NUM_MSI_ALLOC_SCRATCHPAD_REGS	2
@@ -36,6 +36,6 @@ typedef struct msi_alloc_info {
=20
 #define GENERIC_MSI_DOMAIN_OPS		1
=20
-#endif /* CONFIG_GENERIC_MSI_IRQ_DOMAIN */
+#endif /* CONFIG_GENERIC_MSI_IRQ */
=20
 #endif
diff --git a/include/clocksource/hyperv_timer.h b/include/clocksource/hyperv_=
timer.h
index b3f5d73ae1d6..b4a3935801ca 100644
--- a/include/clocksource/hyperv_timer.h
+++ b/include/clocksource/hyperv_timer.h
@@ -15,13 +15,15 @@
=20
 #include <linux/clocksource.h>
 #include <linux/math64.h>
-#include <asm/mshyperv.h>
+#include <asm/hyperv-tlfs.h>
=20
 #define HV_MAX_MAX_DELTA_TICKS 0xffffffff
 #define HV_MIN_DELTA_TICKS 1
=20
 #ifdef CONFIG_HYPERV_TIMER
=20
+#include <asm/hyperv_timer.h>
+
 /* Routines called by the VMbus driver */
 extern int hv_stimer_alloc(bool have_percpu_irqs);
 extern int hv_stimer_cleanup(unsigned int cpu);
diff --git a/include/linux/device.h b/include/linux/device.h
index 424b55df0272..c90a444be1c4 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -378,10 +378,8 @@ struct dev_links_info {
  * @data:	Pointer to MSI device data
  */
 struct dev_msi_info {
-#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
-	struct irq_domain	*domain;
-#endif
 #ifdef CONFIG_GENERIC_MSI_IRQ
+	struct irq_domain	*domain;
 	struct msi_device_data	*data;
 #endif
 };
@@ -742,7 +740,7 @@ static inline void set_dev_node(struct device *dev, int n=
ode)
=20
 static inline struct irq_domain *dev_get_msi_domain(const struct device *dev)
 {
-#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
+#ifdef CONFIG_GENERIC_MSI_IRQ
 	return dev->msi.domain;
 #else
 	return NULL;
@@ -751,7 +749,7 @@ static inline struct irq_domain *dev_get_msi_domain(const=
 struct device *dev)
=20
 static inline void dev_set_msi_domain(struct device *dev, struct irq_domain =
*d)
 {
-#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
+#ifdef CONFIG_GENERIC_MSI_IRQ
 	dev->msi.domain =3D d;
 #endif
 }
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 6aeea1071b1b..88ae4513abb5 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -27,7 +27,7 @@ struct gpio_chip;
=20
 union gpio_irq_fwspec {
 	struct irq_fwspec	fwspec;
-#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
+#ifdef CONFIG_GENERIC_MSI_IRQ
 	msi_alloc_info_t	msiinfo;
 #endif
 };
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 00d577f90883..a372086750ca 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -31,6 +31,7 @@
 #define _LINUX_IRQDOMAIN_H
=20
 #include <linux/types.h>
+#include <linux/irqdomain_defs.h>
 #include <linux/irqhandler.h>
 #include <linux/of.h>
 #include <linux/mutex.h>
@@ -45,6 +46,7 @@ struct irq_desc;
 struct cpumask;
 struct seq_file;
 struct irq_affinity_desc;
+struct msi_parent_ops;
=20
 #define IRQ_DOMAIN_IRQ_SPEC_PARAMS 16
=20
@@ -68,27 +70,6 @@ struct irq_fwspec {
 void of_phandle_args_to_fwspec(struct device_node *np, const u32 *args,
 			       unsigned int count, struct irq_fwspec *fwspec);
=20
-/*
- * Should several domains have the same device node, but serve
- * different purposes (for example one domain is for PCI/MSI, and the
- * other for wired IRQs), they can be distinguished using a
- * bus-specific token. Most domains are expected to only carry
- * DOMAIN_BUS_ANY.
- */
-enum irq_domain_bus_token {
-	DOMAIN_BUS_ANY		=3D 0,
-	DOMAIN_BUS_WIRED,
-	DOMAIN_BUS_GENERIC_MSI,
-	DOMAIN_BUS_PCI_MSI,
-	DOMAIN_BUS_PLATFORM_MSI,
-	DOMAIN_BUS_NEXUS,
-	DOMAIN_BUS_IPI,
-	DOMAIN_BUS_FSL_MC_MSI,
-	DOMAIN_BUS_TI_SCI_INTA_MSI,
-	DOMAIN_BUS_WAKEUP,
-	DOMAIN_BUS_VMD_MSI,
-};
-
 /**
  * struct irq_domain_ops - Methods for irq_domain objects
  * @match: Match an interrupt controller device node to a host, returns
@@ -137,53 +118,61 @@ struct irq_domain_chip_generic;
=20
 /**
  * struct irq_domain - Hardware interrupt number translation object
- * @link: Element in global irq_domain list.
- * @name: Name of interrupt domain
- * @ops: pointer to irq_domain methods
- * @host_data: private data pointer for use by owner.  Not touched by irq_do=
main
- *             core code.
- * @flags: host per irq_domain flags
- * @mapcount: The number of mapped interrupts
+ * @link:	Element in global irq_domain list.
+ * @name:	Name of interrupt domain
+ * @ops:	Pointer to irq_domain methods
+ * @host_data:	Private data pointer for use by owner.  Not touched by irq_do=
main
+ *		core code.
+ * @flags:	Per irq_domain flags
+ * @mapcount:	The number of mapped interrupts
  *
- * Optional elements
- * @fwnode: Pointer to firmware node associated with the irq_domain. Pretty =
easy
- *          to swap it for the of_node via the irq_domain_get_of_node access=
or
- * @gc: Pointer to a list of generic chips. There is a helper function for
- *      setting up one or more generic chips for interrupt controllers
- *      drivers using the generic chip library which uses this pointer.
- * @dev: Pointer to a device that the domain represent, and that will be
- *       used for power management purposes.
- * @parent: Pointer to parent irq_domain to support hierarchy irq_domains
+ * Optional elements:
+ * @fwnode:	Pointer to firmware node associated with the irq_domain. Pretty =
easy
+ *		to swap it for the of_node via the irq_domain_get_of_node accessor
+ * @gc:		Pointer to a list of generic chips. There is a helper function for
+ *		setting up one or more generic chips for interrupt controllers
+ *		drivers using the generic chip library which uses this pointer.
+ * @dev:	Pointer to the device which instantiated the irqdomain
+ *		With per device irq domains this is not necessarily the same
+ *		as @pm_dev.
+ * @pm_dev:	Pointer to a device that can be utilized for power management
+ *		purposes related to the irq domain.
+ * @parent:	Pointer to parent irq_domain to support hierarchy irq_domains
+ * @msi_parent_ops: Pointer to MSI parent domain methods for per device doma=
in init
  *
- * Revmap data, used internally by irq_domain
- * @revmap_size: Size of the linear map table @revmap[]
- * @revmap_tree: Radix map tree for hwirqs that don't fit in the linear map
- * @revmap_mutex: Lock for the revmap
- * @revmap: Linear table of irq_data pointers
+ * Revmap data, used internally by the irq domain code:
+ * @revmap_size:	Size of the linear map table @revmap[]
+ * @revmap_tree:	Radix map tree for hwirqs that don't fit in the linear map
+ * @revmap_mutex:	Lock for the revmap
+ * @revmap:		Linear table of irq_data pointers
  */
 struct irq_domain {
-	struct list_head link;
-	const char *name;
-	const struct irq_domain_ops *ops;
-	void *host_data;
-	unsigned int flags;
-	unsigned int mapcount;
+	struct list_head		link;
+	const char			*name;
+	const struct irq_domain_ops	*ops;
+	void				*host_data;
+	unsigned int			flags;
+	unsigned int			mapcount;
=20
 	/* Optional data */
-	struct fwnode_handle *fwnode;
-	enum irq_domain_bus_token bus_token;
-	struct irq_domain_chip_generic *gc;
-	struct device *dev;
+	struct fwnode_handle		*fwnode;
+	enum irq_domain_bus_token	bus_token;
+	struct irq_domain_chip_generic	*gc;
+	struct device			*dev;
+	struct device			*pm_dev;
 #ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
-	struct irq_domain *parent;
+	struct irq_domain		*parent;
+#endif
+#ifdef CONFIG_GENERIC_MSI_IRQ
+	const struct msi_parent_ops	*msi_parent_ops;
 #endif
=20
 	/* reverse map data. The linear map gets appended to the irq_domain */
-	irq_hw_number_t hwirq_max;
-	unsigned int revmap_size;
-	struct radix_tree_root revmap_tree;
-	struct mutex revmap_mutex;
-	struct irq_data __rcu *revmap[];
+	irq_hw_number_t			hwirq_max;
+	unsigned int			revmap_size;
+	struct radix_tree_root		revmap_tree;
+	struct mutex			revmap_mutex;
+	struct irq_data __rcu		*revmap[];
 };
=20
 /* Irq domain flags */
@@ -206,15 +195,14 @@ enum {
 	/* Irq domain implements MSI remapping */
 	IRQ_DOMAIN_FLAG_MSI_REMAP	=3D (1 << 5),
=20
-	/*
-	 * Quirk to handle MSI implementations which do not provide
-	 * masking. Currently known to affect x86, but partially
-	 * handled in core code.
-	 */
-	IRQ_DOMAIN_MSI_NOMASK_QUIRK	=3D (1 << 6),
-
 	/* Irq domain doesn't translate anything */
-	IRQ_DOMAIN_FLAG_NO_MAP		=3D (1 << 7),
+	IRQ_DOMAIN_FLAG_NO_MAP		=3D (1 << 6),
+
+	/* Irq domain is a MSI parent domain */
+	IRQ_DOMAIN_FLAG_MSI_PARENT	=3D (1 << 8),
+
+	/* Irq domain is a MSI device domain */
+	IRQ_DOMAIN_FLAG_MSI_DEVICE	=3D (1 << 9),
=20
 	/*
 	 * Flags starting from IRQ_DOMAIN_FLAG_NONCORE are reserved
@@ -233,7 +221,7 @@ static inline void irq_domain_set_pm_device(struct irq_do=
main *d,
 					    struct device *dev)
 {
 	if (d)
-		d->dev =3D dev;
+		d->pm_dev =3D dev;
 }
=20
 #ifdef CONFIG_IRQ_DOMAIN
@@ -578,6 +566,16 @@ static inline bool irq_domain_is_msi_remap(struct irq_do=
main *domain)
=20
 extern bool irq_domain_hierarchical_is_msi_remap(struct irq_domain *domain);
=20
+static inline bool irq_domain_is_msi_parent(struct irq_domain *domain)
+{
+	return domain->flags & IRQ_DOMAIN_FLAG_MSI_PARENT;
+}
+
+static inline bool irq_domain_is_msi_device(struct irq_domain *domain)
+{
+	return domain->flags & IRQ_DOMAIN_FLAG_MSI_DEVICE;
+}
+
 #else	/* CONFIG_IRQ_DOMAIN_HIERARCHY */
 static inline int irq_domain_alloc_irqs(struct irq_domain *domain,
 			unsigned int nr_irqs, int node, void *arg)
@@ -623,6 +621,17 @@ irq_domain_hierarchical_is_msi_remap(struct irq_domain *=
domain)
 {
 	return false;
 }
+
+static inline bool irq_domain_is_msi_parent(struct irq_domain *domain)
+{
+	return false;
+}
+
+static inline bool irq_domain_is_msi_device(struct irq_domain *domain)
+{
+	return false;
+}
+
 #endif	/* CONFIG_IRQ_DOMAIN_HIERARCHY */
=20
 #else /* CONFIG_IRQ_DOMAIN */
diff --git a/include/linux/irqdomain_defs.h b/include/linux/irqdomain_defs.h
new file mode 100644
index 000000000000..c29921fd8cd1
--- /dev/null
+++ b/include/linux/irqdomain_defs.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_IRQDOMAIN_DEFS_H
+#define _LINUX_IRQDOMAIN_DEFS_H
+
+/*
+ * Should several domains have the same device node, but serve
+ * different purposes (for example one domain is for PCI/MSI, and the
+ * other for wired IRQs), they can be distinguished using a
+ * bus-specific token. Most domains are expected to only carry
+ * DOMAIN_BUS_ANY.
+ */
+enum irq_domain_bus_token {
+	DOMAIN_BUS_ANY		=3D 0,
+	DOMAIN_BUS_WIRED,
+	DOMAIN_BUS_GENERIC_MSI,
+	DOMAIN_BUS_PCI_MSI,
+	DOMAIN_BUS_PLATFORM_MSI,
+	DOMAIN_BUS_NEXUS,
+	DOMAIN_BUS_IPI,
+	DOMAIN_BUS_FSL_MC_MSI,
+	DOMAIN_BUS_TI_SCI_INTA_MSI,
+	DOMAIN_BUS_WAKEUP,
+	DOMAIN_BUS_VMD_MSI,
+	DOMAIN_BUS_PCI_DEVICE_MSI,
+	DOMAIN_BUS_PCI_DEVICE_MSIX,
+	DOMAIN_BUS_DMAR,
+	DOMAIN_BUS_AMDVI,
+	DOMAIN_BUS_PCI_DEVICE_IMS,
+};
+
+#endif /* _LINUX_IRQDOMAIN_DEFS_H */
diff --git a/include/linux/irqreturn.h b/include/linux/irqreturn.h
index bd4c066ad39b..d426c7ad92bf 100644
--- a/include/linux/irqreturn.h
+++ b/include/linux/irqreturn.h
@@ -3,10 +3,10 @@
 #define _LINUX_IRQRETURN_H
=20
 /**
- * enum irqreturn
- * @IRQ_NONE		interrupt was not from this device or was not handled
- * @IRQ_HANDLED		interrupt was handled by this device
- * @IRQ_WAKE_THREAD	handler requests to wake the handler thread
+ * enum irqreturn - irqreturn type values
+ * @IRQ_NONE:		interrupt was not from this device or was not handled
+ * @IRQ_HANDLED:	interrupt was handled by this device
+ * @IRQ_WAKE_THREAD:	handler requests to wake the handler thread
  */
 enum irqreturn {
 	IRQ_NONE		=3D (0 << 0),
diff --git a/include/linux/msi.h b/include/linux/msi.h
index fc918a658d48..a112b913fff9 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -13,13 +13,20 @@
  *
  * Regular device drivers have no business with any of these functions and
  * especially storing MSI descriptor pointers in random code is considered
- * abuse. The only function which is relevant for drivers is msi_get_virq().
+ * abuse.
+ *
+ * Device driver relevant functions are available in <linux/msi_api.h>
  */
=20
+#include <linux/irqdomain_defs.h>
 #include <linux/cpumask.h>
+#include <linux/msi_api.h>
 #include <linux/xarray.h>
 #include <linux/mutex.h>
 #include <linux/list.h>
+#include <linux/irq.h>
+#include <linux/bits.h>
+
 #include <asm/msi.h>
=20
 /* Dummy shadow structures if an architecture does not define them */
@@ -68,19 +75,18 @@ struct msi_msg {
=20
 extern int pci_msi_ignore_mask;
 /* Helper functions */
-struct irq_data;
 struct msi_desc;
 struct pci_dev;
 struct platform_msi_priv_data;
 struct device_attribute;
+struct irq_domain;
+struct irq_affinity_desc;
=20
 void __get_cached_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
 #ifdef CONFIG_GENERIC_MSI_IRQ
 void get_cached_msi_msg(unsigned int irq, struct msi_msg *msg);
 #else
-static inline void get_cached_msi_msg(unsigned int irq, struct msi_msg *msg)
-{
-}
+static inline void get_cached_msi_msg(unsigned int irq, struct msi_msg *msg)=
 { }
 #endif
=20
 typedef void (*irq_write_msi_msg_t)(struct msi_desc *desc,
@@ -120,6 +126,38 @@ struct pci_msi_desc {
 	};
 };
=20
+/**
+ * union msi_domain_cookie - Opaque MSI domain specific data
+ * @value:	u64 value store
+ * @ptr:	Pointer to domain specific data
+ * @iobase:	Domain specific IOmem pointer
+ *
+ * The content of this data is implementation defined and used by the MSI
+ * domain to store domain specific information which is requried for
+ * interrupt chip callbacks.
+ */
+union msi_domain_cookie {
+	u64	value;
+	void	*ptr;
+	void	__iomem *iobase;
+};
+
+/**
+ * struct msi_desc_data - Generic MSI descriptor data
+ * @dcookie:	Cookie for MSI domain specific data which is required
+ *		for irq_chip callbacks
+ * @icookie:	Cookie for the MSI interrupt instance provided by
+ *		the usage site to the allocation function
+ *
+ * The content of this data is implementation defined, e.g. PCI/IMS
+ * implementations define the meaning of the data. The MSI core ignores
+ * this data completely.
+ */
+struct msi_desc_data {
+	union msi_domain_cookie		dcookie;
+	union msi_instance_cookie	icookie;
+};
+
 #define MSI_MAX_INDEX		((unsigned int)USHRT_MAX)
=20
 /**
@@ -137,6 +175,7 @@ struct pci_msi_desc {
  *
  * @msi_index:	Index of the msi descriptor
  * @pci:	PCI specific msi descriptor data
+ * @data:	Generic MSI descriptor data
  */
 struct msi_desc {
 	/* Shared device/bus type independent data */
@@ -156,7 +195,10 @@ struct msi_desc {
 	void *write_msi_msg_data;
=20
 	u16				msi_index;
-	struct pci_msi_desc		pci;
+	union {
+		struct pci_msi_desc	pci;
+		struct msi_desc_data	data;
+	};
 };
=20
 /*
@@ -171,33 +213,80 @@ enum msi_desc_filter {
 	MSI_DESC_ASSOCIATED,
 };
=20
+
+/**
+ * struct msi_dev_domain - The internals of MSI domain info per device
+ * @store:		Xarray for storing MSI descriptor pointers
+ * @irqdomain:		Pointer to a per device interrupt domain
+ */
+struct msi_dev_domain {
+	struct xarray		store;
+	struct irq_domain	*domain;
+};
+
 /**
  * msi_device_data - MSI per device data
  * @properties:		MSI properties which are interesting to drivers
  * @platform_data:	Platform-MSI specific data
  * @mutex:		Mutex protecting the MSI descriptor store
- * @__store:		Xarray for storing MSI descriptor pointers
+ * @__domains:		Internal data for per device MSI domains
  * @__iter_idx:		Index to search the next entry for iterators
  */
 struct msi_device_data {
 	unsigned long			properties;
 	struct platform_msi_priv_data	*platform_data;
 	struct mutex			mutex;
-	struct xarray			__store;
+	struct msi_dev_domain		__domains[MSI_MAX_DEVICE_IRQDOMAINS];
 	unsigned long			__iter_idx;
 };
=20
 int msi_setup_device_data(struct device *dev);
=20
-unsigned int msi_get_virq(struct device *dev, unsigned int index);
 void msi_lock_descs(struct device *dev);
 void msi_unlock_descs(struct device *dev);
=20
-struct msi_desc *msi_first_desc(struct device *dev, enum msi_desc_filter fil=
ter);
-struct msi_desc *msi_next_desc(struct device *dev, enum msi_desc_filter filt=
er);
+struct msi_desc *msi_domain_first_desc(struct device *dev, unsigned int domi=
d,
+				       enum msi_desc_filter filter);
=20
 /**
- * msi_for_each_desc - Iterate the MSI descriptors
+ * msi_first_desc - Get the first MSI descriptor of the default irqdomain
+ * @dev:	Device to operate on
+ * @filter:	Descriptor state filter
+ *
+ * Must be called with the MSI descriptor mutex held, i.e. msi_lock_descs()
+ * must be invoked before the call.
+ *
+ * Return: Pointer to the first MSI descriptor matching the search
+ *	   criteria, NULL if none found.
+ */
+static inline struct msi_desc *msi_first_desc(struct device *dev,
+					      enum msi_desc_filter filter)
+{
+	return msi_domain_first_desc(dev, MSI_DEFAULT_DOMAIN, filter);
+}
+
+struct msi_desc *msi_next_desc(struct device *dev, unsigned int domid,
+			       enum msi_desc_filter filter);
+
+/**
+ * msi_domain_for_each_desc - Iterate the MSI descriptors in a specific doma=
in
+ *
+ * @desc:	struct msi_desc pointer used as iterator
+ * @dev:	struct device pointer - device to iterate
+ * @domid:	The id of the interrupt domain which should be walked.
+ * @filter:	Filter for descriptor selection
+ *
+ * Notes:
+ *  - The loop must be protected with a msi_lock_descs()/msi_unlock_descs()
+ *    pair.
+ *  - It is safe to remove a retrieved MSI descriptor in the loop.
+ */
+#define msi_domain_for_each_desc(desc, dev, domid, filter)			\
+	for ((desc) =3D msi_domain_first_desc((dev), (domid), (filter)); (desc);	\
+	     (desc) =3D msi_next_desc((dev), (domid), (filter)))
+
+/**
+ * msi_for_each_desc - Iterate the MSI descriptors in the default irqdomain
  *
  * @desc:	struct msi_desc pointer used as iterator
  * @dev:	struct device pointer - device to iterate
@@ -208,9 +297,8 @@ struct msi_desc *msi_next_desc(struct device *dev, enum m=
si_desc_filter filter);
  *    pair.
  *  - It is safe to remove a retrieved MSI descriptor in the loop.
  */
-#define msi_for_each_desc(desc, dev, filter)			\
-	for ((desc) =3D msi_first_desc((dev), (filter)); (desc);	\
-	     (desc) =3D msi_next_desc((dev), (filter)))
+#define msi_for_each_desc(desc, dev, filter)					\
+	msi_domain_for_each_desc((desc), (dev), MSI_DEFAULT_DOMAIN, (filter))
=20
 #define msi_desc_to_dev(desc)		((desc)->dev)
=20
@@ -237,34 +325,47 @@ static inline void msi_desc_set_iommu_cookie(struct msi=
_desc *desc,
 }
 #endif
=20
-#ifdef CONFIG_PCI_MSI
-struct pci_dev *msi_desc_to_pci_dev(struct msi_desc *desc);
-void pci_write_msi_msg(unsigned int irq, struct msi_msg *msg);
-#else /* CONFIG_PCI_MSI */
-static inline void pci_write_msi_msg(unsigned int irq, struct msi_msg *msg)
+int msi_domain_insert_msi_desc(struct device *dev, unsigned int domid,
+			       struct msi_desc *init_desc);
+/**
+ * msi_insert_msi_desc - Allocate and initialize a MSI descriptor in the
+ *			 default irqdomain and insert it at @init_desc->msi_index
+ * @dev:	Pointer to the device for which the descriptor is allocated
+ * @init_desc:	Pointer to an MSI descriptor to initialize the new descriptor
+ *
+ * Return: 0 on success or an appropriate failure code.
+ */
+static inline int msi_insert_msi_desc(struct device *dev, struct msi_desc *i=
nit_desc)
 {
+	return msi_domain_insert_msi_desc(dev, MSI_DEFAULT_DOMAIN, init_desc);
 }
-#endif /* CONFIG_PCI_MSI */
=20
-int msi_add_msi_desc(struct device *dev, struct msi_desc *init_desc);
-void msi_free_msi_descs_range(struct device *dev, enum msi_desc_filter filte=
r,
-			      unsigned int first_index, unsigned int last_index);
+void msi_domain_free_msi_descs_range(struct device *dev, unsigned int domid,
+				     unsigned int first, unsigned int last);
+
+/**
+ * msi_free_msi_descs_range - Free a range of MSI descriptors of a device
+ *			      in the default irqdomain
+ *
+ * @dev:	Device for which to free the descriptors
+ * @first:	Index to start freeing from (inclusive)
+ * @last:	Last index to be freed (inclusive)
+ */
+static inline void msi_free_msi_descs_range(struct device *dev, unsigned int=
 first,
+					    unsigned int last)
+{
+	msi_domain_free_msi_descs_range(dev, MSI_DEFAULT_DOMAIN, first, last);
+}
=20
 /**
- * msi_free_msi_descs - Free MSI descriptors of a device
+ * msi_free_msi_descs - Free all MSI descriptors of a device in the default =
irqdomain
  * @dev:	Device to free the descriptors
  */
 static inline void msi_free_msi_descs(struct device *dev)
 {
-	msi_free_msi_descs_range(dev, MSI_DESC_ALL, 0, MSI_MAX_INDEX);
+	msi_free_msi_descs_range(dev, 0, MSI_MAX_INDEX);
 }
=20
-void __pci_read_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
-void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
-
-void pci_msi_mask_irq(struct irq_data *data);
-void pci_msi_unmask_irq(struct irq_data *data);
-
 /*
  * The arch hooks to setup up msi irqs. Default functions are implemented
  * as weak symbols so that they /can/ be overriden by architecture specific
@@ -293,7 +394,7 @@ static inline void msi_device_destroy_sysfs(struct device=
 *dev) { }
  */
 bool arch_restore_msi_irqs(struct pci_dev *dev);
=20
-#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
+#ifdef CONFIG_GENERIC_MSI_IRQ
=20
 #include <linux/irqhandler.h>
=20
@@ -309,19 +410,22 @@ struct msi_domain_info;
  * @get_hwirq:		Retrieve the resulting hw irq number
  * @msi_init:		Domain specific init function for MSI interrupts
  * @msi_free:		Domain specific function to free a MSI interrupts
- * @msi_check:		Callback for verification of the domain/info/dev data
  * @msi_prepare:	Prepare the allocation of the interrupts in the domain
+ * @prepare_desc:	Optional function to prepare the allocated MSI descriptor
+ *			in the domain
  * @set_desc:		Set the msi descriptor for an interrupt
  * @domain_alloc_irqs:	Optional function to override the default allocation
  *			function.
  * @domain_free_irqs:	Optional function to override the default free
  *			function.
+ * @msi_post_free:	Optional function which is invoked after freeing
+ *			all interrupts.
  *
  * @get_hwirq, @msi_init and @msi_free are callbacks used by the underlying
  * irqdomain.
  *
- * @msi_check, @msi_prepare and @set_desc are callbacks used by
- * msi_domain_alloc/free_irqs().
+ * @msi_check, @msi_prepare, @prepare_desc and @set_desc are callbacks used =
by the
+ * msi_domain_alloc/free_irqs*() variants.
  *
  * @domain_alloc_irqs, @domain_free_irqs can be used to override the
  * default allocation/free functions (__msi_domain_alloc/free_irqs). This
@@ -329,15 +433,6 @@ struct msi_domain_info;
  * be wrapped into the regular irq domains concepts by mere mortals.  This
  * allows to universally use msi_domain_alloc/free_irqs without having to
  * special case XEN all over the place.
- *
- * Contrary to other operations @domain_alloc_irqs and @domain_free_irqs
- * are set to the default implementation if NULL and even when
- * MSI_FLAG_USE_DEF_DOM_OPS is not set to avoid breaking existing users and
- * because these callbacks are obviously mandatory.
- *
- * This is NOT meant to be abused, but it can be useful to build wrappers
- * for specialized MSI irq domains which need extra work before and after
- * calling __msi_domain_alloc_irqs()/__msi_domain_free_irqs().
  */
 struct msi_domain_ops {
 	irq_hw_number_t	(*get_hwirq)(struct msi_domain_info *info,
@@ -349,23 +444,29 @@ struct msi_domain_ops {
 	void		(*msi_free)(struct irq_domain *domain,
 				    struct msi_domain_info *info,
 				    unsigned int virq);
-	int		(*msi_check)(struct irq_domain *domain,
-				     struct msi_domain_info *info,
-				     struct device *dev);
 	int		(*msi_prepare)(struct irq_domain *domain,
 				       struct device *dev, int nvec,
 				       msi_alloc_info_t *arg);
+	void		(*prepare_desc)(struct irq_domain *domain, msi_alloc_info_t *arg,
+					struct msi_desc *desc);
 	void		(*set_desc)(msi_alloc_info_t *arg,
 				    struct msi_desc *desc);
 	int		(*domain_alloc_irqs)(struct irq_domain *domain,
 					     struct device *dev, int nvec);
 	void		(*domain_free_irqs)(struct irq_domain *domain,
 					    struct device *dev);
+	void		(*msi_post_free)(struct irq_domain *domain,
+					 struct device *dev);
 };
=20
 /**
  * struct msi_domain_info - MSI interrupt domain data
  * @flags:		Flags to decribe features and capabilities
+ * @bus_token:		The domain bus token
+ * @hwsize:		The hardware table size or the software index limit.
+ *			If 0 then the size is considered unlimited and
+ *			gets initialized to the maximum software index limit
+ *			by the domain creation code.
  * @ops:		The callback data structure
  * @chip:		Optional: associated interrupt chip
  * @chip_data:		Optional: associated interrupt chip data
@@ -375,17 +476,42 @@ struct msi_domain_ops {
  * @data:		Optional: domain specific data
  */
 struct msi_domain_info {
-	u32			flags;
-	struct msi_domain_ops	*ops;
-	struct irq_chip		*chip;
-	void			*chip_data;
-	irq_flow_handler_t	handler;
-	void			*handler_data;
-	const char		*handler_name;
-	void			*data;
+	u32				flags;
+	enum irq_domain_bus_token	bus_token;
+	unsigned int			hwsize;
+	struct msi_domain_ops		*ops;
+	struct irq_chip			*chip;
+	void				*chip_data;
+	irq_flow_handler_t		handler;
+	void				*handler_data;
+	const char			*handler_name;
+	void				*data;
 };
=20
-/* Flags for msi_domain_info */
+/**
+ * struct msi_domain_template - Template for MSI device domains
+ * @name:	Storage for the resulting name. Filled in by the core.
+ * @chip:	Interrupt chip for this domain
+ * @ops:	MSI domain ops
+ * @info:	MSI domain info data
+ */
+struct msi_domain_template {
+	char			name[48];
+	struct irq_chip		chip;
+	struct msi_domain_ops	ops;
+	struct msi_domain_info	info;
+};
+
+/*
+ * Flags for msi_domain_info
+ *
+ * Bit 0-15:	Generic MSI functionality which is not subject to restriction
+ *		by parent domains
+ *
+ * Bit 16-31:	Functionality which depends on the underlying parent domain and
+ *		can be masked out by msi_parent_ops::init_dev_msi_info() when
+ *		a device MSI domain is initialized.
+ */
 enum {
 	/*
 	 * Init non implemented ops callbacks with default MSI domain
@@ -397,44 +523,100 @@ enum {
 	 * callbacks.
 	 */
 	MSI_FLAG_USE_DEF_CHIP_OPS	=3D (1 << 1),
-	/* Support multiple PCI MSI interrupts */
-	MSI_FLAG_MULTI_PCI_MSI		=3D (1 << 2),
-	/* Support PCI MSIX interrupts */
-	MSI_FLAG_PCI_MSIX		=3D (1 << 3),
 	/* Needs early activate, required for PCI */
-	MSI_FLAG_ACTIVATE_EARLY		=3D (1 << 4),
+	MSI_FLAG_ACTIVATE_EARLY		=3D (1 << 2),
 	/*
 	 * Must reactivate when irq is started even when
 	 * MSI_FLAG_ACTIVATE_EARLY has been set.
 	 */
-	MSI_FLAG_MUST_REACTIVATE	=3D (1 << 5),
-	/* Is level-triggered capable, using two messages */
-	MSI_FLAG_LEVEL_CAPABLE		=3D (1 << 6),
+	MSI_FLAG_MUST_REACTIVATE	=3D (1 << 3),
 	/* Populate sysfs on alloc() and destroy it on free() */
-	MSI_FLAG_DEV_SYSFS		=3D (1 << 7),
-	/* MSI-X entries must be contiguous */
-	MSI_FLAG_MSIX_CONTIGUOUS	=3D (1 << 8),
+	MSI_FLAG_DEV_SYSFS		=3D (1 << 4),
 	/* Allocate simple MSI descriptors */
-	MSI_FLAG_ALLOC_SIMPLE_MSI_DESCS	=3D (1 << 9),
+	MSI_FLAG_ALLOC_SIMPLE_MSI_DESCS	=3D (1 << 5),
 	/* Free MSI descriptors */
-	MSI_FLAG_FREE_MSI_DESCS		=3D (1 << 10),
+	MSI_FLAG_FREE_MSI_DESCS		=3D (1 << 6),
+	/*
+	 * Quirk to handle MSI implementations which do not provide
+	 * masking. Currently known to affect x86, but has to be partially
+	 * handled in the core MSI code.
+	 */
+	MSI_FLAG_NOMASK_QUIRK		=3D (1 << 7),
+
+	/* Mask for the generic functionality */
+	MSI_GENERIC_FLAGS_MASK		=3D GENMASK(15, 0),
+
+	/* Mask for the domain specific functionality */
+	MSI_DOMAIN_FLAGS_MASK		=3D GENMASK(31, 16),
+
+	/* Support multiple PCI MSI interrupts */
+	MSI_FLAG_MULTI_PCI_MSI		=3D (1 << 16),
+	/* Support PCI MSIX interrupts */
+	MSI_FLAG_PCI_MSIX		=3D (1 << 17),
+	/* Is level-triggered capable, using two messages */
+	MSI_FLAG_LEVEL_CAPABLE		=3D (1 << 18),
+	/* MSI-X entries must be contiguous */
+	MSI_FLAG_MSIX_CONTIGUOUS	=3D (1 << 19),
+	/* PCI/MSI-X vectors can be dynamically allocated/freed post MSI-X enable */
+	MSI_FLAG_PCI_MSIX_ALLOC_DYN	=3D (1 << 20),
+	/* Support for PCI/IMS */
+	MSI_FLAG_PCI_IMS		=3D (1 << 21),
 };
=20
+/**
+ * struct msi_parent_ops - MSI parent domain callbacks and configuration info
+ *
+ * @supported_flags:	Required: The supported MSI flags of the parent domain
+ * @prefix:		Optional: Prefix for the domain and chip name
+ * @init_dev_msi_info:	Required: Callback for MSI parent domains to setup pa=
rent
+ *			domain specific domain flags, domain ops and interrupt chip
+ *			callbacks when a per device domain is created.
+ */
+struct msi_parent_ops {
+	u32		supported_flags;
+	const char	*prefix;
+	bool		(*init_dev_msi_info)(struct device *dev, struct irq_domain *domain,
+					     struct irq_domain *msi_parent_domain,
+					     struct msi_domain_info *msi_child_info);
+};
+
+bool msi_parent_init_dev_msi_info(struct device *dev, struct irq_domain *dom=
ain,
+				  struct irq_domain *msi_parent_domain,
+				  struct msi_domain_info *msi_child_info);
+
 int msi_domain_set_affinity(struct irq_data *data, const struct cpumask *mas=
k,
 			    bool force);
=20
 struct irq_domain *msi_create_irq_domain(struct fwnode_handle *fwnode,
 					 struct msi_domain_info *info,
 					 struct irq_domain *parent);
-int __msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
-			    int nvec);
-int msi_domain_alloc_irqs_descs_locked(struct irq_domain *domain, struct dev=
ice *dev,
-				       int nvec);
-int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
-			  int nvec);
-void __msi_domain_free_irqs(struct irq_domain *domain, struct device *dev);
-void msi_domain_free_irqs_descs_locked(struct irq_domain *domain, struct dev=
ice *dev);
-void msi_domain_free_irqs(struct irq_domain *domain, struct device *dev);
+
+bool msi_create_device_irq_domain(struct device *dev, unsigned int domid,
+				  const struct msi_domain_template *template,
+				  unsigned int hwsize, void *domain_data,
+				  void *chip_data);
+void msi_remove_device_irq_domain(struct device *dev, unsigned int domid);
+
+bool msi_match_device_irq_domain(struct device *dev, unsigned int domid,
+				 enum irq_domain_bus_token bus_token);
+
+int msi_domain_alloc_irqs_range_locked(struct device *dev, unsigned int domi=
d,
+				       unsigned int first, unsigned int last);
+int msi_domain_alloc_irqs_range(struct device *dev, unsigned int domid,
+				unsigned int first, unsigned int last);
+int msi_domain_alloc_irqs_all_locked(struct device *dev, unsigned int domid,=
 int nirqs);
+
+struct msi_map msi_domain_alloc_irq_at(struct device *dev, unsigned int domi=
d, unsigned int index,
+				       const struct irq_affinity_desc *affdesc,
+				       union msi_instance_cookie *cookie);
+
+void msi_domain_free_irqs_range_locked(struct device *dev, unsigned int domi=
d,
+				       unsigned int first, unsigned int last);
+void msi_domain_free_irqs_range(struct device *dev, unsigned int domid,
+				unsigned int first, unsigned int last);
+void msi_domain_free_irqs_all_locked(struct device *dev, unsigned int domid);
+void msi_domain_free_irqs_all(struct device *dev, unsigned int domid);
+
 struct msi_domain_info *msi_get_domain_info(struct irq_domain *domain);
=20
 struct irq_domain *platform_msi_create_irq_domain(struct fwnode_handle *fwno=
de,
@@ -467,20 +649,27 @@ int platform_msi_device_domain_alloc(struct irq_domain =
*domain, unsigned int vir
 void platform_msi_device_domain_free(struct irq_domain *domain, unsigned int=
 virq,
 				     unsigned int nvec);
 void *platform_msi_get_host_data(struct irq_domain *domain);
-#endif /* CONFIG_GENERIC_MSI_IRQ_DOMAIN */
+#endif /* CONFIG_GENERIC_MSI_IRQ */
=20
-#ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
+/* PCI specific interfaces */
+#ifdef CONFIG_PCI_MSI
+struct pci_dev *msi_desc_to_pci_dev(struct msi_desc *desc);
+void pci_write_msi_msg(unsigned int irq, struct msi_msg *msg);
+void __pci_read_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
+void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
+void pci_msi_mask_irq(struct irq_data *data);
+void pci_msi_unmask_irq(struct irq_data *data);
 struct irq_domain *pci_msi_create_irq_domain(struct fwnode_handle *fwnode,
 					     struct msi_domain_info *info,
 					     struct irq_domain *parent);
 u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pd=
ev);
 struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev);
-bool pci_dev_has_special_msi_domain(struct pci_dev *pdev);
-#else
+#else /* CONFIG_PCI_MSI */
 static inline struct irq_domain *pci_msi_get_device_domain(struct pci_dev *p=
dev)
 {
 	return NULL;
 }
-#endif /* CONFIG_PCI_MSI_IRQ_DOMAIN */
+static inline void pci_write_msi_msg(unsigned int irq, struct msi_msg *msg) =
{ }
+#endif /* !CONFIG_PCI_MSI */
=20
 #endif /* LINUX_MSI_H */
diff --git a/include/linux/msi_api.h b/include/linux/msi_api.h
new file mode 100644
index 000000000000..391087ad99b1
--- /dev/null
+++ b/include/linux/msi_api.h
@@ -0,0 +1,73 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef LINUX_MSI_API_H
+#define LINUX_MSI_API_H
+
+/*
+ * APIs which are relevant for device driver code for allocating and
+ * freeing MSI interrupts and querying the associations between
+ * hardware/software MSI indices and the Linux interrupt number.
+ */
+
+struct device;
+
+/*
+ * Per device interrupt domain related constants.
+ */
+enum msi_domain_ids {
+	MSI_DEFAULT_DOMAIN,
+	MSI_SECONDARY_DOMAIN,
+	MSI_MAX_DEVICE_IRQDOMAINS,
+};
+
+/**
+ * union msi_instance_cookie - MSI instance cookie
+ * @value:	u64 value store
+ * @ptr:	Pointer to usage site specific data
+ *
+ * This cookie is handed to the IMS allocation function and stored in the
+ * MSI descriptor for the interrupt chip callbacks.
+ *
+ * The content of this cookie is MSI domain implementation defined.  For
+ * PCI/IMS implementations this could be a PASID or a pointer to queue
+ * memory.
+ */
+union msi_instance_cookie {
+	u64	value;
+	void	*ptr;
+};
+
+/**
+ * msi_map - Mapping between MSI index and Linux interrupt number
+ * @index:	The MSI index, e.g. slot in the MSI-X table or
+ *		a software managed index if >=3D 0. If negative
+ *		the allocation function failed and it contains
+ *		the error code.
+ * @virq:	The associated Linux interrupt number
+ */
+struct msi_map {
+	int	index;
+	int	virq;
+};
+
+/*
+ * Constant to be used for dynamic allocations when the allocation is any
+ * free MSI index, which is either an entry in a hardware table or a
+ * software managed index.
+ */
+#define MSI_ANY_INDEX		UINT_MAX
+
+unsigned int msi_domain_get_virq(struct device *dev, unsigned int domid, uns=
igned int index);
+
+/**
+ * msi_get_virq - Lookup the Linux interrupt number for a MSI index on the d=
efault interrupt domain
+ * @dev:	Device for which the lookup happens
+ * @index:	The MSI index to lookup
+ *
+ * Return: The Linux interrupt number on success (> 0), 0 if not found
+ */
+static inline unsigned int msi_get_virq(struct device *dev, unsigned int ind=
ex)
+{
+	return msi_domain_get_virq(dev, MSI_DEFAULT_DOMAIN, index);
+}
+
+#endif
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 2bda4a4e47e8..aa514b54c681 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -38,6 +38,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/resource_ext.h>
+#include <linux/msi_api.h>
 #include <uapi/linux/pci.h>
=20
 #include <linux/pci_ids.h>
@@ -1553,10 +1554,17 @@ static inline int pci_enable_msix_exact(struct pci_de=
v *dev,
 		return rc;
 	return 0;
 }
+int pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
+			  unsigned int max_vecs, unsigned int flags);
 int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vec=
s,
 				   unsigned int max_vecs, unsigned int flags,
 				   struct irq_affinity *affd);
=20
+bool pci_msix_can_alloc_dyn(struct pci_dev *dev);
+struct msi_map pci_msix_alloc_irq_at(struct pci_dev *dev, unsigned int index,
+				     const struct irq_affinity_desc *affdesc);
+void pci_msix_free_irq(struct pci_dev *pdev, struct msi_map map);
+
 void pci_free_irq_vectors(struct pci_dev *dev);
 int pci_irq_vector(struct pci_dev *dev, unsigned int nr);
 const struct cpumask *pci_irq_get_affinity(struct pci_dev *pdev, int vec);
@@ -1586,6 +1594,13 @@ pci_alloc_irq_vectors_affinity(struct pci_dev *dev, un=
signed int min_vecs,
 		return 1;
 	return -ENOSPC;
 }
+static inline int
+pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
+		      unsigned int max_vecs, unsigned int flags)
+{
+	return pci_alloc_irq_vectors_affinity(dev, min_vecs, max_vecs,
+					      flags, NULL);
+}
=20
 static inline void pci_free_irq_vectors(struct pci_dev *dev)
 {
@@ -1898,15 +1913,13 @@ pci_alloc_irq_vectors_affinity(struct pci_dev *dev, u=
nsigned int min_vecs,
 {
 	return -ENOSPC;
 }
-#endif /* CONFIG_PCI */
-
 static inline int
 pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
 		      unsigned int max_vecs, unsigned int flags)
 {
-	return pci_alloc_irq_vectors_affinity(dev, min_vecs, max_vecs, flags,
-					      NULL);
+	return -ENOSPC;
 }
+#endif /* CONFIG_PCI */
=20
 /* Include architecture-dependent settings and functions */
=20
@@ -2474,6 +2487,14 @@ static inline bool pci_is_thunderbolt_attached(struct =
pci_dev *pdev)
 void pci_uevent_ers(struct pci_dev *pdev, enum  pci_ers_result err_type);
 #endif
=20
+struct msi_domain_template;
+
+bool pci_create_ims_domain(struct pci_dev *pdev, const struct msi_domain_tem=
plate *template,
+			   unsigned int hwsize, void *data);
+struct msi_map pci_ims_alloc_irq(struct pci_dev *pdev, union msi_instance_co=
okie *icookie,
+				 const struct irq_affinity_desc *affdesc);
+void pci_ims_free_irq(struct pci_dev *pdev, struct msi_map map);
+
 #include <linux/dma-mapping.h>
=20
 #define pci_printk(level, pdev, fmt, arg...) \
diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index db3d174c53d4..b64c44ae4c25 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -86,15 +86,10 @@ config GENERIC_IRQ_IPI
 	depends on SMP
 	select IRQ_DOMAIN_HIERARCHY
=20
-# Generic MSI interrupt support
-config GENERIC_MSI_IRQ
-	bool
-
 # Generic MSI hierarchical interrupt domain support
-config GENERIC_MSI_IRQ_DOMAIN
+config GENERIC_MSI_IRQ
 	bool
 	select IRQ_DOMAIN_HIERARCHY
-	select GENERIC_MSI_IRQ
=20
 config IRQ_MSI_IOMMU
 	bool
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 8ac37e8e738a..49e7bc871fec 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -1561,10 +1561,10 @@ int irq_chip_compose_msi_msg(struct irq_data *data, s=
truct msi_msg *msg)
 	return 0;
 }
=20
-static struct device *irq_get_parent_device(struct irq_data *data)
+static struct device *irq_get_pm_device(struct irq_data *data)
 {
 	if (data->domain)
-		return data->domain->dev;
+		return data->domain->pm_dev;
=20
 	return NULL;
 }
@@ -1578,7 +1578,7 @@ static struct device *irq_get_parent_device(struct irq_=
data *data)
  */
 int irq_chip_pm_get(struct irq_data *data)
 {
-	struct device *dev =3D irq_get_parent_device(data);
+	struct device *dev =3D irq_get_pm_device(data);
 	int retval =3D 0;
=20
 	if (IS_ENABLED(CONFIG_PM) && dev)
@@ -1597,7 +1597,7 @@ int irq_chip_pm_get(struct irq_data *data)
  */
 int irq_chip_pm_put(struct irq_data *data)
 {
-	struct device *dev =3D irq_get_parent_device(data);
+	struct device *dev =3D irq_get_pm_device(data);
 	int retval =3D 0;
=20
 	if (IS_ENABLED(CONFIG_PM) && dev)
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index f09c60393e55..5fdc0b557579 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -52,6 +52,7 @@ enum {
  * IRQS_PENDING			- irq is pending and replayed later
  * IRQS_SUSPENDED		- irq is suspended
  * IRQS_NMI			- irq line is used to deliver NMIs
+ * IRQS_SYSFS			- descriptor has been added to sysfs
  */
 enum {
 	IRQS_AUTODETECT		=3D 0x00000001,
@@ -64,6 +65,7 @@ enum {
 	IRQS_SUSPENDED		=3D 0x00000800,
 	IRQS_TIMINGS		=3D 0x00001000,
 	IRQS_NMI		=3D 0x00002000,
+	IRQS_SYSFS		=3D 0x00004000,
 };
=20
 #include "debug.h"
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index a91f9001103c..fd0996274401 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -288,22 +288,25 @@ static void irq_sysfs_add(int irq, struct irq_desc *des=
c)
 	if (irq_kobj_base) {
 		/*
 		 * Continue even in case of failure as this is nothing
-		 * crucial.
+		 * crucial and failures in the late irq_sysfs_init()
+		 * cannot be rolled back.
 		 */
 		if (kobject_add(&desc->kobj, irq_kobj_base, "%d", irq))
 			pr_warn("Failed to add kobject for irq %d\n", irq);
+		else
+			desc->istate |=3D IRQS_SYSFS;
 	}
 }
=20
 static void irq_sysfs_del(struct irq_desc *desc)
 {
 	/*
-	 * If irq_sysfs_init() has not yet been invoked (early boot), then
-	 * irq_kobj_base is NULL and the descriptor was never added.
-	 * kobject_del() complains about a object with no parent, so make
-	 * it conditional.
+	 * Only invoke kobject_del() when kobject_add() was successfully
+	 * invoked for the descriptor. This covers both early boot, where
+	 * sysfs is not initialized yet, and the case of a failed
+	 * kobject_add() invocation.
 	 */
-	if (irq_kobj_base)
+	if (desc->istate & IRQS_SYSFS)
 		kobject_del(&desc->kobj);
 }
=20
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 40fe7806cc8c..5b7cf28df290 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -321,7 +321,7 @@ static int irq_try_set_affinity(struct irq_data *data,
 }
=20
 static bool irq_set_affinity_deactivated(struct irq_data *data,
-					 const struct cpumask *mask, bool force)
+					 const struct cpumask *mask)
 {
 	struct irq_desc *desc =3D irq_data_to_desc(data);
=20
@@ -354,7 +354,7 @@ int irq_set_affinity_locked(struct irq_data *data, const =
struct cpumask *mask,
 	if (!chip || !chip->irq_set_affinity)
 		return -EINVAL;
=20
-	if (irq_set_affinity_deactivated(data, mask, force))
+	if (irq_set_affinity_deactivated(data, mask))
 		return 0;
=20
 	if (irq_can_move_pcntxt(data) && !irqd_is_setaffinity_pending(data)) {
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index a9ee535293eb..bd4d4dd626b4 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -19,8 +19,31 @@
=20
 #include "internals.h"
=20
+/**
+ * struct msi_ctrl - MSI internal management control structure
+ * @domid:	ID of the domain on which management operations should be done
+ * @first:	First (hardware) slot index to operate on
+ * @last:	Last (hardware) slot index to operate on
+ * @nirqs:	The number of Linux interrupts to allocate. Can be larger
+ *		than the range due to PCI/multi-MSI.
+ */
+struct msi_ctrl {
+	unsigned int			domid;
+	unsigned int			first;
+	unsigned int			last;
+	unsigned int			nirqs;
+};
+
+/* Invalid Xarray index which is outside of any searchable range */
+#define MSI_XA_MAX_INDEX	(ULONG_MAX - 1)
+/* The maximum domain size */
+#define MSI_XA_DOMAIN_SIZE	(MSI_MAX_INDEX + 1)
+
+static void msi_domain_free_locked(struct device *dev, struct msi_ctrl *ctrl=
);
+static unsigned int msi_domain_get_hwsize(struct device *dev, unsigned int d=
omid);
 static inline int msi_sysfs_create_group(struct device *dev);
=20
+
 /**
  * msi_alloc_desc - Allocate an initialized msi_desc
  * @dev:	Pointer to the device for which this is allocated
@@ -33,7 +56,7 @@ static inline int msi_sysfs_create_group(struct device *dev=
);
  * Return: pointer to allocated &msi_desc on success or %NULL on failure
  */
 static struct msi_desc *msi_alloc_desc(struct device *dev, int nvec,
-					const struct irq_affinity_desc *affinity)
+				       const struct irq_affinity_desc *affinity)
 {
 	struct msi_desc *desc =3D kzalloc(sizeof(*desc), GFP_KERNEL);
=20
@@ -58,25 +81,56 @@ static void msi_free_desc(struct msi_desc *desc)
 	kfree(desc);
 }
=20
-static int msi_insert_desc(struct msi_device_data *md, struct msi_desc *desc=
, unsigned int index)
+static int msi_insert_desc(struct device *dev, struct msi_desc *desc,
+			   unsigned int domid, unsigned int index)
 {
+	struct msi_device_data *md =3D dev->msi.data;
+	struct xarray *xa =3D &md->__domains[domid].store;
+	unsigned int hwsize;
 	int ret;
=20
-	desc->msi_index =3D index;
-	ret =3D xa_insert(&md->__store, index, desc, GFP_KERNEL);
-	if (ret)
-		msi_free_desc(desc);
+	hwsize =3D msi_domain_get_hwsize(dev, domid);
+
+	if (index =3D=3D MSI_ANY_INDEX) {
+		struct xa_limit limit =3D { .min =3D 0, .max =3D hwsize - 1 };
+		unsigned int index;
+
+		/* Let the xarray allocate a free index within the limit */
+		ret =3D xa_alloc(xa, &index, desc, limit, GFP_KERNEL);
+		if (ret)
+			goto fail;
+
+		desc->msi_index =3D index;
+		return 0;
+	} else {
+		if (index >=3D hwsize) {
+			ret =3D -ERANGE;
+			goto fail;
+		}
+
+		desc->msi_index =3D index;
+		ret =3D xa_insert(xa, index, desc, GFP_KERNEL);
+		if (ret)
+			goto fail;
+		return 0;
+	}
+fail:
+	msi_free_desc(desc);
 	return ret;
 }
=20
 /**
- * msi_add_msi_desc - Allocate and initialize a MSI descriptor
+ * msi_domain_insert_msi_desc - Allocate and initialize a MSI descriptor and
+ *				insert it at @init_desc->msi_index
+ *
  * @dev:	Pointer to the device for which the descriptor is allocated
+ * @domid:	The id of the interrupt domain to which the desriptor is added
  * @init_desc:	Pointer to an MSI descriptor to initialize the new descriptor
  *
  * Return: 0 on success or an appropriate failure code.
  */
-int msi_add_msi_desc(struct device *dev, struct msi_desc *init_desc)
+int msi_domain_insert_msi_desc(struct device *dev, unsigned int domid,
+			       struct msi_desc *init_desc)
 {
 	struct msi_desc *desc;
=20
@@ -88,40 +142,8 @@ int msi_add_msi_desc(struct device *dev, struct msi_desc =
*init_desc)
=20
 	/* Copy type specific data to the new descriptor. */
 	desc->pci =3D init_desc->pci;
-	return msi_insert_desc(dev->msi.data, desc, init_desc->msi_index);
-}
=20
-/**
- * msi_add_simple_msi_descs - Allocate and initialize MSI descriptors
- * @dev:	Pointer to the device for which the descriptors are allocated
- * @index:	Index for the first MSI descriptor
- * @ndesc:	Number of descriptors to allocate
- *
- * Return: 0 on success or an appropriate failure code.
- */
-static int msi_add_simple_msi_descs(struct device *dev, unsigned int index, =
unsigned int ndesc)
-{
-	unsigned int idx, last =3D index + ndesc - 1;
-	struct msi_desc *desc;
-	int ret;
-
-	lockdep_assert_held(&dev->msi.data->mutex);
-
-	for (idx =3D index; idx <=3D last; idx++) {
-		desc =3D msi_alloc_desc(dev, 1, NULL);
-		if (!desc)
-			goto fail_mem;
-		ret =3D msi_insert_desc(dev->msi.data, desc, idx);
-		if (ret)
-			goto fail;
-	}
-	return 0;
-
-fail_mem:
-	ret =3D -ENOMEM;
-fail:
-	msi_free_msi_descs_range(dev, MSI_DESC_NOTASSOCIATED, index, last);
-	return ret;
+	return msi_insert_desc(dev, desc, domid, init_desc->msi_index);
 }
=20
 static bool msi_desc_match(struct msi_desc *desc, enum msi_desc_filter filte=
r)
@@ -138,28 +160,96 @@ static bool msi_desc_match(struct msi_desc *desc, enum =
msi_desc_filter filter)
 	return false;
 }
=20
+static bool msi_ctrl_valid(struct device *dev, struct msi_ctrl *ctrl)
+{
+	unsigned int hwsize;
+
+	if (WARN_ON_ONCE(ctrl->domid >=3D MSI_MAX_DEVICE_IRQDOMAINS ||
+			 !dev->msi.data->__domains[ctrl->domid].domain))
+		return false;
+
+	hwsize =3D msi_domain_get_hwsize(dev, ctrl->domid);
+	if (WARN_ON_ONCE(ctrl->first > ctrl->last ||
+			 ctrl->first >=3D hwsize ||
+			 ctrl->last >=3D hwsize))
+		return false;
+	return true;
+}
+
+static void msi_domain_free_descs(struct device *dev, struct msi_ctrl *ctrl)
+{
+	struct msi_desc *desc;
+	struct xarray *xa;
+	unsigned long idx;
+
+	lockdep_assert_held(&dev->msi.data->mutex);
+
+	if (!msi_ctrl_valid(dev, ctrl))
+		return;
+
+	xa =3D &dev->msi.data->__domains[ctrl->domid].store;
+	xa_for_each_range(xa, idx, desc, ctrl->first, ctrl->last) {
+		xa_erase(xa, idx);
+
+		/* Leak the descriptor when it is still referenced */
+		if (WARN_ON_ONCE(msi_desc_match(desc, MSI_DESC_ASSOCIATED)))
+			continue;
+		msi_free_desc(desc);
+	}
+}
+
 /**
- * msi_free_msi_descs_range - Free MSI descriptors of a device
- * @dev:		Device to free the descriptors
- * @filter:		Descriptor state filter
- * @first_index:	Index to start freeing from
- * @last_index:		Last index to be freed
+ * msi_domain_free_msi_descs_range - Free a range of MSI descriptors of a de=
vice in an irqdomain
+ * @dev:	Device for which to free the descriptors
+ * @domid:	Id of the domain to operate on
+ * @first:	Index to start freeing from (inclusive)
+ * @last:	Last index to be freed (inclusive)
  */
-void msi_free_msi_descs_range(struct device *dev, enum msi_desc_filter filte=
r,
-			      unsigned int first_index, unsigned int last_index)
+void msi_domain_free_msi_descs_range(struct device *dev, unsigned int domid,
+				     unsigned int first, unsigned int last)
+{
+	struct msi_ctrl ctrl =3D {
+		.domid	=3D domid,
+		.first	=3D first,
+		.last	=3D last,
+	};
+
+	msi_domain_free_descs(dev, &ctrl);
+}
+
+/**
+ * msi_domain_add_simple_msi_descs - Allocate and initialize MSI descriptors
+ * @dev:	Pointer to the device for which the descriptors are allocated
+ * @ctrl:	Allocation control struct
+ *
+ * Return: 0 on success or an appropriate failure code.
+ */
+static int msi_domain_add_simple_msi_descs(struct device *dev, struct msi_ct=
rl *ctrl)
 {
-	struct xarray *xa =3D &dev->msi.data->__store;
 	struct msi_desc *desc;
-	unsigned long idx;
+	unsigned int idx;
+	int ret;
=20
 	lockdep_assert_held(&dev->msi.data->mutex);
=20
-	xa_for_each_range(xa, idx, desc, first_index, last_index) {
-		if (msi_desc_match(desc, filter)) {
-			xa_erase(xa, idx);
-			msi_free_desc(desc);
-		}
+	if (!msi_ctrl_valid(dev, ctrl))
+		return -EINVAL;
+
+	for (idx =3D ctrl->first; idx <=3D ctrl->last; idx++) {
+		desc =3D msi_alloc_desc(dev, 1, NULL);
+		if (!desc)
+			goto fail_mem;
+		ret =3D msi_insert_desc(dev, desc, ctrl->domid, idx);
+		if (ret)
+			goto fail;
 	}
+	return 0;
+
+fail_mem:
+	ret =3D -ENOMEM;
+fail:
+	msi_domain_free_descs(dev, ctrl);
+	return ret;
 }
=20
 void __get_cached_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
@@ -178,9 +268,13 @@ EXPORT_SYMBOL_GPL(get_cached_msi_msg);
 static void msi_device_data_release(struct device *dev, void *res)
 {
 	struct msi_device_data *md =3D res;
+	int i;
=20
-	WARN_ON_ONCE(!xa_empty(&md->__store));
-	xa_destroy(&md->__store);
+	for (i =3D 0; i < MSI_MAX_DEVICE_IRQDOMAINS; i++) {
+		msi_remove_device_irq_domain(dev, i);
+		WARN_ON_ONCE(!xa_empty(&md->__domains[i].store));
+		xa_destroy(&md->__domains[i].store);
+	}
 	dev->msi.data =3D NULL;
 }
=20
@@ -197,7 +291,7 @@ static void msi_device_data_release(struct device *dev, v=
oid *res)
 int msi_setup_device_data(struct device *dev)
 {
 	struct msi_device_data *md;
-	int ret;
+	int ret, i;
=20
 	if (dev->msi.data)
 		return 0;
@@ -212,7 +306,18 @@ int msi_setup_device_data(struct device *dev)
 		return ret;
 	}
=20
-	xa_init(&md->__store);
+	for (i =3D 0; i < MSI_MAX_DEVICE_IRQDOMAINS; i++)
+		xa_init_flags(&md->__domains[i].store, XA_FLAGS_ALLOC);
+
+	/*
+	 * If @dev::msi::domain is set and is a global MSI domain, copy the
+	 * pointer into the domain array so all code can operate on domain
+	 * ids. The NULL pointer check is required to keep the legacy
+	 * architecture specific PCI/MSI support working.
+	 */
+	if (dev->msi.domain && !irq_domain_is_msi_parent(dev->msi.domain))
+		md->__domains[MSI_DEFAULT_DOMAIN].domain =3D dev->msi.domain;
+
 	mutex_init(&md->mutex);
 	dev->msi.data =3D md;
 	devres_add(dev, md);
@@ -235,27 +340,30 @@ EXPORT_SYMBOL_GPL(msi_lock_descs);
  */
 void msi_unlock_descs(struct device *dev)
 {
-	/* Invalidate the index wich was cached by the iterator */
-	dev->msi.data->__iter_idx =3D MSI_MAX_INDEX;
+	/* Invalidate the index which was cached by the iterator */
+	dev->msi.data->__iter_idx =3D MSI_XA_MAX_INDEX;
 	mutex_unlock(&dev->msi.data->mutex);
 }
 EXPORT_SYMBOL_GPL(msi_unlock_descs);
=20
-static struct msi_desc *msi_find_desc(struct msi_device_data *md, enum msi_d=
esc_filter filter)
+static struct msi_desc *msi_find_desc(struct msi_device_data *md, unsigned i=
nt domid,
+				      enum msi_desc_filter filter)
 {
+	struct xarray *xa =3D &md->__domains[domid].store;
 	struct msi_desc *desc;
=20
-	xa_for_each_start(&md->__store, md->__iter_idx, desc, md->__iter_idx) {
+	xa_for_each_start(xa, md->__iter_idx, desc, md->__iter_idx) {
 		if (msi_desc_match(desc, filter))
 			return desc;
 	}
-	md->__iter_idx =3D MSI_MAX_INDEX;
+	md->__iter_idx =3D MSI_XA_MAX_INDEX;
 	return NULL;
 }
=20
 /**
- * msi_first_desc - Get the first MSI descriptor of a device
+ * msi_domain_first_desc - Get the first MSI descriptor of an irqdomain asso=
ciated to a device
  * @dev:	Device to operate on
+ * @domid:	The id of the interrupt domain which should be walked.
  * @filter:	Descriptor state filter
  *
  * Must be called with the MSI descriptor mutex held, i.e. msi_lock_descs()
@@ -264,23 +372,26 @@ static struct msi_desc *msi_find_desc(struct msi_device=
_data *md, enum msi_desc_
  * Return: Pointer to the first MSI descriptor matching the search
  *	   criteria, NULL if none found.
  */
-struct msi_desc *msi_first_desc(struct device *dev, enum msi_desc_filter fil=
ter)
+struct msi_desc *msi_domain_first_desc(struct device *dev, unsigned int domi=
d,
+				       enum msi_desc_filter filter)
 {
 	struct msi_device_data *md =3D dev->msi.data;
=20
-	if (WARN_ON_ONCE(!md))
+	if (WARN_ON_ONCE(!md || domid >=3D MSI_MAX_DEVICE_IRQDOMAINS))
 		return NULL;
=20
 	lockdep_assert_held(&md->mutex);
=20
 	md->__iter_idx =3D 0;
-	return msi_find_desc(md, filter);
+	return msi_find_desc(md, domid, filter);
 }
-EXPORT_SYMBOL_GPL(msi_first_desc);
+EXPORT_SYMBOL_GPL(msi_domain_first_desc);
=20
 /**
  * msi_next_desc - Get the next MSI descriptor of a device
  * @dev:	Device to operate on
+ * @domid:	The id of the interrupt domain which should be walked.
+ * @filter:	Descriptor state filter
  *
  * The first invocation of msi_next_desc() has to be preceeded by a
  * successful invocation of __msi_first_desc(). Consecutive invocations are
@@ -290,11 +401,12 @@ EXPORT_SYMBOL_GPL(msi_first_desc);
  * Return: Pointer to the next MSI descriptor matching the search
  *	   criteria, NULL if none found.
  */
-struct msi_desc *msi_next_desc(struct device *dev, enum msi_desc_filter filt=
er)
+struct msi_desc *msi_next_desc(struct device *dev, unsigned int domid,
+			       enum msi_desc_filter filter)
 {
 	struct msi_device_data *md =3D dev->msi.data;
=20
-	if (WARN_ON_ONCE(!md))
+	if (WARN_ON_ONCE(!md || domid >=3D MSI_MAX_DEVICE_IRQDOMAINS))
 		return NULL;
=20
 	lockdep_assert_held(&md->mutex);
@@ -303,30 +415,38 @@ struct msi_desc *msi_next_desc(struct device *dev, enum=
 msi_desc_filter filter)
 		return NULL;
=20
 	md->__iter_idx++;
-	return msi_find_desc(md, filter);
+	return msi_find_desc(md, domid, filter);
 }
 EXPORT_SYMBOL_GPL(msi_next_desc);
=20
 /**
- * msi_get_virq - Return Linux interrupt number of a MSI interrupt
+ * msi_domain_get_virq - Lookup the Linux interrupt number for a MSI index o=
n a interrupt domain
  * @dev:	Device to operate on
+ * @domid:	Domain ID of the interrupt domain associated to the device
  * @index:	MSI interrupt index to look for (0-based)
  *
  * Return: The Linux interrupt number on success (> 0), 0 if not found
  */
-unsigned int msi_get_virq(struct device *dev, unsigned int index)
+unsigned int msi_domain_get_virq(struct device *dev, unsigned int domid, uns=
igned int index)
 {
 	struct msi_desc *desc;
 	unsigned int ret =3D 0;
-	bool pcimsi;
+	bool pcimsi =3D false;
+	struct xarray *xa;
=20
 	if (!dev->msi.data)
 		return 0;
=20
-	pcimsi =3D dev_is_pci(dev) ? to_pci_dev(dev)->msi_enabled : false;
+	if (WARN_ON_ONCE(index > MSI_MAX_INDEX || domid >=3D MSI_MAX_DEVICE_IRQDOMA=
INS))
+		return 0;
+
+	/* This check is only valid for the PCI default MSI domain */
+	if (dev_is_pci(dev) && domid =3D=3D MSI_DEFAULT_DOMAIN)
+		pcimsi =3D to_pci_dev(dev)->msi_enabled;
=20
 	msi_lock_descs(dev);
-	desc =3D xa_load(&dev->msi.data->__store, pcimsi ? 0 : index);
+	xa =3D &dev->msi.data->__domains[domid].store;
+	desc =3D xa_load(xa, pcimsi ? 0 : index);
 	if (desc && desc->irq) {
 		/*
 		 * PCI-MSI has only one descriptor for multiple interrupts.
@@ -340,10 +460,11 @@ unsigned int msi_get_virq(struct device *dev, unsigned =
int index)
 			ret =3D desc->irq;
 		}
 	}
+
 	msi_unlock_descs(dev);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(msi_get_virq);
+EXPORT_SYMBOL_GPL(msi_domain_get_virq);
=20
 #ifdef CONFIG_SYSFS
 static struct attribute *msi_dev_attrs[] =3D {
@@ -459,7 +580,39 @@ static inline int msi_sysfs_populate_desc(struct device =
*dev, struct msi_desc *d
 static inline void msi_sysfs_remove_desc(struct device *dev, struct msi_desc=
 *desc) { }
 #endif /* !CONFIG_SYSFS */
=20
-#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
+static struct irq_domain *msi_get_device_domain(struct device *dev, unsigned=
 int domid)
+{
+	struct irq_domain *domain;
+
+	lockdep_assert_held(&dev->msi.data->mutex);
+
+	if (WARN_ON_ONCE(domid >=3D MSI_MAX_DEVICE_IRQDOMAINS))
+		return NULL;
+
+	domain =3D dev->msi.data->__domains[domid].domain;
+	if (!domain)
+		return NULL;
+
+	if (WARN_ON_ONCE(irq_domain_is_msi_parent(domain)))
+		return NULL;
+
+	return domain;
+}
+
+static unsigned int msi_domain_get_hwsize(struct device *dev, unsigned int d=
omid)
+{
+	struct msi_domain_info *info;
+	struct irq_domain *domain;
+
+	domain =3D msi_get_device_domain(dev, domid);
+	if (domain) {
+		info =3D domain->host_data;
+		return info->hwsize;
+	}
+	/* No domain, no size... */
+	return 0;
+}
+
 static inline void irq_chip_write_msi_msg(struct irq_data *data,
 					  struct msi_msg *msg)
 {
@@ -613,21 +766,11 @@ static int msi_domain_ops_init(struct irq_domain *domai=
n,
 	return 0;
 }
=20
-static int msi_domain_ops_check(struct irq_domain *domain,
-				struct msi_domain_info *info,
-				struct device *dev)
-{
-	return 0;
-}
-
 static struct msi_domain_ops msi_domain_ops_default =3D {
 	.get_hwirq		=3D msi_domain_ops_get_hwirq,
 	.msi_init		=3D msi_domain_ops_init,
-	.msi_check		=3D msi_domain_ops_check,
 	.msi_prepare		=3D msi_domain_ops_prepare,
 	.set_desc		=3D msi_domain_ops_set_desc,
-	.domain_alloc_irqs	=3D __msi_domain_alloc_irqs,
-	.domain_free_irqs	=3D __msi_domain_free_irqs,
 };
=20
 static void msi_domain_update_dom_ops(struct msi_domain_info *info)
@@ -639,11 +782,6 @@ static void msi_domain_update_dom_ops(struct msi_domain_=
info *info)
 		return;
 	}
=20
-	if (ops->domain_alloc_irqs =3D=3D NULL)
-		ops->domain_alloc_irqs =3D msi_domain_ops_default.domain_alloc_irqs;
-	if (ops->domain_free_irqs =3D=3D NULL)
-		ops->domain_free_irqs =3D msi_domain_ops_default.domain_free_irqs;
-
 	if (!(info->flags & MSI_FLAG_USE_DEF_DOM_OPS))
 		return;
=20
@@ -651,8 +789,6 @@ static void msi_domain_update_dom_ops(struct msi_domain_i=
nfo *info)
 		ops->get_hwirq =3D msi_domain_ops_default.get_hwirq;
 	if (ops->msi_init =3D=3D NULL)
 		ops->msi_init =3D msi_domain_ops_default.msi_init;
-	if (ops->msi_check =3D=3D NULL)
-		ops->msi_check =3D msi_domain_ops_default.msi_check;
 	if (ops->msi_prepare =3D=3D NULL)
 		ops->msi_prepare =3D msi_domain_ops_default.msi_prepare;
 	if (ops->set_desc =3D=3D NULL)
@@ -668,6 +804,40 @@ static void msi_domain_update_chip_ops(struct msi_domain=
_info *info)
 		chip->irq_set_affinity =3D msi_domain_set_affinity;
 }
=20
+static struct irq_domain *__msi_create_irq_domain(struct fwnode_handle *fwno=
de,
+						  struct msi_domain_info *info,
+						  unsigned int flags,
+						  struct irq_domain *parent)
+{
+	struct irq_domain *domain;
+
+	if (info->hwsize > MSI_XA_DOMAIN_SIZE)
+		return NULL;
+
+	/*
+	 * Hardware size 0 is valid for backwards compatibility and for
+	 * domains which are not backed by a hardware table. Grant the
+	 * maximum index space.
+	 */
+	if (!info->hwsize)
+		info->hwsize =3D MSI_XA_DOMAIN_SIZE;
+
+	msi_domain_update_dom_ops(info);
+	if (info->flags & MSI_FLAG_USE_DEF_CHIP_OPS)
+		msi_domain_update_chip_ops(info);
+
+	domain =3D irq_domain_create_hierarchy(parent, flags | IRQ_DOMAIN_FLAG_MSI,=
 0,
+					     fwnode, &msi_domain_ops, info);
+
+	if (domain) {
+		if (!domain->name && info->chip)
+			domain->name =3D info->chip->name;
+		irq_domain_update_bus_token(domain, info->bus_token);
+	}
+
+	return domain;
+}
+
 /**
  * msi_create_irq_domain - Create an MSI interrupt domain
  * @fwnode:	Optional fwnode of the interrupt controller
@@ -680,19 +850,210 @@ struct irq_domain *msi_create_irq_domain(struct fwnode=
_handle *fwnode,
 					 struct msi_domain_info *info,
 					 struct irq_domain *parent)
 {
+	return __msi_create_irq_domain(fwnode, info, 0, parent);
+}
+
+/**
+ * msi_parent_init_dev_msi_info - Delegate initialization of device MSI info=
 down
+ *				  in the domain hierarchy
+ * @dev:		The device for which the domain should be created
+ * @domain:		The domain in the hierarchy this op is being called on
+ * @msi_parent_domain:	The IRQ_DOMAIN_FLAG_MSI_PARENT domain for the child to
+ *			be created
+ * @msi_child_info:	The MSI domain info of the IRQ_DOMAIN_FLAG_MSI_DEVICE
+ *			domain to be created
+ *
+ * Return: true on success, false otherwise
+ *
+ * This is the most complex problem of per device MSI domains and the
+ * underlying interrupt domain hierarchy:
+ *
+ * The device domain to be initialized requests the broadest feature set
+ * possible and the underlying domain hierarchy puts restrictions on it.
+ *
+ * That's trivial for a simple parent->child relationship, but it gets
+ * interesting with an intermediate domain: root->parent->child.  The
+ * intermediate 'parent' can expand the capabilities which the 'root'
+ * domain is providing. So that creates a classic hen and egg problem:
+ * Which entity is doing the restrictions/expansions?
+ *
+ * One solution is to let the root domain handle the initialization that's
+ * why there is the @domain and the @msi_parent_domain pointer.
+ */
+bool msi_parent_init_dev_msi_info(struct device *dev, struct irq_domain *dom=
ain,
+				  struct irq_domain *msi_parent_domain,
+				  struct msi_domain_info *msi_child_info)
+{
+	struct irq_domain *parent =3D domain->parent;
+
+	if (WARN_ON_ONCE(!parent || !parent->msi_parent_ops ||
+			 !parent->msi_parent_ops->init_dev_msi_info))
+		return false;
+
+	return parent->msi_parent_ops->init_dev_msi_info(dev, parent, msi_parent_do=
main,
+							 msi_child_info);
+}
+
+/**
+ * msi_create_device_irq_domain - Create a device MSI interrupt domain
+ * @dev:		Pointer to the device
+ * @domid:		Domain id
+ * @template:		MSI domain info bundle used as template
+ * @hwsize:		Maximum number of MSI table entries (0 if unknown or unlimited)
+ * @domain_data:	Optional pointer to domain specific data which is set in
+ *			msi_domain_info::data
+ * @chip_data:		Optional pointer to chip specific data which is set in
+ *			msi_domain_info::chip_data
+ *
+ * Return: True on success, false otherwise
+ *
+ * There is no firmware node required for this interface because the per
+ * device domains are software constructs which are actually closer to the
+ * hardware reality than any firmware can describe them.
+ *
+ * The domain name and the irq chip name for a MSI device domain are
+ * composed by: "$(PREFIX)$(CHIPNAME)-$(DEVNAME)"
+ *
+ * $PREFIX:   Optional prefix provided by the underlying MSI parent domain
+ *	      via msi_parent_ops::prefix. If that pointer is NULL the prefix
+ *	      is empty.
+ * $CHIPNAME: The name of the irq_chip in @template
+ * $DEVNAME:  The name of the device
+ *
+ * This results in understandable chip names and hardware interrupt numbers
+ * in e.g. /proc/interrupts
+ *
+ * PCI-MSI-0000:00:1c.0     0-edge  Parent domain has no prefix
+ * IR-PCI-MSI-0000:00:1c.4  0-edge  Same with interrupt remapping prefix 'IR=
-'
+ *
+ * IR-PCI-MSIX-0000:3d:00.0 0-edge  Hardware interrupt numbers reflect
+ * IR-PCI-MSIX-0000:3d:00.0 1-edge  the real MSI-X index on that device
+ * IR-PCI-MSIX-0000:3d:00.0 2-edge
+ *
+ * On IMS domains the hardware interrupt number is either a table entry
+ * index or a purely software managed index but it is guaranteed to be
+ * unique.
+ *
+ * The domain pointer is stored in @dev::msi::data::__irqdomains[]. All
+ * subsequent operations on the domain depend on the domain id.
+ *
+ * The domain is automatically freed when the device is removed via devres
+ * in the context of @dev::msi::data freeing, but it can also be
+ * independently removed via @msi_remove_device_irq_domain().
+ */
+bool msi_create_device_irq_domain(struct device *dev, unsigned int domid,
+				  const struct msi_domain_template *template,
+				  unsigned int hwsize, void *domain_data,
+				  void *chip_data)
+{
+	struct irq_domain *domain, *parent =3D dev->msi.domain;
+	const struct msi_parent_ops *pops;
+	struct msi_domain_template *bundle;
+	struct fwnode_handle *fwnode;
+
+	if (!irq_domain_is_msi_parent(parent))
+		return false;
+
+	if (domid >=3D MSI_MAX_DEVICE_IRQDOMAINS)
+		return false;
+
+	bundle =3D kmemdup(template, sizeof(*bundle), GFP_KERNEL);
+	if (!bundle)
+		return false;
+
+	bundle->info.hwsize =3D hwsize;
+	bundle->info.chip =3D &bundle->chip;
+	bundle->info.ops =3D &bundle->ops;
+	bundle->info.data =3D domain_data;
+	bundle->info.chip_data =3D chip_data;
+
+	pops =3D parent->msi_parent_ops;
+	snprintf(bundle->name, sizeof(bundle->name), "%s%s-%s",
+		 pops->prefix ? : "", bundle->chip.name, dev_name(dev));
+	bundle->chip.name =3D bundle->name;
+
+	fwnode =3D irq_domain_alloc_named_fwnode(bundle->name);
+	if (!fwnode)
+		goto free_bundle;
+
+	if (msi_setup_device_data(dev))
+		goto free_fwnode;
+
+	msi_lock_descs(dev);
+
+	if (WARN_ON_ONCE(msi_get_device_domain(dev, domid)))
+		goto fail;
+
+	if (!pops->init_dev_msi_info(dev, parent, parent, &bundle->info))
+		goto fail;
+
+	domain =3D __msi_create_irq_domain(fwnode, &bundle->info, IRQ_DOMAIN_FLAG_M=
SI_DEVICE, parent);
+	if (!domain)
+		goto fail;
+
+	domain->dev =3D dev;
+	dev->msi.data->__domains[domid].domain =3D domain;
+	msi_unlock_descs(dev);
+	return true;
+
+fail:
+	msi_unlock_descs(dev);
+free_fwnode:
+	kfree(fwnode);
+free_bundle:
+	kfree(bundle);
+	return false;
+}
+
+/**
+ * msi_remove_device_irq_domain - Free a device MSI interrupt domain
+ * @dev:	Pointer to the device
+ * @domid:	Domain id
+ */
+void msi_remove_device_irq_domain(struct device *dev, unsigned int domid)
+{
+	struct msi_domain_info *info;
 	struct irq_domain *domain;
=20
-	msi_domain_update_dom_ops(info);
-	if (info->flags & MSI_FLAG_USE_DEF_CHIP_OPS)
-		msi_domain_update_chip_ops(info);
+	msi_lock_descs(dev);
=20
-	domain =3D irq_domain_create_hierarchy(parent, IRQ_DOMAIN_FLAG_MSI, 0,
-					     fwnode, &msi_domain_ops, info);
+	domain =3D msi_get_device_domain(dev, domid);
=20
-	if (domain && !domain->name && info->chip)
-		domain->name =3D info->chip->name;
+	if (!domain || !irq_domain_is_msi_device(domain))
+		goto unlock;
=20
-	return domain;
+	dev->msi.data->__domains[domid].domain =3D NULL;
+	info =3D domain->host_data;
+	irq_domain_remove(domain);
+	kfree(container_of(info, struct msi_domain_template, info));
+
+unlock:
+	msi_unlock_descs(dev);
+}
+
+/**
+ * msi_match_device_irq_domain - Match a device irq domain against a bus tok=
en
+ * @dev:	Pointer to the device
+ * @domid:	Domain id
+ * @bus_token:	Bus token to match against the domain bus token
+ *
+ * Return: True if device domain exists and bus tokens match.
+ */
+bool msi_match_device_irq_domain(struct device *dev, unsigned int domid,
+				 enum irq_domain_bus_token bus_token)
+{
+	struct msi_domain_info *info;
+	struct irq_domain *domain;
+	bool ret =3D false;
+
+	msi_lock_descs(dev);
+	domain =3D msi_get_device_domain(dev, domid);
+	if (domain && irq_domain_is_msi_device(domain)) {
+		info =3D domain->host_data;
+		ret =3D info->bus_token =3D=3D bus_token;
+	}
+	msi_unlock_descs(dev);
+	return ret;
 }
=20
 int msi_domain_prepare_irqs(struct irq_domain *domain, struct device *dev,
@@ -700,13 +1061,8 @@ int msi_domain_prepare_irqs(struct irq_domain *domain, =
struct device *dev,
 {
 	struct msi_domain_info *info =3D domain->host_data;
 	struct msi_domain_ops *ops =3D info->ops;
-	int ret;
=20
-	ret =3D ops->msi_check(domain, info, dev);
-	if (ret =3D=3D 0)
-		ret =3D ops->msi_prepare(domain, dev, nvec, arg);
-
-	return ret;
+	return ops->msi_prepare(domain, dev, nvec, arg);
 }
=20
 int msi_domain_populate_irqs(struct irq_domain *domain, struct device *dev,
@@ -714,16 +1070,27 @@ int msi_domain_populate_irqs(struct irq_domain *domain=
, struct device *dev,
 {
 	struct msi_domain_info *info =3D domain->host_data;
 	struct msi_domain_ops *ops =3D info->ops;
+	struct msi_ctrl ctrl =3D {
+		.domid	=3D MSI_DEFAULT_DOMAIN,
+		.first  =3D virq_base,
+		.last	=3D virq_base + nvec - 1,
+	};
 	struct msi_desc *desc;
+	struct xarray *xa;
 	int ret, virq;
=20
+	if (!msi_ctrl_valid(dev, &ctrl))
+		return -EINVAL;
+
 	msi_lock_descs(dev);
-	ret =3D msi_add_simple_msi_descs(dev, virq_base, nvec);
+	ret =3D msi_domain_add_simple_msi_descs(dev, &ctrl);
 	if (ret)
 		goto unlock;
=20
+	xa =3D &dev->msi.data->__domains[ctrl.domid].store;
+
 	for (virq =3D virq_base; virq < virq_base + nvec; virq++) {
-		desc =3D xa_load(&dev->msi.data->__store, virq);
+		desc =3D xa_load(xa, virq);
 		desc->irq =3D virq;
=20
 		ops->set_desc(arg, desc);
@@ -739,7 +1106,7 @@ int msi_domain_populate_irqs(struct irq_domain *domain, =
struct device *dev,
 fail:
 	for (--virq; virq >=3D virq_base; virq--)
 		irq_domain_free_irqs_common(domain, virq, 1);
-	msi_free_msi_descs_range(dev, MSI_DESC_ALL, virq_base, virq_base + nvec - 1=
);
+	msi_domain_free_descs(dev, &ctrl);
 unlock:
 	msi_unlock_descs(dev);
 	return ret;
@@ -764,6 +1131,8 @@ static bool msi_check_reservation_mode(struct irq_domain=
 *domain,
=20
 	switch(domain->bus_token) {
 	case DOMAIN_BUS_PCI_MSI:
+	case DOMAIN_BUS_PCI_DEVICE_MSI:
+	case DOMAIN_BUS_PCI_DEVICE_MSIX:
 	case DOMAIN_BUS_VMD_MSI:
 		break;
 	default:
@@ -789,6 +1158,8 @@ static int msi_handle_pci_fail(struct irq_domain *domain=
, struct msi_desc *desc,
 {
 	switch(domain->bus_token) {
 	case DOMAIN_BUS_PCI_MSI:
+	case DOMAIN_BUS_PCI_DEVICE_MSI:
+	case DOMAIN_BUS_PCI_DEVICE_MSIX:
 	case DOMAIN_BUS_VMD_MSI:
 		if (IS_ENABLED(CONFIG_PCI_MSI))
 			break;
@@ -850,18 +1221,19 @@ static int msi_init_virq(struct irq_domain *domain, in=
t virq, unsigned int vflag
 	return 0;
 }
=20
-int __msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
-			    int nvec)
+static int __msi_domain_alloc_irqs(struct device *dev, struct irq_domain *do=
main,
+				   struct msi_ctrl *ctrl)
 {
+	struct xarray *xa =3D &dev->msi.data->__domains[ctrl->domid].store;
 	struct msi_domain_info *info =3D domain->host_data;
 	struct msi_domain_ops *ops =3D info->ops;
+	unsigned int vflags =3D 0, allocated =3D 0;
 	msi_alloc_info_t arg =3D { };
-	unsigned int vflags =3D 0;
 	struct msi_desc *desc;
-	int allocated =3D 0;
+	unsigned long idx;
 	int i, ret, virq;
=20
-	ret =3D msi_domain_prepare_irqs(domain, dev, nvec, &arg);
+	ret =3D msi_domain_prepare_irqs(domain, dev, ctrl->nirqs, &arg);
 	if (ret)
 		return ret;
=20
@@ -883,11 +1255,21 @@ int __msi_domain_alloc_irqs(struct irq_domain *domain,=
 struct device *dev,
 		 * MSI affinity setting requires a special quirk (X86) when
 		 * reservation mode is active.
 		 */
-		if (domain->flags & IRQ_DOMAIN_MSI_NOMASK_QUIRK)
+		if (info->flags & MSI_FLAG_NOMASK_QUIRK)
 			vflags |=3D VIRQ_NOMASK_QUIRK;
 	}
=20
-	msi_for_each_desc(desc, dev, MSI_DESC_NOTASSOCIATED) {
+	xa_for_each_range(xa, idx, desc, ctrl->first, ctrl->last) {
+		if (!msi_desc_match(desc, MSI_DESC_NOTASSOCIATED))
+			continue;
+
+		/* This should return -ECONFUSED... */
+		if (WARN_ON_ONCE(allocated >=3D ctrl->nirqs))
+			return -EINVAL;
+
+		if (ops->prepare_desc)
+			ops->prepare_desc(domain, &arg, desc);
+
 		ops->set_desc(&arg, desc);
=20
 		virq =3D __irq_domain_alloc_irqs(domain, -1, desc->nvec_used,
@@ -913,76 +1295,213 @@ int __msi_domain_alloc_irqs(struct irq_domain *domain=
, struct device *dev,
 	return 0;
 }
=20
-static int msi_domain_add_simple_msi_descs(struct msi_domain_info *info,
-					   struct device *dev,
-					   unsigned int num_descs)
+static int msi_domain_alloc_simple_msi_descs(struct device *dev,
+					     struct msi_domain_info *info,
+					     struct msi_ctrl *ctrl)
 {
 	if (!(info->flags & MSI_FLAG_ALLOC_SIMPLE_MSI_DESCS))
 		return 0;
=20
-	return msi_add_simple_msi_descs(dev, 0, num_descs);
+	return msi_domain_add_simple_msi_descs(dev, ctrl);
+}
+
+static int __msi_domain_alloc_locked(struct device *dev, struct msi_ctrl *ct=
rl)
+{
+	struct msi_domain_info *info;
+	struct msi_domain_ops *ops;
+	struct irq_domain *domain;
+	int ret;
+
+	if (!msi_ctrl_valid(dev, ctrl))
+		return -EINVAL;
+
+	domain =3D msi_get_device_domain(dev, ctrl->domid);
+	if (!domain)
+		return -ENODEV;
+
+	info =3D domain->host_data;
+
+	ret =3D msi_domain_alloc_simple_msi_descs(dev, info, ctrl);
+	if (ret)
+		return ret;
+
+	ops =3D info->ops;
+	if (ops->domain_alloc_irqs)
+		return ops->domain_alloc_irqs(domain, dev, ctrl->nirqs);
+
+	return __msi_domain_alloc_irqs(dev, domain, ctrl);
+}
+
+static int msi_domain_alloc_locked(struct device *dev, struct msi_ctrl *ctrl)
+{
+	int ret =3D __msi_domain_alloc_locked(dev, ctrl);
+
+	if (ret)
+		msi_domain_free_locked(dev, ctrl);
+	return ret;
 }
=20
 /**
- * msi_domain_alloc_irqs_descs_locked - Allocate interrupts from a MSI inter=
rupt domain
- * @domain:	The domain to allocate from
+ * msi_domain_alloc_irqs_range_locked - Allocate interrupts from a MSI inter=
rupt domain
  * @dev:	Pointer to device struct of the device for which the interrupts
  *		are allocated
- * @nvec:	The number of interrupts to allocate
+ * @domid:	Id of the interrupt domain to operate on
+ * @first:	First index to allocate (inclusive)
+ * @last:	Last index to allocate (inclusive)
  *
  * Must be invoked from within a msi_lock_descs() / msi_unlock_descs()
- * pair. Use this for MSI irqdomains which implement their own vector
+ * pair. Use this for MSI irqdomains which implement their own descriptor
  * allocation/free.
  *
  * Return: %0 on success or an error code.
  */
-int msi_domain_alloc_irqs_descs_locked(struct irq_domain *domain, struct dev=
ice *dev,
-				       int nvec)
+int msi_domain_alloc_irqs_range_locked(struct device *dev, unsigned int domi=
d,
+				       unsigned int first, unsigned int last)
 {
-	struct msi_domain_info *info =3D domain->host_data;
-	struct msi_domain_ops *ops =3D info->ops;
-	int ret;
-
-	lockdep_assert_held(&dev->msi.data->mutex);
+	struct msi_ctrl ctrl =3D {
+		.domid	=3D domid,
+		.first	=3D first,
+		.last	=3D last,
+		.nirqs	=3D last + 1 - first,
+	};
+
+	return msi_domain_alloc_locked(dev, &ctrl);
+}
=20
-	ret =3D msi_domain_add_simple_msi_descs(info, dev, nvec);
-	if (ret)
-		return ret;
+/**
+ * msi_domain_alloc_irqs_range - Allocate interrupts from a MSI interrupt do=
main
+ * @dev:	Pointer to device struct of the device for which the interrupts
+ *		are allocated
+ * @domid:	Id of the interrupt domain to operate on
+ * @first:	First index to allocate (inclusive)
+ * @last:	Last index to allocate (inclusive)
+ *
+ * Return: %0 on success or an error code.
+ */
+int msi_domain_alloc_irqs_range(struct device *dev, unsigned int domid,
+				unsigned int first, unsigned int last)
+{
+	int ret;
=20
-	ret =3D ops->domain_alloc_irqs(domain, dev, nvec);
-	if (ret)
-		msi_domain_free_irqs_descs_locked(domain, dev);
+	msi_lock_descs(dev);
+	ret =3D msi_domain_alloc_irqs_range_locked(dev, domid, first, last);
+	msi_unlock_descs(dev);
 	return ret;
 }
=20
 /**
- * msi_domain_alloc_irqs - Allocate interrupts from a MSI interrupt domain
- * @domain:	The domain to allocate from
+ * msi_domain_alloc_irqs_all_locked - Allocate all interrupts from a MSI int=
errupt domain
+ *
  * @dev:	Pointer to device struct of the device for which the interrupts
  *		are allocated
- * @nvec:	The number of interrupts to allocate
+ * @domid:	Id of the interrupt domain to operate on
+ * @nirqs:	The number of interrupts to allocate
+ *
+ * This function scans all MSI descriptors of the MSI domain and allocates i=
nterrupts
+ * for all unassigned ones. That function is to be used for MSI domain usage=
 where
+ * the descriptor allocation is handled at the call site, e.g. PCI/MSI[X].
  *
  * Return: %0 on success or an error code.
  */
-int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev, int=
 nvec)
+int msi_domain_alloc_irqs_all_locked(struct device *dev, unsigned int domid,=
 int nirqs)
 {
+	struct msi_ctrl ctrl =3D {
+		.domid	=3D domid,
+		.first	=3D 0,
+		.last	=3D msi_domain_get_hwsize(dev, domid) - 1,
+		.nirqs	=3D nirqs,
+	};
+
+	return msi_domain_alloc_locked(dev, &ctrl);
+}
+
+/**
+ * msi_domain_alloc_irq_at - Allocate an interrupt from a MSI interrupt doma=
in at
+ *			     a given index - or at the next free index
+ *
+ * @dev:	Pointer to device struct of the device for which the interrupts
+ *		are allocated
+ * @domid:	Id of the interrupt domain to operate on
+ * @index:	Index for allocation. If @index =3D=3D %MSI_ANY_INDEX the allocat=
ion
+ *		uses the next free index.
+ * @affdesc:	Optional pointer to an interrupt affinity descriptor structure
+ * @icookie:	Optional pointer to a domain specific per instance cookie. If
+ *		non-NULL the content of the cookie is stored in msi_desc::data.
+ *		Must be NULL for MSI-X allocations
+ *
+ * This requires a MSI interrupt domain which lets the core code manage the
+ * MSI descriptors.
+ *
+ * Return: struct msi_map
+ *
+ *	On success msi_map::index contains the allocated index number and
+ *	msi_map::virq the corresponding Linux interrupt number
+ *
+ *	On failure msi_map::index contains the error code and msi_map::virq
+ *	is %0.
+ */
+struct msi_map msi_domain_alloc_irq_at(struct device *dev, unsigned int domi=
d, unsigned int index,
+				       const struct irq_affinity_desc *affdesc,
+				       union msi_instance_cookie *icookie)
+{
+	struct msi_ctrl ctrl =3D { .domid	=3D domid, .nirqs =3D 1, };
+	struct irq_domain *domain;
+	struct msi_map map =3D { };
+	struct msi_desc *desc;
 	int ret;
=20
 	msi_lock_descs(dev);
-	ret =3D msi_domain_alloc_irqs_descs_locked(domain, dev, nvec);
+	domain =3D msi_get_device_domain(dev, domid);
+	if (!domain) {
+		map.index =3D -ENODEV;
+		goto unlock;
+	}
+
+	desc =3D msi_alloc_desc(dev, 1, affdesc);
+	if (!desc) {
+		map.index =3D -ENOMEM;
+		goto unlock;
+	}
+
+	if (icookie)
+		desc->data.icookie =3D *icookie;
+
+	ret =3D msi_insert_desc(dev, desc, domid, index);
+	if (ret) {
+		map.index =3D ret;
+		goto unlock;
+	}
+
+	ctrl.first =3D ctrl.last =3D desc->msi_index;
+
+	ret =3D __msi_domain_alloc_irqs(dev, domain, &ctrl);
+	if (ret) {
+		map.index =3D ret;
+		msi_domain_free_locked(dev, &ctrl);
+	} else {
+		map.index =3D desc->msi_index;
+		map.virq =3D desc->irq;
+	}
+unlock:
 	msi_unlock_descs(dev);
-	return ret;
+	return map;
 }
=20
-void __msi_domain_free_irqs(struct irq_domain *domain, struct device *dev)
+static void __msi_domain_free_irqs(struct device *dev, struct irq_domain *do=
main,
+				   struct msi_ctrl *ctrl)
 {
+	struct xarray *xa =3D &dev->msi.data->__domains[ctrl->domid].store;
 	struct msi_domain_info *info =3D domain->host_data;
 	struct irq_data *irqd;
 	struct msi_desc *desc;
+	unsigned long idx;
 	int i;
=20
-	/* Only handle MSI entries which have an interrupt associated */
-	msi_for_each_desc(desc, dev, MSI_DESC_ASSOCIATED) {
+	xa_for_each_range(xa, idx, desc, ctrl->first, ctrl->last) {
+		/* Only handle MSI entries which have an interrupt associated */
+		if (!msi_desc_match(desc, MSI_DESC_ASSOCIATED))
+			continue;
+
 		/* Make sure all interrupts are deactivated */
 		for (i =3D 0; i < desc->nvec_used; i++) {
 			irqd =3D irq_domain_get_irq_data(domain, desc->irq + i);
@@ -997,44 +1516,99 @@ void __msi_domain_free_irqs(struct irq_domain *domain,=
 struct device *dev)
 	}
 }
=20
-static void msi_domain_free_msi_descs(struct msi_domain_info *info,
-				      struct device *dev)
+static void msi_domain_free_locked(struct device *dev, struct msi_ctrl *ctrl)
 {
+	struct msi_domain_info *info;
+	struct msi_domain_ops *ops;
+	struct irq_domain *domain;
+
+	if (!msi_ctrl_valid(dev, ctrl))
+		return;
+
+	domain =3D msi_get_device_domain(dev, ctrl->domid);
+	if (!domain)
+		return;
+
+	info =3D domain->host_data;
+	ops =3D info->ops;
+
+	if (ops->domain_free_irqs)
+		ops->domain_free_irqs(domain, dev);
+	else
+		__msi_domain_free_irqs(dev, domain, ctrl);
+
+	if (ops->msi_post_free)
+		ops->msi_post_free(domain, dev);
+
 	if (info->flags & MSI_FLAG_FREE_MSI_DESCS)
-		msi_free_msi_descs(dev);
+		msi_domain_free_descs(dev, ctrl);
 }
=20
 /**
- * msi_domain_free_irqs_descs_locked - Free interrupts from a MSI interrupt =
@domain associated to @dev
- * @domain:	The domain to managing the interrupts
+ * msi_domain_free_irqs_range_locked - Free a range of interrupts from a MSI=
 interrupt domain
+ *				       associated to @dev with msi_lock held
  * @dev:	Pointer to device struct of the device for which the interrupts
- *		are free
+ *		are freed
+ * @domid:	Id of the interrupt domain to operate on
+ * @first:	First index to free (inclusive)
+ * @last:	Last index to free (inclusive)
+ */
+void msi_domain_free_irqs_range_locked(struct device *dev, unsigned int domi=
d,
+				       unsigned int first, unsigned int last)
+{
+	struct msi_ctrl ctrl =3D {
+		.domid	=3D domid,
+		.first	=3D first,
+		.last	=3D last,
+	};
+	msi_domain_free_locked(dev, &ctrl);
+}
+
+/**
+ * msi_domain_free_irqs_range - Free a range of interrupts from a MSI interr=
upt domain
+ *				associated to @dev
+ * @dev:	Pointer to device struct of the device for which the interrupts
+ *		are freed
+ * @domid:	Id of the interrupt domain to operate on
+ * @first:	First index to free (inclusive)
+ * @last:	Last index to free (inclusive)
+ */
+void msi_domain_free_irqs_range(struct device *dev, unsigned int domid,
+				unsigned int first, unsigned int last)
+{
+	msi_lock_descs(dev);
+	msi_domain_free_irqs_range_locked(dev, domid, first, last);
+	msi_unlock_descs(dev);
+}
+
+/**
+ * msi_domain_free_irqs_all_locked - Free all interrupts from a MSI interrup=
t domain
+ *				     associated to a device
+ * @dev:	Pointer to device struct of the device for which the interrupts
+ *		are freed
+ * @domid:	The id of the domain to operate on
  *
  * Must be invoked from within a msi_lock_descs() / msi_unlock_descs()
  * pair. Use this for MSI irqdomains which implement their own vector
  * allocation.
  */
-void msi_domain_free_irqs_descs_locked(struct irq_domain *domain, struct dev=
ice *dev)
+void msi_domain_free_irqs_all_locked(struct device *dev, unsigned int domid)
 {
-	struct msi_domain_info *info =3D domain->host_data;
-	struct msi_domain_ops *ops =3D info->ops;
-
-	lockdep_assert_held(&dev->msi.data->mutex);
-
-	ops->domain_free_irqs(domain, dev);
-	msi_domain_free_msi_descs(info, dev);
+	msi_domain_free_irqs_range_locked(dev, domid, 0,
+					  msi_domain_get_hwsize(dev, domid) - 1);
 }
=20
 /**
- * msi_domain_free_irqs - Free interrupts from a MSI interrupt @domain assoc=
iated to @dev
- * @domain:	The domain to managing the interrupts
+ * msi_domain_free_irqs_all - Free all interrupts from a MSI interrupt domain
+ *			      associated to a device
  * @dev:	Pointer to device struct of the device for which the interrupts
- *		are free
+ *		are freed
+ * @domid:	The id of the domain to operate on
  */
-void msi_domain_free_irqs(struct irq_domain *domain, struct device *dev)
+void msi_domain_free_irqs_all(struct device *dev, unsigned int domid)
 {
 	msi_lock_descs(dev);
-	msi_domain_free_irqs_descs_locked(domain, dev);
+	msi_domain_free_irqs_all_locked(dev, domid);
 	msi_unlock_descs(dev);
 }
=20
@@ -1048,5 +1622,3 @@ struct msi_domain_info *msi_get_domain_info(struct irq_=
domain *domain)
 {
 	return (struct msi_domain_info *)domain->host_data;
 }
-
-#endif /* CONFIG_GENERIC_MSI_IRQ_DOMAIN */

