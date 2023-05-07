Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3BC6F997F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 17:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbjEGPqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 11:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjEGPqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 11:46:31 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4690C1942C
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 08:46:30 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-24df758db1cso2455401a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 May 2023 08:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683474390; x=1686066390;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y8aKivAi7Wv2K+b9qOFRY7q/Y6aEZb+fXI+HfgLvAtY=;
        b=IWQeIrrBhyjfUBgVv6Wh33w6v48aO7VzZkM8EMKF+SFX0yjx8VtFTYPK17fFbMFTh/
         VuzKf0jbhnwMFEmpHnY52jBWXjoRJx0NGw2s01N3FpB3r59zKJG7WafML+H+1avV84A4
         fYHxP6SI2dHEauitsNDXUnNOQXrlBtmpzD9XDtVNQd6BkpXT0Ubl3yM+nzUKh1m3b3Y/
         Em57iUDZVUW7TapXi2HWXL6K5GKneID5I72T0+3GBRIQh0SvPqWkrBctdcWt9f10zEKF
         mAUNlsBhtuNxI2qxmF/g2m7t+XVK3058UA3zKhlE3iHRylj7Q/1UXyXkMnpQ6hxmWucV
         Ju1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683474390; x=1686066390;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y8aKivAi7Wv2K+b9qOFRY7q/Y6aEZb+fXI+HfgLvAtY=;
        b=Yr0XwZFoq1A9M088aev9JrY1LVsXNb/hlkityn70aUfRnjeF6NsqO1IKkSpjvfrE6k
         qmWrUu2piSsCdSv7xBJw6EWMQNu3yW6wTgEC1qTmnQlp3Ajb7QJzy9zV22cJOhuNoCN3
         wgvsD2YF+/FjkTfMn8OBsORbNkggh3B7SpjJI3ri+YRMOmULYVoP0fvT5cOXND7ZUSds
         sFPhZMyQ+38M7s2wsNhmkpqkcDwUqbxQvx5NJpruL6RzulmLPTDAB3niXdZMJpLyQlCr
         b+87IE9XmSChb1SK89dDFFUPbv7IovS6CbNl97NHIT9+Z06gt1ZTySAhFnkSVgsTTupz
         EmxA==
X-Gm-Message-State: AC+VfDy7ZHOQT53tIPf+YOn4RZwiuqL7ja0M/li9KiQx3I6C/1pK39q2
        wiEc4gmOqqXFWU6Bfs/Ylj4=
X-Google-Smtp-Source: ACHHUZ7fXwEHFJWMIGi2C6hX1o1O32KJp/bnu5d36edYQAkpBmZY3MGbD+142FU0VyJLxKHTLXzkAg==
X-Received: by 2002:a17:90a:c908:b0:24e:b0f:8f57 with SMTP id v8-20020a17090ac90800b0024e0b0f8f57mr7008565pjt.48.1683474389605;
        Sun, 07 May 2023 08:46:29 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.245.199])
        by smtp.gmail.com with ESMTPSA id b3-20020a17090ae38300b0024e47016966sm12989470pjz.1.2023.05.07.08.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 08:46:29 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     linux-phy@lists.infradead.org
Cc:     David Yang <mmyangfl@gmail.com>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] phy: hisilicon: Adopt phy-hisi-inno-usb2 to Hi3798MV100
Date:   Sun,  7 May 2023 23:46:10 +0800
Message-Id: <20230507154615.793942-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hisilicon also uses phy-hisi-inno-usb2 on Hi3798MV100, with a slightly
different register convention.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/phy/hisilicon/Kconfig              |  2 +-
 drivers/phy/hisilicon/phy-hisi-inno-usb2.c | 67 ++++++++++++++++------
 2 files changed, 51 insertions(+), 18 deletions(-)

diff --git a/drivers/phy/hisilicon/Kconfig b/drivers/phy/hisilicon/Kconfig
index d3b92c288554..6c89136fc8c2 100644
--- a/drivers/phy/hisilicon/Kconfig
+++ b/drivers/phy/hisilicon/Kconfig
@@ -54,7 +54,7 @@ config PHY_HISTB_COMBPHY
 
 config PHY_HISI_INNO_USB2
 	tristate "HiSilicon INNO USB2 PHY support"
-	depends on (ARCH_HISI && ARM64) || COMPILE_TEST
+	depends on ARCH_HISI || COMPILE_TEST
 	select GENERIC_PHY
 	select MFD_SYSCON
 	help
diff --git a/drivers/phy/hisilicon/phy-hisi-inno-usb2.c b/drivers/phy/hisilicon/phy-hisi-inno-usb2.c
index b133ae06757a..b5d006f38934 100644
--- a/drivers/phy/hisilicon/phy-hisi-inno-usb2.c
+++ b/drivers/phy/hisilicon/phy-hisi-inno-usb2.c
@@ -9,7 +9,7 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/module.h>
-#include <linux/platform_device.h>
+#include <linux/of_device.h>
 #include <linux/phy/phy.h>
 #include <linux/reset.h>
 
@@ -20,12 +20,28 @@
 #define PHY_CLK_STABLE_TIME	2	/* unit:ms */
 #define UTMI_RST_COMPLETE_TIME	2	/* unit:ms */
 #define POR_RST_COMPLETE_TIME	300	/* unit:us */
-#define PHY_TEST_DATA		GENMASK(7, 0)
-#define PHY_TEST_ADDR		GENMASK(15, 8)
-#define PHY_TEST_PORT		GENMASK(18, 16)
-#define PHY_TEST_WREN		BIT(21)
-#define PHY_TEST_CLK		BIT(22)	/* rising edge active */
-#define PHY_TEST_RST		BIT(23)	/* low active */
+
+#define PHY_TYPE_0	0
+#define PHY_TYPE_1	1
+
+#define PHY0_TEST_DATA		GENMASK(7, 0)
+#define PHY0_TEST_ADDR_OFFSET	8
+#define PHY0_TEST_ADDR		GENMASK(15, 8)
+#define PHY0_TEST_PORT_OFFSET	16
+#define PHY0_TEST_PORT		GENMASK(18, 16)
+#define PHY0_TEST_WREN		BIT(21)
+#define PHY0_TEST_CLK		BIT(22)	/* rising edge active */
+#define PHY0_TEST_RST		BIT(23)	/* low active */
+
+#define PHY1_TEST_DATA		GENMASK(7, 0)
+#define PHY1_TEST_ADDR_OFFSET	8
+#define PHY1_TEST_ADDR		GENMASK(11, 8)
+#define PHY1_TEST_PORT_OFFSET	12
+#define PHY1_TEST_PORT		BIT(12)
+#define PHY1_TEST_WREN		BIT(13)
+#define PHY1_TEST_CLK		BIT(14)	/* rising edge active */
+#define PHY1_TEST_RST		BIT(15)	/* low active */
+
 #define PHY_CLK_ENABLE		BIT(2)
 
 struct hisi_inno_phy_port {
@@ -37,6 +53,7 @@ struct hisi_inno_phy_priv {
 	void __iomem *mmio;
 	struct clk *ref_clk;
 	struct reset_control *por_rst;
+	unsigned int type;
 	struct hisi_inno_phy_port ports[INNO_PHY_PORT_NUM];
 };
 
@@ -45,17 +62,27 @@ static void hisi_inno_phy_write_reg(struct hisi_inno_phy_priv *priv,
 {
 	void __iomem *reg = priv->mmio;
 	u32 val;
-
-	val = (data & PHY_TEST_DATA) |
-	      ((addr << 8) & PHY_TEST_ADDR) |
-	      ((port << 16) & PHY_TEST_PORT) |
-	      PHY_TEST_WREN | PHY_TEST_RST;
+	u32 value;
+
+	if (priv->type == PHY_TYPE_0)
+		val = (data & PHY0_TEST_DATA) |
+		      ((addr << PHY0_TEST_ADDR_OFFSET) & PHY0_TEST_ADDR) |
+		      ((port << PHY0_TEST_PORT_OFFSET) & PHY0_TEST_PORT) |
+		      PHY0_TEST_WREN | PHY0_TEST_RST;
+	else
+		val = (data & PHY1_TEST_DATA) |
+		      ((addr << PHY1_TEST_ADDR_OFFSET) & PHY1_TEST_ADDR) |
+		      ((port << PHY1_TEST_PORT_OFFSET) & PHY1_TEST_PORT) |
+		      PHY1_TEST_WREN | PHY1_TEST_RST;
 	writel(val, reg);
 
-	val |= PHY_TEST_CLK;
-	writel(val, reg);
+	value = val;
+	if (priv->type == PHY_TYPE_0)
+		value |= PHY0_TEST_CLK;
+	else
+		value |= PHY1_TEST_CLK;
+	writel(value, reg);
 
-	val &= ~PHY_TEST_CLK;
 	writel(val, reg);
 }
 
@@ -135,6 +162,8 @@ static int hisi_inno_phy_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->por_rst))
 		return PTR_ERR(priv->por_rst);
 
+	priv->type = (unsigned int) of_device_get_match_data(dev);
+
 	for_each_child_of_node(np, child) {
 		struct reset_control *rst;
 		struct phy *phy;
@@ -170,8 +199,12 @@ static int hisi_inno_phy_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id hisi_inno_phy_of_match[] = {
-	{ .compatible = "hisilicon,inno-usb2-phy", },
-	{ .compatible = "hisilicon,hi3798cv200-usb2-phy", },
+	{ .compatible = "hisilicon,inno-usb2-phy",
+	  .data = (void *) PHY_TYPE_0 },
+	{ .compatible = "hisilicon,hi3798cv200-usb2-phy",
+	  .data = (void *) PHY_TYPE_0 },
+	{ .compatible = "hisilicon,hi3798mv100-usb2-phy",
+	  .data = (void *) PHY_TYPE_1 },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, hisi_inno_phy_of_match);
-- 
2.39.2

