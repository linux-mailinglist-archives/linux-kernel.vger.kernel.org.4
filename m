Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B868C68F00A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 14:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbjBHNmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 08:42:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjBHNmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 08:42:21 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9955F2F7B1;
        Wed,  8 Feb 2023 05:42:20 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 318CwiOr019691;
        Wed, 8 Feb 2023 13:42:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=QhhDhHLPtQlrKQ/0w7Ad6DBmj1X9Ylr1RZKpwCxkEM0=;
 b=kEQ/7x59rUDPu7hy2JVkKYppQSIP41bTYAE7LMYY4VLiOogaUUGClEpBnrloQJpsYYAS
 GZX/mfpCvx9iMYPjilWQ1UtUXFVn4CPmS7TWfCRGTtio5yxyRioKT0XUh3TsidWIM6Pt
 kMRjRI5Mnb8hd75vMkSvx0/96R/W7js4mX/f5L7YjoelpyyRfv8jBWidIsxQtNUOD/1x
 I837fsH8T2ih/frNJ2ZVrMwcZixt4MC1xVajatjrNY2cbIq85umn+X6rKNQI1ltUGink
 9jDIOhjuIHtwRSIYQXGX2WBXuvP0tKC5wC28FQfkz+6wHK6mOthc/yOaQF9Y87jLnNa0 tw== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nm8x1rjwh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Feb 2023 13:42:14 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 318DgAru025358;
        Wed, 8 Feb 2023 13:42:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3nhgekjer4-1;
        Wed, 08 Feb 2023 13:42:10 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 318DgAdL025367;
        Wed, 8 Feb 2023 13:42:10 GMT
Received: from kalyant-linux.qualcomm.com (kalyant-linux.qualcomm.com [10.204.66.210])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 318DgA0T025349;
        Wed, 08 Feb 2023 13:42:10 +0000
Received: by kalyant-linux.qualcomm.com (Postfix, from userid 94428)
        id BCFB7D97; Wed,  8 Feb 2023 05:42:09 -0800 (PST)
From:   Kalyan Thota <quic_kalyant@quicinc.com>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     Kalyan Thota <quic_kalyant@quicinc.com>,
        linux-kernel@vger.kernel.org, robdclark@chromium.org,
        dianders@chromium.org, swboyd@chromium.org,
        quic_vpolimer@quicinc.com, dmitry.baryshkov@linaro.org,
        quic_abhinavk@quicinc.com, marijn.suijten@somainline.org
Subject: [PATCH v3 3/4] drm/msm/dpu: avoid unnecessary check in DPU reservations
Date:   Wed,  8 Feb 2023 05:42:03 -0800
Message-Id: <1675863724-28412-4-git-send-email-quic_kalyant@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1675863724-28412-1-git-send-email-quic_kalyant@quicinc.com>
References: <1675863724-28412-1-git-send-email-quic_kalyant@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rAvMRB28RJoGc1etAsSUKAz6TAmSm5Ql
X-Proofpoint-ORIG-GUID: rAvMRB28RJoGc1etAsSUKAz6TAmSm5Ql
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-08_05,2023-02-08_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 mlxscore=0 suspectscore=0 malwarescore=0 mlxlogscore=856
 lowpriorityscore=0 spamscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302080120
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return immediately on failure, this will make dpu reservations
part look cleaner.

Signed-off-by: Kalyan Thota <quic_kalyant@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 46d2a5c..3920efd 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -636,25 +636,22 @@ static int dpu_encoder_virt_atomic_check(
 		if (ret) {
 			DPU_ERROR_ENC(dpu_enc,
 					"mode unsupported, phys idx %d\n", i);
-			break;
+			return ret;
 		}
 	}
 
 	topology = dpu_encoder_get_topology(dpu_enc, dpu_kms, adj_mode, crtc_state);
 
-	/* Reserve dynamic resources now. */
-	if (!ret) {
-		/*
-		 * Release and Allocate resources on every modeset
-		 * Dont allocate when active is false.
-		 */
-		if (drm_atomic_crtc_needs_modeset(crtc_state)) {
-			dpu_rm_release(global_state, drm_enc);
+	/*
+	 * Release and Allocate resources on every modeset
+	 * Dont allocate when active is false.
+	 */
+	if (drm_atomic_crtc_needs_modeset(crtc_state)) {
+		dpu_rm_release(global_state, drm_enc);
 
-			if (!crtc_state->active_changed || crtc_state->active)
-				ret = dpu_rm_reserve(&dpu_kms->rm, global_state,
-						drm_enc, crtc_state, topology);
-		}
+		if (!crtc_state->active_changed || crtc_state->active)
+			ret = dpu_rm_reserve(&dpu_kms->rm, global_state,
+					drm_enc, crtc_state, topology);
 	}
 
 	trace_dpu_enc_atomic_check_flags(DRMID(drm_enc), adj_mode->flags);
-- 
2.7.4

