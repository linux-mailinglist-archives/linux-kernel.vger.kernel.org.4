Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2ED06656E5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 10:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238357AbjAKJF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 04:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238407AbjAKJFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 04:05:00 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9099F13E2C
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 01:03:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H5/cZcNxsCV1Npk+Fp0eUwuBXcwAk7UFtACw15ScmaTqFko1T4a2OFUZ0qExK5/XJ5MTU4m+5uV6fRzb6lEIrcdX4/HzaWn7EYAEpdYaMioGyR6D9V2NPq5kzzyNmL5uXaonY7oCHXxBIWFc1jE/sylnpesY2FQU24P3SJmIbDp9z5w2XlBGww77xu5Kc1l8kUKkPyvHjC5h9GHfnEDr6asV7840nlJWnDD5AxWVXLDJf3Ut+4GP1W92RZqjNtwXS2oDjCi7Z8S3r+KTC5A7GaKF2SlsYrIusdGelm4G3NYqSHsSjxLoYY175hdyz9gFOzOLrsJzl5K3zDIcCyQ+jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dKbs/gWVIUwuuZ9ieSx4rMt6gTr0u2uz5VezFzMnLeg=;
 b=Zbd8cqOD+6AvY2zfPS7Eg1ISl+HTVUdJpepDUkBs2mzDyTXfjQuzd+00Xt+PQVftWSeDBHf5Uq7x9vJvd5+ue4EeMhMB409B0Y7wropUQewUr55YTXmAxJSVW3LkQnxChn+sVSFSBy2WBDM9V4WHYzWcf983jQMVczF6K0AEdWRMIcUNHG4mUQ0W+eB2qP+YCDI2TXCv6pUGk4txSbIy6cgU0ZvedTsNbL4qgsBMLBYUs7Y82rVd2j5HUGm9ht7t8AHBqoW6xlqbtKW8Ulu3V79Cmxj+RxxqJpHeOGALEmyXVuC4J7M5ovCHFnX6V6aC+B3Hqvmzc4GH0uHRhe+uVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKbs/gWVIUwuuZ9ieSx4rMt6gTr0u2uz5VezFzMnLeg=;
 b=U9cDBh+lZ64mg2WsRjLzECpa6tmwGXZtq0CamM/1z52ah/sugyfRteO9Nm72LblkeOCMKU/DJsTdkz7VsxgM9GyQ2RbsVXqOAKPc2TQNfGpKNuUeE1wtL0kagUvcQRvhf9rjHKF0Pc4MLdbabXs1WKR2/bwLKxYudC22DqqKlzs=
Received: from DM6PR05CA0066.namprd05.prod.outlook.com (2603:10b6:5:335::35)
 by PH7PR12MB7428.namprd12.prod.outlook.com (2603:10b6:510:203::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Wed, 11 Jan
 2023 09:02:57 +0000
Received: from DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:335:cafe::90) by DM6PR05CA0066.outlook.office365.com
 (2603:10b6:5:335::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13 via Frontend
 Transport; Wed, 11 Jan 2023 09:02:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT019.mail.protection.outlook.com (10.13.172.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.18 via Frontend Transport; Wed, 11 Jan 2023 09:02:57 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 11 Jan
 2023 03:02:47 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 11 Jan
 2023 01:02:13 -0800
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Wed, 11 Jan 2023 03:02:09 -0600
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <broonie@kernel.org>, <vkoul@kernel.org>,
        <alsa-devel@alsa-project.org>
CC:     <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <Mario.Limonciello@amd.com>, <Mastan.Katragadda@amd.com>,
        <arungopal.kondaveeti@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 15/19] soundwire: amd: add startup and shutdown dai ops
Date:   Wed, 11 Jan 2023 14:32:18 +0530
Message-ID: <20230111090222.2016499-16-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
References: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT019:EE_|PH7PR12MB7428:EE_
X-MS-Office365-Filtering-Correlation-Id: e6102fc3-808d-456d-edfa-08daf3b2a1e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xdzpWCLLywxzPEA4gIrFOhRc5vpaheQOuxSAVA4cmQGxmNqeiixZHxJOHpd4MNmlTe5WYWtd5puwL4iqKX2MRnqUdp4kZCpfB6Loacmo70IKvgooOv5WepAjhsIsGLYvVAEr/qcWvRvkFeUYuqDPyBjnpK2fLQrACcohWH9fnIMJaw9F+GoAB5JBMFqC97do03yuXkztqq0SfahxnPEMDVBxFQz1lVmoOwiy948DQk1znGladk8+cdkGrgjVYx9lG2Up33/f/+pgWNA0jCz5o81YIFIRs9C/I5LCgHllKuqhxqcrV9KuLLD6Qp2xk32SpH4EEWRX4bDKqwDHONrRFjLLNuQwL0w2g37w634C2qzbVgk3Ffq/krv1S1u/wVYrifkMHpZkpTEiIZePgx6otgi1+LtP+Jcci2wsEj7VhWMlSP1D1L6q6lQRM7jrhUgqYPm9Zo9rUFaT5UvDLGHaSh03dQ0fHWwhaIL47JBiRqpxhGVdkmcNu+GFn0QvTJAIqSV2KYT/OXdvF4qOW56YNl3cDc3khnkssvdI/dDdoY0vTPm/fqvhgPUNMNp7VsyWrLov0rN/ltzGLX4R/m+CVg1JzKeQHiKrl63t/TsjPCQrgtFGhtnl9ssfwkJ9f7jGlASb3YmcbWlfNkb00EoF8tqUJyWi06IqI9OncsfddGIL3LCwg/lev5h6vbhvYNoxtVHJDsBIVojuLP73Yn+U4z/n2LfIHWuXGvtHCNTdCfk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(39860400002)(396003)(346002)(451199015)(46966006)(40470700004)(36840700001)(2906002)(7696005)(26005)(478600001)(6666004)(186003)(8676002)(83380400001)(110136005)(2616005)(1076003)(70586007)(36756003)(316002)(54906003)(336012)(40460700003)(70206006)(426003)(4326008)(41300700001)(47076005)(40480700001)(5660300002)(82740400003)(36860700001)(82310400005)(86362001)(81166007)(8936002)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 09:02:57.0984
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6102fc3-808d-456d-edfa-08daf3b2a1e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7428
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add start up and shutdown dai ops for AMD Master driver.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 drivers/soundwire/amd_master.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/soundwire/amd_master.c b/drivers/soundwire/amd_master.c
index d2d7f07de202..290c59ab7760 100644
--- a/drivers/soundwire/amd_master.c
+++ b/drivers/soundwire/amd_master.c
@@ -1117,6 +1117,15 @@ static int amd_set_sdw_stream(struct snd_soc_dai *dai, void *stream, int directi
 	return 0;
 }
 
+static void amd_sdwc_shutdown(struct snd_pcm_substream *substream,
+			      struct snd_soc_dai *dai)
+{
+	struct amd_sdwc_ctrl *ctrl = snd_soc_dai_get_drvdata(dai);
+
+	pm_runtime_mark_last_busy(ctrl->dev);
+	pm_runtime_put_autosuspend(ctrl->dev);
+}
+
 static int amd_pcm_set_sdw_stream(struct snd_soc_dai *dai, void *stream, int direction)
 {
 	return amd_set_sdw_stream(dai, stream, direction);
@@ -1137,9 +1146,27 @@ static void *amd_get_sdw_stream(struct snd_soc_dai *dai, int direction)
 	return dma->stream;
 }
 
+static int amd_sdwc_startup(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
+{
+	struct amd_sdwc_ctrl *ctrl = snd_soc_dai_get_drvdata(dai);
+	int ret;
+
+	ret = pm_runtime_get_sync(ctrl->dev);
+	if (ret < 0 && ret != -EACCES) {
+		dev_err_ratelimited(ctrl->dev,
+				    "pm_runtime_get_sync failed in %s, ret %d\n",
+				     __func__, ret);
+		pm_runtime_put_noidle(ctrl->dev);
+		return ret;
+	}
+	return 0;
+}
+
 static const struct snd_soc_dai_ops amd_sdwc_dai_ops = {
 	.hw_params = amd_sdwc_hw_params,
 	.hw_free = amd_sdwc_hw_free,
+	.startup = amd_sdwc_startup,
+	.shutdown = amd_sdwc_shutdown,
 	.set_stream = amd_pcm_set_sdw_stream,
 	.get_stream = amd_get_sdw_stream,
 };
-- 
2.34.1

