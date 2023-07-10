Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68ACA74D214
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 11:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbjGJJtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 05:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233214AbjGJJsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 05:48:06 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544E530F5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 02:43:40 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-78363cc070aso206102039f.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 02:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1688982219; x=1691574219;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xsDadgu4zFYxaidCyMCgBtLLg4ch6o0hizhw6Xf+JWI=;
        b=QEeq93mIOqTIkpTS2TDFGGcf3T/pxS5GqRaurc0PEkWCpbbc/YuE6hUpWBiQ9V0ydh
         BuWxNcIdnGrEnAv//Nh74drOi0NHIeLcrhNOLEZ+IamGRy4QAtQp5fdb+nOvCiz6jfeH
         ygk/f+fs0BQR6x6EFmkS98arVVrz/iJw2VB3pxkmHRgstWXSa7xbgE/mtj10BNCI5XZs
         I+sOkHlYWWZwGGqKSgGzn5DwhKlRmlMswoNvFdIuOe+ZLzQbpDap7+xlIOeIoACsotoa
         gqB3YTI6bavR3VFNDfGyceM0AHyllAc4fHdN5ETBYlDA29EjN0OhEipPBziwIlZGadMI
         L/hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688982219; x=1691574219;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xsDadgu4zFYxaidCyMCgBtLLg4ch6o0hizhw6Xf+JWI=;
        b=TwhaQk82lpHBeEc7+oVPXzINyvQVjGw4rkRlsuAdznl/6OPTWPofkeElYvmuuwEKnY
         Udkp9WCQ8vqGw8xEh7J4TW31wmXF+XzGFeqOUoTD1sJQH++QF31R/+op0h06zKHFYO5E
         ZKL3ZawWV0nsArDaVFIigCd2jFOGRVouzjm/KZnvAHr2CWPDTTDkOXRTdFhEPXXlEuDa
         VcwroppYoaxf3g0wTMGzJNTsJhSxhPWxQE7jJfSrygSvH3GPdBo03NoHDYeMLDKkLJW8
         1OAIuDj3LuQbx0TQOMF871A9QwUah3FcK7QPYFRSZ3VeDFvIlfyI233feo/uQmdFYzqx
         DxzA==
X-Gm-Message-State: ABy/qLYqkztGxglo/UsuGxNic58DqJ+aWQyV9+OzxkhNWBaExGzGkx7M
        DtglD7xw64QrY4oFj1kvj/IHBw==
X-Google-Smtp-Source: APBJJlEKO1Ti+cjyC3HuUM8xLoZTM567hECGaUeRYBdWlSgOmax+9711bNT2933KYdLzT9Dw5jHtKQ==
X-Received: by 2002:a5e:de44:0:b0:787:8cf:fe8a with SMTP id e4-20020a5ede44000000b0078708cffe8amr3889581ioq.2.1688982218808;
        Mon, 10 Jul 2023 02:43:38 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id k1-20020a6b7a41000000b007870c56387dsm936938iop.49.2023.07.10.02.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 02:43:38 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Conor Dooley <conor@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v5 0/9] Linux RISC-V AIA Support
Date:   Mon, 10 Jul 2023 15:13:12 +0530
Message-Id: <20230710094321.1378351-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RISC-V AIA specification is now frozen as-per the RISC-V international
process. The latest frozen specifcation can be found at:
https://github.com/riscv/riscv-aia/releases/download/1.0/riscv-interrupts-1.0.pdf

At a high-level, the AIA specification adds three things:
1) AIA CSRs
   - Improved local interrupt support
2) Incoming Message Signaled Interrupt Controller (IMSIC)
   - Per-HART MSI controller
   - Support MSI virtualization
   - Support IPI along with virtualization
3) Advanced Platform-Level Interrupt Controller (APLIC)
   - Wired interrupt controller
   - In MSI-mode, converts wired interrupt into MSIs (i.e. MSI generator)
   - In Direct-mode, injects external interrupts directly into HARTs

For an overview of the AIA specification, refer the AIA virtualization
talk at KVM Forum 2022:
https://static.sched.com/hosted_files/kvmforum2022/a1/AIA_Virtualization_in_KVM_RISCV_final.pdf
https://www.youtube.com/watch?v=r071dL8Z0yo

To test this series, use QEMU v7.2 (or higher) and OpenSBI v1.2 (or higher).

These patches can also be found in the riscv_aia_v5 branch at:
https://github.com/avpatel/linux.git

Changes since v4:
 - Rebased on Linux-6.5-rc1
 - Added "Dependencies" in the APLIC bindings (PATCH6 in v4)
 - Dropped the PATCH6 which was changing the IOMMU DMA domain APIs
 - Dropped use of IOMMU DMA APIs in the IMSIC driver (PATCH4)

Changes since v3:
 - Rebased on Linux-6.4-rc6
 - Droped PATCH2 of v3 series instead we now set FWNODE_FLAG_BEST_EFFORT via
   IRQCHIP_DECLARE()
 - Extend riscv_fw_parent_hartid() to support both DT and ACPI in PATCH1
 - Extend iommu_dma_compose_msi_msg() instead of adding iommu_dma_select_msi()
   in PATCH6
 - Addressed Conor's comments in PATCH3
 - Addressed Conor's and Rob's comments in PATCH7

Changes since v2:
 - Rebased on Linux-6.4-rc1
 - Addressed Rob's comments on DT bindings patches 4 and 8.
 - Addessed Marc's comments on IMSIC driver PATCH5
 - Replaced use of OF apis in APLIC and IMSIC drivers with FWNODE apis
   this makes both drivers easily portable for ACPI support. This also
   removes unnecessary indirection from the APLIC and IMSIC drivers.
 - PATCH1 is a new patch for portability with ACPI support
 - PATCH2 is a new patch to fix probing in APLIC drivers for APLIC-only systems.
 - PATCH7 is a new patch which addresses the IOMMU DMA domain issues pointed
   out by SiFive

Changes since v1:
 - Rebased on Linux-6.2-rc2
 - Addressed comments on IMSIC DT bindings for PATCH4
 - Use raw_spin_lock_irqsave() on ids_lock for PATCH5
 - Improved MMIO alignment checks in PATCH5 to allow MMIO regions
   with holes.
 - Addressed comments on APLIC DT bindings for PATCH6
 - Fixed warning splat in aplic_msi_write_msg() caused by
   zeroed MSI message in PATCH7
 - Dropped DT property riscv,slow-ipi instead will have module
   parameter in future.

Anup Patel (9):
  RISC-V: Add riscv_fw_parent_hartid() function
  irqchip/riscv-intc: Add support for RISC-V AIA
  dt-bindings: interrupt-controller: Add RISC-V incoming MSI controller
  irqchip: Add RISC-V incoming MSI controller driver
  irqchip/riscv-imsic: Add support for PCI MSI irqdomain
  dt-bindings: interrupt-controller: Add RISC-V advanced PLIC
  irqchip: Add RISC-V advanced PLIC driver
  RISC-V: Select APLIC and IMSIC drivers
  MAINTAINERS: Add entry for RISC-V AIA drivers

 .../interrupt-controller/riscv,aplic.yaml     |  172 +++
 .../interrupt-controller/riscv,imsics.yaml    |  172 +++
 MAINTAINERS                                   |   12 +
 arch/riscv/Kconfig                            |    2 +
 arch/riscv/include/asm/processor.h            |    3 +
 arch/riscv/kernel/cpu.c                       |   16 +
 drivers/irqchip/Kconfig                       |   20 +-
 drivers/irqchip/Makefile                      |    2 +
 drivers/irqchip/irq-riscv-aplic.c             |  774 ++++++++++++
 drivers/irqchip/irq-riscv-imsic.c             | 1060 +++++++++++++++++
 drivers/irqchip/irq-riscv-intc.c              |   36 +-
 include/linux/irqchip/riscv-aplic.h           |  119 ++
 include/linux/irqchip/riscv-imsic.h           |   86 ++
 13 files changed, 2467 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,imsics.yaml
 create mode 100644 drivers/irqchip/irq-riscv-aplic.c
 create mode 100644 drivers/irqchip/irq-riscv-imsic.c
 create mode 100644 include/linux/irqchip/riscv-aplic.h
 create mode 100644 include/linux/irqchip/riscv-imsic.h

-- 
2.34.1

