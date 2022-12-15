Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0750D64DD76
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 16:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiLOPMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 10:12:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbiLOPMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 10:12:17 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35C02FBFF;
        Thu, 15 Dec 2022 07:12:13 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BFE2fkI022795;
        Thu, 15 Dec 2022 15:11:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=+TNCVzAQc98dTTmqznrkrdANu0/8YBru4BYnBEttDw4=;
 b=hdst9ulbSI8EKLG2AfSiiebuGOmV7B8u+j6qYdk6JZ5HXf3T5cVgrO/CKd0E2NFlZFaj
 DhtUG9py5pTS/jwmFUVi8QM/vATFOJWEMMTcnitvA2at54nYXUFZyI3i2JzpdI1U6gjA
 EWMjPml/UmAfleqzWYMh31dJcCQhOuBWLbMZuNY1ZVvJ0K+E7iE5a5RGUC3ovhnYyXqS
 zu2S+JwY1/Sgke6i9/eOCwoQz//xBO4Qd7zUO/quTrD+7bu7SQqh57JP+rg6cwcQ/3QD
 Lln2C1tfW3h4XZ52ugcemPyVqv7YRXFC2crZ1A7MvZJl+SyeICAizDvEHu0h70MR68Bu RA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mf6rrmxk0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Dec 2022 15:11:53 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BFFBoSB003106
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Dec 2022 15:11:51 GMT
Received: from hyd-lnxbld559.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 15 Dec 2022 07:11:44 -0800
From:   Akhil P Oommen <quic_akhilpo@quicinc.com>
To:     freedreno <freedreno@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
CC:     Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Sean Paul <sean@poorly.run>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/5] drm/msm/a6xx: Use genpd notifier to ensure cx-gdsc collapse
Date:   Thu, 15 Dec 2022 20:41:01 +0530
Message-ID: <20221215203751.5.I9e10545c6a448d5eb1b734839b871d1b3146dac3@changeid>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1671117062-26276-1-git-send-email-quic_akhilpo@quicinc.com>
References: <1671117062-26276-1-git-send-email-quic_akhilpo@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zeDPXzdPU7fKN7rVHZn3xom3pZpOjTQV
X-Proofpoint-ORIG-GUID: zeDPXzdPU7fKN7rVHZn3xom3pZpOjTQV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-15_08,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 phishscore=0 malwarescore=0 impostorscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212150123
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per the recommended recovery sequence of adreno gpu, cx gdsc should
collapse at hardware before it is turned back ON. This helps to clear
out the stale states in hardware before it is reinitialized. Use the
genpd notifier along with the newly introduced
dev_pm_genpd_synced_poweroff() api to ensure that cx gdsc has collapsed
before we turn it back ON.

Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
---

 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 15 +++++++++++++++
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h |  6 ++++++
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 11 +++++++++++
 3 files changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 1580d0090f35..c03830957c26 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -1507,6 +1507,17 @@ void a6xx_gmu_remove(struct a6xx_gpu *a6xx_gpu)
 	gmu->initialized = false;
 }
 
+static int cxpd_notifier_cb(struct notifier_block *nb,
+			unsigned long action, void *data)
+{
+	struct a6xx_gmu *gmu = container_of(nb, struct a6xx_gmu, pd_nb);
+
+	if (action == GENPD_NOTIFY_OFF)
+		complete_all(&gmu->pd_gate);
+
+	return 0;
+}
+
 int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
 {
 	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
@@ -1640,6 +1651,10 @@ int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
 		goto detach_cxpd;
 	}
 
+	init_completion(&gmu->pd_gate);
+	complete_all(&gmu->pd_gate);
+	gmu->pd_nb.notifier_call = cxpd_notifier_cb;
+
 	/*
 	 * Get a link to the GX power domain to reset the GPU in case of GMU
 	 * crash
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
index 5a42dd4dd31f..0bc3eb443fec 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
@@ -4,8 +4,10 @@
 #ifndef _A6XX_GMU_H_
 #define _A6XX_GMU_H_
 
+#include <linux/completion.h>
 #include <linux/iopoll.h>
 #include <linux/interrupt.h>
+#include <linux/notifier.h>
 #include "msm_drv.h"
 #include "a6xx_hfi.h"
 
@@ -90,6 +92,10 @@ struct a6xx_gmu {
 	bool initialized;
 	bool hung;
 	bool legacy; /* a618 or a630 */
+
+	/* For power domain callback */
+	struct notifier_block pd_nb;
+	struct completion pd_gate;
 };
 
 static inline u32 gmu_read(struct a6xx_gmu *gmu, u32 offset)
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 4b16e75dfa50..dd618b099110 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -10,6 +10,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/devfreq.h>
+#include <linux/pm_domain.h>
 #include <linux/soc/qcom/llcc-qcom.h>
 
 #define GPU_PAS_ID 13
@@ -1258,6 +1259,7 @@ static void a6xx_recover(struct msm_gpu *gpu)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
 	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
+	struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
 	int i, active_submits;
 
 	adreno_dump_info(gpu);
@@ -1290,6 +1292,10 @@ static void a6xx_recover(struct msm_gpu *gpu)
 	 */
 	gpu->active_submits = 0;
 
+	reinit_completion(&gmu->pd_gate);
+	dev_pm_genpd_add_notifier(gmu->cxpd, &gmu->pd_nb);
+	dev_pm_genpd_synced_poweroff(gmu->cxpd);
+
 	/* Drop the rpm refcount from active submits */
 	if (active_submits)
 		pm_runtime_put(&gpu->pdev->dev);
@@ -1297,6 +1303,11 @@ static void a6xx_recover(struct msm_gpu *gpu)
 	/* And the final one from recover worker */
 	pm_runtime_put_sync(&gpu->pdev->dev);
 
+	if (!wait_for_completion_timeout(&gmu->pd_gate, msecs_to_jiffies(1000)))
+		DRM_DEV_ERROR(&gpu->pdev->dev, "cx gdsc didn't collapse\n");
+
+	dev_pm_genpd_remove_notifier(gmu->cxpd);
+
 	pm_runtime_use_autosuspend(&gpu->pdev->dev);
 
 	if (active_submits)
-- 
2.7.4

