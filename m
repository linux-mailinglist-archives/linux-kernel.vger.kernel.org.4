Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22ACD6F692C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 12:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjEDKhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 06:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjEDKhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 06:37:02 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB13E4C2F;
        Thu,  4 May 2023 03:36:51 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 344AWqj5016251;
        Thu, 4 May 2023 10:36:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=hyqZ3bFPRWDVwsGQ+XyTjSaOGixECGiQQNufB++Q97Q=;
 b=N0GLEdulIjIFkHWRxw3Jj0TcEo0xXRn4bXfnJaR3pXbXGSv49f4nwFiImgWmn/VmU/3e
 DmxqXPn79HXFB64Bkor/jbO+cKaAZcLgictNA5Ly/IuUHkjGN/fuxApgTsFb196OFPi1
 YEw5AboD+un32gYQhc4j8dJFjEVZ+K7DdvTrNVFKF2SsIa+zqGyTFGxFfcgBY4x7UTKo
 e7J9ztzn11g6eMrR+tOHNPS8c+c5u+1XrOwQ7uKm1lXSPyvHLcQBVKcCtrLLivFlo98e
 sRHL2rhviPdgHyFdqlnXE68GLKY/a9U/ePXn841Xr8zjbPEeynK2kO61JJ0AyJ8mq450 JQ== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qcb24807m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 May 2023 10:36:48 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 344AXAAu030568;
        Thu, 4 May 2023 10:36:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3q8vakt1qs-1;
        Thu, 04 May 2023 10:36:45 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 344Aafcf002428;
        Thu, 4 May 2023 10:36:45 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-dikshita-hyd.qualcomm.com [10.213.110.13])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 344AaibS002849;
        Thu, 04 May 2023 10:36:45 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
        id 3E7C137B0; Thu,  4 May 2023 16:06:44 +0530 (+0530)
From:   Dikshita Agarwal <quic_dikshita@quicinc.com>
To:     linux-media@vger.kernel.org, stanimir.k.varbanov@gmail.com,
        quic_vgarodia@quicinc.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, mchehab@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Subject: [PATCH 4/4] venus: return P010 as preferred format for 10 bit decode
Date:   Thu,  4 May 2023 16:06:39 +0530
Message-Id: <1683196599-3730-5-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1683196599-3730-1-git-send-email-quic_dikshita@quicinc.com>
References: <1683196599-3730-1-git-send-email-quic_dikshita@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ajyrKPY4Ap9upicX4s8bZDgxu9gF7Xlw
X-Proofpoint-ORIG-GUID: ajyrKPY4Ap9upicX4s8bZDgxu9gF7Xlw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_06,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=884 phishscore=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305040086
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If bit depth is detected as 10 bit by firmware, return
P010 as preferred decoder format to the client.

Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
---
 drivers/media/platform/qcom/venus/vdec.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index 69f7f6e..ed11dc2 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -1468,8 +1468,13 @@ static void vdec_event_change(struct venus_inst *inst,
 	inst->out_width = ev_data->width;
 	inst->out_height = ev_data->height;
 
-	if (inst->bit_depth != ev_data->bit_depth)
+	if (inst->bit_depth != ev_data->bit_depth) {
 		inst->bit_depth = ev_data->bit_depth;
+		if (inst->bit_depth == VIDC_BITDEPTH_10)
+			inst->fmt_cap = &vdec_formats[3];
+		else
+			inst->fmt_cap = &vdec_formats[0];
+	}
 
 	if (inst->pic_struct != ev_data->pic_struct)
 		inst->pic_struct = ev_data->pic_struct;
-- 
2.7.4

