Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13327690A2A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 14:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjBINbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 08:31:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjBINaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 08:30:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CC723C7A;
        Thu,  9 Feb 2023 05:30:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF6E661ABA;
        Thu,  9 Feb 2023 13:30:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6404EC4333E;
        Thu,  9 Feb 2023 13:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675949443;
        bh=NTHXrrpZCAJQDbqGQ5Dk1VncIloUIc9A9BrVorjY3xI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nYyAS3/jMTrOrQkqzxE8B5R+kCJA33WHUACgO3u4maL1KI6eOMC6KdVb7sKrAIe2q
         KGQcpdr28joNSS83Q1OENfMsXmQa+Qkj/El7u7axKD7xn+m1EfD8GB4cU8lJdL0HH3
         YA5Ut7l3qrKwJDAG9Gro8Shh7Ki7Dwh82EieJohc9itIMwm8V4YCT5MGMEX1toj4oT
         a9amOFPGN6m4cVkBb8CMZnPo7aWHQYlP0gtS0HUKJsz+PmZI1/FvX6ebJ99pAT0nKm
         b/GOyJ2jehG0MLsv7Xn1q08vi3n0HDR1a6By8/HibtGzFKDwu0+FVQq0u7V0koORm8
         irPz+jBwRRFJg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pQ71H-0001LO-8K; Thu, 09 Feb 2023 14:31:23 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Subject: [PATCH v5 13/19] irqchip/alpine-msi: Use irq_domain_add_hierarchy()
Date:   Thu,  9 Feb 2023 14:23:17 +0100
Message-Id: <20230209132323.4599-14-johan+linaro@kernel.org>
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
2.39.1

