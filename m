Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2549A64B6E3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 15:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235687AbiLMOJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 09:09:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235847AbiLMOIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 09:08:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B152B20BF0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 06:08:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 464D861547
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 14:08:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84437C43392;
        Tue, 13 Dec 2022 14:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670940521;
        bh=5ANoRWrSaLL6qmyIVtv/zuiN4Gcz4H2KBPrL3ePRwww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OVE3nw4VjjY+BFuP1O+J++Oa7V8+ioOqIXPOvGVBTJsvD65b93f8CDLNWL9+LCBsn
         0VJz5Ed4xJ+gmEdF9OjXzRrsYw3JQSsa9ng+1vwpOf/GLuakBwblIz+mJuoeo0LP7G
         sfgUIf9RhydWdwvJYCTEl6HM1bJNHu8PPFvE9yAE6KHpAnXENKGlFLzqezYbTiiP1/
         j4gbYTwGFvVPrFVgfxcvoYhRD4agYlyLqRayxlsqlo5CwEQLoKnbFb0MWl/gIdVVtL
         xEPGseHaCKK/zniNCEUXUwWXadaR8h8Aq3ZFNZH28Hv9F7iwsWuYi/Cv9JvLmP7Ynf
         vzpVzEyMQkJSw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1p55xz-00042L-Eu; Tue, 13 Dec 2022 15:09:07 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 1/2] irqchip: Use irq_domain_alloc_irqs()
Date:   Tue, 13 Dec 2022 15:08:43 +0100
Message-Id: <20221213140844.15470-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221213140844.15470-1-johan+linaro@kernel.org>
References: <20221213140844.15470-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the irq_domain_alloc_irqs() wrapper instead of the full
__irq_domain_alloc_irqs() interface, which was only intended for some
legacy (x86) use cases.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/irqchip/irq-apple-aic.c     |  5 ++---
 drivers/irqchip/irq-armada-370-xp.c |  4 ++--
 drivers/irqchip/irq-bcm2836.c       |  6 ++----
 drivers/irqchip/irq-gic-v3.c        |  5 ++---
 drivers/irqchip/irq-gic-v4.c        | 10 ++++------
 drivers/irqchip/irq-gic.c           |  5 ++---
 6 files changed, 14 insertions(+), 21 deletions(-)

diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
index ae3437f03e6c..848ccef03c92 100644
--- a/drivers/irqchip/irq-apple-aic.c
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -924,9 +924,8 @@ static int __init aic_init_smp(struct aic_irq_chip *irqc, struct device_node *no
 	ipi_domain->flags |= IRQ_DOMAIN_FLAG_IPI_SINGLE;
 	irq_domain_update_bus_token(ipi_domain, DOMAIN_BUS_IPI);
 
-	base_ipi = __irq_domain_alloc_irqs(ipi_domain, -1, AIC_NR_SWIPI,
-					   NUMA_NO_NODE, NULL, false, NULL);
-
+	base_ipi = irq_domain_alloc_irqs(ipi_domain, AIC_NR_SWIPI, NUMA_NO_NODE,
+					 NULL);
 	if (WARN_ON(!base_ipi)) {
 		irq_domain_remove(ipi_domain);
 		return -ENODEV;
diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index ee18eb3e72b7..c6f8f5b07ec0 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -454,8 +454,8 @@ static __init void armada_xp_ipi_init(struct device_node *node)
 		return;
 
 	irq_domain_update_bus_token(ipi_domain, DOMAIN_BUS_IPI);
-	base_ipi = __irq_domain_alloc_irqs(ipi_domain, -1, IPI_DOORBELL_END,
-					   NUMA_NO_NODE, NULL, false, NULL);
+	base_ipi = irq_domain_alloc_irqs(ipi_domain, IPI_DOORBELL_END,
+					 NUMA_NO_NODE, NULL);
 	if (WARN_ON(!base_ipi))
 		return;
 
diff --git a/drivers/irqchip/irq-bcm2836.c b/drivers/irqchip/irq-bcm2836.c
index 51491c3c6fdd..0f49246af16e 100644
--- a/drivers/irqchip/irq-bcm2836.c
+++ b/drivers/irqchip/irq-bcm2836.c
@@ -268,10 +268,8 @@ static void __init bcm2836_arm_irqchip_smp_init(void)
 	ipi_domain->flags |= IRQ_DOMAIN_FLAG_IPI_SINGLE;
 	irq_domain_update_bus_token(ipi_domain, DOMAIN_BUS_IPI);
 
-	base_ipi = __irq_domain_alloc_irqs(ipi_domain, -1, BITS_PER_MBOX,
-					   NUMA_NO_NODE, NULL,
-					   false, NULL);
-
+	base_ipi = irq_domain_alloc_irqs(ipi_domain, BITS_PER_MBOX,
+					 NUMA_NO_NODE, NULL);
 	if (WARN_ON(!base_ipi))
 		return;
 
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 997104d4338e..7acf501c9a10 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1310,9 +1310,8 @@ static void __init gic_smp_init(void)
 				  gic_starting_cpu, NULL);
 
 	/* Register all 8 non-secure SGIs */
-	base_sgi = __irq_domain_alloc_irqs(gic_data.domain, -1, 8,
-					   NUMA_NO_NODE, &sgi_fwspec,
-					   false, NULL);
+	base_sgi = irq_domain_alloc_irqs(gic_data.domain, 8, NUMA_NO_NODE,
+					 &sgi_fwspec);
 	if (WARN_ON(base_sgi <= 0))
 		return;
 
diff --git a/drivers/irqchip/irq-gic-v4.c b/drivers/irqchip/irq-gic-v4.c
index a6277dea4c7a..7635707c37e5 100644
--- a/drivers/irqchip/irq-gic-v4.c
+++ b/drivers/irqchip/irq-gic-v4.c
@@ -139,9 +139,8 @@ static int its_alloc_vcpu_sgis(struct its_vpe *vpe, int idx)
 	if (!vpe->sgi_domain)
 		goto err;
 
-	sgi_base = __irq_domain_alloc_irqs(vpe->sgi_domain, -1, 16,
-					       NUMA_NO_NODE, vpe,
-					       false, NULL);
+	sgi_base = irq_domain_alloc_irqs(vpe->sgi_domain, 16, NUMA_NO_NODE,
+					 vpe);
 	if (sgi_base <= 0)
 		goto err;
 
@@ -176,9 +175,8 @@ int its_alloc_vcpu_irqs(struct its_vm *vm)
 		vm->vpes[i]->idai = true;
 	}
 
-	vpe_base_irq = __irq_domain_alloc_irqs(vm->domain, -1, vm->nr_vpes,
-					       NUMA_NO_NODE, vm,
-					       false, NULL);
+	vpe_base_irq = irq_domain_alloc_irqs(vm->domain, vm->nr_vpes,
+					     NUMA_NO_NODE, vm);
 	if (vpe_base_irq <= 0)
 		goto err;
 
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 210bc2f4d555..c87021f037c9 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -868,9 +868,8 @@ static __init void gic_smp_init(void)
 				  "irqchip/arm/gic:starting",
 				  gic_starting_cpu, NULL);
 
-	base_sgi = __irq_domain_alloc_irqs(gic_data[0].domain, -1, 8,
-					   NUMA_NO_NODE, &sgi_fwspec,
-					   false, NULL);
+	base_sgi = irq_domain_alloc_irqs(gic_data[0].domain, 8, NUMA_NO_NODE,
+					 &sgi_fwspec);
 	if (WARN_ON(base_sgi <= 0))
 		return;
 
-- 
2.37.4

