Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD566A98AF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 14:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbjCCNix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 08:38:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbjCCNiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 08:38:25 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC0A41CAE2
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 05:37:50 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id x20-20020a17090a8a9400b00233ba727724so5648236pjn.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 05:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1677850668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hQCnSR2uhLGdQyOkOFgSQ8VeHxY3xwdVpRHCeTeD8ew=;
        b=NMLEUSb82IGQQhW0x4NPkapm0Psw8L1OGm/oPdiLRtWhywKWeyx7vPddrp7pmxBHe7
         bt5qBneS3lUdBhyL/Sj7skxxrBiPGzbKutT2c1sDQ448f2THTSxlpoOVfoe0QRtLRFfo
         wCd/WBraJKU65Z1HuVm12PFLXP0bexX+t2YC2UWXCZL1rJhe29HhZ84piDer3bXS8F4A
         JSJ0VA2CCJn6Fii9M5rDYYuqyB8z9ru1nPvlI3fI7T1QBDy50itlpY2KT7TLxtbt1x6V
         jqeXBMh9/JV/dWD1M/j1ibj77HWnxaUEwHgELuI7WDbyUO9eQRDj9OjlsZAnIe1xMXSi
         sxRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677850668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hQCnSR2uhLGdQyOkOFgSQ8VeHxY3xwdVpRHCeTeD8ew=;
        b=r6YNHuuQzcMyJTVwvixhDg2z055K8GFXNgkTiZG72To9YCUzCuy6yvEc7T6E2AcSJK
         4RWwdSmr9kulDSvwCNEnKl/4pZsfDrCFgqGaAGhhxWpK3/jEn277T2Vi22cFB1lxiyVg
         RfVRRBfwQ22Hfep3bhAsJWOEIDZkFk33WRYmVdnCVei27g4fHJaTqywufcYZg3oycPRm
         qrdtJmkACgRd/XWLVSIAzXCL8ogKeXKQKC4k/+Sw34Cm8Bl+fnPAlnXWQq+i4M9z2ciZ
         uWjY4F4uYyvi79FF3AH3zfeZOBkjFSSMlD5rq12PyDs0ypdb3NMhmKqylfp0qoX/d8IF
         TdMg==
X-Gm-Message-State: AO0yUKXUrJrBxsBZM60Ar/9F5edYYAWzlIfr5SMBK0XqUqEL78h+vCBr
        4FA2zZ53W5o6CTlGl8Q9D7kJoA==
X-Google-Smtp-Source: AK7set/jmy9dq9epVpz+uP0wD1ybCypEBIE8+NTFo7SLPWfCjJDt2BpAuFqvDUHvsA/phDd7zfgESg==
X-Received: by 2002:a17:902:ec88:b0:19a:e762:a1af with SMTP id x8-20020a170902ec8800b0019ae762a1afmr5549833plg.33.1677850668422;
        Fri, 03 Mar 2023 05:37:48 -0800 (PST)
Received: from localhost.localdomain ([49.206.14.226])
        by smtp.gmail.com with ESMTPSA id m9-20020a170902768900b0019ac5d3ee9dsm1533125pll.157.2023.03.03.05.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 05:37:48 -0800 (PST)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        'Conor Dooley ' <conor.dooley@microchip.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH V3 11/20] RISC-V: ACPI: Cache and retrieve the RINTC structure
Date:   Fri,  3 Mar 2023 19:06:38 +0530
Message-Id: <20230303133647.845095-12-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230303133647.845095-1-sunilvl@ventanamicro.com>
References: <20230303133647.845095-1-sunilvl@ventanamicro.com>
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

RINTC structures in the MADT provide mapping between the hartid
and the CPU. This is required many times even at run time like
cpuinfo. So, instead of parsing the ACPI table every time, cache
the RINTC structures and provide a function to get the correct
RINTC structure for a given cpu.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 arch/riscv/include/asm/acpi.h |  9 ++++++
 arch/riscv/kernel/acpi.c      | 56 +++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
index 111a8ed10af1..8be16c1ef7da 100644
--- a/arch/riscv/include/asm/acpi.h
+++ b/arch/riscv/include/asm/acpi.h
@@ -61,6 +61,10 @@ static inline void arch_fix_phys_package_id(int num, u32 slot) { }
 
 int acpi_get_riscv_isa(struct acpi_table_header *table,
 		       unsigned int cpu, const char **isa);
+
+struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu);
+
+u32 get_acpi_id_for_cpu(int cpu);
 #else
 static inline int acpi_get_riscv_isa(struct acpi_table_header *table,
 				     unsigned int cpu, const char **isa)
@@ -68,6 +72,11 @@ static inline int acpi_get_riscv_isa(struct acpi_table_header *table,
 	return -EINVAL;
 }
 
+static inline u32 get_acpi_id_for_cpu(int cpu)
+{
+	return -1;
+}
+
 #endif /* CONFIG_ACPI */
 
 #endif /*_ASM_ACPI_H*/
diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
index 81d448c41714..8b3d68d8225f 100644
--- a/arch/riscv/kernel/acpi.c
+++ b/arch/riscv/kernel/acpi.c
@@ -24,6 +24,62 @@ EXPORT_SYMBOL(acpi_disabled);
 int acpi_pci_disabled = 1;	/* skip ACPI PCI scan and IRQ initialization */
 EXPORT_SYMBOL(acpi_pci_disabled);
 
+static struct acpi_madt_rintc cpu_madt_rintc[NR_CPUS];
+
+static int acpi_parse_madt_rintc(union acpi_subtable_headers *header, const unsigned long end)
+{
+	struct acpi_madt_rintc *rintc = (struct acpi_madt_rintc *)header;
+	int cpuid;
+
+	if (!(rintc->flags & ACPI_MADT_ENABLED))
+		return 0;
+
+	cpuid = riscv_hartid_to_cpuid(rintc->hart_id);
+	if (cpuid >= 0 && cpuid < NR_CPUS)
+		cpu_madt_rintc[cpuid] = *rintc;
+
+	return 0;
+}
+
+static int acpi_init_rintc_array(void)
+{
+	if (acpi_table_parse_madt(ACPI_MADT_TYPE_RINTC, acpi_parse_madt_rintc, 0) > 0)
+		return 0;
+
+	return -ENODEV;
+}
+
+/*
+ * Instead of parsing (and freeing) the ACPI table, cache
+ * the RINTC structures since they are frequently used
+ * like in  cpuinfo.
+ */
+struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu)
+{
+	static bool rintc_init_done;
+
+	if (!rintc_init_done) {
+		if (acpi_init_rintc_array()) {
+			pr_err("No valid RINTC entries exist\n");
+			return NULL;
+		}
+
+		rintc_init_done = true;
+	}
+
+	return &cpu_madt_rintc[cpu];
+}
+
+u32 get_acpi_id_for_cpu(int cpu)
+{
+	struct acpi_madt_rintc *rintc = acpi_cpu_get_madt_rintc(cpu);
+
+	if (!rintc)
+		return -1;
+
+	return rintc->uid;
+}
+
 /*
  * __acpi_map_table() will be called before paging_init(), so early_ioremap()
  * or early_memremap() should be called here to for ACPI table mapping.
-- 
2.34.1

