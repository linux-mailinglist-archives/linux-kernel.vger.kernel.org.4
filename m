Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446486AE07B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 14:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjCGN2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 08:28:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjCGN2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 08:28:19 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F6D3B228
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 05:27:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n/ywayPuw1NK+QwX3hiXyYAMGAp+9lJdV7Ty26kAnmAR69ZWMR1PW5HxI0mkbPdciXoGTWA0JhU3NaEOKp/1YlPmmoBBoIT1YpFwn67V1rJfii4+WByw4q0wxHYSqCM9Y3pG275IxCgeqB7bx/0MYRIeKmDUjZ4F5tjhMWjJ9//C/PBY77Sj630FkROFRmP8I0dl6FMdMPWqPYwpROzmfP7k2hGwi6gJv7t3S1h/pjGKkVdXj3C28LL7cwZ2QNg3z4Em20JNqojC1EM8cCJwQbTBbA0bDIdTSNkiYFOgnzrverNBZKeynGT5WxBmBFNqATi5YaZZrcrNXrQlLa8tww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Gz8WZ2jQ7ZhUbOKttMS4IsIhaTWg5dAMlfBlEWHJ/0=;
 b=amLPXnY+u9iAEFiPVVWUOlY10GSRMa+oAqUHRPv9viLYMywzeeMd96fKS6JKQ2gde1cDtqJoqAoISdKaeClOGGoMpKS8KPmj3QK7UhZXS0XkIfXAHCgEO+qjpmB6V4f7UBywpf5HcHwid0sh3NI39UGoN2ajhi/t5iwU9xhMTRL6QF4iaf0ovHCa5Ws7rhEaao87ngXXV/xxK+EOBc2SBFtF7r/53xRObCku8ZCrq5kZofYILSdVPIuKVPpFRhTLq5IT+qmzcIzCm58DtX/lDnRh8OgxKYTd4SMAKX0Se8BTwDetAi4Rlzc1pfnGap4Fdxu74uI/HwmSSHJq84X8nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Gz8WZ2jQ7ZhUbOKttMS4IsIhaTWg5dAMlfBlEWHJ/0=;
 b=hCT/lkpR16xxZ/ogqXtpXM/QnsOYardNmAOTI1alBP+rkWf8sVcJvwBJzNckjmxPmrTvM2y0/Ja7qxVDz8SmcdysDxi8S/4wl779IbMBOgZvzyMfUzE4QQbN7fjeyhrswo1D8mtU6NqZnGFL+Jw97MHIeNdv7QMO/TJrktq3afo=
Received: from BL1P221CA0002.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::32)
 by MW3PR12MB4361.namprd12.prod.outlook.com (2603:10b6:303:5a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Tue, 7 Mar
 2023 13:27:48 +0000
Received: from BL02EPF0000EE3E.namprd05.prod.outlook.com
 (2603:10b6:208:2c5:cafe::2e) by BL1P221CA0002.outlook.office365.com
 (2603:10b6:208:2c5::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28 via Frontend
 Transport; Tue, 7 Mar 2023 13:27:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0000EE3E.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.13 via Frontend Transport; Tue, 7 Mar 2023 13:27:47 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 7 Mar
 2023 07:27:47 -0600
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Tue, 7 Mar 2023 07:27:43 -0600
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <vkoul@kernel.org>
CC:     <alsa-devel@alsa-project.org>,
        <pierre-louis.bossart@linux.intel.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <Mario.Limonciello@amd.com>, <amadeuszx.slawinski@linux.intel.com>,
        <Mastan.Katragadda@amd.com>, <Arungopal.kondaveeti@amd.com>,
        <claudiu.beznea@microchip.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH V6 3/8] soundwire: amd: register SoundWire manager dai ops
Date:   Tue, 7 Mar 2023 19:01:30 +0530
Message-ID: <20230307133135.545952-4-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230307133135.545952-1-Vijendar.Mukunda@amd.com>
References: <20230307133135.545952-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000EE3E:EE_|MW3PR12MB4361:EE_
X-MS-Office365-Filtering-Correlation-Id: 703c30cf-b138-43f7-8980-08db1f0fbe01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8LHTaHuhjm3nlMZTSyr9HdHpHduZsueOQGTSDhVtERJiNftnQUVTwja9UCXtb7QGrLOp6ljy7GyPDxztMl9SDl01J9SxW77sfstfjO0ggNGditvfexQfMqR+/v/bXRupKjdCr61rBy8v7Anf+Guk+M5ikSOZghocrLIhUd9ZqarX05Djn4UJMSYBWym2si3gkknng157TiLu3M+TrjBkiN0Rq5DInen3xQV/Dd9IhhEr9f3anQf+E8fvd6tdADiZXN/XIW1OhiE3esA87wlvBG0HA4LHE8b7ED1DooMZlXXIVjIprRPcORP0thL62KbIKPgvGqitFO9uBYKAFbV7dbLa8OxBRrZFr77YfEuWPcuzbjlPQOCD7LoiuAzAOBGp2HK7JiAtgJsJKjfYYgxvlw/KE4D39j0wF4CINXZPT7MajhVW1JfJp5YuaE/xt9bPNOKrIFM39ajwIeO7DDifMrz4FncOS4s5ooqFF3JMs/cLKWprZW+WSaju3o577iO6odshNcAMI5K90br6R86/MvNbFFNkVCOzHXxe8tEy0iLs3WMexriQMeyxlJOHB9kWXhCfDWhMOyRyxxb5glAXVOfUAd6VhtM2MoJmDGKkZI5mMaJN1oYb77MXNLWIfjCshppKYHHVr+LSTMLkKMb8Qd555Ey4TRcyzHcEr32Xzd2R6mYJzlR67uXxA7bU4lCPyNFjDy6KNRC88MZ8MDdpAVrIkXJZMQI5LYSbCQMogXU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199018)(36840700001)(46966006)(40470700004)(82310400005)(2906002)(2616005)(336012)(83380400001)(47076005)(426003)(26005)(70586007)(70206006)(4326008)(8676002)(6916009)(5660300002)(186003)(81166007)(41300700001)(1076003)(36756003)(82740400003)(6666004)(8936002)(478600001)(966005)(54906003)(356005)(7696005)(86362001)(40460700003)(316002)(40480700001)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 13:27:47.5330
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 703c30cf-b138-43f7-8980-08db1f0fbe01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000EE3E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4361
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register dai ops for SoundWire manager instances.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/lkml/20230227154801.50319-4-Vijendar.Mukunda@amd.com
---
 drivers/soundwire/amd_manager.c   | 182 ++++++++++++++++++++++++++++++
 drivers/soundwire/amd_manager.h   |  18 +++
 include/linux/soundwire/sdw_amd.h |  18 +++
 3 files changed, 218 insertions(+)

diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
index a5cf6acd936c..dd7fd4036d89 100644
--- a/drivers/soundwire/amd_manager.c
+++ b/drivers/soundwire/amd_manager.c
@@ -581,6 +581,182 @@ static const struct sdw_master_ops amd_sdw_ops = {
 	.read_ping_status = amd_sdw_read_ping_status,
 };
 
+static int amd_sdw_hw_params(struct snd_pcm_substream *substream,
+			     struct snd_pcm_hw_params *params,
+			     struct snd_soc_dai *dai)
+{
+	struct amd_sdw_manager *amd_manager = snd_soc_dai_get_drvdata(dai);
+	struct sdw_amd_dai_runtime *dai_runtime;
+	struct sdw_stream_config sconfig;
+	struct sdw_port_config *pconfig;
+	int ch, dir;
+	int ret;
+
+	dai_runtime = amd_manager->dai_runtime_array[dai->id];
+	if (!dai_runtime)
+		return -EIO;
+
+	ch = params_channels(params);
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
+		dir = SDW_DATA_DIR_RX;
+	else
+		dir = SDW_DATA_DIR_TX;
+	dev_dbg(amd_manager->dev, "dir:%d dai->id:0x%x\n", dir, dai->id);
+
+	sconfig.direction = dir;
+	sconfig.ch_count = ch;
+	sconfig.frame_rate = params_rate(params);
+	sconfig.type = dai_runtime->stream_type;
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
+	ret = sdw_stream_add_master(&amd_manager->bus, &sconfig,
+				    pconfig, 1, dai_runtime->stream);
+	if (ret)
+		dev_err(amd_manager->dev, "add manager to stream failed:%d\n", ret);
+
+	kfree(pconfig);
+error:
+	return ret;
+}
+
+static int amd_sdw_hw_free(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
+{
+	struct amd_sdw_manager *amd_manager = snd_soc_dai_get_drvdata(dai);
+	struct sdw_amd_dai_runtime *dai_runtime;
+	int ret;
+
+	dai_runtime = amd_manager->dai_runtime_array[dai->id];
+	if (!dai_runtime)
+		return -EIO;
+
+	ret = sdw_stream_remove_master(&amd_manager->bus, dai_runtime->stream);
+	if (ret < 0)
+		dev_err(dai->dev, "remove manager from stream %s failed: %d\n",
+			dai_runtime->stream->name, ret);
+	return ret;
+}
+
+static int amd_set_sdw_stream(struct snd_soc_dai *dai, void *stream, int direction)
+{
+	struct amd_sdw_manager *amd_manager = snd_soc_dai_get_drvdata(dai);
+	struct sdw_amd_dai_runtime *dai_runtime;
+
+	dai_runtime = amd_manager->dai_runtime_array[dai->id];
+	if (stream) {
+		/* first paranoia check */
+		if (dai_runtime) {
+			dev_err(dai->dev,
+				"dai_runtime already allocated for dai %s\n",
+				dai->name);
+			return -EINVAL;
+		}
+
+		/* allocate and set dai_runtime info */
+		dai_runtime = kzalloc(sizeof(*dai_runtime), GFP_KERNEL);
+		if (!dai_runtime)
+			return -ENOMEM;
+
+		dai_runtime->stream_type = SDW_STREAM_PCM;
+		dai_runtime->bus = &amd_manager->bus;
+		dai_runtime->stream = stream;
+		amd_manager->dai_runtime_array[dai->id] = dai_runtime;
+	} else {
+		/* second paranoia check */
+		if (!dai_runtime) {
+			dev_err(dai->dev,
+				"dai_runtime not allocated for dai %s\n",
+				dai->name);
+			return -EINVAL;
+		}
+
+		/* for NULL stream we release allocated dai_runtime */
+		kfree(dai_runtime);
+		amd_manager->dai_runtime_array[dai->id] = NULL;
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
+	struct amd_sdw_manager *amd_manager = snd_soc_dai_get_drvdata(dai);
+	struct sdw_amd_dai_runtime *dai_runtime;
+
+	dai_runtime = amd_manager->dai_runtime_array[dai->id];
+	if (!dai_runtime)
+		return ERR_PTR(-EINVAL);
+
+	return dai_runtime->stream;
+}
+
+static const struct snd_soc_dai_ops amd_sdw_dai_ops = {
+	.hw_params = amd_sdw_hw_params,
+	.hw_free = amd_sdw_hw_free,
+	.set_stream = amd_pcm_set_sdw_stream,
+	.get_stream = amd_get_sdw_stream,
+};
+
+static const struct snd_soc_component_driver amd_sdw_dai_component = {
+	.name = "soundwire",
+};
+
+static int amd_sdw_register_dais(struct amd_sdw_manager *amd_manager)
+{
+	struct sdw_amd_dai_runtime **dai_runtime_array;
+	struct snd_soc_dai_driver *dais;
+	struct snd_soc_pcm_stream *stream;
+	struct device *dev;
+	int i, num_dais;
+
+	dev = amd_manager->dev;
+	num_dais = amd_manager->num_dout_ports + amd_manager->num_din_ports;
+	dais = devm_kcalloc(dev, num_dais, sizeof(*dais), GFP_KERNEL);
+	if (!dais)
+		return -ENOMEM;
+
+	dai_runtime_array = devm_kcalloc(dev, num_dais,
+					 sizeof(struct sdw_amd_dai_runtime *),
+					 GFP_KERNEL);
+	if (!dai_runtime_array)
+		return -ENOMEM;
+	amd_manager->dai_runtime_array = dai_runtime_array;
+	for (i = 0; i < num_dais; i++) {
+		dais[i].name = devm_kasprintf(dev, GFP_KERNEL, "SDW%d Pin%d", amd_manager->instance,
+					      i);
+		if (!dais[i].name)
+			return -ENOMEM;
+		if (i < amd_manager->num_dout_ports)
+			stream = &dais[i].playback;
+		else
+			stream = &dais[i].capture;
+
+		stream->channels_min = 2;
+		stream->channels_max = 2;
+		stream->rates = SNDRV_PCM_RATE_48000;
+		stream->formats = SNDRV_PCM_FMTBIT_S16_LE;
+
+		dais[i].ops = &amd_sdw_dai_ops;
+		dais[i].id = i;
+	}
+
+	return devm_snd_soc_register_component(dev, &amd_sdw_dai_component,
+					       dais, num_dais);
+}
+
 static void amd_sdw_probe_work(struct work_struct *work)
 {
 	struct amd_sdw_manager *amd_manager = container_of(work, struct amd_sdw_manager,
@@ -664,6 +840,12 @@ static int amd_sdw_manager_probe(struct platform_device *pdev)
 		dev_err(dev, "Failed to register SoundWire manager(%d)\n", ret);
 		return ret;
 	}
+	ret = amd_sdw_register_dais(amd_manager);
+	if (ret) {
+		dev_err(dev, "CPU DAI registration failed\n");
+		sdw_bus_master_delete(&amd_manager->bus);
+		return ret;
+	}
 	dev_set_drvdata(dev, amd_manager);
 	INIT_WORK(&amd_manager->probe_work, amd_sdw_probe_work);
 	/*
diff --git a/drivers/soundwire/amd_manager.h b/drivers/soundwire/amd_manager.h
index 0d4b8653877e..cad26034087b 100644
--- a/drivers/soundwire/amd_manager.h
+++ b/drivers/soundwire/amd_manager.h
@@ -204,6 +204,24 @@ struct sdw_manager_dp_reg {
 	u32 lane_ctrl_ch_en_reg;
 };
 
+/*
+ * SDW0 Manager instance registers  6 CPU DAI (3 TX & 3 RX Ports)
+ * whereas SDW1  Manager Instance registers 2 CPU DAI (one TX & one RX port)
+ * Below is the CPU DAI <->Manager port number mapping
+ * i.e SDW0 Pin0 -> port number 0 -> AUDIO0 TX
+ *     SDW0 Pin1 -> Port number 1 -> AUDIO1 TX
+ *     SDW0 Pin2 -> Port number 2 -> AUDIO2 TX
+ *     SDW0 Pin3 -> port number 3 -> AUDIO0 RX
+ *     SDW0 Pin4 -> Port number 4 -> AUDIO1 RX
+ *     SDW0 Pin5 -> Port number 5 -> AUDIO2 RX
+ *  Whereas for SDW1 instance
+ *  SDW1 Pin0 -> port number 0 -> AUDIO1 TX
+ *  SDW1 Pin1 -> Port number 1 -> AUDIO1 RX
+ *  Same mapping should be used for programming DMA controller registers in SoundWire DMA driver.
+ * i.e if AUDIO0 TX channel is selected then we need to use AUDIO0 TX registers for DMA programming
+ * in SoundWire DMA driver.
+ */
+
 static struct sdw_manager_dp_reg sdw0_manager_dp_reg[AMD_SDW0_MAX_DAI] =  {
 	{ACP_SW_AUDIO0_TX_FRAME_FORMAT, ACP_SW_AUDIO0_TX_SAMPLEINTERVAL, ACP_SW_AUDIO0_TX_HCTRL_DP0,
 	 ACP_SW_AUDIO0_TX_OFFSET_DP0, ACP_SW_AUDIO0_TX_CHANNEL_ENABLE_DP0},
diff --git a/include/linux/soundwire/sdw_amd.h b/include/linux/soundwire/sdw_amd.h
index c14a291a40e8..ac537419301d 100644
--- a/include/linux/soundwire/sdw_amd.h
+++ b/include/linux/soundwire/sdw_amd.h
@@ -23,6 +23,21 @@ struct sdw_manager_reg_mask {
 	u32 acp_sdw_intr_mask;
 };
 
+/**
+ * struct sdw_amd_dai_runtime: AMD sdw dai runtime  data
+ *
+ * @name: SoundWire stream name
+ * @stream: stream runtime
+ * @bus: Bus handle
+ * @stream_type: Stream type
+ */
+struct sdw_amd_dai_runtime {
+	char *name;
+	struct sdw_stream_runtime *stream;
+	struct sdw_bus *bus;
+	enum sdw_stream_type stream_type;
+};
+
 /**
  * struct amd_sdw_manager - amd manager driver context
  * @bus: bus handle
@@ -40,6 +55,7 @@ struct sdw_manager_reg_mask {
  * @quirks: SoundWire manager quirks
  * @wake_en_mask: wake enable mask per SoundWire manager
  * @power_mode_mask: flag interprets amd SoundWire manager power mode
+ * @dai_runtime_array: dai runtime array
  */
 struct amd_sdw_manager {
 	struct sdw_bus bus;
@@ -63,5 +79,7 @@ struct amd_sdw_manager {
 	u32 quirks;
 	u32 wake_en_mask;
 	u32 power_mode_mask;
+
+	struct sdw_amd_dai_runtime **dai_runtime_array;
 };
 #endif
-- 
2.34.1

