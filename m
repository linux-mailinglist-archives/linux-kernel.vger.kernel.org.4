Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C907B635CA5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 13:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236967AbiKWMU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 07:20:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237335AbiKWMUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 07:20:14 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E7642986
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 04:20:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hidWO7I+7uLxpQcqD+tn76ZA0Cl+FyH1HF0X6KP8XnjqroOrzfL7MEJnhuxxGagqrEC0oi93Wcj9d9J92El4+yJXhmJzP4jeZJEJs6DIvA3TVTGOFAgGzzj32K2H5Cr6oe/Yr6YWpWfgZlPg79x8rXBUengUc+2kkMRKlkhfBQ4Gv/vJOOH4lj3smIacEICzLbUlxgmYwswpmu2GiKZnANjEan6YF03DH+eTmCfzaxvPNY42E7NH4/71Wn+ir/ouAMleneb0ghqy3dA4HSst6FIoiVc9FL1bOqk9sRh2PCmbKCej2wC2EpXsmBFpxKytpj3V4jfGkjZeAbK2DTLNQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3F14VLhuDVixjvfMyP0ErSYyjBZwE6u7UJtM0w2B+1w=;
 b=GC7JKVMrA8WIJ6Hn7LrwSWHtYVnqeCw70AaIijbwnkGVFcmC9V6xhb4EDQne7o+vCo717M8KZIYSLw11MdWItHDgLterpwkHjpxX/7efxA6pQUBNIKS84X1TeAjm9UWFX0tYyvf4TyGqbRJiMr+LUbDORvdCU/8p7tJ030VVIRWeeSCAvVwu99ZyUC4eOdd+wkxPd7Rxu+fF3N5SoGqbIjEJmvBVAkdcnX2YTmnPHlm0b+ajM26BO9gqrFxLlopDkgar7Ck2F2H2Q3YK3uTNXBbscZ/7ScpTiBKnYF5aIrON14XCllgX0wi03KMStqwvtTl9I1nWTQKFaGUP13ADaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=amd.corp-partner.google.com; dmarc=fail (p=reject sp=reject
 pct=100) action=oreject header.from=amd.corp-partner.google.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3F14VLhuDVixjvfMyP0ErSYyjBZwE6u7UJtM0w2B+1w=;
 b=wH7uXdU9pfrPydbOzmmOdF7iXM01q0lo2dYAFG24TGEnFtQl+mYvBs9iq/tohEZpl6C2p4hpnJeXMEH+uD9bbztnsHz39F20aNSAuQRPg5ELpWRO7qrNSVVkaCLKd3S73p813Df+X2d9obtqnyVyZSVwphXmxkd15YGV+HaNLlHJ8t1dzokpCUX59elnQcnnyro/CLuJnEw42KiM2OOCeALxr+DLVXNXdJMM8mpTx0oWCcPM/CtWEzwI7sUG5L0H4ybC++uy9BihS5hd39PlhYFCMlEUZv/uCWbcQiPIGHjEqlScGX/G0LobI0KOo86GkZBBD8BGgx3OzV5L1x0/Bg==
Received: from MW4PR03CA0099.namprd03.prod.outlook.com (2603:10b6:303:b7::14)
 by PH8PR12MB6699.namprd12.prod.outlook.com (2603:10b6:510:1ce::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 12:20:04 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::44) by MW4PR03CA0099.outlook.office365.com
 (2603:10b6:303:b7::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15 via Frontend
 Transport; Wed, 23 Nov 2022 12:20:04 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.corp-partner.google.com; dkim=none (message
 not signed) header.d=none;dmarc=fail action=oreject
 header.from=amd.corp-partner.google.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.corp-partner.google.com discourages use of 165.204.84.17 as permitted
 sender)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT046.mail.protection.outlook.com (10.13.174.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Wed, 23 Nov 2022 12:20:04 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 23 Nov
 2022 06:19:26 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 23 Nov
 2022 04:19:18 -0800
Received: from sof-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Wed, 23 Nov 2022 06:19:13 -0600
From:   V sujith kumar Reddy 
        <vsujithkumar.reddy@amd.corp-partner.google.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <venkataprasad.potturu@amd.com>,
        <ssabakar@amd.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        "Bard Liao" <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Ajit Kumar Pandey" <AjitKumar.Pandey@amd.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" 
        <sound-open-firmware@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 2/4] ASoC: SOF: amd: Fix for selecting clock source as external clock.
Date:   Wed, 23 Nov 2022 17:49:09 +0530
Message-ID: <20221123121911.3446224-3-vsujithkumar.reddy@amd.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221123121911.3446224-1-vsujithkumar.reddy@amd.corp-partner.google.com>
References: <20221123121911.3446224-1-vsujithkumar.reddy@amd.corp-partner.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT046:EE_|PH8PR12MB6699:EE_
X-MS-Office365-Filtering-Correlation-Id: bbf4d7c6-3ea3-4669-1396-08dacd4d0d6f
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +IgWo2Eh114flyr0P75go0UapKlRfYmYYGRshZOINH5rF3vmNv8SUek5HLcUeLc7FyKZZ2gk1IFmOT8UgOnuLqAG0uYc7vVx95dVMYeYksEKDsQCsnXU+UtiH4lgxEvAZ5AXTUr10zm75VJ3U/hyOMc6eNMpHLvk7lB41Fb6MWV0Pd9l9Ah+EjBrrS28Fau/wNrjQJk51L7ks83G95oLzhEOrX/f3xrlHU8h7K8cln/nb2GXF7cci5XSSZcUJw7dNDv8BhkHQLQDa1mQjaRKnCU3Mh46aF0TfoaEVIm4t0un6+yrHQYCwV0/qodp6bdEL33uDA70rh4bn2wLXNNISFFxZmZf/afrzF7vAaXPZ56R2qEeILJtItdRHmh/eQWvY/6yg4gvrTFljwdOmn6SZo9YX6EYkIQSv0vZ9vkplmQEF9x4qVdcDNDrqVAeNo85wEG+a1So4P6AKzCBKEb1rHxghoxryhUtCBEk4lMkDjwnSv1OGlRrO2ZUTpLVhp3IWQFBw+PSRCvh5seGB4xuXP/lKY4iOifyya7KapZn7qJ1E8OXNeqqEEYGJ2wWpxp8zbFxzs+ElROocyq444lSNE62sTrFGdxybADi+qU/JLy4DlMcjKuGYlGyMIUS/VgJejXhVdLZbH2CbQNkKMmxIIHaTt8EF8g2mCzOSFYBcBKIoPkDDfJqBs5EtBKEn6WXargFOK/hWbkThD+GdK4DNQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(396003)(346002)(84050400002)(451199015)(46966006)(40470700004)(82740400003)(26005)(8936002)(81166007)(2616005)(47076005)(1076003)(35950700001)(336012)(5660300002)(86362001)(82310400005)(356005)(316002)(498600001)(76482006)(110136005)(40460700003)(40480700001)(4326008)(6666004)(54906003)(70206006)(70586007)(8676002)(41300700001)(7416002)(2906002)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amdcloud.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 12:20:04.6187
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbf4d7c6-3ea3-4669-1396-08dacd4d0d6f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6699
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>

By default clock source is selected as internal clock of 96Mhz
which is not configurable. Now we select the clock source to
external clock (ACLK) which can be configurable to different clock
ranges depending on usecase.

Signed-off-by: V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>
---
 sound/soc/sof/amd/acp.c | 4 +++-
 sound/soc/sof/amd/acp.h | 8 ++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
index 36966643e36a..47115a77c92c 100644
--- a/sound/soc/sof/amd/acp.c
+++ b/sound/soc/sof/amd/acp.c
@@ -390,6 +390,7 @@ static int acp_power_on(struct snd_sof_dev *sdev)
 
 static int acp_reset(struct snd_sof_dev *sdev)
 {
+	const struct sof_amd_acp_desc *desc = get_chip_info(sdev->pdata);
 	unsigned int val;
 	int ret;
 
@@ -410,6 +411,7 @@ static int acp_reset(struct snd_sof_dev *sdev)
 	if (ret < 0)
 		dev_err(sdev->dev, "timeout in releasing reset\n");
 
+	snd_sof_dsp_write(sdev, ACP_DSP_BAR, desc->acp_clkmux_sel, ACP_CLOCK_ACLK);
 	return ret;
 }
 
@@ -456,7 +458,7 @@ int amd_sof_acp_resume(struct snd_sof_dev *sdev)
 		return ret;
 	}
 
-	snd_sof_dsp_write(sdev, ACP_DSP_BAR, desc->acp_clkmux_sel, 0x03);
+	snd_sof_dsp_write(sdev, ACP_DSP_BAR, desc->acp_clkmux_sel, ACP_CLOCK_ACLK);
 
 	ret = acp_memory_init(sdev);
 
diff --git a/sound/soc/sof/amd/acp.h b/sound/soc/sof/amd/acp.h
index 1529c6d9bf9b..76ad963faec1 100644
--- a/sound/soc/sof/amd/acp.h
+++ b/sound/soc/sof/amd/acp.h
@@ -69,6 +69,14 @@
 #define BOX_SIZE_512				0x200
 #define BOX_SIZE_1024				0x400
 
+enum clock_source {
+	ACP_CLOCK_96M = 0,
+	ACP_CLOCK_48M,
+	ACP_CLOCK_24M,
+	ACP_CLOCK_ACLK,
+	ACP_CLOCK_MCLK,
+};
+
 struct  acp_atu_grp_pte {
 	u32 low;
 	u32 high;
-- 
2.25.1

