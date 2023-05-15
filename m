Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0837023C0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 07:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239000AbjEOFyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 01:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235175AbjEOFxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 01:53:03 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DFB26AE
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 22:50:59 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-51452556acdso8373389a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 22:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1684129859; x=1686721859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xPSUnhfUj53RcidJeP5kL6gGwZHEmDmCHUal6KZm638=;
        b=KkYXPMVJYldDXzlYMdzc07JWsILuYGQeAMIHfrngu72V6abryWThHX527Bvfd4MVSk
         YMaJ5wGLKWQNP7EwwtjOYx0Bf9HmphDyD8Lfh0SAHLummac7h1DJlYj4yKBiudYcIcEF
         w4osqYtf99ETJ7KsEqX2b4FHQxdvjoJDi11gPvMC3MYhahY9hKP/WXuS2h2P3tygrrfB
         x9xWrrV1GXDXxDFTBesTudDEsL5qChVDtcGHhzsBOyUTi119lgWgmH4l9mQws0Fh7wcw
         MUxTlv0ParZd6lf0bGG171wj/9avHRWsDGVNU242sc84wMExSkbyoNh1/YOZ3Xru4s/Y
         jKNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684129859; x=1686721859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xPSUnhfUj53RcidJeP5kL6gGwZHEmDmCHUal6KZm638=;
        b=Y8n5DsGmO56oGDy1PhE/sFt3hwKTqTqkhsbKHptOpOM6W+baFcLEZ++ze7a/nqNik7
         pUlZxNvYX5PI1SSCrWZu9Y4fSCqzk387DPrhK+Hw6zoOBbMNKLZkXYvCny19uOai7EK5
         VorVjivxK9ZYPyXsomxYTThsZAXQ/f4QRQy6KlK6vG9wpk0Fn3/pKmYAr6ftApD/f+lE
         +9zZPJJ3K6RaY1ZbJhxwfI5iF3tVUeE7ecF8O2lICLazjfeImZKE63s2kf/AHXmSRkLX
         nwVLvOSadvW08WR0hZoAmgggHuzK35IhO4EDTzPCDtonxtH/UKT6GxjTiH/Ztym3fJ+Z
         aCFQ==
X-Gm-Message-State: AC+VfDxYWxOE7T5jDSaNz6Hnm2TLWCX7P7zds6iFwB9YhIe0UZl6xzr0
        VZDpxu55AccOWRNK8OtJ7c40WA==
X-Google-Smtp-Source: ACHHUZ5gqjyjY/wyzV1UawFz+Je+eikfLLa2ymtotyaGp3hoDXgBMzNgRFQJABMjgIulkIKr/eAY7w==
X-Received: by 2002:a17:902:a516:b0:1ab:1355:1a45 with SMTP id s22-20020a170902a51600b001ab13551a45mr30869286plq.30.1684129858710;
        Sun, 14 May 2023 22:50:58 -0700 (PDT)
Received: from localhost.localdomain ([106.51.191.118])
        by smtp.gmail.com with ESMTPSA id f10-20020a17090274ca00b001ab28f620d0sm12423277plt.290.2023.05.14.22.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 22:50:58 -0700 (PDT)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-crypto@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        llvm@lists.linux.dev
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Weili Qian <qianweili@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Marc Zyngier <maz@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH V6 12/21] RISC-V: smpboot: Add ACPI support in setup_smp()
Date:   Mon, 15 May 2023 11:19:19 +0530
Message-Id: <20230515054928.2079268-13-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230515054928.2079268-1-sunilvl@ventanamicro.com>
References: <20230515054928.2079268-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable SMP boot on ACPI based platforms by using the RINTC
structures in the MADT table.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/include/asm/acpi.h |  2 +
 arch/riscv/kernel/smpboot.c   | 72 ++++++++++++++++++++++++++++++++++-
 2 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
index 39471759bec1..f71ce21ff684 100644
--- a/arch/riscv/include/asm/acpi.h
+++ b/arch/riscv/include/asm/acpi.h
@@ -64,6 +64,8 @@ struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu);
 u32 get_acpi_id_for_cpu(int cpu);
 int acpi_get_riscv_isa(struct acpi_table_header *table,
 		       unsigned int cpu, const char **isa);
+
+static inline int acpi_numa_get_nid(unsigned int cpu) { return NUMA_NO_NODE; }
 #else
 static inline void acpi_init_rintc_map(void) { }
 static inline struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu)
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index a2e66126b733..67bc5ef3e8b2 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -8,6 +8,7 @@
  * Copyright (C) 2017 SiFive
  */
 
+#include <linux/acpi.h>
 #include <linux/arch_topology.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -70,6 +71,72 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 	}
 }
 
+#ifdef CONFIG_ACPI
+static unsigned int cpu_count = 1;
+
+static int __init acpi_parse_rintc(union acpi_subtable_headers *header, const unsigned long end)
+{
+	unsigned long hart;
+	static bool found_boot_cpu;
+	struct acpi_madt_rintc *processor = (struct acpi_madt_rintc *)header;
+
+	/*
+	 * Each RINTC structure in MADT will have a flag. If ACPI_MADT_ENABLED
+	 * bit in the flag is not enabled, it means OS should not try to enable
+	 * the cpu to which RINTC belongs.
+	 */
+	if (!(processor->flags & ACPI_MADT_ENABLED))
+		return 0;
+
+	if (BAD_MADT_ENTRY(processor, end))
+		return -EINVAL;
+
+	acpi_table_print_madt_entry(&header->common);
+
+	hart = processor->hart_id;
+	if (hart == INVALID_HARTID) {
+		pr_warn("Invalid hartid\n");
+		return 0;
+	}
+
+	if (hart == cpuid_to_hartid_map(0)) {
+		BUG_ON(found_boot_cpu);
+		found_boot_cpu = true;
+		early_map_cpu_to_node(0, acpi_numa_get_nid(cpu_count));
+		return 0;
+	}
+
+	if (cpu_count >= NR_CPUS) {
+		pr_warn("NR_CPUS is too small for the number of ACPI tables.\n");
+		return 0;
+	}
+
+	cpuid_to_hartid_map(cpu_count) = hart;
+	early_map_cpu_to_node(cpu_count, acpi_numa_get_nid(cpu_count));
+	cpu_count++;
+
+	return 0;
+}
+
+static void __init acpi_parse_and_init_cpus(void)
+{
+	int cpuid;
+
+	cpu_set_ops(0);
+
+	acpi_table_parse_madt(ACPI_MADT_TYPE_RINTC, acpi_parse_rintc, 0);
+
+	for (cpuid = 1; cpuid < nr_cpu_ids; cpuid++) {
+		if (cpuid_to_hartid_map(cpuid) != INVALID_HARTID) {
+			cpu_set_ops(cpuid);
+			set_cpu_possible(cpuid, true);
+		}
+	}
+}
+#else
+#define acpi_parse_and_init_cpus(...)	do { } while (0)
+#endif
+
 static void __init of_parse_and_init_cpus(void)
 {
 	struct device_node *dn;
@@ -118,7 +185,10 @@ static void __init of_parse_and_init_cpus(void)
 
 void __init setup_smp(void)
 {
-	of_parse_and_init_cpus();
+	if (acpi_disabled)
+		of_parse_and_init_cpus();
+	else
+		acpi_parse_and_init_cpus();
 }
 
 static int start_secondary_cpu(int cpu, struct task_struct *tidle)
-- 
2.34.1

