Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0CC72A672
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 01:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbjFIXBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 19:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjFIXBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 19:01:20 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCC230D7;
        Fri,  9 Jun 2023 16:01:19 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 359MONRk031585;
        Fri, 9 Jun 2023 23:01:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=6A/lO1VqhowarPXi8xTZes5iWB0q1LQ9L8/ixOZVTZI=;
 b=cdjNi/hK7SMiWXA5Mf43If0UcFg6mgnurgr+vkwhUrwSq6SbA87+g1PXaQxNuxhQ/LOk
 vy7kJ3lN/6XHUoiOfsGvJifbq2yU0ATtFhAsjSnWIIw3JQRyn7dxvjyVKNu7RcVsoMJO
 lgVlc+WrcT+wsUHPPp9C5jz6q0uMvIOALRTu/dJY7xMECZ28e5he7ueuUNn30Mm2jvmh
 YsxnBCiXJSn06DMY0qmKbCCS9HIXx30zlLKmTqlZnOLEuyNK/9n9u2KDq4nf3AV/Y1Ap
 4qWiH26OsxDC+t/cA3G3ZnOzhpOghT0r+IKiTEuoFQ8VCehY8vQIhfb4j3PAS70P7H9m 0g== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r3t70j9ue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jun 2023 23:01:12 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 359N1B64032720
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 9 Jun 2023 23:01:11 GMT
Received: from jesszhan-linux.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 9 Jun 2023 16:01:11 -0700
From:   Jessica Zhang <quic_jesszhan@quicinc.com>
Date:   Fri, 9 Jun 2023 15:57:18 -0700
Subject: [PATCH v6 6/6] drm/msm/dsi: Document DSC related pclk_rate and
 hdisplay calculations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230405-add-dsc-support-v6-6-95eab864d1b6@quicinc.com>
References: <20230405-add-dsc-support-v6-0-95eab864d1b6@quicinc.com>
In-Reply-To: <20230405-add-dsc-support-v6-0-95eab864d1b6@quicinc.com>
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
X-Mailer: b4 0.13-dev-c6835
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686351669; l=1473;
 i=quic_jesszhan@quicinc.com; s=20230329; h=from:subject:message-id;
 bh=uR0RLPcseyLdEEjwpKbYoijamy2EY5+2eV/daX0qaQs=;
 b=SUWf4A4soRQ7eSVeYk5Kqa3hJ7C2pDs3roe/hqQzFHEr3FOnFVA+lakQrwPLlmsJm/crYJi+v
 eCauXdCM/ZBD2tP2svFWop3/FkzU0wHLQp4uQq1rRpJdBbfWuaQd6gb
X-Developer-Key: i=quic_jesszhan@quicinc.com; a=ed25519;
 pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1Y0p-tOC1tD4d_PegcqO8AmtRNt_PHOM
X-Proofpoint-ORIG-GUID: 1Y0p-tOC1tD4d_PegcqO8AmtRNt_PHOM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-09_16,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 clxscore=1015 suspectscore=0
 bulkscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=991 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306090195
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation comments explaining the pclk_rate and hdisplay math
related to DSC.

Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
---
 drivers/gpu/drm/msm/dsi/dsi_host.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index fb1d3a25765f..aeaadc18bc7b 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -564,6 +564,13 @@ void dsi_link_clk_disable_v2(struct msm_dsi_host *msm_host)
 static unsigned long dsi_adjust_pclk_for_compression(const struct drm_display_mode *mode,
 		const struct drm_dsc_config *dsc)
 {
+	/*
+	 * Adjust the pclk rate by calculating a new hdisplay proportional to
+	 * the compression ratio such that:
+	 *     new_hdisplay = old_hdisplay * target_bpp / source_bpp
+	 *
+	 * Porches need not be adjusted during compression.
+	 */
 	int new_hdisplay = DIV_ROUND_UP(mode->hdisplay * drm_dsc_get_bpp_int(dsc),
 			dsc->bits_per_component * 3);
 
@@ -961,6 +968,9 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
 
 		/* Divide the display by 3 but keep back/font porch and
 		 * pulse width same
+		 *
+		 * hdisplay will be divided by 3 here to account for the fact
+		 * that DPU sends 3 bytes per pclk cycle to DSI.
 		 */
 		h_total -= hdisplay;
 		hdisplay = DIV_ROUND_UP(msm_dsc_get_bytes_per_line(msm_host->dsc), 3);

-- 
2.40.1

