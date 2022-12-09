Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C44A648367
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 15:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiLIOGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 09:06:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiLIOFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 09:05:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCC97869E;
        Fri,  9 Dec 2022 06:05:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7972762284;
        Fri,  9 Dec 2022 14:05:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71032C432C6;
        Fri,  9 Dec 2022 14:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670594714;
        bh=4RPPmHlyjmlFUoLHUFxMf8HvCeMtaA+C0YRncoYi5r0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I9U1EWXH4g5czfiJcl1sznKHcybwXhDHSvBNWqKAoKXukqvbk9CcBWG6iNGfjlgsu
         zDW5xeYGQe2Z6XJmQXKV2lG7bkPVFqR10B/YTiDFu+wL3blgNxOYtlxgkkSXPBZA4V
         NDOHRvSCTENf4pJ0802Q0WI51jPP8l5IdCI7KFftI/9WBagQZziZAaILSb8B8XvQ6I
         eYq3s3TwJwJRGUC0ZbZ3phmicN64cDLZfjnoJGtmY8ZmZzqRBo4IDPP2GTSGSUaQNA
         Pooze409PSzu4gDkgEIa3EYs+BWgusMT1PdLk9xUqhqIdBYVdq6Ku9Q4BPRar0NVEi
         IUBq3zuqxbTWQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1p3e0J-0000SA-Nb; Fri, 09 Dec 2022 15:05:31 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v3 17/19] irqchip/loongson-pch-msi: Use irq_domain_create_hierarchy()
Date:   Fri,  9 Dec 2022 15:01:48 +0100
Message-Id: <20221209140150.1453-18-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221209140150.1453-1-johan+linaro@kernel.org>
References: <20221209140150.1453-1-johan+linaro@kernel.org>
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

Use the irq_domain_create_hierarchy() helper to create the hierarchical
domain, which both serves as documentation and avoids poking at
irqdomain internals.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/irqchip/irq-loongson-pch-msi.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-loongson-pch-msi.c b/drivers/irqchip/irq-loongson-pch-msi.c
index a72ede90ffc6..6e1e1f011bb2 100644
--- a/drivers/irqchip/irq-loongson-pch-msi.c
+++ b/drivers/irqchip/irq-loongson-pch-msi.c
@@ -163,16 +163,15 @@ static int pch_msi_init_domains(struct pch_msi_data *priv,
 {
 	struct irq_domain *middle_domain, *msi_domain;
 
-	middle_domain = irq_domain_create_linear(domain_handle,
-						priv->num_irqs,
-						&pch_msi_middle_domain_ops,
-						priv);
+	middle_domain = irq_domain_create_hierarchy(parent, 0, priv->num_irqs,
+						    domain_handle,
+						    &pch_msi_middle_domain_ops,
+						    priv);
 	if (!middle_domain) {
 		pr_err("Failed to create the MSI middle domain\n");
 		return -ENOMEM;
 	}
 
-	middle_domain->parent = parent;
 	irq_domain_update_bus_token(middle_domain, DOMAIN_BUS_NEXUS);
 
 	msi_domain = pci_msi_create_irq_domain(domain_handle,
-- 
2.37.4

