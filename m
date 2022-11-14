Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44118627926
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 10:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235862AbiKNJjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 04:39:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236860AbiKNJjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 04:39:37 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83BF1D327
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 01:39:33 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id cn2-20020a056830658200b0066c74617e3dso6329614otb.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 01:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eV8k2aGjfM7iqdIwfhHzpd30GsE9w9UeElnqo1gOQMU=;
        b=PJ8CFMjLrMeXPyAd586Fg3053DQvr5aHARKbsjoa+CcDf+8TGaztqSNPIYtxw2gIC4
         xXYLM6qr0U2QXRPDAyFR2YRWyG8ELD712G7awrAiVo+s8xx8vFRJkxqjGrCU0Toz6YUw
         1vnqBxMCTbdK0RN1kb01+umMio8+hzNEXQUCpePh0UwgDx96F5isodwttkrqlG0CS82Q
         J+HA22Z22L6zjVjc+2yGwvr3/xSczNvYilUMZp+hMcsMv756tM9O3jqotAw3oQ4Sj3+Z
         yxDgZn9Kd3PnpitqMFfCZkJSKyhyI6ERAkqKMFcm/oNcz7wq53kRPuAsJS3LjHZKrsu5
         fujA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eV8k2aGjfM7iqdIwfhHzpd30GsE9w9UeElnqo1gOQMU=;
        b=y7XmtJ4R4G+lYPYahJ1nHBRHWNQReeYAQfrTd9kA23FQAJFDYEVDGLUqTL22Z3W0Zr
         SWT2vQipeTwCtpwL1CMC/x+oXnv1uv8cWOUKkfsdZP3VDvTszVc0pierpZ8qnR7JCJ+G
         /+nvfE+hpnvBjgQH10axhxdSTZsTpKY+7ammDWZMnwqMzDBjs6SOpGVrXzjofFvMJOQl
         4qogsNd308dEQNp1MDZWSIuIFhgX17PgVA9ktzBWIA+73x7Q45w7e+/EZKxEdiryY/wa
         dqzpq0y1J2GxoNV99e6+y+BCJCbhDClZ0MPY3uxjY/a+6N+p17Q59TuvZgQvDS0Urawq
         k6rA==
X-Gm-Message-State: ANoB5pkYk4hdEDQbBLURx6S8wREDllkg99ewk6wuF4fvRJSWh0DWYFZb
        zjXN7voRoNCn0Up5S4aSmJCKLA==
X-Google-Smtp-Source: AA0mqf6hyKNfScoz1m6kuaiyz6qHJRU0MZqU3fbehjJHjEM2TSQwzjqHQnG70FCzgKA8tiZWHODOhQ==
X-Received: by 2002:a9d:6e8c:0:b0:637:28be:7934 with SMTP id a12-20020a9d6e8c000000b0063728be7934mr5953269otr.107.1668418773132;
        Mon, 14 Nov 2022 01:39:33 -0800 (PST)
Received: from anup-ubuntu64-vm.. ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id l12-20020a4ae38c000000b0049f3bdd791esm3222677oov.26.2022.11.14.01.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 01:39:32 -0800 (PST)
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
Subject: [PATCH v11 0/7] RISC-V IPI Improvements
Date:   Mon, 14 Nov 2022 15:08:57 +0530
Message-Id: <20221114093904.1669461-1-apatel@ventanamicro.com>
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

These patches can also be found in riscv_ipi_imp_v11 branch at:
https://github.com/avpatel/linux.git

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
 arch/riscv/include/asm/smp.h      |  49 ++++--
 arch/riscv/kernel/Makefile        |   1 +
 arch/riscv/kernel/cpu-hotplug.c   |   3 +-
 arch/riscv/kernel/irq.c           |  21 ++-
 arch/riscv/kernel/sbi-ipi.c       |  80 +++++++++
 arch/riscv/kernel/sbi.c           |  11 --
 arch/riscv/kernel/smp.c           | 166 +++++++++---------
 arch/riscv/kernel/smpboot.c       |   5 +-
 arch/riscv/mm/cacheflush.c        |   5 +-
 arch/riscv/mm/tlbflush.c          |  93 +++++++++--
 drivers/clocksource/timer-clint.c |  43 +++--
 drivers/irqchip/irq-riscv-intc.c  |  60 +++----
 include/linux/irq.h               |  18 ++
 kernel/irq/Kconfig                |   5 +
 kernel/irq/Makefile               |   1 +
 kernel/irq/ipi-mux.c              | 268 ++++++++++++++++++++++++++++++
 19 files changed, 675 insertions(+), 167 deletions(-)
 create mode 100644 arch/riscv/kernel/sbi-ipi.c
 create mode 100644 kernel/irq/ipi-mux.c

-- 
2.34.1

