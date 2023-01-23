Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F44467864E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 20:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbjAWT2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 14:28:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbjAWT2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 14:28:43 -0500
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19839A245;
        Mon, 23 Jan 2023 11:28:43 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30NGB4Fq009522;
        Mon, 23 Jan 2023 11:28:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=uo7y1dqJr2f4+xqCbqPkEXGS1gJmv4tDpk/8yEw7mmg=;
 b=HXnwo0hw4MCDv3332hDrsZujuQ09imSV246yGgP+BtHbzyV3XtUIsV9AIObzmiWCijYq
 hsxqjPlkvFEZIk/zxpAySGJ5PIdNgpcoBkKZHATjzo5mvfPykPFxtPZGk/X6gT9rcEXS
 VDG0CEPxwD0YvkCMFT5AbYmrK7UhsXbGYf0hzwrTlgEtWs5xNe03kCzUxTIPNLrYYIiL
 DHm/KAnQsEtP9AIV4/JHjklRYKdm2WwJI/UuR8YfKzcQ4YoJ33mEDlC/79eh7q93I/cS
 czvtBTZ/L3pTJ83nkDLpUQQ81Er+JsRM0Oms6TntaGS9sBlKDB4Ky7yn58vk61+0SZ1V Zg== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3n8gerbeqh-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 23 Jan 2023 11:28:36 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 23 Jan
 2023 11:28:34 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.42 via Frontend
 Transport; Mon, 23 Jan 2023 11:28:34 -0800
Received: from localhost.localdomain (unknown [10.110.150.250])
        by maili.marvell.com (Postfix) with ESMTP id 65E7E3F7050;
        Mon, 23 Jan 2023 11:28:34 -0800 (PST)
From:   Piyush Malgujar <pmalgujar@marvell.com>
To:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <yamada.masahiro@socionext.com>, <devicetree@vger.kernel.org>
CC:     <jannadurai@marvell.com>, <cchavva@marvell.com>,
        Piyush Malgujar <pmalgujar@marvell.com>
Subject: [PATCH v2 3/5] drivers: mmc: sdhci-cadence: enable MMC_SDHCI_IO_ACCESSORS
Date:   Mon, 23 Jan 2023 11:27:33 -0800
Message-ID: <20230123192735.21136-4-pmalgujar@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230123192735.21136-1-pmalgujar@marvell.com>
References: <20230123192735.21136-1-pmalgujar@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: PrufgUhFQMQeqY4GbZxDKZ_rOvv08kqK
X-Proofpoint-ORIG-GUID: PrufgUhFQMQeqY4GbZxDKZ_rOvv08kqK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_12,2023-01-23_01,2022-06-22_01
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
index 5e19a961c34d7b5664ab2fd43cfba82dc90913ac..9e41115cc753aaf577a9c01c293ec602ce1e3f52 100644
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
index 03895b519061e7d3424742ce779d94b12ecf4ab8..baee0f98deac975ab92cf3e09a1edec5d3a59021 100644
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
@@ -1576,6 +1631,14 @@ static const struct sdhci_ops sdhci_cdns_sd4_ops = {
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

