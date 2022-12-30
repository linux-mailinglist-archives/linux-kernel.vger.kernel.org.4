Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0110B65694D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 11:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbiL0KHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 05:07:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiL0KHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 05:07:30 -0500
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755D964C3;
        Tue, 27 Dec 2022 02:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:
         in-reply-to:references;
        bh=PYDm95PWaADa9YxjFLIe4Cqpn1ITTd0IS1l03smDoZI=;
        b=NRKaVERjP8DPCHUa1B+i6P3ve/o20Ki43luqRob99yEHHPV3BdvQx8tteWZBssTlc19fpTU5j+6YM
         +HdiekDTphI0msuVJKGfQvw88BKqaoOXVWfN5jBn87HMA/T0BtmWEd9LZhylJhyY+fSbdmchmvc9kS
         VhelAq6A6RAWzFzd4hFUlgZVrX9Esw+s8kLBIPBb+4B+1hnQGY5OOtnDEcde+UO0IgLQ3IYgFuB7yv
         z9xowIiEbnf+5K2WCAsSjxJ8EKC+SQyLLcTnFwYk8YTeeQlUXTM73efdd38kxASJ4+wt+TyjtkBZKK
         b9/jxjbE3RK26+4+8pFhVqHDGWPccHw==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.5.1460, Stamp: 3], Multi: [Enabled, t: (0.000009,0.012572)], BW: [Enabled, t: (0.000022,0.000001)], RTDA: [Enabled, t: (0.089347), Hit: No, Details: v2.42.0; Id: 15.52ka2i.1gl9gprcr.3ma; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from localhost.localdomain ([78.37.162.181])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Tue, 27 Dec 2022 13:07:11 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     Conor Dooley <conor.dooley@microchip.com>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Ivan Bornyakov <i.bornyakov@metrotek.ru>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        system@metrotek.ru
Subject: [PATCH v3 3/3] fpga: microchip-spi: separate data frame write routine
Date:   Tue, 27 Dec 2022 13:04:50 +0300
Message-Id: <20221227100450.2257-4-i.bornyakov@metrotek.ru>
X-Mailer: git-send-email 2.38.2
In-Reply-To: <20221227100450.2257-1-i.bornyakov@metrotek.ru>
References: <20221227100450.2257-1-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mpf_ops_write() function writes bitstream data to the FPGA by a smaller
frames. Introduce mpf_spi_frame_write() function which is for writing a
single data frame and use it in mpf_ops_write().

No functional changes intended.

Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
---
 drivers/fpga/microchip-spi.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/fpga/microchip-spi.c b/drivers/fpga/microchip-spi.c
index 8d1d9476d0cc..ea92e5d106fa 100644
--- a/drivers/fpga/microchip-spi.c
+++ b/drivers/fpga/microchip-spi.c
@@ -274,9 +274,30 @@ static int mpf_ops_write_init(struct fpga_manager *mgr,
 	return 0;
 }
 
+static int mpf_spi_frame_write(struct mpf_priv *priv, const char *buf)
+{
+	struct spi_transfer xfers[2] = {
+		{
+			.tx_buf = &priv->tx,
+			.len = 1,
+		}, {
+			.tx_buf = buf,
+			.len = MPF_SPI_FRAME_SIZE,
+		},
+	};
+	int ret;
+
+	ret = mpf_poll_status(priv, 0);
+	if (ret < 0)
+		return ret;
+
+	priv->tx = MPF_SPI_FRAME;
+
+	return spi_sync_transfer(priv->spi, xfers, ARRAY_SIZE(xfers));
+}
+
 static int mpf_ops_write(struct fpga_manager *mgr, const char *buf, size_t count)
 {
-	struct spi_transfer xfers[2] = { 0 };
 	struct mpf_priv *priv = mgr->priv;
 	struct device *dev = &mgr->dev;
 	int ret, i;
@@ -287,19 +308,8 @@ static int mpf_ops_write(struct fpga_manager *mgr, const char *buf, size_t count
 		return -EINVAL;
 	}
 
-	xfers[0].tx_buf = &priv->tx;
-	xfers[0].len = 1;
-
 	for (i = 0; i < count / MPF_SPI_FRAME_SIZE; i++) {
-		xfers[1].tx_buf = buf + i * MPF_SPI_FRAME_SIZE;
-		xfers[1].len = MPF_SPI_FRAME_SIZE;
-
-		ret = mpf_poll_status(priv, 0);
-		if (ret >= 0) {
-			priv->tx = MPF_SPI_FRAME;
-			ret = spi_sync_transfer(priv->spi, xfers, ARRAY_SIZE(xfers));
-		}
-
+		ret = mpf_spi_frame_write(priv, buf + i * MPF_SPI_FRAME_SIZE);
 		if (ret) {
 			dev_err(dev, "Failed to write bitstream frame %d/%zu\n",
 				i, count / MPF_SPI_FRAME_SIZE);
-- 
2.38.2


