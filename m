Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07BBD6938A7
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 17:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjBLQ36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 11:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBLQ34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 11:29:56 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DFEB76A;
        Sun, 12 Feb 2023 08:29:39 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31CGTb9V015244;
        Sun, 12 Feb 2023 16:29:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=5541rvjzRalFGyRJy8gOGY+SwqZ2yBmR83pAe/IFHlM=;
 b=Ku2LqWlPC+gfBaDtp+Vz/Gr0UiQkrN1NNh92qESP/h87ioBZiXj/GTk0CskOEw5bOqhm
 DGBC3YdYl85IYLtghDiGSQvJ1VPfPLmDEoxSJs5QOzVldHT99Cp1bk9YqxEkhR6DxvRD
 PFevTZ17VFHxy4jLs7TxrGNWQ9JgLot919awFX6mvvhYarRJE1dVSIEku7IDuKgbIvXx
 kF96dM88OPvc5rnCauW11vibH9Kd9Tm2IPFr9gBU1L/jMHw/Z9Pe0Vmsqg+34z8M/gf3
 vmOu3OjK5ITOgY/TdHI+ZbEr3kGjRqv19gJ1dooxwAjBZUZXJQnxfzp/sT8UGKVe6ooh fg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3np4aga472-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 12 Feb 2023 16:29:36 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31CGTaiR026959
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 12 Feb 2023 16:29:36 GMT
Received: from vpolimer-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Sun, 12 Feb 2023 08:29:30 -0800
From:   Vinod Polimera <quic_vpolimer@quicinc.com>
To:     <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <freedreno@lists.freedesktop.org>, <devicetree@vger.kernel.org>
CC:     Vinod Polimera <quic_vpolimer@quicinc.com>,
        <linux-kernel@vger.kernel.org>, <robdclark@gmail.com>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <quic_kalyant@quicinc.com>, <dmitry.baryshkov@linaro.org>,
        <quic_khsieh@quicinc.com>, <quic_vproddut@quicinc.com>,
        <quic_bjorande@quicinc.com>, <quic_abhinavk@quicinc.com>,
        <quic_sbillaka@quicinc.com>
Subject: [PATCH v13 04/13] drm/msm/disp/dpu: check for crtc enable rather than crtc active to release shared resources
Date:   Sun, 12 Feb 2023 21:58:48 +0530
Message-ID: <1676219337-6526-5-git-send-email-quic_vpolimer@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1676219337-6526-1-git-send-email-quic_vpolimer@quicinc.com>
References: <1676219337-6526-1-git-send-email-quic_vpolimer@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: hBX2s3DbiZWXIwX7mxTV9modHpb9Oebs
X-Proofpoint-GUID: hBX2s3DbiZWXIwX7mxTV9modHpb9Oebs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-12_06,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 impostorscore=0 clxscore=1015 adultscore=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0 mlxlogscore=988
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302120148
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to KMS documentation, The driver must not release any shared
resources if active is set to false but enable still true.

Fixes: ccc862b957c6 ("drm/msm/dpu: Fix reservation failures in modeset")
Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 758261e..c237003 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -652,7 +652,7 @@ static int dpu_encoder_virt_atomic_check(
 		if (drm_atomic_crtc_needs_modeset(crtc_state)) {
 			dpu_rm_release(global_state, drm_enc);
 
-			if (!crtc_state->active_changed || crtc_state->active)
+			if (!crtc_state->active_changed || crtc_state->enable)
 				ret = dpu_rm_reserve(&dpu_kms->rm, global_state,
 						drm_enc, crtc_state, topology);
 		}
-- 
2.7.4

