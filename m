Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4E472A684
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 01:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjFIXBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 19:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjFIXBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 19:01:21 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7732F3A9B;
        Fri,  9 Jun 2023 16:01:19 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 359Mbx4K024531;
        Fri, 9 Jun 2023 23:01:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=u4274tyHRcroppExO4k0UDStKbWdM9Bg19PBhVTjHOs=;
 b=M6B8nTlfUFiyreNsobWcEtaSuoj3TFoSGqdN3KV4gaQCYZVAAjIeZ+xnldbmOw5Vxho8
 RKxxN5S8drfe7TJ3xU02ME/wPGWw4cORX9bfaCmtMmfUeQp/8hs/aeAq58QuSUx2hQc+
 tE6t1zflqA0ripEF2732kCbyzMCLdUME9wP7S/vYmKCcPDKfLuEa5Z87sjXCybPHWXjq
 /jT3vzSVd93xZLyCgZ9m0rYcwL7aYaCGmarG8ePjPUKB++vb5hZtzBLZZANKLrK2bhir
 5fe8icZpzkn0m6IYknlSnyPt/7FyRbHBxCqO0QM/kAyuWhU77xl73oZDWkvoktBOaXoZ ww== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r3t70j9u9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jun 2023 23:01:11 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 359N1ArS031621
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 9 Jun 2023 23:01:10 GMT
Received: from jesszhan-linux.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 9 Jun 2023 16:01:10 -0700
From:   Jessica Zhang <quic_jesszhan@quicinc.com>
Date:   Fri, 9 Jun 2023 15:57:14 -0700
Subject: [PATCH v6 2/6] drm/msm/dsi: Reduce pclk rate for compression
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230405-add-dsc-support-v6-2-95eab864d1b6@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686351669; l=2474;
 i=quic_jesszhan@quicinc.com; s=20230329; h=from:subject:message-id;
 bh=ZFBFEqy3T24BhuHHCYmydthxOclItYdfWY8Kbr5xQ00=;
 b=RV2Hb8R/OdChuJlvNoc5E12xZ4hEoTUAwuFLIpt5LbvY9c51XDc1Glu0r8QCTZ/pwJDy443ke
 R5zy+iJz996C+22WDourDyTEqh/Tk6kDnb9aWo6wnrOY933EINa04Af
X-Developer-Key: i=quic_jesszhan@quicinc.com; a=ed25519;
 pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fJA_MVClB8ayXT1-g3Lr2ZLD_YvhTZSf
X-Proofpoint-ORIG-GUID: fJA_MVClB8ayXT1-g3Lr2ZLD_YvhTZSf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-09_16,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 clxscore=1015 suspectscore=0
 bulkscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999 phishscore=0
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

Adjust the pclk rate to divide hdisplay by the compression ratio when DSC
is enabled.

Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
---
 drivers/gpu/drm/msm/dsi/dsi_host.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index a448931af804..98ea1da492c7 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -561,12 +561,27 @@ void dsi_link_clk_disable_v2(struct msm_dsi_host *msm_host)
 	clk_disable_unprepare(msm_host->byte_clk);
 }
 
-static unsigned long dsi_get_pclk_rate(const struct drm_display_mode *mode, bool is_bonded_dsi)
+static unsigned long dsi_adjust_pclk_for_compression(const struct drm_display_mode *mode,
+		const struct drm_dsc_config *dsc)
+{
+	int new_hdisplay = DIV_ROUND_UP(mode->hdisplay * drm_dsc_get_bpp_int(dsc),
+			dsc->bits_per_component * 3);
+
+	int new_htotal = mode->htotal - mode->hdisplay + new_hdisplay;
+
+	return new_htotal * mode->vtotal * drm_mode_vrefresh(mode);
+}
+
+static unsigned long dsi_get_pclk_rate(const struct drm_display_mode *mode,
+		const struct drm_dsc_config *dsc, bool is_bonded_dsi)
 {
 	unsigned long pclk_rate;
 
 	pclk_rate = mode->clock * 1000;
 
+	if (dsc)
+		pclk_rate = dsi_adjust_pclk_for_compression(mode, dsc);
+
 	/*
 	 * For bonded DSI mode, the current DRM mode has the complete width of the
 	 * panel. Since, the complete panel is driven by two DSI controllers,
@@ -585,7 +600,7 @@ unsigned long dsi_byte_clk_get_rate(struct mipi_dsi_host *host, bool is_bonded_d
 	struct msm_dsi_host *msm_host = to_msm_dsi_host(host);
 	u8 lanes = msm_host->lanes;
 	u32 bpp = dsi_get_bpp(msm_host->format);
-	unsigned long pclk_rate = dsi_get_pclk_rate(mode, is_bonded_dsi);
+	unsigned long pclk_rate = dsi_get_pclk_rate(mode, msm_host->dsc, is_bonded_dsi);
 	unsigned long pclk_bpp;
 
 	if (lanes == 0) {
@@ -604,7 +619,7 @@ unsigned long dsi_byte_clk_get_rate(struct mipi_dsi_host *host, bool is_bonded_d
 
 static void dsi_calc_pclk(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
 {
-	msm_host->pixel_clk_rate = dsi_get_pclk_rate(msm_host->mode, is_bonded_dsi);
+	msm_host->pixel_clk_rate = dsi_get_pclk_rate(msm_host->mode, msm_host->dsc, is_bonded_dsi);
 	msm_host->byte_clk_rate = dsi_byte_clk_get_rate(&msm_host->base, is_bonded_dsi,
 							msm_host->mode);
 

-- 
2.40.1

