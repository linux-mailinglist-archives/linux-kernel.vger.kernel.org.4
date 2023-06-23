Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3BB73B3C6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 11:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbjFWJiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 05:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbjFWJh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 05:37:56 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EF926AF
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 02:37:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EYtXnFQ5HwcMOoC6PjI4KufRujfuM3pPoQ0iCImqd8N6d4NzDuT+KcQmRnkUfPWWKyY5rD1+jT313c+g8xegh3cm0bItF3MkC8iT8pVooZcLL1/Z8t4sWYRcJuC42AkWY9PPz9JduW8dFbAQSsam8OeQm9093Tos9GrMzwVdxMRwl3bHVsZLJSPEuqJ+0CyEH5xrRmRxveL9MELeZ+XpTr67u7ICOzjGg7S1tRnB/CUv6U9k61j3EOk22w82ek7vrfxbINe23UHBgRXICRhysKPGTtRGQbizJa1xYdcOM/WP9Di7hcpWCnl8iPN8SpgYRfUtWxftsA+3FpQ/t/xfuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uff4I+f/JIXJsb1bkQsRX8wckjpzJfKnrgqnvisMh6E=;
 b=E2PZhaEcOolElJLqriAlA8MIMnbvl3+1izLrZpbkhVa9npQLrx8+tRzl3fCMFQdUXCVIC6UCR/VY9moOKx42kcLuyHlSI+rbZc3IKS4RnBojkrDMnwVggs9xdMoqRHsP297RxSJcgySHAlR2c7vIxRfI2L7L5HWMGOcJN+Im7XclWlOD0XByX8+wLwJNBusESKeMzI8xhLLLOQQpy02jlnZu5RItqU7UZC2+cM3pTXNxLlpdAv2Gb05oKqzusoYuvpPmZqm/vIu4WgDfQ6qdnA2+vlgnQC8Sn0Mk7U2CdT/vXqKZVGxePeD+d376C3KMDx7VkbeS2e98OcHwsngJmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uff4I+f/JIXJsb1bkQsRX8wckjpzJfKnrgqnvisMh6E=;
 b=fp31OFPAa/orE+s8prYGywByQwhSGNHVfus7EdQz3imhFlv0VQudErtz6fO8TEDumvsWkw0atbbHhTIqnAZabQ4/T8M9z/ERaIKppT7RZ0ICna4E3cPdCvblxA8UdCkfiIKC+v0nOb14sKRnxJdgOwHg6wQVGz2D7EKZwevnZnI=
Received: from MW4PR03CA0043.namprd03.prod.outlook.com (2603:10b6:303:8e::18)
 by PH7PR12MB6468.namprd12.prod.outlook.com (2603:10b6:510:1f4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 23 Jun
 2023 09:37:28 +0000
Received: from CO1PEPF000044F9.namprd21.prod.outlook.com
 (2603:10b6:303:8e:cafe::e3) by MW4PR03CA0043.outlook.office365.com
 (2603:10b6:303:8e::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26 via Frontend
 Transport; Fri, 23 Jun 2023 09:37:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6544.9 via Frontend Transport; Fri, 23 Jun 2023 09:37:27 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 23 Jun
 2023 04:37:26 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 23 Jun
 2023 04:37:26 -0500
Received: from amd-Z390-D.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Fri, 23 Jun 2023 04:37:16 -0500
From:   Arun Gopal Kondaveeti <arungopal.kondaveeti@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <sunil-kumar.dommati@amd.com>, <venkataprasad.potturu@amd.com>,
        <syed.sabakareem@amd.com>, <mario.limonciello@amd.com>,
        Arun Gopal Kondaveeti <arungopal.kondaveeti@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Syed Saba Kareem" <Syed.SabaKareem@amd.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] ASoC: amd: update pm_runtime enable sequence
Date:   Sat, 24 Jun 2023 03:11:40 +0530
Message-ID: <20230623214150.4058721-1-arungopal.kondaveeti@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F9:EE_|PH7PR12MB6468:EE_
X-MS-Office365-Filtering-Correlation-Id: 921700c0-91c6-48e7-11e4-08db73cd7593
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8QvE0eruGI6uyTDLgmwjCC/9fTh6pRjfCj0yk8cv4YdTFWB4Jasy9db9pmq4rcRjqOeRD9JxQRmJQJao2VkJYbQQCHryiNWY/e2GH426vtmtfYYzsfTEABiFtNindIQGhrDSgJP+6lS8pmMTJ1NbItUYgcLkFnKKBmN7z8V1e/YRE4nBBz18DrTwwBX6qgnPnFz+0ETyAarM35e4eXw1selsa1prDpeX4ZX+drVFfQmpbtXtrP3fttF54qmpLsQ/HRXPrQV90p4oU76VPMOJ2em4xtifDz9EJzJWit3OpvfKad9Z1k0pbnx5n79lMRefVTtc9970Rsy1d+ByS2sJlbLKpEn0N4fcDrrbMX98U97vQdILSAi0oTkUOcosOKUhNMYgaRLsTX/1J0MMg1ZJkSVYlDIyPjcJIBxkQ0voTRm7CQHAdMgvzZTaAmHUgvbjGH1rhmdEru8EOaq/p27cGqj1V3XS9jUxfR4qQ5JApYjB9c5oJCHDIYPLxOkqaLlv9nYRo+NAKEdtEDb9QNtnKkiXJlKKGrSV74yRScccPpV4JWkxgWdNhaJN/sp6aPD2bw5ElzpwxxLBrHK+RAKJiwIsqnoZ3K17mI4lAPi4fwiRkr8e5jAfevupjsMkSPRas8CDCdoTI9HN8b7V7TasKHhYCj/7dBoJeMO+A4xFMCz7KQApxz7mGbcD42wNJEYxIqIdpCvi0rWVZhTd2YXCgjCGhgGRhJQBDcCdlsRcHd8Rt574wRtmepXAz+VRPZOaOkIZcETgc21CcgTHcaO9vQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(396003)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(356005)(82310400005)(81166007)(86362001)(40480700001)(40460700003)(316002)(2616005)(41300700001)(8936002)(8676002)(70586007)(4326008)(70206006)(336012)(5660300002)(15650500001)(7696005)(426003)(1076003)(478600001)(6666004)(54906003)(110136005)(83380400001)(186003)(26005)(36756003)(36860700001)(2906002)(47076005)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 09:37:27.9400
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 921700c0-91c6-48e7-11e4-08db73cd7593
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6468
X-Spam-Status: No, score=2.1 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pm_runtime_allow() is not needed for ACP child platform devices.
Replace pm_runtime_allow() with pm_runtime_mark_last_busy()
& pm_runtime_set_active() in pm_runtime enable sequence for
ACP child platform drivers.

Signed-off-by: Arun Gopal <arungopal.kondaveeti@amd.com>
---

Changes since v1:
    -- Updated commit message

---
 sound/soc/amd/ps/ps-pdm-dma.c         | 3 ++-
 sound/soc/amd/raven/acp3x-pcm-dma.c   | 3 ++-
 sound/soc/amd/renoir/acp3x-pdm-dma.c  | 3 ++-
 sound/soc/amd/vangogh/acp5x-pcm-dma.c | 4 ++--
 sound/soc/amd/yc/acp6x-pdm-dma.c      | 3 ++-
 5 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/sound/soc/amd/ps/ps-pdm-dma.c b/sound/soc/amd/ps/ps-pdm-dma.c
index bdbbb797c74d..d48f7c5af289 100644
--- a/sound/soc/amd/ps/ps-pdm-dma.c
+++ b/sound/soc/amd/ps/ps-pdm-dma.c
@@ -391,8 +391,9 @@ static int acp63_pdm_audio_probe(struct platform_device *pdev)
 	}
 	pm_runtime_set_autosuspend_delay(&pdev->dev, ACP_SUSPEND_DELAY_MS);
 	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_mark_last_busy(&pdev->dev);
+	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
-	pm_runtime_allow(&pdev->dev);
 	return 0;
 }
 
diff --git a/sound/soc/amd/raven/acp3x-pcm-dma.c b/sound/soc/amd/raven/acp3x-pcm-dma.c
index 7362dd15ad30..9538f3ffc5d9 100644
--- a/sound/soc/amd/raven/acp3x-pcm-dma.c
+++ b/sound/soc/amd/raven/acp3x-pcm-dma.c
@@ -416,8 +416,9 @@ static int acp3x_audio_probe(struct platform_device *pdev)
 
 	pm_runtime_set_autosuspend_delay(&pdev->dev, 2000);
 	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_mark_last_busy(&pdev->dev);
+	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
-	pm_runtime_allow(&pdev->dev);
 	return 0;
 }
 
diff --git a/sound/soc/amd/renoir/acp3x-pdm-dma.c b/sound/soc/amd/renoir/acp3x-pdm-dma.c
index 4e299f96521f..c3b47e9bd239 100644
--- a/sound/soc/amd/renoir/acp3x-pdm-dma.c
+++ b/sound/soc/amd/renoir/acp3x-pdm-dma.c
@@ -430,8 +430,9 @@ static int acp_pdm_audio_probe(struct platform_device *pdev)
 	}
 	pm_runtime_set_autosuspend_delay(&pdev->dev, ACP_SUSPEND_DELAY_MS);
 	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_mark_last_busy(&pdev->dev);
+	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
-	pm_runtime_allow(&pdev->dev);
 	return 0;
 }
 
diff --git a/sound/soc/amd/vangogh/acp5x-pcm-dma.c b/sound/soc/amd/vangogh/acp5x-pcm-dma.c
index 29901ee4bfe3..587dec5bb33d 100644
--- a/sound/soc/amd/vangogh/acp5x-pcm-dma.c
+++ b/sound/soc/amd/vangogh/acp5x-pcm-dma.c
@@ -409,9 +409,9 @@ static int acp5x_audio_probe(struct platform_device *pdev)
 	}
 	pm_runtime_set_autosuspend_delay(&pdev->dev, 2000);
 	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_mark_last_busy(&pdev->dev);
+	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
-	pm_runtime_allow(&pdev->dev);
-
 	return 0;
 }
 
diff --git a/sound/soc/amd/yc/acp6x-pdm-dma.c b/sound/soc/amd/yc/acp6x-pdm-dma.c
index d818eba48546..72c4591e451b 100644
--- a/sound/soc/amd/yc/acp6x-pdm-dma.c
+++ b/sound/soc/amd/yc/acp6x-pdm-dma.c
@@ -383,8 +383,9 @@ static int acp6x_pdm_audio_probe(struct platform_device *pdev)
 	}
 	pm_runtime_set_autosuspend_delay(&pdev->dev, ACP_SUSPEND_DELAY_MS);
 	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_mark_last_busy(&pdev->dev);
+	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
-	pm_runtime_allow(&pdev->dev);
 	return 0;
 }
 
-- 
2.25.1

