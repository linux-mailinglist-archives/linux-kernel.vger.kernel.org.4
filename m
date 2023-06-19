Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAF9735641
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 13:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjFSLxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 07:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjFSLxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 07:53:03 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9968E62;
        Mon, 19 Jun 2023 04:52:57 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35JAiSNJ006661;
        Mon, 19 Jun 2023 13:52:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=KAp7zfvpG6cF2t99BxBFfJf+xPwiHLcRjGpIqYuYpuY=;
 b=6V9Z5ViwLWY6yLINI/QbP/SZAqRtN+S4xIq70rRd8iwpHEhXWIsVV6i9k98MNAQI62ft
 wL1leSs5j7qo+1DQKxGETx58ovd312JQUr5XrqcKSovE1KFS86epJsdRVcM5+S31zaNR
 onDC1dIEdJPvbvW52qAbNJ/j2USAypb+SZkak7sVUcknSBOKlvPxMk83LhOQwrW03Uiq
 cUfFgka2EZ9YgNy/32okPQHDTf+uugbV3v/j/XcsoqzyUq7fHYbJjAWwi3LrG7U79QXJ
 KGkvbSBmuRTaiVSKxDe936S/Osxo4vuoUmy6eWL7YMam7ZnhWV6TKc6v5d+w7SvjttU4 rA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3raka81cw0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jun 2023 13:52:38 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BF2CB100051;
        Mon, 19 Jun 2023 13:52:37 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B7995228A33;
        Mon, 19 Jun 2023 13:52:37 +0200 (CEST)
Received: from localhost (10.201.21.210) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Mon, 19 Jun
 2023 13:52:36 +0200
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
Subject: [PATCH v2 4/6] mmc: mmci: stm32: manage block gap hardware flow control
Date:   Mon, 19 Jun 2023 13:51:18 +0200
Message-ID: <20230619115120.64474-5-yann.gautier@foss.st.com>
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

In stm32 sdmmc variant revision v3.0, a block gap hardware flow control
should be used with bus speed modes SDR104 and HS200.
It is enabled by writing a non-null value to the new added register
MMCI_STM32_FIFOTHRR.
The threshold will be 2^(N-1) bytes, so we can use the ffs() function to
compute the value N to be written to the register. The threshold used
should be the data block size, but must not be bigger than the FIFO size.

Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
---
 drivers/mmc/host/mmci.h             |  5 +++++
 drivers/mmc/host/mmci_stm32_sdmmc.c | 13 +++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index b1968cafc58bb..361954249d04d 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -218,6 +218,11 @@
 #define MCI_STM32_BUSYD0ENDMASK	BIT(21)
 
 #define MMCIMASK1		0x040
+
+/* STM32 sdmmc data FIFO threshold register */
+#define MMCI_STM32_FIFOTHRR	0x044
+#define MMCI_STM32_THR_MASK	GENMASK(3, 0)
+
 #define MMCIFIFOCNT		0x048
 #define MMCIFIFO		0x080 /* to 0x0bc */
 
diff --git a/drivers/mmc/host/mmci_stm32_sdmmc.c b/drivers/mmc/host/mmci_stm32_sdmmc.c
index 7f43506b9bb08..0dc1ae674f44c 100644
--- a/drivers/mmc/host/mmci_stm32_sdmmc.c
+++ b/drivers/mmc/host/mmci_stm32_sdmmc.c
@@ -361,6 +361,19 @@ static u32 sdmmc_get_dctrl_cfg(struct mmci_host *host)
 
 	datactrl = mmci_dctrl_blksz(host);
 
+	if (host->hw_revision >= 3) {
+		u32 thr = 0;
+
+		if (host->mmc->ios.timing == MMC_TIMING_UHS_SDR104 ||
+		    host->mmc->ios.timing == MMC_TIMING_MMC_HS200) {
+			thr = ffs(min_t(unsigned int, host->data->blksz,
+					host->variant->fifosize));
+			thr = min_t(u32, thr, MMCI_STM32_THR_MASK);
+		}
+
+		writel_relaxed(thr, host->base + MMCI_STM32_FIFOTHRR);
+	}
+
 	if (host->mmc->card && mmc_card_sdio(host->mmc->card) &&
 	    host->data->blocks == 1)
 		datactrl |= MCI_DPSM_STM32_MODE_SDIO;
-- 
2.25.1

