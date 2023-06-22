Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A83873A4BC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 17:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbjFVPZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 11:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbjFVPZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 11:25:01 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEAB91AC
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 08:24:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oDZTZ+JRXxFEVO1/bFzL71Eli0T/WiYkUM8QiO9nvoq7HJGM03hlfZla7GEjWk/Xf/mPnHFMcvdXCwV8bHRhK9lfy1vX1hnK0mssYBZ8CR2PjC+PiH+jKkhlFw2Er4grPiaamOh/wEZtYQItqLZQ734LMbexT1rFqN4dJyp7YfQ1hdca5QcAekUoIe+BlY0Cwx9KyGK4hHvbNPyyK3asFA+knVzXYRC3R3TFUaarlW+pyPoxbs/fxGglMxxHqBH50gk9kdardWD+xnc5VlAUtEXHFikuPD9+hjN9YLnE+bmc4urUVe5RefDbyXcYJ0Tpds1idcVgLHC+FvXAtRCUyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZvE7+sHAx7gFFMEXYrdJmw8Y+MxDll2Zrp6Zoj6FHjM=;
 b=jqWK/Ls6hlDRc8E9vzKkuD5K/RdHHaYIrhk0V6//rQrymgOLuHJYjgv8WymjvqNW/GEhVsCYLxbJanCfiT31wQ0GU0JMyGTYFoWpcp3MZaE4G9oC36v5LJsdn6O8k2iNUHa4Qda+nk8s9+wHpufKSEQkBx4c7am0GJkKIesgH6eA0Vf+NTJHw7y4kN3WHq9KEoanOXLhol8i0T7dfqZLUQpHMj81qtE97wRDXHfgYZAKmff0v+Ii6lQCHj+7cPowRuDKRsZ8zB+iqDF0WEamve4O/UHP6ADjviBng1x+1IwVwaQ2a6ZqMq9vrKDq6HJB/fvS6ldGmDKg0+kqEomefw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZvE7+sHAx7gFFMEXYrdJmw8Y+MxDll2Zrp6Zoj6FHjM=;
 b=H3c0bvLRUuTDtqa/2GU0BQ2LlkbbqlLGcpRnN/9SWVcrLV2DsL7JCBmdvYUhoVpmRaF5O5Dzz+K/h4vsRZGOtN/hwVBGUiwq1g2r0y10BOy3PNTXmmoCq9UVFKW6OrSglSWXK6Qx2FEesXnXbVFVvD1Y4SrwnSaVh4c4dpBI7+U=
Received: from BYAPR08CA0055.namprd08.prod.outlook.com (2603:10b6:a03:117::32)
 by MN0PR12MB5929.namprd12.prod.outlook.com (2603:10b6:208:37c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 15:24:54 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:a03:117:cafe::d8) by BYAPR08CA0055.outlook.office365.com
 (2603:10b6:a03:117::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 15:24:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.19 via Frontend Transport; Thu, 22 Jun 2023 15:24:54 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 10:24:52 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 08:24:51 -0700
Received: from amd-B450M-DS3H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Thu, 22 Jun 2023 10:24:48 -0500
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
Subject: [PATCH 02/12] ASoC: amd: acp: remove acp poweroff function
Date:   Thu, 22 Jun 2023 20:53:41 +0530
Message-ID: <20230622152406.3709231-4-Syed.SabaKareem@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230622152406.3709231-1-Syed.SabaKareem@amd.com>
References: <20230622152406.3709231-1-Syed.SabaKareem@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|MN0PR12MB5929:EE_
X-MS-Office365-Filtering-Correlation-Id: 114562e0-6ee2-4b15-e38f-08db7334d46e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V180SkfO6GvLM/lOTYUokf8gDHHbMOjyJ4+6Z//Zyg2Mzti3PciHQ7vbJGGWRupCkV/v9b8viSdg/BGKF8zPiD0gYCQqOb5mg11AqSreXPQZ2kiREvw8PEGKXYfbjk5Kg9T5SNyHQjyYUOVcbvnbxhCLMWck4p9HSL8DHiohnmantGEHCGiZ+dUySGfiHVZuoTs/fOBFiTHCzSmxC0ZE68+TXp0O4eNyk9RejJ27GLwRiTqqf8rEuej+rl0FO+SY9RKYZc9N9L9F2eh7B1UVUzOxPdrrtHZKcj17vv7UV0CbEJd9gkWVRhtwr5LF7KO+iA1aJV9DDrbDIUiSbePuiD5bQBGlDBBK2GshAl5vuwfVVFWl8rLff0sMCqZMMtCeKr1l3j87Q65UP+yiVB4sytX+SFuw+iKYap/mkWFwZyCfJZByOwkJhfA2Sde/wgTl4ScZrKfsQCAeB9Kkv7aj8LpzLAr7mkfC6r+VP5ly3DhHj3q1iDpysCDkZLMVbkdTBEoiJG0IUDXIsC/fk+1amCqvuSN23o2Gjtjgjw8N+8WqtEKyVdgyReUSCw0tIHkrpPpVJy9ngIWEaxPCIZ670FPMNUCrIwOfsHQo5eQRmt6jvWXU7VeWvAoU6Vt118Gihv+0wntMKEhH/Q2Mao/hCRJ5NNp6FXIxpztnpucHLZUZDhXgeR2OEKUcIWv6OIa/L6t5VyVs73No/x6WkWGkYro7qnoukUV24HFRUrJwc0OTDiGUBtB4bo+OUddKdZWB2cNZxX0cRNprLvoJqijdbg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(346002)(396003)(451199021)(40470700004)(46966006)(36840700001)(40480700001)(110136005)(356005)(478600001)(40460700003)(26005)(186003)(8676002)(8936002)(336012)(41300700001)(82310400005)(316002)(81166007)(2616005)(54906003)(70586007)(70206006)(82740400003)(4326008)(36756003)(6666004)(1076003)(7696005)(5660300002)(2906002)(86362001)(426003)(83380400001)(47076005)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 15:24:54.0869
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 114562e0-6ee2-4b15-e38f-08db7334d46e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5929
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

