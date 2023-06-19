Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8541D73563C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 13:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjFSLws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 07:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbjFSLwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 07:52:42 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026A9197;
        Mon, 19 Jun 2023 04:52:40 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35JAiSwU006656;
        Mon, 19 Jun 2023 13:52:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=5EhAdfqRxv12KVPD6eaexHq1m9nURohDH2wpSyU/l+A=;
 b=bo9PMscGCSIUOZR6kP4pPNRAs7IQEDAiI58uvq7i726QNfsZPiIuLCxQNR16tefNHJ1+
 nBHTc7I/NxZnFjbkB3BmVx2yLX0hY81zKhorkgeB/Sf6do9W6UwGx3dva41+OmQS0bif
 Hu+JItVJLhE74BHulZeG15xCLK7t2Oesb8Dwa+iFqgeOyrEwWC86svVWZ972uupQwC7E
 xigkl6Yj3/mLDviaQv8J/ih9RHLyNK+3Sf0KvrSikEVoegNGhPA7/u1oQbEB1+VOmi2G
 blqaFwRpT08X2SBQtRvmLzbMU14lJDZWvI4ABqfa9khTMKbMlGBuYfA2r8RvEloHAWVx 5A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3raka81ctw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jun 2023 13:52:00 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0726610002A;
        Mon, 19 Jun 2023 13:52:00 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id EF0D62128D2;
        Mon, 19 Jun 2023 13:51:59 +0200 (CEST)
Received: from localhost (10.201.21.210) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Mon, 19 Jun
 2023 13:51:57 +0200
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
Subject: [PATCH v2 2/6] mmc: mmci: add stm32_idmabsize_align parameter
Date:   Mon, 19 Jun 2023 13:51:16 +0200
Message-ID: <20230619115120.64474-3-yann.gautier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230619115120.64474-1-yann.gautier@foss.st.com>
References: <20230619115120.64474-1-yann.gautier@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.21.210]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-19_08,2023-06-16_01,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The alignment for the IDMA size depends on the peripheral version, it
should then be configurable. Add stm32_idmabsize_align in the variant
structure.
And remove now unused (and wrong) MMCI_STM32_IDMABNDT_* macros.

Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
---
 drivers/mmc/host/mmci.c             | 2 ++
 drivers/mmc/host/mmci.h             | 3 +--
 drivers/mmc/host/mmci_stm32_sdmmc.c | 4 ++--
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 726bf772b2e2d..eae3d1c8934cb 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -270,6 +270,7 @@ static struct variant_data variant_stm32_sdmmc = {
 	.datactrl_any_blocksz	= true,
 	.datactrl_mask_sdio	= MCI_DPSM_ST_SDIOEN,
 	.stm32_idmabsize_mask	= GENMASK(12, 5),
+	.stm32_idmabsize_align	= BIT(5),
 	.busy_timeout		= true,
 	.busy_detect		= true,
 	.busy_detect_flag	= MCI_STM32_BUSYD0,
@@ -296,6 +297,7 @@ static struct variant_data variant_stm32_sdmmcv2 = {
 	.datactrl_any_blocksz	= true,
 	.datactrl_mask_sdio	= MCI_DPSM_ST_SDIOEN,
 	.stm32_idmabsize_mask	= GENMASK(16, 5),
+	.stm32_idmabsize_align	= BIT(5),
 	.dma_lli		= true,
 	.busy_timeout		= true,
 	.busy_detect		= true,
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 12a7bbd3ce263..b1968cafc58bb 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -227,8 +227,6 @@
 #define MMCI_STM32_IDMALLIEN	BIT(1)
 
 #define MMCI_STM32_IDMABSIZER		0x054
-#define MMCI_STM32_IDMABNDT_SHIFT	5
-#define MMCI_STM32_IDMABNDT_MASK	GENMASK(12, 5)
 
 #define MMCI_STM32_IDMABASE0R	0x058
 
@@ -374,6 +372,7 @@ struct variant_data {
 	u32			opendrain;
 	u8			dma_lli:1;
 	u32			stm32_idmabsize_mask;
+	u32			stm32_idmabsize_align;
 	void (*init)(struct mmci_host *host);
 };
 
diff --git a/drivers/mmc/host/mmci_stm32_sdmmc.c b/drivers/mmc/host/mmci_stm32_sdmmc.c
index 50292f9c69046..7f43506b9bb08 100644
--- a/drivers/mmc/host/mmci_stm32_sdmmc.c
+++ b/drivers/mmc/host/mmci_stm32_sdmmc.c
@@ -15,7 +15,6 @@
 #include "mmci.h"
 
 #define SDMMC_LLI_BUF_LEN	PAGE_SIZE
-#define SDMMC_IDMA_BURST	BIT(MMCI_STM32_IDMABNDT_SHIFT)
 
 #define DLYB_CR			0x0
 #define DLYB_CR_DEN		BIT(0)
@@ -69,7 +68,8 @@ static int sdmmc_idma_validate_data(struct mmci_host *host,
 	idma->use_bounce_buffer = false;
 	for_each_sg(data->sg, sg, data->sg_len - 1, i) {
 		if (!IS_ALIGNED(sg->offset, sizeof(u32)) ||
-		    !IS_ALIGNED(sg->length, SDMMC_IDMA_BURST)) {
+		    !IS_ALIGNED(sg->length,
+				host->variant->stm32_idmabsize_align)) {
 			dev_dbg(mmc_dev(host->mmc),
 				"unaligned scatterlist: ofst:%x length:%d\n",
 				data->sg->offset, data->sg->length);
-- 
2.25.1

