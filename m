Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0BC167C348
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 04:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236354AbjAZDQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 22:16:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236206AbjAZDQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 22:16:12 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF1565F02;
        Wed, 25 Jan 2023 19:15:43 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30Q2va2R018786;
        Thu, 26 Jan 2023 03:14:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=9DUsAREdcbyKkri9QQ9DarmPLi+PaOWxom+nSMkrqB4=;
 b=l6bxJjql0QVnu4oIc6epvCpUIO4hW0Fkzmso0X4dnD83PcPLMT5iJehMQmOgoWp+sYYv
 3x9BFugKqbEY75ymXTYpZ9wjVjAhJQGtqUh6CxEot7gs2IsoV0F1lk30g/AwU5bpofyw
 eAAEjKIoJqFzn2c78bKdONCNDCuL+mFD0U8mww9+YojFlNibwwy4mKT6c/GXSQqC6Ukn
 wGE5zGjJzoJgY1DwF3iNf4DAT2DlwgPCYePFiOIz4U7ki6W+CcJypUIxqr7L6RFHYLCW
 LzpWLduYZUkIVJT3CGQztQsPiIA/dSLjiOlkmKkfbGNBKnz+rxwCMrRSBUSlHBNP1BK2 xQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nbd7arbm7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 03:14:46 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30Q3EjRY011805
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 03:14:45 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 25 Jan 2023 19:14:45 -0800
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
Subject: [RFC PATCH v2 13/22] sound: usb: Export USB SND APIs for modules
Date:   Wed, 25 Jan 2023 19:14:15 -0800
Message-ID: <20230126031424.14582-14-quic_wcheng@quicinc.com>
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
X-Proofpoint-ORIG-GUID: iRx374J8JRqYXE32goI7hpBI2-vZkO0-
X-Proofpoint-GUID: iRx374J8JRqYXE32goI7hpBI2-vZkO0-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_14,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 impostorscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0
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

Some vendor modules will utilize useful parsing and endpoint management
APIs to start audio playback/capture.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 include/sound/pcm_params.h |  4 +++
 sound/core/oss/pcm_oss.c   | 58 ----------------------------------
 sound/core/pcm_lib.c       | 65 ++++++++++++++++++++++++++++++++++++++
 sound/usb/card.c           |  2 ++
 sound/usb/endpoint.c       |  2 ++
 sound/usb/helper.c         |  1 +
 sound/usb/pcm.c            |  9 ++++--
 sound/usb/pcm.h            | 12 +++++++
 8 files changed, 92 insertions(+), 61 deletions(-)

diff --git a/include/sound/pcm_params.h b/include/sound/pcm_params.h
index ba184f49f7e1..407557b72700 100644
--- a/include/sound/pcm_params.h
+++ b/include/sound/pcm_params.h
@@ -17,6 +17,10 @@ int snd_pcm_hw_param_last(struct snd_pcm_substream *pcm,
 			  snd_pcm_hw_param_t var, int *dir);
 int snd_pcm_hw_param_value(const struct snd_pcm_hw_params *params,
 			   snd_pcm_hw_param_t var, int *dir);
+int _snd_pcm_hw_param_set(struct snd_pcm_hw_params *params,
+				 snd_pcm_hw_param_t var, unsigned int val,
+				 int dir);
+int snd_interval_refine_set(struct snd_interval *i, unsigned int val);
 
 #define SNDRV_MASK_BITS	64	/* we use so far 64bits only */
 #define SNDRV_MASK_SIZE	(SNDRV_MASK_BITS / 32)
diff --git a/sound/core/oss/pcm_oss.c b/sound/core/oss/pcm_oss.c
index ac2efeb63a39..eb45e37bb875 100644
--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -103,16 +103,6 @@ static int snd_interval_refine_max(struct snd_interval *i, unsigned int max, int
 	return changed;
 }
 
-static int snd_interval_refine_set(struct snd_interval *i, unsigned int val)
-{
-	struct snd_interval t;
-	t.empty = 0;
-	t.min = t.max = val;
-	t.openmin = t.openmax = 0;
-	t.integer = 1;
-	return snd_interval_refine(i, &t);
-}
-
 /**
  * snd_pcm_hw_param_value_min
  * @params: the hw_params instance
@@ -443,54 +433,6 @@ static int snd_pcm_hw_param_near(struct snd_pcm_substream *pcm,
 	return v;
 }
 
-static int _snd_pcm_hw_param_set(struct snd_pcm_hw_params *params,
-				 snd_pcm_hw_param_t var, unsigned int val,
-				 int dir)
-{
-	int changed;
-	if (hw_is_mask(var)) {
-		struct snd_mask *m = hw_param_mask(params, var);
-		if (val == 0 && dir < 0) {
-			changed = -EINVAL;
-			snd_mask_none(m);
-		} else {
-			if (dir > 0)
-				val++;
-			else if (dir < 0)
-				val--;
-			changed = snd_mask_refine_set(hw_param_mask(params, var), val);
-		}
-	} else if (hw_is_interval(var)) {
-		struct snd_interval *i = hw_param_interval(params, var);
-		if (val == 0 && dir < 0) {
-			changed = -EINVAL;
-			snd_interval_none(i);
-		} else if (dir == 0)
-			changed = snd_interval_refine_set(i, val);
-		else {
-			struct snd_interval t;
-			t.openmin = 1;
-			t.openmax = 1;
-			t.empty = 0;
-			t.integer = 0;
-			if (dir < 0) {
-				t.min = val - 1;
-				t.max = val;
-			} else {
-				t.min = val;
-				t.max = val+1;
-			}
-			changed = snd_interval_refine(i, &t);
-		}
-	} else
-		return -EINVAL;
-	if (changed > 0) {
-		params->cmask |= 1 << var;
-		params->rmask |= 1 << var;
-	}
-	return changed;
-}
-
 /**
  * snd_pcm_hw_param_set
  * @pcm: PCM instance
diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index 8b6aeb8a78f7..8305fd0860ad 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -2532,3 +2532,68 @@ int snd_pcm_add_chmap_ctls(struct snd_pcm *pcm, int stream,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_pcm_add_chmap_ctls);
+
+int snd_interval_refine_set(struct snd_interval *i, unsigned int val)
+{
+	struct snd_interval t;
+
+	t.empty = 0;
+	t.min = t.max = val;
+	t.openmin = t.openmax = 0;
+	t.integer = 1;
+	return snd_interval_refine(i, &t);
+}
+EXPORT_SYMBOL_GPL(snd_interval_refine_set);
+
+int _snd_pcm_hw_param_set(struct snd_pcm_hw_params *params,
+				 snd_pcm_hw_param_t var, unsigned int val,
+				 int dir)
+{
+	int changed;
+
+	if (hw_is_mask(var)) {
+		struct snd_mask *m = hw_param_mask(params, var);
+
+		if (val == 0 && dir < 0) {
+			changed = -EINVAL;
+			snd_mask_none(m);
+		} else {
+			if (dir > 0)
+				val++;
+			else if (dir < 0)
+				val--;
+			changed = snd_mask_refine_set(hw_param_mask(params, var), val);
+		}
+	} else if (hw_is_interval(var)) {
+		struct snd_interval *i = hw_param_interval(params, var);
+
+		if (val == 0 && dir < 0) {
+			changed = -EINVAL;
+			snd_interval_none(i);
+		} else if (dir == 0)
+			changed = snd_interval_refine_set(i, val);
+		else {
+			struct snd_interval t;
+
+			t.openmin = 1;
+			t.openmax = 1;
+			t.empty = 0;
+			t.integer = 0;
+			if (dir < 0) {
+				t.min = val - 1;
+				t.max = val;
+			} else {
+				t.min = val;
+				t.max = val+1;
+			}
+			changed = snd_interval_refine(i, &t);
+		}
+	} else
+		return -EINVAL;
+	if (changed > 0) {
+		params->cmask |= 1 << var;
+		params->rmask |= 1 << var;
+	}
+	return changed;
+}
+EXPORT_SYMBOL_GPL(_snd_pcm_hw_param_set);
diff --git a/sound/usb/card.c b/sound/usb/card.c
index 803230343c16..59be5f543315 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -1071,6 +1071,7 @@ int snd_usb_autoresume(struct snd_usb_audio *chip)
 	}
 	return 0;
 }
+EXPORT_SYMBOL_GPL(snd_usb_autoresume);
 
 void snd_usb_autosuspend(struct snd_usb_audio *chip)
 {
@@ -1084,6 +1085,7 @@ void snd_usb_autosuspend(struct snd_usb_audio *chip)
 	for (i = 0; i < chip->num_interfaces; i++)
 		usb_autopm_put_interface(chip->intf[i]);
 }
+EXPORT_SYMBOL_GPL(snd_usb_autosuspend);
 
 static int usb_audio_suspend(struct usb_interface *intf, pm_message_t message)
 {
diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 310cd6fb0038..25b79c067956 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -858,6 +858,7 @@ snd_usb_endpoint_open(struct snd_usb_audio *chip,
 	mutex_unlock(&chip->mutex);
 	return ep;
 }
+EXPORT_SYMBOL_GPL(snd_usb_endpoint_open);
 
 /*
  * snd_usb_endpoint_set_sync: Link data and sync endpoints
@@ -1506,6 +1507,7 @@ int snd_usb_endpoint_prepare(struct snd_usb_audio *chip,
 	mutex_unlock(&chip->mutex);
 	return err;
 }
+EXPORT_SYMBOL_GPL(snd_usb_endpoint_prepare);
 
 /* get the current rate set to the given clock by any endpoint */
 int snd_usb_endpoint_get_clock_rate(struct snd_usb_audio *chip, int clock)
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
index 8ed165f036a0..0b01a5dfcb73 100644
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
+EXPORT_SYMBOL_GPL(find_format);
 
-static const struct audioformat *
+const struct audioformat *
 find_substream_format(struct snd_usb_substream *subs,
 		      const struct snd_pcm_hw_params *params)
 {
@@ -156,6 +157,7 @@ find_substream_format(struct snd_usb_substream *subs,
 			   params_rate(params), params_channels(params),
 			   true, subs);
 }
+EXPORT_SYMBOL_GPL(find_substream_format);
 
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
