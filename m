Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED9E690A35
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 14:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbjBINbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 08:31:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbjBINav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 08:30:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853C05EBFF;
        Thu,  9 Feb 2023 05:30:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AEBBBB82144;
        Thu,  9 Feb 2023 13:30:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB0D0C43234;
        Thu,  9 Feb 2023 13:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675949443;
        bh=xReQQbRP8f3ZcgElG5HL2OX/F0HPnUSW+WJ1I2BgRtE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TpFoR87h4CVzdcgL6j8nfk4026l69oWKrVtkrpvIeqrZjLp9OWcf3VFYh5hp5SmCS
         +sZpIY55fJc4MDomzGwRj8GEbDdhQ6zAU+YGpbXiNCXfRci4pkncf7GYrzr28MyumC
         oDNGbTj78k0MRJQEXKikjKowEvQ+HCS88FcxdKa7+KJF8IV4h8RuVjWUTXr3m/9agS
         6zS3tMt1GcOVs/vmfRJjj7nlk/rCyDQ+80rE0GzN0+YQT6jvRgMBt9+Ni541c4oauH
         e90S7lza9Ol4zhgFuYxE2TVY9sroziB9bu+seZ2YhwnvALGuybqzfUJeZX4vP22EvJ
         wdSPEA9SiHQ4Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pQ71H-0001La-JB; Thu, 09 Feb 2023 14:31:23 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Subject: [PATCH v5 17/19] irqchip/loongson-pch-msi: Use irq_domain_create_hierarchy()
Date:   Thu,  9 Feb 2023 14:23:21 +0100
Message-Id: <20230209132323.4599-18-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230209132323.4599-1-johan+linaro@kernel.org>
References: <20230209132323.4599-1-johan+linaro@kernel.org>
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
2.39.1

