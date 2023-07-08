Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6D174BB05
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 03:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbjGHBZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 21:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGHBZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 21:25:06 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36632127;
        Fri,  7 Jul 2023 18:25:05 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3681FAI2000844;
        Sat, 8 Jul 2023 01:24:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=PRzmYm72GEIRgOncePCjCMjujp1N+YuURufG16Djo/4=;
 b=V4A9nHLbxyS5zqV4FK1YLtwR8Ny+Lczs2EJEDtPaoCzlbYs3JVu0OEYRYsUWSX3F7cYg
 DrZrpLvIDNWgr9eb96+g5V1DHWM/OIHBfITAejwVQ+B1OdyGiDqu3kIQHeLMcLdE3AhP
 Nmgj8uHwt3sKUORO05g4gNe0q4AbM3ZMq0SkGt3syLrJ/HTFGIEYSI7wzNxkrD9CFpTA
 wMIinkcwcEgNeFvu/T0PgHeMZomVO3bG5sn6d9YQd5U+NkjD98N2C+OZalE+d2I1CDn9
 PIZLstuGRC4o3vLAff5OYPZvMM4vZv5Dmh1btdcQqJAYsUKCyj6C3VnSk7caAR+gvKEV qw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rp8a62usq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 08 Jul 2023 01:24:59 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3681Owaj002823
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 8 Jul 2023 01:24:58 GMT
Received: from hu-rmccann-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 7 Jul 2023 18:24:57 -0700
From:   Ryan McCann <quic_rmccann@quicinc.com>
Date:   Fri, 7 Jul 2023 18:24:44 -0700
Subject: [PATCH v5 5/6] drm/msm/dpu: Refactor printing of main blocks in
 device core dump
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230622-devcoredump_patch-v5-5-67e8b66c4723@quicinc.com>
References: <20230622-devcoredump_patch-v5-0-67e8b66c4723@quicinc.com>
In-Reply-To: <20230622-devcoredump_patch-v5-0-67e8b66c4723@quicinc.com>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     Rob Clark <robdclark@chromium.org>,
        <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <quic_jesszhan@quicinc.com>, Ryan McCann <quic_rmccann@quicinc.com>
X-Mailer: b4 0.13-dev-8a804
X-Developer-Signature: v=1; a=ed25519-sha256; t=1688779496; l=3170;
 i=quic_rmccann@quicinc.com; s=20230622; h=from:subject:message-id;
 bh=BEOijhkkAUkQUwqC1UhZn7AFHdQ0CsQpWM9M8c6eXXQ=;
 b=oyAqT4SxX+b666OrKS0LbccKj5C8vjr9J7IIeM+rYaeX6Ydx0/zJqV7z7MCXWgggpm0P9uZjZ
 +wTAwv91nY6CUaWvQR4Ob6ULV8z9cja+Yg8PZSlfLnrms2K7t28Ou4P
X-Developer-Key: i=quic_rmccann@quicinc.com; a=ed25519;
 pk=d/uP3OwPGpj/bTtiHvV1RBZ2S6q4AL6j1+A5y+dmbTI=
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Q0h4JF2S9VENzJWwOJXSr3z0kbpDPiqQ
X-Proofpoint-GUID: Q0h4JF2S9VENzJWwOJXSr3z0kbpDPiqQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_16,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 clxscore=1015 phishscore=0 mlxlogscore=922 bulkscore=0
 spamscore=0 impostorscore=0 mlxscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307080010
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the names of main blocks are hardcoded into the
msm_disp_snapshot_add_block function rather than using the name that
already exists in the catalog. Change this to take the name directly from
the catalog instead of hardcoding it.

Signed-off-by: Ryan McCann <quic_rmccann@quicinc.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index aa8499de1b9f..7a2787279ba0 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -900,37 +900,37 @@ static void dpu_kms_mdp_snapshot(struct msm_disp_state *disp_state, struct msm_k
 	/* dump CTL sub-blocks HW regs info */
 	for (i = 0; i < cat->ctl_count; i++)
 		msm_disp_snapshot_add_block(disp_state, cat->ctl[i].len,
-				dpu_kms->mmio + cat->ctl[i].base, "ctl_%d", i);
+				dpu_kms->mmio + cat->ctl[i].base, cat->ctl[i].name);
 
 	/* dump DSPP sub-blocks HW regs info */
 	for (i = 0; i < cat->dspp_count; i++)
 		msm_disp_snapshot_add_block(disp_state, cat->dspp[i].len,
-				dpu_kms->mmio + cat->dspp[i].base, "dspp_%d", i);
+				dpu_kms->mmio + cat->dspp[i].base, cat->dspp[i].name);
 
 	/* dump INTF sub-blocks HW regs info */
 	for (i = 0; i < cat->intf_count; i++)
 		msm_disp_snapshot_add_block(disp_state, cat->intf[i].len,
-				dpu_kms->mmio + cat->intf[i].base, "intf_%d", i);
+				dpu_kms->mmio + cat->intf[i].base, cat->intf[i].name);
 
 	/* dump PP sub-blocks HW regs info */
 	for (i = 0; i < cat->pingpong_count; i++)
 		msm_disp_snapshot_add_block(disp_state, cat->pingpong[i].len,
-				dpu_kms->mmio + cat->pingpong[i].base, "pingpong_%d", i);
+				dpu_kms->mmio + cat->pingpong[i].base, cat->pingpong[i].name);
 
 	/* dump SSPP sub-blocks HW regs info */
 	for (i = 0; i < cat->sspp_count; i++)
 		msm_disp_snapshot_add_block(disp_state, cat->sspp[i].len,
-				dpu_kms->mmio + cat->sspp[i].base, "sspp_%d", i);
+				dpu_kms->mmio + cat->sspp[i].base, cat->sspp[i].name);
 
 	/* dump LM sub-blocks HW regs info */
 	for (i = 0; i < cat->mixer_count; i++)
 		msm_disp_snapshot_add_block(disp_state, cat->mixer[i].len,
-				dpu_kms->mmio + cat->mixer[i].base, "lm_%d", i);
+				dpu_kms->mmio + cat->mixer[i].base, cat->mixer[i].name);
 
 	/* dump WB sub-blocks HW regs info */
 	for (i = 0; i < cat->wb_count; i++)
 		msm_disp_snapshot_add_block(disp_state, cat->wb[i].len,
-				dpu_kms->mmio + cat->wb[i].base, "wb_%d", i);
+				dpu_kms->mmio + cat->wb[i].base, cat->wb[i].name);
 
 	if (cat->mdp[0].features & BIT(DPU_MDP_PERIPH_0_REMOVED)) {
 		msm_disp_snapshot_add_block(disp_state, MDP_PERIPH_TOP0,
@@ -945,7 +945,7 @@ static void dpu_kms_mdp_snapshot(struct msm_disp_state *disp_state, struct msm_k
 	/* dump DSC sub-blocks HW regs info */
 	for (i = 0; i < cat->dsc_count; i++)
 		msm_disp_snapshot_add_block(disp_state, cat->dsc[i].len,
-				dpu_kms->mmio + cat->dsc[i].base, "dsc_%d", i);
+				dpu_kms->mmio + cat->dsc[i].base, cat->dsc[i].name);
 
 	pm_runtime_put_sync(&dpu_kms->pdev->dev);
 }

-- 
2.25.1

