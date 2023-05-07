Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B666F961D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 02:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbjEGAjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 20:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbjEGAiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 20:38:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B32C10A;
        Sat,  6 May 2023 17:36:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0E756155C;
        Sun,  7 May 2023 00:36:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88613C4339C;
        Sun,  7 May 2023 00:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683419783;
        bh=Htpo8krxL7BOoqzFGpJA2I0Wp6KsXnO7PzVDxuTr0UU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iemy9mXe7BIlFCKegA/KcCQIrGP1jMF75v4PFxn4hCvMLxVtgsE+yWfyavZjidZci
         xk8JbTxinj06lWMZw73tlSogk5dUjVaGxUGa7GKGxjhHtjyCaF99/iMU4ewrlGOtYu
         VEw1tU7GCKeA9PNa6XJ1L53cXS/FkrhXbqMI+fVVHOy05fW8a348ZGOm8RO8gxPWkD
         GTgQelErSLn3EEd6M/4qTo49KMm4iFJwkgPSSebY+ET8MAoPz5iUYrvF/8ZEvHGJES
         PMdjzmM4UKKt0F6Nj6oP9kA9NcAkzJVt0TZOLoUH7Cipk8w+lVPQqstSNBhvgQI0LG
         uH3ZHr+fWoHFg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kevin Groeneveld <kgroeneveld@lenbrook.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, shawnguo@kernel.org,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 5/9] spi: spi-imx: fix MX51_ECSPI_* macros when cs > 3
Date:   Sat,  6 May 2023 20:36:05 -0400
Message-Id: <20230507003609.4079746-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230507003609.4079746-1-sashal@kernel.org>
References: <20230507003609.4079746-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kevin Groeneveld <kgroeneveld@lenbrook.com>

[ Upstream commit 87c614175bbf28d3fd076dc2d166bac759e41427 ]

When using gpio based chip select the cs value can go outside the range
0 – 3. The various MX51_ECSPI_* macros did not take this into consideration
resulting in possible corruption of the configuration.

For example for any cs value over 3 the SCLKPHA bits would not be set and
other values in the register possibly corrupted.

One way to fix this is to just mask the cs bits to 2 bits. This still
allows all 4 native chip selects to work as well as gpio chip selects
(which can use any of the 4 chip select configurations).

Signed-off-by: Kevin Groeneveld <kgroeneveld@lenbrook.com>
Link: https://lore.kernel.org/r/20230318222132.3373-1-kgroeneveld@lenbrook.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-imx.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 9d593675257e0..67f31183c1180 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -239,6 +239,18 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
 	return true;
 }
 
+/*
+ * Note the number of natively supported chip selects for MX51 is 4. Some
+ * devices may have less actual SS pins but the register map supports 4. When
+ * using gpio chip selects the cs values passed into the macros below can go
+ * outside the range 0 - 3. We therefore need to limit the cs value to avoid
+ * corrupting bits outside the allocated locations.
+ *
+ * The simplest way to do this is to just mask the cs bits to 2 bits. This
+ * still allows all 4 native chip selects to work as well as gpio chip selects
+ * (which can use any of the 4 chip select configurations).
+ */
+
 #define MX51_ECSPI_CTRL		0x08
 #define MX51_ECSPI_CTRL_ENABLE		(1 <<  0)
 #define MX51_ECSPI_CTRL_XCH		(1 <<  2)
@@ -247,16 +259,16 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
 #define MX51_ECSPI_CTRL_DRCTL(drctl)	((drctl) << 16)
 #define MX51_ECSPI_CTRL_POSTDIV_OFFSET	8
 #define MX51_ECSPI_CTRL_PREDIV_OFFSET	12
-#define MX51_ECSPI_CTRL_CS(cs)		((cs) << 18)
+#define MX51_ECSPI_CTRL_CS(cs)		((cs & 3) << 18)
 #define MX51_ECSPI_CTRL_BL_OFFSET	20
 #define MX51_ECSPI_CTRL_BL_MASK		(0xfff << 20)
 
 #define MX51_ECSPI_CONFIG	0x0c
-#define MX51_ECSPI_CONFIG_SCLKPHA(cs)	(1 << ((cs) +  0))
-#define MX51_ECSPI_CONFIG_SCLKPOL(cs)	(1 << ((cs) +  4))
-#define MX51_ECSPI_CONFIG_SBBCTRL(cs)	(1 << ((cs) +  8))
-#define MX51_ECSPI_CONFIG_SSBPOL(cs)	(1 << ((cs) + 12))
-#define MX51_ECSPI_CONFIG_SCLKCTL(cs)	(1 << ((cs) + 20))
+#define MX51_ECSPI_CONFIG_SCLKPHA(cs)	(1 << ((cs & 3) +  0))
+#define MX51_ECSPI_CONFIG_SCLKPOL(cs)	(1 << ((cs & 3) +  4))
+#define MX51_ECSPI_CONFIG_SBBCTRL(cs)	(1 << ((cs & 3) +  8))
+#define MX51_ECSPI_CONFIG_SSBPOL(cs)	(1 << ((cs & 3) + 12))
+#define MX51_ECSPI_CONFIG_SCLKCTL(cs)	(1 << ((cs & 3) + 20))
 
 #define MX51_ECSPI_INT		0x10
 #define MX51_ECSPI_INT_TEEN		(1 <<  0)
-- 
2.39.2

