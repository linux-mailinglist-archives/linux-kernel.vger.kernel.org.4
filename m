Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4BB96EF450
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 14:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240894AbjDZM3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 08:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240907AbjDZM3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 08:29:37 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6D04C03
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 05:29:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qe2zaTPLGNzP1wq8JdTDT36gpQVzapQaUasT1p5UshaMcw8P2dfDkPhGM7KY3qWxrNpaH/LXGIL83zJ3CAWZmcq8xAtym/ZRJHHpvcUK993OJWbDXeVdtc+ifBA40iUFcanBSwkj4bpCfZc+N1KAfV7/x9yxqsfGwErtavqT4I6va6cRzzIgHJ/mr1ZQGNwx9EqWbMfLusvM6beATM4NQ9wifX5k1aldnGPw/nD8b6ewraXGgkIhobF16bnU1K1iscpWCS5/Xga65mM6p1aNFNGOixzHwFVYc5AqXX6+A4sjVy/AcQCGUkZYeSsrJGEiNa22ZdpmzJqF8XYvB5ye8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGou7InbW7YVGCF6nSgg6DEjs9tXDrTiIWhKUYz64MA=;
 b=Yylsm8ozNjfKjgYos8URuy/ISnFgkmq12J31K6z38hIWHlahG6oS+x0PrEJxqO4WFq8TXrXcSXeOGudNGAbVOamj1MtPBx/mtNUhCxezDTj23fA+9Bci7qa4aB54DOK9o0/6tOho8SThCFP58oMUeltJVTk7MbJqBLOuPxFpPgH72Ud/UEDU25WwFClupfBNTak/b2vlLUPqBEpY1/ChBq8uR72Rvxy/CMFRe0flhaa30zEXld9Okg4R40FQIDxIM80ZEF1PDQIJqZWgFbcRoz7jV/nx1W2apkHPbz2U0qzy9uyG9uTRo+Bx1YrZsP4coO/xQDCHKSauv4hKJFOgAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGou7InbW7YVGCF6nSgg6DEjs9tXDrTiIWhKUYz64MA=;
 b=HXXjeeLESQN6ISHRqvGmObim6K+PzqILtzEdaHTf1/IPiiGzGqyZHUi5F4ycwF9raGvPMwcELBWQvDZnfl2edCot28CLb241zLjj2gqU/IFX1pGkbMFgKsV/YM1aSR1twj25cmg1i6u+WB53WQ9G3qbqkJZCDuQEmOqCZACv3eU=
Received: from CYXPR02CA0041.namprd02.prod.outlook.com (2603:10b6:930:cc::6)
 by DS7PR12MB8203.namprd12.prod.outlook.com (2603:10b6:8:e1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Wed, 26 Apr
 2023 12:29:10 +0000
Received: from CY4PEPF0000C972.namprd02.prod.outlook.com
 (2603:10b6:930:cc:cafe::a3) by CYXPR02CA0041.outlook.office365.com
 (2603:10b6:930:cc::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21 via Frontend
 Transport; Wed, 26 Apr 2023 12:29:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C972.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.16 via Frontend Transport; Wed, 26 Apr 2023 12:29:10 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 26 Apr
 2023 07:29:09 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 26 Apr
 2023 07:29:09 -0500
Received: from amd-B450M-DS3H.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 26 Apr 2023 07:29:05 -0500
From:   Syed Saba Kareem <Syed.SabaKareem@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <basavaraj.hiregoudar@amd.com>,
        <sunil-kumar.dommati@amd.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "Nathan Chancellor" <nathan@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] ASoC: amd: ps: refactor acp power on and reset functions.
Date:   Wed, 26 Apr 2023 17:52:02 +0530
Message-ID: <20230426122219.3745586-2-Syed.SabaKareem@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230426122219.3745586-1-Syed.SabaKareem@amd.com>
References: <20230426122219.3745586-1-Syed.SabaKareem@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C972:EE_|DS7PR12MB8203:EE_
X-MS-Office365-Filtering-Correlation-Id: f1013537-50cf-4e57-eb65-08db4651d61a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O6Zif1p9yhivmNoaQVn04lpBakoblbG8QM8FcEJ7lYil+tM7FmawQ3LanO/mHUu1l5gIAKA6YIjb/c+t1LY/j+WdHdFN04NJBDo8QiyvMzmchKcbCkv9WDrWLR7TieVw/yc0TR1Pyf2DwX3TXx4JAHcCn6+myB2Ud9SWtfOj1291LTknEVWtQMmdwt+RWur6kffJX09zgz7Agnj4BW6THUbbG0yAS7he30wA3y/rktsZYnspeIJEJDghFUBJeaaqMHfReaJiRvOsYE9MGXGePcbzy/JVI9dThXjIuYpTiynmjUhgyAoxIWq5I52uxoilo8zkV99nDihOdEpc54QcFueyJQAG6TwDo8513+Qdunjtd3+w7zIMxQlIpLsG+bF3jgUY0nAZ1SUDUo5F8ZHTJsIy87oPoSn2Kl2WPfPPyC5Z0vKUg2vBpOLb7a+vxOVAH3kgXZj5PD5VvURNNHSTFu+jtUIf+/0xAESKd7h3rEbNCrUYP5UwpxjFfN264S9tQNgMQWIwsv5dmxTvQD1Nro0KqDH74ru3yp0CP+Xk+8qpsVydd05Xsyb4Yu94oI40Pa5OsWT1F4dk3VO3F4LaVHLq8HcjT5HkQY5cw/QhE/Psc0L6hMj6ulYuA5aS2Fh3m4egoqJKKmgODgRXc0m1mjYWxNss2BsULAEOTZMfyFmnf+eEnDAOtsb5hz6zUiIyUj/RVIrlTFjncyefPSpZEyDeecb1DOdrNISyhXEasI0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199021)(46966006)(36840700001)(40470700004)(54906003)(2616005)(47076005)(83380400001)(478600001)(36860700001)(7696005)(40480700001)(1076003)(26005)(6666004)(82740400003)(41300700001)(4326008)(81166007)(110136005)(316002)(356005)(186003)(336012)(426003)(70206006)(70586007)(5660300002)(8936002)(2906002)(40460700003)(86362001)(8676002)(82310400005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 12:29:10.0347
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1013537-50cf-4e57-eb65-08db4651d61a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C972.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8203
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of a busy waiting while loop using udelay in
acp63_power_on and acp63_reset functions use readl_poll_timeout
function to check the condition.

Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
Reviewed-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/ps/acp63.h  |  3 +++
 sound/soc/amd/ps/pci-ps.c | 38 +++++++++++++-------------------------
 2 files changed, 16 insertions(+), 25 deletions(-)

diff --git a/sound/soc/amd/ps/acp63.h b/sound/soc/amd/ps/acp63.h
index 16eeda3fbdbd..eb4e9334b5e8 100644
--- a/sound/soc/amd/ps/acp63.h
+++ b/sound/soc/amd/ps/acp63.h
@@ -58,6 +58,9 @@
 #define ACP63_PDM_DEV_MASK		1
 #define ACP_DMIC_DEV	2
 
+/* time in ms for acp timeout */
+#define ACP_TIMEOUT		500
+
 enum acp_config {
 	ACP_CONFIG_0 = 0,
 	ACP_CONFIG_1,
diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
index 097fd5488534..c957718abefc 100644
--- a/sound/soc/amd/ps/pci-ps.c
+++ b/sound/soc/amd/ps/pci-ps.c
@@ -14,13 +14,13 @@
 #include <linux/interrupt.h>
 #include <sound/pcm_params.h>
 #include <linux/pm_runtime.h>
+#include <linux/iopoll.h>
 
 #include "acp63.h"
 
 static int acp63_power_on(void __iomem *acp_base)
 {
 	u32 val;
-	int timeout;
 
 	val = readl(acp_base + ACP_PGFSM_STATUS);
 
@@ -29,38 +29,26 @@ static int acp63_power_on(void __iomem *acp_base)
 
 	if ((val & ACP_PGFSM_STATUS_MASK) != ACP_POWER_ON_IN_PROGRESS)
 		writel(ACP_PGFSM_CNTL_POWER_ON_MASK, acp_base + ACP_PGFSM_CONTROL);
-	timeout = 0;
-	while (++timeout < 500) {
-		val = readl(acp_base + ACP_PGFSM_STATUS);
-		if (!val)
-			return 0;
-		udelay(1);
-	}
-	return -ETIMEDOUT;
+
+	return readl_poll_timeout(acp_base + ACP_PGFSM_STATUS, val, !val, DELAY_US, ACP_TIMEOUT);
 }
 
 static int acp63_reset(void __iomem *acp_base)
 {
 	u32 val;
-	int timeout;
+	int ret;
 
 	writel(1, acp_base + ACP_SOFT_RESET);
-	timeout = 0;
-	while (++timeout < 500) {
-		val = readl(acp_base + ACP_SOFT_RESET);
-		if (val & ACP_SOFT_RESET_SOFTRESET_AUDDONE_MASK)
-			break;
-		cpu_relax();
-	}
+
+	ret = readl_poll_timeout(acp_base + ACP_SOFT_RESET, val,
+				 val & ACP_SOFT_RESET_SOFTRESET_AUDDONE_MASK,
+				 DELAY_US, ACP_TIMEOUT);
+	if (ret)
+		return ret;
+
 	writel(0, acp_base + ACP_SOFT_RESET);
-	timeout = 0;
-	while (++timeout < 500) {
-		val = readl(acp_base + ACP_SOFT_RESET);
-		if (!val)
-			return 0;
-		cpu_relax();
-	}
-	return -ETIMEDOUT;
+
+	return readl_poll_timeout(acp_base + ACP_SOFT_RESET, val, !val, DELAY_US, ACP_TIMEOUT);
 }
 
 static void acp63_enable_interrupts(void __iomem *acp_base)
-- 
2.25.1

