Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF26648365
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 15:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbiLIOGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 09:06:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiLIOFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 09:05:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFDD7616D;
        Fri,  9 Dec 2022 06:05:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6395F6227E;
        Fri,  9 Dec 2022 14:05:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D30CC4333B;
        Fri,  9 Dec 2022 14:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670594714;
        bh=1R69EjNecFlegnni2yXQZM+277REaHNNTHY/K11udy0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mnf9JEUD7JHMYGBYApLf75+mZmAgrtsrYJ02sdm8UKC2Sf9WiJgIm5/9s58scqcLB
         iMtYck+IjZHQ5NGdTeNIiuJmq3Ddep6kGCG41Gs/xqAKBavdghFv838rjjAeEhNPIc
         sIvb9Iea8qtCGCdJNHMyAKMcVdsw5vLT1BvE2KC5o0q16uJRIeuvQY0R2Rk5qClBx1
         2G+qwGLcc78nH8cD+NXIR9d1vIvzGqZk6E7N6W4bBb6F4pCELIgbRmNirC7MizYes4
         0RrKS9vJeFfKyuIQnaUo2mBhmMC5AcRArr+t8fATrWgBEKxPZuZsCwpSJ4hEJLgBwO
         xnQDtiWmGSYcA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1p3e0J-0000S7-KN; Fri, 09 Dec 2022 15:05:31 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v3 16/19] irqchip/gic-v3-mbi: Use irq_domain_create_hierarchy()
Date:   Fri,  9 Dec 2022 15:01:47 +0100
Message-Id: <20221209140150.1453-17-johan+linaro@kernel.org>
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
 drivers/irqchip/irq-gic-v3-mbi.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-mbi.c b/drivers/irqchip/irq-gic-v3-mbi.c
index e1efdec9e9ac..dbb8b1efda44 100644
--- a/drivers/irqchip/irq-gic-v3-mbi.c
+++ b/drivers/irqchip/irq-gic-v3-mbi.c
@@ -233,13 +233,12 @@ static int mbi_allocate_domains(struct irq_domain *parent)
 	struct irq_domain *nexus_domain, *pci_domain, *plat_domain;
 	int err;
 
-	nexus_domain = irq_domain_create_tree(parent->fwnode,
-					      &mbi_domain_ops, NULL);
+	nexus_domain = irq_domain_create_hierarchy(parent, 0, 0, parent->fwnode,
+						   &mbi_domain_ops, NULL);
 	if (!nexus_domain)
 		return -ENOMEM;
 
 	irq_domain_update_bus_token(nexus_domain, DOMAIN_BUS_NEXUS);
-	nexus_domain->parent = parent;
 
 	err = mbi_allocate_pci_domain(nexus_domain, &pci_domain);
 
-- 
2.37.4

