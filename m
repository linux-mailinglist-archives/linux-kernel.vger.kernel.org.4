Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E128622B55
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 13:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiKIMRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 07:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbiKIMRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 07:17:02 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B86193EE;
        Wed,  9 Nov 2022 04:16:56 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A9AvWEE002199;
        Wed, 9 Nov 2022 12:16:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=MSrVexxyBZ4hcfWqH3Zo/PYvPduj+u8s7BV7aJw1Aig=;
 b=othPQ2fLf3MYWU/SfDo5VqeNy+bkcP5JNsc4O+jQBSYYIaqPLNghB8N9IT/LYDINDQJl
 IMnMhILp84VWb4pfAR1YLG9spmVv8bIk75ieRXjGskEuPrYPXtlkQpHlM4t2eQpcLJ89
 h9kx63qb22npWOnWhiv6OGBpngHqyvNIuN6EmSt0MBzX56QEix7pd11Arntqo/Ubn6q9
 139Q/xoEuYWh/bp0oFx/dg7Oi+u1eMu/Q21Wl8PWOF/GtyeCzicTcrtK93q5nm4+hyK/
 5l9LvHLuUO7BG6OYHCNixTSOad07ITdHfDpt4qQZ24u+ItbkILpFePF4OJcxzqHYRXgP HA== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kr6e4ry74-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Nov 2022 12:16:54 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 2A9CGpPT008029;
        Wed, 9 Nov 2022 12:16:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3kngwkn0wq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 09 Nov 2022 12:16:51 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2A9CGobN008023;
        Wed, 9 Nov 2022 12:16:50 GMT
Received: from kalyant-linux.qualcomm.com (kalyant-linux.qualcomm.com [10.204.66.210])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 2A9CGoV5008021;
        Wed, 09 Nov 2022 12:16:50 +0000
Received: by kalyant-linux.qualcomm.com (Postfix, from userid 94428)
        id 8E8E548B5; Wed,  9 Nov 2022 04:16:49 -0800 (PST)
From:   Kalyan Thota <quic_kalyant@quicinc.com>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     Kalyan Thota <quic_kalyant@quicinc.com>,
        linux-kernel@vger.kernel.org, robdclark@chromium.org,
        dianders@chromium.org, swboyd@chromium.org,
        quic_vpolimer@quicinc.com, dmitry.baryshkov@linaro.org,
        quic_abhinavk@quicinc.com
Subject: [PATCH 1/4] drm/msm/disp/dpu1: pin 1 crtc to 1 encoder
Date:   Wed,  9 Nov 2022 04:16:43 -0800
Message-Id: <1667996206-4153-1-git-send-email-quic_kalyant@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: DsE0kOQSZiIbp7zPjPOAwmHSacVmU_Zk
X-Proofpoint-GUID: DsE0kOQSZiIbp7zPjPOAwmHSacVmU_Zk
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

Pin each crtc with one encoder. This arrangement will
disallow crtc switching between encoders and also will
facilitate to advertise certain features on crtc based
on encoder type.

Signed-off-by: Kalyan Thota <quic_kalyant@quicinc.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index 7a5fabc..552a89c 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -798,19 +798,19 @@ static int _dpu_kms_drm_obj_init(struct dpu_kms *dpu_kms)
 	max_crtc_count = min(max_crtc_count, primary_planes_idx);
 
 	/* Create one CRTC per encoder */
+	encoder = list_first_entry(&(dev)->mode_config.encoder_list,
+		struct drm_encoder, head);
 	for (i = 0; i < max_crtc_count; i++) {
 		crtc = dpu_crtc_init(dev, primary_planes[i], cursor_planes[i]);
-		if (IS_ERR(crtc)) {
+		if (IS_ERR(crtc) || IS_ERR_OR_NULL(encoder)) {
 			ret = PTR_ERR(crtc);
 			return ret;
 		}
 		priv->crtcs[priv->num_crtcs++] = crtc;
+		encoder->possible_crtcs = 1 << drm_crtc_index(crtc);
+		encoder = list_next_entry(encoder, head);
 	}
 
-	/* All CRTCs are compatible with all encoders */
-	drm_for_each_encoder(encoder, dev)
-		encoder->possible_crtcs = (1 << priv->num_crtcs) - 1;
-
 	return 0;
 }
 
-- 
2.7.4

