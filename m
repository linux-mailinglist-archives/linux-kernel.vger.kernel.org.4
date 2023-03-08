Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A666B16F6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 00:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjCHX6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 18:58:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjCHX61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 18:58:27 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE7F7389D;
        Wed,  8 Mar 2023 15:58:26 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 328NU8pr001869;
        Wed, 8 Mar 2023 23:58:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=5IqGnM08SWxXF8sTW/f2AkAFGv6jdwVbgFkdQ1MxpXU=;
 b=etlWuK2fveX4tXNz7hPxk55tUFawJRbePvAw7MLTiA1GjOY2rToSIssG32McpaykeDzn
 LzSELVHHibPQbVA3zAt0iko/IFWhRYQ0in6g5PpGzl/782MsDrv0wTvXUMTgSsdz/JmH
 TIliUAOizK2/rGDrOa47fDwmiB7slimECBXJkPcFd9fH2GpvWaPFnyySZss1/tJRS4qi
 bivg9N4b+sUuRv6u71OuMNO4vbO9GvUft9uK7I/C+MTe69ikvVvco36IVbNF2F8LmVNM
 IOCfVGEMq6Ri26vjCcMC4NrsbTCz2aMDO2c9j1M925jac/0cS+ZqCGnhnl+yJkwf2xnM 4w== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p6fetu630-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 23:58:12 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 328NwChp015046
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
Subject: [PATCH v3 23/28] sound: Pass USB SND card and PCM information to SOC USB
Date:   Wed, 8 Mar 2023 15:57:46 -0800
Message-ID: <20230308235751.495-24-quic_wcheng@quicinc.com>
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
X-Proofpoint-GUID: aSh3LHz5OMLYWoV0crBRcr6vIp4KYNTZ
X-Proofpoint-ORIG-GUID: aSh3LHz5OMLYWoV0crBRcr6vIp4KYNTZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_15,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 impostorscore=0 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=708
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303080200
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, only the index to the USB SND card array is passed to the USB
backend.  Pass through more information, specifically the USB SND card
number and the number of PCM devices available.  The USB backend should
know about which sound resources are being shared between the ASoC and USB
SND paths.  This can be utilized to properly select and maintain the
offloading devices.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 include/sound/soc-usb.h           |  9 +++++----
 sound/soc/qcom/qdsp6/q6usb.c      | 20 ++++++++++++++++++--
 sound/soc/soc-usb.c               | 12 +++++++-----
 sound/usb/qcom/qc_audio_offload.c |  9 +++++----
 4 files changed, 35 insertions(+), 15 deletions(-)

diff --git a/include/sound/soc-usb.h b/include/sound/soc-usb.h
index 71e6e75e600a..606128332044 100644
--- a/include/sound/soc-usb.h
+++ b/include/sound/soc-usb.h
@@ -19,20 +19,21 @@ struct snd_soc_usb {
 	struct device *dev;
 	struct snd_soc_component *component;
 	int (*connection_status_cb)(struct snd_soc_usb *usb, int card_idx,
-				int connected);
+				int chip_idx, int num_pcm, int connected);
 	void *priv_data;
 };
 
 int snd_soc_usb_find_format(int card_idx, struct snd_pcm_hw_params *params,
 			int direction);
 
-int snd_soc_usb_connect(struct device *usbdev, int card_idx);
-int snd_soc_usb_disconnect(struct device *usbdev);
+int snd_soc_usb_connect(struct device *usbdev, int card_idx, int chip_idx,
+			int num_pcm);
+int snd_soc_usb_disconnect(struct device *usbdev, int card_idx);
 void snd_soc_usb_set_priv_data(struct device *dev, void *priv);
 void *snd_soc_usb_get_priv_data(struct device *usbdev);
 
 struct snd_soc_usb *snd_soc_usb_add_port(struct device *dev, void *priv,
 			int (*connection_cb)(struct snd_soc_usb *usb, int card_idx,
-			int connected));
+			int chip_idx, int num_pcm, int connected));
 int snd_soc_usb_remove_port(struct device *dev);
 #endif
diff --git a/sound/soc/qcom/qdsp6/q6usb.c b/sound/soc/qcom/qdsp6/q6usb.c
index c9d5c9eecf89..0dadc92b583f 100644
--- a/sound/soc/qcom/qdsp6/q6usb.c
+++ b/sound/soc/qcom/qdsp6/q6usb.c
@@ -25,10 +25,18 @@
 
 #define SID_MASK	0xF
 
+struct q6usb_status {
+	unsigned int num_pcm;
+	unsigned int chip_index;
+	unsigned int pcm_index;
+};
+
 struct q6usb_port_data {
 	struct q6afe_usb_cfg usb_cfg;
 	struct snd_soc_usb *usb;
 	struct q6usb_offload priv;
+	unsigned long available_card_slot;
+	struct q6usb_status status[SNDRV_CARDS];
 	int active_idx;
 };
 
@@ -97,7 +105,7 @@ static int q6usb_audio_ports_of_xlate_dai_name(struct snd_soc_component *compone
 }
 
 static int q6usb_alsa_connection_cb(struct snd_soc_usb *usb, int card_idx,
-			int connected)
+			int chip_idx, int num_pcm, int connected)
 {
 	struct snd_soc_dapm_context *dapm;
 	struct q6usb_port_data *data;
@@ -109,8 +117,16 @@ static int q6usb_alsa_connection_cb(struct snd_soc_usb *usb, int card_idx,
 		snd_soc_dapm_enable_pin(dapm, "USB_RX_BE");
 		/* We only track the latest USB headset plugged in */
 		data->active_idx = card_idx;
+
+		set_bit(card_idx, &data->available_card_slot);
+		data->status[card_idx].num_pcm = num_pcm;
+		data->status[card_idx].chip_index = chip_idx;
 	} else {
-		snd_soc_dapm_disable_pin(dapm, "USB_RX_BE");
+		clear_bit(card_idx, &data->available_card_slot);
+		data->status[card_idx].num_pcm = 0;
+		data->status[card_idx].chip_index = 0;
+		if (!data->available_card_slot)
+			snd_soc_dapm_disable_pin(dapm, "USB_RX_BE");
 	}
 	snd_soc_dapm_sync(dapm);
 
diff --git a/sound/soc/soc-usb.c b/sound/soc/soc-usb.c
index cdce1bb42df5..84dc6d0b2eab 100644
--- a/sound/soc/soc-usb.c
+++ b/sound/soc/soc-usb.c
@@ -95,7 +95,7 @@ EXPORT_SYMBOL_GPL(snd_soc_usb_find_format);
  */
 struct snd_soc_usb *snd_soc_usb_add_port(struct device *dev, void *priv,
 			int (*connection_cb)(struct snd_soc_usb *usb, int card_idx,
-			int connected))
+			int chip_idx, int num_pcm, int connected))
 {
 	struct snd_soc_usb *usb;
 
@@ -149,7 +149,8 @@ EXPORT_SYMBOL_GPL(snd_soc_usb_remove_port);
  * handle how the USB backend selects, which device to enable offloading on.
  *
  */
-int snd_soc_usb_connect(struct device *usbdev, int card_idx)
+int snd_soc_usb_connect(struct device *usbdev, int card_idx, int chip_idx,
+			int num_pcm)
 {
 	struct snd_soc_usb *ctx;
 
@@ -161,7 +162,8 @@ int snd_soc_usb_connect(struct device *usbdev, int card_idx)
 		return -ENODEV;
 
 	if (ctx->connection_status_cb)
-		ctx->connection_status_cb(ctx, card_idx, 1);
+		ctx->connection_status_cb(ctx, card_idx, chip_idx,
+						num_pcm, 1);
 
 	return 0;
 }
@@ -174,7 +176,7 @@ EXPORT_SYMBOL_GPL(snd_soc_usb_connect);
  * Notify of a new USB SND device disconnection to the USB backend.
  *
  */
-int snd_soc_usb_disconnect(struct device *usbdev)
+int snd_soc_usb_disconnect(struct device *usbdev, int card_idx)
 {
 	struct snd_soc_usb *ctx;
 
@@ -186,7 +188,7 @@ int snd_soc_usb_disconnect(struct device *usbdev)
 		return -ENODEV;
 
 	if (ctx->connection_status_cb)
-		ctx->connection_status_cb(ctx, -1, 0);
+		ctx->connection_status_cb(ctx, card_idx, 0, 0, 0);
 
 	return 0;
 }
diff --git a/sound/usb/qcom/qc_audio_offload.c b/sound/usb/qcom/qc_audio_offload.c
index 2c8dd5605849..7d6e7f946a47 100644
--- a/sound/usb/qcom/qc_audio_offload.c
+++ b/sound/usb/qcom/qc_audio_offload.c
@@ -1562,7 +1562,8 @@ static void qc_usb_audio_offload_probe(struct snd_usb_audio *chip)
 	uadev[chip->card->number].chip = chip;
 	uaudio_qdev->last_card_num = chip->card->number;
 
-	snd_soc_usb_connect(usb_get_usb_backend(udev), chip->index);
+	snd_soc_usb_connect(usb_get_usb_backend(udev), chip->card->number,
+				chip->index, chip->pcm_devs);
 	mutex_unlock(&chip->mutex);
 }
 
@@ -1649,12 +1650,12 @@ static void qc_usb_audio_offload_disconnect(struct snd_usb_audio *chip)
 	uadev[card_num].chip = NULL;
 	mutex_unlock(&chip->mutex);
 
+	snd_soc_usb_disconnect(usb_get_usb_backend(udev), card_num);
+
 	mutex_lock(&qdev_mutex);
 	atomic_dec(&uaudio_qdev->qdev_in_use);
-	if (!atomic_read(&uaudio_qdev->qdev_in_use)) {
-		snd_soc_usb_disconnect(usb_get_usb_backend(udev));
+	if (!atomic_read(&uaudio_qdev->qdev_in_use))
 		qc_usb_audio_cleanup_qmi_dev();
-	}
 	mutex_unlock(&qdev_mutex);
 }
 
