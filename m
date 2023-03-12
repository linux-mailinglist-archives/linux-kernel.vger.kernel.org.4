Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B73B06B628F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 01:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjCLAsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 19:48:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjCLAss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 19:48:48 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2060e.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eb2::60e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2E8196A1;
        Sat, 11 Mar 2023 16:48:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DeWdoOR0K/FrEe5rBmcdsDbIhghpqJ8QjYJMqhsBCHeS6H1RxmFY5x+0qK/H53pvNMDdbk8VkL5oqdiuZe4ShshyhMBu7darrbIJmvxBKhu11mcj2r7oGLoETKc5DHWULoOowMVmVpcCh3GErWq8ARzbjKL0X/5m4gBWCjdV3McF0icRjD/HqBFQLsPcABjIrxaEyF6uKMsiWZvuqUKpaRCUyDp7B/yW9c9kMfItdnHwS7UH/UxjSYEo1J3bSm6v4Ws6KHclwlcFbyp170AHeMqe/OcLxZNvmYeYMTr8eCs+/gyxc5AIpAg1kaH5dSr0Ue3ef6lzCiKCUmyFrKtOIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZVI1OZZMPiHNVrQddAKYxgPCAkOIkTxwqmQwe+IEi90=;
 b=WpwwkPLNRWwNk2d6QAV2RH1X2JTkdUwHeSXVadf+jgR2eOtX+h+GkEFvx6/LyuYMvJL64vHo6200j1D7bNXEdtxfmkDTeR5LKplbBqptkWUpd01ua8D1cUStS2C6G74dNu2aCO1Fc2qIDPrZhj0+LZM8vqCHbB6GNN3billkmiyHaDS+/rBels7sordmUS/5GD/ImogmugLEkmt1dVv+VVZc3AKLaSyB9PV5OFY6q7Jq4Bpn4CVEvW/tD2mCVhoyJQquNyhUsBzRpwo/Ds/N9wSPfYZxw4dRLxmt/3iiy0LAyNSJFOBw6pEaNCNV94DPymuCO8viBEs/kEnFtHKEaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZVI1OZZMPiHNVrQddAKYxgPCAkOIkTxwqmQwe+IEi90=;
 b=ANi6B1DGUqhOD1ldVjrXsy4vxllsCqsrk78yVysEvPgo6FwCFh6CYflxIkMoUXFuItK5S0nLLnAnkfCRqksnaOynyxxph5B5Kigtey1NWdFWNTUPCuxr3KvCTltsvFoGZ9xnYWwbRLXCdfOXmdxwD+RDAt0ZPtgeCCFKBYoCwwg=
Received: from DS7PR06CA0025.namprd06.prod.outlook.com (2603:10b6:8:54::31) by
 DM6PR12MB4332.namprd12.prod.outlook.com (2603:10b6:5:21e::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.22; Sun, 12 Mar 2023 00:47:16 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::b9) by DS7PR06CA0025.outlook.office365.com
 (2603:10b6:8:54::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.23 via Frontend
 Transport; Sun, 12 Mar 2023 00:47:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.24 via Frontend Transport; Sun, 12 Mar 2023 00:47:16 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sat, 11 Mar 2023 18:47:12 -0600
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
Subject: [PATCH v11 14/15] mmc: sdhci-cadence: Support mmc hardware reset
Date:   Sat, 11 Mar 2023 16:44:44 -0800
Message-ID: <20230312004445.15913-15-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230312004445.15913-1-blarson@amd.com>
References: <20230312004445.15913-1-blarson@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT060:EE_|DM6PR12MB4332:EE_
X-MS-Office365-Filtering-Correlation-Id: e984df04-d42f-4443-bc58-08db229353d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IyE9HPV2A3HKt1nx+zo5k5cZI51NKBsrGYsauZjja3a6RJ5cxco4RsELsBwNtRsPEGZQSo7vFQXYF+/kny4hNoutJfH4pVW6fIV7E5Do6BO/Uf3ocNg9wXkcQD2pdMDB9CZLAv6wZJvp4MOYvpi2q7cYqSfXa64T+7jIuDQallbDsx5jzLcNtXvszq+lu2UntHQMywj89gg/bvZo8tTVjnbIEL2XeAQnn54Dtnv/vAvxBnwOpj0KRmTF+H/8qRW4j4Y993ti08/J8hroS6DOU73aEYWuXN0hqnj8dYId0GUrz28yNjyjkeA97rqx8sOxKBnni4TXambGp4SRD282JNHaQ6YScUnHUq8gW4eV/2imqn2nl2qGYMDqif3jCVkTcBZSBwDhJmIdtHWa0b4QvRABLs8Ws2AVdtLOMFRMe8J1oOh6vK40sY+DsxSD1fcaX7VopWfh1WEjWUej4MZN0A44uyvW1bttA74BrjXOy5ipeOnujWygGVcpoystNZ2WbPbra6V5PtgkEW/s3JtEGnG6osBaXeKk29jJ3ZdpJdUdBydmjLw6Uk/zgZ/RC4i878ltL/2WrchtdcjTQBT7cy8Krz9Xncv2h+VobMIAZi7POXbrbdXOtDL9maLSs20SW27+gKTG78CelEHIxUv+9uOreirdHNMlmD8JHJSHd84sNSbAfGNyi1VyQNGkGWP2IcGEzDM9sMFoS/f1z1boNrwWLvop7+6Hop1t1M1nUe0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199018)(46966006)(36840700001)(40470700004)(186003)(356005)(2906002)(16526019)(82740400003)(26005)(1076003)(2616005)(81166007)(8936002)(5660300002)(36860700001)(7406005)(6666004)(7416002)(6916009)(336012)(426003)(47076005)(40460700003)(41300700001)(4326008)(8676002)(82310400005)(40480700001)(70586007)(70206006)(36756003)(478600001)(316002)(83380400001)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2023 00:47:16.4067
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e984df04-d42f-4443-bc58-08db229353d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4332
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
---

v9 changes:
- Previously patch 17/17
- Changed delay after reset_control_assert() from 9 to 3 usec
- Renamed sdhci_mmc_hw_reset() to sdhci_cdns_mmc_hw_reset()

---
 drivers/mmc/host/sdhci-cadence.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
index c0024d1e69a8..0d8db1a54729 100644
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
@@ -455,6 +457,22 @@ static void sdhci_cdns_hs400_enhanced_strobe(struct mmc_host *mmc,
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
@@ -518,6 +536,15 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
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

