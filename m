Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60BFF6F8ABF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 23:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbjEEVYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 17:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232792AbjEEVYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 17:24:12 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86266A3;
        Fri,  5 May 2023 14:24:11 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 345LGLj0027415;
        Fri, 5 May 2023 21:24:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=uF3VIzx4IwC21DQbpIefb6k4caeYIFUcpPHCNX/lBbo=;
 b=AMIgK8NCM6I3uu1dRHr5X85TJ8fXKAaB+JeUvg6+yHhD3LzOtRoZH5M7qcw98QBeB3AV
 ThY56pcLpP1yNCyvkVzMb8J0Sy5rynZCfCR9uOkBcInKOlB+3fR+b6LNXafhR0EEaKc8
 z3v64Gfk3k2HCNDXbZt/YDBu5JhYGpOcDml/96s6R+Osjo4dSSsn5FyiMKM6IEeWI/MP
 0OD83aD1ie1KuCoQhje66NwzqsJMSBIFSdqkPPdvDixYW7SiD9v+xWTya1/1+x55FCEg
 avOZuyORR7QUx8AzhpC96/MVTc5x7nrFpdlmmU/Nb2zlWcN89gm90Q8imstpzdosnyf9 jQ== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qd3hrgw27-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 May 2023 21:24:04 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 345LO4bX031798
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 5 May 2023 21:24:04 GMT
Received: from jesszhan-linux.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 5 May 2023 14:24:03 -0700
From:   Jessica Zhang <quic_jesszhan@quicinc.com>
Date:   Fri, 5 May 2023 14:23:49 -0700
Subject: [PATCH v2 2/4] drm/msm/dsi: Fix compressed word count calculation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230405-add-dsc-support-v2-2-1072c70e9786@quicinc.com>
References: <20230405-add-dsc-support-v2-0-1072c70e9786@quicinc.com>
In-Reply-To: <20230405-add-dsc-support-v2-0-1072c70e9786@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1683321843; l=1835;
 i=quic_jesszhan@quicinc.com; s=20230329; h=from:subject:message-id;
 bh=dj1STSigYt2hwxL1JPzulKjaVnUdQAnxUQMk0hFmBBI=;
 b=XLyzK9brVE5Z+YnPa4OHwWpi6UeZ3RUtwzBS2EP5PGuns8HnzdEojRWCLBpwy8ruCqasotXVY
 dTh3xcnqyOZC5FNVh/6WuwsdOnYAJMgR5qyhfepZzIx5vgREM4ouXP8
X-Developer-Key: i=quic_jesszhan@quicinc.com; a=ed25519;
 pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: CzmhTGL-yMOzkiF2lVRbDs3pzaH0Ujah
X-Proofpoint-GUID: CzmhTGL-yMOzkiF2lVRbDs3pzaH0Ujah
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_27,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305050173
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, word count is calculated using slice_count. This is incorrect
as downstream uses slice per packet, which is different from
slice_count.

Slice count represents the number of soft slices per interface, and its
value will not always match that of slice per packet. For example, it is
possible to have cases where there are multiple soft slices per interface
but the panel specifies only one slice per packet.

Thus, use the default value of one slice per packet and remove slice_count
from the word count calculation.

Changes in v2:
- "drm_panel" -> "mipi_dsi_device" in TODO comment

Fixes: bc6b6ff8135c ("drm/msm/dsi: Use DSC slice(s) packet size to compute word count")
Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
---
 drivers/gpu/drm/msm/dsi/dsi_host.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index 0e5778e8091f..f6fb32e2223c 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -999,7 +999,14 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
 		if (!msm_host->dsc)
 			wc = hdisplay * dsi_get_bpp(msm_host->format) / 8 + 1;
 		else
-			wc = msm_host->dsc->slice_chunk_size * msm_host->dsc->slice_count + 1;
+			/*
+			 * When DSC is enabled, WC = slice_chunk_size * slice_per_packet + 1.
+			 * Currently, the driver only supports default value of slice_per_packet = 1
+			 *
+			 * TODO: Expand mipi_dsi_device struct to hold slice_per_packet info
+			 *       and adjust DSC math to account for slice_per_packet.
+			 */
+			wc = msm_host->dsc->slice_chunk_size + 1;
 
 		dsi_write(msm_host, REG_DSI_CMD_MDP_STREAM0_CTRL,
 			DSI_CMD_MDP_STREAM0_CTRL_WORD_COUNT(wc) |

-- 
2.40.1

