Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92396648366
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 15:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbiLIOGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 09:06:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiLIOFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 09:05:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73EDB7683F;
        Fri,  9 Dec 2022 06:05:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 603476227D;
        Fri,  9 Dec 2022 14:05:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20BDEC433D2;
        Fri,  9 Dec 2022 14:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670594714;
        bh=9AtJSfDyD2LZYkx9jto+1enajKmHrHjk2oxsdGhfsTI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LQH/23aQv5CuTQY+WSVZhYoXYYPKe6yGP1JpGCGS4WwGIs95UD34/oFrns8IfdXbb
         kjRAvMWLf3p5JqVYlg10HwURYxs7WqpDpqDM5cK2SGKIrxzHrv1v+C6g0N340RjwSw
         2eLqhphBx0Pww1X072puzRf/Ag9/cpnverpYZS444l2SEsNGj70hDSF3MgQhNYF83k
         r0aIP18jRdwkwi+9SRwUDPoeEbCscYT2eW0fWFVqLej9t5pHUkPUzqiQHl0KsIe9kR
         gEdFN0uxhpNhLBIrhQKvvGmOTyOH6TSY9b5gRuxSNk538JAR6veJDICDg0zoLfCPoM
         oN3icrx9blW0g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1p3e0J-0000Ry-Bh; Fri, 09 Dec 2022 15:05:31 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v3 13/19] irqchip/alpine-msi: Use irq_domain_add_hierarchy()
Date:   Fri,  9 Dec 2022 15:01:44 +0100
Message-Id: <20221209140150.1453-14-johan+linaro@kernel.org>
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

Use the irq_domain_add_hierarchy() helper to create the hierarchical
domain, which both serves as documentation and avoids poking at
irqdomain internals.

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
2.37.4

