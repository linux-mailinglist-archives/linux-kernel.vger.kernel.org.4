Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2F3604AF7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbiJSPP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232819AbiJSPOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:14:36 -0400
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25AD9FDD;
        Wed, 19 Oct 2022 08:07:19 -0700 (PDT)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.94.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1olACX-0000nH-HZ; Wed, 19 Oct 2022 16:37:45 +0200
Date:   Wed, 19 Oct 2022 15:37:35 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-iio@vger.kernel.org
Cc:     David Bauer <mail@david-bauer.net>,
        Gwendal Grignou <gwendal@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] iio: adc: mt6577_auxadc: add optional 32k clock
Message-ID: <f98ed7f3fc15a0614443a57427d46ce17ec2e0cc.1666190235.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MediaTek MT7986 and MT7981 require an additional clock to be brought up
for AUXADC. Add support for that in the driver, similar to how it's
done in MediaTek's SDK[1].

[1]: https://git01.mediatek.com/plugins/gitiles/openwrt/feeds/mtk-openwrt-feeds/+/refs/heads/master/target/linux/mediatek/patches-5.4/500-auxadc-add-auxadc-32k-clk.patch
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/iio/adc/mt6577_auxadc.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/iio/adc/mt6577_auxadc.c b/drivers/iio/adc/mt6577_auxadc.c
index 0e134777bdd248..e28e9691cae22a 100644
--- a/drivers/iio/adc/mt6577_auxadc.c
+++ b/drivers/iio/adc/mt6577_auxadc.c
@@ -42,6 +42,7 @@ struct mtk_auxadc_compatible {
 struct mt6577_auxadc_device {
 	void __iomem *reg_base;
 	struct clk *adc_clk;
+	struct clk *adc_32k_clk;
 	struct mutex lock;
 	const struct mtk_auxadc_compatible *dev_comp;
 };
@@ -227,6 +228,12 @@ static int mt6577_auxadc_resume(struct device *dev)
 		return ret;
 	}
 
+	ret = clk_prepare_enable(adc_dev->adc_32k_clk);
+	if (ret) {
+		pr_err("failed to enable auxadc clock\n");
+		return ret;
+	}
+
 	mt6577_auxadc_mod_reg(adc_dev->reg_base + MT6577_AUXADC_MISC,
 			      MT6577_AUXADC_PDN_EN, 0);
 	mdelay(MT6577_AUXADC_POWER_READY_MS);
@@ -241,6 +248,8 @@ static int mt6577_auxadc_suspend(struct device *dev)
 
 	mt6577_auxadc_mod_reg(adc_dev->reg_base + MT6577_AUXADC_MISC,
 			      0, MT6577_AUXADC_PDN_EN);
+
+	clk_disable_unprepare(adc_dev->adc_32k_clk);
 	clk_disable_unprepare(adc_dev->adc_clk);
 
 	return 0;
@@ -282,6 +291,17 @@ static int mt6577_auxadc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	adc_dev->adc_32k_clk = devm_clk_get_optional(&pdev->dev, "32k");
+	if (IS_ERR(adc_dev->adc_32k_clk)) {
+		dev_err(&pdev->dev, "failed to get auxadc 32k clock\n");
+		return PTR_ERR(adc_dev->adc_32k_clk);
+	}
+	ret = clk_prepare_enable(adc_dev->adc_32k_clk);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to enable auxadc 32k clock\n");
+		return ret;
+	}
+
 	adc_clk_rate = clk_get_rate(adc_dev->adc_clk);
 	if (!adc_clk_rate) {
 		ret = -EINVAL;
@@ -311,6 +331,7 @@ static int mt6577_auxadc_probe(struct platform_device *pdev)
 	mt6577_auxadc_mod_reg(adc_dev->reg_base + MT6577_AUXADC_MISC,
 			      0, MT6577_AUXADC_PDN_EN);
 err_disable_clk:
+	clk_disable_unprepare(adc_dev->adc_32k_clk);
 	clk_disable_unprepare(adc_dev->adc_clk);
 	return ret;
 }
@@ -325,6 +346,7 @@ static int mt6577_auxadc_remove(struct platform_device *pdev)
 	mt6577_auxadc_mod_reg(adc_dev->reg_base + MT6577_AUXADC_MISC,
 			      0, MT6577_AUXADC_PDN_EN);
 
+	clk_disable_unprepare(adc_dev->adc_32k_clk);
 	clk_disable_unprepare(adc_dev->adc_clk);
 
 	return 0;
-- 
2.37.3

