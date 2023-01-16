Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 306C966C04F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 14:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjAPNvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 08:51:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjAPNut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 08:50:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B3F21A17;
        Mon, 16 Jan 2023 05:50:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 55C99B80F9C;
        Mon, 16 Jan 2023 13:50:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85430C432C4;
        Mon, 16 Jan 2023 13:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673877041;
        bh=8DJCpUTNn+l1lULiQCFrqNOTi/kGEEvzvK7CyZ3zKZE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bbXomJWO7ZAWnj9f1IHYWsdNOiKPjuldKfB71I8vFaL289g4PgVvZ2CnJhi/ilL2j
         EOXhxb9aOaf/dRV40UcEh01ip0NTxDdljQGPOQSM35iD7XRJjJGFuoINFi6X4zdW6j
         /RoXuxAhmDNa/lkHX8DcvSn2YN1k5llWU5hUt78LyQp0IbWQtdV4m9ys6SupTUcfUl
         K6ziM4uy2P8E9ektMaOQmOMsco5xoEpjNKYPL9Zjgpq6XigjfRnFjdnV7/nASAASTV
         ei6wiIrQtAXP01c9vD7v+nyrm+9JCHXzPzN+rsArQjOQNiiUGKZ9macMM+jj187Q+7
         ScBzZmt+wfq/A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pHPt7-0003vV-0i; Mon, 16 Jan 2023 14:51:01 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Subject: [PATCH v4 17/19] irqchip/loongson-pch-msi: Use irq_domain_create_hierarchy()
Date:   Mon, 16 Jan 2023 14:50:42 +0100
Message-Id: <20230116135044.14998-18-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.38.2
In-Reply-To: <20230116135044.14998-1-johan+linaro@kernel.org>
References: <20230116135044.14998-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>
Tested-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
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
2.38.2

