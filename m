Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1499E70CB14
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 22:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234329AbjEVUbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 16:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233410AbjEVUas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 16:30:48 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00ED9C2;
        Mon, 22 May 2023 13:30:46 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34MKUenO030735;
        Mon, 22 May 2023 20:30:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=zfq+gg84/opEXxXI4TTjUQPxXY1TZCDMm/us0c5TBBE=;
 b=LTJLB95LBW0LVGvUDV8F15OjgBnMLWPMz8fWAvWnQ4jqsG1GgBpoJB+3ZsqiVNT9A/YB
 c26xSKc4tz+tFnlq2ZAHgQ5t753aaKKd2KkuY92wy/nS5l9N/1jVYSk041LBZpjsw82t
 bTHSq0xnXKEs5KF2rB3Yd6NUAzEH0DMpVbHeEcLDtd5MSdBoCZwtXAxfAqqDeYZWCL9a
 raWbbof96v69J/pY5wg0VhDzaRnOQtxkrkjJzN6B4yRbtjAB4hPndKAEtYS27B7n7jSf
 uwF4kiH1DdcgYBFQ2o1+Po4yelG1HtYEAmbIKrHOpUVdRykSnbWpgtegUBVHuhrQhwY0 mw== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qr53w9eb7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 20:30:40 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34MKUeQW010425
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 20:30:40 GMT
Received: from jesszhan-linux.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 22 May 2023 13:30:39 -0700
From:   Jessica Zhang <quic_jesszhan@quicinc.com>
Date:   Mon, 22 May 2023 13:30:22 -0700
Subject: [PATCH v4 3/5] drm/msm/dpu: Add DPU_INTF_DATA_COMPRESS feature
 flag
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230405-add-dsc-support-v4-3-15daf84f8dcb@quicinc.com>
References: <20230405-add-dsc-support-v4-0-15daf84f8dcb@quicinc.com>
In-Reply-To: <20230405-add-dsc-support-v4-0-15daf84f8dcb@quicinc.com>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Marijn Suijten <marijn.suijten@somainline.org>
CC:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>
X-Mailer: b4 0.13-dev-bfdf5
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684787438; l=1859;
 i=quic_jesszhan@quicinc.com; s=20230329; h=from:subject:message-id;
 bh=pNAs84j0wiO45gXOaDTFoULI8IeLxCipuI9OnPl7Hos=;
 b=E9Kaco9dL/c4lVlwpYbqLdSvxkuyBqoVXBSqayu+Y/RE1r48r9qufN60GB+zilub0qtCmXdwp
 l/Yi6VrblAzAVxRRvDfjIPQhKp0PbhIq04rmfEL/U4iru9GqywooFZk
X-Developer-Key: i=quic_jesszhan@quicinc.com; a=ed25519;
 pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Xpp9znBGX5JGXdqOk3PtTdNMYELISZAV
X-Proofpoint-ORIG-GUID: Xpp9znBGX5JGXdqOk3PtTdNMYELISZAV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-22_15,2023-05-22_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 mlxlogscore=693
 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0 clxscore=1015
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305220173
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DATA_COMPRESS feature flag to DPU INTF block.

In DPU 7.x and later, DSC/DCE enablement registers have been moved from
PINGPONG to INTF.

Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c | 3 ++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
index 7944481d0a33..8e12e07728df 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
@@ -104,7 +104,8 @@
 #define INTF_SC7180_MASK \
 	(BIT(DPU_INTF_INPUT_CTRL) | BIT(DPU_INTF_TE) | BIT(DPU_INTF_STATUS_SUPPORTED))
 
-#define INTF_SC7280_MASK INTF_SC7180_MASK | BIT(DPU_DATA_HCTL_EN)
+#define INTF_SC7280_MASK \
+	(INTF_SC7180_MASK | BIT(DPU_DATA_HCTL_EN) | BIT(DPU_INTF_DATA_COMPRESS))
 
 #define WB_SM8250_MASK (BIT(DPU_WB_LINE_MODE) | \
 			 BIT(DPU_WB_UBWC) | \
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
index 4eda2cc847ef..01c65f940f2a 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
@@ -185,6 +185,7 @@ enum {
  * @DPU_DATA_HCTL_EN                Allows data to be transferred at different rate
  *                                  than video timing
  * @DPU_INTF_STATUS_SUPPORTED       INTF block has INTF_STATUS register
+ * @DPU_INTF_DATA_COMPRESS          INTF block has DATA_COMPRESS register
  * @DPU_INTF_MAX
  */
 enum {
@@ -192,6 +193,7 @@ enum {
 	DPU_INTF_TE,
 	DPU_DATA_HCTL_EN,
 	DPU_INTF_STATUS_SUPPORTED,
+	DPU_INTF_DATA_COMPRESS,
 	DPU_INTF_MAX
 };
 

-- 
2.40.1

