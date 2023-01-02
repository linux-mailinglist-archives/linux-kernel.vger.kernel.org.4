Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07CD065AFDD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 11:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbjABKtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 05:49:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232378AbjABKtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 05:49:21 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CFDB87;
        Mon,  2 Jan 2023 02:49:21 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 302AAvrD012099;
        Mon, 2 Jan 2023 10:48:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=RSf8P3pVo0pQ3dKKyoCr9K8iN7clmptkqL8x8ilOuQk=;
 b=bSfhQs7Nwy6pULR2796STV+GUkaHZhgGYuDWmlftjVtHvy02+x6NJv1hrvip3o2MLf14
 6oP5OL/5trRww1mu9bKTA4jmRuRfbM7peLUpVZ/Kji3K35SH0YZYrtO0t8f8TOVxBKPh
 4/kYOkaiRvSLlTcSDNk/o21kV0vKqofbY/70IRnDQFTR6+vNMaVIhk5nf+QTDJsgCkA3
 q9qMkkKsE8N1WwIg9jqWuyRlhSjuXKBADx3/60zwFHSjZB5Ac9bVm6Bt8kTRNUtWFT2A
 n7S/e61UjwoRpd/8EAiicGSuPZzuPbTRRqofcayshjnzOiYcVBaDanuzQi1l63txT0WB dw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mtcdsjwxa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Jan 2023 10:48:50 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 302AmnDE012583
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 2 Jan 2023 10:48:49 GMT
Received: from hyd-lnxbld559.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 2 Jan 2023 02:48:40 -0800
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
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Sean Paul" <sean@poorly.run>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: [PATCH v5 0/5] Improve GPU reset sequence for Adreno GPU
Date:   Mon, 2 Jan 2023 16:18:26 +0530
Message-ID: <1672656511-1931-1-git-send-email-quic_akhilpo@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: jSLXBoal9ABZNoKgyxYqjiPhCZZiQZoA
X-Proofpoint-GUID: jSLXBoal9ABZNoKgyxYqjiPhCZZiQZoA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-02_06,2022-12-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 mlxlogscore=974 phishscore=0 suspectscore=0
 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301020098
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

Changes in v5:
- Capture all Reviewed-by tags

Changes in v4:
- Update genpd function documentation (Ulf)

Changes in v3:
- Rename the var 'force_sync' to 'wait (Stephen)

Changes in v2:
- Minor formatting fix
- Select PM_GENERIC_DOMAINS from Kconfig

Akhil P Oommen (4):
  clk: qcom: gdsc: Support 'synced_poweroff' genpd flag
  drm/msm/a6xx: Vote for cx gdsc from gpu driver
  drm/msm/a6xx: Remove cx gdsc polling using 'reset'
  drm/msm/a6xx: Use genpd notifier to ensure cx-gdsc collapse

Ulf Hansson (1):
  PM: domains: Allow a genpd consumer to require a synced power off

 drivers/base/power/domain.c           | 26 ++++++++++++++++++++
 drivers/clk/qcom/gdsc.c               | 11 +++++----
 drivers/gpu/drm/msm/Kconfig           |  1 +
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 46 ++++++++++++++++++++++++++++++++---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h |  7 ++++++
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 13 +++++++---
 drivers/gpu/drm/msm/msm_gpu.c         |  4 ---
 drivers/gpu/drm/msm/msm_gpu.h         |  4 ---
 include/linux/pm_domain.h             |  5 ++++
 9 files changed, 97 insertions(+), 20 deletions(-)

-- 
2.7.4

