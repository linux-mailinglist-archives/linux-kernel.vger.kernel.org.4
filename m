Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 616C472D50A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 01:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237816AbjFLXiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 19:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237529AbjFLXiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 19:38:20 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A16B124;
        Mon, 12 Jun 2023 16:38:19 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CNL5Gh019976;
        Mon, 12 Jun 2023 23:38:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : to : cc; s=qcppdkim1;
 bh=nF0oxcJueMu5x7aoa0z57cKbfobnIExcbE0zg1TNeHU=;
 b=SRnfHbLdzXaF1ChbEjrZDNiOKBjdN8M5MNpNFw87S/V8nQriV2G4fz3r9m/57CT4QID1
 RSFSx31gE0q1SK6EtrYc9sOd3+zbzwcGmnre38wRiUSa9OtUK3jr1FGk108GBF+HQKAh
 B8nmva7Adi/CZzSkMaBpVSZIMm+Js4bXkSjki/aoEkQTfV7WgoEAUelMRiOyrzOfGSm6
 cfS8qQV7pdr3TLPrCOBzmcn5eq8ZsEeQCRF7DgHOP1lJBrR/RQ3tR74OO06ukupTP/qs
 WM76bwzz4kAqANetqk+2mrFJWXN/uy4p1K0X16d16iTcAkX76ZbUuKKxKSd/smjlKyz9 Gw== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r68x98cxf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jun 2023 23:38:11 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35CNcAUt031794
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jun 2023 23:38:10 GMT
Received: from jesszhan-linux.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 12 Jun 2023 16:38:10 -0700
From:   Jessica Zhang <quic_jesszhan@quicinc.com>
Date:   Mon, 12 Jun 2023 16:37:36 -0700
Subject: [PATCH] drm/msm/dsi: Enable BURST_MODE for command mode for DSI 6G
 v1.3+
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230608-b4-add-burst-mode-v1-1-55dfbcfada55@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAD+sh2QC/x2NQQqDMBAAvyJ77kK0qbR9Qp/Q4mHXrBpoomS1C
 OLfjT0OzDAbqCQvCs9igyQ/r36MGcpLAe1AsRf0LjNUprqa2tyRLZJzyEvSGcPoBOnGXFpr6kd
 HkDsmFeREsR3O8vXGoAGjrDN+l0D96UxJOr/+v59m3w9wyGUGhwAAAA==
To:     Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        "Daniel Vetter" <daniel@ffwll.ch>
CC:     <quic_abhinavk@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>
X-Mailer: b4 0.13-dev-c6835
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686613090; l=1443;
 i=quic_jesszhan@quicinc.com; s=20230329; h=from:subject:message-id;
 bh=3AkGtxG8lwBTKyEdG06x39OyLfylf84f2+kPxqOtcqI=;
 b=JAHAesW/J4wfvV5wP9axVDLHOPlsZhpT/iM1ivhliyp3ouVWT1acQrqsqHF9UA5yAhESpwRW5
 i3bDV9jxpxVAXra/1DeTxUvCCPr8YoRSPiq1CVyMyuXlF1DpDlNFsDs
X-Developer-Key: i=quic_jesszhan@quicinc.com; a=ed25519;
 pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: E6FXTjbu_VmQieQhUcmIPFNqfwsx4Kwa
X-Proofpoint-ORIG-GUID: E6FXTjbu_VmQieQhUcmIPFNqfwsx4Kwa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_16,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 spamscore=0
 suspectscore=0 mlxlogscore=662 mlxscore=0 adultscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306120204
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During a frame transfer in command mode, there could be frequent
LP11 <-> HS transitions when multiple DCS commands are sent mid-frame or
if the DSI controller is running on slow clock and is throttled. To
minimize frame latency due to these transitions, it is recommended to
send the frame in a single burst.

This feature is supported for DSI 6G 1.3 and above, thus enable burst
mode if supported.

Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
---
 drivers/gpu/drm/msm/dsi/dsi_host.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index 744f2398a6d6..8254b06dca85 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -994,6 +994,11 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
 		dsi_write(msm_host, REG_DSI_CMD_MDP_STREAM0_TOTAL,
 			DSI_CMD_MDP_STREAM0_TOTAL_H_TOTAL(hdisplay) |
 			DSI_CMD_MDP_STREAM0_TOTAL_V_TOTAL(mode->vdisplay));
+
+		if (msm_host->cfg_hnd->major == MSM_DSI_VER_MAJOR_6G &&
+				msm_host->cfg_hnd->minor >= MSM_DSI_6G_VER_MINOR_V1_3)
+			dsi_write(msm_host, REG_DSI_CMD_MODE_MDP_CTRL2,
+					DSI_CMD_MODE_MDP_CTRL2_BURST_MODE);
 	}
 }
 

---
base-commit: dd969f852ba4c66938c71889e826aa8e5300d2f2
change-id: 20230608-b4-add-burst-mode-a5bb144069fa

Best regards,
-- 
Jessica Zhang <quic_jesszhan@quicinc.com>

