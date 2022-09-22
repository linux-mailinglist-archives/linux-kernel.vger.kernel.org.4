Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5F25E65BB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 16:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbiIVOdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 10:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbiIVOd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 10:33:29 -0400
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1F0A3F50BA;
        Thu, 22 Sep 2022 07:33:24 -0700 (PDT)
Received: from NTHCCAS04.nuvoton.com (NTHCCAS04.nuvoton.com [10.1.8.29])
        by maillog.nuvoton.com (Postfix) with ESMTP id E86811C8116A;
        Thu, 22 Sep 2022 22:22:21 +0800 (CST)
Received: from NTHCML01B.nuvoton.com (10.1.8.178) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 22
 Sep 2022 22:22:21 +0800
Received: from NTHCCAS04.nuvoton.com (10.1.8.29) by NTHCML01B.nuvoton.com
 (10.1.8.178) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Thu, 22 Sep
 2022 22:22:21 +0800
Received: from taln60.nuvoton.co.il (10.191.1.180) by NTHCCAS04.nuvoton.com
 (10.1.12.25) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Thu, 22 Sep 2022 22:22:21 +0800
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 8489E637C4; Thu, 22 Sep 2022 17:22:20 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <avifishman70@gmail.com>, <tali.perry1@gmail.com>,
        <joel@jms.id.au>, <venture@google.com>, <yuenn@google.com>,
        <benjaminfair@google.com>, <olivia@selenic.com>,
        <herbert@gondor.apana.org.au>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <openbmc@lists.ozlabs.org>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1 2/2] hwrng: npcm: Add NPCM8XX support
Date:   Thu, 22 Sep 2022 17:22:16 +0300
Message-ID: <20220922142216.17581-3-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220922142216.17581-1-tmaimon77@gmail.com>
References: <20220922142216.17581-1-tmaimon77@gmail.com>
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
- Add NPCM8XX specific clock prescaler.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 drivers/char/hw_random/npcm-rng.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/char/hw_random/npcm-rng.c b/drivers/char/hw_random/npcm-rng.c
index 1ec5f267a656..705be9ccae31 100644
--- a/drivers/char/hw_random/npcm-rng.c
+++ b/drivers/char/hw_random/npcm-rng.c
@@ -18,10 +18,11 @@
 #define NPCM_RNGD_REG		0x04	/* Data register */
 #define NPCM_RNGMODE_REG	0x08	/* Mode register */
 
-#define NPCM_RNG_CLK_SET_25MHZ	GENMASK(4, 3) /* 20-25 MHz */
-#define NPCM_RNG_DATA_VALID	BIT(1)
-#define NPCM_RNG_ENABLE		BIT(0)
-#define NPCM_RNG_M1ROSEL	BIT(1)
+#define NPCM_RNG_CLK_SET_25MHZ		GENMASK(4, 3) /* 20-25 MHz */
+#define NPCM_RNG_CLK_SET_62_5MHZ	BIT(2) /* 60-80 MHz */
+#define NPCM_RNG_DATA_VALID		BIT(1)
+#define NPCM_RNG_ENABLE			BIT(0)
+#define NPCM_RNG_M1ROSEL		BIT(1)
 
 #define NPCM_RNG_TIMEOUT_USEC	20000
 #define NPCM_RNG_POLL_USEC	1000
@@ -31,14 +32,14 @@
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
@@ -47,7 +48,7 @@ static void npcm_rng_cleanup(struct hwrng *rng)
 {
 	struct npcm_rng *priv = to_npcm_rng(rng);
 
-	writel(NPCM_RNG_CLK_SET_25MHZ, priv->base + NPCM_RNGCS_REG);
+	writel(priv->clkp, priv->base + NPCM_RNGCS_REG);
 }
 
 static int npcm_rng_read(struct hwrng *rng, void *buf, size_t max, bool wait)
@@ -102,6 +103,11 @@ static int npcm_rng_probe(struct platform_device *pdev)
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
+	if (of_device_is_compatible(pdev->dev.of_node, "nuvoton,npcm750-rng"))
+		priv->clkp = NPCM_RNG_CLK_SET_25MHZ;
+	if (of_device_is_compatible(pdev->dev.of_node, "nuvoton,npcm845-rng"))
+		priv->clkp = NPCM_RNG_CLK_SET_62_5MHZ;
+
 #ifndef CONFIG_PM
 	priv->rng.init = npcm_rng_init;
 	priv->rng.cleanup = npcm_rng_cleanup;
@@ -163,6 +169,7 @@ static const struct dev_pm_ops npcm_rng_pm_ops = {
 
 static const struct of_device_id rng_dt_id[] __maybe_unused = {
 	{ .compatible = "nuvoton,npcm750-rng",  },
+	{ .compatible = "nuvoton,npcm845-rng",  },
 	{},
 };
 MODULE_DEVICE_TABLE(of, rng_dt_id);
-- 
2.33.0

