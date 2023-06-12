Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7957C72D3FF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 00:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238299AbjFLWDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 18:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233166AbjFLWDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 18:03:15 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6564E7B;
        Mon, 12 Jun 2023 15:03:14 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CLvLOe018283;
        Mon, 12 Jun 2023 22:03:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=FBxG8QsZ08lg0WK0Ayh+eBz21ZlXnvAAso2cOjBwOMo=;
 b=KyqlKkjv7dqAOryma9yEsV4gdJC+wORPUQQhJp5nzXds+j2zPje6D3tH+dNP2ftFDH4c
 f2cxgnScoJGHLMYEuYrNwLXurZcad9dAu6sQD2OB/ONV5cBCP/39r14nSyoOl22Y35MN
 kVoaWjtNmab//LFo4ZpGbukR4I2Ltty6f8z7Xbly7IAlpoetDqYsrAjCmPmhAjy2f230
 Tk09zu+SNknRSiUFq3/J9AFyIONwzIlCl2pctdElDazdp1Dn8lQAdTjfZHapzgOyjgtv
 aWW+zo417UF/oEjdr5TNn8fY+wt2dmNf5b5tE0pqE6TTxVrB0yBjHYK50qsG4/62i043 nQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r60pesf1g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jun 2023 22:03:07 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35CM34kE027143
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jun 2023 22:03:05 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 12 Jun 2023 15:03:04 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
CC:     Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        Johan Hovold <johan+linaro@kernel.org>,
        "Vinod Polimera" <quic_vpolimer@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/msm/dp: Free resources after unregistering them
Date:   Mon, 12 Jun 2023 15:02:59 -0700
Message-ID: <20230612220259.1884381-1-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: CJJ-sO0Qic8LssHLIuQkVC5JOdUaEQ_J
X-Proofpoint-ORIG-GUID: CJJ-sO0Qic8LssHLIuQkVC5JOdUaEQ_J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_16,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 impostorscore=0 mlxscore=0
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306120189
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DP component's unbind operation walks through the submodules to
unregister and clean things up. But if the unbind happens because the DP
controller itself is being removed, all the memory for those submodules
has just been freed.

Change the order of these operations to avoid the many use-after-free
that otherwise happens in this code path.

Fixes: c943b4948b58 ("drm/msm/dp: add displayPort driver support")
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index bbb0550a022b..ebc84b8fddf8 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -1337,9 +1337,9 @@ static int dp_display_remove(struct platform_device *pdev)
 {
 	struct dp_display_private *dp = dev_get_dp_display_private(&pdev->dev);
 
+	component_del(&pdev->dev, &dp_display_comp_ops);
 	dp_display_deinit_sub_modules(dp);
 
-	component_del(&pdev->dev, &dp_display_comp_ops);
 	platform_set_drvdata(pdev, NULL);
 
 	return 0;
-- 
2.25.1

