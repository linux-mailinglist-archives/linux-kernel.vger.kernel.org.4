Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C846E6818E8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 19:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238030AbjA3SZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 13:25:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238065AbjA3SYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 13:24:33 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E8845BC7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 10:23:39 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id e8-20020a17090a9a8800b0022c387f0f93so11348925pjp.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 10:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RoNsoxjlD8YqMSH0pVqFEhvuCFLj9XoDBF5p4r2NIfw=;
        b=iDP9c7ApKkeB+Xt1IY5/R1iq7FKDBdju6Gcvu0MaOJbVMwIYqvi+FcQp3Rhci/cc5J
         KoQD04jyy6VO99ZWoK4TcBtQinWwKlBtUXVq3L7bE9PuU/ZVfJG9ZCmXLl+WB4X4i4VW
         BQpf68cV9//tP+mZrgsx+74mDrgOxMSmF+WLXD/OqoqKebupmq+dwbG9DqtQJs/RxbTS
         8jSuMpnxiU8ENHw7dfJQKKAbDN77oYx8eR8SpY8zpqyoTO6+8cAjE6RwhM5HRoLPSZFa
         LiT0HjazTXTYtwFYqfZkPowj9WignKTXYrWH5vPlbv3ghQ6swvcBM1zRLcTrjOuNKGfX
         v3rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RoNsoxjlD8YqMSH0pVqFEhvuCFLj9XoDBF5p4r2NIfw=;
        b=eYWmUSyzU2ZSBH+eQC7eYLer3UATT837Hu/qJaGUoqkbSJEGP0vXH1G4DPcIKAPAnA
         J9an8pIG8iCGMI+2wZXIFrmdyXtTyOQejrQhucyA3/NSfWB3WMLYnkoc2Nmot8useTJe
         agE64D9giOHSlEazqqk+4SuPWecQ7FBZZqj+NK8D5dy7rDvUyTXzvUuZTcnEyPHFftLD
         sqS4abwnFNcXSBl1sia5H+IHa1eS27A2KMTpkbLU+X4Pmqk0L9cc+fXGESWZa2reIV2V
         Zl3QOxN6ou+d6pVg0Fmy+mZnEtNTW+eP/bAGIh7gGYc6ZkjsNKOidn40yqiafyIwa2cL
         HD7w==
X-Gm-Message-State: AFqh2krV4IQ8QS/YuAHnj13YwesFvCchahgnBr5dXtZkuX6OPWKQ0rV1
        8HOah7cywGm3Ul/Z7dne4xqutw==
X-Google-Smtp-Source: AMrXdXsri6EFFpQDUL2InJo9z3j/bCDEJMfcZoHWyztBdQ136ASsttq8Z8Ti99sjosyysKb91k/I5w==
X-Received: by 2002:a05:6a20:8f02:b0:af:c871:bf4b with SMTP id b2-20020a056a208f0200b000afc871bf4bmr70215553pzk.26.1675103018053;
        Mon, 30 Jan 2023 10:23:38 -0800 (PST)
Received: from kerodipc.Dlink ([49.206.9.96])
        by smtp.gmail.com with ESMTPSA id j193-20020a638bca000000b00478162d9923sm7000291pge.13.2023.01.30.10.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 10:23:37 -0800 (PST)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH 14/24] RISC-V: ACPI: smpboot: Add function to retrieve the hartid
Date:   Mon, 30 Jan 2023 23:52:15 +0530
Message-Id: <20230130182225.2471414-15-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20230130182225.2471414-1-sunilvl@ventanamicro.com>
References: <20230130182225.2471414-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hartid is in RINTC structuire in MADT table. Instead of parsing
the ACPI table every time we need for a cpu, cache it and provide
a function to read it.

This is similar to acpi_get_madt_gicc() in arm64.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 arch/riscv/include/asm/acpi.h | 14 +++++++++++++-
 arch/riscv/kernel/smpboot.c   | 21 +++++++++++++++++++++
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
index d1f1e53ec657..69a880b7257a 100644
--- a/arch/riscv/include/asm/acpi.h
+++ b/arch/riscv/include/asm/acpi.h
@@ -65,6 +65,18 @@ int acpi_numa_get_nid(unsigned int cpu);
 static inline int acpi_numa_get_nid(unsigned int cpu) { return NUMA_NO_NODE; }
 #endif /* CONFIG_ACPI_NUMA */
 
-#endif
+struct acpi_madt_rintc *acpi_get_madt_rintc(int cpu);
+struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu);
+static inline u32 get_acpi_id_for_cpu(int cpu)
+{
+	return	acpi_cpu_get_madt_rintc(cpu)->uid;
+}
+#else
+static inline u32 get_acpi_id_for_cpu(int cpu)
+{
+	return -1;
+}
+
+#endif /* CONFIG_ACPI */
 
 #endif /*_ASM_ACPI_H*/
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index e48cf88d0bc1..3a8b7a9eb5ac 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -73,6 +73,25 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 
 #ifdef CONFIG_ACPI
 static unsigned int cpu_count = 1;
+static unsigned int intc_count;
+static struct acpi_madt_rintc cpu_madt_rintc[NR_CPUS];
+
+struct acpi_madt_rintc *acpi_get_madt_rintc(int cpu)
+{
+	return &cpu_madt_rintc[cpu];
+}
+
+struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu)
+{
+	int i;
+
+	for (i = 0; i < NR_CPUS; i++) {
+		if (riscv_hartid_to_cpuid(cpu_madt_rintc[i].hart_id) == cpu)
+			return &cpu_madt_rintc[i];
+	}
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(acpi_cpu_get_madt_rintc);
 
 static int __init
 acpi_parse_rintc(union acpi_subtable_headers *header,
@@ -92,6 +111,8 @@ acpi_parse_rintc(union acpi_subtable_headers *header,
 	hart = processor->hart_id;
 	if (hart < 0)
 		return 0;
+
+	cpu_madt_rintc[intc_count++] = *processor;
 	if (hart == cpuid_to_hartid_map(0)) {
 		BUG_ON(found_boot_cpu);
 		found_boot_cpu = 1;
-- 
2.38.0

