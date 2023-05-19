Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F3570A176
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 23:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjESVRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 17:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjESVRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 17:17:46 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F87CD9;
        Fri, 19 May 2023 14:17:45 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34JL5Kfb027322;
        Fri, 19 May 2023 21:17:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=KUAyaly87rl3GTMy6tRTM1Zy022izTl2AVeB6RDoaYQ=;
 b=TzHSEm2Tqf53J/02g/p1g/674B3WT2359/AO8aA5qOPhb1RXsqSkkiL9fRFmJvpbWHMM
 astFfQ6LZQn6nGR/KGKIXOB3Muon9FxZNrV6v1pkJOS2NZDRr78WoRjBv/WDbQ7Pc9mo
 vRIc8Jwx7toNBJYGIAu6289QMkuHfmMlZrWjxaDGri/o7AqzAXY8NiOL9KedRGAfvr4g
 3jayh+kxRgonsiAii0830fSWJWDogKYAak4lVrh7If85flCZ6IrKNfPXkiMgvUc7pCDp
 LLlssliZaA9nyhFsC+qwoa2VCJqG9PZnbs9bCWxP/8NyT8YIxnqtmxL8YfNYDNgQlq5i 3Q== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qp8fm1fkn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 21:17:38 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34JLHbaR002614
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 21:17:37 GMT
Received: from jesszhan-linux.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 19 May 2023 14:17:36 -0700
From:   Jessica Zhang <quic_jesszhan@quicinc.com>
Date:   Fri, 19 May 2023 14:17:28 -0700
Subject: [PATCH v3 3/5] drm/msm/dpu: Add DPU_INTF_DATA_COMPRESS feature
 flag
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230405-add-dsc-support-v3-3-6e1d35a206b3@quicinc.com>
References: <20230405-add-dsc-support-v3-0-6e1d35a206b3@quicinc.com>
In-Reply-To: <20230405-add-dsc-support-v3-0-6e1d35a206b3@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684531055; l=1851;
 i=quic_jesszhan@quicinc.com; s=20230329; h=from:subject:message-id;
 bh=xlmYuXzrxjojwQK8HCsnZax0nefHQVaKqnTx4tI4c5k=;
 b=PKT6XCBujmLPZkOokrJ5ZiGzNNWOOWsuVY0sHgmlgNsphnYFno89JCI1HcTE58CJXHfmlyagq
 SMjj48Gdc8BDkHLxfShQ3k2pnBf2+OTRubZfsfPmhinJVzeHYFcGepM
X-Developer-Key: i=quic_jesszhan@quicinc.com; a=ed25519;
 pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Cezs36rlp40Lg0-69sId7P2JxzbfzDud
X-Proofpoint-GUID: Cezs36rlp40Lg0-69sId7P2JxzbfzDud
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_16,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 mlxlogscore=694 bulkscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 clxscore=1015
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305190184
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
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
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c | 2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
index 7944481d0a33..c74051906d05 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
@@ -104,7 +104,7 @@
 #define INTF_SC7180_MASK \
 	(BIT(DPU_INTF_INPUT_CTRL) | BIT(DPU_INTF_TE) | BIT(DPU_INTF_STATUS_SUPPORTED))
 
-#define INTF_SC7280_MASK INTF_SC7180_MASK | BIT(DPU_DATA_HCTL_EN)
+#define INTF_SC7280_MASK INTF_SC7180_MASK | BIT(DPU_DATA_HCTL_EN) | BIT(DPU_INTF_DATA_COMPRESS)
 
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

