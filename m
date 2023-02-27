Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC3406A49D7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 19:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjB0Sdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 13:33:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjB0Sdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 13:33:32 -0500
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3EC1DBB8;
        Mon, 27 Feb 2023 10:33:01 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31RCtGwF026362;
        Mon, 27 Feb 2023 10:32:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=Vzu7NIu2++o+YiyPvG9HnyjlbVP1fkiGXqHQYWPFNSA=;
 b=TmsO9FdqpTjFh3T6ksHfPTZXGAaaiiAQrcREFbIlH7kSvdtWfFP42Wnp5uEhXRicO86X
 Z+znU000J/cVXyiBbZloPTXtrrVgvJ4Sh12iNC2H2ZkOTEHY/2KxQes+8lhGTa4wPq5B
 ERWnpdqktJvm5xBB2mY7oPIsZZydAvRnI99HkCPva+rOVfPiPD4LwyoWajWvxzimVeYV
 QZBwKaS7lyGBpU56sc3NSi2F7E32O1S+qL+OscG+wmN5Eh2Xmb/RO+fdWmyxHLrc16Qd
 Gc13+j7ltnaY0sXkpZYwQLtJ9dI5biOhW2LdIIzoiRe4QLT8NHQbnSDNar1WY5RdIfmz Pg== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3nyjqtsbmu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 27 Feb 2023 10:32:40 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 27 Feb
 2023 10:32:38 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.42 via Frontend
 Transport; Mon, 27 Feb 2023 10:32:38 -0800
Received: from localhost.localdomain (unknown [10.110.150.250])
        by maili.marvell.com (Postfix) with ESMTP id EA71B3F7066;
        Mon, 27 Feb 2023 10:32:37 -0800 (PST)
From:   Piyush Malgujar <pmalgujar@marvell.com>
To:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <yamada.masahiro@socionext.com>, <devicetree@vger.kernel.org>
CC:     <jannadurai@marvell.com>, <cchavva@marvell.com>,
        Piyush Malgujar <pmalgujar@marvell.com>
Subject: [PATCH v3 4/6] mmc: sdhci-cadence: enable MMC_SDHCI_IO_ACCESSORS
Date:   Mon, 27 Feb 2023 10:31:49 -0800
Message-ID: <20230227183151.27912-5-pmalgujar@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230227183151.27912-1-pmalgujar@marvell.com>
References: <20230227183151.27912-1-pmalgujar@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: FyJD-LSEaG2BSHT7Iw0H86-eeDnz0gOs
X-Proofpoint-GUID: FyJD-LSEaG2BSHT7Iw0H86-eeDnz0gOs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-27_15,2023-02-27_01,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jayanthi Annadurai <jannadurai@marvell.com>

Add support for CONFIG_MMC_SDHCI_IO_ACCESSORS for controller
specific register read and write APIs.

Signed-off-by: Jayanthi Annadurai <jannadurai@marvell.com>
Signed-off-by: Piyush Malgujar <pmalgujar@marvell.com>
---
 drivers/mmc/host/Kconfig         |  1 +
 drivers/mmc/host/sdhci-cadence.c | 63 ++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index e13b0b0b8ebb85a63b14a13d3fdbf009928b43fa..82dcfb323dda84171b501f0f26a88ce87f141453 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -255,6 +255,7 @@ config MMC_SDHCI_CADENCE
 	tristate "SDHCI support for the Cadence SD/SDIO/eMMC controller"
 	depends on MMC_SDHCI_PLTFM
 	depends on OF
+	select MMC_SDHCI_IO_ACCESSORS
 	help
 	  This selects the Cadence SD/SDIO/eMMC driver.
 
diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
index 4b32757dd3750af6428e0d4177b419b3a9e8696d..badff2df70b904779c70775b02b40086780b118d 100644
--- a/drivers/mmc/host/sdhci-cadence.c
+++ b/drivers/mmc/host/sdhci-cadence.c
@@ -449,6 +449,61 @@ static u32 read_dqs_cmd_delay, clk_wrdqs_delay, clk_wr_delay, read_dqs_delay;
 
 static u32 sdhci_cdns_sd6_get_mode(struct sdhci_host *host, unsigned int timing);
 
+#ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
+static u32 sdhci_cdns_sd6_readl(struct sdhci_host *host, int reg)
+{
+	return readl(host->ioaddr + reg);
+}
+
+static void sdhci_cdns_sd6_writel(struct sdhci_host *host, u32 val, int reg)
+{
+	writel(val, host->ioaddr + reg);
+}
+
+static u16 sdhci_cdns_sd6_readw(struct sdhci_host *host, int reg)
+{
+	u32 val, regoff;
+
+	regoff = reg & ~3;
+
+	val = readl(host->ioaddr + regoff);
+	if ((reg & 0x3) == 0)
+		return (val & 0xFFFF);
+	else
+		return ((val >> 16) & 0xFFFF);
+}
+
+static void sdhci_cdns_sd6_writew(struct sdhci_host *host, u16 val, int reg)
+{
+	writew(val, host->ioaddr + reg);
+}
+
+static u8 sdhci_cdns_sd6_readb(struct sdhci_host *host, int reg)
+{
+	u32 val, regoff;
+
+	regoff = reg & ~3;
+
+	val = readl(host->ioaddr + regoff);
+	switch (reg & 3) {
+	case 0:
+		return (val & 0xFF);
+	case 1:
+		return ((val >> 8) & 0xFF);
+	case 2:
+		return ((val >> 16) & 0xFF);
+	case 3:
+		return ((val >> 24) & 0xFF);
+	}
+	return 0;
+}
+
+static void sdhci_cdns_sd6_writeb(struct sdhci_host *host, u8 val, int reg)
+{
+	writeb(val, host->ioaddr + reg);
+}
+#endif
+
 static int sdhci_cdns_sd6_phy_lock_dll(struct sdhci_cdns_sd6_phy *phy)
 {
 	u32 delay_element = phy->d.delay_element_org;
@@ -1578,6 +1633,14 @@ static const struct sdhci_ops sdhci_cdns_sd4_ops = {
 };
 
 static const struct sdhci_ops sdhci_cdns_sd6_ops = {
+#ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
+	.read_l = sdhci_cdns_sd6_readl,
+	.write_l = sdhci_cdns_sd6_writel,
+	.read_w = sdhci_cdns_sd6_readw,
+	.write_w = sdhci_cdns_sd6_writew,
+	.read_b = sdhci_cdns_sd6_readb,
+	.write_b = sdhci_cdns_sd6_writeb,
+#endif
 	.get_max_clock = sdhci_cdns_get_max_clock,
 	.set_clock = sdhci_cdns_sd6_set_clock,
 	.get_timeout_clock = sdhci_cdns_get_timeout_clock,
-- 
2.17.1

