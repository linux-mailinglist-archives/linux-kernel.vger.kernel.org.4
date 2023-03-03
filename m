Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4FC6A98B8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 14:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbjCCNjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 08:39:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbjCCNih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 08:38:37 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658F14D612
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 05:38:04 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id m20-20020a17090ab79400b00239d8e182efso6125482pjr.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 05:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1677850683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0NTsYtUJNb7uS+HqQnID6st7LmlddjRj2NkYh86FZo0=;
        b=M25owZtphUqGcASQ2wyvBhUCpahd7MWa9/fmZwAfVRWgbrRzkft6axRYT28uRgX7nr
         CWw1nNLCuKzppnBZB0ssVkSqMGx4zhsAEg17by5BoUk1z0z2g419FysJb7yNcxXyW66M
         AubtTnC5e+7NhVdzDHizPlpKnPfaUNjI7AbbQn+CBY18I+AOSeGgBkkySrdZhzhRi5rc
         +l28bOnsnBX91qr7YXP4w1oPMSzBGdCs2Ik6H7DDUqFIYYLaaWkh/tp+61GMufHDMHVC
         AkpbptY08TtFh9wTVgXoIu1F+X4ASt7lZSBcUtRfRn+zqpq9oyYPtCbJY5sxeTZo8V9Z
         FCfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677850683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0NTsYtUJNb7uS+HqQnID6st7LmlddjRj2NkYh86FZo0=;
        b=SRMBKa3aAtf5YO7Hf78s1XH6339qCs1ZiSaEcmoI/PjMCp7O/e/NbEXT5sSydrn7Rf
         vs9mRiU+6halNlqWLA3G0KFumQcvJKYiezk6ITk4YyRxGZiJ0F5EtU2sbDpeODQ55pp8
         AZGQ8I8802e2AFaQn0Fd6BMylDB/UKcrTj+FcM7UEi0vfjAgqVRWsEzqIEz7L2WcWWyW
         luQ/vmvenf8pLAUrEH6c56ZwHkrlGM0kpW+0PU3jMaoSxGsUhrMYh7uNSgXwghr1nczy
         amTaUHNsomdJXLmMdSx1ZL7f9bPtDhLWpkKziez+lNfbukWg23xFEYtOOi7N2Xvg/hqE
         QirA==
X-Gm-Message-State: AO0yUKVNyWonokPFGK9H7fkfeULj0jjpxPROHBtAWwgH8wO1mzPpJHfq
        Ts4XcQdqQX6S4WRadDy7SUORPg==
X-Google-Smtp-Source: AK7set8ZSK8lfq07d6knUNnE0n6uZxnTVev5zbs5tzsbMO6Dnvwnt5Cbba1r0pUm7jipR5u8Ht43AQ==
X-Received: by 2002:a17:903:247:b0:19e:8076:9bd2 with SMTP id j7-20020a170903024700b0019e80769bd2mr2490767plh.17.1677850682759;
        Fri, 03 Mar 2023 05:38:02 -0800 (PST)
Received: from localhost.localdomain ([49.206.14.226])
        by smtp.gmail.com with ESMTPSA id m9-20020a170902768900b0019ac5d3ee9dsm1533125pll.157.2023.03.03.05.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 05:38:02 -0800 (PST)
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
Subject: [PATCH V3 14/20] irqchip/riscv-intc: Add ACPI support
Date:   Fri,  3 Mar 2023 19:06:41 +0530
Message-Id: <20230303133647.845095-15-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230303133647.845095-1-sunilvl@ventanamicro.com>
References: <20230303133647.845095-1-sunilvl@ventanamicro.com>
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

Add support for initializing the RISC-V INTC driver on ACPI
platforms.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 drivers/irqchip/irq-riscv-intc.c | 77 +++++++++++++++++++++++++++-----
 1 file changed, 65 insertions(+), 12 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index f229e3e66387..f522510dc1f3 100644
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
@@ -133,24 +158,52 @@ static int __init riscv_intc_init(struct device_node *node,
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
+static int __init riscv_intc_acpi_init(union acpi_subtable_headers *header,
+				       const unsigned long end)
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
+	 * for each INTC. We only do INTC initialization
+	 * for the INTC belonging to the boot CPU (or boot HART).
+	 */
+	if (riscv_hartid_to_cpuid(rintc->hart_id) != smp_processor_id())
+		return 0;
+
+	fn = irq_domain_alloc_named_fwnode("RISCV-INTC");
+	if (!fn) {
+		pr_err("unable to allocate INTC FW node\n");
+		return -ENOMEM;
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
+IRQCHIP_ACPI_DECLARE(riscv_intc, ACPI_MADT_TYPE_RINTC, NULL,
+		     ACPI_MADT_RINTC_VERSION_V1, riscv_intc_acpi_init);
+#endif
-- 
2.34.1

