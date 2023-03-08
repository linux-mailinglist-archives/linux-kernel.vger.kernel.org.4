Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803976B172F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 00:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjCHX7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 18:59:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjCHX6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 18:58:32 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DE47BA2C;
        Wed,  8 Mar 2023 15:58:30 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 328JnHcS031594;
        Wed, 8 Mar 2023 23:58:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=ekKa9TYUeoAxY2Zr4eJ5jk3LwrQiD85w586qCAoUxq0=;
 b=jjH1ocfRuxLE2siNXw7aNqKkt+LSnCBnQjrhX4ZwPvQKYzXqD8fLL3HQLJ6ya/P6aW/p
 bURSwE86J9KEp6YCqZCKBqCzSb6ZZtuiiuPhpQtIJt0OMTVGYf2MtBhom8xR0bm3NnN5
 Fh5VLtiugFiatRS1XocN2g7g+XZVP4iiJjcMyxMB0mjqqXzs0lfcZq3skyL3Y3PK1H9d
 EdSeJo5BdzTXlR1uOYWnC6ynVi0mZNc9DR2qmZEe7Lehe+kJaBoM8T+m/HFBn0H+R0P1
 351Hf0x6VnDKgnzBdO0LkpqkvGiNfGrWHsGfm14ducKI7stH8VPCGlL9maAehQdnNwG1 wA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p6vnah88q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 23:58:13 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 328NwCK0016305
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 8 Mar 2023 23:58:12 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 8 Mar 2023 15:58:11 -0800
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <agross@kernel.org>,
        <Thinh.Nguyen@synopsys.com>, <bgoswami@quicinc.com>,
        <andersson@kernel.org>, <robh+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <tiwai@suse.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <quic_jackp@quicinc.com>,
        <quic_plai@quicinc.com>, Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH v3 24/28] sound: soc: qdsp6: Add SND kcontrol to select offload device
Date:   Wed, 8 Mar 2023 15:57:47 -0800
Message-ID: <20230308235751.495-25-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230308235751.495-1-quic_wcheng@quicinc.com>
References: <20230308235751.495-1-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: AIZ3BOmsVMlRJgjxtVRLQ5UuSwO9_f5H
X-Proofpoint-ORIG-GUID: AIZ3BOmsVMlRJgjxtVRLQ5UuSwO9_f5H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_15,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 spamscore=0 clxscore=1015 mlxlogscore=999 impostorscore=0 mlxscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303080200
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose a kcontrol on the platform sound card, which will allow for
userspace to determine which USB card number and PCM device to offload.
This allows for userspace to potentially tag an alternate path for a
specific USB SND card and PCM device.  Previously, control was absent, and
the offload path would be enabled on the last USB SND device which was
connected.  This logic will continue to be applicable if no mixer input is
received for specific device selection.

An example to configure the offload device using tinymix:
tinymix -D 0 set 'Q6USB offload SND device select' 1 0

The above will set the Q6AFE device token to choose offload on card#1 and
pcm#0.  Device selection is made possible by setting the Q6AFE device
token.  The audio DSP utilizes this parameter, and will pass this field
back to the USB offload driver within the QMI stream requests.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 sound/soc/qcom/qdsp6/q6usb.c | 126 ++++++++++++++++++++++++++++++++++-
 1 file changed, 123 insertions(+), 3 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6usb.c b/sound/soc/qcom/qdsp6/q6usb.c
index 0dadc92b583f..55f9bcd928f3 100644
--- a/sound/soc/qcom/qdsp6/q6usb.c
+++ b/sound/soc/qcom/qdsp6/q6usb.c
@@ -14,6 +14,7 @@
 #include <linux/dma-map-ops.h>
 
 #include <sound/pcm.h>
+#include <sound/control.h>
 #include <sound/soc.h>
 #include <sound/soc-usb.h>
 #include <sound/pcm_params.h>
@@ -35,9 +36,12 @@ struct q6usb_port_data {
 	struct q6afe_usb_cfg usb_cfg;
 	struct snd_soc_usb *usb;
 	struct q6usb_offload priv;
+	struct mutex mutex;
 	unsigned long available_card_slot;
 	struct q6usb_status status[SNDRV_CARDS];
-	int active_idx;
+	bool idx_valid;
+	int sel_card_idx;
+	int sel_pcm_idx;
 };
 
 static const struct snd_soc_dapm_widget q6usb_dai_widgets[] = {
@@ -53,10 +57,36 @@ static int q6usb_hw_params(struct snd_pcm_substream *substream,
 			   struct snd_soc_dai *dai)
 {
 	struct q6usb_port_data *data = dev_get_drvdata(dai->dev);
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
+	struct q6afe_port *q6usb_afe;
 	int direction = substream->stream;
+	int chip_idx;
+	int ret;
+
+	mutex_lock(&data->mutex);
+	chip_idx = data->status[data->sel_card_idx].chip_index;
+
+	ret = snd_soc_usb_find_format(chip_idx, params, direction);
+	if (ret < 0)
+		goto out;
+
+	q6usb_afe = q6afe_port_get_from_id(cpu_dai->dev, USB_RX);
+	if (IS_ERR(q6usb_afe))
+		goto out;
+
+	ret = afe_port_send_usb_dev_param(q6usb_afe, data->sel_card_idx,
+						data->sel_pcm_idx);
+	if (ret < 0)
+		goto out;
+
+	data->status[data->sel_card_idx].pcm_index = data->sel_pcm_idx;
+out:
+	mutex_unlock(&data->mutex);
 
-	return snd_soc_usb_find_format(data->active_idx, params, direction);
+	return ret;
 }
+
 static const struct snd_soc_dai_ops q6usb_ops = {
 	.hw_params = q6usb_hw_params,
 };
@@ -85,6 +115,89 @@ static struct snd_soc_dai_driver q6usb_be_dais[] = {
 	},
 };
 
+static int q6usb_get_offload_dev(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+	struct q6usb_port_data *data = dev_get_drvdata(component->dev);
+	int pcm_idx;
+	int card_idx;
+
+	mutex_lock(&data->mutex);
+	if (!data->idx_valid) {
+		card_idx = -1;
+		pcm_idx = -1;
+	} else {
+		card_idx = data->sel_card_idx;
+		pcm_idx = data->sel_pcm_idx;
+	}
+
+	ucontrol->value.integer.value[0] = card_idx;
+	ucontrol->value.integer.value[1] = pcm_idx;
+	mutex_unlock(&data->mutex);
+
+	return 0;
+}
+
+static int q6usb_put_offload_dev(struct snd_kcontrol *kcontrol,
+			      struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+	struct q6usb_port_data *data = dev_get_drvdata(component->dev);
+	int changed = 0;
+	int pcmidx;
+	int cardidx;
+
+	cardidx = ucontrol->value.integer.value[0];
+	pcmidx = ucontrol->value.integer.value[1];
+
+	mutex_lock(&data->mutex);
+	if ((cardidx >= 0 && test_bit(cardidx, &data->available_card_slot))) {
+		data->sel_card_idx = cardidx;
+		changed = 1;
+	}
+
+	if ((pcmidx >= 0 && pcmidx < data->status[cardidx].num_pcm)) {
+		data->sel_pcm_idx = pcmidx;
+		data->idx_valid = true;
+		changed = 1;
+	}
+	mutex_unlock(&data->mutex);
+
+	return changed;
+}
+
+static int q6usb_offload_dev_info(struct snd_kcontrol *kcontrol,
+			      struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 2;
+	uinfo->value.integer.min = -1;
+	uinfo->value.integer.max = SNDRV_CARDS;
+
+	return 0;
+}
+
+static const struct snd_kcontrol_new q6usb_offload_dev_ctrl = {
+	.iface = SNDRV_CTL_ELEM_IFACE_CARD,
+	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	.name = "Q6USB offload SND device select",
+	.info = q6usb_offload_dev_info,
+	.get = q6usb_get_offload_dev,
+	.put = q6usb_put_offload_dev,
+};
+
+/* Build a mixer control for a UAC connector control (jack-detect) */
+static void q6usb_connector_control_init(struct snd_soc_component *component)
+{
+	int ret;
+
+	ret = snd_ctl_add(component->card->snd_card,
+				snd_ctl_new1(&q6usb_offload_dev_ctrl, component));
+	if (ret < 0)
+		return;
+}
+
 static int q6usb_audio_ports_of_xlate_dai_name(struct snd_soc_component *component,
 					const struct of_phandle_args *args,
 					const char **dai_name)
@@ -113,10 +226,12 @@ static int q6usb_alsa_connection_cb(struct snd_soc_usb *usb, int card_idx,
 	dapm = snd_soc_component_get_dapm(usb->component);
 	data = dev_get_drvdata(usb->component->dev);
 
+	mutex_lock(&data->mutex);
 	if (connected) {
 		snd_soc_dapm_enable_pin(dapm, "USB_RX_BE");
 		/* We only track the latest USB headset plugged in */
-		data->active_idx = card_idx;
+		if (!data->idx_valid || data->sel_card_idx < 0)
+			data->sel_card_idx = card_idx;
 
 		set_bit(card_idx, &data->available_card_slot);
 		data->status[card_idx].num_pcm = num_pcm;
@@ -129,6 +244,7 @@ static int q6usb_alsa_connection_cb(struct snd_soc_usb *usb, int card_idx,
 			snd_soc_dapm_disable_pin(dapm, "USB_RX_BE");
 	}
 	snd_soc_dapm_sync(dapm);
+	mutex_unlock(&data->mutex);
 
 	return 0;
 }
@@ -141,6 +257,8 @@ static int q6usb_component_probe(struct snd_soc_component *component)
 	snd_soc_dapm_disable_pin(dapm, "USB_RX_BE");
 	snd_soc_dapm_sync(dapm);
 
+	q6usb_connector_control_init(component);
+
 	data->usb = snd_soc_usb_add_port(component->dev, &data->priv, q6usb_alsa_connection_cb);
 	if (IS_ERR(data->usb)) {
 		dev_err(component->dev, "failed to add usb port\n");
@@ -189,6 +307,8 @@ static int q6usb_dai_dev_probe(struct platform_device *pdev)
 
 	data->priv.domain = iommu_get_domain_for_dev(&pdev->dev);
 
+	mutex_init(&data->mutex);
+
 	data->priv.dev = dev;
 	dev_set_drvdata(dev, data);
 
