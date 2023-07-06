Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D959B74A4DA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 22:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbjGFU2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 16:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjGFU2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 16:28:00 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E801996;
        Thu,  6 Jul 2023 13:27:58 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3664Woqn026436;
        Thu, 6 Jul 2023 20:27:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=C92CpaLMBxsIu1Vqu81H7JOvCBxUCRCAB1bx/1EdNVs=;
 b=hNBQGUiEY0zAaV6AAIPaUxuVHfwYifRkh4kaHFn+9mNFFOGf55ppJUazDkir+avwf5vb
 eZY/X8ePEZVl8fooGf1VFGZXI5Nlrtd1I/eYZtBbV+AlTe+YP2diL+JlgWfOZdcq4dgd
 RPt8SFwv5m8Ls3xFvE/XWKwUTvv2qnfH0DtleRMp4dcBHUgDbb4S9Jn0C8w3RPQfHjhz
 Vnskhf4UiDs8whvrOOT3ClSAbVfpVMhVOwel2/pN3s89Qw15PDUbZBzZb1YBlxbiNQly
 Cq5BScQLv5WNET+bkA9SLS/LDU5VpVBJnJvuNh73YBDYwzqFAECpExlCrAfRUvKRHkPF gg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rnfm4jgkn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jul 2023 20:27:48 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 366KRmRI026341
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Jul 2023 20:27:48 GMT
Received: from hu-rmccann-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 6 Jul 2023 13:27:47 -0700
From:   Ryan McCann <quic_rmccann@quicinc.com>
Date:   Thu, 6 Jul 2023 13:26:52 -0700
Subject: [PATCH v3 6/6] drm/msm/dpu: Update dev core dump to dump registers
 of sub-blocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230622-devcoredump_patch-v3-6-83601b72eb67@quicinc.com>
References: <20230622-devcoredump_patch-v3-0-83601b72eb67@quicinc.com>
In-Reply-To: <20230622-devcoredump_patch-v3-0-83601b72eb67@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1688675265; l=4752;
 i=quic_rmccann@quicinc.com; s=20230622; h=from:subject:message-id;
 bh=AT8Z1kDsBnEI1CH8VhV5WFsBJXsUk7u9tyfOM6NNPIs=;
 b=nbF8MCTVqNy7JLwkw9JQSN3crxXvoSm2XIi3IKiPXWQgUGe1MbJ+V7k9hF2NU/W6gJ/mD3Jwa
 bkLA2k2USvkBNf7fBFykZ213qPeIoRfDcZAQeSpSE/W7xO+Xw1dZ38g
X-Developer-Key: i=quic_rmccann@quicinc.com; a=ed25519;
 pk=d/uP3OwPGpj/bTtiHvV1RBZ2S6q4AL6j1+A5y+dmbTI=
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: V3upiz-mS1qP6IWE6wQcDmT5MH74r967
X-Proofpoint-ORIG-GUID: V3upiz-mS1qP6IWE6wQcDmT5MH74r967
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_15,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxlogscore=943 mlxscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307060179
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
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
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 66 ++++++++++++++++++++++++++++++---
 1 file changed, 60 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index 70dbb1204e6c..afc45d597d65 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -903,25 +903,58 @@ static void dpu_kms_mdp_snapshot(struct msm_disp_state *disp_state, struct msm_k
 					    cat->ctl[i].base, cat->ctl[i].name);
 
 	/* dump DSPP sub-blocks HW regs info */
-	for (i = 0; i < cat->dspp_count; i++)
+	for (i = 0; i < cat->dspp_count; i++) {
 		msm_disp_snapshot_add_block(disp_state, cat->dspp[i].len, dpu_kms->mmio +
 					    cat->dspp[i].base, cat->dspp[i].name);
 
+		if (cat->dspp[i].sblk && cat->dspp[i].sblk->pcc.len > 0)
+			msm_disp_snapshot_add_block(disp_state, cat->dspp[i].sblk->pcc.len,
+						    dpu_kms->mmio + cat->dspp[i].base +
+						    cat->dspp[i].sblk->pcc.base, "%s_%s",
+						    cat->dspp[i].name,
+						    cat->dspp[i].sblk->pcc.name);
+	}
+
 	/* dump INTF sub-blocks HW regs info */
 	for (i = 0; i < cat->intf_count; i++)
 		msm_disp_snapshot_add_block(disp_state, cat->intf[i].len, dpu_kms->mmio +
 					    cat->intf[i].base, cat->intf[i].name);
 
 	/* dump PP sub-blocks HW regs info */
-	for (i = 0; i < cat->pingpong_count; i++)
+	for (i = 0; i < cat->pingpong_count; i++) {
 		msm_disp_snapshot_add_block(disp_state, cat->pingpong[i].len, dpu_kms->mmio +
 					    cat->pingpong[i].base, cat->pingpong[i].name);
 
+		/* TE2 block has length of 0, so will not print it */
+
+		if (cat->pingpong[i].sblk && cat->pingpong[i].sblk->dither.len > 0)
+			msm_disp_snapshot_add_block(disp_state, cat->pingpong[i].sblk->dither.len,
+						    dpu_kms->mmio + cat->pingpong[i].base +
+						    cat->pingpong[i].sblk->dither.base, "%s_%s",
+						    cat->pingpong[i].name,
+						    cat->pingpong[i].sblk->dither.name);
+	}
+
 	/* dump SSPP sub-blocks HW regs info */
-	for (i = 0; i < cat->sspp_count; i++)
+	for (i = 0; i < cat->sspp_count; i++) {
 		msm_disp_snapshot_add_block(disp_state, cat->sspp[i].len, dpu_kms->mmio +
 					    cat->sspp[i].base, cat->sspp[i].name);
 
+		if (cat->sspp[i].sblk && cat->sspp[i].sblk->scaler_blk.len > 0)
+			msm_disp_snapshot_add_block(disp_state, cat->sspp[i].sblk->scaler_blk.len,
+						    dpu_kms->mmio + cat->sspp[i].base +
+						    cat->sspp[i].sblk->scaler_blk.base, "%s_%s",
+						    cat->sspp[i].name,
+						    cat->sspp[i].sblk->scaler_blk.name);
+
+		if (cat->sspp[i].sblk && cat->sspp[i].sblk->csc_blk.len > 0)
+			msm_disp_snapshot_add_block(disp_state, cat->sspp[i].sblk->csc_blk.len,
+						    dpu_kms->mmio + cat->sspp[i].base +
+						    cat->sspp[i].sblk->csc_blk.base, "%s_%s",
+						    cat->sspp[i].name,
+						    cat->sspp[i].sblk->csc_blk.name);
+	}
+
 	/* dump LM sub-blocks HW regs info */
 	for (i = 0; i < cat->mixer_count; i++)
 		msm_disp_snapshot_add_block(disp_state, cat->mixer[i].len, dpu_kms->mmio +
@@ -943,9 +976,30 @@ static void dpu_kms_mdp_snapshot(struct msm_disp_state *disp_state, struct msm_k
 	}
 
 	/* dump DSC sub-blocks HW regs info */
-	for (i = 0; i < cat->dsc_count; i++)
-		msm_disp_snapshot_add_block(disp_state, cat->dsc[i].len, dpu_kms->mmio +
-					    cat->dsc[i].base, cat->dsc[i].name);
+	for (i = 0; i < cat->dsc_count; i++) {
+		if (cat->dsc[i].features & BIT(DPU_DSC_HW_REV_1_2)) {
+			struct dpu_dsc_blk enc = cat->dsc[i].sblk->enc;
+			struct dpu_dsc_blk ctl = cat->dsc[i].sblk->ctl;
+
+			/* For now, pass in a length of 0 because the DSC_BLK register space
+			 * overlaps with the sblks' register space.
+			 *
+			 * TODO: Pass in a length of 0 to DSC_BLK_1_2 in the HW catalog where
+			 * applicable.
+			 */
+			msm_disp_snapshot_add_block(disp_state, 0, dpu_kms->mmio +
+						    cat->dsc[i].base, cat->dsc[i].name);
+			msm_disp_snapshot_add_block(disp_state, enc.len, dpu_kms->mmio +
+						    cat->dsc[i].base + enc.base, "%s_%s",
+						    cat->dsc[i].name, enc.name);
+			msm_disp_snapshot_add_block(disp_state, ctl.len, dpu_kms->mmio +
+						    cat->dsc[i].base + ctl.base, "%s_%s",
+						    cat->dsc[i].name, ctl.name);
+		} else {
+			msm_disp_snapshot_add_block(disp_state, cat->dsc[i].len, dpu_kms->mmio +
+						    cat->dsc[i].base, cat->dsc[i].name);
+		}
+	}
 
 	pm_runtime_put_sync(&dpu_kms->pdev->dev);
 }

-- 
2.25.1

