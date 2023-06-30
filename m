Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677A37431AD
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 02:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbjF3A0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 20:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjF3A0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 20:26:07 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB0F30DD;
        Thu, 29 Jun 2023 17:26:05 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35U0DKgu030275;
        Fri, 30 Jun 2023 00:25:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=hJhHS+CeuDQckFgfilFOi4hctm6d0kpkU05KwtnJmDo=;
 b=jElJzj+jlRbSI6pVdfhFxnPfyu1D26fJG2TjIiL/c6l5xTzA1p0sSG9CvdBFARfZkmTf
 KqKUWqmgnTlBcVNQxfEO4CtLzKqKQbYLbf/QTf0tkS15TV4MhyxX6zt9bPqhzT1MZJaU
 2ZEgrrhXNx9Vgm1F/I5uS0uk0ecsBEm1HwWFeKbiWmzg75QMENCTQgR1ktR/28gzI58o
 p8IklmN98YmHfK8W9jOwf2cq8TE0NN4iDpxib1kc0SynKyjlamgtlSZ3nmHtKIUq8P4d
 lIMA91Tk64Yw0KswnjCxQrgmCoAajU6K/oSZElVgdErrAinW2SJ6UCJDD6seg5vYvqvj ew== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rhfew8hm4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 00:25:38 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35U0Pb73021947
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 00:25:37 GMT
Received: from jesszhan-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 29 Jun 2023 17:25:37 -0700
From:   Jessica Zhang <quic_jesszhan@quicinc.com>
Date:   Thu, 29 Jun 2023 17:25:04 -0700
Subject: [PATCH RFC v4 5/7] drm/msm/dpu: Add solid fill and pixel source
 properties
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230404-solid-fill-v4-5-f4ec0caa742d@quicinc.com>
References: <20230404-solid-fill-v4-0-f4ec0caa742d@quicinc.com>
In-Reply-To: <20230404-solid-fill-v4-0-f4ec0caa742d@quicinc.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        "Sean Paul" <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>
CC:     <quic_abhinavk@quicinc.com>, <ppaalanen@gmail.com>,
        <contact@emersion.fr>, <laurent.pinchart@ideasonboard.com>,
        <sebastian.wick@redhat.com>, <ville.syrjala@linux.intel.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <freedreno@lists.freedesktop.org>,
        <wayland-devel@lists.freedesktop.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>
X-Mailer: b4 0.13-dev-c6835
X-Developer-Signature: v=1; a=ed25519-sha256; t=1688084735; l=909;
 i=quic_jesszhan@quicinc.com; s=20230329; h=from:subject:message-id;
 bh=g04EkSn+AIc/7kssuO+qpNbFCz+Ys7Fj95l36WWwzg8=;
 b=J6ZmhrWsEBthTVugS8Ej9wkUIfTrxobmwl6WxVJnTtPf9jIObDRyh2d2cctykSw98o39aHGAE
 22QDFCGMNmjCgfx96/wLClpLJku68O74/5CiIt+08axjd0IqvyrBqDU
X-Developer-Key: i=quic_jesszhan@quicinc.com; a=ed25519;
 pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: jxgfGsmlo8yRGUvlWrmuXLnKZRewFBV-
X-Proofpoint-GUID: jxgfGsmlo8yRGUvlWrmuXLnKZRewFBV-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-29_10,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 clxscore=1015 spamscore=0 mlxlogscore=727 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306300002
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add solid_fill and pixel_source properties to DPU plane

Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
index c2aaaded07ed..5f0984ce62b1 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
@@ -1429,6 +1429,8 @@ struct drm_plane *dpu_plane_init(struct drm_device *dev,
 		DPU_ERROR("failed to install zpos property, rc = %d\n", ret);
 
 	drm_plane_create_alpha_property(plane);
+	drm_plane_create_solid_fill_property(plane);
+	drm_plane_create_pixel_source_property(plane, BIT(DRM_PLANE_PIXEL_SOURCE_COLOR));
 	drm_plane_create_blend_mode_property(plane,
 			BIT(DRM_MODE_BLEND_PIXEL_NONE) |
 			BIT(DRM_MODE_BLEND_PREMULTI) |

-- 
2.41.0

