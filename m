Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59734691A00
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 09:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbjBJI2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 03:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjBJI2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 03:28:50 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0340D366B2;
        Fri, 10 Feb 2023 00:28:48 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4PCn245V7Lz4xpy1;
        Fri, 10 Feb 2023 16:28:44 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
        by mse-fl2.zte.com.cn with SMTP id 31A8STYW020026;
        Fri, 10 Feb 2023 16:28:30 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Fri, 10 Feb 2023 16:28:32 +0800 (CST)
Date:   Fri, 10 Feb 2023 16:28:32 +0800 (CST)
X-Zmail-TransId: 2af963e600304908c39b
X-Mailer: Zmail v1.0
Message-ID: <202302101628321403257@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <ulf.hansson@linaro.org>
Cc:     <kdasu.kdev@gmail.com>, <alcooperx@gmail.com>,
        <bcm-kernel-feedback-list@broadcom.com>, <adrian.hunter@intel.com>,
        <f.fainelli@gmail.com>, <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBtbWM6IHNkaGNpLWJyY21zdGI6IFVzZcKgZGV2bV9wbGF0Zm9ybV9nZXRfYW5kX2lvcmVtYXBfcmVzb3VyY2UoKQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 31A8STYW020026
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63E6003C.000/4PCn245V7Lz4xpy1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ye Xingchen <ye.xingchen@zte.com.cn>

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
---
 drivers/mmc/host/sdhci-brcmstb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index 0a19b7af1d41..4c22337199cf 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -255,7 +255,6 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
 	struct sdhci_brcmstb_priv *priv;
 	u32 actual_clock_mhz;
 	struct sdhci_host *host;
-	struct resource *iomem;
 	struct clk *clk;
 	struct clk *base_clk = NULL;
 	int res;
@@ -291,8 +290,7 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
 	}

 	/* Map in the non-standard CFG registers */
-	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	priv->cfg_regs = devm_ioremap_resource(&pdev->dev, iomem);
+	priv->cfg_regs = devm_platform_get_and_ioremap_resource(pdev, 1, NULL);
 	if (IS_ERR(priv->cfg_regs)) {
 		res = PTR_ERR(priv->cfg_regs);
 		goto err;
-- 
2.25.1
