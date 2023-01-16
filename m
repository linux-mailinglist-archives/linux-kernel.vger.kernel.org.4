Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99F066C04C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 14:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbjAPNvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 08:51:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbjAPNuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 08:50:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7708321963;
        Mon, 16 Jan 2023 05:50:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E37D60FDE;
        Mon, 16 Jan 2023 13:50:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47EE2C4339B;
        Mon, 16 Jan 2023 13:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673877041;
        bh=xzaP0POiJTvdAArF5s+sRyCE4tI36PeyUYdNU4owoyY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zc9+3pnmtbZ6o82DpGuYgW1tMjj2PtHMP9Upu1/umGP0gbfj8u/zRXpbpei3VP4k3
         yh66TqL50QoPk7mXgdeNbBCpC13H6fm1Ls7zqggb3rogCRORryH9ZxK2eK3jLw4+GS
         nCroqQSwrzlbhN+4ZXOmYg61FG/wVxc0HOrPq5HR7Ty1JcuzJF+5atkBtuTnqx09Bj
         F1OtSt8LptZorWDyyh5Kw/BWMdQ5RifsiBQNdIytp6M67brGBBhO3jIXVhlFAjHi6q
         0WnR5b2/IO2kGUl8OwiQXkItmlXHLJU4kpyoqqAG7zt3dMxFYAuM9geuRWMy/TgGoO
         TNC7j7/KEE6qA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pHPt6-0003vL-OK; Mon, 16 Jan 2023 14:51:00 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Subject: [PATCH v4 14/19] irqchip/gic-v2m: Use irq_domain_create_hierarchy()
Date:   Mon, 16 Jan 2023 14:50:39 +0100
Message-Id: <20230116135044.14998-15-johan+linaro@kernel.org>
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
 drivers/irqchip/irq-gic-v2m.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index f4d7eeb13951..f1e75b35a52a 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -287,15 +287,14 @@ static __init int gicv2m_allocate_domains(struct irq_domain *parent)
 	if (!v2m)
 		return 0;
 
-	inner_domain = irq_domain_create_tree(v2m->fwnode,
-					      &gicv2m_domain_ops, v2m);
+	inner_domain = irq_domain_create_hierarchy(parent, 0, 0, v2m->fwnode,
+						   &gicv2m_domain_ops, v2m);
 	if (!inner_domain) {
 		pr_err("Failed to create GICv2m domain\n");
 		return -ENOMEM;
 	}
 
 	irq_domain_update_bus_token(inner_domain, DOMAIN_BUS_NEXUS);
-	inner_domain->parent = parent;
 	pci_domain = pci_msi_create_irq_domain(v2m->fwnode,
 					       &gicv2m_msi_domain_info,
 					       inner_domain);
-- 
2.38.2

