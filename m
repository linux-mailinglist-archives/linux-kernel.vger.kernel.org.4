Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10EA96A869F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 17:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjCBQet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 11:34:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjCBQeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 11:34:44 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600541ADFB;
        Thu,  2 Mar 2023 08:34:16 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 322EinVF027244;
        Thu, 2 Mar 2023 16:34:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=5mFrOPCuJpELd7cFaQmUZ0V5GlCh3W2QTWCLLtSx65E=;
 b=EveYHXIL2NDd0ihh46j0b0ptCjFed+8LWbxf5VvZLkzl9rhtO890vP3Cw7z0bA8+Me6o
 ENPd9SUkQZvC6hlx/847LF3x9awBwAKTu401dbssjYqrnuVH8u6FfIHpJpDqXoYCNyKz
 WNdfeYf0PgZut8poOKqyQ5+VH1ATeyCciel8KAJbopSnfqQlNtm/Mar56QItDV4BXj5C
 kGRdVrv8Zf2LdWfKPV+pRcPmqDTKqRTU6qjM7k7fDym6XIfwQGBqb4nRN7pj8T50bDsa
 Mv3sdqWKQrxaynsktZO+qbJtngmyohvpZrGoN/tYW1p24kaj+JnfWxs4MoyMA0zPkP8D JQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p2cx8au62-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Mar 2023 16:34:12 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 322GYBZj005198
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 2 Mar 2023 16:34:11 GMT
Received: from vpolimer-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 2 Mar 2023 08:34:06 -0800
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
Subject: [PATCH v14 06/14] drm/msm/disp/dpu: wait for extra vsync till timing engine status is disabled
Date:   Thu, 2 Mar 2023 22:03:09 +0530
Message-ID: <1677774797-31063-7-git-send-email-quic_vpolimer@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1677774797-31063-1-git-send-email-quic_vpolimer@quicinc.com>
References: <1677774797-31063-1-git-send-email-quic_vpolimer@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jy6c6_0yU8g7hUaHFJ3jr686IsPd7L2B
X-Proofpoint-ORIG-GUID: jy6c6_0yU8g7hUaHFJ3jr686IsPd7L2B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_10,2023-03-02_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303020144
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There can be a race between timing gen disable and vblank irq. The
wait post timing gen disable may return early but intf disable sequence
might not be completed. Ensure that, intf status is disabled before
we retire the function.

Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c    | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
index 48c4810..0396084 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
@@ -523,6 +523,7 @@ static void dpu_encoder_phys_vid_disable(struct dpu_encoder_phys *phys_enc)
 {
 	unsigned long lock_flags;
 	int ret;
+	struct intf_status intf_status = {0};
 
 	if (!phys_enc->parent || !phys_enc->parent->dev) {
 		DPU_ERROR("invalid encoder/device\n");
@@ -567,6 +568,26 @@ static void dpu_encoder_phys_vid_disable(struct dpu_encoder_phys *phys_enc)
 		}
 	}
 
+	if (phys_enc->hw_intf && phys_enc->hw_intf->ops.get_status)
+		phys_enc->hw_intf->ops.get_status(phys_enc->hw_intf, &intf_status);
+
+	/*
+	 * Wait for a vsync if timing en status is on after timing engine
+	 * is disabled.
+	 */
+	if (intf_status.is_en && dpu_encoder_phys_vid_is_master(phys_enc)) {
+		spin_lock_irqsave(phys_enc->enc_spinlock, lock_flags);
+		dpu_encoder_phys_inc_pending(phys_enc);
+		spin_unlock_irqrestore(phys_enc->enc_spinlock, lock_flags);
+		ret = dpu_encoder_phys_vid_wait_for_vblank(phys_enc);
+		if (ret) {
+			atomic_set(&phys_enc->pending_kickoff_cnt, 0);
+			DRM_ERROR("wait disable failed: id:%u intf:%d ret:%d\n",
+				  DRMID(phys_enc->parent),
+				  phys_enc->hw_intf->idx - INTF_0, ret);
+		}
+	}
+
 	phys_enc->enable_state = DPU_ENC_DISABLED;
 }
 
-- 
2.7.4

