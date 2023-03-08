Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406746B1747
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 01:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbjCHX7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 18:59:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjCHX6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 18:58:33 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E2C9AFE4;
        Wed,  8 Mar 2023 15:58:32 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 328Nu5fC021365;
        Wed, 8 Mar 2023 23:58:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=f6/qdOtfQVlyOiZpX8BmuHeD3kEeuXSUXzhaZtLvKHg=;
 b=H4AvSNldYgqTWEyo5JrmqtCPFhAps7rRVq1NoUzh7aqoSxTEMDFX1SA0biix90js7vQ2
 gyASAm0hL8YHYmSLQCFbF5VkHaAlXi9BEi5cWVKgEJRolhpH9meldxfG50SFb5P3Iskv
 nDcQguR1N5P1cg6CSZILNmkzEc4LWoao5T8TBLAUS0JCLxyJ9RK9U0S+cB7XikQvr9Sp
 HnwwGQNfKK+lC1R14wbhsoc0GcMUy2vnWk0Hf2xxOLq8mqF9obnkTvfKn2GmTjRjrLgD
 Y5O91dgcYJ+hvreUQX773jChyT9bvPbfwhZpEQN98OilqwDNV4oSDvrH8aK7sREfliLC rQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p6vrms8w9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 23:58:08 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 328Nw74d011942
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 8 Mar 2023 23:58:08 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 8 Mar 2023 15:58:07 -0800
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
Subject: [PATCH v3 10/28] sound: usb: Export USB SND APIs for modules
Date:   Wed, 8 Mar 2023 15:57:33 -0800
Message-ID: <20230308235751.495-11-quic_wcheng@quicinc.com>
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
X-Proofpoint-ORIG-GUID: UZTbXoKlGzwfJz_vBsXLoo3YFbRnCnwO
X-Proofpoint-GUID: UZTbXoKlGzwfJz_vBsXLoo3YFbRnCnwO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_15,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 adultscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303080200
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
index 728c211142d1..fc9ce709412d 100644
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
index 9bcbaa0c0a55..e5d5c0f04c85 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -1077,6 +1077,7 @@ int snd_usb_autoresume(struct snd_usb_audio *chip)
 	}
 	return 0;
 }
+EXPORT_SYMBOL_GPL(snd_usb_autoresume);
 
 void snd_usb_autosuspend(struct snd_usb_audio *chip)
 {
@@ -1090,6 +1091,7 @@ void snd_usb_autosuspend(struct snd_usb_audio *chip)
 	for (i = 0; i < chip->num_interfaces; i++)
 		usb_autopm_put_interface(chip->intf[i]);
 }
+EXPORT_SYMBOL_GPL(snd_usb_autosuspend);
 
 static int usb_audio_suspend(struct usb_interface *intf, pm_message_t message)
 {
diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 419302e2057e..207869dc95f0 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -860,6 +860,7 @@ snd_usb_endpoint_open(struct snd_usb_audio *chip,
 	mutex_unlock(&chip->mutex);
 	return ep;
 }
+EXPORT_SYMBOL_GPL(snd_usb_endpoint_open);
 
 /*
  * snd_usb_endpoint_set_sync: Link data and sync endpoints
@@ -1510,6 +1511,7 @@ int snd_usb_endpoint_prepare(struct snd_usb_audio *chip,
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
index d959da7a1afb..4576a36dc9b2 100644
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
 
 bool snd_usb_pcm_has_fixed_rate(struct snd_usb_substream *subs)
 {
@@ -446,7 +448,7 @@ int snd_usb_pcm_resume(struct snd_usb_stream *as)
 	return 0;
 }
 
-static void close_endpoints(struct snd_usb_audio *chip,
+void close_endpoints(struct snd_usb_audio *chip,
 			    struct snd_usb_substream *subs)
 {
 	if (subs->data_endpoint) {
@@ -460,6 +462,7 @@ static void close_endpoints(struct snd_usb_audio *chip,
 		subs->sync_endpoint = NULL;
 	}
 }
+EXPORT_SYMBOL(close_endpoints);
 
 /*
  * hw_params callback
diff --git a/sound/usb/pcm.h b/sound/usb/pcm.h
index 388fe2ba346d..b5216cb19e75 100644
--- a/sound/usb/pcm.h
+++ b/sound/usb/pcm.h
@@ -15,4 +15,16 @@ void snd_usb_preallocate_buffer(struct snd_usb_substream *subs);
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
