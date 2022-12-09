Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABA764836A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 15:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbiLIOGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 09:06:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiLIOFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 09:05:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1A176143;
        Fri,  9 Dec 2022 06:05:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 26115B8288B;
        Fri,  9 Dec 2022 14:05:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F9DC432C7;
        Fri,  9 Dec 2022 14:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670594714;
        bh=VZG0mIrnpRYSLmP6v+aPSsXqssZN+JxVOB0YXZxJtgI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vBPCGJ3ydqDKIQkyQiwvx3XBhQ8eYOJI6wjL7rjJduxKvPdzdS5X9EDTcy8k6PxC5
         r2hMYtQ9BPJ38yd40f/xppo09a5tY54ooaCwgv7bHH17qds/lSpnelHcNAThBeuhz/
         BrjSw3OEW9PtnBWPMuErakJhKSnTpv80Bhu0T8z2VQr2n8I3BcENT58IDq8oT3n6n1
         tTRDCz/w4Ra6GZ99RJmFy8Jv1kiZqdKtmbldZW9z01mSQohFyIF2INRmpczT8jgrZz
         Z0gTo7WjVwGW5u9NI6AhHt2Jgp4Dh0CnSQTmD8OJ6yRG7UYz6t6F6Ux+of7yFXakxf
         EI6muweRqyVcg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1p3e0J-0000SD-QA; Fri, 09 Dec 2022 15:05:31 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v3 18/19] irqchip/mvebu-odmi: Use irq_domain_create_hierarchy()
Date:   Fri,  9 Dec 2022 15:01:49 +0100
Message-Id: <20221209140150.1453-19-johan+linaro@kernel.org>
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
2.37.4

