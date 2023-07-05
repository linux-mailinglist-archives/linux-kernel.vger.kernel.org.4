Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8834B748DE0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 21:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234234AbjGETc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 15:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234145AbjGETcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:32:24 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5882171A;
        Wed,  5 Jul 2023 12:32:22 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 365HeZku011533;
        Wed, 5 Jul 2023 19:32:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=p15hj/n9Ks0fLsFKrqRNyan4d2irE1I2jec0Kpnoc1A=;
 b=i1LZVj4DIfX9Bh84PZdZ3s5w4EC/Jf4j8TA/4UIPXetcuGKZwtMtrhiHb0hSGZ/WAD+p
 Tp/OjCohv82yap1Zg9J4IRxXzZS/1rP58dq2ErmPXUIZv07AUmHqTAbEigVyXaGcbqmz
 GhrheMhn//DxDVp8vH6y/fu73CVehBBsgmHH92ujhSs+gzRGDhODw1tmYDBVxl0ECUPM
 z+fNlJoHKHlgD4XlTG2SIFjiFdfcOBcfgmTeYTqqh4/Q69lGvNHrvRm0AKJnv+VtlegU
 MnqTM9DZyZYA3tDHIchW56USSanjbZ6XqqdwdlrrG1R/X9QZ3m3rzba2o+duQm3OoOq3 gw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rn5mfsejm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jul 2023 19:32:14 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 365JWCcS002083
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 5 Jul 2023 19:32:12 GMT
Received: from hu-rmccann-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.7; Wed, 5 Jul 2023 12:32:12 -0700
From:   Ryan McCann <quic_rmccann@quicinc.com>
Date:   Wed, 5 Jul 2023 12:30:15 -0700
Subject: [PATCH v2 1/5] drm/msm: Update dev core dump to not print
 backwards
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230622-devcoredump_patch-v2-1-9e90a87d393f@quicinc.com>
References: <20230622-devcoredump_patch-v2-0-9e90a87d393f@quicinc.com>
In-Reply-To: <20230622-devcoredump_patch-v2-0-9e90a87d393f@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1688585532; l=1175;
 i=quic_rmccann@quicinc.com; s=20230622; h=from:subject:message-id;
 bh=spf8P6JJVhZzx19aCNUdDvZTBd91BGOkV8kKkMp6IzA=;
 b=sc4zHURKMqgkJo1SuQCRvFYoYKCiWahINzEumwz1Z7NsPmAwJpfKwutQYfvk9Gp8jthKj7om6
 SFJQzT2X7D6BuxrwtkAJYmBw+mzsIsY2IAQBRlnzd4BX5SvrNKgh/c5
X-Developer-Key: i=quic_rmccann@quicinc.com; a=ed25519;
 pk=d/uP3OwPGpj/bTtiHvV1RBZ2S6q4AL6j1+A5y+dmbTI=
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: XMWP-G27QwU4jsVD-0scWPIxSj013CxE
X-Proofpoint-ORIG-GUID: XMWP-G27QwU4jsVD-0scWPIxSj013CxE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-05_10,2023-07-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=862 priorityscore=1501
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307050178
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Device core dump add block method adds hardware blocks to dumping queue
with stack behavior which causes the hardware blocks to be printed in
reverse order. Change the addition to dumping queue data structure
from "list_add" to "list_add_tail" for FIFO queue behavior.

Fixes: 98659487b845 ("drm/msm: add support to take dpu snapshot")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Ryan McCann <quic_rmccann@quicinc.com>
---
 drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c b/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c
index acfe1b31e079..add72bbc28b1 100644
--- a/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c
+++ b/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c
@@ -192,5 +192,5 @@ void msm_disp_snapshot_add_block(struct msm_disp_state *disp_state, u32 len,
 	new_blk->base_addr = base_addr;
 
 	msm_disp_state_dump_regs(&new_blk->state, new_blk->size, base_addr);
-	list_add(&new_blk->node, &disp_state->blocks);
+	list_add_tail(&new_blk->node, &disp_state->blocks);
 }

-- 
2.25.1

