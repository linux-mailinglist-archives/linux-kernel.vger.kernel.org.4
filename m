Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 174245ED5D6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 09:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbiI1HUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 03:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233410AbiI1HUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 03:20:09 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5F110FFC;
        Wed, 28 Sep 2022 00:20:04 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28S5XAT8031779;
        Wed, 28 Sep 2022 07:19:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=ptAp81tTYiqQkYXMiOQMfTlvGSo562gUuwCLSQk+Kwk=;
 b=KpW5ovxpCS1En1rCViwAkwkeiEIs99ZI46d+NFfvbMD5bWvD4/fJCAHCvDzLDBTVwP2j
 B62odRURoiFwKjDG3Jd108hbfk7iYxQndAS4pFOa3DJ+NDTEKdfNyQ3TPaxF3yDVuIYj
 DESk5YLEHa7XpjTMYBMadru8vEV1ksNbXTOygRxiynMmrarziiOO/AIrxdwweNN2z4Uz
 WBxbc1Lg1bBCNjjk/DnJkvMPE/lNxLirVPAKhN1fzywTeOxkMWa9ucbEibfK9lOgU3b+
 pkLiAr8AGicuaUlndBxAdF/RJ2tXYvvaTaoyZuTJP1KAuD1e68+45Dd9ofW6GQuOfCQV 0A== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3juwru42jd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Sep 2022 07:19:30 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28S7JTwT027164
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Sep 2022 07:19:29 GMT
Received: from hyd-lnxbld559.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 28 Sep 2022 00:19:23 -0700
From:   Akhil P Oommen <quic_akhilpo@quicinc.com>
To:     freedreno <freedreno@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>
CC:     Jonathan Marek <jonathan@marek.ca>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Sean Paul <sean@poorly.run>,
        "Vladimir Lypak" <vladimir.lypak@gmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] drm/msm/gpu: Fix crash during system suspend after unbind
Date:   Wed, 28 Sep 2022 12:49:00 +0530
Message-ID: <20220928124830.2.I5ee0ac073ccdeb81961e5ec0cce5f741a7207a71@changeid>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20220928124830.1.I8ea24a8d586b4978823b848adde000f92f74d5c2@changeid>
References: <20220928124830.1.I8ea24a8d586b4978823b848adde000f92f74d5c2@changeid>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QbvX70lX0tv8POGZLNW_qBuZkeLP_tn7
X-Proofpoint-ORIG-GUID: QbvX70lX0tv8POGZLNW_qBuZkeLP_tn7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-28_02,2022-09-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1011 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209280043
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In adreno_unbind, we should clean up gpu device's drvdata to avoid
accessing a stale pointer during system suspend. Also, check for NULL
ptr in both system suspend/resume callbacks.

Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
---
Rebased on msm-next + some external fixes to boot sc7280 device.

 drivers/gpu/drm/msm/adreno/adreno_device.c | 10 +++++++++-
 drivers/gpu/drm/msm/msm_gpu.c              |  2 ++
 drivers/gpu/drm/msm/msm_gpu.h              |  4 ++++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 24b489b..6288064 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -679,6 +679,9 @@ static int adreno_system_suspend(struct device *dev)
 	struct msm_gpu *gpu = dev_to_gpu(dev);
 	int remaining, ret;
 
+	if (!gpu)
+		return 0;
+
 	suspend_scheduler(gpu);
 
 	remaining = wait_event_timeout(gpu->retire_event,
@@ -700,7 +703,12 @@ static int adreno_system_suspend(struct device *dev)
 
 static int adreno_system_resume(struct device *dev)
 {
-	resume_scheduler(dev_to_gpu(dev));
+	struct msm_gpu *gpu = dev_to_gpu(dev);
+
+	if (!gpu)
+		return 0;
+
+	resume_scheduler(gpu);
 	return pm_runtime_force_resume(dev);
 }
 
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 0098ee8..021f4e2 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -997,4 +997,6 @@ void msm_gpu_cleanup(struct msm_gpu *gpu)
 	}
 
 	msm_devfreq_cleanup(gpu);
+
+	platform_set_drvdata(gpu->pdev, NULL);
 }
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index ff911e73..58a72e6 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -280,6 +280,10 @@ struct msm_gpu {
 static inline struct msm_gpu *dev_to_gpu(struct device *dev)
 {
 	struct adreno_smmu_priv *adreno_smmu = dev_get_drvdata(dev);
+
+	if (!adreno_smmu)
+		return NULL;
+
 	return container_of(adreno_smmu, struct msm_gpu, adreno_smmu);
 }
 
-- 
2.7.4

