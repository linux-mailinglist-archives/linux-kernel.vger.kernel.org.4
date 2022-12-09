Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8025C648369
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 15:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbiLIOGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 09:06:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiLIOFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 09:05:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57EF76158;
        Fri,  9 Dec 2022 06:05:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 06F03B82888;
        Fri,  9 Dec 2022 14:05:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39586C43336;
        Fri,  9 Dec 2022 14:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670594714;
        bh=UP2+AxwTenj8IrLgN7iAfjLcXLHT12juB5rPhe2Zwxc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BpiDKarNH9X0K6qACc5wCbNpoj3PrvLBH3ImpbDVxAxxji2VVF4P849xUehHurjyX
         t/kNzu4eYQt+hcnRpVw/dzMaltG99Z277c3qMosBOIHyxJNhppT/gnExeOPO5PKg6Y
         YSddxp4S+zfGSnuYnWT7LUyRzLcEjju4Mjr7PjLEKYM2/TQAPqUysd+44AuqKUe/oV
         N6eGq6TqROl5p/7FDNCrvnWWbp3qa2e2ExaNC2Ptb5qd3EAMJvwBVtRuJ9sGi86DBs
         hIFXZ5zNcVYmc9br2fVUYWoHw3M8SOI1VvlAbHPk3cFYRer2PeolbfSauun3/Ci2x5
         StOGXJZ8dldiQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1p3e0J-0000S4-Hq; Fri, 09 Dec 2022 15:05:31 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v3 15/19] irqchip/gic-v3-its: Use irq_domain_create_hierarchy()
Date:   Fri,  9 Dec 2022 15:01:46 +0100
Message-Id: <20221209140150.1453-16-johan+linaro@kernel.org>
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

Note that the domain host_data was first set to the struct its_node
during allocation only to immediately be overwritten with the struct
msi_domain_info.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 973ede0197e3..5634d29b644d 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -4909,18 +4909,19 @@ static int its_init_domain(struct fwnode_handle *handle, struct its_node *its)
 	if (!info)
 		return -ENOMEM;
 
-	inner_domain = irq_domain_create_tree(handle, &its_domain_ops, its);
+	info->ops = &its_msi_domain_ops;
+	info->data = its;
+
+	inner_domain = irq_domain_create_hierarchy(its_parent,
+						   its->msi_domain_flags, 0,
+						   handle, &its_domain_ops,
+						   info);
 	if (!inner_domain) {
 		kfree(info);
 		return -ENOMEM;
 	}
 
-	inner_domain->parent = its_parent;
 	irq_domain_update_bus_token(inner_domain, DOMAIN_BUS_NEXUS);
-	inner_domain->flags |= its->msi_domain_flags;
-	info->ops = &its_msi_domain_ops;
-	info->data = its;
-	inner_domain->host_data = info;
 
 	return 0;
 }
-- 
2.37.4

