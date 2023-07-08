Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4EA74BB0A
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 03:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbjGHBZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 21:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjGHBZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 21:25:07 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57EB2128;
        Fri,  7 Jul 2023 18:25:05 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3681OxOM016895;
        Sat, 8 Jul 2023 01:24:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=XhEO89waCat4oa12H9KVLK2XvqufA4g1o7nKImMe3pQ=;
 b=SuwT4ZKq3PS7YrnamGXGja6LHPFQw4i+kQYsD/C0IVtotEepNVsqVRFr8onbA+XVXBLw
 k5OArDjSYRsGXYPZgWu7nbwyyxZsEzPEBek3t0DHbNnKNM0Md6EnRbGVt8abk4IMyMgX
 R5W8eKpxhYD5ed7lsxjCm6rlWwNt/5GkZSZkzHsXi5TwqC19iiEREhd05MKXeKduM3nk
 0l0Q/eYcgmIXk67RY5jA5XKhlbn/8G8kr/szhlkfGqf5uBcCH8Xh0xqYWXWERmN0Cs+/
 enSimLaqPbra8ne7QQSsqYIKVXAmW6g9I57BXkc7JJV4+fsDMXviImd1MF8ntuLn0eYK Aw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rp8a62usr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 08 Jul 2023 01:24:59 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3681OwdA015420
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 8 Jul 2023 01:24:58 GMT
Received: from hu-rmccann-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 7 Jul 2023 18:24:58 -0700
From:   Ryan McCann <quic_rmccann@quicinc.com>
Date:   Fri, 7 Jul 2023 18:24:45 -0700
Subject: [PATCH v5 6/6] drm/msm/dpu: Update dev core dump to dump registers
 of sub-blocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230622-devcoredump_patch-v5-6-67e8b66c4723@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1688779496; l=4762;
 i=quic_rmccann@quicinc.com; s=20230622; h=from:subject:message-id;
 bh=McF3qtCPE6fgUtFjcMI7OcWUeu/nJFvGk3kHc+5g1+8=;
 b=mKYfbpiaJfX80R5/wqiDMwPx17XO7Od2wXTicUDx3awg0kBXdeFjYjMDJ5H3U6QcA62rjYBV9
 dpeVv1c/sFSCICOWgG2IdmK7UlVvoTSmzCUCDir99H5aHldGdjj2xNs
X-Developer-Key: i=quic_rmccann@quicinc.com; a=ed25519;
 pk=d/uP3OwPGpj/bTtiHvV1RBZ2S6q4AL6j1+A5y+dmbTI=
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3U0NwMF6WGJ3Z_wQF_8Q5KL1MWKflImp
X-Proofpoint-GUID: 3U0NwMF6WGJ3Z_wQF_8Q5KL1MWKflImp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_16,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 clxscore=1015 phishscore=0 mlxlogscore=999 bulkscore=0
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

Currently, the device core dump mechanism does not dump registers of
sub-blocks within the DSPP, SSPP, DSC, and PINGPONG blocks. Edit
dpu_kms_mdp_snapshot function to account for sub-blocks.

Signed-off-by: Ryan McCann <quic_rmccann@quicinc.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 66 +++++++++++++++++++++++++++------
 1 file changed, 54 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index 7a2787279ba0..f7199a5c45ab 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -890,6 +890,7 @@ static void dpu_kms_mdp_snapshot(struct msm_disp_state *disp_state, struct msm_k
 	int i;
 	struct dpu_kms *dpu_kms;
 	const struct dpu_mdss_cfg *cat;
+	void __iomem *base;
 
 	dpu_kms = to_dpu_kms(kms);
 
@@ -903,9 +904,16 @@ static void dpu_kms_mdp_snapshot(struct msm_disp_state *disp_state, struct msm_k
 				dpu_kms->mmio + cat->ctl[i].base, cat->ctl[i].name);
 
 	/* dump DSPP sub-blocks HW regs info */
-	for (i = 0; i < cat->dspp_count; i++)
-		msm_disp_snapshot_add_block(disp_state, cat->dspp[i].len,
-				dpu_kms->mmio + cat->dspp[i].base, cat->dspp[i].name);
+	for (i = 0; i < cat->dspp_count; i++) {
+		base = dpu_kms->mmio + cat->dspp[i].base;
+		msm_disp_snapshot_add_block(disp_state, cat->dspp[i].len, base, cat->dspp[i].name);
+
+		if (cat->dspp[i].sblk && cat->dspp[i].sblk->pcc.len > 0)
+			msm_disp_snapshot_add_block(disp_state, cat->dspp[i].sblk->pcc.len,
+						    base + cat->dspp[i].sblk->pcc.base, "%s_%s",
+						    cat->dspp[i].name,
+						    cat->dspp[i].sblk->pcc.name);
+	}
 
 	/* dump INTF sub-blocks HW regs info */
 	for (i = 0; i < cat->intf_count; i++)
@@ -913,14 +921,37 @@ static void dpu_kms_mdp_snapshot(struct msm_disp_state *disp_state, struct msm_k
 				dpu_kms->mmio + cat->intf[i].base, cat->intf[i].name);
 
 	/* dump PP sub-blocks HW regs info */
-	for (i = 0; i < cat->pingpong_count; i++)
-		msm_disp_snapshot_add_block(disp_state, cat->pingpong[i].len,
-				dpu_kms->mmio + cat->pingpong[i].base, cat->pingpong[i].name);
+	for (i = 0; i < cat->pingpong_count; i++) {
+		base = dpu_kms->mmio + cat->pingpong[i].base;
+		msm_disp_snapshot_add_block(disp_state, cat->pingpong[i].len, base,
+					    cat->pingpong[i].name);
+
+		/* TE2 sub-block has length of 0, so will not print it */
+
+		if (cat->pingpong[i].sblk && cat->pingpong[i].sblk->dither.len > 0)
+			msm_disp_snapshot_add_block(disp_state, cat->pingpong[i].sblk->dither.len,
+						    base + cat->pingpong[i].sblk->dither.base,
+						    "%s_%s", cat->pingpong[i].name,
+						    cat->pingpong[i].sblk->dither.name);
+	}
 
 	/* dump SSPP sub-blocks HW regs info */
-	for (i = 0; i < cat->sspp_count; i++)
-		msm_disp_snapshot_add_block(disp_state, cat->sspp[i].len,
-				dpu_kms->mmio + cat->sspp[i].base, cat->sspp[i].name);
+	for (i = 0; i < cat->sspp_count; i++) {
+		base = dpu_kms->mmio + cat->sspp[i].base;
+		msm_disp_snapshot_add_block(disp_state, cat->sspp[i].len, base, cat->sspp[i].name);
+
+		if (cat->sspp[i].sblk && cat->sspp[i].sblk->scaler_blk.len > 0)
+			msm_disp_snapshot_add_block(disp_state, cat->sspp[i].sblk->scaler_blk.len,
+						    base + cat->sspp[i].sblk->scaler_blk.base,
+						    "%s_%s", cat->sspp[i].name,
+						    cat->sspp[i].sblk->scaler_blk.name);
+
+		if (cat->sspp[i].sblk && cat->sspp[i].sblk->csc_blk.len > 0)
+			msm_disp_snapshot_add_block(disp_state, cat->sspp[i].sblk->csc_blk.len,
+						    base + cat->sspp[i].sblk->csc_blk.base,
+						    "%s_%s", cat->sspp[i].name,
+						    cat->sspp[i].sblk->csc_blk.name);
+	}
 
 	/* dump LM sub-blocks HW regs info */
 	for (i = 0; i < cat->mixer_count; i++)
@@ -943,9 +974,20 @@ static void dpu_kms_mdp_snapshot(struct msm_disp_state *disp_state, struct msm_k
 	}
 
 	/* dump DSC sub-blocks HW regs info */
-	for (i = 0; i < cat->dsc_count; i++)
-		msm_disp_snapshot_add_block(disp_state, cat->dsc[i].len,
-				dpu_kms->mmio + cat->dsc[i].base, cat->dsc[i].name);
+	for (i = 0; i < cat->dsc_count; i++) {
+		base = dpu_kms->mmio + cat->dsc[i].base;
+		msm_disp_snapshot_add_block(disp_state, cat->dsc[i].len, base, cat->dsc[i].name);
+
+		if (cat->dsc[i].features & BIT(DPU_DSC_HW_REV_1_2)) {
+			struct dpu_dsc_blk enc = cat->dsc[i].sblk->enc;
+			struct dpu_dsc_blk ctl = cat->dsc[i].sblk->ctl;
+
+			msm_disp_snapshot_add_block(disp_state, enc.len, base + enc.base, "%s_%s",
+						    cat->dsc[i].name, enc.name);
+			msm_disp_snapshot_add_block(disp_state, ctl.len, base + ctl.base, "%s_%s",
+						    cat->dsc[i].name, ctl.name);
+		}
+	}
 
 	pm_runtime_put_sync(&dpu_kms->pdev->dev);
 }

-- 
2.25.1

