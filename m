Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F000731391
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 11:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245518AbjFOJVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 05:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245582AbjFOJVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 05:21:33 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3664C199D;
        Thu, 15 Jun 2023 02:21:31 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35F8YmP5021568;
        Thu, 15 Jun 2023 11:21:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=KAp7zfvpG6cF2t99BxBFfJf+xPwiHLcRjGpIqYuYpuY=;
 b=L346q7gL5v7/MTBi9JYxObpdLPynveL3c5YA6+LF8StwR8XuJ/Eoukav6zb7csXBQEIp
 4/dpQZBBdeZimIA8WF/sfiMIsEQwC/kkz8HN4Gv94C9TrH4c6xXSdPvSN+bwJKDxdLfO
 h/6Nx1qojGpJGMbOHGr5kaeqMvwjMEW9v2gKfPthbMCEli/swni/T3xzccmvyy9M1PkO
 92kidLOyM0Eoog8txkAcgknQUCpiohu+WgcM6y1xk8j+82w97jdi8/4cW2e10itJZwuz
 Nmm6SMlFF7Ys2VNySRPwDki5YeNQuaBufSLGLDRfvKERDnt0R4ESWNKfwjPpgpV65rKK HA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3r7y8sgbku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 11:21:08 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 87EBA10002A;
        Thu, 15 Jun 2023 11:21:07 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7E73621A234;
        Thu, 15 Jun 2023 11:21:07 +0200 (CEST)
Received: from localhost (10.201.21.210) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 15 Jun
 2023 11:21:06 +0200
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
Subject: [PATCH 4/6] mmc: mmci: stm32: manage block gap hardware flow control
Date:   Thu, 15 Jun 2023 11:19:59 +0200
Message-ID: <20230615092001.1213132-5-yann.gautier@foss.st.com>
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

