Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15FCC73564A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 13:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjFSLyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 07:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjFSLyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 07:54:00 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB757134;
        Mon, 19 Jun 2023 04:53:53 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35JAiTNw032603;
        Mon, 19 Jun 2023 13:53:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=i1KQomgbTCKKL1jhfJcq7MepijYGukr9j+2PCgWp/oI=;
 b=bwJlV/8jzyl4tx7faoHfBVBavw5NOIOv2tj28Ki+HhhAiR/YH19CT5WQhGFt8rwG2qhL
 ZWnoM8Nt9n7/xthDGTeQ8n8zUxifWYNc3FC6A4QReMRRN//OPCZITDvVW6NLYdWEaNgT
 AlCK+tsMsOW1l5mV/6fYVe9txZzdKgQHFAJXeBhIJrpC+6Kqzu4d4wBgKdqEgL+N3zVh
 E27JN4aV6BpRq0AGs0x7XYc4s1jPOKYBVOZFPj6vxp8wzGumVOAPLB2bLlxHL7zFRHuI
 2kNVOYq1Cu+z8OCkxjp/7xOQVTwYwv69etBb0OWX6ZtHOTEBW0Tnyf/eS7447fljkGt3 Rg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ramu5rnqg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jun 2023 13:53:33 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2581E10002A;
        Mon, 19 Jun 2023 13:53:33 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1C0BE228A33;
        Mon, 19 Jun 2023 13:53:33 +0200 (CEST)
Received: from localhost (10.201.21.210) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Mon, 19 Jun
 2023 13:53:32 +0200
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
Subject: [PATCH v2 6/6] mmc: mmci: stm32: add delay block support for STM32MP25
Date:   Mon, 19 Jun 2023 13:51:20 +0200
Message-ID: <20230619115120.64474-7-yann.gautier@foss.st.com>
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

On STM32MP25, the delay block is inside the SoC, and configured through
the SYSCFG registers. The algorithm is also different from what was in
STM32MP1 chip.

Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
---
 drivers/mmc/host/mmci_stm32_sdmmc.c | 66 ++++++++++++++++++++++++++++-
 1 file changed, 65 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mmci_stm32_sdmmc.c b/drivers/mmc/host/mmci_stm32_sdmmc.c
index c51c85ca24917..d6112a8dacf8b 100644
--- a/drivers/mmc/host/mmci_stm32_sdmmc.c
+++ b/drivers/mmc/host/mmci_stm32_sdmmc.c
@@ -33,6 +33,20 @@
 #define DLYB_LNG_TIMEOUT_US	1000
 #define SDMMC_VSWEND_TIMEOUT_US 10000
 
+#define SYSCFG_DLYBSD_CR	0x0
+#define DLYBSD_CR_EN		BIT(0)
+#define DLYBSD_CR_RXTAPSEL_MASK	GENMASK(6, 1)
+#define DLYBSD_TAPSEL_NB	32
+#define DLYBSD_BYP_EN		BIT(16)
+#define DLYBSD_BYP_CMD		GENMASK(21, 17)
+#define DLYBSD_ANTIGLITCH_EN	BIT(22)
+
+#define SYSCFG_DLYBSD_SR	0x4
+#define DLYBSD_SR_LOCK		BIT(0)
+#define DLYBSD_SR_RXTAPSEL_ACK	BIT(1)
+
+#define DLYBSD_TIMEOUT_1S_IN_US	1000000
+
 struct sdmmc_lli_desc {
 	u32 idmalar;
 	u32 idmabase;
@@ -499,6 +513,46 @@ static int sdmmc_dlyb_mp15_prepare(struct mmci_host *host)
 	return 0;
 }
 
+static int sdmmc_dlyb_mp25_enable(struct sdmmc_dlyb *dlyb)
+{
+	u32 cr, sr;
+
+	cr = readl_relaxed(dlyb->base + SYSCFG_DLYBSD_CR);
+	cr |= DLYBSD_CR_EN;
+
+	writel_relaxed(cr, dlyb->base + SYSCFG_DLYBSD_CR);
+
+	return readl_relaxed_poll_timeout(dlyb->base + SYSCFG_DLYBSD_SR,
+					   sr, sr & DLYBSD_SR_LOCK, 1,
+					   DLYBSD_TIMEOUT_1S_IN_US);
+}
+
+static int sdmmc_dlyb_mp25_set_cfg(struct sdmmc_dlyb *dlyb,
+				   int unit __maybe_unused, int phase,
+				   bool sampler __maybe_unused)
+{
+	u32 cr, sr;
+
+	cr = readl_relaxed(dlyb->base + SYSCFG_DLYBSD_CR);
+	cr &= ~DLYBSD_CR_RXTAPSEL_MASK;
+	cr |= FIELD_PREP(DLYBSD_CR_RXTAPSEL_MASK, phase);
+
+	writel_relaxed(cr, dlyb->base + SYSCFG_DLYBSD_CR);
+
+	return readl_relaxed_poll_timeout(dlyb->base + SYSCFG_DLYBSD_SR,
+					  sr, sr & DLYBSD_SR_RXTAPSEL_ACK, 1,
+					  DLYBSD_TIMEOUT_1S_IN_US);
+}
+
+static int sdmmc_dlyb_mp25_prepare(struct mmci_host *host)
+{
+	struct sdmmc_dlyb *dlyb = host->variant_priv;
+
+	dlyb->max = DLYBSD_TAPSEL_NB;
+
+	return 0;
+}
+
 static int sdmmc_dlyb_phase_tuning(struct mmci_host *host, u32 opcode)
 {
 	struct sdmmc_dlyb *dlyb = host->variant_priv;
@@ -639,6 +693,12 @@ static struct sdmmc_tuning_ops dlyb_tuning_mp15_ops = {
 	.set_cfg = sdmmc_dlyb_mp15_set_cfg,
 };
 
+static struct sdmmc_tuning_ops dlyb_tuning_mp25_ops = {
+	.dlyb_enable = sdmmc_dlyb_mp25_enable,
+	.tuning_prepare = sdmmc_dlyb_mp25_prepare,
+	.set_cfg = sdmmc_dlyb_mp25_set_cfg,
+};
+
 void sdmmc_variant_init(struct mmci_host *host)
 {
 	struct device_node *np = host->mmc->parent->of_node;
@@ -657,7 +717,11 @@ void sdmmc_variant_init(struct mmci_host *host)
 		return;
 
 	dlyb->base = base_dlyb;
-	dlyb->ops = &dlyb_tuning_mp15_ops;
+	if (of_device_is_compatible(np, "st,stm32mp25-sdmmc2"))
+		dlyb->ops = &dlyb_tuning_mp25_ops;
+	else
+		dlyb->ops = &dlyb_tuning_mp15_ops;
+
 	host->variant_priv = dlyb;
 	host->mmc_ops->execute_tuning = sdmmc_execute_tuning;
 }
-- 
2.25.1

