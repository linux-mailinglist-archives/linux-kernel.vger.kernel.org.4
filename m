Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE0D673023
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 05:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbjASE0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 23:26:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjASD5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 22:57:04 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0942342DF4;
        Wed, 18 Jan 2023 19:55:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cS5xJPFr4sj7fckYqmE3UuOkepwvLD199hS/TcRnZttKImTeviz97LNmwB0fJg6PgTkKGBJ9Nqm2wUp7c661sLnou8QUSroS7n1fmvpC5Ax2kSI6Dte7l5QaAY+KP1b+23WGR6VoI7UZfe6g6uLDMULfT2h+OydPW+YCrYITID5q1PfkVj/pl4fgkclApK5Du4lTU8ZPpZY7gqc7MeUNypfV0RgVhTFwNAXBihET3xob90wztQeHMRLmk52xDeRKjBXXWRTXHQnErUFZtBZziXbPcsHhTAwZFtgmklun+c3uBAysoL2nvBVDa0GgixZceD6/6ZltVbUhoivs5LXSmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ASmDPbaFuzX/ldCl1/F7wg3DR9HkEcxMnn+qoW/V/nU=;
 b=TANxwT2kZR+7gnyoCnlp/+mKidWGykKZPwsAkDQdCuJoMAUq2+ENhHzaf7bkPDvhwLWqDzzmBO9Gza+LCUe1iwRKks8+AhIoJM86MwQL/ipjjGwseaowuZhMqMzd1EsBs4ntgl150kncSCC9wzn8CPSiyl8erEi2eRHsP7Dl5NLWzYM9Wm/pTOam3i/qhAm+4eyanX2RrPg9jC5hJyCZOnJ51KZ48ChahcPFpSbMVScwSjbAG6XVfWyb9tSxtapyYVVY9RcYm4hJXGQnEUq/Kd1im5qnGJHjNyHh+XPYXurMj7As3ktiFcNYzEsRERG/SCwDoD4rvY5LcvX7nQ+Flw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ASmDPbaFuzX/ldCl1/F7wg3DR9HkEcxMnn+qoW/V/nU=;
 b=P+yraJD0/6RWzXFRJiTgcx/3olvanii85tHSDA/tcf3+Jrb2UmsHwnFDomAOU2SUsrIAOtdDGB+I+BdrJNbZV/XkzEOqIEwgHPtHuwmn7B4aWu5OttuBCqG0RNMabVcxglHMpnDXKV7u7wEmMKw+0qx8e40MrP7pOm6m+3Vfj+U=
Received: from MW4P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::8)
 by CY8PR12MB7634.namprd12.prod.outlook.com (2603:10b6:930:9d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Thu, 19 Jan
 2023 03:53:03 +0000
Received: from CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::8) by MW4P220CA0003.outlook.office365.com
 (2603:10b6:303:115::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.25 via Frontend
 Transport; Thu, 19 Jan 2023 03:53:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT042.mail.protection.outlook.com (10.13.174.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6023.16 via Frontend Transport; Thu, 19 Jan 2023 03:53:03 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 18 Jan 2023 21:52:59 -0600
From:   Brad Larson <blarson@amd.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <adrian.hunter@intel.com>,
        <alcooperx@gmail.com>, <andy.shevchenko@gmail.com>,
        <arnd@arndb.de>, <brad@pensando.io>, <blarson@amd.com>,
        <brendan.higgins@linux.dev>, <briannorris@chromium.org>,
        <brijeshkumar.singh@amd.com>, <catalin.marinas@arm.com>,
        <davidgow@google.com>, <gsomlo@gmail.com>, <gerg@linux-m68k.org>,
        <krzk@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <lee@kernel.org>, <lee.jones@linaro.org>, <broonie@kernel.org>,
        <yamada.masahiro@socionext.com>, <p.zabel@pengutronix.de>,
        <piotrs@cadence.com>, <p.yadav@ti.com>, <rdunlap@infradead.org>,
        <robh+dt@kernel.org>, <samuel@sholland.org>,
        <fancer.lancer@gmail.com>, <skhan@linuxfoundation.org>,
        <suravee.suthikulpanit@amd.com>, <thomas.lendacky@amd.com>,
        <tonyhuang.sunplus@gmail.com>, <ulf.hansson@linaro.org>,
        <vaishnav.a@ti.com>, <will@kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v9 14/15] mmc: sdhci-cadence: Support mmc hardware reset
Date:   Wed, 18 Jan 2023 19:51:35 -0800
Message-ID: <20230119035136.21603-15-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230119035136.21603-1-blarson@amd.com>
References: <20230119035136.21603-1-blarson@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT042:EE_|CY8PR12MB7634:EE_
X-MS-Office365-Filtering-Correlation-Id: 32efbb21-267e-4d7a-37b6-08daf9d0aa75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ndwRT0jnZPfoV7ON/VwYVjHTaDlQqQ8ep80VQBetI2vvHW5sHxS2IoT1ZSzUsOB28JjgCfoDQ5RjuEu+siE0QyifJZqaK1REF71WHthUtGi1kvFLJx+yHTPatCJY66dWdk6x3McTzx9XWfNUM4gVfsLxkexZEiHApxSBEYx03BthZbUUAUfjO+J2UH3R7P19in8dt8M+u69buzXi+9m6TSTh39nnTkAapxbCDJqQ1B7KlNps6fbe2jmRHH75WRh2/XJd1ds81/jf9cGbT1uSq7R3qx5vnUPzbTo/WRb0GLcdBtZGxuK0FSlHoj2g/2cOigc4ljpN0kpM6Ah4KyhAQMU/IlpXB51/lAcdJJ+wwTJdowuANt0LJ1xbqDSiHYbxgf7jLIPm6sskR2UWr4kDVDmBkbd9iB39wFCJql1Tf/5wpmiixiJy+s/+4cbrsmPcErlyAErFbI/Fs0QFVoqdJUxH0255aamP+D9qhYIRze4vZpLi7PrvvLlc2IvhkRPUqcDeQfZGuAchwo1vyj1ww/ZPD7sXzTQQ83vdvLxg/ju14DuoXVLzie9H/T1Hwe7l/h7GillFSzs+5WcSUZZC899syZslq9rs0cL2qnhAPHNvtnIK0Ez67u6JX9qDga/jNpf4sOU74/Ixaw0aYkEj+d96g8D202H4+Qt3O1zBCRC+BD8tbydfMY0oCH3xSdyjOLGgDFKNpHTzY4/8HG5m5yEXSbqcZlVGOnyQmROz+lA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199015)(36840700001)(40470700004)(46966006)(36756003)(40480700001)(54906003)(186003)(316002)(40460700003)(6666004)(478600001)(36860700001)(5660300002)(7406005)(7416002)(2906002)(8676002)(70206006)(4326008)(8936002)(6916009)(41300700001)(70586007)(356005)(82740400003)(82310400005)(81166007)(336012)(2616005)(1076003)(26005)(16526019)(83380400001)(426003)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 03:53:03.3106
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32efbb21-267e-4d7a-37b6-08daf9d0aa75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7634
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
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
---

Changes since v6:
- Previously patch 17/17
- Changed delay after reset_control_assert() from 9 to 3 usec
- Renamed sdhci_mmc_hw_reset() to sdhci_cdns_mmc_hw_reset()

---
 drivers/mmc/host/sdhci-cadence.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
index e92aa79a8be2..62321cef41db 100644
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
@@ -458,6 +460,24 @@ static void sdhci_cdns_hs400_enhanced_strobe(struct mmc_host *mmc,
 					 SDHCI_CDNS_HRS06_MODE_MMC_HS400);
 }
 
+extern unsigned int sdhci_timeout_val;
+
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
@@ -521,6 +541,17 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 	if (ret)
 		goto free;
 
+	if (host->mmc->caps & MMC_CAP_HW_RESET) {
+		priv->rst_hw = devm_reset_control_get_optional_exclusive(dev, "hw");
+		if (IS_ERR(priv->rst_hw)) {
+			ret = PTR_ERR(priv->rst_hw);
+			if (ret == -ENOENT)
+				priv->rst_hw = NULL;
+		} else {
+			host->mmc_host_ops.card_hw_reset = sdhci_cdns_mmc_hw_reset;
+		}
+	}
+
 	ret = sdhci_add_host(host);
 	if (ret)
 		goto free;
-- 
2.17.1

