Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED006C5B3F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 01:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbjCWAMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 20:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbjCWALv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 20:11:51 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C76F305D6;
        Wed, 22 Mar 2023 17:11:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d8fiZcJOtfj7rRGLQPsdbeKf/7lgNZ1A+x69UGUGctYpU+Xbka428zDy0QJEshjeljG7qw2Cnx9QvR87Kx3NxUJzEXmCUbTqg6YxAle4JvXL28YoaiZuruleMvGI6wh7+IChQRbG/PWLN6wXpDZ6x+GVaj8aHfOwKTmfqiO/6hytNHhDGnYUOJ5rQi/EzVPWwTOYjs54WlhIz4HBXdsyBxs3HYI53Rw7Lga+C4AOpTAs+OHQ1iYq1CgTxpzl/ZHSrjRd/Amz1yu5hSRCb+vXUM/Ny//5JqDriOiR+URno49r5Zj29hcpCGrBcvVKNpzH65wO0Km3iSG31IRht8cxdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZVI1OZZMPiHNVrQddAKYxgPCAkOIkTxwqmQwe+IEi90=;
 b=gpQZO3oSpPfgV79GJZhVBtMMYx0jUIzhMWC6BPEezD6FwVqZnAVO/zC2QB44sXfoE2uJbfdNhlxihAjZkGSvCMp+8qdC3RUXqgKgzEqmq0h+k0cBbUk0mKwQMnEi3NZ4g9ZK7/uqtTX6yyW0DXXRE11Xt0n/Os3OTrTPcZ4FOn9IVFEfK8y0Orw0W9qjVHpQ2V8Ah7p48IdVGfSwLcTOh6xWjjKA+Tnr4mteBIcGdNCmWnPfu7i6pjHdtwSUTGzK33kLPPOupI0H7/j0kvW8CQIT5aGwQSVz+ibbfdRyRf9S86/z7LvBZv3WBKC5/sFAgnFY6C3KpHFMIGFA/BdTIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZVI1OZZMPiHNVrQddAKYxgPCAkOIkTxwqmQwe+IEi90=;
 b=tIqQIEYfROfTp6FmmYMPXPM2WCmfMhw9/o/ReIGDFuOJO4mM74ozQ/YyWAtjJDN6nRCR95r56waBYFD3Eg8UL42CgogpsayDC84XpdOma4EAvoRCn0KMbl9bJ/FLbTzJG88wyob8AP7dgI61WZlVQ2bYxlnVZr1KjEzBI5kCGPQ=
Received: from MN2PR11CA0006.namprd11.prod.outlook.com (2603:10b6:208:23b::11)
 by DM6PR12MB4909.namprd12.prod.outlook.com (2603:10b6:5:1ba::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 00:10:56 +0000
Received: from BL02EPF000100D0.namprd05.prod.outlook.com
 (2603:10b6:208:23b:cafe::6) by MN2PR11CA0006.outlook.office365.com
 (2603:10b6:208:23b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Thu, 23 Mar 2023 00:10:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D0.mail.protection.outlook.com (10.167.241.204) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Thu, 23 Mar 2023 00:10:56 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 22 Mar 2023 19:10:53 -0500
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
Subject: [PATCH v12 14/15] mmc: sdhci-cadence: Support mmc hardware reset
Date:   Wed, 22 Mar 2023 17:06:56 -0700
Message-ID: <20230323000657.28664-15-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230323000657.28664-1-blarson@amd.com>
References: <20230323000657.28664-1-blarson@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D0:EE_|DM6PR12MB4909:EE_
X-MS-Office365-Filtering-Correlation-Id: 6df70512-ce8b-434b-d9a9-08db2b3312be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2RxSXhIl0qyY73ihWxKrZ32IRkCzY3BF+exF5vSGP7FnrmtSx2juE+lZoc44tmY/UxoI9EtMBcshuwr9HD3573OyMrWxZBf45fS8vV8tZ6QflGzUf70xkpxOxykLqfDRDqO01Nw5EnxTxU/ZkGyRZ6ldaCgzLLZWu6YKx4vNk0XbPc9pgi1vPLM4U9lU7lhsiIsdQQCYgAMRPVdyFnLtUufVDM5ivYu77gFM/iGZeW5+aP3cDz3IpshHhNE0mIa5zXzDbjQz/N8mrYiQys4X2c308SHpaS+bKkuJ4L5cEmlrJc8Jnm8VfWdU1k7ZMoZ7VAsfvfxMo4GWilOFIamnp5FzXuKYVFC0Hmd+9V98lOo4qohWYM8GSSORhaQCTr6B9R+iODyUPq8x0eVgEj4iX+yhzh77kB/dFq2Ihcq/BKLKMxia+1Yb4TmGA9PegBVOrSIIpj4UxmohsB7kqyGetHBMfFuDJeTnazw4wziZz3ylmqc8SdgRUD5YA6lCBEYhelpF3JTnGSSbT2gg77zp81BZxXbeGdtNgUeDNG0BgyjuAG4gnD9QKibNqSFZeuSbaX7UCOAr+eAQNX257nP44/FzldFK5M9D1UlxfxFrO+Nqek6auaeQOZVIxKDQheSoEKpqxD668X7I9dOhpTEAV9TcjnIlilK1gU7A6QdRYHAiefnMvyWHIG+zRDGnYrV6ZZV8A5JSZCT64hvUdyQCOua5ZJTl8Sbq4M7AQuNUu0k=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(346002)(39860400002)(396003)(451199018)(36840700001)(40470700004)(46966006)(7406005)(54906003)(47076005)(336012)(83380400001)(2616005)(82310400005)(426003)(316002)(8936002)(478600001)(1076003)(186003)(82740400003)(26005)(356005)(40480700001)(40460700003)(4326008)(6916009)(2906002)(81166007)(16526019)(70586007)(70206006)(7416002)(36860700001)(36756003)(5660300002)(8676002)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 00:10:56.0412
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6df70512-ce8b-434b-d9a9-08db2b3312be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4909
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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

