Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD5466C053
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 14:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjAPNwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 08:52:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbjAPNup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 08:50:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB1821A10;
        Mon, 16 Jan 2023 05:50:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6792B60FE4;
        Mon, 16 Jan 2023 13:50:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F5B1C4332F;
        Mon, 16 Jan 2023 13:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673877041;
        bh=exIBPyxduIGuUodwt8BZURfkCW3s1wM57ISgdqjT39c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aoQxzveXsm/ZO3tWIHkVG6yOughBTRwFZ4w3sRrr96uAlPlyx7SpR+ZXxXvUOIxHe
         7L+qV1iQ2dWU5TH+hcV0tr/8GdtdxBw1Yo6BhAGOIYb/rabVdgtv2aNcMQxzRMTAM0
         bbh5rNPE6lCooDhEBQm1NBiGH+qdPEc0AUV5ozjh0aWxeoF20+u9Zc0ZVRKm8nZ691
         Ur3XCOM7hzmHdXcraj9O9AX3/ue/9EV4mCGojI6818WYTnt+styKgBm64nnxWgtFC/
         daDIz13zqgMzXCIQ1JJHqcysoLXCUbkWc2So86SiCW+EQqY9WdTwv7ljPGLhZkBUCm
         QmyPMOiGsYLJA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pHPt6-0003vI-LQ; Mon, 16 Jan 2023 14:51:00 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Subject: [PATCH v4 13/19] irqchip/alpine-msi: Use irq_domain_add_hierarchy()
Date:   Mon, 16 Jan 2023 14:50:38 +0100
Message-Id: <20230116135044.14998-14-johan+linaro@kernel.org>
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

Use the irq_domain_add_hierarchy() helper to create the hierarchical
domain, which both serves as documentation and avoids poking at
irqdomain internals.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>
Tested-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/irqchip/irq-alpine-msi.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-alpine-msi.c b/drivers/irqchip/irq-alpine-msi.c
index 5ddb8e578ac6..604459372fdd 100644
--- a/drivers/irqchip/irq-alpine-msi.c
+++ b/drivers/irqchip/irq-alpine-msi.c
@@ -204,16 +204,14 @@ static int alpine_msix_init_domains(struct alpine_msix_data *priv,
 		return -ENXIO;
 	}
 
-	middle_domain = irq_domain_add_tree(NULL,
-					    &alpine_msix_middle_domain_ops,
-					    priv);
+	middle_domain = irq_domain_add_hierarchy(gic_domain, 0, 0, NULL,
+						 &alpine_msix_middle_domain_ops,
+						 priv);
 	if (!middle_domain) {
 		pr_err("Failed to create the MSIX middle domain\n");
 		return -ENOMEM;
 	}
 
-	middle_domain->parent = gic_domain;
-
 	msi_domain = pci_msi_create_irq_domain(of_node_to_fwnode(node),
 					       &alpine_msix_domain_info,
 					       middle_domain);
-- 
2.38.2

