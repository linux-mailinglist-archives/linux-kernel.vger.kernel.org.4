Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1DE672E2F2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 14:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242404AbjFMM2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 08:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242465AbjFMM2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 08:28:24 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5B21998
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 05:28:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ivoDcP2yxX+hJwW9R96/LRrhEdoRyonlHaiJ6/4/6dVok03fCvKtqBKgNafUvETDajuz+kNdZghje8GVpV3C9+w1yqMfNTJipkXxR8N4mlUsyyZCpETqTMu43EcLsPhzqrrzadX+pcZeRvWISlcl+ZjuKEfzUBfRdBK07dlbqWqrTssrMN8veTzf+v58B5V6joDkUhRdCfeYXUmrYxQ2jOKOOmQUhRiKR4q85+opF0BQG8ejPaOK01kGVDYJ6D0VBig3gJRcaA/nbiP/1dCNivx/ozkoGjbWQdgkjBud/9y/MrBp0atZJkkrkCdmFKJcTuJU/Jm1lZWXgj7Hve5lCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hO2JSQyz6gRmMoZGHNyD60VEPB42Wq/pL3MpoRi4GeQ=;
 b=Y0pVttY/3IAzMRSFC3go/KKDoiubQx8TsBqYQhfQSPkRnfsZghGfcBabI4zOhzoFzMmgSglmiSMtnlqjjFSufRy+KDCVvdn15c8BbYGCVlTeKAJiCCOqgf1hVU4khIzA3zCuA2H1MrIaapKZAP532/gxXaBpQrbiqnWHonpmNMnejqAOAwn/IMwboo/3TZW9nFafcfwnga1rVPNoMLIkdSzOIqK3ZoiL4J2cvjz5rm6dc11WAtpsDgSA0tP7Rt/rUbrpaZV5nVN8Y8Ce7/+lk8GuqXHyFCaePWmkLAJrVUrg+RPNElrPJEGhpAFFvg6zUXVe2F1RQ7OXGipYk2F6Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hO2JSQyz6gRmMoZGHNyD60VEPB42Wq/pL3MpoRi4GeQ=;
 b=Kg59ikpAnnjwkhcq2KQB8TnP2d/50PxtOl0e/Dyeo9zVG0umD9cNx7Bknyz4UfrDfDMp2li46nWyZ70syupWbAFYTCxAjAP765LjxO549VrmmH7jjoaz0yfCXZX5Vi1aE9RhJN1VLlzG321i4P+t8UtdVdAigQXR/9SOyYBovL0=
Received: from BN9PR03CA0367.namprd03.prod.outlook.com (2603:10b6:408:f7::12)
 by IA0PR12MB8839.namprd12.prod.outlook.com (2603:10b6:208:493::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 13 Jun
 2023 12:28:00 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f7:cafe::7d) by BN9PR03CA0367.outlook.office365.com
 (2603:10b6:408:f7::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.35 via Frontend
 Transport; Tue, 13 Jun 2023 12:28:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.23 via Frontend Transport; Tue, 13 Jun 2023 12:28:00 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 13 Jun
 2023 07:27:59 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 13 Jun
 2023 05:27:54 -0700
Received: from amd-Z390-D.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Tue, 13 Jun 2023 07:27:44 -0500
From:   Arun Gopal Kondaveeti <arungopal.kondaveeti@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <vsujithkumar.reddy@amd.com>, <Vijendar.Mukunda@amd.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <syed.sabakareem@amd.com>, <mastan.katragadda@amd.com>,
        <arungopal.kondaveeti@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Syed Saba Kareem" <Syed.SabaKareem@amd.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: amd: correct pm_runtime enable sequence
Date:   Wed, 14 Jun 2023 06:01:59 +0530
Message-ID: <20230614003206.933147-1-arungopal.kondaveeti@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT018:EE_|IA0PR12MB8839:EE_
X-MS-Office365-Filtering-Correlation-Id: d94dff17-cc43-40d2-e5f0-08db6c09a063
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Gbd8KEQr3lLZii1FYZyJEYdNYYL7fhZdzGdBQKR/DmJKWKecCB/TORqzgzFthy60rwiJOW3kS+CSAqKvi12mGP/zP06oF0MbYeBqvxPkRMuS8LZOXdVwbdFCEWkYHLDy3jjWNXAgQoOUIoHKYJzv4BJ9Q9ma30TsiAjCgeRbPJAEIWkvNjkz/W4siFsD59NzaJyZVeICbddX2DFt3GiwWJg1Nx+u3OQbf5rX3qTQdI4Ql5VGY1Id5jxZOOHVJSJqPw9IlAuikPEJG2MC7HVWMwppKMJeTrlrscp0EVwnn+g7d+2qDqr7KqmsVjegSjcsI8lBTXhWhWgklE8fP2Vv7ehFdxEDqjVlSoPlSmAPScCXzz5sH57t11fR7oNP9IfgLYFw4zPhDxELeia5vHLl4RVI+LTSgtFbVneLFC93X3b4Smp2KeyWPpfn57+sm34SbM/MDVQ/cx1PaaPq+IM7aJqdIUNVV75n0okXBRKXpLKACsSbX4xb5pzhPC/MRHtKoKIudcKBqIRB0xWXL7whUwqZgzHuS02//lI5kWHcXN2GvWghrXW7230SpBpIvfXwO7A5kBa3cyafz+1oU36vpqjPS2T1R/x0g7e+K48ZrTR+eSLY3TxH3e1d/6EaVdxIUa5nb9NRwhs+lHfSpOP8KuAXX453ZFnMgpQQakl5K+apgiYzhULDxw+lDBKaoWA634FJjNqsy5S2X5YglkJuWBJqPU8giCG2WVAwr7b6FwIAhWe4JUODYlPUzOku3RfZDcnwvAySX9ZLbkrfQex2w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(396003)(136003)(451199021)(46966006)(36840700001)(40470700004)(6666004)(7696005)(36756003)(36860700001)(186003)(82310400005)(2616005)(40480700001)(86362001)(426003)(83380400001)(47076005)(356005)(81166007)(82740400003)(26005)(1076003)(336012)(40460700003)(41300700001)(5660300002)(316002)(8676002)(2906002)(110136005)(54906003)(478600001)(8936002)(70586007)(70206006)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 12:28:00.3995
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d94dff17-cc43-40d2-e5f0-08db6c09a063
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8839
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

Replace pm_runtime_allow() with pm_runtime_mark_last_busy()
& pm_runtime_set_active() in pm_runtime enable sequence for
dma drivers.

Signed-off-by: Arun Gopal <arungopal.kondaveeti@amd.com>
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

