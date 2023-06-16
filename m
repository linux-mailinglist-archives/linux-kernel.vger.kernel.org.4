Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3904732EDF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 12:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345348AbjFPKhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 06:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345234AbjFPKeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 06:34:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDF25B96;
        Fri, 16 Jun 2023 03:28:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E1CF6365B;
        Fri, 16 Jun 2023 10:27:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAE7FC433CC;
        Fri, 16 Jun 2023 10:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686911278;
        bh=CBc4GKNO1MRLJg1eKVWqxkEoP1h79fxST86ixGuqN60=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uns5xOILdzecr/CL2OF5+fI2qDgqRwNvfVAE3ESahv5zHA3/o+jHJ0Wz1wvsYghEM
         4uxB0L8P0AY0ILpsAv7i9KCsjR/PcXCEJDytwzgPFwUTH+2swucNeB074dOqn63GSu
         jxaV2DXOG95nBrgVNjkwaY1Y+F2qwGPWASDWnNbESI33upgQscHZz9Nfpw8C/9COR5
         HSD+Y91il7JvduFAJjbAPRyIK0xCfW9pYlXscZVQIQlibAydJMCw7S/QehYJVAZEGy
         LRI386P7VteikmmCTce9YZHIW/XodRacT5AWsG9G9CP9CIW71UnO2W9UZvUimpLWLD
         LbQ02Z0YgoTjw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Clark Wang <xiaoning.wang@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 03/14] spi: lpspi: disable lpspi module irq in DMA mode
Date:   Fri, 16 Jun 2023 06:27:40 -0400
Message-Id: <20230616102753.673975-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230616102753.673975-1-sashal@kernel.org>
References: <20230616102753.673975-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.184
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
index 5d98611dd999d..c5ff6e8c45be0 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -906,9 +906,14 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
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

