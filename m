Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F3063C269
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 15:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235633AbiK2OZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 09:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235383AbiK2OZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 09:25:23 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A851824F1B
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 06:25:19 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d18so2754220pls.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 06:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qe57EoQBO7kaxIm5DHEr+NjxUNyA/iTv7lBLEurKYJw=;
        b=BT1N+o1wuVcSfqUyqn3ANFvHK2WDducnvVp/0T4W7XCLFj4OFsj1omPHHRMovKFtSs
         st6gX2x11fW3xzYkhgLxCp/Kv51r8j7y/XdVVDUGjnVyM51gO4t8sKpRSYi/Mui0gnny
         Kctm+LKfaJhU2hCiGT8WPzESIGf6CC4mYWZwQrrPQkn8Z0HxAQq1Hu/9JEUn3fQ/XjVL
         cUHZoYHInoC+BrMdFKrs+UPyCD3RGKhPoQYxPXM2TTOZ+JbVR7Jp1pf1QHcFXPGKbyTA
         FNH+C18eu5VOuXYG7T408lYkkxdcxDfEiPB3mqSvpzLERsqo4KafIEovrMc2kCgb/+5Y
         1OmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qe57EoQBO7kaxIm5DHEr+NjxUNyA/iTv7lBLEurKYJw=;
        b=30EObsDNvz0+RKVSUMn/1MiYx+IcnzYB2cbgDGeCBkVDlzaLgpijPDTf4F4ogVMC0A
         VEa5yGWVEpjtJOfR8Q2QNeMZ43g1dTV+r3n2k4RVzkXfBTjtQXcVnADjx9U8/dZLa1Rv
         pfiQj6qPTSL1X8THFNQAdySItoSQv6zUv2PPeq5IWXP8I07wzVt1pkgLdVgqA9hoSO5S
         oS/Uu8ZMSHVzQTHxfeUl6er57SypNlWcgLICiwHyrnzwj7RUAmbF+aHR59r7Gg7wCRd1
         s15Zq2LSbUkfQLxEE8DwwBgM5nPm4N7aFW90d+vQGvBz+5QriyA7yy5jpGEhdw0nz+u3
         H7Hg==
X-Gm-Message-State: ANoB5pmQqNWQmW5TBJmbYJAMeCgsYEZClxUvs3d7UnplOHAnteQyVgad
        HE3Whd1XIv1+Ov4EzCXsPvF62Q==
X-Google-Smtp-Source: AA0mqf4Mi+h8Bb7reeupkyZycc5+cz9JHv+7jDVNydR7H/mgu9bxKKI0ugkTmaIBAg0t02li4t43yw==
X-Received: by 2002:a17:90b:438a:b0:218:f733:d9c7 with SMTP id in10-20020a17090b438a00b00218f733d9c7mr28409108pjb.221.1669731919082;
        Tue, 29 Nov 2022 06:25:19 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([171.76.84.98])
        by smtp.gmail.com with ESMTPSA id l12-20020a170903120c00b00176a2d23d1asm11039076plh.56.2022.11.29.06.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 06:25:18 -0800 (PST)
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
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>
Subject: [PATCH v13 5/7] RISC-V: Allow marking IPIs as suitable for remote FENCEs
Date:   Tue, 29 Nov 2022 19:54:47 +0530
Message-Id: <20221129142449.886518-6-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221129142449.886518-1-apatel@ventanamicro.com>
References: <20221129142449.886518-1-apatel@ventanamicro.com>
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

To do remote FENCEs (i.e. remote TLB flushes) using IPI calls on the
RISC-V kernel, we need hardware mechanism to directly inject IPI from
the supervisor mode (i.e. RISC-V kernel) instead of using SBI calls.

The upcoming AIA IMSIC devices allow direct IPI injection from the
supervisor mode (i.e. RISC-V kernel). To support this, we extend the
riscv_ipi_set_virq_range() function so that IPI provider (i.e. irqchip
drivers can mark IPIs as suitable for remote FENCEs.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/smp.h      | 18 ++++++++++++++++--
 arch/riscv/kernel/sbi-ipi.c       |  2 +-
 arch/riscv/kernel/smp.c           | 11 ++++++++++-
 drivers/clocksource/timer-clint.c |  2 +-
 4 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
index 79ed0b73cd4e..56976e41a21e 100644
--- a/arch/riscv/include/asm/smp.h
+++ b/arch/riscv/include/asm/smp.h
@@ -16,6 +16,9 @@ struct seq_file;
 extern unsigned long boot_cpu_hartid;
 
 #ifdef CONFIG_SMP
+
+#include <linux/jump_label.h>
+
 /*
  * Mapping between linux logical cpu index and hartid.
  */
@@ -46,7 +49,12 @@ void riscv_ipi_disable(void);
 bool riscv_ipi_have_virq_range(void);
 
 /* Set the IPI interrupt numbers for arch (called by irqchip drivers) */
-void riscv_ipi_set_virq_range(int virq, int nr);
+void riscv_ipi_set_virq_range(int virq, int nr, bool use_for_rfence);
+
+/* Check if we can use IPIs for remote FENCEs */
+DECLARE_STATIC_KEY_FALSE(riscv_ipi_for_rfence);
+#define riscv_use_ipi_for_rfence() \
+	static_branch_unlikely(&riscv_ipi_for_rfence)
 
 /* Secondary hart entry */
 asmlinkage void smp_callin(void);
@@ -93,10 +101,16 @@ static inline bool riscv_ipi_have_virq_range(void)
 	return false;
 }
 
-static inline void riscv_ipi_set_virq_range(int virq, int nr)
+static inline void riscv_ipi_set_virq_range(int virq, int nr,
+					    bool use_for_rfence)
 {
 }
 
+static inline bool riscv_use_ipi_for_rfence(void)
+{
+	return false;
+}
+
 #endif /* CONFIG_SMP */
 
 #if defined(CONFIG_HOTPLUG_CPU) && (CONFIG_SMP)
diff --git a/arch/riscv/kernel/sbi-ipi.c b/arch/riscv/kernel/sbi-ipi.c
index 6466706b03a7..efe18de74e95 100644
--- a/arch/riscv/kernel/sbi-ipi.c
+++ b/arch/riscv/kernel/sbi-ipi.c
@@ -76,6 +76,6 @@ void __init sbi_ipi_init(void)
 			  "irqchip/sbi-ipi:starting",
 			  sbi_ipi_starting_cpu, sbi_ipi_dying_cpu);
 
-	riscv_ipi_set_virq_range(virq, BITS_PER_BYTE);
+	riscv_ipi_set_virq_range(virq, BITS_PER_BYTE, false);
 	pr_info("providing IPIs using SBI IPI extension\n");
 }
diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index e8a20454d65b..74b8cb1a89ab 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -145,7 +145,10 @@ bool riscv_ipi_have_virq_range(void)
 	return (ipi_virq_base) ? true : false;
 }
 
-void riscv_ipi_set_virq_range(int virq, int nr)
+DEFINE_STATIC_KEY_FALSE(riscv_ipi_for_rfence);
+EXPORT_SYMBOL_GPL(riscv_ipi_for_rfence);
+
+void riscv_ipi_set_virq_range(int virq, int nr, bool use_for_rfence)
 {
 	int i, err;
 
@@ -168,6 +171,12 @@ void riscv_ipi_set_virq_range(int virq, int nr)
 
 	/* Enabled IPIs for boot CPU immediately */
 	riscv_ipi_enable();
+
+	/* Update RFENCE static key */
+	if (use_for_rfence)
+		static_branch_enable(&riscv_ipi_for_rfence);
+	else
+		static_branch_disable(&riscv_ipi_for_rfence);
 }
 EXPORT_SYMBOL_GPL(riscv_ipi_set_virq_range);
 
diff --git a/drivers/clocksource/timer-clint.c b/drivers/clocksource/timer-clint.c
index 9877b4b1c9e9..eb23da3054b8 100644
--- a/drivers/clocksource/timer-clint.c
+++ b/drivers/clocksource/timer-clint.c
@@ -248,7 +248,7 @@ static int __init clint_timer_init_dt(struct device_node *np)
 		goto fail_free_irq;
 	}
 
-	riscv_ipi_set_virq_range(rc, BITS_PER_BYTE);
+	riscv_ipi_set_virq_range(rc, BITS_PER_BYTE, true);
 	clint_clear_ipi();
 #endif
 
-- 
2.34.1

