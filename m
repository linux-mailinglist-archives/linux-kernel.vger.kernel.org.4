Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32ECD732E16
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 12:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344179AbjFPK3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 06:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344479AbjFPK2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 06:28:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C1230F2;
        Fri, 16 Jun 2023 03:26:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52C5B635F7;
        Fri, 16 Jun 2023 10:26:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00EEAC433C9;
        Fri, 16 Jun 2023 10:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686911193;
        bh=gizL6bQhos79Sa4PBqyA7LxHliUG6CHMwXq5ocxr7lA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X/+ve3TqwnQvqrmHzMyzTSoiSfMwM/ZuLuAhmX2CvvktejrC5lNa+yH8WmZE3EcHt
         yqmhqqO2iyds8aqi1plYO0v9+t/1WCD1x+EawdyGO8RsO2rIDtkx9YwegFBYtEX87k
         /+NEYYkGjq1mflNvz+zoyawfz/VNQsMSnSNK/gAmQ1keZkDjXmGp6DGVk56CFiLO6O
         TOxfY1qXHb5KupfGhKEyK0QR7xDpFuB5CYuocwpWIzDTainfe2Mw5kwwCAY2bWYH73
         cNrlZo01EH4t/en/zjfJKBHcPxpDYVGrY2wdvg/3p5uEy1c1EI/R9zqxm2P9AI8yRe
         73xXSzwbG1jSw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Clark Wang <xiaoning.wang@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 05/26] spi: lpspi: disable lpspi module irq in DMA mode
Date:   Fri, 16 Jun 2023 06:26:02 -0400
Message-Id: <20230616102625.673454-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230616102625.673454-1-sashal@kernel.org>
References: <20230616102625.673454-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.34
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Clark Wang <xiaoning.wang@nxp.com>

[ Upstream commit 9728fb3ce11729aa8c276825ddf504edeb00611d ]

When all bits of IER are set to 0, we still can observe the lpspi irq events
when using DMA mode to transfer data.

So disable irq to avoid the too much irq events.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Link: https://lore.kernel.org/r/20230505063557.3962220-1-xiaoning.wang@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-fsl-lpspi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index e8c1c8a4c6c82..9e324d72596af 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -905,9 +905,14 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 	ret = fsl_lpspi_dma_init(&pdev->dev, fsl_lpspi, controller);
 	if (ret == -EPROBE_DEFER)
 		goto out_pm_get;
-
 	if (ret < 0)
 		dev_err(&pdev->dev, "dma setup error %d, use pio\n", ret);
+	else
+		/*
+		 * disable LPSPI module IRQ when enable DMA mode successfully,
+		 * to prevent the unexpected LPSPI module IRQ events.
+		 */
+		disable_irq(irq);
 
 	ret = devm_spi_register_controller(&pdev->dev, controller);
 	if (ret < 0) {
-- 
2.39.2

