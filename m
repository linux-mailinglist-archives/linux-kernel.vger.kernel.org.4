Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB83699C07
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 19:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjBPSUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 13:20:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjBPSUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 13:20:53 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C62A50ADD
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 10:20:52 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id i15so133854plr.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 10:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MgvYXC/YwJq34AMN9II76hX03Nd4KT2jWXyTADHEnv4=;
        b=pdNcm8bSgevrSaZy31y3t4t9v1m4YYznVaEm0s/HBgp1I1aMx3aOngBEWd5qngNxDG
         /AF60Dlr9YvAxjoM/qhbuFnaBjY/diBQAQPsSQ6uTJmZ9I+F61Ki+7BdrNK/j5A4ewhs
         gywSqXhU1JMXs7GTmVgaASC9eC5Tp7QFdtFRZ+fPLnAB/2KmkUIUJQ2c4TWHMzPPzOq7
         GiId2YGRBXT5KdqUrIEfj9F92Mw2gNm0gyRKsobkRFw1z1Vb2loISbb6xdLLROKcI64t
         35sAKjUm/pS00cyYnoSffxHGr2cEeezy00q26I4DuFUSlso3FlcMiuw6Q/eCaRwuArNs
         MQDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MgvYXC/YwJq34AMN9II76hX03Nd4KT2jWXyTADHEnv4=;
        b=BE4ArRyo+LE0E7VXNzm3wbHWXbsWsjlA+Dxmp5iwpFUlaG/rq+5lwLFW/Xs6Apii/N
         xaAAeRBHkRFkqBOQEc6aXrN9oqWSYMaeDuffeURWl0DqCCgLuzbWF3qUUJmudquwl/ur
         U8h7Uw221KrlvkIvqz98mwG0o6WEV3EzLT7WkZP0cL5ZXfGemzzoBzs6lHryPXJIEyyg
         oTerVTLTPFoC+F4cQ1080Mo34vgCZWgj6Vs48oOFKRsLeAX8Bp/LwM2R0LCome/3iBwP
         r8mcb3gz2HTTWadVAyWNJP1GphMbeWtBWnNmMJmFRgIljr6M6iXvbcB4/PpF296d5zic
         DqtA==
X-Gm-Message-State: AO0yUKV5AiwHRdwO2ju6KabzqYeyzjYTULxZG9sjedFlEmEs8tNDbbEL
        5Io9a+47iJYpHDYOUajPU67/Dw==
X-Google-Smtp-Source: AK7set9ADd0lkOoShwpMoMr1ZMdv/q6YpixBWzT32AwgiQCDHW12Oh4+5ycBen8zn5TAT5BA/CaSoQ==
X-Received: by 2002:a17:90a:35d:b0:233:c301:32c5 with SMTP id 29-20020a17090a035d00b00233c30132c5mr7904526pjf.45.1676571651833;
        Thu, 16 Feb 2023 10:20:51 -0800 (PST)
Received: from kerodi.Dlink ([49.206.14.226])
        by smtp.gmail.com with ESMTPSA id n21-20020a637215000000b004dff15fc121sm1517574pgc.36.2023.02.16.10.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 10:20:51 -0800 (PST)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH V2 00/21] Add basic ACPI support for RISC-V
Date:   Thu, 16 Feb 2023 23:50:22 +0530
Message-Id: <20230216182043.1946553-1-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series enables the basic ACPI infrastructure for RISC-V.
Supporting external interrupt controllers is in progress and hence it is
tested using poll based HVC SBI console and RAM disk.

The first patch in this series is one of the patch from Jisheng's
series [1] which is not merged yet. This patch is required to support
ACPI since efi_init() which gets called before sbi_init() can enable
static branches and hits panic.

The series depends on Anup's IPI improvement series [2].

[1] https://lore.kernel.org/all/20220821140918.3613-1-jszhang@kernel.org/
[2] https://lore.kernel.org/lkml/20230103141221.772261-7-apatel@ventanamicro.com/T/

Changes since V1:
	1) Dropped PCI changes and instead added dummy interfaces just to enable
	   building ACPI core when CONFIG_PCI is enabled. Actual PCI changes will
	   be added in future along with external interrupt controller support
	   in ACPI.
	2) Squashed couple of patches so that new code added gets built in each
	   commit.
	3) Fixed the missing wake_cpu code in timer refactor patch as pointed by
	   Conor
	4) Fixed an issue with SMP disabled.
	5) Addressed other comments from Conor.
	6) Updated documentation patch as per feedback from Sanjaya.
	7) Fixed W=1 and checkpatch --strict issues.
	8) Added ACK/RB tags

These changes are available at
https://github.com/vlsunil/linux/commits/acpi_b1_us_review_ipi17_V2

Testing:
1) Build Qemu with ACPI support using below branch
https://github.com/vlsunil/qemu/tree/acpi_b1_us_review_V3

2) Build EDK2 as per instructions in
https://github.com/vlsunil/riscv-uefi-edk2-docs/wiki/RISC-V-Qemu-Virt-support

3) Build Linux after enabling SBI HVC and SBI earlycon
CONFIG_RISCV_SBI_V01=y
CONFIG_SERIAL_EARLYCON_RISCV_SBI=y
CONFIG_HVC_RISCV_SBI=y

4) Build buildroot.

Run with below command.
qemu-system-riscv64   -nographic \
-drive file=Build/RiscVVirtQemu/RELEASE_GCC5/FV/RISCV_VIRT.fd,if=pflash,format=raw,unit=1 \
-machine virt,acpi -smp 16 -m 2G \
-kernel arch/riscv/boot/Image \
-initrd buildroot/output/images/rootfs.cpio \
-append "root=/dev/ram ro console=hvc0 earlycon=sbi"


Jisheng Zhang (1):
  riscv: move sbi_init() earlier before jump_label_init()

Sunil V L (20):
  ACPICA: MADT: Add RISC-V INTC interrupt controller
  ACPICA: Add structure definitions for RISC-V RHCT
  RISC-V: Add support to build the ACPI core
  ACPI: Kconfig: Enable ACPI_PROCESSOR for RISC-V
  ACPI: OSL: Make should_use_kmap() 0 for RISC-V.
  ACPI: processor_core: RISC-V: Enable mapping processor to the hartid
  drivers/acpi: RISC-V: Add RHCT related code
  RISC-V: smpboot: Create wrapper smp_setup()
  RISC-V: smpboot: Add ACPI support in smp_setup()
  RISC-V: ACPI: Add a function to retrieve the hartid
  RISC-V: cpufeature: Add ACPI support in riscv_fill_hwcap()
  RISC-V: cpu: Enable cpuinfo for ACPI systems
  irqchip/riscv-intc: Add ACPI support
  clocksource/timer-riscv: Refactor riscv_timer_init_dt()
  clocksource/timer-riscv: Add ACPI support
  RISC-V: time.c: Add ACPI support for time_init()
  RISC-V: Add ACPI initialization in setup_arch()
  RISC-V: Enable ACPI in defconfig
  MAINTAINERS: Add entry for drivers/acpi/riscv
  Documentation/kernel-parameters.txt: Add RISC-V for ACPI parameter

 .../admin-guide/kernel-parameters.txt         |   8 +-
 MAINTAINERS                                   |   7 +
 arch/riscv/Kconfig                            |   5 +
 arch/riscv/configs/defconfig                  |   2 +
 arch/riscv/include/asm/acenv.h                |  11 +
 arch/riscv/include/asm/acpi.h                 |  87 ++++++
 arch/riscv/include/asm/cpu.h                  |   8 +
 arch/riscv/kernel/Makefile                    |   2 +
 arch/riscv/kernel/acpi.c                      | 248 ++++++++++++++++++
 arch/riscv/kernel/cpu.c                       |  31 ++-
 arch/riscv/kernel/cpufeature.c                |  41 ++-
 arch/riscv/kernel/setup.c                     |  27 +-
 arch/riscv/kernel/smpboot.c                   |  75 +++++-
 arch/riscv/kernel/time.c                      |  25 +-
 drivers/acpi/Kconfig                          |   2 +-
 drivers/acpi/Makefile                         |   2 +
 drivers/acpi/osl.c                            |   2 +-
 drivers/acpi/processor_core.c                 |  29 ++
 drivers/acpi/riscv/Makefile                   |   2 +
 drivers/acpi/riscv/rhct.c                     |  92 +++++++
 drivers/clocksource/timer-riscv.c             |  93 ++++---
 drivers/irqchip/irq-riscv-intc.c              |  78 +++++-
 include/acpi/actbl2.h                         |  68 ++++-
 23 files changed, 854 insertions(+), 91 deletions(-)
 create mode 100644 arch/riscv/include/asm/acenv.h
 create mode 100644 arch/riscv/include/asm/acpi.h
 create mode 100644 arch/riscv/include/asm/cpu.h
 create mode 100644 arch/riscv/kernel/acpi.c
 create mode 100644 drivers/acpi/riscv/Makefile
 create mode 100644 drivers/acpi/riscv/rhct.c

-- 
2.34.1

