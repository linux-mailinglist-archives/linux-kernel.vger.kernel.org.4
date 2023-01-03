Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7BD65C197
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 15:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237859AbjACONR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 09:13:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237847AbjACONC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 09:13:02 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE4411470
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 06:13:00 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id jl4so26426473plb.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 06:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LpOGLHCCze3Qrz0T2fIbHYDVqeXz60uKcyL+jWZhlg8=;
        b=UYZ4t90Kwc4TJhHwVS4LeCURIv27178l+3wPhgqNJrChuixgNRsyoV2x7DAQqtF57r
         X9XApiI4KUt+GwjAdvs6HJVo5NHQ4vRg55KQgyCOdtIsLrnT9sgeJuYQhR/2XweG69Z2
         rMjbyT/DjuVFkgYljXkWSeTBTqaQsriid+eqgBnAg/LA6g3+DIQALDa8JMikZadf3WJg
         g4eKw0fqPWMq5dZkRabV46Zii8SMq1K6G29d4SHfjwYqtXGp9tvxKcE5CsJGr8MWhHxn
         RK/n+7srKVAoYZqsLiorHeFQUPeMwR3oiINN8n/wQotWQ+oHPgh1yLGP7P67oO36RaqA
         wQ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LpOGLHCCze3Qrz0T2fIbHYDVqeXz60uKcyL+jWZhlg8=;
        b=DtYnEM6cWMishaKB4+y1JyHZd4NRokI4Rfl3hem36o9v8n0jH7hEWvG3MvLs+vzoix
         WQKtQQ7lfkImFfDEyOhA9xnMMwzp4Af3wU3cdP0WBA0DCIVc80y5Y2nJX1ZvmuXOd0Qu
         UM4rE0vtGnAObTid8FrUGP+e4NJCw9uSquPgpqASU2MuSahUPkZK4iz2ZormPQ57tGxM
         OShHcrzodsA3wuFzQmtVpNrU9w1gRAMrc5fE9D2R5wltayy5tG6mbbJxqwTrOMX7asXX
         3JkW8lIhTJ7aDAbANO7E/AiJj3MYIcbIkAxaes2DQ5PusFrBr/GkRXZ45LBB+Gnt57Yk
         Gj9Q==
X-Gm-Message-State: AFqh2krji5SxOvyhbBGvU4Mly1dIV2US10roxiP9JNquVCA5G/pYonvN
        WA/doYLbPKwNab5x3dw6jel9Wg==
X-Google-Smtp-Source: AMrXdXvBmVydsjqVigHSLQaUkXoDfPacX7mbai5MozoCC4s8JLE/D1PuAYNnEchkfa6UqfNL+smqbg==
X-Received: by 2002:a17:902:654e:b0:191:14c1:626c with SMTP id d14-20020a170902654e00b0019114c1626cmr50486044pln.9.1672755180248;
        Tue, 03 Jan 2023 06:13:00 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([171.76.85.241])
        by smtp.gmail.com with ESMTPSA id x16-20020a1709027c1000b00192b0a07891sm8598286pll.101.2023.01.03.06.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 06:12:59 -0800 (PST)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev, Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>
Subject: [PATCH v16 5/9] RISC-V: Allow marking IPIs as suitable for remote FENCEs
Date:   Tue,  3 Jan 2023 19:42:17 +0530
Message-Id: <20230103141221.772261-6-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230103141221.772261-1-apatel@ventanamicro.com>
References: <20230103141221.772261-1-apatel@ventanamicro.com>
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
index 4fe7a8854c2e..c4b77017ec58 100644
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
 
 /* Check other CPUs stop or not */
 bool smp_crash_stop_failed(void);
@@ -96,10 +104,16 @@ static inline bool riscv_ipi_have_virq_range(void)
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
index 41981ab88493..a4559695ce62 100644
--- a/arch/riscv/kernel/sbi-ipi.c
+++ b/arch/riscv/kernel/sbi-ipi.c
@@ -72,6 +72,6 @@ void __init sbi_ipi_init(void)
 			  "irqchip/sbi-ipi:starting",
 			  sbi_ipi_starting_cpu, NULL);
 
-	riscv_ipi_set_virq_range(virq, BITS_PER_BYTE);
+	riscv_ipi_set_virq_range(virq, BITS_PER_BYTE, false);
 	pr_info("providing IPIs using SBI IPI extension\n");
 }
diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index 47e7ecfedb4d..5f985a197eff 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -177,7 +177,10 @@ bool riscv_ipi_have_virq_range(void)
 	return (ipi_virq_base) ? true : false;
 }
 
-void riscv_ipi_set_virq_range(int virq, int nr)
+DEFINE_STATIC_KEY_FALSE(riscv_ipi_for_rfence);
+EXPORT_SYMBOL_GPL(riscv_ipi_for_rfence);
+
+void riscv_ipi_set_virq_range(int virq, int nr, bool use_for_rfence)
 {
 	int i, err;
 
@@ -200,6 +203,12 @@ void riscv_ipi_set_virq_range(int virq, int nr)
 
 	/* Enabled IPIs for boot CPU immediately */
 	riscv_ipi_enable();
+
+	/* Update RFENCE static key */
+	if (use_for_rfence)
+		static_branch_enable(&riscv_ipi_for_rfence);
+	else
+		static_branch_disable(&riscv_ipi_for_rfence);
 }
 
 static const char * const ipi_names[] = {
diff --git a/drivers/clocksource/timer-clint.c b/drivers/clocksource/timer-clint.c
index 7ccc16dd6a76..9a55e733ae99 100644
--- a/drivers/clocksource/timer-clint.c
+++ b/drivers/clocksource/timer-clint.c
@@ -251,7 +251,7 @@ static int __init clint_timer_init_dt(struct device_node *np)
 	}
 
 	irq_set_chained_handler(clint_ipi_irq, clint_ipi_interrupt);
-	riscv_ipi_set_virq_range(rc, BITS_PER_BYTE);
+	riscv_ipi_set_virq_range(rc, BITS_PER_BYTE, true);
 	clint_clear_ipi();
 #endif
 
-- 
2.34.1

