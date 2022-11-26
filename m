Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF17639772
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 18:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiKZRfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 12:35:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiKZRfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 12:35:05 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FBB1D674
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 09:35:04 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id b4so6741052pfb.9
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 09:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NFx7rRBV8oprEfQqy4eCQjV+Bi5CA0WYPRApio+E1/c=;
        b=Pjc3EAF8RwrjDavr7VAUI73u1dkvIEjj+nd1I7F7wcJgJvVeoqLxQY1Vsr0u5RcuPT
         4InGSm2pwGYCJ9YVyui0cDdOrpAR4XHf9fUAeQL0lQjGC7QWeiEJHbh2YdMrEPxciL8k
         VwkDCYdkRsENKJiSIQfgmkVef01gjFiiszfsLugqa3cj2bxKSb+2svcfNYFdZSS+Y6aW
         UP/CxfPk/tglIbD03u/0zJA5PVKXs/UvgRbHsqdfUac/liP9w69alI0T/MvRQQ6b5Rmn
         ChPJgz7MvJ/Ou9ZJ7Pu+2o5RYyrwZWI+byVla3oytuC7Lx69uNQRiEcgAqDdff841YWD
         Bizw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NFx7rRBV8oprEfQqy4eCQjV+Bi5CA0WYPRApio+E1/c=;
        b=ffWkRdB6AFZtT6r7kpAFcA8YjD6odZYiX2Cys9BdNC/2ax5G4cCxEB56WTmQjbMDlV
         LO0sjTpLbntNeVF2xj3+Cu97PqcKLXINz3r/SHKvHR+KNs1E5iM9omjrCrrC1nHyS0YF
         aDacgwzWuW88Z8u7TZHZTnNNw+HJi2CMAd8rpuqlbsKhRuWfndAL7eXzjNbMyhyGH52U
         1YquMxZK+OKHOWI8YgExMtx2KWn0TLqxd824jQVnd1AzRCZktnbTplrbVvo+yYy3/LyC
         Fp//azGGufT2FpSu3bIqj3Jd/tuFmGdFyYO3KDE9Lt2dHqoklJQhQ7TOhOXzWudrFVH9
         aJsA==
X-Gm-Message-State: ANoB5pm8IWgtdReNIWZI0olQY5y3yvygf5yDSHiIrGPEW0URREgaYj8a
        q72TANI3dx3w/U4JaHn5YRZksw==
X-Google-Smtp-Source: AA0mqf402Klya+cz+a/odRL1ELagSc7iocK5/CONOEGO0iL6jMA3a7IRaQIHirZHCRXzVy8IiP1xJA==
X-Received: by 2002:a63:1f21:0:b0:46b:2bd4:f298 with SMTP id f33-20020a631f21000000b0046b2bd4f298mr23192786pgf.135.1669484103489;
        Sat, 26 Nov 2022 09:35:03 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id u11-20020a170902bf4b00b0017f7c4e260fsm5639813pls.150.2022.11.26.09.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Nov 2022 09:35:03 -0800 (PST)
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
Subject: [PATCH v12 0/7] RISC-V IPI Improvements
Date:   Sat, 26 Nov 2022 23:04:46 +0530
Message-Id: <20221126173453.306088-1-apatel@ventanamicro.com>
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

These patches can also be found in riscv_ipi_imp_v12 branch at:
https://github.com/avpatel/linux.git

Changes since v11:
 - Removed ipi_mux_pre/post_handle() callbacks in PATCH3
 - Removed sturct ipi_mux_ops in PATCH3
 - Removed parent_virq and data pointer from everywhere in PATCH3
 - Removed struct ipi_mux_control in PATCH3
 - Improved function signature of ipi_mux_send() callback in PATCH3
 - Used unsigned type with atomic operation in PATCH3

Changes since v10:
 - Rebased on Linux-6.1-rc5
 - Drop the "!(pending & ibit)" check in ipi_mux_send_mask() of PATCH3
 - Disable local interrupts in ipi_mux_send_mask() of PATCH3 because we
   can be preempted while using a per-CPU temporary variable.

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
 arch/riscv/include/asm/smp.h      |  49 +++++--
 arch/riscv/kernel/Makefile        |   1 +
 arch/riscv/kernel/cpu-hotplug.c   |   3 +-
 arch/riscv/kernel/irq.c           |  21 ++-
 arch/riscv/kernel/sbi-ipi.c       |  86 ++++++++++++
 arch/riscv/kernel/sbi.c           |  11 --
 arch/riscv/kernel/smp.c           | 166 ++++++++++++-----------
 arch/riscv/kernel/smpboot.c       |   5 +-
 arch/riscv/mm/cacheflush.c        |   5 +-
 arch/riscv/mm/tlbflush.c          |  93 ++++++++++---
 drivers/clocksource/timer-clint.c |  58 +++++++--
 drivers/irqchip/Kconfig           |   1 +
 drivers/irqchip/irq-riscv-intc.c  |  60 ++++-----
 include/linux/irq.h               |   4 +
 kernel/irq/Kconfig                |   5 +
 kernel/irq/Makefile               |   1 +
 kernel/irq/ipi-mux.c              | 210 ++++++++++++++++++++++++++++++
 20 files changed, 625 insertions(+), 167 deletions(-)
 create mode 100644 arch/riscv/kernel/sbi-ipi.c
 create mode 100644 kernel/irq/ipi-mux.c

-- 
2.34.1

