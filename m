Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB1C67C331
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 04:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236151AbjAZDPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 22:15:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236141AbjAZDPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 22:15:39 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8415A65F33;
        Wed, 25 Jan 2023 19:15:07 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30Q2va2S018786;
        Thu, 26 Jan 2023 03:14:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=/Ys3+vP/SR8aiAN4HzahjXM1RRlJ/QH4E8Ntv69ejEQ=;
 b=ELmmCvDZ9+WCF14SiSiDuH5RQ1Z7hn8gSHVnFvAT5JbLuVtHFSJ48UZLWZ2MvP0HHRxd
 2SXmOPQWAEVVRtX9bBs9rNkIfI7ieiRMvy7ovuuYQ+sUlFG0NRC3NYEbaxAqzh2XEtgf
 7/4dILqIlWMQ3VmgJnHt5RVFuAmJP1V64A0/hFldVGgCctpaEiD+B+tGmdc5YNAVA4UH
 0LX80m++RpHzb8QyzLhOXaKv0Xigt8CriJb44ku+56Ik8A6Ew2ID/ZV9eQ5UGtgbXeJ9
 8VjrNc+cc9UddSguQZHCt3EwpXHwxmd0gJv/5A1jHYqHywsAAiMATByPbC+/wqRGYEk7 HQ== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nbd7arbm9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 03:14:49 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30Q3EmJM031672
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 03:14:48 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 25 Jan 2023 19:14:47 -0800
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
Subject: [RFC PATCH v2 17/22] sound: usb: card: Check for support for requested audio format
Date:   Wed, 25 Jan 2023 19:14:19 -0800
Message-ID: <20230126031424.14582-18-quic_wcheng@quicinc.com>
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
X-Proofpoint-ORIG-GUID: w3DrZv4JekBRL12Ama70yMbCy-AyGu0X
X-Proofpoint-GUID: w3DrZv4JekBRL12Ama70yMbCy-AyGu0X
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

Allow for checks on a specific USB audio device to see if a requested PCM
format is supported.  This is needed for support for when playback is
initiated by the ASoC USB backend path.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 sound/usb/card.c | 28 ++++++++++++++++++++++++++++
 sound/usb/card.h |  8 ++++++++
 2 files changed, 36 insertions(+)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 59be5f543315..be06d19ee935 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -136,6 +136,34 @@ int snd_usb_unregister_platform_ops(void)
 }
 EXPORT_SYMBOL_GPL(snd_usb_unregister_platform_ops);
 
+struct snd_usb_stream *snd_usb_find_suppported_substream(int card_idx,
+			struct snd_pcm_hw_params *params, int direction)
+{
+	struct snd_usb_audio *chip = usb_chip[card_idx];
+	struct snd_usb_substream *subs = NULL;
+	struct snd_usb_stream *as;
+	const struct audioformat *fmt;
+
+	if (!chip)
+		return NULL;
+
+	mutex_lock(&chip->mutex);
+	if (enable[card_idx]) {
+		list_for_each_entry(as, &chip->pcm_list, list) {
+			subs = &as->substream[direction];
+			fmt = find_substream_format(subs, params);
+			if (fmt) {
+				mutex_unlock(&chip->mutex);
+				return as;
+			}
+		}
+	}
+	mutex_unlock(&chip->mutex);
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(snd_usb_find_suppported_substream);
+
 /*
  * disconnect streams
  * called from usb_audio_disconnect()
diff --git a/sound/usb/card.h b/sound/usb/card.h
index 2249c411c3a1..410a4ffad98e 100644
--- a/sound/usb/card.h
+++ b/sound/usb/card.h
@@ -215,6 +215,8 @@ struct snd_usb_platform_ops {
 #if IS_ENABLED(CONFIG_SND_USB_AUDIO)
 int snd_usb_register_platform_ops(struct snd_usb_platform_ops *ops);
 int snd_usb_unregister_platform_ops(void);
+struct snd_usb_stream *snd_usb_find_suppported_substream(int card_idx,
+			struct snd_pcm_hw_params *params, int direction);
 #else
 int snd_usb_register_platform_ops(struct snd_usb_platform_ops *ops)
 {
@@ -225,5 +227,11 @@ int snd_usb_unregister_platform_ops(void)
 {
 	return -EOPNOTSUPP;
 }
+
+struct snd_usb_stream *snd_usb_find_suppported_substream(int card_idx,
+			struct snd_pcm_hw_params *params, int direction)
+{
+	return NULL;
+}
 #endif /* IS_ENABLED(CONFIG_SND_USB_AUDIO) */
 #endif /* __USBAUDIO_CARD_H */
