Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D0D6252B9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 05:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiKKEmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 23:42:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiKKEmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 23:42:45 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B5A6A6B5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 20:42:44 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id n205so3995407oib.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 20:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5rRCdDoP4ucuHJTu4Dp35ZlpfeELCSDaYd2hKM7VLR8=;
        b=Ah9ALclYD+mRrHhK5dzn2/JkJ5HxliwwDYtD/JQV6/7PU5gcF/nGWIceSm5kyLSF/x
         F+vAiZT8lVqGvGO8CeWYjDrqAVQGySjalFTLunBFcc88mR33+D+KrXWbFkLIqgFgxMPo
         k8KqKhA9zaokx2Ly0yz/gukqPpKK6jxQMYstYdMZo3rEAzPtwTactGy1IByOBla6SwAF
         G+RFXRFFLhYKU9e/fX17c6LbTom4Gv4BrvXeMMxKJrAaPbB7Q6gfbxEzaTYhJ4HWHacb
         f9HTXX4q5//06+49rHn+TktjO+G6Gby1C7CCe3pW9ZTFNJc7SihrcVrzlLlG36awoZRd
         +m0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5rRCdDoP4ucuHJTu4Dp35ZlpfeELCSDaYd2hKM7VLR8=;
        b=oa+0e6UJhUEcq/C5wP0QXOfBIbtkXyHHDBrgcgN+buVTZqem3CCUuWdMBPoC5h5O02
         LNc+VF4s6lAz2UNQ+D+xZS088YnDBLre/19HBSdYN+7bJVd1CXwaSfcYCc1wTUV5qFYD
         +860fzRTHcXFJuDwY4eqC7TpFhFEdkG6COvSrDIYVtzGt5fwHRKoPWjaeJFOsGfwt38R
         H6WM3YM3wtgUL7l5e2pfAtdgxdGKxhZRSpV7oVehlC9WQKKNqre4OI74wCyxPkER05pZ
         GWO/nmYM7+Y8PmeVeEaygcdjLQnZO96q7bAtYY1MczmKROKR46ihkbP/XhFHA3PsfZIG
         +usQ==
X-Gm-Message-State: ACrzQf0lS5OlmOvLVWPD3LLI/Bl/Nr71MuEBZ+Q1edMp0JI20Q0disTY
        P3cwcsGr7kIG3BeQe7zygeTyjw==
X-Google-Smtp-Source: AMsMyM6ccFBGCQhM+86XrT4r7MAESQqQ3bT7i9DXvYWPsUkIqaLCjxouX/GRGmYeduFJ0b4L6HovRg==
X-Received: by 2002:aca:f241:0:b0:35a:1a81:1961 with SMTP id q62-20020acaf241000000b0035a1a811961mr2787471oih.251.1668141763441;
        Thu, 10 Nov 2022 20:42:43 -0800 (PST)
Received: from anup-ubuntu64-vm.. ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id k14-20020a056870350e00b0013d9bd4ad2esm787353oah.12.2022.11.10.20.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 20:42:43 -0800 (PST)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 0/9] Linux RISC-V AIA Support
Date:   Fri, 11 Nov 2022 10:11:58 +0530
Message-Id: <20221111044207.1478350-1-apatel@ventanamicro.com>
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

The RISC-V AIA specification is now frozen as-per the RISC-V international
process. The latest frozen specifcation can be found at:
https://github.com/riscv/riscv-aia/releases/download/1.0-RC1/riscv-interrupts-1.0-RC1.pdf

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

For an overview of the AIA specification, refer the recent AIA virtualization
talk at KVM Forum 2022:
https://static.sched.com/hosted_files/kvmforum2022/a1/AIA_Virtualization_in_KVM_RISCV_final.pdf
https://www.youtube.com/watch?v=r071dL8Z0yo

This series adds required Linux irqchip drivers for AIA and it depends on
the recent "RISC-V IPI Improvements".
(Refer, https://lore.kernel.org/lkml/20221101143400.690000-1-apatel@ventanamicro.com/t/)

To test this series, use QEMU v7.1 (or higher) and OpenSBI v1.1 (or higher).

These patches can also be found in the riscv_aia_v1 branch at:
https://github.com/avpatel/linux.git

Anup Patel (9):
  RISC-V: Add AIA related CSR defines
  RISC-V: Detect AIA CSRs from ISA string
  irqchip/riscv-intc: Add support for RISC-V AIA
  dt-bindings: Add RISC-V incoming MSI controller bindings
  irqchip: Add RISC-V incoming MSI controller driver
  dt-bindings: Add RISC-V advanced PLIC bindings
  irqchip: Add RISC-V advanced PLIC driver
  RISC-V: Select APLIC and IMSIC drivers for QEMU virt machine
  MAINTAINERS: Add entry for RISC-V AIA drivers

 .../interrupt-controller/riscv,aplic.yaml     |  136 ++
 .../interrupt-controller/riscv,imsic.yaml     |  174 +++
 MAINTAINERS                                   |   12 +
 arch/riscv/Kconfig.socs                       |    2 +
 arch/riscv/include/asm/csr.h                  |   92 ++
 arch/riscv/include/asm/hwcap.h                |    8 +
 arch/riscv/kernel/cpu.c                       |    2 +
 arch/riscv/kernel/cpufeature.c                |    2 +
 drivers/irqchip/Kconfig                       |   32 +-
 drivers/irqchip/Makefile                      |    2 +
 drivers/irqchip/irq-riscv-aplic.c             |  656 +++++++++
 drivers/irqchip/irq-riscv-imsic.c             | 1207 +++++++++++++++++
 drivers/irqchip/irq-riscv-intc.c              |   37 +-
 include/linux/irqchip/riscv-aplic.h           |  117 ++
 include/linux/irqchip/riscv-imsic.h           |   92 ++
 15 files changed, 2564 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,imsic.yaml
 create mode 100644 drivers/irqchip/irq-riscv-aplic.c
 create mode 100644 drivers/irqchip/irq-riscv-imsic.c
 create mode 100644 include/linux/irqchip/riscv-aplic.h
 create mode 100644 include/linux/irqchip/riscv-imsic.h

-- 
2.34.1

