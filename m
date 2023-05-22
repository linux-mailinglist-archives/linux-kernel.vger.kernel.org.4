Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B31170C7C1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 21:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234815AbjEVTcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 15:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234791AbjEVTcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 15:32:04 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E02C9E;
        Mon, 22 May 2023 12:32:02 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34MISqdI027794;
        Mon, 22 May 2023 19:31:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=kKB94OMz6i3mtQBjIfVqdUOld64G/njfcAiumFtldUk=;
 b=fGmBIVHuyZ3YlU9CQGQkkvYilwj+/kqtn5/jZYeP4knZQVZkk9D5u2TilT7TEGH6UWZd
 CEQchwU+GaIoLJ2rxtgD26oA+dzUKzY2Md/XoX/mTN62LaOoXSjfLfUNS1WNWnml9nTR
 tegLO5kQds7HN7csnyqZgNHDjGpnk3dD5X/jj7O7F4LpV7EJ53prfIXAYFa4gDMVMe0x
 GMZbJdwmj1XlJsX7uqoRAD0zSV/15cJoTyc0AulhnuDj+NNE/jcM9RDvVdCoAsfEqUnJ
 RZR7pDbKKsZB8K+/hodK0za7FuuE4f7y23ywK8+fwt730O+ZVRpyDeApnCl4hQKupXt0 Iw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qr4wh1dk9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 19:31:53 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34MJVm1M025898
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 19:31:48 GMT
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 22 May 2023 12:31:47 -0700
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
To:     <dri-devel@lists.freedesktop.org>, <robdclark@gmail.com>,
        <sean@poorly.run>, <swboyd@chromium.org>, <dianders@chromium.org>,
        <vkoul@kernel.org>, <daniel@ffwll.ch>, <airlied@gmail.com>,
        <agross@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <andersson@kernel.org>
CC:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        <quic_abhinavk@quicinc.com>, <quic_jesszhan@quicinc.com>,
        <quic_sbillaka@quicinc.com>, <marijn.suijten@somainline.org>,
        <freedreno@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v12 04/10] drm/msm/dpu: Guard PINGPONG DSC ops behind DPU_PINGPONG_DSC bit
Date:   Mon, 22 May 2023 12:30:47 -0700
Message-ID: <1684783853-22193-5-git-send-email-quic_khsieh@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1684783853-22193-1-git-send-email-quic_khsieh@quicinc.com>
References: <1684783853-22193-1-git-send-email-quic_khsieh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: zpjOjsKjgq1zAXEOLF3QM1w9-QHJVSSy
X-Proofpoint-GUID: zpjOjsKjgq1zAXEOLF3QM1w9-QHJVSSy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-22_14,2023-05-22_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 impostorscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305220164
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DPU < 7.0.0 has DPU_PINGPONG_DSC feature bit set to indicate it requires
both dpu_hw_pp_setup_dsc() and dpu_hw_pp_dsc_{enable,disable}() to be
executed to complete DSC configuration if DSC hardware block is present.
Hence test DPU_PINGPONG_DSC feature bit and assign DSC related functions
to the ops of PINGPONG block accordingly if DPU_PINGPONG_DSC bit is set.

Changes in v6:
-- split patches, this patch has function handles DPU_PINGPONG_DSC bit

Changes in v9:
-- the original code of assigning dsc related functions to the ops of
   pingpong block without testing the DPU_PINGPONG_DSC feature bit was
   restored back due to rebase error which defeat the purpose of this
   patch. Remove those error code.

Changes in v10:
-- change commit title
-- correct texts at changes in v9

Changes in v12:
-- fixed length too long at Changes in v9

Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c
index 79e4576..437d9e6 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c
@@ -291,9 +291,12 @@ static void _setup_pingpong_ops(struct dpu_hw_pingpong *c,
 		c->ops.get_line_count = dpu_hw_pp_get_line_count;
 		c->ops.disable_autorefresh = dpu_hw_pp_disable_autorefresh;
 	}
-	c->ops.setup_dsc = dpu_hw_pp_setup_dsc;
-	c->ops.enable_dsc = dpu_hw_pp_dsc_enable;
-	c->ops.disable_dsc = dpu_hw_pp_dsc_disable;
+
+	if (test_bit(DPU_PINGPONG_DSC, &features)) {
+		c->ops.setup_dsc = dpu_hw_pp_setup_dsc;
+		c->ops.enable_dsc = dpu_hw_pp_dsc_enable;
+		c->ops.disable_dsc = dpu_hw_pp_dsc_disable;
+	}
 
 	if (test_bit(DPU_PINGPONG_DITHER, &features))
 		c->ops.setup_dither = dpu_hw_pp_setup_dither;
-- 
2.7.4

