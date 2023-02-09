Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7E6690A38
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 14:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjBINbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 08:31:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjBINau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 08:30:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A635D1E7;
        Thu,  9 Feb 2023 05:30:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9D6A2B82142;
        Thu,  9 Feb 2023 13:30:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98055C43230;
        Thu,  9 Feb 2023 13:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675949443;
        bh=g3QrnnkP4AAAVKLpcN2UD/9G9Q9P7im2mBObh2fnrA8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CkTHK1i6/q2BiBNnNFiXZGehf02okV9w7aXbdoVBUGKhxm/ZOy/WdxFYkV3C+AR2W
         hSOuovBe2MMCeH2zrtrst80tTqqR4ybYCS0K9TRvbZGR9Pzi0y/9qTKxSrTtV7hgkX
         BsX/PN9wURKcGjxuCmdmxshBG6mpTBm+ndhG7MUUmiZgI9387L7YyAM9TcYbJhsr0t
         1JXMz6/sOpitjHhN4UhTc6JZ9a7HrjvXzyL7OJjbeYdssAbpFFk3h8jnikP4AmHGPN
         TrP6BmBnAFVeFjpDlrLi67UZNEjOjSapzt0Wn5VVtTXQ2cLyZ1xBDQJUhELmzaT4PI
         eOhuxnZoG2NJg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pQ71H-0001LX-GH; Thu, 09 Feb 2023 14:31:23 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Subject: [PATCH v5 16/19] irqchip/gic-v3-mbi: Use irq_domain_create_hierarchy()
Date:   Thu,  9 Feb 2023 14:23:20 +0100
Message-Id: <20230209132323.4599-17-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230209132323.4599-1-johan+linaro@kernel.org>
References: <20230209132323.4599-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
2.39.1

