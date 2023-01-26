Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D725B67C35B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 04:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236381AbjAZDQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 22:16:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236373AbjAZDQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 22:16:43 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A3166037;
        Wed, 25 Jan 2023 19:16:05 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30Q30Bfg032691;
        Thu, 26 Jan 2023 03:14:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=Adk1/F5AFhB4MjrOMT9puVK7WazS1Fzr8KJMP5s4uLE=;
 b=XIhaJS5DvRx7iQRXN50Sj4ck+7SoAoCzQOBV1Al0mBlWF6Z8jD4s8zMz+lvKwTzStbXZ
 aK/OMEVkIuPPFUWgqMyWorou9nKl9jF4xUhLjOLPIC1ewAtOJSCJYsUSZzCKj4UPJsL1
 iy6PO2LPLDv9FSIUuwY0TGsbCc13jvDmpIKg/HPvWnpy3NTkZL5V2uKuBJtxRjQJjUyY
 jggG8t5gZGnp41R3bPY/wACjeUl+yvADY6IC2VfIy5jhEX9WceLA2syVu8TDp6OvbsP/
 eSMRJi4Jmu3U2AACSchSXfPpceKHg37sXP/TZ4yotHqv0PNIRwYtWUWQO/XQzGJUxoWL 1Q== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nb0qrsx76-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 03:14:45 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30Q3EiRC031320
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 03:14:44 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 25 Jan 2023 19:14:44 -0800
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
Subject: [RFC PATCH v2 11/22] ASoC: qcom: Add USB backend ASoC driver for Q6
Date:   Wed, 25 Jan 2023 19:14:13 -0800
Message-ID: <20230126031424.14582-12-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230126031424.14582-1-quic_wcheng@quicinc.com>
References: <20230126031424.14582-1-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: p0q8Vl-4EB34Ouuz9Pl0uvLkdIMrHrgi
X-Proofpoint-ORIG-GUID: p0q8Vl-4EB34Ouuz9Pl0uvLkdIMrHrgi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_14,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301260028
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a USB BE component that will register a new USB port to the ASoC USB
framework.  This will handle determination on if the requested audio
profile is supported by the USB device currently selected.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 include/sound/q6usboffload.h  |  20 +++
 sound/soc/qcom/Kconfig        |   4 +
 sound/soc/qcom/qdsp6/Makefile |   1 +
 sound/soc/qcom/qdsp6/q6usb.c  | 231 ++++++++++++++++++++++++++++++++++
 4 files changed, 256 insertions(+)
 create mode 100644 include/sound/q6usboffload.h
 create mode 100644 sound/soc/qcom/qdsp6/q6usb.c

diff --git a/include/sound/q6usboffload.h b/include/sound/q6usboffload.h
new file mode 100644
index 000000000000..e576808901d9
--- /dev/null
+++ b/include/sound/q6usboffload.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * linux/sound/q6usboffload.h -- QDSP6 USB offload
+ *
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+/**
+ * struct q6usb_offload
+ * @dev - dev handle to usb be
+ * @sid - streamID for iommu
+ * @intr_num - usb interrupter number
+ * @domain - allocated iommu domain
+ **/
+struct q6usb_offload {
+	struct device *dev;
+	u32 sid;
+	u32 intr_num;
+	struct iommu_domain *domain;
+};
diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 8c7398bc1ca8..d65c365116e5 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -111,6 +111,9 @@ config SND_SOC_QDSP6_APM
 config SND_SOC_QDSP6_PRM_LPASS_CLOCKS
 	tristate
 
+config SND_SOC_QDSP6_USB
+	tristate
+
 config SND_SOC_QDSP6_PRM
 	tristate
 	select SND_SOC_QDSP6_PRM_LPASS_CLOCKS
@@ -131,6 +134,7 @@ config SND_SOC_QDSP6
 	select SND_SOC_TOPOLOGY
 	select SND_SOC_QDSP6_APM
 	select SND_SOC_QDSP6_PRM
+	select SND_SOC_QDSP6_USB
 	help
 	 To add support for MSM QDSP6 Soc Audio.
 	 This will enable sound soc platform specific
diff --git a/sound/soc/qcom/qdsp6/Makefile b/sound/soc/qcom/qdsp6/Makefile
index 3963bf234664..c9457ee898d0 100644
--- a/sound/soc/qcom/qdsp6/Makefile
+++ b/sound/soc/qcom/qdsp6/Makefile
@@ -17,3 +17,4 @@ obj-$(CONFIG_SND_SOC_QDSP6_APM_DAI) += q6apm-dai.o
 obj-$(CONFIG_SND_SOC_QDSP6_APM_LPASS_DAI) += q6apm-lpass-dais.o
 obj-$(CONFIG_SND_SOC_QDSP6_PRM) += q6prm.o
 obj-$(CONFIG_SND_SOC_QDSP6_PRM_LPASS_CLOCKS) += q6prm-clocks.o
+obj-$(CONFIG_SND_SOC_QDSP6_USB) += q6usb.o
diff --git a/sound/soc/qcom/qdsp6/q6usb.c b/sound/soc/qcom/qdsp6/q6usb.c
new file mode 100644
index 000000000000..afbff66108bc
--- /dev/null
+++ b/sound/soc/qcom/qdsp6/q6usb.c
@@ -0,0 +1,231 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/iommu.h>
+#include <linux/dma-mapping.h>
+#include <linux/dma-map-ops.h>
+
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/soc-usb.h>
+#include <sound/pcm_params.h>
+#include <sound/asound.h>
+#include <sound/q6usboffload.h>
+
+#include "q6dsp-lpass-ports.h"
+#include "q6afe.h"
+
+struct q6usb_port_data {
+	struct q6afe_usb_cfg usb_cfg;
+	struct snd_soc_usb *usb;
+	struct q6usb_offload priv;
+	int active_idx;
+};
+
+static const struct snd_soc_dapm_widget q6usb_dai_widgets[] = {
+	SND_SOC_DAPM_HP("USB_RX_BE", NULL),
+};
+
+static const struct snd_soc_dapm_route q6usb_dapm_routes[] = {
+	{"USB Playback", NULL, "USB_RX_BE"},
+};
+
+static int q6usb_hw_params(struct snd_pcm_substream *substream,
+			   struct snd_pcm_hw_params *params,
+			   struct snd_soc_dai *dai)
+{
+	return 0;
+}
+static const struct snd_soc_dai_ops q6usb_ops = {
+	.hw_params = q6usb_hw_params,
+};
+
+static struct snd_soc_dai_driver q6usb_be_dais[] = {
+	{
+		.playback = {
+			.stream_name = "USB BE RX",
+			.rates = SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |
+				SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 |
+				SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 |
+				SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_96000 |
+				SNDRV_PCM_RATE_192000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S16_BE |
+				SNDRV_PCM_FMTBIT_U16_LE | SNDRV_PCM_FMTBIT_U16_BE |
+				SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S24_BE |
+				SNDRV_PCM_FMTBIT_U24_LE | SNDRV_PCM_FMTBIT_U24_BE,
+			.channels_min = 1,
+			.channels_max = 2,
+			.rate_max =     192000,
+			.rate_min =	8000,
+		},
+		.id = USB_RX,
+		.name = "USB_RX_BE",
+		.ops = &q6usb_ops,
+	},
+};
+
+static int q6usb_audio_ports_of_xlate_dai_name(struct snd_soc_component *component,
+					const struct of_phandle_args *args,
+					const char **dai_name)
+{
+	int id = args->args[0];
+	int ret = -EINVAL;
+	int i;
+
+	for (i = 0; i  < ARRAY_SIZE(q6usb_be_dais); i++) {
+		if (q6usb_be_dais[i].id == id) {
+			*dai_name = q6usb_be_dais[i].name;
+			ret = 0;
+			break;
+		}
+	}
+
+	return ret;
+}
+
+static int q6usb_component_probe(struct snd_soc_component *component)
+{
+	struct q6usb_port_data *data = dev_get_drvdata(component->dev);
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
+
+	data->usb->component = component;
+
+	snd_soc_dapm_disable_pin(dapm, "USB_RX_BE");
+	snd_soc_dapm_sync(dapm);
+
+	return 0;
+}
+
+static const struct snd_soc_component_driver q6usb_dai_component = {
+	.probe = q6usb_component_probe,
+	.name = "q6usb-dai-component",
+	.dapm_widgets = q6usb_dai_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(q6usb_dai_widgets),
+	.dapm_routes = q6usb_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(q6usb_dapm_routes),
+	.of_xlate_dai_name = q6usb_audio_ports_of_xlate_dai_name,
+};
+
+static int q6usb_alsa_connection_cb(struct snd_soc_usb *usb, int card_idx,
+			int connected)
+{
+	struct snd_soc_dapm_context *dapm;
+	struct q6usb_port_data *data;
+
+	/* Check if routes to the backend have not yet been established */
+	if (!usb->component)
+		return -ENODEV;
+
+	dapm = snd_soc_component_get_dapm(usb->component);
+	data = dev_get_drvdata(usb->component->dev);
+
+	if (connected) {
+		snd_soc_dapm_enable_pin(dapm, "USB_RX_BE");
+		/* We only track the latest USB headset plugged in */
+		data->active_idx = card_idx;
+	} else {
+		snd_soc_dapm_disable_pin(dapm, "USB_RX_BE");
+	}
+	snd_soc_dapm_sync(dapm);
+
+	return 0;
+}
+
+static int q6usb_dai_dev_probe(struct platform_device *pdev)
+{
+	struct device_node *node = pdev->dev.of_node;
+	struct q6usb_port_data *data;
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	ret = of_property_read_u32(node, "qcom,usb-audio-stream-id",
+				&data->priv.sid);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to read sid.\n");
+		return -ENODEV;
+	}
+
+	ret = of_property_read_u32(node, "qcom,usb-audio-intr-num",
+				&data->priv.intr_num);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to read intr num.\n");
+		return -ENODEV;
+	}
+
+	data->priv.domain = iommu_domain_alloc(pdev->dev.bus);
+	if (!data->priv.domain) {
+		dev_err(&pdev->dev, "failed to allocate iommu domain\n");
+		return -ENODEV;
+	}
+
+	/* attach to external processor iommu */
+	ret = iommu_attach_device(data->priv.domain, &pdev->dev);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to attach device ret = %d\n", ret);
+		goto free_domain;
+	}
+
+	data->usb = snd_soc_usb_add_port(dev, q6usb_alsa_connection_cb);
+	if (IS_ERR(data->usb)) {
+		dev_err(&pdev->dev, "failed to add usb port\n");
+		goto detach_device;
+	}
+
+	data->priv.dev = dev;
+	dev_set_drvdata(dev, data);
+	devm_snd_soc_register_component(dev, &q6usb_dai_component,
+					q6usb_be_dais, ARRAY_SIZE(q6usb_be_dais));
+	snd_soc_usb_set_priv_data(dev, &data->priv);
+
+	return 0;
+
+detach_device:
+	iommu_detach_device(data->priv.domain, &pdev->dev);
+free_domain:
+	iommu_domain_free(data->priv.domain);
+
+	return ret;
+}
+
+static int q6usb_dai_dev_remove(struct platform_device *pdev)
+{
+	struct q6usb_port_data *data = platform_get_drvdata(pdev);
+
+	iommu_detach_device(data->priv.domain, &pdev->dev);
+	iommu_domain_free(data->priv.domain);
+
+	snd_soc_usb_remove_port(&pdev->dev);
+
+	return 0;
+}
+
+static const struct of_device_id q6usb_dai_device_id[] = {
+	{ .compatible = "qcom,q6usb-dais" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, q6usb_dai_device_id);
+
+static struct platform_driver q6usb_dai_platform_driver = {
+	.driver = {
+		.name = "q6usb-dai",
+		.of_match_table = of_match_ptr(q6usb_dai_device_id),
+	},
+	.probe = q6usb_dai_dev_probe,
+	.remove = q6usb_dai_dev_remove,
+};
+module_platform_driver(q6usb_dai_platform_driver);
+
+MODULE_DESCRIPTION("Q6 USB backend dai driver");
+MODULE_LICENSE("GPL");
