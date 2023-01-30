Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2605F6818DC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 19:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238142AbjA3SYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 13:24:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238082AbjA3SX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 13:23:59 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5466445BCE
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 10:23:25 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id b24-20020a17090a551800b0022beefa7a23so16360444pji.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 10:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9/7p8mpWwrRZDJ0Ssv5B2rQ0QEcsG8FyQnZGa88XnoU=;
        b=PW+JkRB4EcpFyhCBbGvgqbqLOB8Ov8q0vsn9Z5bbhMkMlF/2+7eW27QVw4YVoMmlyu
         bVamRDgEm2QzEPQk4lCpp0rjmuPrZX/AFddnJcQBQxnflSDDa8CTulnMOTeuSQ94xMmp
         YiJlwQ3EL/bxTVczbemObTMHUVp7/Kb4fQcRLsjDdDTswPYS3tp7Y3qZJ654JLsXQFA+
         sqd5gTjZZNVRseZskZuH+9xzzFXfpYjqF4Rn1CnMFtxi8CwANtVxsa1syuQyzjGS6Kqc
         R5JwHbtjnYh4NIvyUUzEYRdHX40u97uY5TcnrqH3EqEzJcnm2f0zxGAqBoANMRl7MiQT
         E+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9/7p8mpWwrRZDJ0Ssv5B2rQ0QEcsG8FyQnZGa88XnoU=;
        b=FIl1yXrtXIwLWO6c/Oy5mywYha31JKre5EyeHs4qmUT2J2t1wEM+kEuoyVLGJby1LO
         o9Iv/l01tWXMLy5ced5bXfgGdZui2W5Zx/2iXf/VWd5yhyTDWtqRbZUc/NG7aOh2hDjW
         IBrzWpT+V3YyKboi1Tk34glJJitBNS2N8l+e6dCjOA98gjh3W8zQ1QC84ziOFgocwc7S
         7FZ9h4wRe3qDT8S8KVwgkICiJKXOkA6+CmCyu65NmA3I03qG42Qm88vWe3PaRMuAPi1+
         h7lDi+XE5u1WbDFo1heLpqVeG9glJAsuvHw0DpNXvfcFDKCPe2c50c9TMjz4usv7jM2W
         aZ/g==
X-Gm-Message-State: AO0yUKVQTAVIypYJd69ZPF4CwcynRUfETBMo9MA7ADfRcq0MZAF7DY6j
        Gom5vD4fDzPaN9mIY9b3cjsOcA==
X-Google-Smtp-Source: AK7set/O9E/ul7V9nZdfoDMHFdpq19d+UP5/qbcgqnRZAgazc3TW9AomhsBc2fFFKf/jDgy9fCJUrA==
X-Received: by 2002:a17:902:e20c:b0:196:7f9c:6c86 with SMTP id u12-20020a170902e20c00b001967f9c6c86mr4411085plb.45.1675103004634;
        Mon, 30 Jan 2023 10:23:24 -0800 (PST)
Received: from kerodipc.Dlink ([49.206.9.96])
        by smtp.gmail.com with ESMTPSA id j193-20020a638bca000000b00478162d9923sm7000291pge.13.2023.01.30.10.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 10:23:24 -0800 (PST)
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
Subject: [PATCH 11/24] RISC-V: ACPI: irqchip/riscv-intc: Add ACPI support
Date:   Mon, 30 Jan 2023 23:52:12 +0530
Message-Id: <20230130182225.2471414-12-sunilvl@ventanamicro.com>
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

Add support for initializing the RISC-V INTC driver on ACPI based
platforms.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/irqchip/irq-riscv-intc.c | 79 +++++++++++++++++++++++++++-----
 1 file changed, 67 insertions(+), 12 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index f229e3e66387..044ec92fcba7 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -6,6 +6,7 @@
  */
 
 #define pr_fmt(fmt) "riscv-intc: " fmt
+#include <linux/acpi.h>
 #include <linux/atomic.h>
 #include <linux/bits.h>
 #include <linux/cpu.h>
@@ -112,6 +113,30 @@ static struct fwnode_handle *riscv_intc_hwnode(void)
 	return intc_domain->fwnode;
 }
 
+static int __init riscv_intc_init_common(struct fwnode_handle *fn)
+{
+	int rc;
+
+	intc_domain = irq_domain_create_linear(fn, BITS_PER_LONG,
+					       &riscv_intc_domain_ops, NULL);
+	if (!intc_domain) {
+		pr_err("unable to add IRQ domain\n");
+		return -ENXIO;
+	}
+
+	rc = set_handle_irq(&riscv_intc_irq);
+	if (rc) {
+		pr_err("failed to set irq handler\n");
+		return rc;
+	}
+
+	riscv_set_intc_hwnode_fn(riscv_intc_hwnode);
+
+	pr_info("%d local interrupts mapped\n", BITS_PER_LONG);
+
+	return 0;
+}
+
 static int __init riscv_intc_init(struct device_node *node,
 				  struct device_node *parent)
 {
@@ -133,24 +158,54 @@ static int __init riscv_intc_init(struct device_node *node,
 	if (riscv_hartid_to_cpuid(hartid) != smp_processor_id())
 		return 0;
 
-	intc_domain = irq_domain_add_linear(node, BITS_PER_LONG,
-					    &riscv_intc_domain_ops, NULL);
-	if (!intc_domain) {
-		pr_err("unable to add IRQ domain\n");
-		return -ENXIO;
-	}
-
-	rc = set_handle_irq(&riscv_intc_irq);
+	rc = riscv_intc_init_common(of_node_to_fwnode(node));
 	if (rc) {
-		pr_err("failed to set irq handler\n");
+		pr_err("failed to initialize INTC\n");
 		return rc;
 	}
 
-	riscv_set_intc_hwnode_fn(riscv_intc_hwnode);
+	return 0;
+}
 
-	pr_info("%d local interrupts mapped\n", BITS_PER_LONG);
+IRQCHIP_DECLARE(riscv, "riscv,cpu-intc", riscv_intc_init);
+
+#ifdef CONFIG_ACPI
+
+static int __init
+riscv_intc_acpi_init(union acpi_subtable_headers *header,
+		     const unsigned long end)
+{
+	int rc;
+	struct fwnode_handle *fn;
+	struct acpi_madt_rintc *rintc;
+
+	rintc = (struct acpi_madt_rintc *)header;
+
+	/*
+	 * The ACPI MADT will have one INTC for each CPU (or HART)
+	 * so riscv_intc_acpi_init() function will be called once
+	 * for each INTC. We only need to do INTC initialization
+	 * for the INTC belonging to the boot CPU (or boot HART).
+	 */
+	if (riscv_hartid_to_cpuid(rintc->hart_id) != smp_processor_id())
+		return 0;
+
+	fn = irq_domain_alloc_named_fwnode("RISCV-INTC");
+	WARN_ON(fn == NULL);
+	if (!fn) {
+		pr_err("unable to allocate INTC FW node\n");
+		return -1;
+	}
+
+	rc = riscv_intc_init_common(fn);
+	if (rc) {
+		pr_err("failed to initialize INTC\n");
+		return rc;
+	}
 
 	return 0;
 }
 
-IRQCHIP_DECLARE(riscv, "riscv,cpu-intc", riscv_intc_init);
+IRQCHIP_ACPI_DECLARE(riscv_intc, ACPI_MADT_TYPE_RINTC,
+		     NULL, 1, riscv_intc_acpi_init);
+#endif
-- 
2.38.0

