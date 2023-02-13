Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D123694350
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 11:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbjBMKoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 05:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjBMKnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 05:43:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857A416AD9;
        Mon, 13 Feb 2023 02:43:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 753D060FB5;
        Mon, 13 Feb 2023 10:43:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F354C4322D;
        Mon, 13 Feb 2023 10:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676284997;
        bh=xReQQbRP8f3ZcgElG5HL2OX/F0HPnUSW+WJ1I2BgRtE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gdoiOf9PS9M5a8bj/h1JirELfWDz1MVJxqCr+NulstJZ22rF+WQt7n/JmppMxMNyF
         CiwKKUyQz3CDQA4/otENz0FUjvvvcyR2GnVO54ZMRrk9DiPaJNOXcjo0d0fPRbG005
         lEiGNim1/eF6DSZJG0PywpjO+qpSc4db6VJxpwzmx/EA2GbLVC3vGnY/UBl5mwHwYY
         c5lEMKYzOpD1ABoaCh0cW1m/fPcrmMKoZU6gHBOjWoR++ecSm5Vf6wM2AGrtC0OVvx
         srPUaSDdIVR6GZAI7AbRt/SZKr2AZQ1M3anmWZpZZiS4TjAytM9AvYQclKMsII7dxC
         Frn5Q2en7ySJQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pRWJc-0004X6-Gg; Mon, 13 Feb 2023 11:44:08 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Subject: [PATCH v6 18/20] irqchip/loongson-pch-msi: Use irq_domain_create_hierarchy()
Date:   Mon, 13 Feb 2023 11:43:00 +0100
Message-Id: <20230213104302.17307-19-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230213104302.17307-1-johan+linaro@kernel.org>
References: <20230213104302.17307-1-johan+linaro@kernel.org>
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

