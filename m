Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F846971DF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 00:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbjBNXeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 18:34:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbjBNXel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 18:34:41 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E2130EBD
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 15:34:38 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id w14-20020a17090a5e0e00b00233d3b9650eso340952pjf.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 15:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SyylP0dLgQ4asCxngY/+BtyC8fT6IgNch9KD6tsWn/k=;
        b=ZJWgdgdeDcALyzNsrzBmfXelgCjE+0JdPXLeH90B+rr8GyPVpeoxYPCZRgrNv5WI6e
         hSUDXiyA6P+WCdgvQhhc+L33e9c2GNzrTWBcRXo3xgiAjI63oVTl+xG4VyOimslwSvjU
         t4yVgP6xYmF8otZPDjHs+YLNzAzLbcyu00X9IgJmwPZMZL6AYFjBh5fTIFWRljnvu1zw
         /EiiNn/0JaLuo5Ri0khUcyZL7kn4JgQ9khORK9qp5I/NF1Zz0FJKd6HC5ZnNFZKYRTre
         PdOshuv3UAmAYo7157ru/5SZT0jolOvkX70qQhP0yGyzQuIdQ680ndqnOQmmNqm0F92/
         oggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SyylP0dLgQ4asCxngY/+BtyC8fT6IgNch9KD6tsWn/k=;
        b=sTd7UvMptt4wIwr5CHLkJnen6C6Tv2O8dAGYutG8ZpmciQLlqyGD/P26NsqgRBibrA
         yxPqjmZzFxgihNodfOtYCDn6G8d3AW9Sz/RZw3mYToio53sZ9+ewJ6r8QDNcHK/hrTJG
         /TDGJatPynxC+qf10UIfjj8Y78AQi37q7g/fIS88W4YahixjTu3rHAezDHJAWdMn7wxr
         ZfZdLSRR8dH/QKkPBFTZGGG0hL74l5qrlGtL09/jDpyiqjSmSBhGM7nCWMCeSW4LyPzA
         FxIlMVZcO5Maj25q1qVKAlYrq6ZX0jNv0jXKJ55k1TolNlRFYLFP7qnA43UXxanTG0QH
         Yy+g==
X-Gm-Message-State: AO0yUKXYGpGzKSp2SXo+lK7XQ3yYxlsm1IXGV8s/95ZJwZcumRekMOWn
        bO5KtpBwNCHT8BoPfm1IvjM=
X-Google-Smtp-Source: AK7set9gUgKFKTHPQ4vcB+yKpE8Sa0qQPAg6uGk1MQXwoJmPMzDWwyRmQ9Bvk5uGmNZuOOjv8WWpjQ==
X-Received: by 2002:a17:903:1c9:b0:198:9f0c:a91 with SMTP id e9-20020a17090301c900b001989f0c0a91mr481784plh.20.1676417678335;
        Tue, 14 Feb 2023 15:34:38 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id f12-20020a170902684c00b001963a178dfcsm9434801pln.244.2023.02.14.15.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 15:34:37 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        linux-kernel@vger.kernel.org (open list:IRQCHIP DRIVERS),
        Sudeep Holla <sudeep.holla@arm.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>
Subject: [PATCH 3/3] irqchip/gic-v3: Save and restore distributor and re-distributor
Date:   Tue, 14 Feb 2023 15:34:26 -0800
Message-Id: <20230214233426.2994501-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230214233426.2994501-1-f.fainelli@gmail.com>
References: <20230214233426.2994501-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On platforms implementing Suspend to RAM where the GIC loses power, we
are not properly saving and restoring the GIC distributor and
re-distributor registers thus leading to the system resuming without any
functional interrupts.

Add support for saving and restoring the GIC distributor and
re-distributor in order to properly suspend and resume with a functional
system.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/irqchip/irq-gic-v3.c       | 258 +++++++++++++++++++++++++++++
 include/linux/irqchip/arm-gic-v3.h |   4 +
 2 files changed, 262 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 48b0e9aba27c..4caab61268d0 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -11,6 +11,7 @@
 #include <linux/cpu_pm.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/irqdomain.h>
 #include <linux/kstrtox.h>
 #include <linux/of.h>
@@ -57,6 +58,25 @@ struct gic_chip_data {
 	bool			has_rss;
 	unsigned int		ppi_nr;
 	struct partition_desc	**ppi_descs;
+#ifdef CONFIG_CPU_PM
+	u32			*saved_spi_conf;
+	u64			*saved_spi_target;
+	u32			*saved_spi_enable;
+	u32			*saved_spi_active;
+
+	u32			*saved_espi_conf;
+	u64			*saved_espi_target;
+	u32			*saved_espi_enable;
+	u32			*saved_espi_active;
+
+	u32			saved_ppi_conf;
+	u32			saved_ppi_enable;
+	u32			saved_ppi_active;
+
+	u32			*saved_eppi_conf;
+	u32			*saved_eppi_enable;
+	u32			*saved_eppi_active;
+#endif
 };
 
 static struct gic_chip_data gic_data __read_mostly;
@@ -1371,6 +1391,143 @@ static int gic_retrigger(struct irq_data *data)
 }
 
 #ifdef CONFIG_CPU_PM
+static void gic_rdist_save(void)
+{
+	struct gic_chip_data *gic = &gic_data;
+	void __iomem *rbase = gic_data_rdist_sgi_base();
+	unsigned int i;
+
+	gic->saved_ppi_conf = readl_relaxed(rbase + GICR_ICFGR0 + 4);
+	gic->saved_ppi_enable = readl_relaxed(rbase + GICR_ISENABLER0);
+	gic->saved_ppi_active = readl_relaxed(rbase + GICR_ICACTIVER0);
+
+	for (i = 0; i < DIV_ROUND_UP(gic->ppi_nr - 16, 32); i++) {
+		gic->saved_eppi_conf[i] =
+			readl_relaxed(rbase + GICR_ICFGRnE + i * 4);
+		gic->saved_eppi_enable[i] =
+			readl_relaxed(rbase + GICR_ISENABLERnE + i * 4);
+		gic->saved_eppi_active[i] =
+			readl_relaxed(rbase + GICR_ICACTIVERnE + i * 4);
+	}
+}
+
+static void gic_dist_save(void)
+{
+	struct gic_chip_data *gic = &gic_data;
+	void __iomem *base = gic_data.dist_base;
+	unsigned int i;
+
+	/* Save the SPIs first */
+	for (i = 2; i < DIV_ROUND_UP(GIC_LINE_NR, 16); i++)
+		gic->saved_spi_conf[i] =
+			readl_relaxed(base + GICD_ICFGR + i * 4);
+
+	for (i = 32; i < GIC_LINE_NR; i++)
+		gic->saved_spi_target[i] =
+			readq_relaxed(base + GICD_IROUTER + i * 8);
+
+	for (i = 1; i < DIV_ROUND_UP(GIC_LINE_NR, 32); i++) {
+		gic->saved_spi_enable[i] =
+			readl_relaxed(base + GICD_ISENABLER + i * 4);
+		gic->saved_spi_active[i] =
+			readl_relaxed(base + GICD_ISACTIVER + i * 4);
+	}
+
+	/* Save the EPIs next */
+	for (i = 0; i < DIV_ROUND_UP(GIC_ESPI_NR, 16); i++)
+		gic->saved_espi_conf[i] =
+			readl_relaxed(base + GICD_ICFGRnE + i * 4);
+
+	for (i = 0; i < GIC_ESPI_NR; i++)
+		gic->saved_espi_target[i] =
+			readq_relaxed(base + GICD_IROUTERnE + i * 8);
+
+	for (i = 0; i < DIV_ROUND_UP(GIC_ESPI_NR, 32); i++) {
+		gic->saved_espi_enable[i] =
+			readl_relaxed(base + GICD_ISENABLERnE + i * 4);
+		gic->saved_espi_active[i] =
+			readl_relaxed(base + GICD_ISACTIVERnE + i * 4);
+	}
+}
+
+static void gic_rdist_restore(void)
+{
+	struct gic_chip_data *gic = &gic_data;
+	void __iomem *rbase = gic_data_rdist_sgi_base();
+	unsigned int i;
+
+	writel_relaxed(gic->saved_ppi_conf, rbase + GICR_ICFGR0 + 4);
+	writel_relaxed(gic->saved_ppi_enable, rbase + GICR_ISENABLER0);
+	writel_relaxed(gic->saved_ppi_active, rbase + GICR_ICACTIVER0);
+
+	for (i = 0; i < DIV_ROUND_UP(gic->ppi_nr - 16, 32); i++) {
+		writel_relaxed(gic->saved_eppi_conf[i],
+				rbase + GICR_ICFGRnE + i * 4);
+		writel_relaxed(gic->saved_eppi_enable[i],
+				rbase + GICR_ISENABLERnE + i * 4);
+		writel_relaxed(gic->saved_eppi_active[i],
+				rbase + GICR_ICACTIVERnE + i * 4);
+	}
+}
+
+static void gic_dist_restore(void)
+{
+	struct gic_chip_data *gic = &gic_data;
+	void __iomem *base = gic_data.dist_base;
+	unsigned int i;
+
+	/* Ensure distributor is disabled */
+	writel_relaxed(0, base + GICD_CTLR);
+	gic_dist_wait_for_rwp();
+
+	/* Configure SPIs as non-secure Group-1. */
+	for (i = 32; i < GIC_LINE_NR; i += 32)
+		writel_relaxed(~0, base + GICD_IGROUPR + i / 8);
+
+	/* Restore the SPIs */
+	for (i = 2; i < DIV_ROUND_UP(GIC_LINE_NR, 16); i++)
+		writel_relaxed(gic->saved_spi_conf[i],
+			       base + GICD_ICFGR + i * 4);
+
+	for (i = 32; i < GIC_LINE_NR; i++)
+		writel_relaxed(gic->saved_spi_target[i],
+				base + GICD_IROUTER + i * 8);
+
+	for (i = 1; i < DIV_ROUND_UP(GIC_LINE_NR, 32); i++) {
+		writel_relaxed(gic->saved_spi_enable[i],
+				base + GICD_ISENABLER + i * 4);
+		writel_relaxed(gic->saved_spi_active[i],
+				base + GICD_ISACTIVER + i * 4);
+	}
+
+	/* Configure ESPIs as non-secure Group-1. */
+	for (i = 0; i < GIC_ESPI_NR; i += 32)
+		writel_relaxed(~0U, base + GICD_IGROUPRnE + i / 8);
+
+	/* Restore the ESPIs */
+	for (i = 0; i < DIV_ROUND_UP(GIC_ESPI_NR, 16); i++)
+		writel_relaxed(gic->saved_espi_conf[i],
+				base + GICD_ICFGRnE + i * 4);
+
+	for (i = 0; i < GIC_ESPI_NR; i++)
+		writeq_relaxed(gic->saved_espi_target[i],
+				base + GICD_IROUTERnE + i * 8);
+
+	for (i = 0; i < DIV_ROUND_UP(GIC_ESPI_NR, 32); i++) {
+		writel_relaxed(gic->saved_espi_enable[i],
+				base + GICD_ISENABLERnE + i * 4);
+		writel_relaxed(gic->saved_espi_active[i],
+				base + GICD_ISACTIVERnE + i * 4);
+	}
+
+	for (i = 0; i < GIC_ESPI_NR; i += 4)
+		writel_relaxed(GICD_INT_DEF_PRI_X4, base + GICD_IPRIORITYRnE + i);
+
+	/* Enable distributor with ARE, Group1 */
+	writel_relaxed(GICD_CTLR_ARE_NS | GICD_CTLR_ENABLE_G1A | GICD_CTLR_ENABLE_G1,
+		       base + GICD_CTLR);
+}
+
 static int gic_cpu_pm_notifier(struct notifier_block *self,
 			       unsigned long cmd, void *v)
 {
@@ -1380,12 +1537,20 @@ static int gic_cpu_pm_notifier(struct notifier_block *self,
 			gic_write_grpen1(0);
 			gic_enable_redist(false);
 		}
+		gic_rdist_save();
+		break;
+	case CPU_CLUSTER_PM_ENTER:
+		gic_dist_save();
 		break;
 	case CPU_PM_EXIT:
+		gic_rdist_restore();
 		if (gic_dist_security_disabled())
 			gic_enable_redist(true);
 		gic_cpu_sys_reg_init();
 		break;
+	case CPU_CLUSTER_PM_EXIT:
+		gic_dist_restore();
+		break;
 	}
 
 	return NOTIFY_OK;
@@ -1397,9 +1562,102 @@ static struct notifier_block gic_cpu_pm_notifier_block = {
 
 static int gic_cpu_pm_init(void)
 {
+	struct gic_chip_data *gic = &gic_data;
+	unsigned int spi_size = DIV_ROUND_UP(GIC_LINE_NR, 32);
+	unsigned int espi_size = DIV_ROUND_UP(GIC_ESPI_NR, 32);
+	unsigned int eppi_size = DIV_ROUND_UP(gic->ppi_nr - 16, 32);
+
+	gic->saved_spi_conf = kcalloc(DIV_ROUND_UP(GIC_LINE_NR, 16),
+				      sizeof(*gic->saved_spi_conf),
+				      GFP_KERNEL);
+	if (WARN_ON(!gic->saved_spi_conf))
+		return -ENOMEM;
+
+	gic->saved_spi_target = kcalloc(GIC_LINE_NR,
+					sizeof(*gic->saved_spi_target),
+					GFP_KERNEL);
+	if (WARN_ON(!gic->saved_spi_target))
+		goto out_free_spi_conf;
+
+	gic->saved_spi_enable = kcalloc(spi_size,
+					sizeof(*gic->saved_spi_enable),
+					GFP_KERNEL);
+	if (WARN_ON(!gic->saved_spi_enable))
+		goto out_free_spi_target;
+
+	gic->saved_spi_active = kcalloc(spi_size,
+					sizeof(*gic->saved_spi_active),
+					GFP_KERNEL);
+	if (WARN_ON(!gic->saved_spi_active))
+		goto out_free_spi_enable;
+
+	gic->saved_espi_conf = kcalloc(DIV_ROUND_UP(GIC_ESPI_NR, 16),
+				       sizeof(*gic->saved_espi_conf),
+				       GFP_KERNEL);
+	if (WARN_ON(!gic->saved_espi_conf))
+		goto out_free_spi_active;
+
+	gic->saved_espi_target = kcalloc(GIC_ESPI_NR,
+					 sizeof(*gic->saved_espi_target),
+					 GFP_KERNEL);
+	if (WARN_ON(!gic->saved_espi_target))
+		goto out_free_espi_conf;
+
+	gic->saved_espi_enable = kcalloc(espi_size,
+					 sizeof(*gic->saved_espi_enable),
+					 GFP_KERNEL);
+	if (WARN_ON(!gic->saved_espi_enable))
+		goto out_free_espi_target;
+
+	gic->saved_espi_active = kcalloc(espi_size,
+					 sizeof(*gic->saved_espi_active),
+					 GFP_KERNEL);
+	if (WARN_ON(!gic->saved_espi_active))
+		goto out_free_espi_enable;
+
+	gic->saved_eppi_conf = kcalloc(DIV_ROUND_UP(gic->ppi_nr - 16, 16),
+				       sizeof(*gic->saved_eppi_conf),
+				       GFP_KERNEL);
+	if (WARN_ON(!gic->saved_eppi_conf))
+		goto out_free_espi_active;
+
+	gic->saved_eppi_enable = kcalloc(eppi_size,
+					 sizeof(*gic->saved_eppi_enable),
+					 GFP_KERNEL);
+	if (WARN_ON(!gic->saved_eppi_enable))
+		goto out_free_eppi_conf;
+
+	gic->saved_eppi_active = kcalloc(eppi_size,
+					 sizeof(*gic->saved_eppi_active),
+					 GFP_KERNEL);
+	if (WARN_ON(!gic->saved_eppi_active))
+		goto out_free_eppi_enable;
+
 	cpu_pm_register_notifier(&gic_cpu_pm_notifier_block);
 
 	return 0;
+
+out_free_eppi_enable:
+	kfree(gic->saved_eppi_enable);
+out_free_eppi_conf:
+	kfree(gic->saved_eppi_conf);
+out_free_espi_active:
+	kfree(gic->saved_espi_active);
+out_free_espi_enable:
+	kfree(gic->saved_espi_enable);
+out_free_espi_target:
+	kfree(gic->saved_espi_target);
+out_free_espi_conf:
+	kfree(gic->saved_espi_conf);
+out_free_spi_active:
+	kfree(gic->saved_spi_active);
+out_free_spi_enable:
+	kfree(gic->saved_spi_enable);
+out_free_spi_target:
+	kfree(gic->saved_spi_target);
+out_free_spi_conf:
+	kfree(gic->saved_spi_conf);
+	return -ENOMEM;
 }
 
 #else
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 728691365464..40483530cadd 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -229,13 +229,17 @@
  */
 #define GICR_IGROUPR0			GICD_IGROUPR
 #define GICR_ISENABLER0			GICD_ISENABLER
+#define GICR_ISENABLERnE		GICD_ISENABLERnE
 #define GICR_ICENABLER0			GICD_ICENABLER
 #define GICR_ISPENDR0			GICD_ISPENDR
 #define GICR_ICPENDR0			GICD_ICPENDR
 #define GICR_ISACTIVER0			GICD_ISACTIVER
+#define GICR_ISACTIVERnE		GICD_ISACTIVERnE
 #define GICR_ICACTIVER0			GICD_ICACTIVER
+#define GICR_ICACTIVERnE		GICD_ICACTIVERnE
 #define GICR_IPRIORITYR0		GICD_IPRIORITYR
 #define GICR_ICFGR0			GICD_ICFGR
+#define GICR_ICFGRnE			GICD_ICFGRnE
 #define GICR_IGRPMODR0			GICD_IGRPMODR
 #define GICR_NSACR			GICD_NSACR
 
-- 
2.34.1

