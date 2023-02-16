Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1382A699C29
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 19:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjBPSWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 13:22:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjBPSWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 13:22:14 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B4F50ADD
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 10:21:46 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id bx22so2712451pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 10:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GipxeDCOyjMj8YF40M4Hg7LI5rDefQ4n1sWRXQ5Wf4A=;
        b=eEFXo/GfQ56r4rtPgsxzNpFtJ23EjjcqYMMKhNbgLjE2Uuuy6P1bpuyH7mca/UbFYP
         aBNx3N2EIanq/lyuvYX2QMPg6Z1XipqO6QH1D/VjXzNzHfwBixUTZ/HkyjgfC9haFo78
         Y12zsDunSkOjC4xURoqcxMZVCuD9ZLuBo70InXbPD6zU79CNTJXTYKIqcnJ1InzY+flJ
         //f7yL3N67uDxSS8o5mkf0Pe86BtKQRee5sbU4av6NbYmLZowEkxCR9khQ3johCdCu8S
         KY1xIiFS6em7YokS3n0jAZZwM4ZAuhjIaWBjjPllKiungJ3uK7QAE9DuaATKsqxVIfyc
         phdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GipxeDCOyjMj8YF40M4Hg7LI5rDefQ4n1sWRXQ5Wf4A=;
        b=46mEJe8olB0Gb6FWWcDsGiFrqouJCYesTnxfoXgE12KTCcHm6XQqSWWwQm8H95Q17/
         ZOGgQsdAi4alWXLXb099SbZxV4N8mHgUlZXHh2UxAHlKi5mRo8zpm59JyoS9DuMygRTn
         wRIpdTnTI967X7EsyHRYvs5B6BgivMCBAhOVLAINQFrlT5BFC+VOQRwZyg/rpsx/yoZb
         1JK0wNxyJp3HsIABirl7Tm33rwxJpR1NgLwrgEB9auLP4egMhNBbL89wHb4soCrXZ4y+
         72pb44qu+qx20nOF7BSHRssxhrOpyUUl1Q1mduMXcP8eTZxBMQ2I5w7NKCog3ME4bHFW
         QBlA==
X-Gm-Message-State: AO0yUKVUXywJj0lz6iYy8vaA/GIvwnF9im8g5Ty9hUVvolaBVxAyrX7w
        WfoUsFAuO2t34LDxpEAyxiasxg==
X-Google-Smtp-Source: AK7set9k9++/QzvIRe1B3IRDZ869l6XRxNCvE+UR28XP1HGqhzjPmFL0xkUQqSpERzooLyWBhEFXjg==
X-Received: by 2002:a05:6a20:6a0c:b0:9f:3197:bfa1 with SMTP id p12-20020a056a206a0c00b0009f3197bfa1mr7989098pzk.7.1676571705447;
        Thu, 16 Feb 2023 10:21:45 -0800 (PST)
Received: from kerodi.Dlink ([49.206.14.226])
        by smtp.gmail.com with ESMTPSA id n21-20020a637215000000b004dff15fc121sm1517574pgc.36.2023.02.16.10.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 10:21:45 -0800 (PST)
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
        Sunil V L <sunilvl@ventanamicro.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH V2 11/21] RISC-V: ACPI: Add a function to retrieve the hartid
Date:   Thu, 16 Feb 2023 23:50:33 +0530
Message-Id: <20230216182043.1946553-12-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230216182043.1946553-1-sunilvl@ventanamicro.com>
References: <20230216182043.1946553-1-sunilvl@ventanamicro.com>
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

The hartid is in the RINTC structure of the MADT table. Instead of
parsing the ACPI table every time, cache it and provide a function
to read it.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 arch/riscv/include/asm/acpi.h |  8 +++++
 arch/riscv/kernel/acpi.c      | 55 +++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
index 3c3a8ac3b37a..b9d7b713fb43 100644
--- a/arch/riscv/include/asm/acpi.h
+++ b/arch/riscv/include/asm/acpi.h
@@ -67,6 +67,9 @@ int acpi_numa_get_nid(unsigned int cpu);
 static inline int acpi_numa_get_nid(unsigned int cpu) { return NUMA_NO_NODE; }
 #endif /* CONFIG_ACPI_NUMA */
 
+struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu);
+
+u32 get_acpi_id_for_cpu(int cpu);
 #else
 static inline int acpi_get_riscv_isa(struct acpi_table_header *table,
 				     unsigned int cpu, const char **isa)
@@ -74,6 +77,11 @@ static inline int acpi_get_riscv_isa(struct acpi_table_header *table,
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
index 81d448c41714..13b26c87c136 100644
--- a/arch/riscv/kernel/acpi.c
+++ b/arch/riscv/kernel/acpi.c
@@ -24,6 +24,61 @@ EXPORT_SYMBOL(acpi_disabled);
 int acpi_pci_disabled = 1;	/* skip ACPI PCI scan and IRQ initialization */
 EXPORT_SYMBOL(acpi_pci_disabled);
 
+static unsigned int intc_count;
+static struct acpi_madt_rintc cpu_madt_rintc[NR_CPUS];
+
+static int acpi_parse_madt_rintc(union acpi_subtable_headers *header, const unsigned long end)
+{
+	struct acpi_madt_rintc *rintc = (struct acpi_madt_rintc *)header;
+
+	if (!(rintc->flags & ACPI_MADT_ENABLED))
+		return 0;
+
+	cpu_madt_rintc[intc_count++] = *rintc;
+
+	return 0;
+}
+
+static int acpi_init_rintc_array(void)
+{
+	if (acpi_table_parse_madt(ACPI_MADT_TYPE_RINTC, acpi_parse_madt_rintc, 0) > 0)
+		return 0;
+
+	pr_info("No valid RINTC entries exist\n");
+	return -ENODEV;
+}
+
+struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu)
+{
+	static bool rintc_init_done;
+	unsigned int i;
+
+	if (!rintc_init_done) {
+		if (acpi_init_rintc_array()) {
+			pr_err("Failed to initialize RINTC array\n");
+			return NULL;
+		}
+		rintc_init_done = true;
+	}
+
+	for (i = 0; i < intc_count; i++) {
+		if (cpu_madt_rintc[i].hart_id == cpuid_to_hartid_map(cpu))
+			return &cpu_madt_rintc[i];
+	}
+
+	return NULL;
+}
+
+u32 get_acpi_id_for_cpu(int cpu)
+{
+	struct acpi_madt_rintc *rintc = acpi_cpu_get_madt_rintc(cpu);
+
+	if (!rintc)
+		return -1;
+
+	return  rintc->uid;
+}
+
 /*
  * __acpi_map_table() will be called before paging_init(), so early_ioremap()
  * or early_memremap() should be called here to for ACPI table mapping.
-- 
2.34.1

