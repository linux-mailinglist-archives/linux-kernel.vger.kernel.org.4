Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2C9699C32
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 19:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjBPSXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 13:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjBPSWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 13:22:32 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5604050368
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 10:22:02 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id cp18so516514pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 10:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8+mNmph7z+0hgeAPhfRjYNKRnC89i/LR46jyYpJ0Apo=;
        b=l+E/4mGvkIJFMOx3vpketHl6w+OVgKH1DxDQBosv+JiXnn3EnFIE5kJx5+YzS6lLiS
         0rYHRmZl+afg6HhbnviJ+eKMj5yIjob50D2ExCAbohUNkrRvegMgK53TL+DatL6okNB1
         f+4FlaxZq63X6ZwMSDhpiwE6X2KLXp7s5x+yRBbSxUoHZgSQtI87+UVq0Z2HgJ9Ay/Zd
         yif3+oeSS9ykcKUaZq3ZNvy7s4zFmSY3VYzDbAcXZ0n7WsSQoMo4LXuYcp5xcp9ruJdm
         7QGg+T1xe2cQhLpXyD5XCOSgPN0bqnBE7qZdpVxAexRvSprB2mokXcWga7rVPXqE1fX0
         d8Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8+mNmph7z+0hgeAPhfRjYNKRnC89i/LR46jyYpJ0Apo=;
        b=DKIFYYPKmGOUmY1TrYXju4ttMH93wsd+YEPUaUjBfzGhwZIyr5OFB9AMDkqD5TOuTr
         eKd6J0zdgA60Bbc8SGDuVcQTAtHDU7z+QD4L1DQfEaPM1sHnPyx/BBtEHedqnYLq5To0
         suVNWx+w6HPiaDenmz7S7eT6j3EjsBohrRhKchr7aL5HeACVGj8ugzzPbSh01LxsjmuD
         nYxSy1unrOmTh6AWq6jrtltlu5nDiINSEnnWbbXvpDdluItArKjaIU13//N4bfIBwLZn
         35Mk3OfLJbciG223hl+CVFb+maZv4XcIgKNDd/6EwPeRemgiUODRTTll/WR76eX6lRL4
         rzwg==
X-Gm-Message-State: AO0yUKVOyLsb8jOE8n94t2HKT077+n6JZIhbV6F4WcAAXwAcIyNQ2JZD
        spMobn6kYWEPzMAiFpBKI8pNgA==
X-Google-Smtp-Source: AK7set940eocbZJrVpFGvstTalckFPNlTIQlDCA11v5kbvJbNDaml4O2OhjVpI7zpc+dOhk9Rjo3Bg==
X-Received: by 2002:a17:90a:1ca:b0:234:106a:34b7 with SMTP id 10-20020a17090a01ca00b00234106a34b7mr7684245pjd.46.1676571719882;
        Thu, 16 Feb 2023 10:21:59 -0800 (PST)
Received: from kerodi.Dlink ([49.206.14.226])
        by smtp.gmail.com with ESMTPSA id n21-20020a637215000000b004dff15fc121sm1517574pgc.36.2023.02.16.10.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 10:21:59 -0800 (PST)
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
Subject: [PATCH V2 14/21] irqchip/riscv-intc: Add ACPI support
Date:   Thu, 16 Feb 2023 23:50:36 +0530
Message-Id: <20230216182043.1946553-15-sunilvl@ventanamicro.com>
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

Add support for initializing the RISC-V INTC driver on ACPI
platforms.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/irqchip/irq-riscv-intc.c | 78 +++++++++++++++++++++++++++-----
 1 file changed, 66 insertions(+), 12 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index f229e3e66387..97a8db0fbc6c 100644
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
@@ -133,24 +158,53 @@ static int __init riscv_intc_init(struct device_node *node,
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

