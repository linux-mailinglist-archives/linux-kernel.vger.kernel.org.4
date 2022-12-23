Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245FF655634
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 00:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbiLWXeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 18:34:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbiLWXdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 18:33:14 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003FF1144B;
        Fri, 23 Dec 2022 15:33:13 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BNNT8Fv016249;
        Fri, 23 Dec 2022 23:32:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=HcJRJO3bS0aEzBawFv2YTqL9+yT53g5gAXCz77w7QI8=;
 b=jhWHnJXAPUQmenQqF51zAIf94LHxSlYeWFVQN6A+M2LoYdt4ONYk9qsBVMZW9YlzNaZx
 WoWMB6P22H4y3GWQad8WiYI5grwIJW0HToxl8RAku4RJxoBzyZVKyPEw6X67/biDDAsC
 xwdZiz+tT/eewKkPGpuAzN6gxchfb/q2r3aUpg5KLMQYLQUWREtBqgUm/V10cpP2B5B9
 +baPzhlwkRzcRIOUSySY4bkIL0ZDRmtM/N+/kWYbeKm/s6nHZ84UffIk1AV7hymy6n0Y
 p7mXB9wTcEIcRroK+xwQieuwTRTQhfAUvY1sLiMpdh6KaTBnhmCwvk6zQIGPGlkLKg27 pg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mm8x4n4ex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Dec 2022 23:32:46 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BNNWjs5009841
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Dec 2022 23:32:45 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 23 Dec 2022 15:32:44 -0800
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <andersson@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <gregkh@linuxfoundation.org>, <Thinh.Nguyen@synopsys.com>,
        <bgoswami@quicinc.com>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <agross@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <quic_jackp@quicinc.com>,
        <quic_plai@quicinc.com>, Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [RFC PATCH 05/14] sound: usb: Export USB SND APIs for modules
Date:   Fri, 23 Dec 2022 15:31:51 -0800
Message-ID: <20221223233200.26089-6-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221223233200.26089-1-quic_wcheng@quicinc.com>
References: <20221223233200.26089-1-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: lWD0lW3dlx79i52S_coF9PjwJhGmksbZ
X-Proofpoint-ORIG-GUID: lWD0lW3dlx79i52S_coF9PjwJhGmksbZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-23_08,2022-12-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 suspectscore=0 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212230197
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some vendor modules will utilize useful parsing and endpoint management
APIs to start audio playback/capture.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 sound/usb/card.c     |  2 ++
 sound/usb/endpoint.c |  2 ++
 sound/usb/helper.c   |  1 +
 sound/usb/pcm.c      |  9 ++++++---
 sound/usb/pcm.h      | 12 ++++++++++++
 5 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 212f55a7683c..396e5a34e23b 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -1068,6 +1068,7 @@ int snd_usb_autoresume(struct snd_usb_audio *chip)
 	}
 	return 0;
 }
+EXPORT_SYMBOL(snd_usb_autoresume);
 
 void snd_usb_autosuspend(struct snd_usb_audio *chip)
 {
@@ -1081,6 +1082,7 @@ void snd_usb_autosuspend(struct snd_usb_audio *chip)
 	for (i = 0; i < chip->num_interfaces; i++)
 		usb_autopm_put_interface(chip->intf[i]);
 }
+EXPORT_SYMBOL(snd_usb_autosuspend);
 
 static int usb_audio_suspend(struct usb_interface *intf, pm_message_t message)
 {
diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 310cd6fb0038..1663f9e9cb4b 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -858,6 +858,7 @@ snd_usb_endpoint_open(struct snd_usb_audio *chip,
 	mutex_unlock(&chip->mutex);
 	return ep;
 }
+EXPORT_SYMBOL_GPL(snd_usb_endpoint_open);
 
 /*
  * snd_usb_endpoint_set_sync: Link data and sync endpoints
@@ -1525,6 +1526,7 @@ int snd_usb_endpoint_get_clock_rate(struct snd_usb_audio *chip, int clock)
 	mutex_unlock(&chip->mutex);
 	return rate;
 }
+EXPORT_SYMBOL(snd_usb_endpoint_prepare);
 
 /**
  * snd_usb_endpoint_start: start an snd_usb_endpoint
diff --git a/sound/usb/helper.c b/sound/usb/helper.c
index a4410267bf70..b4ed9ef3eeb3 100644
--- a/sound/usb/helper.c
+++ b/sound/usb/helper.c
@@ -62,6 +62,7 @@ void *snd_usb_find_csint_desc(void *buffer, int buflen, void *after, u8 dsubtype
 	}
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(snd_usb_find_csint_desc);
 
 /*
  * Wrapper for usb_control_msg().
diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 8ed165f036a0..624f555c6657 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -87,7 +87,7 @@ static snd_pcm_uframes_t snd_usb_pcm_pointer(struct snd_pcm_substream *substream
 /*
  * find a matching audio format
  */
-static const struct audioformat *
+const struct audioformat *
 find_format(struct list_head *fmt_list_head, snd_pcm_format_t format,
 	    unsigned int rate, unsigned int channels, bool strict_match,
 	    struct snd_usb_substream *subs)
@@ -147,8 +147,9 @@ find_format(struct list_head *fmt_list_head, snd_pcm_format_t format,
 	}
 	return found;
 }
+EXPORT_SYMBOL(find_format);
 
-static const struct audioformat *
+const struct audioformat *
 find_substream_format(struct snd_usb_substream *subs,
 		      const struct snd_pcm_hw_params *params)
 {
@@ -156,6 +157,7 @@ find_substream_format(struct snd_usb_substream *subs,
 			   params_rate(params), params_channels(params),
 			   true, subs);
 }
+EXPORT_SYMBOL(find_substream_format);
 
 static int init_pitch_v1(struct snd_usb_audio *chip, int ep)
 {
@@ -418,7 +420,7 @@ int snd_usb_pcm_resume(struct snd_usb_stream *as)
 	return 0;
 }
 
-static void close_endpoints(struct snd_usb_audio *chip,
+void close_endpoints(struct snd_usb_audio *chip,
 			    struct snd_usb_substream *subs)
 {
 	if (subs->data_endpoint) {
@@ -432,6 +434,7 @@ static void close_endpoints(struct snd_usb_audio *chip,
 		subs->sync_endpoint = NULL;
 	}
 }
+EXPORT_SYMBOL(close_endpoints);
 
 /*
  * hw_params callback
diff --git a/sound/usb/pcm.h b/sound/usb/pcm.h
index 493a4e34d78d..43a4a03dfce7 100644
--- a/sound/usb/pcm.h
+++ b/sound/usb/pcm.h
@@ -13,4 +13,16 @@ void snd_usb_preallocate_buffer(struct snd_usb_substream *subs);
 int snd_usb_audioformat_set_sync_ep(struct snd_usb_audio *chip,
 				    struct audioformat *fmt);
 
+void close_endpoints(struct snd_usb_audio *chip,
+			    struct snd_usb_substream *subs);
+int configure_endpoints(struct snd_usb_audio *chip,
+			       struct snd_usb_substream *subs);
+
+const struct audioformat *
+find_format(struct list_head *fmt_list_head, snd_pcm_format_t format,
+	    unsigned int rate, unsigned int channels, bool strict_match,
+	    struct snd_usb_substream *subs);
+const struct audioformat *
+find_substream_format(struct snd_usb_substream *subs,
+		      const struct snd_pcm_hw_params *params);
 #endif /* __USBAUDIO_PCM_H */
