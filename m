Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03ED465AFE0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 11:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbjABKuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 05:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbjABKtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 05:49:35 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA3EB25;
        Mon,  2 Jan 2023 02:49:34 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 302AQxmD020756;
        Mon, 2 Jan 2023 10:49:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=8lqJjL9jHslmMbRzyPjVaNyVeIhX99Na9q9L69myhZU=;
 b=cdiTahRd3tYluyKKrVsfQhnW9N+KGQAaAsrZ7dgfNT5odizKrKCwQvhlmBD5CsHCZf1V
 ihdF54yPYNdLLgQozIScDNQZjfWTEf09CorGXnfbzBWpNdu0oIHCtSvVn/OcPyM1BF7m
 TulYs5xsARt0/TZXon/zLcFjxTBk01tdnjH44Y5OQ2QaTvN+mLW9gXFYQrBI6AmibtKP
 IuWKWCtVbFheEKjInpBunQ5uH4CetQN432LRQmuXf29TIUdQWI7tT2hZb7BYFYRW/k4H
 lUvpfWmXwS7U5fbz3b6eh//K9IExCUhXscdMYcJ2QmxmcLuJ8Kxe+AIBojxbmMy4PeUo YA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mtdabamej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Jan 2023 10:49:07 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 302An6Rs007424
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 2 Jan 2023 10:49:06 GMT
Received: from hyd-lnxbld559.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 2 Jan 2023 02:49:00 -0800
From:   Akhil P Oommen <quic_akhilpo@quicinc.com>
To:     freedreno <freedreno@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        "Douglas Anderson" <dianders@chromium.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Sean Paul <sean@poorly.run>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 3/5] drm/msm/a6xx: Vote for cx gdsc from gpu driver
Date:   Mon, 2 Jan 2023 16:18:29 +0530
Message-ID: <20230102161757.v5.3.I7f545d8494dcdbe6e96a15fbe8aaf5bb0c003d50@changeid>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1672656511-1931-1-git-send-email-quic_akhilpo@quicinc.com>
References: <1672656511-1931-1-git-send-email-quic_akhilpo@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: axuk3QOS2xzrB1blzC4lzWRmyNnkLIC6
X-Proofpoint-ORIG-GUID: axuk3QOS2xzrB1blzC4lzWRmyNnkLIC6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-02_06,2022-12-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 impostorscore=0 suspectscore=0 bulkscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301020098
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a device has multiple power domains, dev->power_domain is left
empty during probe. That didn't cause any issue so far because we are
freeloading on smmu driver's vote on cx gdsc. Instead of that, create
a device_link between cx genpd device and gmu device to keep a vote from
gpu driver.

Before this patch:
localhost ~ # cat /sys/kernel/debug/pm_genpd/pm_genpd_summary
gx_gdsc		on		0
    /devices/genpd:1:3d6a000.gmu		active		0
cx_gdsc		on		0
    /devices/platform/soc@0/3da0000.iommu	active		0

After this patch:
localhost ~ # cat /sys/kernel/debug/pm_genpd/pm_genpd_summary
gx_gdsc		on		0
    /devices/genpd:1:3d6a000.gmu		active		0
cx_gdsc		on		0
    /devices/platform/soc@0/3da0000.iommu	active		0
    /devices/genpd:0:3d6a000.gmu		active		0

Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
---

(no changes since v1)

 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 31 +++++++++++++++++++++++++++----
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h |  1 +
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 6484b97c5344..1580d0090f35 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -1479,6 +1479,12 @@ void a6xx_gmu_remove(struct a6xx_gpu *a6xx_gpu)
 
 	pm_runtime_force_suspend(gmu->dev);
 
+	/*
+	 * Since cxpd is a virt device, the devlink with gmu-dev will be removed
+	 * automatically when we do detach
+	 */
+	dev_pm_domain_detach(gmu->cxpd, false);
+
 	if (!IS_ERR_OR_NULL(gmu->gxpd)) {
 		pm_runtime_disable(gmu->gxpd);
 		dev_pm_domain_detach(gmu->gxpd, false);
@@ -1605,8 +1611,10 @@ int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
 
 	if (adreno_is_a650_family(adreno_gpu)) {
 		gmu->rscc = a6xx_gmu_get_mmio(pdev, "rscc");
-		if (IS_ERR(gmu->rscc))
+		if (IS_ERR(gmu->rscc)) {
+			ret = -ENODEV;
 			goto err_mmio;
+		}
 	} else {
 		gmu->rscc = gmu->mmio + 0x23000;
 	}
@@ -1615,8 +1623,22 @@ int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
 	gmu->hfi_irq = a6xx_gmu_get_irq(gmu, pdev, "hfi", a6xx_hfi_irq);
 	gmu->gmu_irq = a6xx_gmu_get_irq(gmu, pdev, "gmu", a6xx_gmu_irq);
 
-	if (gmu->hfi_irq < 0 || gmu->gmu_irq < 0)
+	if (gmu->hfi_irq < 0 || gmu->gmu_irq < 0) {
+		ret = -ENODEV;
+		goto err_mmio;
+	}
+
+	gmu->cxpd = dev_pm_domain_attach_by_name(gmu->dev, "cx");
+	if (IS_ERR(gmu->cxpd)) {
+		ret = PTR_ERR(gmu->cxpd);
 		goto err_mmio;
+	}
+
+	if (!device_link_add(gmu->dev, gmu->cxpd,
+					DL_FLAG_PM_RUNTIME)) {
+		ret = -ENODEV;
+		goto detach_cxpd;
+	}
 
 	/*
 	 * Get a link to the GX power domain to reset the GPU in case of GMU
@@ -1634,6 +1656,9 @@ int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
 
 	return 0;
 
+detach_cxpd:
+	dev_pm_domain_detach(gmu->cxpd, false);
+
 err_mmio:
 	iounmap(gmu->mmio);
 	if (platform_get_resource_byname(pdev, IORESOURCE_MEM, "rscc"))
@@ -1641,8 +1666,6 @@ int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
 	free_irq(gmu->gmu_irq, gmu);
 	free_irq(gmu->hfi_irq, gmu);
 
-	ret = -ENODEV;
-
 err_memory:
 	a6xx_gmu_memory_free(gmu);
 err_put_device:
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
index e034935b3986..5a42dd4dd31f 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
@@ -56,6 +56,7 @@ struct a6xx_gmu {
 	int gmu_irq;
 
 	struct device *gxpd;
+	struct device *cxpd;
 
 	int idle_level;
 
-- 
2.7.4

