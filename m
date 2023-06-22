Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16BE73A4DD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 17:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbjFVP1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 11:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232448AbjFVP04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 11:26:56 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBF01FC0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 08:26:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bNP2QP5Ni+R04gUfBIZ/ME/Gg1p0hdux+QAscFzn4rPhpRPejY1XoQMhkBAR8+HfC8zbyWNKJkpyQXELxzIY9JklCAZrCk1wxlbe99rrleJTJZRU0tq4TotMhuQm5SPwTWK7JAnzvPq5AGYflxLjR9EE7qYFBGArPb66Wk7lio/n+iqYloirRyEhLw//vDEpHsktJYXa5CPnluhaMnYH2PXFBms6hNvhQYh96eN/H4kJnMld68KJBqs0wToiRezhtKtPkjlERmY+5UOEb2rstsiFG/wo7ti/3UqOWPfDDxUeI+FQminv0TuCSR+LDILYqIBGQg6x3YuoX3BZneTyUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y1gJUJChraGI/0cF68p/+kGmZoqkKWvMw/xcvMoaTYc=;
 b=GSJj0pAvu8KP+LFVJFDiCfrC0bCODaahDkW4D9KrlN3QtgrrinXQik7dJ4L4rAUdw81iPo7hUiqa6Dtg7lagctwcMdc+HgKJ1/kokmBAGzv/B4e/tKvQLTc+Qm8Xvulpl73dPRaXsuDeWEd2RqG9ftkrZg+H+J7pJp/a2wKO20jS0YTa+P9m4uGBsrdpC7/6ITl4aT2URFvALN9GXbY5Jcb0UBj6GJApKT1z0QyzsE3kWNGiIpEJfkdUC3/34KjExXD6AgA6la2y7YrIZBYsFHO+GYwEpNSiOgqhXjPRFb8z+iMDA4FxW8dLgk7FoeZgOy62V699riOId/IeqMsjvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y1gJUJChraGI/0cF68p/+kGmZoqkKWvMw/xcvMoaTYc=;
 b=5D8VVm2h4Bp+FbQHygieZtd/DEnUODNOxQbl1o7CtgEdSRu9c9c1F9QZGfGszssPhLHuc3OdloiooXbc9kUuMeJwcllwH2Lowa0gX/rCU6BJBYOH6zMc/Ci3nbIChhgGP9ZoTDnNPoACljLVCVOcN83ie0L+3/NNGVqsEvWEIsQ=
Received: from SA1P222CA0033.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::6)
 by DM4PR12MB7648.namprd12.prod.outlook.com (2603:10b6:8:104::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 15:26:29 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:2d0:cafe::f1) by SA1P222CA0033.outlook.office365.com
 (2603:10b6:806:2d0::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 15:26:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Thu, 22 Jun 2023 15:26:29 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 10:26:27 -0500
Received: from amd-B450M-DS3H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Thu, 22 Jun 2023 10:26:24 -0500
From:   Syed Saba Kareem <Syed.SabaKareem@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 07/11] ASoC: amd: acp: store xfer_resolution of the stream
Date:   Thu, 22 Jun 2023 20:53:51 +0530
Message-ID: <20230622152406.3709231-14-Syed.SabaKareem@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230622152406.3709231-1-Syed.SabaKareem@amd.com>
References: <20230622152406.3709231-1-Syed.SabaKareem@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|DM4PR12MB7648:EE_
X-MS-Office365-Filtering-Correlation-Id: 66355664-f616-494e-2040-08db73350d42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sjCB3Ll2q8XJjWgq0BeDcjq1LOU1Y/jp+ztjS/quar5R9bs/M4VnqNmKlqA2yvoL/0uKz//gQlYaxnQTgoI37SkBD8cMkY0JJXfLUJe11hi3KfYfcgLdXZbBO1XvAE6rnT7qEklQBiGYJwBDLXBYDZaY0P8J9ECIKeYTZ7CV0L/lFtIFRsoKboHYdRP3Yf12xKyE5FKnFbulqV6dd2Wx07iscWR43WFLslgSYErXfRql6YoAnTy5tPwp0OWvxTCPkQD3fXfr7Is8bHPZuBwDA8N9E3pJkabrvsHpDwKfgkf7beHL/eBP5qyvBiVw0JQ/7NW9QMnZrKR9gJ6a6je2854d2irPbfmRpoKXeFr63sTA8iBbbcEr8rHGKS5ZSxVtx1+dnVv4A6xA89YQXgRZsWdi/CpRTNlgn6ezbBEWFVs6jmfipP4mq6Qoa9ivJAuZY/DyDQ9K38VpJiIqxKaWOVbjCK7e2wYXOd7ZwAKouAfuB/WN4zhV2eabluI6J43yu6jRpq9SXWEJ2qZnlk2MSfl17vYuMG0rnEyAtZAAA4fqOfozo50YkZaeLaMwHbU/sMgVXzRxLbAVGxDob3kIja/+lVVAguE/JbpCsUpjLe43gkbjAHrBfuiX6qb+mC5LfSqik7knHVrTtkeys1C3Q/ru4P/vb3n5Ga21AKnvRiMw2dvDAP86I37//4IycpaVINfD1PY93D//hcd810vAi/xvgmlJ3aNyNCo4m7yg2edxescziMhMHpucDL2j7HsmXnvxnUWx+KB4MqN/Aywmkg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(396003)(451199021)(46966006)(40470700004)(36840700001)(82310400005)(40480700001)(40460700003)(86362001)(41300700001)(8676002)(8936002)(336012)(70586007)(70206006)(2616005)(316002)(426003)(5660300002)(7696005)(1076003)(47076005)(478600001)(6666004)(4326008)(186003)(26005)(54906003)(110136005)(82740400003)(356005)(81166007)(36860700001)(2906002)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 15:26:29.5330
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66355664-f616-494e-2040-08db73350d42
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7648
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Store the 'xfer_resolution' of the stream in private data structure,
it will be used to reprogram the xfer_resolution for the active stream
during system level resume.

Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
---
 sound/soc/amd/acp/acp-i2s.c | 2 ++
 sound/soc/amd/acp/amd.h     | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/sound/soc/amd/acp/acp-i2s.c b/sound/soc/amd/acp/acp-i2s.c
index 09b6511c0a26..09dc5f2c0bfc 100644
--- a/sound/soc/amd/acp/acp-i2s.c
+++ b/sound/soc/amd/acp/acp-i2s.c
@@ -149,6 +149,7 @@ static int acp_i2s_hwparams(struct snd_pcm_substream *substream, struct snd_pcm_
 			dev_err(dev, "Invalid dai id %x\n", dai->driver->id);
 			return -EINVAL;
 		}
+		adata->xfer_tx_resolution[dai->driver->id - 1] = xfer_resolution;
 	} else {
 		switch (dai->driver->id) {
 		case I2S_BT_INSTANCE:
@@ -167,6 +168,7 @@ static int acp_i2s_hwparams(struct snd_pcm_substream *substream, struct snd_pcm_
 			dev_err(dev, "Invalid dai id %x\n", dai->driver->id);
 			return -EINVAL;
 		}
+		adata->xfer_rx_resolution[dai->driver->id - 1] = xfer_resolution;
 	}
 
 	val = readl(adata->acp_base + reg_val);
diff --git a/sound/soc/amd/acp/amd.h b/sound/soc/amd/acp/amd.h
index f53613216397..38c152c6c8c6 100644
--- a/sound/soc/amd/acp/amd.h
+++ b/sound/soc/amd/acp/amd.h
@@ -166,6 +166,8 @@ struct acp_dev_data {
 	struct acp_resource *rsrc;
 	u32 tdm_tx_fmt[3];
 	u32 tdm_rx_fmt[3];
+	u32 xfer_tx_resolution[3];
+	u32 xfer_rx_resolution[3];
 };
 
 union acp_i2stdm_mstrclkgen {
-- 
2.25.1

