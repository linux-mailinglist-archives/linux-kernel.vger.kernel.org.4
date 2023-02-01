Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF8967C31B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 04:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236173AbjAZDO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 22:14:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235962AbjAZDOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 22:14:49 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F41265F09;
        Wed, 25 Jan 2023 19:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1674702885; x=1706238885;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=FHMen8BOj1wJyxQLpH56jMvwuqHzmMsYn9QZTPIZBcI=;
  b=YkNnansAfGMcf29uscFHUV+OvP8SykYg6EgvjF5wGAJ5vHh3ePP6fwCb
   uOs5QyijKK/VLZGCOGDT9Z5PTOpRQ7RiGvH/Di0oqQR3EZ8D2eEGsP7Z4
   R2IZO51f4uM5q3oVH78YjM5cl3u2uEllRFW+HgaLMJMNOXx27eZyr5Ixi
   Q=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 25 Jan 2023 19:14:43 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.45.79.139])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 19:14:43 -0800
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 25 Jan 2023 19:14:42 -0800
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <lgirdwood@gmail.com>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <gregkh@linuxfoundation.org>,
        <Thinh.Nguyen@synopsys.com>, <broonie@kernel.org>,
        <bgoswami@quicinc.com>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <agross@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <quic_jackp@quicinc.com>,
        <quic_plai@quicinc.com>, Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [RFC PATCH v2 09/22] ASoC: qcom: qdsp6: Introduce USB AFE port to q6dsp
Date:   Wed, 25 Jan 2023 19:14:11 -0800
Message-ID: <20230126031424.14582-10-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230126031424.14582-1-quic_wcheng@quicinc.com>
References: <20230126031424.14582-1-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The QC ADSP is able to support USB playback endpoints, so that the main
application processor can be placed into lower CPU power modes.  This adds
the required AFE port configurations and port start command to start an
audio session.

Specifically, the QC ADSP can support all potential endpoints that are
exposed by the audio data interface.  This includes, feedback endpoints
(both implicit and explicit) as well as the isochronous (data) endpoints.
The size of audio samples sent per USB frame (microframe) will be adjusted
based on information received on the feedback endpoint.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 sound/soc/qcom/qdsp6/q6afe-dai.c         |  48 ++++++
 sound/soc/qcom/qdsp6/q6afe.c             | 183 +++++++++++++++++++++++
 sound/soc/qcom/qdsp6/q6afe.h             |  46 +++++-
 sound/soc/qcom/qdsp6/q6dsp-lpass-ports.c |  23 +++
 sound/soc/qcom/qdsp6/q6dsp-lpass-ports.h |   1 +
 sound/soc/qcom/qdsp6/q6routing.c         |   8 +
 6 files changed, 308 insertions(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/q6afe-dai.c b/sound/soc/qcom/qdsp6/q6afe-dai.c
index 8bb7452b8f18..0773a0882d9b 100644
--- a/sound/soc/qcom/qdsp6/q6afe-dai.c
+++ b/sound/soc/qcom/qdsp6/q6afe-dai.c
@@ -111,6 +111,40 @@ static int q6hdmi_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static int q6usb_hw_params(struct snd_pcm_substream *substream,
+			   struct snd_pcm_hw_params *params,
+			   struct snd_soc_dai *dai)
+{
+	struct q6afe_dai_data *dai_data = dev_get_drvdata(dai->dev);
+	int channels = params_channels(params);
+	int rate = params_rate(params);
+	struct q6afe_usb_cfg *usb = &dai_data->port_config[dai->id].usb_audio;
+
+	usb->sample_rate = rate;
+	usb->num_channels = channels;
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_U16_LE:
+	case SNDRV_PCM_FORMAT_S16_LE:
+	case SNDRV_PCM_FORMAT_SPECIAL:
+		usb->bit_width = 16;
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+	case SNDRV_PCM_FORMAT_S24_3LE:
+		usb->bit_width = 24;
+		break;
+	case SNDRV_PCM_FORMAT_S32_LE:
+		usb->bit_width = 32;
+		break;
+	default:
+		dev_err(dai->dev, "%s: invalid format %d\n",
+			__func__, params_format(params));
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int q6i2s_hw_params(struct snd_pcm_substream *substream,
 			   struct snd_pcm_hw_params *params,
 			   struct snd_soc_dai *dai)
@@ -411,6 +445,10 @@ static int q6afe_dai_prepare(struct snd_pcm_substream *substream,
 		q6afe_cdc_dma_port_prepare(dai_data->port[dai->id],
 					   &dai_data->port_config[dai->id].dma_cfg);
 		break;
+	case USB_RX:
+		q6afe_usb_port_prepare(dai_data->port[dai->id],
+					   &dai_data->port_config[dai->id].usb_audio);
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -495,6 +533,8 @@ static int q6afe_mi2s_set_sysclk(struct snd_soc_dai *dai,
 }
 
 static const struct snd_soc_dapm_route q6afe_dapm_routes[] = {
+	/* USB playback AFE port receives data for playback, hence use the RX port */
+	{"USB Playback", NULL, "USB_RX"},
 	{"HDMI Playback", NULL, "HDMI_RX"},
 	{"Display Port Playback", NULL, "DISPLAY_PORT_RX"},
 	{"Slimbus Playback", NULL, "SLIMBUS_0_RX"},
@@ -639,6 +679,12 @@ static const struct snd_soc_dapm_route q6afe_dapm_routes[] = {
 	{"RX_CODEC_DMA_RX_7 Playback", NULL, "RX_CODEC_DMA_RX_7"},
 };
 
+static const struct snd_soc_dai_ops q6usb_ops = {
+	.prepare	= q6afe_dai_prepare,
+	.hw_params	= q6usb_hw_params,
+	.shutdown	= q6afe_dai_shutdown,
+};
+
 static const struct snd_soc_dai_ops q6hdmi_ops = {
 	.prepare	= q6afe_dai_prepare,
 	.hw_params	= q6hdmi_hw_params,
@@ -703,6 +749,7 @@ static int msm_dai_q6_dai_remove(struct snd_soc_dai *dai)
 }
 
 static const struct snd_soc_dapm_widget q6afe_dai_widgets[] = {
+	SND_SOC_DAPM_AIF_IN("USB_RX", NULL, 0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_IN("HDMI_RX", NULL, 0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_IN("SLIMBUS_0_RX", NULL, 0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_IN("SLIMBUS_1_RX", NULL, 0, SND_SOC_NOPM, 0, 0),
@@ -1068,6 +1115,7 @@ static int q6afe_dai_dev_probe(struct platform_device *pdev)
 	cfg.q6i2s_ops = &q6i2s_ops;
 	cfg.q6tdm_ops = &q6tdm_ops;
 	cfg.q6dma_ops = &q6dma_ops;
+	cfg.q6usb_ops = &q6usb_ops;
 	dais = q6dsp_audio_ports_set_config(dev, &cfg, &num_dais);
 
 	return devm_snd_soc_register_component(dev, &q6afe_dai_component, dais, num_dais);
diff --git a/sound/soc/qcom/qdsp6/q6afe.c b/sound/soc/qcom/qdsp6/q6afe.c
index 919e326b9462..ca799fc3820e 100644
--- a/sound/soc/qcom/qdsp6/q6afe.c
+++ b/sound/soc/qcom/qdsp6/q6afe.c
@@ -34,6 +34,8 @@
 #define AFE_MODULE_TDM			0x0001028A
 
 #define AFE_PARAM_ID_CDC_SLIMBUS_SLAVE_CFG 0x00010235
+#define AFE_PARAM_ID_USB_AUDIO_DEV_PARAMS    0x000102A5
+#define AFE_PARAM_ID_USB_AUDIO_DEV_LPCM_FMT 0x000102AA
 
 #define AFE_PARAM_ID_LPAIF_CLK_CONFIG	0x00010238
 #define AFE_PARAM_ID_INT_DIGITAL_CDC_CLK_CONFIG	0x00010239
@@ -43,6 +45,7 @@
 #define AFE_PARAM_ID_TDM_CONFIG	0x0001029D
 #define AFE_PARAM_ID_PORT_SLOT_MAPPING_CONFIG	0x00010297
 #define AFE_PARAM_ID_CODEC_DMA_CONFIG	0x000102B8
+#define AFE_PARAM_ID_USB_AUDIO_CONFIG    0x000102A4
 #define AFE_CMD_REMOTE_LPASS_CORE_HW_VOTE_REQUEST	0x000100f4
 #define AFE_CMD_RSP_REMOTE_LPASS_CORE_HW_VOTE_REQUEST   0x000100f5
 #define AFE_CMD_REMOTE_LPASS_CORE_HW_DEVOTE_REQUEST	0x000100f6
@@ -71,12 +74,16 @@
 #define AFE_PORT_CONFIG_I2S_WS_SRC_INTERNAL	0x1
 #define AFE_LINEAR_PCM_DATA				0x0
 
+#define AFE_API_MINOR_VERSION_USB_AUDIO_CONFIG 0x1
 
 /* Port IDs */
 #define AFE_API_VERSION_HDMI_CONFIG	0x1
 #define AFE_PORT_ID_MULTICHAN_HDMI_RX	0x100E
 #define AFE_PORT_ID_HDMI_OVER_DP_RX	0x6020
 
+/* USB AFE port */
+#define AFE_PORT_ID_USB_RX                       0x7000
+
 #define AFE_API_VERSION_SLIMBUS_CONFIG 0x1
 /* Clock set API version */
 #define AFE_API_VERSION_CLOCK_SET 1
@@ -512,12 +519,109 @@ struct afe_param_id_cdc_dma_cfg {
 	u16	active_channels_mask;
 } __packed;
 
+struct afe_param_id_usb_cfg {
+/* Minor version used for tracking USB audio device configuration.
+ * Supported values: AFE_API_MINOR_VERSION_USB_AUDIO_CONFIG
+ */
+	u32                  cfg_minor_version;
+/* Sampling rate of the port.
+ * Supported values:
+ * - AFE_PORT_SAMPLE_RATE_8K
+ * - AFE_PORT_SAMPLE_RATE_11025
+ * - AFE_PORT_SAMPLE_RATE_12K
+ * - AFE_PORT_SAMPLE_RATE_16K
+ * - AFE_PORT_SAMPLE_RATE_22050
+ * - AFE_PORT_SAMPLE_RATE_24K
+ * - AFE_PORT_SAMPLE_RATE_32K
+ * - AFE_PORT_SAMPLE_RATE_44P1K
+ * - AFE_PORT_SAMPLE_RATE_48K
+ * - AFE_PORT_SAMPLE_RATE_96K
+ * - AFE_PORT_SAMPLE_RATE_192K
+ */
+	u32                  sample_rate;
+/* Bit width of the sample.
+ * Supported values: 16, 24
+ */
+	u16                  bit_width;
+/* Number of channels.
+ * Supported values: 1 and 2
+ */
+	u16                  num_channels;
+/* Data format supported by the USB. The supported value is
+ * 0 (#AFE_USB_AUDIO_DATA_FORMAT_LINEAR_PCM).
+ */
+	u16                  data_format;
+/* this field must be 0 */
+	u16                  reserved;
+/* device token of actual end USB aduio device */
+	u32                  dev_token;
+/* endianness of this interface */
+	u32                   endian;
+/* service interval */
+	u32                  service_interval;
+} __packed;
+
+/**
+ * struct afe_param_id_usb_audio_dev_params
+ * @cfg_minor_version: Minor version used for tracking USB audio device
+ * configuration.
+ * Supported values:
+ *     AFE_API_MINOR_VERSION_USB_AUDIO_CONFIG
+ * @dev_token: device token of actual end USB aduio device
+ **/
+struct afe_param_id_usb_audio_dev_params {
+	u32	cfg_minor_version;
+	u32	dev_token;
+} __packed;
+
+/**
+ * struct afe_param_id_usb_audio_dev_lpcm_fmt
+ * @cfg_minor_version: Minor version used for tracking USB audio device
+ * configuration.
+ * Supported values:
+ *     AFE_API_MINOR_VERSION_USB_AUDIO_CONFIG
+ * @endian: endianness of this interface
+ **/
+struct afe_param_id_usb_audio_dev_lpcm_fmt {
+	u32	cfg_minor_version;
+	u32	endian;
+} __packed;
+
+/**
+ * struct afe_param_id_usb_audio_dev_latency_mode
+ * @cfg_minor_version: Minor version used for tracking USB audio device
+ * configuration.
+ * Supported values:
+ *     AFE_API_MINOR_VERSION_USB_AUDIO_LATENCY_MODE
+ * @mode: latency mode for the USB audio device
+ **/
+struct afe_param_id_usb_audio_dev_latency_mode {
+	u32	minor_version;
+	u32	mode;
+} __packed;
+
+#define AFE_PARAM_ID_USB_AUDIO_SVC_INTERVAL     0x000102B7
+
+/**
+ * struct afe_param_id_usb_audio_svc_interval
+ * @cfg_minor_version: Minor version used for tracking USB audio device
+ * configuration.
+ * Supported values:
+ *     AFE_API_MINOR_VERSION_USB_AUDIO_CONFIG
+ * @svc_interval: service interval
+ **/
+struct afe_param_id_usb_audio_svc_interval {
+	u32	cfg_minor_version;
+	u32	svc_interval;
+} __packed;
+
 union afe_port_config {
 	struct afe_param_id_hdmi_multi_chan_audio_cfg hdmi_multi_ch;
 	struct afe_param_id_slimbus_cfg           slim_cfg;
 	struct afe_param_id_i2s_cfg	i2s_cfg;
 	struct afe_param_id_tdm_cfg	tdm_cfg;
 	struct afe_param_id_cdc_dma_cfg	dma_cfg;
+	struct afe_param_id_usb_cfg usb_cfg;
 } __packed;
 
 
@@ -577,6 +681,7 @@ struct afe_port_map {
  */
 
 static struct afe_port_map port_maps[AFE_PORT_MAX] = {
+	[USB_RX] = { AFE_PORT_ID_USB_RX, USB_RX, 1, 1},
 	[HDMI_RX] = { AFE_PORT_ID_MULTICHAN_HDMI_RX, HDMI_RX, 1, 1},
 	[SLIMBUS_0_RX] = { AFE_PORT_ID_SLIMBUS_MULTI_CHAN_0_RX,
 				SLIMBUS_0_RX, 1, 1},
@@ -1289,6 +1394,82 @@ void q6afe_tdm_port_prepare(struct q6afe_port *port,
 }
 EXPORT_SYMBOL_GPL(q6afe_tdm_port_prepare);
 
+static int afe_port_send_usb_dev_param(struct q6afe_port *port, struct q6afe_usb_cfg *cfg)
+{
+	union afe_port_config *pcfg = &port->port_cfg;
+	struct afe_param_id_usb_audio_dev_params usb_dev;
+	struct afe_param_id_usb_audio_dev_lpcm_fmt lpcm_fmt;
+	struct afe_param_id_usb_audio_svc_interval svc_int;
+	int ret = 0;
+
+	if (!pcfg) {
+		dev_err(port->afe->dev, "%s: Error, no configuration data\n", __func__);
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	memset(&usb_dev, 0, sizeof(usb_dev));
+	memset(&lpcm_fmt, 0, sizeof(lpcm_fmt));
+
+	usb_dev.cfg_minor_version = AFE_API_MINOR_VERSION_USB_AUDIO_CONFIG;
+	q6afe_port_set_param_v2(port, &usb_dev,
+					AFE_PARAM_ID_USB_AUDIO_DEV_PARAMS,
+					AFE_MODULE_AUDIO_DEV_INTERFACE, sizeof(usb_dev));
+	if (ret) {
+		dev_err(port->afe->dev, "%s: AFE device param cmd failed %d\n",
+			__func__, ret);
+		goto exit;
+	}
+
+	lpcm_fmt.cfg_minor_version = AFE_API_MINOR_VERSION_USB_AUDIO_CONFIG;
+	lpcm_fmt.endian = pcfg->usb_cfg.endian;
+	ret = q6afe_port_set_param_v2(port, &lpcm_fmt,
+					AFE_PARAM_ID_USB_AUDIO_DEV_LPCM_FMT,
+					AFE_MODULE_AUDIO_DEV_INTERFACE, sizeof(lpcm_fmt));
+	if (ret) {
+		dev_err(port->afe->dev, "%s: AFE device param cmd LPCM_FMT failed %d\n",
+			__func__, ret);
+		goto exit;
+	}
+
+	svc_int.cfg_minor_version =
+		AFE_API_MINOR_VERSION_USB_AUDIO_CONFIG;
+	svc_int.svc_interval = pcfg->usb_cfg.service_interval;
+	ret = q6afe_port_set_param_v2(port, &svc_int,
+					AFE_PARAM_ID_USB_AUDIO_SVC_INTERVAL,
+					AFE_MODULE_AUDIO_DEV_INTERFACE, sizeof(svc_int));
+	if (ret) {
+		dev_err(port->afe->dev, "%s: AFE device param cmd svc_interval failed %d\n",
+			__func__, ret);
+		ret = -EINVAL;
+		goto exit;
+	}
+exit:
+	return ret;
+}
+
+/**
+ * q6afe_usb_port_prepare() - Prepare usb afe port.
+ *
+ * @port: Instance of afe port
+ * @cfg: USB configuration for the afe port
+ *
+ */
+void q6afe_usb_port_prepare(struct q6afe_port *port,
+			     struct q6afe_usb_cfg *cfg)
+{
+	union afe_port_config *pcfg = &port->port_cfg;
+
+	pcfg->usb_cfg.cfg_minor_version =
+					AFE_API_MINOR_VERSION_USB_AUDIO_CONFIG;
+	pcfg->usb_cfg.sample_rate = cfg->sample_rate;
+	pcfg->usb_cfg.num_channels = cfg->num_channels;
+	pcfg->usb_cfg.bit_width = cfg->bit_width;
+
+	afe_port_send_usb_dev_param(port, cfg);
+}
+EXPORT_SYMBOL_GPL(q6afe_usb_port_prepare);
+
 /**
  * q6afe_hdmi_port_prepare() - Prepare hdmi afe port.
  *
@@ -1611,6 +1792,8 @@ struct q6afe_port *q6afe_port_get_from_id(struct device *dev, int id)
 		break;
 	case AFE_PORT_ID_WSA_CODEC_DMA_RX_0 ... AFE_PORT_ID_RX_CODEC_DMA_RX_7:
 		cfg_type = AFE_PARAM_ID_CODEC_DMA_CONFIG;
+	case AFE_PORT_ID_USB_RX:
+		cfg_type = AFE_PARAM_ID_USB_AUDIO_CONFIG;
 	break;
 	default:
 		dev_err(dev, "Invalid port id 0x%x\n", port_id);
diff --git a/sound/soc/qcom/qdsp6/q6afe.h b/sound/soc/qcom/qdsp6/q6afe.h
index 30fd77e2f458..88550a08e57d 100644
--- a/sound/soc/qcom/qdsp6/q6afe.h
+++ b/sound/soc/qcom/qdsp6/q6afe.h
@@ -5,7 +5,7 @@
 
 #include <dt-bindings/sound/qcom,q6afe.h>
 
-#define AFE_PORT_MAX		129
+#define AFE_PORT_MAX		130
 
 #define MSM_AFE_PORT_TYPE_RX 0
 #define MSM_AFE_PORT_TYPE_TX 1
@@ -205,6 +205,47 @@ struct q6afe_cdc_dma_cfg {
 	u16	active_channels_mask;
 };
 
+/**
+ * struct q6afe_usb_cfg
+ * @cfg_minor_version: Minor version used for tracking USB audio device
+ * configuration.
+ * Supported values:
+ *     AFE_API_MINOR_VERSION_USB_AUDIO_CONFIG
+ * @sample_rate: Sampling rate of the port
+ *    Supported values:
+ *      AFE_PORT_SAMPLE_RATE_8K
+ *      AFE_PORT_SAMPLE_RATE_11025
+ *      AFE_PORT_SAMPLE_RATE_12K
+ *      AFE_PORT_SAMPLE_RATE_16K
+ *      AFE_PORT_SAMPLE_RATE_22050
+ *      AFE_PORT_SAMPLE_RATE_24K
+ *      AFE_PORT_SAMPLE_RATE_32K
+ *      AFE_PORT_SAMPLE_RATE_44P1K
+ *      AFE_PORT_SAMPLE_RATE_48K
+ *      AFE_PORT_SAMPLE_RATE_96K
+ *      AFE_PORT_SAMPLE_RATE_192K
+ * @bit_width: Bit width of the sample.
+ *    Supported values: 16, 24
+ * @num_channels: Number of channels
+ *    Supported values: 1, 2
+ * @data_format: Data format supported by the USB
+ *    Supported values: 0
+ * @reserved: this field must be 0
+ * @dev_token: device token of actual end USB aduio device
+ * @endian: endianness of this interface
+ * @service_interval: service interval
+ **/
+struct q6afe_usb_cfg {
+	u32	cfg_minor_version;
+	u32     sample_rate;
+	u16	bit_width;
+	u16	num_channels;
+	u16	data_format;
+	u16	reserved;
+	u32	dev_token;
+	u32	endian;
+	u32	service_interval;
+};
 
 struct q6afe_port_config {
 	struct q6afe_hdmi_cfg hdmi;
@@ -212,6 +253,7 @@ struct q6afe_port_config {
 	struct q6afe_i2s_cfg i2s_cfg;
 	struct q6afe_tdm_cfg tdm;
 	struct q6afe_cdc_dma_cfg dma_cfg;
+	struct q6afe_usb_cfg usb_audio;
 };
 
 struct q6afe_port;
@@ -221,6 +263,8 @@ int q6afe_port_start(struct q6afe_port *port);
 int q6afe_port_stop(struct q6afe_port *port);
 void q6afe_port_put(struct q6afe_port *port);
 int q6afe_get_port_id(int index);
+void q6afe_usb_port_prepare(struct q6afe_port *port,
+			     struct q6afe_usb_cfg *cfg);
 void q6afe_hdmi_port_prepare(struct q6afe_port *port,
 			    struct q6afe_hdmi_cfg *cfg);
 void q6afe_slim_port_prepare(struct q6afe_port *port,
diff --git a/sound/soc/qcom/qdsp6/q6dsp-lpass-ports.c b/sound/soc/qcom/qdsp6/q6dsp-lpass-ports.c
index f67c16fd90b9..39719c3f1767 100644
--- a/sound/soc/qcom/qdsp6/q6dsp-lpass-ports.c
+++ b/sound/soc/qcom/qdsp6/q6dsp-lpass-ports.c
@@ -81,6 +81,26 @@
 
 
 static struct snd_soc_dai_driver q6dsp_audio_fe_dais[] = {
+	{
+		.playback = {
+			.stream_name = "USB Playback",
+			.rates = SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |
+					SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 |
+					SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 |
+					SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_96000 |
+					SNDRV_PCM_RATE_192000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S16_BE |
+					SNDRV_PCM_FMTBIT_U16_LE | SNDRV_PCM_FMTBIT_U16_BE |
+					SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S24_BE |
+					SNDRV_PCM_FMTBIT_U24_LE | SNDRV_PCM_FMTBIT_U24_BE,
+			.channels_min = 1,
+			.channels_max = 2,
+			.rate_min =	8000,
+			.rate_max = 192000,
+		},
+		.id = USB_RX,
+		.name = "USB_RX",
+	},
 	{
 		.playback = {
 			.stream_name = "HDMI Playback",
@@ -616,6 +636,9 @@ struct snd_soc_dai_driver *q6dsp_audio_ports_set_config(struct device *dev,
 		case WSA_CODEC_DMA_RX_0 ... RX_CODEC_DMA_RX_7:
 			q6dsp_audio_fe_dais[i].ops = cfg->q6dma_ops;
 			break;
+		case USB_RX:
+			q6dsp_audio_fe_dais[i].ops = cfg->q6usb_ops;
+			break;
 		default:
 			break;
 		}
diff --git a/sound/soc/qcom/qdsp6/q6dsp-lpass-ports.h b/sound/soc/qcom/qdsp6/q6dsp-lpass-ports.h
index 7f052c8a1257..d8dde6dd0aca 100644
--- a/sound/soc/qcom/qdsp6/q6dsp-lpass-ports.h
+++ b/sound/soc/qcom/qdsp6/q6dsp-lpass-ports.h
@@ -11,6 +11,7 @@ struct q6dsp_audio_port_dai_driver_config {
 	const struct snd_soc_dai_ops *q6i2s_ops;
 	const struct snd_soc_dai_ops *q6tdm_ops;
 	const struct snd_soc_dai_ops *q6dma_ops;
+	const struct snd_soc_dai_ops *q6usb_ops;
 };
 
 struct snd_soc_dai_driver *q6dsp_audio_ports_set_config(struct device *dev,
diff --git a/sound/soc/qcom/qdsp6/q6routing.c b/sound/soc/qcom/qdsp6/q6routing.c
index 928fd23e2c27..683ae2ae8e50 100644
--- a/sound/soc/qcom/qdsp6/q6routing.c
+++ b/sound/soc/qcom/qdsp6/q6routing.c
@@ -514,6 +514,9 @@ static int msm_routing_put_audio_mixer(struct snd_kcontrol *kcontrol,
 	return 1;
 }
 
+static const struct snd_kcontrol_new usb_mixer_controls[] = {
+	Q6ROUTING_RX_MIXERS(USB_RX) };
+
 static const struct snd_kcontrol_new hdmi_mixer_controls[] = {
 	Q6ROUTING_RX_MIXERS(HDMI_RX) };
 
@@ -733,6 +736,10 @@ static const struct snd_kcontrol_new mmul8_mixer_controls[] = {
 
 static const struct snd_soc_dapm_widget msm_qdsp6_widgets[] = {
 	/* Mixer definitions */
+	SND_SOC_DAPM_MIXER("USB Mixer", SND_SOC_NOPM, 0, 0,
+			   usb_mixer_controls,
+			   ARRAY_SIZE(usb_mixer_controls)),
+
 	SND_SOC_DAPM_MIXER("HDMI Mixer", SND_SOC_NOPM, 0, 0,
 			   hdmi_mixer_controls,
 			   ARRAY_SIZE(hdmi_mixer_controls)),
@@ -952,6 +959,7 @@ static const struct snd_soc_dapm_widget msm_qdsp6_widgets[] = {
 };
 
 static const struct snd_soc_dapm_route intercon[] = {
+	Q6ROUTING_RX_DAPM_ROUTE("USB Mixer", "USB_RX"),
 	Q6ROUTING_RX_DAPM_ROUTE("HDMI Mixer", "HDMI_RX"),
 	Q6ROUTING_RX_DAPM_ROUTE("DISPLAY_PORT_RX Audio Mixer",
 				"DISPLAY_PORT_RX"),
