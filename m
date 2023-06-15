Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C917731199
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 09:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243803AbjFOH7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 03:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239200AbjFOH7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 03:59:03 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D57110F7;
        Thu, 15 Jun 2023 00:59:02 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35F5X5a9022782;
        Thu, 15 Jun 2023 09:58:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=IICZM+0CNuKTxudZVSBaEPenazQ5zFia5Dy9MALM2tM=;
 b=yqiUe378exOdJLdpUDMVglyTd5oqj5UyIybboip5MTFg078f+1dugjlE5LJZBFiO14Dl
 6AM+3XCW7TSD/zBw2dJinOl4l9E3j8DNRebO2TyrngE6izfji4YNTwdYLDIfOGqTqJhW
 dWZht3RE9cVKK/8E0eK0WWROb5PANMTcD3Uo3b33cYbFmncQHVafPPw7m3STcQOjpRqU
 AjwFZwNHhAHMfrAXAylMtbvDa62J51qr5MocAZLLb4RxOA0FaH9ZrDwDY4GBKvGF6tgw
 CAmXtnrJSL9t0cZYDeFFjQ4OmjECy0c6c9gn5FNgWyReP9At0f43+FUNrmccBR0Ybul1 4A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3r7vkfs3rk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 09:58:49 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DA799100046;
        Thu, 15 Jun 2023 09:58:48 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D3BB621682B;
        Thu, 15 Jun 2023 09:58:48 +0200 (CEST)
Received: from localhost (10.252.8.64) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 15 Jun
 2023 09:58:48 +0200
From:   Valentin Caron <valentin.caron@foss.st.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alain Volmat <alain.volmat@foss.st.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Valentin Caron <valentin.caron@foss.st.com>
Subject: [PATCH v3 2/4] spi: stm32: use dmaengine_terminate_{a}sync instead of _all
Date:   Thu, 15 Jun 2023 09:58:13 +0200
Message-ID: <20230615075815.310261-3-valentin.caron@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230615075815.310261-1-valentin.caron@foss.st.com>
References: <20230615075815.310261-1-valentin.caron@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.252.8.64]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-15_04,2023-06-14_02,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alain Volmat <alain.volmat@foss.st.com>

Avoid usage of deprecated dmaengine_terminate_all and use
dmaengine_terminate_sync and dmaengine_terminate_async instead.

Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
---
 drivers/spi/spi-stm32.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 5d9439ae1c09..82fbd20e8a96 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -657,9 +657,9 @@ static void stm32f4_spi_disable(struct stm32_spi *spi)
 	}
 
 	if (spi->cur_usedma && spi->dma_tx)
-		dmaengine_terminate_all(spi->dma_tx);
+		dmaengine_terminate_async(spi->dma_tx);
 	if (spi->cur_usedma && spi->dma_rx)
-		dmaengine_terminate_all(spi->dma_rx);
+		dmaengine_terminate_async(spi->dma_rx);
 
 	stm32_spi_clr_bits(spi, STM32F4_SPI_CR1, STM32F4_SPI_CR1_SPE);
 
@@ -696,9 +696,9 @@ static void stm32h7_spi_disable(struct stm32_spi *spi)
 	}
 
 	if (spi->cur_usedma && spi->dma_tx)
-		dmaengine_terminate_all(spi->dma_tx);
+		dmaengine_terminate_async(spi->dma_tx);
 	if (spi->cur_usedma && spi->dma_rx)
-		dmaengine_terminate_all(spi->dma_rx);
+		dmaengine_terminate_async(spi->dma_rx);
 
 	stm32_spi_clr_bits(spi, STM32H7_SPI_CR1, STM32H7_SPI_CR1_SPE);
 
@@ -1302,7 +1302,7 @@ static int stm32_spi_transfer_one_dma(struct stm32_spi *spi,
 
 dma_submit_error:
 	if (spi->dma_rx)
-		dmaengine_terminate_all(spi->dma_rx);
+		dmaengine_terminate_sync(spi->dma_rx);
 
 dma_desc_error:
 	stm32_spi_clr_bits(spi, spi->cfg->regs->dma_rx_en.reg,
-- 
2.25.1

