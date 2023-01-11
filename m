Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC726656EA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 10:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238399AbjAKJHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 04:07:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237435AbjAKJGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 04:06:22 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A68175B6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 01:04:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GDOb2tx/JML9zMGoBP9KrBdDS2JotQqFmXaVZXQ1CciJ0ivVLWozMmNLwPsR+hacTogZ5NzeN06tUAaXl4WnYbDO8hSqJV9RkN/6tRmwOmfz6UbPNL7pjXwV7nXOtuJddL7sE6zYqqUbrl3h3BriP55BXBAgOf5uAJFuye0LU4vSZgSi+kb8cKUQU+bRh6b0n3V/zioJ2O8cOsrsI3W3P2j3ZbDmh/lrkpf1ZkgiqRUaUTpyD6yy2aZCSZxZTo8vAky7kPRdvTcYRyk4tu/YnwoP6CQr0ga+FYL2ag8wbBU4B/c9RoQM8XWvam3CCUEa/sfYDzswXZVFDq6OyqBVpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3a/H2doGWR7YV4MJgHmCrzGZ5Y+VdyOdV7Lcegcl8GY=;
 b=O6JAavymS+KQ+Np+OLLEYgAZwu9MwRaxl9D13fc9/mSbTj/NbK98OQ1YS4RLinJrtAKP87BUol7oOOFb6j20xeIFpGtq41hc/KYi5UCc9+TM9RUQgsvgRE+yRtZI42VA9voDhEweYchGiSs93hFCiJwkwTh6uUjn7BWAHdu4OzwOEvm5Zhozv8XohrpTAXwCN+xOl6Y4QY5hSv56toTd+pS0IkS0yonJ6vCIf1pWzY/eti4nNRrBsdHNjxxF5rkd9b5XY2m8cT7dXuCAspINcHmTqJ28wIMs3bg1A1M4pXiO8MZPTR8hOH75GBwVtQ4tRFFcDA8r07483/1RfPUopQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3a/H2doGWR7YV4MJgHmCrzGZ5Y+VdyOdV7Lcegcl8GY=;
 b=cEFzNw5bue7U4rInIgIiHB9J/2sgu14Cz8DZaiq0CMJnSodnnUji9K4j4Su/ph/LMFo+S29TFrVnd/M10/NRk+sF++wHLOkHPPEKXVq/Gz++FcxVZh68C82w28wf2ezgy92TqNZLLmKZ16zYLtcVyUboTAGnxcrhTytU6xiJCy8=
Received: from BN0PR04CA0147.namprd04.prod.outlook.com (2603:10b6:408:ed::32)
 by PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Wed, 11 Jan
 2023 09:03:54 +0000
Received: from BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ed:cafe::85) by BN0PR04CA0147.outlook.office365.com
 (2603:10b6:408:ed::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13 via Frontend
 Transport; Wed, 11 Jan 2023 09:03:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT009.mail.protection.outlook.com (10.13.176.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Wed, 11 Jan 2023 09:03:53 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 11 Jan
 2023 03:03:42 -0600
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Wed, 11 Jan 2023 03:03:38 -0600
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <broonie@kernel.org>, <vkoul@kernel.org>,
        <alsa-devel@alsa-project.org>
CC:     <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <Mario.Limonciello@amd.com>, <Mastan.Katragadda@amd.com>,
        <arungopal.kondaveeti@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 18/19] ASoC: amd: ps: implement system level pm ops for soundwire dma driver
Date:   Wed, 11 Jan 2023 14:32:21 +0530
Message-ID: <20230111090222.2016499-19-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
References: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT009:EE_|PH7PR12MB6588:EE_
X-MS-Office365-Filtering-Correlation-Id: 016dcf06-5dbe-4d7b-13ff-08daf3b2c3a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pbU6WG6wweBu60sRAU4Cxw1O8qnCNuQ4ACZv413GZn62tX0n6m7zvhcfaohe2B4fbzmZ+MpDDf8cxH3Xfo0jaC5KTP8+S1r+ime0X1AwHXurAMYZWKE1HhQTk84az5eocKYU/jCSoOWpdLjNeXClVYmS/6CXeNJ7wj5Bwq3+D8OyIAisre30ZlWulzOT2mULVt4rZ9TwxMmxdnY1GLOI6TALPD46Hi7x7kiwRogYI9wW8NESbvZRYsRVSQ5JeGTz932fatz/wMGqCAwZ0ybhng5SG/ndz6hNYRvxqNLEluOoPLtYkZ9TkerQrWZhZt3YIUTnS3hAXYr49tPheVcgIls/OMOUnoORVzrW0nWZjoLweDWK5Epl0S7t6avM++JGCn67dGlzpPvkb4gV07oofSNBXZGZDh+iS1MIWAZmpFXFtyoLr/+y2M0gQ3pdoJ2Eczrd9MhOG89O0AdJ2os5FzNbm9ad8z3HhBW3nQ8eIDMK++sD9a39TdSXiIN1s5pS6BfgiLsORtWreUeYjyIWB6EeX23rMaL3vw54dhXmsnT24ipnOYBK0jy1cTtRo1SNiNGBPj1LXy31Qn/DJyjbb4+fHMkJKKcGQFVyWi5/qe+L4Dj4Ey5eGaJQDi+h0+cu2xHx6snNz5UH/hO1fqdOwUI/YmtklZUh1+lPiNQsc4DKRepJH1ZsW51Jn04JSQlwbPYRv5jBckV9suvXMhFli5m+caMpn4vsl1BY/4/F9Kw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(376002)(39860400002)(346002)(451199015)(40470700004)(36840700001)(46966006)(356005)(70206006)(4326008)(8676002)(82310400005)(70586007)(83380400001)(7696005)(86362001)(41300700001)(8936002)(36756003)(81166007)(186003)(26005)(6666004)(316002)(478600001)(110136005)(40480700001)(82740400003)(426003)(40460700003)(54906003)(1076003)(47076005)(5660300002)(2616005)(336012)(36860700001)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 09:03:53.7407
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 016dcf06-5dbe-4d7b-13ff-08daf3b2c3a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6588
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for system level pm ops for soundwire dma driver for
pink sardine platform.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/ps/ps-sdw-dma.c | 59 +++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/sound/soc/amd/ps/ps-sdw-dma.c b/sound/soc/amd/ps/ps-sdw-dma.c
index 960c0bc5e848..ba2eea23d41e 100644
--- a/sound/soc/amd/ps/ps-sdw-dma.c
+++ b/sound/soc/amd/ps/ps-sdw-dma.c
@@ -623,6 +623,64 @@ static int acp63_sdw_platform_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int __maybe_unused acp63_sdw_pcm_resume(struct device *dev)
+{
+	struct sdw_dma_dev_data *sdw_dma_data;
+	struct sdw_stream_instance *sdw_ins;
+	struct snd_pcm_runtime *runtime;
+	u32 period_bytes, buf_size, water_mark_size_reg;
+	int ret;
+	int index;
+
+	sdw_dma_data = dev_get_drvdata(dev);
+	for (index = 0; index < ACP63_SDW_MAX_STREAMS; index++) {
+		if (sdw_dma_data->sdw_stream[index] &&
+		    sdw_dma_data->sdw_stream[index]->runtime) {
+			switch (index) {
+			case ACP_SDW_AUDIO_TX:
+				water_mark_size_reg = ACP_AUDIO_TX_INTR_WATERMARK_SIZE;
+				break;
+			case ACP_SDW_BT_TX:
+				water_mark_size_reg = ACP_BT_TX_INTR_WATERMARK_SIZE;
+				break;
+			case ACP_SDW_HS_TX:
+				water_mark_size_reg = ACP_HS_TX_INTR_WATERMARK_SIZE;
+				break;
+			case ACP_SDW1_BT_TX:
+				water_mark_size_reg = ACP_P1_BT_TX_INTR_WATERMARK_SIZE;
+				break;
+			case ACP_SDW_AUDIO_RX:
+				water_mark_size_reg = ACP_AUDIO_RX_INTR_WATERMARK_SIZE;
+				break;
+			case ACP_SDW_BT_RX:
+				water_mark_size_reg = ACP_BT_RX_INTR_WATERMARK_SIZE;
+				break;
+			case ACP_SDW_HS_RX:
+				water_mark_size_reg = ACP_HS_RX_INTR_WATERMARK_SIZE;
+				break;
+			case ACP_SDW1_BT_RX:
+				water_mark_size_reg = ACP_P1_BT_RX_INTR_WATERMARK_SIZE;
+				break;
+			default:
+				dev_err(dev, "%s: Invalid channel type\n", __func__);
+				return -EINVAL;
+			}
+			runtime = sdw_dma_data->sdw_stream[index]->runtime;
+			sdw_ins = runtime->private_data;
+			period_bytes = frames_to_bytes(runtime, runtime->period_size);
+			buf_size = frames_to_bytes(runtime, runtime->buffer_size);
+			acp63_config_dma(sdw_ins, index);
+			ret = acp63_configure_sdw_ringbuffer(sdw_dma_data->acp_base, index,
+							     buf_size);
+			if (ret)
+				return ret;
+			acp63_writel(period_bytes, sdw_dma_data->acp_base + water_mark_size_reg);
+		}
+	}
+	acp63_enable_disable_sdw_dma_interrupts(sdw_dma_data->acp_base, true);
+	return 0;
+}
+
 static int __maybe_unused acp63_sdw_pcm_runtime_suspend(struct device *dev)
 {
 	struct sdw_dma_dev_data *sdw_dma_data;
@@ -650,6 +708,7 @@ static int __maybe_unused acp63_sdw_pcm_runtime_resume(struct device *dev)
 static const struct dev_pm_ops acp63_pm_ops = {
 	SET_RUNTIME_PM_OPS(acp63_sdw_pcm_runtime_suspend,
 			   acp63_sdw_pcm_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(acp63_sdw_pcm_runtime_suspend, acp63_sdw_pcm_resume)
 };
 
 static struct platform_driver acp63_sdw_dma_driver = {
-- 
2.34.1

