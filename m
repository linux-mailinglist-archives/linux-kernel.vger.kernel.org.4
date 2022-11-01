Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6738C614CA1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 15:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbiKAOei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 10:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiKAOeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 10:34:36 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D8F1B9D8
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 07:34:33 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id u6so13713074plq.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 07:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bzrUAtNLPZtva+XCQ1PJ1UKO7iIk8iXap37Oxcyeu5I=;
        b=fyS2W+arSy0GY5JgumfUxcS6nkiXA/qIpfsdeHJ9WAwPuV35UGueycE4MWQGNkwZ3X
         LXWaOAijKFEUPIfG66XZLTIlzWbxfaZTwLkHM2P0RLbKuogEamt70YHTzLfG2qqbzuXu
         I7A1tSb4/56x21eWdiBE/ByFtvhB5n7kPSuEVpiGC1cpS4AsSj46i6feKK/ew9y1nhdc
         h81mf2LvGxzu5oUHPGwlVb8uWa5bQLDM+Umc4WxPtAPnTuvN7lI0XbQqdlGccpfv/Bqy
         3kMY1/u0JSEQ8H7PihMFnidq0fURB2Btk6jIL9IX6ZssUYCDstxM1ZahycFBVE5VNt9O
         WMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bzrUAtNLPZtva+XCQ1PJ1UKO7iIk8iXap37Oxcyeu5I=;
        b=xWoY1bi/7ikfq3mX7OBZiS/nx/ueqBiQqqC0PYBLfAdowlDEcu3gZsMNRi8vEShepk
         w/hcwH5hMEm8uwr1HZ+Wki6RuSRu/8ay4JrnQ7/GknE2JOj5dESfV32/yUOjtTDuhYwY
         /pvvc1lvlafD03SD433z+R/yKcLVIeDVxAjY+16Htx85Gb7GWdmRod1134feNJGVoKh3
         QRY/ggscMnw6jjKMyketsfPE0ccnaIU5dryu2xSPfy82G8cMDQHApgDduF6GT/KnGBtH
         HACdNFczVsn6K7gbopwyDjSwxlL/3fMcI5U30xkJN5HZlRb+VZtFy5SvpbKZsmKEjT/a
         VXUw==
X-Gm-Message-State: ACrzQf04IyZ1QcjgU1IHNoh6PemPtvllXGdNP/Oz2tafEsu82i9+xl+G
        baTNDISHcGcEljIL3zvNpXiEsA==
X-Google-Smtp-Source: AMsMyM5yJSXbt3KfVv4pviMIXwN89iogpmlTwT/XCR4Mr4uXwQA6rTwiHcFQ9ciVAUTHQiws4FZheg==
X-Received: by 2002:a17:90a:af83:b0:213:d08f:a47f with SMTP id w3-20020a17090aaf8300b00213d08fa47fmr14468363pjq.28.1667313273364;
        Tue, 01 Nov 2022 07:34:33 -0700 (PDT)
Received: from anup-ubuntu64-vm.. ([171.76.80.52])
        by smtp.gmail.com with ESMTPSA id o20-20020a170903009400b0018685aaf41dsm6449055pld.18.2022.11.01.07.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 07:34:33 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v10 0/7] RISC-V IPI Improvements
Date:   Tue,  1 Nov 2022 20:03:53 +0530
Message-Id: <20221101143400.690000-1-apatel@ventanamicro.com>
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

This series aims to improve IPI support in Linux RISC-V in following ways:
 1) Treat IPIs as normal per-CPU interrupts instead of having custom RISC-V
    specific hooks. This also makes Linux RISC-V IPI support aligned with
    other architectures.
 2) Remote TLB flushes and icache flushes should prefer local IPIs instead
    of SBI calls whenever we have specialized hardware (such as RISC-V AIA
    IMSIC and RISC-V SWI) which allows S-mode software to directly inject
    IPIs without any assistance from M-mode runtime firmware.

These patches were originally part of the "Linux RISC-V ACLINT Support"
series but this now a separate series so that it can be merged independently
of the "Linux RISC-V ACLINT Support" series.
(Refer, https://lore.kernel.org/lkml/20211007123632.697666-1-anup.patel@wdc.com/)

These patches are also a preparatory patches for the up-coming:
 1) Linux RISC-V AIA support
 2) Linux RISC-V SWI support

These patches can also be found in riscv_ipi_imp_v10 branch at:
https://github.com/avpatel/linux.git

Changes since v9:
 - Rebased on Linux-6.1-rc3
 - Updated header comment block of ipi-mux.c in PATCH3
 - Use a struct for global data of ipi-mux.c in PATCH3
 - Add per-CPU temp cpumask for sending IPIs in PATCH3
 - Drop the use of fwspec in PATCH3
 - Use static key for ipi_mux_pre_handle() and ipi_mux_post_handle()
   in PATCH3
 - Remove redundant pr_warn_ratelimited() called by ipi_mux_process()
   in PATCH3
 - Remove CPUHP thingy from ipi_mux_create() in PATCH3

Changes since v8:
 - Rebased on Linux-6.0-rc3
 - Use dummy percpu data as parameter for request_percpu_irq() in PATCH4.

Changes since v7:
 - Rebased on Linux-6.0-rc1
 - Use atomic operations to track per-CPU pending and enabled IPIs in PATCH3.
   (Note: this is inspired from IPI muxing implemented in
    drivers/irqchip/irq-apple-aic.c)
 - Made "struct ipi_mux_ops" (added by PATCH3) flexible so that
   drivers/irqchip/irq-apple-aic.c can adopt it in future.

Changes since v6:
 - Rebased on Linux-5.19-rc7
 - Added documentation for struct ipi_mux_ops in PATCH3
 - Dropped dummy irq_mask()/unmask() in PATCH3
 - Added const for "ipi_mux_chip" in PATCH3
 - Removed "type" initialization from ipi_mux_domain_alloc() in PATCH3
 - Dropped translate() from "ipi_mux_domain_ops" in PATCH3
 - Improved barrier documentation in ipi_mux_process() of PATCH3
 - Added percpu check in ipi_mux_create() for parent_virq of PATCH3
 - Added nr_ipi parameter in ipi_mux_create() of PATCH3

Changes since v5:
 - Rebased on Linux-5.18-rc3
 - Used kernel doc style in PATCH3
 - Removed redundant loop in ipi_mux_process() of PATCH3
 - Removed "RISC-V" prefix form ipi_mux_chip.name of PATCH3
 - Removed use of "this patch" in PATCH3 commit description
 - Addressed few other nit comments in PATCH3

Changes since v4:
 - Rebased on Linux-5.17
 - Includes new PATCH3 which adds mechanism to multiplex a single HW IPI

Changes since v3:
 - Rebased on Linux-5.17-rc6
 - Updated PATCH2 to not export riscv_set_intc_hwnode_fn()
 - Simplified riscv_intc_hwnode() in PATCH2

Changes since v2:
 - Rebased on Linux-5.17-rc4
 - Updated PATCH2 to not create synthetic INTC fwnode and instead provide
   a function which allows drivers to directly discover INTC fwnode

Changes since v1:
 - Use synthetic fwnode for INTC instead of irq_set_default_host() in PATCH2

Anup Patel (7):
  RISC-V: Clear SIP bit only when using SBI IPI operations
  irqchip/riscv-intc: Allow drivers to directly discover INTC hwnode
  genirq: Add mechanism to multiplex a single HW IPI
  RISC-V: Treat IPIs as normal Linux IRQs
  RISC-V: Allow marking IPIs as suitable for remote FENCEs
  RISC-V: Use IPIs for remote TLB flush when possible
  RISC-V: Use IPIs for remote icache flush when possible

 arch/riscv/Kconfig                |   2 +
 arch/riscv/include/asm/irq.h      |   4 +
 arch/riscv/include/asm/sbi.h      |   7 +
 arch/riscv/include/asm/smp.h      |  49 ++++--
 arch/riscv/kernel/Makefile        |   1 +
 arch/riscv/kernel/cpu-hotplug.c   |   3 +-
 arch/riscv/kernel/irq.c           |  21 ++-
 arch/riscv/kernel/sbi-ipi.c       |  80 +++++++++
 arch/riscv/kernel/sbi.c           |  11 --
 arch/riscv/kernel/smp.c           | 166 ++++++++++---------
 arch/riscv/kernel/smpboot.c       |   5 +-
 arch/riscv/mm/cacheflush.c        |   5 +-
 arch/riscv/mm/tlbflush.c          |  93 +++++++++--
 drivers/clocksource/timer-clint.c |  43 +++--
 drivers/irqchip/irq-riscv-intc.c  |  60 +++----
 include/linux/irq.h               |  18 +++
 kernel/irq/Kconfig                |   5 +
 kernel/irq/Makefile               |   1 +
 kernel/irq/ipi-mux.c              | 260 ++++++++++++++++++++++++++++++
 19 files changed, 667 insertions(+), 167 deletions(-)
 create mode 100644 arch/riscv/kernel/sbi-ipi.c
 create mode 100644 kernel/irq/ipi-mux.c

-- 
2.34.1

