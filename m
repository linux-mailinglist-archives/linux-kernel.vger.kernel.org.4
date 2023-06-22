Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A83173A4BA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 17:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbjFVPYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 11:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbjFVPYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 11:24:33 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD12197
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 08:24:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jmKXd5qjNjfOYyaSCjJmr45XOhg9Hi3eWuhYC29qt5fl1AJ6iQlzt63RpFQ4hHRZPnxPGwlR77noVT1p6teb3T+9iTuO+1BmUr5u1xou34MQT73XXKxY0zAs6JdpBUxU6pBkVS3yyqPyDFpRKFT8Tz70523hO8rLtz/WIGOzOQc1EW0R/14PpLc/M8t/1BnTdqWCHbPwV8E6M52cJUif8m/jKfxzAMU4uBMQZMRlif7oXIcB+cz5Yfw/KpJS0vCR/E65cLOwe+sQwZi/+PnpNq6EREtiwRCd6lnQXkoHooYa8hjgykBMngcBZhuL9DiNMdJtGECIYJfohM0KJq1gHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZvE7+sHAx7gFFMEXYrdJmw8Y+MxDll2Zrp6Zoj6FHjM=;
 b=doxce6imwRpfvvNSauUCto86qdA9B/JzfpizRl+AKD/99deHTW/zg6aR94+KI8AAIM7erIc1xDY/WNk5039WYiXOVzjJzACfYWAK6GVtnxmtSPDcKtxqqp6iAgEBW4Qosy9yIcwiVTgXziOxYiaT3cXbXdiCtFC6W5+yyA+tuKAn5n/UErZKCpwRcjXgmB2MiF6DpjIn59KgCCfWI73hov40yBHeyF98oon/A8qGaGLvlI94+Op3wATMdLjR5NPl2P0naMOPRNnbk5Ezd1tFz+1m8tiySdaJ9Sdyp2+dzYm5nimr9tL8WmdZFAknmjtLyObCxFp4bv6yd5K7DO9elg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZvE7+sHAx7gFFMEXYrdJmw8Y+MxDll2Zrp6Zoj6FHjM=;
 b=tNEesaUzP8+/zpd+LAi6FMPrl/Hbf3g++gpnLN/CPtGJQFHRxUR/RM/JmWdACsI+oHDxl17tg+WS3hA1/P5mquvlMFoGN/etg25USEMsehCw9S00kJFTMrWEIs9E6Q/hiBqdNVEg5NWgptUxrCbtA25nB5yh+b+W58jSiWX3q/Y=
Received: from MW3PR06CA0009.namprd06.prod.outlook.com (2603:10b6:303:2a::14)
 by DS7PR12MB6287.namprd12.prod.outlook.com (2603:10b6:8:94::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 15:24:26 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:303:2a:cafe::fe) by MW3PR06CA0009.outlook.office365.com
 (2603:10b6:303:2a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 15:24:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.19 via Frontend Transport; Thu, 22 Jun 2023 15:24:25 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 10:24:25 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 10:24:24 -0500
Received: from amd-B450M-DS3H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Thu, 22 Jun 2023 10:24:21 -0500
From:   Syed Saba Kareem <Syed.SabaKareem@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "open list" <linux-kernel@vger.kernel.org>
Subject: [PATCH 01/11] ASoC: amd: acp: remove acp poweroff function
Date:   Thu, 22 Jun 2023 20:53:39 +0530
Message-ID: <20230622152406.3709231-2-Syed.SabaKareem@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230622152406.3709231-1-Syed.SabaKareem@amd.com>
References: <20230622152406.3709231-1-Syed.SabaKareem@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|DS7PR12MB6287:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eca2618-32fa-4c10-1a87-08db7334c3a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e3qUePiNR8Ra8HXL5HEyspS96cXAuTX0KqxO/DbICt5TMTtq/V3+vQUwFsPTkVCqXSbQhq7VFyNnuh1Q7VToT4x0aA0bmotqYZIUTtBMYbZ/NgF6k2AMSkGmaO4XbEnxjj9Vv+KwFKTJJU39jMiC9LGmT0Q/DsrVXM4rq44jgGGow9McF6SqePOqiIoDxNX/k9BFfonlnsw0TA37euk/qv7C1RDQ2B4jMBZWGpdVRTf006jRLgDsPFNFVRYNFP8GKDOPAy5V+Vp4CEc0gAaBU++mPuGlYJcj8LLOkInq5OYDftRqBbVJ625gulBVl0dzmqseD1Dq5VnVRRK/f3zDGE8UrE5XjnJlomxO3ICJHCISyODdEDTyKKhnDLX72k31Av4QBF4TsCKjtnHwguVpSbm4fBXi8cJu/tnmnGsPkqox2/7z+xvSmNDYo5ikPf5F9rf+gxec9u1mNIlPwD4d9cyxEeV4nvCOUQWBf4eZRrGv+nAyAnsWJKE0bdmdHg0MGUiAOQ+6+xYCcav1+4g9I91c0my8TYo6/YP8qUlaR1c3aw4d6szK2+y5ePQ4eyjziANVJcuBWBgkQEpeOqBTECu0U5xnD0CHH+uSOYjJJNpRcfWvAwg4oqVPbP26a9XUYxOsM+C3nj26dbv/+ufiSBHbDlkUxGNOl8woUVI/F3hGV+jmgUgXmxXTYDf4+SQ/wNBgosl56Y/urINNDNbuIddGlz5c/WXnYJgSeENEE7KMkNVyBpzhxSeZLi/7MmM7EnAzawz6znHUXwRtmgHvcQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(26005)(2906002)(8676002)(8936002)(86362001)(70206006)(316002)(4326008)(70586007)(478600001)(41300700001)(54906003)(110136005)(5660300002)(82740400003)(82310400005)(83380400001)(6666004)(7696005)(36860700001)(47076005)(336012)(426003)(2616005)(40460700003)(186003)(81166007)(356005)(1076003)(36756003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 15:24:25.9521
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eca2618-32fa-4c10-1a87-08db7334c3a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6287
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        TVD_SUBJ_WIPE_DEBT,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BIOS invokes ACP Power off sequence based on ACP device state.
Remove redundant code from ACP PCI driver for ACP Power off sequence.

Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
---
 sound/soc/amd/acp/acp-rembrandt.c | 25 -------------------------
 sound/soc/amd/acp/acp-renoir.c    | 17 -----------------
 2 files changed, 42 deletions(-)

diff --git a/sound/soc/amd/acp/acp-rembrandt.c b/sound/soc/amd/acp/acp-rembrandt.c
index 5c455cc04113..1b997837c7d8 100644
--- a/sound/soc/amd/acp/acp-rembrandt.c
+++ b/sound/soc/amd/acp/acp-rembrandt.c
@@ -204,23 +204,6 @@ static int acp6x_power_on(void __iomem *base)
 	return -ETIMEDOUT;
 }
 
-static int acp6x_power_off(void __iomem *base)
-{
-	u32 val;
-	int timeout;
-
-	writel(ACP_PGFSM_CNTL_POWER_OFF_MASK,
-	       base + ACP6X_PGFSM_CONTROL);
-	timeout = 0;
-	while (++timeout < 500) {
-		val = readl(base + ACP6X_PGFSM_STATUS);
-		if ((val & ACP_PGFSM_STATUS_MASK) == ACP_POWERED_OFF)
-			return 0;
-		udelay(1);
-	}
-	return -ETIMEDOUT;
-}
-
 static int acp6x_reset(void __iomem *base)
 {
 	u32 val;
@@ -299,14 +282,6 @@ static int rmb_acp_deinit(void __iomem *base)
 	}
 
 	writel(0x00, base + ACP_CONTROL);
-
-	/* power off */
-	ret = acp6x_power_off(base);
-	if (ret) {
-		pr_err("ACP power off failed\n");
-		return ret;
-	}
-
 	return 0;
 }
 
diff --git a/sound/soc/amd/acp/acp-renoir.c b/sound/soc/amd/acp/acp-renoir.c
index b3cbc7f19ec5..f188365fe214 100644
--- a/sound/soc/amd/acp/acp-renoir.c
+++ b/sound/soc/amd/acp/acp-renoir.c
@@ -169,17 +169,6 @@ static int acp3x_power_on(void __iomem *base)
 	return readl_poll_timeout(base + ACP_PGFSM_STATUS, val, !val, DELAY_US, ACP_TIMEOUT);
 }
 
-static int acp3x_power_off(void __iomem *base)
-{
-	u32 val;
-
-	writel(ACP_PWR_OFF_MASK, base + ACP_PGFSM_CONTROL);
-
-	return readl_poll_timeout(base + ACP_PGFSM_STATUS, val,
-				  (val & ACP_PGFSM_STAT_MASK) == ACP_POWERED_OFF,
-				  DELAY_US, ACP_TIMEOUT);
-}
-
 static int acp3x_reset(void __iomem *base)
 {
 	u32 val;
@@ -246,12 +235,6 @@ static int rn_acp_deinit(void __iomem *base)
 		return ret;
 
 	writel(0x00, base + ACP_CONTROL);
-
-	/* power off */
-	ret = acp3x_power_off(base);
-	if (ret)
-		return ret;
-
 	return 0;
 }
 static int renoir_audio_probe(struct platform_device *pdev)
-- 
2.25.1

