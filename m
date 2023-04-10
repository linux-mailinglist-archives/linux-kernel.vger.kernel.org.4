Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022AB6DCB28
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 20:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjDJSs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 14:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbjDJSsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 14:48:50 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15234211E;
        Mon, 10 Apr 2023 11:48:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iSZVzOuxE/LjJG5nNNKBwJ57y8xsXqGvt6rpy1Oj5ggHosNBWiquL3qUxLTbhnPIhbWLCzPsYYYPFRmzKVNgjkiK+kvdLz/ho+XBufs4/EE4p8R39ZioYwC/6nJy6ErFRxJANDEbg7SZiEIlh1M7g1qzNus/Ufii7/2D9eG6iBsr21FQ+1Ttie109gPjhDQfvtnChZnzuxu+1PLlYFQTlbeuwQ9LvE1t6HEyzrpXUr4rogD+WQJgx4bwgQkM2MNG0tMsbCeMbuclzwrQFokTQS+bW7xiABnS50hJvtJdwtlHRft5HnLK8bAV+/CGOdw9yPX6nRdx/5TTARpHdCtdNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x8af604fGrGhqJmMiT/sEtq9ScrZ/AIvFHD/37Ve6FM=;
 b=MfqfMbhbDGcjHo6c8pELolYox0AIAJOdTCtfumamhH9LIE8viA/SpZOllsytlB6DKmM9hQPR+/SYxmnhdKLsZak8QnILNh5V7dljSBZJbsPwaZ6S4DHWx6+8Mkg/6M3LkC3bNY/tN41H1H8+VUsawWXZWNsIDQiq/m+UL40ttESFGHW5SvIL5TswA8pr7HMIWRSIx0+M4P/spYag4mvX7eFO6SxRFmIJg48COoKOFMYXumA0PwRcAhvYBhXZQzWgRIve9smtddt+o7L0anAVyLc4SpV4j3cp3bzxRQwmwH+GxvhEto+NEZUnQol/1yrHiLcGy+iePVXTZJqY7dQddw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x8af604fGrGhqJmMiT/sEtq9ScrZ/AIvFHD/37Ve6FM=;
 b=SU1OmXxWC+1CoNej0h0QRefoKF6Dp6f/Qs2yFcFH0N3LJYQdGjLME9tqBVyK8ZJRnXVvwGdPGJsYZcRqbAZLG4/hD5qiv1KLNStaiRqk2G73nWPEm+gtQNQV+O9BvYFmqSXkabet+lYgfPI+xs2NzlO25t04fOielmxmVIu7p0M=
Received: from DS7PR03CA0040.namprd03.prod.outlook.com (2603:10b6:5:3b5::15)
 by IA1PR12MB8407.namprd12.prod.outlook.com (2603:10b6:208:3d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Mon, 10 Apr
 2023 18:48:00 +0000
Received: from DM6NAM11FT075.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b5:cafe::86) by DS7PR03CA0040.outlook.office365.com
 (2603:10b6:5:3b5::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.39 via Frontend
 Transport; Mon, 10 Apr 2023 18:47:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT075.mail.protection.outlook.com (10.13.173.42) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.25 via Frontend Transport; Mon, 10 Apr 2023 18:47:59 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 10 Apr 2023 13:47:56 -0500
From:   Brad Larson <blarson@amd.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <adrian.hunter@intel.com>,
        <alcooperx@gmail.com>, <andy.shevchenko@gmail.com>,
        <arnd@arndb.de>, <blarson@amd.com>, <brendan.higgins@linux.dev>,
        <briannorris@chromium.org>, <brijeshkumar.singh@amd.com>,
        <catalin.marinas@arm.com>, <davidgow@google.com>,
        <gsomlo@gmail.com>, <gerg@linux-m68k.org>, <krzk@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lee@kernel.org>,
        <lee.jones@linaro.org>, <broonie@kernel.org>,
        <yamada.masahiro@socionext.com>, <p.zabel@pengutronix.de>,
        <piotrs@cadence.com>, <p.yadav@ti.com>, <rdunlap@infradead.org>,
        <robh+dt@kernel.org>, <samuel@sholland.org>,
        <fancer.lancer@gmail.com>, <skhan@linuxfoundation.org>,
        <suravee.suthikulpanit@amd.com>, <thomas.lendacky@amd.com>,
        <tonyhuang.sunplus@gmail.com>, <ulf.hansson@linaro.org>,
        <vaishnav.a@ti.com>, <will@kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v13 14/15] mmc: sdhci-cadence: Support mmc hardware reset
Date:   Mon, 10 Apr 2023 11:45:25 -0700
Message-ID: <20230410184526.15990-15-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230410184526.15990-1-blarson@amd.com>
References: <20230410184526.15990-1-blarson@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT075:EE_|IA1PR12MB8407:EE_
X-MS-Office365-Filtering-Correlation-Id: 1512a1ec-f36e-4c1e-dc27-08db39f41b88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QV5bp0AFyEFucZB/TAbJ8o/aMA7+LGbBFQZasbN+3R5XSSm5Q5ZUJ/amMp5P3OCH8IpaSPCxTV8TTcSGjEwDVwPi/82LXGRAO/Q+hNMUoig3GmDMxbC1rcsCqO3OK0uxH43I/R8KwHIVwI6mHvqwJSC35tbXzt0tO6zfBrGkbWJT+Is7r+qCueHX94NpNwgjXP1GUvyHDUr4oQwwz/i1w5JPk8x0g3tEXsSYRfuJBngF3n0Jt/DbwxAaZdjDjm6RpVh4d3ItWkKHxgRZSLwHhWeTzG5jlFHFBrAdC43MHDx2gVg2pbEhWZcvGpCWubcOi8jxKc3v1RxtvHkPPDQCoxzkw25JIJEwP3jerKU7AHtbfoeU7tLoTRnpOTNsZviats4T+U02G1RvPC1gPfRaHMmvd/l1hdzd4DpJD1uCIEroskA4S2wSgFFXI/cl8LIqgdsMiuGsgYFXmuOhmE4jG/NMqyvwCiCk3eVn3xuYV2UlBB5rW/4+EZBPRstl9yMYHUKvvwLLrBuGMgDPf52Oy2NyH87dwqpXn4NQjwK59XKyCS5mBZYYsgTaGaOu4cBEFgurbVQNnA1l6y/BnfRaEslR+QrLzyIbXpGJxoPHaY7XFP5lEKf/RXn1Zj4ff3saK+duTfsQ4dwsZRoCFTyB+6vzF1eA6Ah4Uvx211b6pSAK4A37I7WfJZPxNjHX4aOeZLKy00PGKb3i1IrxScnYS2BWUoMk6WqvBW/H37XNfjs=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199021)(36840700001)(40470700004)(46966006)(478600001)(6666004)(16526019)(316002)(26005)(1076003)(186003)(54906003)(7416002)(2906002)(7406005)(70206006)(70586007)(6916009)(82310400005)(4326008)(8936002)(8676002)(41300700001)(5660300002)(356005)(81166007)(82740400003)(40480700001)(36756003)(40460700003)(47076005)(83380400001)(36860700001)(2616005)(336012)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 18:47:59.8877
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1512a1ec-f36e-4c1e-dc27-08db39f41b88
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT075.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8407
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for mmc hardware reset using a reset-controller
that would need to be enabled in the device tree with
a supporting driver.  The default is disabled for all
existing designs.

Signed-off-by: Brad Larson <blarson@amd.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
---

v9 changes:
- Previously patch 17/17
- Changed delay after reset_control_assert() from 9 to 3 usec
- Renamed sdhci_mmc_hw_reset() to sdhci_cdns_mmc_hw_reset()

---
 drivers/mmc/host/sdhci-cadence.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
index 5d1e9cef74f5..b24aa27da50c 100644
--- a/drivers/mmc/host/sdhci-cadence.c
+++ b/drivers/mmc/host/sdhci-cadence.c
@@ -12,6 +12,7 @@
 #include <linux/mmc/mmc.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/reset.h>
 
 #include "sdhci-pltfm.h"
 
@@ -70,6 +71,7 @@ struct sdhci_cdns_priv {
 	spinlock_t wrlock;	/* write lock */
 	bool enhanced_strobe;
 	void (*priv_writel)(struct sdhci_cdns_priv *priv, u32 val, void __iomem *reg);
+	struct reset_control *rst_hw;
 	unsigned int nr_phy_params;
 	struct sdhci_cdns_phy_param phy_params[];
 };
@@ -457,6 +459,22 @@ static void sdhci_cdns_hs400_enhanced_strobe(struct mmc_host *mmc,
 					 SDHCI_CDNS_HRS06_MODE_MMC_HS400);
 }
 
+static void sdhci_cdns_mmc_hw_reset(struct mmc_host *mmc)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
+
+	dev_dbg(mmc_dev(host->mmc), "emmc hardware reset\n");
+
+	reset_control_assert(priv->rst_hw);
+	/* For eMMC, minimum is 1us but give it 3us for good measure */
+	udelay(3);
+
+	reset_control_deassert(priv->rst_hw);
+	/* For eMMC, minimum is 200us but give it 300us for good measure */
+	usleep_range(300, 1000);
+}
+
 static int sdhci_cdns_probe(struct platform_device *pdev)
 {
 	struct sdhci_host *host;
@@ -520,6 +538,15 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 	if (ret)
 		goto free;
 
+	if (host->mmc->caps & MMC_CAP_HW_RESET) {
+		priv->rst_hw = devm_reset_control_get_optional_exclusive(dev, NULL);
+		if (IS_ERR(priv->rst_hw))
+			return dev_err_probe(mmc_dev(host->mmc), PTR_ERR(priv->rst_hw),
+					     "reset controller error\n");
+		if (priv->rst_hw)
+			host->mmc_host_ops.card_hw_reset = sdhci_cdns_mmc_hw_reset;
+	}
+
 	ret = sdhci_add_host(host);
 	if (ret)
 		goto free;
-- 
2.17.1

