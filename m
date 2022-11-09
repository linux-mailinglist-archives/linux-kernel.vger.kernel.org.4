Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 938EE622B5C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 13:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiKIMRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 07:17:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiKIMRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 07:17:08 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A8A2CE15;
        Wed,  9 Nov 2022 04:17:07 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A9AvsnF002715;
        Wed, 9 Nov 2022 12:17:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=Ku3aHuSCXNzJ/g3mZvPD4pj7e8GKpCA3WSRnajuVM+8=;
 b=pA+1umaGDGAXJu0eLAXm+54y+0Fgtzzs3MZnMQd59oFwdhtJ27qZ8VRuohiQLfqNFiYq
 F2j3XfkwmS1QYO/QUamBHhuW1Z4MfEtem3eRcVdSJoy9SXBn/jIG1QiGM1I4Q+LEKgJw
 mnASNg+chINMwb7fJouCwGiZ5WKby0cAC7eDolIKZ64rbr5TJp5QDe28QZr4PfEjkKAB
 oV92TdTX32nu9/qiFb4jM3RyQx9spy/axTO1jKbXgFOMby56vrsEk2mSkD5PwBW24CyC
 KWoAOJH58r0PlP4GS/jLIfqCFqTuaIE4uyn1brQalO9978eiHd/Q9CEqzTjZqY/Gb+dc 4w== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kr6e4ry7f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Nov 2022 12:17:04 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 2A9CEieY004811;
        Wed, 9 Nov 2022 12:17:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3kngwkn0xe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 09 Nov 2022 12:17:00 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2A9CH0wx008075;
        Wed, 9 Nov 2022 12:17:00 GMT
Received: from kalyant-linux.qualcomm.com (kalyant-linux.qualcomm.com [10.204.66.210])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 2A9CH0oJ008067;
        Wed, 09 Nov 2022 12:17:00 +0000
Received: by kalyant-linux.qualcomm.com (Postfix, from userid 94428)
        id EFE1E48B5; Wed,  9 Nov 2022 04:16:58 -0800 (PST)
From:   Kalyan Thota <quic_kalyant@quicinc.com>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     Kalyan Thota <quic_kalyant@quicinc.com>,
        linux-kernel@vger.kernel.org, robdclark@chromium.org,
        dianders@chromium.org, swboyd@chromium.org,
        quic_vpolimer@quicinc.com, dmitry.baryshkov@linaro.org,
        quic_abhinavk@quicinc.com
Subject: [PATCH 3/4] drm/msm/disp/dpu1: helper function to determine if encoder is virtual
Date:   Wed,  9 Nov 2022 04:16:45 -0800
Message-Id: <1667996206-4153-3-git-send-email-quic_kalyant@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1667996206-4153-1-git-send-email-quic_kalyant@quicinc.com>
References: <1667996206-4153-1-git-send-email-quic_kalyant@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: zPRK6IQXJzuY0YPS1y2dgogbpcXRe0aH
X-Proofpoint-GUID: zPRK6IQXJzuY0YPS1y2dgogbpcXRe0aH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_05,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 mlxlogscore=999 impostorscore=0
 phishscore=0 adultscore=0 bulkscore=0 spamscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211090094
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a helper function to determine if an encoder is of type
virtual.

Signed-off-by: Kalyan Thota <quic_kalyant@quicinc.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 11 +++++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h |  6 ++++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 5d6ad1f..4c56a16 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -2469,6 +2469,17 @@ bool dpu_encoder_is_external(struct drm_encoder *drm_enc)
 	return dpu_enc->disp_info.is_external;
 }
 
+bool dpu_encoder_is_virtual(struct drm_encoder *drm_enc)
+{
+	struct dpu_encoder_virt *dpu_enc;
+
+	if (!drm_enc)
+		return false;
+
+	dpu_enc = to_dpu_encoder_virt(drm_enc);
+	return (dpu_enc->disp_info.intf_type == DRM_MODE_ENCODER_VIRTUAL);
+}
+
 struct drm_encoder *dpu_encoder_init(struct drm_device *dev,
 		int drm_enc_mode)
 {
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
index 43f0d8b..6ae3c62 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
@@ -136,6 +136,12 @@ void dpu_encoder_virt_runtime_resume(struct drm_encoder *encoder);
 bool dpu_encoder_is_external(struct drm_encoder *drm_enc);
 
 /**
+ * dpu_encoder_is_virtual - find if the encoder is of type virtual.
+ * @drm_enc:    Pointer to previously created drm encoder structure
+ */
+bool dpu_encoder_is_virtual(struct drm_encoder *drm_enc);
+
+/**
  * dpu_encoder_init - initialize virtual encoder object
  * @dev:        Pointer to drm device structure
  * @disp_info:  Pointer to display information structure
-- 
2.7.4

