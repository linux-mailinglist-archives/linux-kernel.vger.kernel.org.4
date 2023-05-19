Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E1970A17F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 23:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbjESVSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 17:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjESVRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 17:17:47 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC56F1B3;
        Fri, 19 May 2023 14:17:45 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34JL9uK4016442;
        Fri, 19 May 2023 21:17:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=2Ertg4tnoqpHRfZd1p0T6g/wNPIvU3qyPjVVSgSnAkg=;
 b=e/AM0AMeqYKX9ZNfs9QBeI3CSjCu80Z/froZqdBDJmoviHUZ46cb0xwFnAoyvwuD9e9j
 mhEF3+vlM6KEEeiaHqXuKyDVXwkmuSckXa/cV68IIqUKT6ZKpl1eh4DDn01CYuHL9bbM
 LoMqgP74yOLKVcWguZJoCfBl/FWxF3lRhB947gfFb1RbyKZ5TXVrObdJTu9hi45u0C67
 uUsQRjH1QNwY/sAsV4+caMoUtvEQZVwBX1werbnEuXkQsHI6keiPlT9Ep2ZvGmSQ8bhh
 m0oSK8vo7cPkTu/012cEXa6IakQtJrrJh5i0Jqh1F2/hOvWOqFSn4PUJDhWIu1dkXJh8 /g== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qp57y1tdv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 21:17:37 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34JLHaYK021551
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 21:17:36 GMT
Received: from jesszhan-linux.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 19 May 2023 14:17:36 -0700
From:   Jessica Zhang <quic_jesszhan@quicinc.com>
Date:   Fri, 19 May 2023 14:17:27 -0700
Subject: [PATCH v3 2/5] drm/msm/dsi: Adjust pclk rate for compression
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230405-add-dsc-support-v3-2-6e1d35a206b3@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684531055; l=2874;
 i=quic_jesszhan@quicinc.com; s=20230329; h=from:subject:message-id;
 bh=iKEm4Xl//e3OX7oqUMvtCRTjCz4YPOSNKsawStDYbY8=;
 b=V2mKcF87Rtx/tQRaA3YPJFoYrcQtyWpZYd2YKY3NhPfe9BkW/W5Vzms1sQ3RkfxFZTp74/+N9
 Xn3Kt+hShqLDkAbTeMMWEMXQbDSJ38stKSFtJGenJqwEancXgkfdKM2
X-Developer-Key: i=quic_jesszhan@quicinc.com; a=ed25519;
 pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: P5cpE0bj5pROfYHy3VeLEd9r5wDDgCIu
X-Proofpoint-ORIG-GUID: P5cpE0bj5pROfYHy3VeLEd9r5wDDgCIu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_16,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305190184
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust the pclk rate to divide hdisplay by the compression ratio when DSC
is enabled.

Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
---
 drivers/gpu/drm/msm/dsi/dsi_host.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index 18d38b90eb28..d04f8bbd707d 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -561,7 +561,18 @@ void dsi_link_clk_disable_v2(struct msm_dsi_host *msm_host)
 	clk_disable_unprepare(msm_host->byte_clk);
 }
 
-static unsigned long dsi_get_pclk_rate(const struct drm_display_mode *mode, bool is_bonded_dsi)
+static unsigned long dsi_adjust_compressed_pclk(const struct drm_display_mode *mode,
+		const struct drm_dsc_config *dsc)
+{
+	int new_hdisplay = DIV_ROUND_UP(mode->hdisplay * drm_dsc_get_bpp_int(dsc),
+			dsc->bits_per_component * 3);
+
+	return (new_hdisplay + (mode->htotal - mode->hdisplay))
+			* mode->vtotal * drm_mode_vrefresh(mode);
+}
+
+static unsigned long dsi_get_pclk_rate(const struct drm_display_mode *mode,
+		const struct drm_dsc_config *dsc, bool is_bonded_dsi)
 {
 	unsigned long pclk_rate;
 
@@ -576,6 +587,10 @@ static unsigned long dsi_get_pclk_rate(const struct drm_display_mode *mode, bool
 	if (is_bonded_dsi)
 		pclk_rate /= 2;
 
+	/* If DSC is enabled, divide hdisplay by compression ratio */
+	if (dsc)
+		pclk_rate = dsi_adjust_compressed_pclk(mode, dsc);
+
 	return pclk_rate;
 }
 
@@ -585,7 +600,7 @@ unsigned long dsi_byte_clk_get_rate(struct mipi_dsi_host *host, bool is_bonded_d
 	struct msm_dsi_host *msm_host = to_msm_dsi_host(host);
 	u8 lanes = msm_host->lanes;
 	u32 bpp = dsi_get_bpp(msm_host->format);
-	unsigned long pclk_rate = dsi_get_pclk_rate(mode, is_bonded_dsi);
+	unsigned long pclk_rate = dsi_get_pclk_rate(mode, msm_host->dsc, is_bonded_dsi);
 	u64 pclk_bpp = (u64)pclk_rate * bpp;
 
 	if (lanes == 0) {
@@ -604,7 +619,7 @@ unsigned long dsi_byte_clk_get_rate(struct mipi_dsi_host *host, bool is_bonded_d
 
 static void dsi_calc_pclk(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
 {
-	msm_host->pixel_clk_rate = dsi_get_pclk_rate(msm_host->mode, is_bonded_dsi);
+	msm_host->pixel_clk_rate = dsi_get_pclk_rate(msm_host->mode, msm_host->dsc, is_bonded_dsi);
 	msm_host->byte_clk_rate = dsi_byte_clk_get_rate(&msm_host->base, is_bonded_dsi,
 							msm_host->mode);
 
@@ -634,7 +649,7 @@ int dsi_calc_clk_rate_v2(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
 
 	dsi_calc_pclk(msm_host, is_bonded_dsi);
 
-	pclk_bpp = (u64)dsi_get_pclk_rate(msm_host->mode, is_bonded_dsi) * bpp;
+	pclk_bpp = (u64)dsi_get_pclk_rate(msm_host->mode, msm_host->dsc, is_bonded_dsi) * bpp;
 	do_div(pclk_bpp, 8);
 	msm_host->src_clk_rate = pclk_bpp;
 

-- 
2.40.1

