Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDDF6FBEFB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 08:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234731AbjEIGFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 02:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234707AbjEIGFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 02:05:52 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94DAA257
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 23:05:50 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1aad5245632so38920315ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 23:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683612350; x=1686204350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s2lsYCo4oxUgya16WmGXOkA6dcbuRZDVUqCEBsg8LeM=;
        b=psNYFFoRqXzVRJbUF65ed/Lk9AN38pc5tKdSAz5oVhZRsiOuudb0vUMkrslgSvKWEm
         KlNyA097ebWS3LdoAxPUKu23PxZA4k70BsFvfmHnIFVkIP/wjwJRdd6tJiahyI/wiO95
         u/MulO7WH4sZlhW8Z7PSPw25BbxOzCN1HEbWIKJF7+Q8zOPhuVP5yO/gtdrSjpuctqcO
         Dr/iTxh6YDovylTlDo3c3bCjLbRi1HnNc9+S+y0LhUDymg7TN5ETzh4NR1TtLllwAEh7
         F+ywYl5IqyycDigAa6BjUzqb9YXs+xNbweDJ9OtrvDlryD3TY3wjw3hR5dXycDbM1w5B
         Wf8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683612350; x=1686204350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s2lsYCo4oxUgya16WmGXOkA6dcbuRZDVUqCEBsg8LeM=;
        b=UwNHAXvagmfvIEQq7q6Jo7pd/GHhjExhqJ5OJzyqmmLmrkZNFdi4cuUyAZt4BO+eYs
         x3xHPYLX6LrdGwf/w+za5sEfLK0mdu1HmsgiF+3KoQxXeFEGBeDDhhfS4b9XKGT3O9j3
         PbbuAey0SnrmLJDm9b1NhXWqYZ5AAORnFZxrjFYpGbYT2FNz4ohArHwqK+CVI4jDKNB0
         O9CvUrdsGtFBzfJubMBsjk8e3PMiPHV5XpuDmNIkK90VbqMUgnP/pNujWGo3XQap1AAX
         s6zXYuq7ksev4h9v9vchbK9LV3hcyUUma0zaYrBEKznkhn0oJ8+bLkegut6Ji/opcTnc
         0R/w==
X-Gm-Message-State: AC+VfDwM62Bt1wALlkvoHpKjobtFzqwThmKfyedK5rRAtwWOHmtquhgI
        fqSHTY3UlwdThfpPC8AOm9c=
X-Google-Smtp-Source: ACHHUZ6Qm3TwZmtOPXu2C0eNbLUBqrnNfbWFLLFQQxrqcEcq5bzBdtsOWFKzC2i1A3HdQ1iZerF61w==
X-Received: by 2002:a17:902:db08:b0:1a6:b496:4053 with SMTP id m8-20020a170902db0800b001a6b4964053mr14908706plx.59.1683612350228;
        Mon, 08 May 2023 23:05:50 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.245.199])
        by smtp.gmail.com with ESMTPSA id ay8-20020a1709028b8800b001a9a3b3f931sm582220plb.99.2023.05.08.23.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 23:05:50 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     linux-phy@lists.infradead.org
Cc:     David Yang <mmyangfl@gmail.com>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] phy: hisilicon: Add inno-usb2-phy driver for Hi3798MV100
Date:   Tue,  9 May 2023 14:04:44 +0800
Message-Id: <20230509060449.1151113-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230509060449.1151113-1-mmyangfl@gmail.com>
References: <20230509060449.1151113-1-mmyangfl@gmail.com>
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

Adopt existing phy-hisi-inno-usb2 driver to Hi3798MV100, with a slightly
different TEST register convention.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/phy/hisilicon/phy-hisi-inno-usb2.c | 62 ++++++++++++++++------
 1 file changed, 46 insertions(+), 16 deletions(-)

diff --git a/drivers/phy/hisilicon/phy-hisi-inno-usb2.c b/drivers/phy/hisilicon/phy-hisi-inno-usb2.c
index b133ae06757a..15dafe359552 100644
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
 
@@ -20,12 +20,25 @@
 #define PHY_CLK_STABLE_TIME	2	/* unit:ms */
 #define UTMI_RST_COMPLETE_TIME	2	/* unit:ms */
 #define POR_RST_COMPLETE_TIME	300	/* unit:us */
+
+#define PHY_TYPE_0	0
+#define PHY_TYPE_1	1
+
 #define PHY_TEST_DATA		GENMASK(7, 0)
-#define PHY_TEST_ADDR		GENMASK(15, 8)
-#define PHY_TEST_PORT		GENMASK(18, 16)
-#define PHY_TEST_WREN		BIT(21)
-#define PHY_TEST_CLK		BIT(22)	/* rising edge active */
-#define PHY_TEST_RST		BIT(23)	/* low active */
+#define PHY_TEST_ADDR_OFFSET	8
+#define PHY0_TEST_ADDR		GENMASK(15, 8)
+#define PHY0_TEST_PORT_OFFSET	16
+#define PHY0_TEST_PORT		GENMASK(18, 16)
+#define PHY0_TEST_WREN		BIT(21)
+#define PHY0_TEST_CLK		BIT(22)	/* rising edge active */
+#define PHY0_TEST_RST		BIT(23)	/* low active */
+#define PHY1_TEST_ADDR		GENMASK(11, 8)
+#define PHY1_TEST_PORT_OFFSET	12
+#define PHY1_TEST_PORT		BIT(12)
+#define PHY1_TEST_WREN		BIT(13)
+#define PHY1_TEST_CLK		BIT(14)	/* rising edge active */
+#define PHY1_TEST_RST		BIT(15)	/* low active */
+
 #define PHY_CLK_ENABLE		BIT(2)
 
 struct hisi_inno_phy_port {
@@ -37,6 +50,7 @@ struct hisi_inno_phy_priv {
 	void __iomem *mmio;
 	struct clk *ref_clk;
 	struct reset_control *por_rst;
+	unsigned int type;
 	struct hisi_inno_phy_port ports[INNO_PHY_PORT_NUM];
 };
 
@@ -45,17 +59,27 @@ static void hisi_inno_phy_write_reg(struct hisi_inno_phy_priv *priv,
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
+		val = (data & PHY_TEST_DATA) |
+		      ((addr << PHY_TEST_ADDR_OFFSET) & PHY0_TEST_ADDR) |
+		      ((port << PHY0_TEST_PORT_OFFSET) & PHY0_TEST_PORT) |
+		      PHY0_TEST_WREN | PHY0_TEST_RST;
+	else
+		val = (data & PHY_TEST_DATA) |
+		      ((addr << PHY_TEST_ADDR_OFFSET) & PHY1_TEST_ADDR) |
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
 
@@ -135,6 +159,8 @@ static int hisi_inno_phy_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->por_rst))
 		return PTR_ERR(priv->por_rst);
 
+	priv->type = (uintptr_t) of_device_get_match_data(dev);
+
 	for_each_child_of_node(np, child) {
 		struct reset_control *rst;
 		struct phy *phy;
@@ -170,8 +196,12 @@ static int hisi_inno_phy_probe(struct platform_device *pdev)
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

