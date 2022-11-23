Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E96636650
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 17:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239200AbiKWQ63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 11:58:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238552AbiKWQ6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 11:58:20 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05901D32B
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 08:58:19 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ANFXqhH006843;
        Wed, 23 Nov 2022 10:58:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=h6RfvX774aia7JX50zH3ODFQb8VZzmsKWXVtJMdQgIk=;
 b=VXbQ8tsenmwlYB1tA4hCBFRT6LaPRR2H+y5KFKl4j6wUQ569xomIUt4Uh7krNpAnMLjS
 ZWBFFmXa6ltDcUv/FItmlux3m0iTaDuqSS2o2lZ33TORSR3tmEK8kloCtm+7xUqKX6Cd
 FbQX3obbsmq01zGkqNW4yjfYBVhuuDFzWPOYq7kj03Um+kIpfbEJ2V7hVKU79VUxqYv1
 c0IdEQG6SA/KIBCn81+bi35oad5mUG/dkU/IOwA8C7bRHGFV1HIHpm5akAB3kuneWfBw
 8emRISR7Do1wx3oTQ4gtm9H1GZF+65D9emD+K8NpKHX2kNSmmmo0BtvTNrN/tlBsEQcP eg== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3kxwe6w535-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Nov 2022 10:58:14 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.20; Wed, 23 Nov
 2022 10:58:11 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.20 via Frontend
 Transport; Wed, 23 Nov 2022 10:58:11 -0600
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.111])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 7DF03477;
        Wed, 23 Nov 2022 16:58:11 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v2 2/2] ASoC: wm_adsp: Return whether changed when writing controls
Date:   Wed, 23 Nov 2022 16:58:11 +0000
Message-ID: <20221123165811.3014472-3-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221123165811.3014472-1-rf@opensource.cirrus.com>
References: <20221123165811.3014472-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: fCV41dzgLXv_ENcHJf7fsGestb3xhgUU
X-Proofpoint-GUID: fCV41dzgLXv_ENcHJf7fsGestb3xhgUU
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Simon Trimmer <simont@opensource.cirrus.com>

Functions that update cs_dsp controls need to handle return codes that
indicate whether the control value changed. A return code of 1 indicates
a change, 0 indicates no-change and a negative value is an error
condition.

Acked controls implicitly change value when written so a successful
write shall always report that the value changed.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 34a94b011518..02fbffd73853 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -19,6 +19,7 @@
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
+#include <linux/vmalloc.h>
 #include <linux/workqueue.h>
 #include <linux/debugfs.h>
 #include <sound/core.h>
@@ -419,16 +420,21 @@ static int wm_coeff_tlv_put(struct snd_kcontrol *kctl,
 		(struct soc_bytes_ext *)kctl->private_value;
 	struct wm_coeff_ctl *ctl = bytes_ext_to_ctl(bytes_ext);
 	struct cs_dsp_coeff_ctl *cs_ctl = ctl->cs_ctl;
+	void *scratch;
 	int ret = 0;
 
-	mutex_lock(&cs_ctl->dsp->pwr_lock);
+	scratch = vmalloc(size);
+	if (!scratch)
+		return -ENOMEM;
 
-	if (copy_from_user(cs_ctl->cache, bytes, size))
+	if (copy_from_user(scratch, bytes, size)) {
 		ret = -EFAULT;
-	else
-		ret = cs_dsp_coeff_write_ctrl(cs_ctl, 0, cs_ctl->cache, size);
-
-	mutex_unlock(&cs_ctl->dsp->pwr_lock);
+	} else {
+		mutex_lock(&cs_ctl->dsp->pwr_lock);
+		ret = cs_dsp_coeff_write_ctrl(cs_ctl, 0, scratch, size);
+		mutex_unlock(&cs_ctl->dsp->pwr_lock);
+	}
+	vfree(scratch);
 
 	return ret;
 }
@@ -455,7 +461,10 @@ static int wm_coeff_put_acked(struct snd_kcontrol *kctl,
 
 	mutex_unlock(&cs_ctl->dsp->pwr_lock);
 
-	return ret;
+	if (ret < 0)
+		return ret;
+
+	return 1;
 }
 
 static int wm_coeff_get(struct snd_kcontrol *kctl,
@@ -682,10 +691,10 @@ int wm_adsp_write_ctl(struct wm_adsp *dsp, const char *name, int type,
 	int ret;
 
 	ret = cs_dsp_coeff_write_ctrl(cs_ctl, 0, buf, len);
-	if (ret)
+	if (ret < 0)
 		return ret;
 
-	if (cs_ctl->flags & WMFW_CTL_FLAG_SYS)
+	if (ret == 0 || (cs_ctl->flags & WMFW_CTL_FLAG_SYS))
 		return 0;
 
 	ctl = cs_ctl->priv;
-- 
2.30.2

