Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3ACE6F954B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 02:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjEGAbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 20:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbjEGAbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 20:31:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EB61A105;
        Sat,  6 May 2023 17:31:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04F2A61378;
        Sun,  7 May 2023 00:30:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F90FC433A4;
        Sun,  7 May 2023 00:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683419458;
        bh=nFzYe1ZFmcKtA76E4tjTrkRVurLuHPfcmozlM5lGDGI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ue8RdGM93cJgNb8BC0ytcKuTAXLLR7pb0l+P/RS9EmMu4kf2UoLPkCh8FQRZNstyZ
         R8c+PJiwCornwatG0K83p4OGwVl6RogmcHe5HTAuE4qeAMKplsPDArtsg09TTzDSkS
         v+KNoxJd+6FWSiLZo66BKgTWahxXIxOOEzlITcdwm1/sTqTw4salxvnMh8Sw2eGjXj
         nIZYSudQotBC059xwYYp8FEA2FkIlu4JXo5CJe+clvjy7inDXjG/s3gZpae5i6WpTd
         QY2AYxGEOY5HSOlyE/3yt3JoFBYHtc/7LoQy2TPHUIVflKYICN0AIKvfzb/4oxtQFv
         DOU6/dixguh8g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kevin Groeneveld <kgroeneveld@lenbrook.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, shawnguo@kernel.org,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.3 13/24] spi: spi-imx: fix MX51_ECSPI_* macros when cs > 3
Date:   Sat,  6 May 2023 20:30:09 -0400
Message-Id: <20230507003022.4070535-13-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230507003022.4070535-1-sashal@kernel.org>
References: <20230507003022.4070535-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
index e4ccd0c329d06..c61c7ac4c70c4 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -252,6 +252,18 @@ static bool spi_imx_can_dma(struct spi_controller *controller, struct spi_device
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
@@ -260,16 +272,16 @@ static bool spi_imx_can_dma(struct spi_controller *controller, struct spi_device
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

