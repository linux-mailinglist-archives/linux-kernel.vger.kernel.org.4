Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991AD6EFB03
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 21:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238466AbjDZTX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 15:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjDZTXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 15:23:24 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD564683;
        Wed, 26 Apr 2023 12:23:03 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33QIrxqw011421;
        Wed, 26 Apr 2023 19:22:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=X3KbPkAaZyqX5PWWFmbrqUknCm8qSBqIRTdgqwju13g=;
 b=d8RQsvW71eRNRwFDURCoxrkoNyGLDT/enTkD3ErLhsr9RkL6eHm2IFzgGvoxgJE0u/wy
 GXS9G8fjoMFvVGwGw+rqxuY07inoM4J7/tHXpTvUfei/kQeADibdbM+7tT10fROQJIki
 11tWqwz3gMFuRuPb+wPACmidJvvPLZ/PdMM6D8h3UMeLZb3A8gv5tZ9Q0GIa/dIxZQvL
 +0TIqMsW1u4LviYRFgK0Rg0s1muSWQfvwICj69l3jXIiOONq+tixaEaICIyVbaoN3Ham
 Y1DgMiQEyw1n0+Ht/bfcRdpot7Z0BSij0REWnGsOqpfW+fI+lxqosSeTgVeo3yYm8XK5 sA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q79eug23s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Apr 2023 19:22:58 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33QJMvYH022465
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Apr 2023 19:22:57 GMT
Received: from abhinavk-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 26 Apr 2023 12:22:56 -0700
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
To:     <freedreno@lists.freedesktop.org>, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <quic_jesszhan@quicinc.com>,
        <marijn.suijten@somainline.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/4] drm/msm/dpu: remove DPU_DSPP_GC handling in dspp flush
Date:   Wed, 26 Apr 2023 12:22:43 -0700
Message-ID: <20230426192246.5517-1-quic_abhinavk@quicinc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JKWgvKUEOi9-Rwk6N7r_ZwGtfEvKq2HC
X-Proofpoint-ORIG-GUID: JKWgvKUEOi9-Rwk6N7r_ZwGtfEvKq2HC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-26_10,2023-04-26_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 phishscore=0 suspectscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 impostorscore=0
 mlxlogscore=832 adultscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304260172
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gamma correction blocks (GC) are not used today so lets remove
the usage of DPU_DSPP_GC in the dspp flush to make it easier
to remove GC from the catalog.

We can add this back when GC is properly supported in DPU with
one of the standard DRM properties.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20230421224721.12738-1-quic_abhinavk@quicinc.com
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
index bbdc95ce374a..57adaebab563 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
@@ -336,9 +336,6 @@ static void dpu_hw_ctl_update_pending_flush_dspp_sub_blocks(
 	case DPU_DSPP_PCC:
 		ctx->pending_dspp_flush_mask[dspp - DSPP_0] |= BIT(4);
 		break;
-	case DPU_DSPP_GC:
-		ctx->pending_dspp_flush_mask[dspp - DSPP_0] |= BIT(5);
-		break;
 	default:
 		return;
 	}
-- 
2.40.1

