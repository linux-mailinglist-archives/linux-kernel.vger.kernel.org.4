Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C19F73138B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 11:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245525AbjFOJVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 05:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245322AbjFOJVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 05:21:14 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4762125;
        Thu, 15 Jun 2023 02:21:12 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35F8aRx3016209;
        Thu, 15 Jun 2023 11:20:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=qPbUB15wIZOIUJ8yrzqh32Nl3JHBM2M82YtjJjGSCD0=;
 b=ClU5UwTTAUSs3D4iPLB3N6q+nrSIqUTUhR/NVipfXdfMQ3kwcGqLR33N6vklgRGmMjUk
 6eBPHy5FdiPhW8rabg9OGe+/8nwX5YaBCgQaUFyu1CSUfd81GJrIuzcrSa9TcTI32kcq
 9xrpc3FpPPyOQ+18paZ55b+hWvdZW6DdmCVtG4CA8II08pufz2+SmFDpUkOm/9HihEwt
 R7lZrfPOGQBlkFOhJJiSoTzNzMnzoTNvzafdqj3kBJVYKUdFOqZmdpwUXLdc5LEjwfO1
 KXMLImD36F8x+Ea/C16X4+rvGqKMUUxVcW6Ur+Qq+tvjKy9r+AFGGak8A2r05kxuMGIM mQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3r7wgx1er0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 11:20:52 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6C49910002A;
        Thu, 15 Jun 2023 11:20:51 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 63A16211F02;
        Thu, 15 Jun 2023 11:20:51 +0200 (CEST)
Received: from localhost (10.201.21.210) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 15 Jun
 2023 11:20:51 +0200
From:   Yann Gautier <yann.gautier@foss.st.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     Conor Dooley <conor+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        <linux-kernel@vger.kernel.org>, Marek Vasut <marex@denx.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Xiang wangx <wangxiang@cdjrlc.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Yann Gautier <yann.gautier@foss.st.com>
Subject: [PATCH 3/6] mmc: mmci: Add support for sdmmc variant revision v3.0
Date:   Thu, 15 Jun 2023 11:19:58 +0200
Message-ID: <20230615092001.1213132-4-yann.gautier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230615092001.1213132-1-yann.gautier@foss.st.com>
References: <20230615092001.1213132-1-yann.gautier@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.21.210]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-15_06,2023-06-14_02,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an update of the SDMMC revision v2.2, with just an increased
FIFO size, from 64B to 1kB.

Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
---
 drivers/mmc/host/mmci.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index eae3d1c8934cb..3c54ab2c59176 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -306,6 +306,34 @@ static struct variant_data variant_stm32_sdmmcv2 = {
 	.init			= sdmmc_variant_init,
 };
 
+static struct variant_data variant_stm32_sdmmcv3 = {
+	.fifosize		= 256 * 4,
+	.fifohalfsize		= 128 * 4,
+	.f_max			= 267000000,
+	.stm32_clkdiv		= true,
+	.cmdreg_cpsm_enable	= MCI_CPSM_STM32_ENABLE,
+	.cmdreg_lrsp_crc	= MCI_CPSM_STM32_LRSP_CRC,
+	.cmdreg_srsp_crc	= MCI_CPSM_STM32_SRSP_CRC,
+	.cmdreg_srsp		= MCI_CPSM_STM32_SRSP,
+	.cmdreg_stop		= MCI_CPSM_STM32_CMDSTOP,
+	.data_cmd_enable	= MCI_CPSM_STM32_CMDTRANS,
+	.irq_pio_mask		= MCI_IRQ_PIO_STM32_MASK,
+	.datactrl_first		= true,
+	.datacnt_useless	= true,
+	.datalength_bits	= 25,
+	.datactrl_blocksz	= 14,
+	.datactrl_any_blocksz	= true,
+	.datactrl_mask_sdio	= MCI_DPSM_ST_SDIOEN,
+	.stm32_idmabsize_mask	= GENMASK(16, 6),
+	.stm32_idmabsize_align	= BIT(6),
+	.dma_lli		= true,
+	.busy_timeout		= true,
+	.busy_detect		= true,
+	.busy_detect_flag	= MCI_STM32_BUSYD0,
+	.busy_detect_mask	= MCI_STM32_BUSYD0ENDMASK,
+	.init			= sdmmc_variant_init,
+};
+
 static struct variant_data variant_qcom = {
 	.fifosize		= 16 * 4,
 	.fifohalfsize		= 8 * 4,
@@ -2500,6 +2528,11 @@ static const struct amba_id mmci_ids[] = {
 		.mask	= 0xf0ffffff,
 		.data	= &variant_stm32_sdmmcv2,
 	},
+	{
+		.id     = 0x00353180,
+		.mask	= 0xf0ffffff,
+		.data	= &variant_stm32_sdmmcv3,
+	},
 	/* Qualcomm variants */
 	{
 		.id     = 0x00051180,
-- 
2.25.1

