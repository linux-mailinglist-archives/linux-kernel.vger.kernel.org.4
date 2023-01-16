Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8406666C04A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 14:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbjAPNva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 08:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbjAPNup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 08:50:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777C021A0C;
        Mon, 16 Jan 2023 05:50:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47FB560FE1;
        Mon, 16 Jan 2023 13:50:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B443DC4322E;
        Mon, 16 Jan 2023 13:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673877041;
        bh=nlxLr7M1e3sPAGKO79refaH63FrFXT94UU3Vpzwqemc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lbf7fa2tZbpeVfBK6+e27SiZIYIPL1Naxz33L0nLt84RxNJ1hoR39PrisqR1X/37R
         33TOcM/FZ8iEdZ4mfOYSVj6Wl7wgUscP71KunXbpaLF2ufmxP7zqAFWKoqrN6L1vet
         T/JwIxIMq+1GBMOWcgof6EKvwiZBKL4ud3N3LJqz9iBHmZ4E8XpXHXrMeWjxOC6GZb
         0rLron/ZW1/2GqYdXR/t49omPmZzwfjx7EUnkD82sIDkr7vKx23oWcoPgnZaS50oaM
         5PR1it7wREqawHTHchbYwXtlr8kNUPqkotI5Wxf+cSc0izc60QweYgk89cHLmFOkgW
         Df47QkoVuUghA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pHPt7-0003vX-2z; Mon, 16 Jan 2023 14:51:01 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Subject: [PATCH v4 18/19] irqchip/mvebu-odmi: Use irq_domain_create_hierarchy()
Date:   Mon, 16 Jan 2023 14:50:43 +0100
Message-Id: <20230116135044.14998-19-johan+linaro@kernel.org>
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
 drivers/irqchip/irq-mvebu-odmi.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-mvebu-odmi.c b/drivers/irqchip/irq-mvebu-odmi.c
index dc4145abdd6f..108091533e10 100644
--- a/drivers/irqchip/irq-mvebu-odmi.c
+++ b/drivers/irqchip/irq-mvebu-odmi.c
@@ -161,7 +161,7 @@ static struct msi_domain_info odmi_msi_domain_info = {
 static int __init mvebu_odmi_init(struct device_node *node,
 				  struct device_node *parent)
 {
-	struct irq_domain *inner_domain, *plat_domain;
+	struct irq_domain *parent_domain, *inner_domain, *plat_domain;
 	int ret, i;
 
 	if (of_property_read_u32(node, "marvell,odmi-frames", &odmis_count))
@@ -197,16 +197,17 @@ static int __init mvebu_odmi_init(struct device_node *node,
 		}
 	}
 
-	inner_domain = irq_domain_create_linear(of_node_to_fwnode(node),
-						odmis_count * NODMIS_PER_FRAME,
-						&odmi_domain_ops, NULL);
+	parent_domain = irq_find_host(parent);
+
+	inner_domain = irq_domain_create_hierarchy(parent_domain, 0,
+						   odmis_count * NODMIS_PER_FRAME,
+						   of_node_to_fwnode(node),
+						   &odmi_domain_ops, NULL);
 	if (!inner_domain) {
 		ret = -ENOMEM;
 		goto err_unmap;
 	}
 
-	inner_domain->parent = irq_find_host(parent);
-
 	plat_domain = platform_msi_create_irq_domain(of_node_to_fwnode(node),
 						     &odmi_msi_domain_info,
 						     inner_domain);
-- 
2.38.2

