Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 018B65EF697
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 15:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235220AbiI2Nbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 09:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234920AbiI2Nbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 09:31:32 -0400
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0857213746B;
        Thu, 29 Sep 2022 06:31:27 -0700 (PDT)
Received: from NTHCCAS01.nuvoton.com (NTHCCAS01.nuvoton.com [10.1.8.28])
        by maillog.nuvoton.com (Postfix) with ESMTP id 458B51C8121D;
        Thu, 29 Sep 2022 21:31:27 +0800 (CST)
Received: from NTHCCAS03.nuvoton.com (10.1.20.28) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 29 Sep
 2022 21:31:27 +0800
Received: from NTHCCAS04.nuvoton.com (10.1.8.29) by NTHCCAS03.nuvoton.com
 (10.1.20.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1847.3; Thu, 29 Sep
 2022 21:31:26 +0800
Received: from taln60.nuvoton.co.il (10.191.1.180) by NTHCCAS04.nuvoton.com
 (10.1.12.25) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Thu, 29 Sep 2022 21:31:26 +0800
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 0DAF163A20; Thu, 29 Sep 2022 16:31:25 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <avifishman70@gmail.com>, <tali.perry1@gmail.com>,
        <joel@jms.id.au>, <venture@google.com>, <yuenn@google.com>,
        <benjaminfair@google.com>, <olivia@selenic.com>,
        <herbert@gondor.apana.org.au>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <openbmc@lists.ozlabs.org>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v2 2/2] hwrng: npcm: Add NPCM8XX support
Date:   Thu, 29 Sep 2022 16:31:11 +0300
Message-ID: <20220929133111.73897-3-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220929133111.73897-1-tmaimon77@gmail.com>
References: <20220929133111.73897-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding RNG NPCM8XX support to NPCM RNG driver.
RNG NPCM8XX uses a different clock prescaler.

As part of adding NPCM8XX support:
- Add NPCM8XX specific compatible string.
- Add data to handle architecture specific clock prescaler.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 drivers/char/hw_random/npcm-rng.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/char/hw_random/npcm-rng.c b/drivers/char/hw_random/npcm-rng.c
index 1ec5f267a656..5bf7f370f985 100644
--- a/drivers/char/hw_random/npcm-rng.c
+++ b/drivers/char/hw_random/npcm-rng.c
@@ -13,11 +13,13 @@
 #include <linux/delay.h>
 #include <linux/of_irq.h>
 #include <linux/pm_runtime.h>
+#include <linux/of_device.h>
 
 #define NPCM_RNGCS_REG		0x00	/* Control and status register */
 #define NPCM_RNGD_REG		0x04	/* Data register */
 #define NPCM_RNGMODE_REG	0x08	/* Mode register */
 
+#define NPCM_RNG_CLK_SET_62_5MHZ	BIT(2) /* 60-80 MHz */
 #define NPCM_RNG_CLK_SET_25MHZ	GENMASK(4, 3) /* 20-25 MHz */
 #define NPCM_RNG_DATA_VALID	BIT(1)
 #define NPCM_RNG_ENABLE		BIT(0)
@@ -31,14 +33,14 @@
 struct npcm_rng {
 	void __iomem *base;
 	struct hwrng rng;
+	u32 clkp;
 };
 
 static int npcm_rng_init(struct hwrng *rng)
 {
 	struct npcm_rng *priv = to_npcm_rng(rng);
 
-	writel(NPCM_RNG_CLK_SET_25MHZ | NPCM_RNG_ENABLE,
-	       priv->base + NPCM_RNGCS_REG);
+	writel(priv->clkp | NPCM_RNG_ENABLE, priv->base + NPCM_RNGCS_REG);
 
 	return 0;
 }
@@ -47,7 +49,7 @@ static void npcm_rng_cleanup(struct hwrng *rng)
 {
 	struct npcm_rng *priv = to_npcm_rng(rng);
 
-	writel(NPCM_RNG_CLK_SET_25MHZ, priv->base + NPCM_RNGCS_REG);
+	writel(priv->clkp, priv->base + NPCM_RNGCS_REG);
 }
 
 static int npcm_rng_read(struct hwrng *rng, void *buf, size_t max, bool wait)
@@ -110,6 +112,7 @@ static int npcm_rng_probe(struct platform_device *pdev)
 	priv->rng.read = npcm_rng_read;
 	priv->rng.priv = (unsigned long)&pdev->dev;
 	priv->rng.quality = 1000;
+	priv->clkp = (u32)(uintptr_t)of_device_get_match_data(&pdev->dev);
 
 	writel(NPCM_RNG_M1ROSEL, priv->base + NPCM_RNGMODE_REG);
 
@@ -162,7 +165,10 @@ static const struct dev_pm_ops npcm_rng_pm_ops = {
 };
 
 static const struct of_device_id rng_dt_id[] __maybe_unused = {
-	{ .compatible = "nuvoton,npcm750-rng",  },
+	{ .compatible = "nuvoton,npcm750-rng",
+		.data = (void *)NPCM_RNG_CLK_SET_25MHZ },
+	{ .compatible = "nuvoton,npcm845-rng",
+		.data = (void *)NPCM_RNG_CLK_SET_62_5MHZ },
 	{},
 };
 MODULE_DEVICE_TABLE(of, rng_dt_id);
-- 
2.33.0

