Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023C864DD6C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 16:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiLOPMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 10:12:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiLOPMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 10:12:05 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0C32D1DA;
        Thu, 15 Dec 2022 07:12:03 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BFCR7o0001017;
        Thu, 15 Dec 2022 15:11:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=CwtUlOEE2auQDbSoAV3Q92tiAt928TzZBxAZmbEYDKw=;
 b=Jb4ydAZ4HnWQJbie0nzLlYE/o/yTqHIIDxb9TmlCk3RWf8KHBARPVH1cGXKO3b7FUvfR
 LRFQoQHYdAqOY5vL3HbZDBPysCUOH8Zie4WmNTrB6tWjj984VNTGPOALbYg4yq4sVVlS
 IwKGlWoBVqMXo3y4GrwumJ0goxTcSsAQu3IONgYAy68BYJe/NnHqE6/mmVUNbu7WMu2R
 0BZeCLSbMjDnAnDc32Uq8r6BO1/sWcwnBVUFhj304H0WH7CS5HM5OSwDiKopxQz8ElxA
 bdIwZXc8AdKAnbkMA59AMJYw5jRaD2s3C7+vuLYhZ195c3+ZsL7MZtzjusK2f9awC7QO qg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mfukhsthx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Dec 2022 15:11:25 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BFFBOJU023238
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Dec 2022 15:11:24 GMT
Received: from hyd-lnxbld559.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 15 Dec 2022 07:11:15 -0800
From:   Akhil P Oommen <quic_akhilpo@quicinc.com>
To:     freedreno <freedreno@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
CC:     Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Andy Gross <agross@kernel.org>, Chia-I Wu <olvaffe@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        "Douglas Anderson" <dianders@chromium.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Kevin Hilman <khilman@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "Len Brown" <len.brown@intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Pavel Machek <pavel@ucw.cz>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sean Paul <sean@poorly.run>, Stephen Boyd <sboyd@kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: [PATCH 0/5] Improve GPU reset sequence for Adreno GPU
Date:   Thu, 15 Dec 2022 20:40:56 +0530
Message-ID: <1671117062-26276-1-git-send-email-quic_akhilpo@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: srWW-E5YSaJ_TcjtaXyXBmqr7HyTi2JL
X-Proofpoint-ORIG-GUID: srWW-E5YSaJ_TcjtaXyXBmqr7HyTi2JL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-15_08,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1011
 mlxscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 mlxlogscore=822 spamscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212150123
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This is a rework of [1] using genpd instead of 'reset' framework.

As per the recommended reset sequence of Adreno gpu, we should ensure that
gpucc-cx-gdsc has collapsed at hardware to reset gpu's internal hardware states.
Because this gdsc is implemented as 'votable', gdsc driver doesn't poll and
wait until its hw status says OFF.

So use the newly introduced genpd api (dev_pm_genpd_synced_poweroff()) to
provide a hint to the gdsc driver to poll for the hw status and use genpd
notifier to wait from adreno gpu driver until gdsc is turned OFF.

This series is rebased on top of linux-next (20221215) since the changes span
multiple drivers.

[1] https://patchwork.freedesktop.org/series/107507/


Akhil P Oommen (4):
  clk: qcom: gdsc: Support 'synced_poweroff' genpd flag
  drm/msm/a6xx: Vote for cx gdsc from gpu driver
  drm/msm/a6xx: Remove cx gdsc polling using 'reset'
  drm/msm/a6xx: Use genpd notifier to ensure cx-gdsc collapse

Ulf Hansson (1):
  PM: domains: Allow a genpd consumer to require a synced power off

 drivers/base/power/domain.c           | 23 ++++++++++++++++++
 drivers/clk/qcom/gdsc.c               | 11 +++++----
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 46 ++++++++++++++++++++++++++++++++---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h |  7 ++++++
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 13 +++++++---
 drivers/gpu/drm/msm/msm_gpu.c         |  4 ---
 drivers/gpu/drm/msm/msm_gpu.h         |  4 ---
 include/linux/pm_domain.h             |  5 ++++
 8 files changed, 93 insertions(+), 20 deletions(-)

-- 
2.7.4

