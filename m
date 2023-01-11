Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F506656A8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 10:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235850AbjAKJAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 04:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbjAKJAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 04:00:10 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29E51182B
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 01:00:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gR8MQ+tIwhdlJzfK8asP+WxTgGietYKFr2jts6B8RqGOFidRJYn/WQUECZg12iIPQ2STWvxteIJSJC3T5Qw32zD9pVMUmRAptgNwtIoJNkYHludtC9599tCU2ZDQE07S2oyp2mL2oYO4OjjEfLy72U5cI1A1vjzUyyiLCNGM5X8coi2Gj0x7lpHEXDOT+yoIUxl1E5hwwhLmOKxvppaiMAotlXKlIXwFKnZ6GLftdtdPaj12qQ84SgplJphww2Ktj4E7UJEkdFVctyj5ehdhrEpt1MV+uIVDNN9HqM+H2XUCk5LRD3O8duS+wMYJUejVIk786lSGS67GDjq9OpUTWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iAc5dacAJ79hXT50ErIFF9zPVuQvxlhphQZsdV0Vn+g=;
 b=I+f5iRguCUynE64JnYGQe4tkGuX5CUhxnxtNN4V9sKe3JQM+UrQCZSgmyonh5w6UnMm8pY3+H0MqMh++l6WKassJpDm9a4DM17PfupcU4vLhXPfD43xjeZaOI4npSCl53UVIcYJcElO5Lk3pOY98ceilUAKTvpzlsBxyu9XG7upj/lkafa25jHFgiYOFJUZKJQQyMTPM/pN3QuFu2wXJlAp5FnrBVVxHVaJiUnl3wZthXIb+ZxpVNbxS5aPxVCbhahIaQaweCevstqYWmiVGNZT5MVl/f9RmcLcaCaMKhG9JOB8ZMNtKCv7n+x6HA39nGJUx7L511+rOLs78E+HFwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iAc5dacAJ79hXT50ErIFF9zPVuQvxlhphQZsdV0Vn+g=;
 b=Jn3EYI4aRVlPlS063Q+iwmmgMXH3/7yQU4h+vwy0bSlShbg1AX5V3KOn/wqd41He9JXLrwv8LaJRj8sK1F39g08HX4aW6zb6iYdXeLIIcENdwEoAcuHqzBTZRp8sCw3PBuAcHNSdVo8QizPHrQVyD3WSxCmAXFutdLvtVKHEWiQ=
Received: from DM5PR07CA0097.namprd07.prod.outlook.com (2603:10b6:4:ae::26) by
 CH2PR12MB4071.namprd12.prod.outlook.com (2603:10b6:610:7b::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18; Wed, 11 Jan 2023 09:00:05 +0000
Received: from DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::dd) by DM5PR07CA0097.outlook.office365.com
 (2603:10b6:4:ae::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Wed, 11 Jan 2023 09:00:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT016.mail.protection.outlook.com (10.13.173.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.18 via Frontend Transport; Wed, 11 Jan 2023 09:00:05 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 11 Jan
 2023 03:00:01 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 11 Jan
 2023 03:00:00 -0600
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Wed, 11 Jan 2023 02:59:50 -0600
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
Subject: [PATCH 03/19] soundwire: amd: register sdw controller dai ops
Date:   Wed, 11 Jan 2023 14:32:06 +0530
Message-ID: <20230111090222.2016499-4-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
References: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT016:EE_|CH2PR12MB4071:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b7c2cf8-a1f8-45f1-0e94-08daf3b23b4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oDzD3SXckIuLV7cOHyH8QcVBoBF63GGem8FymxF1V79/776ckHC/KcPqsK50y6FHYbL6SmqqdIKywNeSQLbr89qkRsY18ef3GXBCorKQJttcNB/Rr9XijyqzGGvq2bZbm5VWaQpveWLZ+6ljkKu8AMwd5/8a3K2/sVNgSZphhikm/I9/cyyWAh0Eu6pyL9hb6ahHHOHV07p6aZT9BJgzvLN6aOScCuobtYxPyV0ERjZnrz4JNt1N2usU/QNkxByl7UQDlhovPyIe/E95ZrTNMcaYxSErgGzsX42KSvmLvMMiu/I7bn4mtP99tTrnw8bLCwkMVuvAhuxcRx6XHYOWfewDo2s540+tkYEbZRMi0sOdgd5u6Or0bC5ezIrfJuKGKZoNRvvZnq7l7jS8jMP1HZ/1YD7aGkRieoCUTDPG239jNkT3kZem7/O86Eua6ersN/17P7h4MlaocFOxtZEfOJcy5nbJK2fEQJjOtm0D3seCjr7Ef7OE/DnTNoSr2KySEjnZfe8L5zK41EN6xBZaz1cdxBg/XsIuyutToPUQawShtssmiw5AJ5v+BIHXKCU2ZzHDf1ZO6I9YxFDb43QlUC/nhJeU1SvQvB2WqKFbethpZandPvZ5lh1m1I0LiB5Tt3MHVLq638u7najJlIUCDLr1GQBgwUNe3XH+Hg0x1prRQzrk+44G+bbxrsd8Uu2isRdhlgYxiwSZ0ZoCWGJqFJlY1Ba799yzHeby4kYvJTg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(39860400002)(376002)(396003)(451199015)(36840700001)(40470700004)(46966006)(82310400005)(2906002)(36756003)(5660300002)(8936002)(70206006)(6666004)(8676002)(41300700001)(2616005)(70586007)(316002)(7696005)(4326008)(54906003)(110136005)(478600001)(40480700001)(26005)(186003)(336012)(1076003)(426003)(86362001)(47076005)(83380400001)(36860700001)(40460700003)(356005)(81166007)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 09:00:05.0173
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b7c2cf8-a1f8-45f1-0e94-08daf3b23b4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4071
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register dai ops for two controller instances.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 drivers/soundwire/amd_master.c    | 186 ++++++++++++++++++++++++++++++
 include/linux/soundwire/sdw_amd.h |  21 ++++
 2 files changed, 207 insertions(+)

diff --git a/drivers/soundwire/amd_master.c b/drivers/soundwire/amd_master.c
index 7e1f618254ac..93bffe6ff9e2 100644
--- a/drivers/soundwire/amd_master.c
+++ b/drivers/soundwire/amd_master.c
@@ -952,6 +952,186 @@ static const struct sdw_master_ops amd_sdwc_ops = {
 	.read_ping_status = amd_sdwc_read_ping_status,
 };
 
+static int amd_sdwc_hw_params(struct snd_pcm_substream *substream,
+			      struct snd_pcm_hw_params *params,
+			      struct snd_soc_dai *dai)
+{
+	struct amd_sdwc_ctrl *ctrl = snd_soc_dai_get_drvdata(dai);
+	struct sdw_amd_dma_data *dma;
+	struct sdw_stream_config sconfig;
+	struct sdw_port_config *pconfig;
+	int ch, dir;
+	int ret;
+
+	dma = snd_soc_dai_get_dma_data(dai, substream);
+	if (!dma)
+		return -EIO;
+
+	ch = params_channels(params);
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
+		dir = SDW_DATA_DIR_RX;
+	else
+		dir = SDW_DATA_DIR_TX;
+	dev_dbg(ctrl->dev, "%s: dir:%d dai->id:0x%x\n", __func__, dir, dai->id);
+	dma->hw_params = params;
+
+	sconfig.direction = dir;
+	sconfig.ch_count = ch;
+	sconfig.frame_rate = params_rate(params);
+	sconfig.type = dma->stream_type;
+
+	sconfig.bps = snd_pcm_format_width(params_format(params));
+
+	/* Port configuration */
+	pconfig = kzalloc(sizeof(*pconfig), GFP_KERNEL);
+	if (!pconfig) {
+		ret =  -ENOMEM;
+		goto error;
+	}
+
+	pconfig->num = dai->id;
+	pconfig->ch_mask = (1 << ch) - 1;
+	ret = sdw_stream_add_master(&ctrl->bus, &sconfig,
+				    pconfig, 1, dma->stream);
+	if (ret)
+		dev_err(ctrl->dev, "add master to stream failed:%d\n", ret);
+
+	kfree(pconfig);
+error:
+	return ret;
+}
+
+static int amd_sdwc_hw_free(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
+{
+	struct amd_sdwc_ctrl *ctrl = snd_soc_dai_get_drvdata(dai);
+	struct sdw_amd_dma_data *dma;
+	int ret;
+
+	dma = snd_soc_dai_get_dma_data(dai, substream);
+	if (!dma)
+		return -EIO;
+
+	ret = sdw_stream_remove_master(&ctrl->bus, dma->stream);
+	if (ret < 0) {
+		dev_err(dai->dev, "remove master from stream %s failed: %d\n",
+			dma->stream->name, ret);
+		return ret;
+	}
+	dma->hw_params = NULL;
+	return 0;
+}
+
+static int amd_set_sdw_stream(struct snd_soc_dai *dai, void *stream, int direction)
+{
+	struct amd_sdwc_ctrl *ctrl = snd_soc_dai_get_drvdata(dai);
+	struct sdw_amd_dma_data *dma;
+
+	if (stream) {
+		if (direction == SNDRV_PCM_STREAM_PLAYBACK)
+			dma = dai->playback_dma_data;
+		else
+			dma = dai->capture_dma_data;
+
+		if (dma) {
+			dev_err(dai->dev,
+				"dma_data already allocated for dai %s\n",
+				dai->name);
+			return -EINVAL;
+		}
+
+		/* allocate and set dma info */
+		dma = kzalloc(sizeof(*dma), GFP_KERNEL);
+		if (!dma)
+			return -ENOMEM;
+		dma->stream_type = SDW_STREAM_PCM;
+		dma->bus = &ctrl->bus;
+		dma->link_id = ctrl->instance;
+		dma->stream = stream;
+
+		if (direction == SNDRV_PCM_STREAM_PLAYBACK)
+			dai->playback_dma_data = dma;
+		else
+			dai->capture_dma_data = dma;
+	} else {
+		if (direction == SNDRV_PCM_STREAM_PLAYBACK) {
+			kfree(dai->playback_dma_data);
+			dai->playback_dma_data = NULL;
+		} else {
+			kfree(dai->capture_dma_data);
+			dai->capture_dma_data = NULL;
+		}
+	}
+	return 0;
+}
+
+static int amd_pcm_set_sdw_stream(struct snd_soc_dai *dai, void *stream, int direction)
+{
+	return amd_set_sdw_stream(dai, stream, direction);
+}
+
+static void *amd_get_sdw_stream(struct snd_soc_dai *dai, int direction)
+{
+	struct sdw_amd_dma_data *dma;
+
+	if (direction == SNDRV_PCM_STREAM_PLAYBACK)
+		dma = dai->playback_dma_data;
+	else
+		dma = dai->capture_dma_data;
+
+	if (!dma)
+		return ERR_PTR(-EINVAL);
+
+	return dma->stream;
+}
+
+static const struct snd_soc_dai_ops amd_sdwc_dai_ops = {
+	.hw_params = amd_sdwc_hw_params,
+	.hw_free = amd_sdwc_hw_free,
+	.set_stream = amd_pcm_set_sdw_stream,
+	.get_stream = amd_get_sdw_stream,
+};
+
+static const struct snd_soc_component_driver amd_sdwc_dai_component = {
+	.name = "soundwire",
+};
+
+static int amd_sdwc_register_dais(struct amd_sdwc_ctrl *ctrl)
+{
+	struct snd_soc_dai_driver *dais;
+	struct snd_soc_pcm_stream *stream;
+	struct device *dev;
+	int i, num_dais;
+
+	dev = ctrl->dev;
+	num_dais = ctrl->num_dout_ports + ctrl->num_din_ports;
+	dais = devm_kcalloc(dev, num_dais, sizeof(*dais), GFP_KERNEL);
+	if (!dais)
+		return -ENOMEM;
+	for (i = 0; i < num_dais; i++) {
+		dais[i].name = devm_kasprintf(dev, GFP_KERNEL, "SDW%d Pin%d", ctrl->instance, i);
+		if (!dais[i].name) {
+			dev_err(ctrl->dev, "-ENOMEM dai name allocation failed\n");
+			return -ENOMEM;
+		}
+
+		if (i < ctrl->num_dout_ports)
+			stream = &dais[i].playback;
+		else
+			stream = &dais[i].capture;
+
+		stream->channels_min = 2;
+		stream->channels_max = 2;
+		stream->rates = SNDRV_PCM_RATE_48000;
+		stream->formats = SNDRV_PCM_FMTBIT_S16_LE;
+
+		dais[i].ops = &amd_sdwc_dai_ops;
+		dais[i].id = i;
+	}
+
+	return devm_snd_soc_register_component(ctrl->dev, &amd_sdwc_dai_component,
+					       dais, num_dais);
+}
+
 static void amd_sdwc_probe_work(struct work_struct *work)
 {
 	struct amd_sdwc_ctrl *ctrl  = container_of(work, struct amd_sdwc_ctrl, probe_work);
@@ -1043,6 +1223,12 @@ static int amd_sdwc_probe(struct platform_device *pdev)
 			ret);
 		return ret;
 	}
+	ret = amd_sdwc_register_dais(ctrl);
+	if (ret) {
+		dev_err(dev, "CPU DAI registration failed\n");
+		sdw_bus_master_delete(&ctrl->bus);
+		return ret;
+	}
 	INIT_WORK(&ctrl->probe_work, amd_sdwc_probe_work);
 	schedule_work(&ctrl->probe_work);
 	return 0;
diff --git a/include/linux/soundwire/sdw_amd.h b/include/linux/soundwire/sdw_amd.h
index 5ec39f8c2f2e..7a99d782969f 100644
--- a/include/linux/soundwire/sdw_amd.h
+++ b/include/linux/soundwire/sdw_amd.h
@@ -13,6 +13,7 @@
 #define ACP_SDW0	0
 #define ACP_SDW1	1
 #define ACP_SDW0_MAX_DAI	6
+#define AMD_SDW_MAX_DAIS	8
 
 struct acp_sdw_pdata {
 	u16 instance;
@@ -25,6 +26,7 @@ struct amd_sdwc_ctrl {
 	void __iomem *mmio;
 	struct work_struct probe_work;
 	struct mutex *sdw_lock;
+	struct sdw_stream_runtime *sruntime[AMD_SDW_MAX_DAIS];
 	int num_din_ports;
 	int num_dout_ports;
 	int cols_index;
@@ -36,4 +38,23 @@ struct amd_sdwc_ctrl {
 	bool startup_done;
 	u32 power_mode_mask;
 };
+
+/**
+ * struct sdw_amd_dma_data: AMD DMA data
+ *
+ * @name: SoundWire stream name
+ * @stream: stream runtime
+ * @bus: Bus handle
+ * @stream_type: Stream type
+ * @link_id: Master link id
+ * @hw_params: hw_params to be applied in .prepare step
+ */
+struct sdw_amd_dma_data {
+	char *name;
+	struct sdw_stream_runtime *stream;
+	struct sdw_bus *bus;
+	enum sdw_stream_type stream_type;
+	int link_id;
+	struct snd_pcm_hw_params *hw_params;
+};
 #endif
-- 
2.34.1

