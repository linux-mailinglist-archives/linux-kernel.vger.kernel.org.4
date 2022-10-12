Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D23FF5FC4F5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 14:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiJLMEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 08:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiJLMC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 08:02:59 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BA4BD07D;
        Wed, 12 Oct 2022 05:02:56 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29C7xw6l003589;
        Wed, 12 Oct 2022 12:02:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=8xs6OVqAcmkaMPq4tN4EOVYM43365DmpXMpRvsah7IE=;
 b=Na8eXGKyGmkZxcvBk1ufEraYYqahftF23QJ+fn/n8zaq6wd7Kb2S7w3Fy4dc1Xf29/DG
 602gXH+hgNS24I+i9fWzIS2IOL759fDncNsbcRJ4YYOFQrYZDcbxcOjXyVTa28KF74Wz
 mBiIKOpLlXXRWdiNTtnqL1oK1HTl4hA0zt3BUkHwMPu7vMY7HY5+h7x3PVju4x5xoOGG
 CR0nw6boVH/p+nGiAhQNqIcSeuMhxexBZ7A7X9fXZQA51EqZsY1s2O12HE1rX4pprtT2
 YltXT5yDWRe0CQ41PN5kmiQzZDVFggWW9oe1VFSxcraT4i9zIMMJMnD4X7WJxhX6L+Hr eA== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k5eg4a9xr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 12:02:53 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 29CC2mZZ026936;
        Wed, 12 Oct 2022 12:02:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3k3jpu0t37-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 12 Oct 2022 12:02:50 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29CC2oIJ026999;
        Wed, 12 Oct 2022 12:02:50 GMT
Received: from vpolimer-linux.qualcomm.com (vpolimer-linux.qualcomm.com [10.204.67.235])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 29CC2mBm026869;
        Wed, 12 Oct 2022 12:02:50 +0000
Received: by vpolimer-linux.qualcomm.com (Postfix, from userid 463814)
        id 3A8C83EF8; Wed, 12 Oct 2022 17:32:47 +0530 (IST)
From:   Vinod Polimera <quic_vpolimer@quicinc.com>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     Vinod Polimera <quic_vpolimer@quicinc.com>,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        dianders@chromium.org, swboyd@chromium.org,
        quic_kalyant@quicinc.com, dmitry.baryshkov@linaro.org,
        quic_khsieh@quicinc.com, quic_vproddut@quicinc.com,
        quic_bjorande@quicinc.com, quic_aravindh@quicinc.com,
        quic_abhinavk@quicinc.com, quic_sbillaka@quicinc.com
Subject: [PATCH v8 10/15] drm/msm/disp/dpu: check for crtc enable rather than crtc active to release shared resources
Date:   Wed, 12 Oct 2022 17:32:34 +0530
Message-Id: <1665576159-3749-11-git-send-email-quic_vpolimer@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1665576159-3749-1-git-send-email-quic_vpolimer@quicinc.com>
References: <1665576159-3749-1-git-send-email-quic_vpolimer@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: XZSl6HrQ9P-DpWgAqQtyzcATDzKltX7m
X-Proofpoint-ORIG-GUID: XZSl6HrQ9P-DpWgAqQtyzcATDzKltX7m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-12_06,2022-10-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=954 mlxscore=0
 suspectscore=0 bulkscore=0 phishscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210120079
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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
index 7e35560..e8c3518 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -648,7 +648,7 @@ static int dpu_encoder_virt_atomic_check(
 		if (drm_atomic_crtc_needs_modeset(crtc_state)) {
 			dpu_rm_release(global_state, drm_enc);
 
-			if (!crtc_state->active_changed || crtc_state->active)
+			if (!crtc_state->active_changed || crtc_state->enable)
 				ret = dpu_rm_reserve(&dpu_kms->rm, global_state,
 						drm_enc, crtc_state, topology);
 		}
-- 
2.7.4

