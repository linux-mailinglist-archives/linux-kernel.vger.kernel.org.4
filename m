Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90C35698A25
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 02:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjBPBiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 20:38:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjBPBio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 20:38:44 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBB8460AF
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 17:38:05 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 24so319384pgt.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 17:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LRWndtf1MfAj2ZhkN4PTYCt6BLCOsDbhtwenSf5gYEI=;
        b=ikG9wYqSon6yeDIZ8/HLH4K6l7GUwJqTSDldmDtiKk0LOcz/BTS7VNLwZoloroz2D9
         oVD4AbiML29i1GxpgZcL46osr4lSsMHnVRsQ9rS+Z00YM67x3toEHXEhCosCp5yKIetC
         RAzHf54kGMjYljwDklADhRgK3YCRYr16I/5zF/1MaWjG9eNDuNPaslKSPphPunImAR+a
         oaf+yIO4Ok0fCJG5J3RlumUqzJAPzUj+FWROrmGx5xRLlffpFh5TPoILkmt+d9EBmE91
         cyIDe7TuwHBO9FB7Hv2qo/8Ft1+cdysWkUrvNOLsPJbtErLjd3ypuvyMbhF0uduCZxzB
         ShOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LRWndtf1MfAj2ZhkN4PTYCt6BLCOsDbhtwenSf5gYEI=;
        b=3voLycvpNxbZpgVLdskSKmjLMXZdmQk5//JpfCEXDu8Pg2OdxS5Z508nCjqtMEXd1r
         3R/VGw1Z/NG2MKJOQepBSqfu8UXPVcK1GldlesO2n+t6lPdNp8bWyHc2yOh01Khh465Z
         sxBkZRJs8Tp55VAD3mpWwovxqTKWF4LcFuiVOSmSsW7jDZkONGQFIL/3IyV1G5GlH5i0
         U7dWiXdIjcdP6lqoujhOeFjRUdnmS7mUzEOqHls9sPrXpO+lTK17BdUXdC8N9ZCDX++2
         Bld8BK00Rd2JEBLVlBj+UC3JFHs7qbaFKmxebJH+FDPh+Ny/90JihsuXLH3uymZwiY1K
         caHA==
X-Gm-Message-State: AO0yUKX0t/oeRMxWLQSlKrUKBEdeq/JtHRmjPd+yxq51F4/hFmLb9dLS
        1wkpE0ikOzOplEC7N3X+3o8=
X-Google-Smtp-Source: AK7set9LEj/YDhRySm8fzqHdYGLT65Td4y7Y6NmEb9R0Bmc5pY2UTnMI0BsHDKrk54W56G/6crxcQA==
X-Received: by 2002:a62:1b52:0:b0:583:9b05:d1f0 with SMTP id b79-20020a621b52000000b005839b05d1f0mr3588869pfb.33.1676511446969;
        Wed, 15 Feb 2023 17:37:26 -0800 (PST)
Received: from y.home.mmyangfl.win ([104.28.245.200])
        by smtp.gmail.com with ESMTPSA id p19-20020aa78613000000b005a8d3d311b8sm22620pfn.22.2023.02.15.17.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 17:37:26 -0800 (PST)
From:   David Yang <mmyangfl@gmail.com>
To:     mmyangfl@gmail.com
Cc:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] phy: hisilicon: Adopt phy-hisi-inno-usb2 to ARM
Date:   Thu, 16 Feb 2023 09:37:13 +0800
Message-Id: <20230216013714.1480736-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hisilicon also uses phy-hisi-inno-usb2 on some ARM32-only SoCs (for
example, Hi3798), with a slightly different register convention.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/phy/hisilicon/Kconfig              |  2 +-
 drivers/phy/hisilicon/phy-hisi-inno-usb2.c | 16 ++++++++++++++--
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/hisilicon/Kconfig b/drivers/phy/hisilicon/Kconfig
index d3b92c288..6c89136fc 100644
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
index b133ae067..624899536 100644
--- a/drivers/phy/hisilicon/phy-hisi-inno-usb2.c
+++ b/drivers/phy/hisilicon/phy-hisi-inno-usb2.c
@@ -20,12 +20,24 @@
 #define PHY_CLK_STABLE_TIME	2	/* unit:ms */
 #define UTMI_RST_COMPLETE_TIME	2	/* unit:ms */
 #define POR_RST_COMPLETE_TIME	300	/* unit:us */
+
 #define PHY_TEST_DATA		GENMASK(7, 0)
+#define PHY_TEST_ADDR_OFFSET	8
+#ifdef CONFIG_ARM64
 #define PHY_TEST_ADDR		GENMASK(15, 8)
+#define PHY_TEST_PORT_OFFSET	16
 #define PHY_TEST_PORT		GENMASK(18, 16)
 #define PHY_TEST_WREN		BIT(21)
 #define PHY_TEST_CLK		BIT(22)	/* rising edge active */
 #define PHY_TEST_RST		BIT(23)	/* low active */
+#else
+#define PHY_TEST_ADDR		GENMASK(11, 8)
+#define PHY_TEST_PORT_OFFSET	12
+#define PHY_TEST_PORT		BIT(12)
+#define PHY_TEST_WREN		BIT(13)
+#define PHY_TEST_CLK		BIT(14)	/* rising edge active */
+#define PHY_TEST_RST		BIT(15)	/* low active */
+#endif
 #define PHY_CLK_ENABLE		BIT(2)
 
 struct hisi_inno_phy_port {
@@ -47,8 +59,8 @@ static void hisi_inno_phy_write_reg(struct hisi_inno_phy_priv *priv,
 	u32 val;
 
 	val = (data & PHY_TEST_DATA) |
-	      ((addr << 8) & PHY_TEST_ADDR) |
-	      ((port << 16) & PHY_TEST_PORT) |
+	      ((addr << PHY_TEST_ADDR_OFFSET) & PHY_TEST_ADDR) |
+	      ((port << PHY_TEST_PORT_OFFSET) & PHY_TEST_PORT) |
 	      PHY_TEST_WREN | PHY_TEST_RST;
 	writel(val, reg);
 
-- 
2.39.1

