Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B951464C6D0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 11:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238176AbiLNKJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 05:09:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238094AbiLNKIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 05:08:18 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AFBD248E1;
        Wed, 14 Dec 2022 02:07:30 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BE8TD42022201;
        Wed, 14 Dec 2022 10:07:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=h58UIYvYouCRcJ4wKnnVdc10JHp8huiPuPf0DRvCHfc=;
 b=S8oqTQwDaZrjE7WKbXFh9zFQg3dnC54tAj15RauV0JnDSjogwiY6pDB10jChrdykKGLr
 h0z3HLClzh1ndX+3kreXOgEEjo9Wa1JITOWYMjQLvCMlJ+DcwQhkXv1IyQ8+TNCCxWgJ
 1LKI2KWinIiIRgYcoMp6EezZ5Gm2XFB/NwzqQjp4w3ZBNoQaecaXQPzNLce/s70rT5Yi
 eB5r5cdfuobKzYJiJd1WlDChHTF5Sxb1l6MZ0/wAHcqYpSE54L1TZBiUdc9Ale3W9zAN
 R/CUWnNPsrxupl62Klb2idpcF2q+4HAqLEMeOi5pBcrH9E9bUwAw2UK/c0i+wi7qY/wH mg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mf6rkgna2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Dec 2022 10:07:27 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BEA7QFB002198
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Dec 2022 10:07:26 GMT
Received: from vpolimer-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 14 Dec 2022 02:07:21 -0800
From:   Vinod Polimera <quic_vpolimer@quicinc.com>
To:     <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <freedreno@lists.freedesktop.org>, <devicetree@vger.kernel.org>
CC:     Vinod Polimera <quic_vpolimer@quicinc.com>,
        <linux-kernel@vger.kernel.org>, <robdclark@gmail.com>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <quic_kalyant@quicinc.com>, <dmitry.baryshkov@linaro.org>,
        <quic_khsieh@quicinc.com>, <quic_vproddut@quicinc.com>,
        <quic_bjorande@quicinc.com>, <quic_aravindh@quicinc.com>,
        <quic_abhinavk@quicinc.com>, <quic_sbillaka@quicinc.com>
Subject: [PATCH v9 13/15] drm/msm/disp/dpu: wait for extra vsync till timing engine status is disabled
Date:   Wed, 14 Dec 2022 15:35:50 +0530
Message-ID: <1671012352-1825-14-git-send-email-quic_vpolimer@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1671012352-1825-1-git-send-email-quic_vpolimer@quicinc.com>
References: <1671012352-1825-1-git-send-email-quic_vpolimer@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Qq2833WMpry5apTE8_4W1vQEXO-qXFSj
X-Proofpoint-ORIG-GUID: Qq2833WMpry5apTE8_4W1vQEXO-qXFSj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-14_04,2022-12-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212140079
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
---
 .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c    | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
index 0f71e8f..685cb44 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
@@ -526,6 +526,7 @@ static void dpu_encoder_phys_vid_disable(struct dpu_encoder_phys *phys_enc)
 {
 	unsigned long lock_flags;
 	int ret;
+	struct intf_status intf_status = {0};
 
 	if (!phys_enc->parent || !phys_enc->parent->dev) {
 		DPU_ERROR("invalid encoder/device\n");
@@ -570,6 +571,26 @@ static void dpu_encoder_phys_vid_disable(struct dpu_encoder_phys *phys_enc)
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

