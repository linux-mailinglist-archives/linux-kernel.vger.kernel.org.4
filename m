Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8A673A4B9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 17:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbjFVPYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 11:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjFVPYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 11:24:15 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F34107
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 08:24:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MFvYkHFPDGgpVEJuk/yk/1eU46jpMt96Zc7uJP9XboQva0ybHRFzMSAlqcpqlAZyQeqWjw6YDF4Jw6jLDdK98nLX3LAxrsAxZldE1vrcxazThwcCaMjbjrY5FR+TsqB5h4L7M/43z0u21dHkxaCBIBX7TBg1AfJflso2hNpT0mOWF80JDPmxzdwtOwN3ERaTrhUClqZa6kZY7B6CwsoAX8etD6+vPcwkSgQmfi2/eK691dlXulZmiq7O+OvgR5aGF8vFF34Enn00qLeNPo3zb8rKOQbqrUZ+uRcjtx8W+NEqZ/mxksgHjXRE3WqlUzhONATZImnWP0YVeG5cXet9mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OChOH1lOIt4lZ7d/UGBrsMN0ddSaaJx0luKEOqEgkYA=;
 b=AWWoCQ2h3iP6TNn/jGWKN2lUZC0+WIdqGW8wOYC30jwuD+luJ+Jr+cpSY1FA1nJeBPaxVapHE+h8WsAZWAQbGg09V0gKp/EbnhBagcWaPEGLuaKL6qK8z1oUa6yLAUrozjfkb0K6aRE2gDSjlyVCYXVe2aj3CuOOgfyi6HF3Z4BLskkmN6YKfw4OfG30ZVNklgmnBTpjfYvqTJ+vzPoV51XHHzfU63jIJaXSoTK6San6VrU9NT0G9g0n6vGaf/6kHes0ftAfUDFloTHL3zi6kSLJQKzMi1AaU4bxiWIPFtVIoV+sAPJDpQojda7RujafZGdrBm/ViQnG6vAhlIIoXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OChOH1lOIt4lZ7d/UGBrsMN0ddSaaJx0luKEOqEgkYA=;
 b=sd3okW54zybcuUfIHD3f2dWRBU/1V0XLHQ2NCwmzIq9Nm78BRCN8zEvEwIzIttT/ylC03tLVd47AsPRomeTEhK1qNLBZ4PHwRBf3Llrcfl9pJtrDRd3rWjfkgfibz8mZZCmU/ZMP0WX5mlScIQiAOLIepzFPmEKmhcZD63E2Uoc=
Received: from CH2PR08CA0010.namprd08.prod.outlook.com (2603:10b6:610:5a::20)
 by CH3PR12MB7497.namprd12.prod.outlook.com (2603:10b6:610:153::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 15:24:12 +0000
Received: from CO1PEPF000042AB.namprd03.prod.outlook.com
 (2603:10b6:610:5a:cafe::2f) by CH2PR08CA0010.outlook.office365.com
 (2603:10b6:610:5a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 15:24:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AB.mail.protection.outlook.com (10.167.243.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Thu, 22 Jun 2023 15:24:11 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 10:24:10 -0500
Received: from amd-B450M-DS3H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Thu, 22 Jun 2023 10:24:07 -0500
From:   Syed Saba Kareem <Syed.SabaKareem@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 01/12] ASoC: amd: acp: clear pdm dma interrupt mask
Date:   Thu, 22 Jun 2023 20:53:38 +0530
Message-ID: <20230622152406.3709231-1-Syed.SabaKareem@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AB:EE_|CH3PR12MB7497:EE_
X-MS-Office365-Filtering-Correlation-Id: 67389ea2-300f-4482-7818-08db7334bb31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O2VqgR/tCMomwCkxn3ZDnQtSK6PyUdL/6IpDP8EX4YGd4UUxuCwwtc+WCPDBZR247GyBG5ry3pB2CY9HGeE80N5XSVOU516liDmQ4ibsoF/DGUpzYb9Cd6Kccxm8yuHOmAgyRiD7l/DpSdXEqa8ARRH1orBjxWPhRsOInd4YFZ20/Y4UK+vul2mgIp2POH8HzC3ncZ3ZmMcut4po2A/N0aU9xeAGEPnwZWW9PISbVMR2xIYUaJ6Txs91xsoKJVK18IFA0A5mK/A4+6934mcoUPMcjcY76eVIpg1XxWvjjryTdCXVAC8LJDTFLao9m4Sj8u7c2XelBeXHYOoKNkvc+Ne4uJoQa5j0/9y7WPlxQI4VbgfiXvmpDssg52V0S7kiPXCb9rJD/rddGno0CO1Ts2CWh/HKVJqf+b6SDVPW/lAtvJWhzMUzPHaYOh4mstulHUQhlZlLYnDty/AqGZTBZM1xyynTef2mGfsVHMEvyU8pgXFvzsEuivRvWXM8c2nmcl+pq5Q+dAaqvuhhgagfG9qO+2+CQBiy48mw2cWXRSKfnrp+4TsGDYAtxD+nUdABZdQlxz6QYlmZ1BSsL0J2yRbidjyldDqZv6pXjIJO1HfArX0s03ok+D6G0bwlJVrYt+xDtbqQkrD53Vvd+J4axBodXLmtlwAiVrho2xswFAMkS1h6EBOkRh60q4OY0BCEygnQcTE5n/R+L25hK1C/LVbtDmah5cH0m7M9Uu21prrkWs2Ff2YQRYiHYOq9dH7M1E1VstEmvY/K+JcGGanYrQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(136003)(451199021)(46966006)(40470700004)(36840700001)(2616005)(47076005)(426003)(336012)(36860700001)(83380400001)(26005)(186003)(1076003)(356005)(82740400003)(81166007)(478600001)(54906003)(110136005)(36756003)(86362001)(6666004)(70586007)(70206006)(40480700001)(8936002)(8676002)(4326008)(316002)(4744005)(2906002)(7696005)(41300700001)(5660300002)(40460700003)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 15:24:11.7725
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67389ea2-300f-4482-7818-08db7334bb31
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7497
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clear pdm dma interrupt mask in acp_dmic_shutdown().

'Fixes: c32bd332ce5c9 ("ASoC: amd: acp: Add generic support for
PDM controller on ACP")'

Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
---
 sound/soc/amd/acp/acp-pdm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp/acp-pdm.c b/sound/soc/amd/acp/acp-pdm.c
index 66ec6b6a5972..f8030b79ac17 100644
--- a/sound/soc/amd/acp/acp-pdm.c
+++ b/sound/soc/amd/acp/acp-pdm.c
@@ -176,7 +176,7 @@ static void acp_dmic_dai_shutdown(struct snd_pcm_substream *substream,
 
 	/* Disable DMIC interrupts */
 	ext_int_ctrl = readl(ACP_EXTERNAL_INTR_CNTL(adata, 0));
-	ext_int_ctrl |= ~PDM_DMA_INTR_MASK;
+	ext_int_ctrl &= ~PDM_DMA_INTR_MASK;
 	writel(ext_int_ctrl, ACP_EXTERNAL_INTR_CNTL(adata, 0));
 }
 
-- 
2.25.1

