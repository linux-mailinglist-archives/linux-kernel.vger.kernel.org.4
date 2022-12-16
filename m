Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4AA64E951
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 11:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiLPKWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 05:22:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiLPKWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 05:22:14 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57DE226AFC;
        Fri, 16 Dec 2022 02:22:12 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BG9oQkj011185;
        Fri, 16 Dec 2022 10:22:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=clyrmdbLgNyncy6VSf4C1UFgXnOB1Y9vkjufiDDOJM8=;
 b=dr7+o9B7jX5ZgEO553ciEme2NPK4Nq6oNUuGI7hH0pQT50hKTSXT+VPHMTWFpdog4juS
 5iDIQdT/E9ypyI5UxxvIi95OMJFulUe3OwqXch+d4S/co6tGKMDzoV60pjxvf+mRSDC4
 pNWsxiKpVRtwZCLExP9F6V7IA9WHORz0ACJSNOxalhxBAK7z+pLJLBZJqnj4w1KRzNSf
 PhRPpCKssY2GkelQ4vw5w5s9Khx+xolp+O0Ym+eUUZxwmDX9OE3bPc1bhuqAECQm93Vd
 PQlXkKc3iahQ54iHDQY/u6HgYZeunM/ZO/92w8eAx+p2oUs2ze3/NvG0hhcOs3jkq3s+ UA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mg6v7tr3g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Dec 2022 10:22:07 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BGAM6r7011530
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Dec 2022 10:22:06 GMT
Received: from hyd-lnxbld559.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 16 Dec 2022 02:22:01 -0800
From:   Akhil P Oommen <quic_akhilpo@quicinc.com>
To:     freedreno <freedreno@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
CC:     Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/5] clk: qcom: gdsc: Support 'synced_poweroff' genpd flag
Date:   Fri, 16 Dec 2022 15:51:21 +0530
Message-ID: <20221216155038.v2.2.Ic128c1df50b7fc9a6b919932a3b41a799b5ed5e8@changeid>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1671186084-11356-1-git-send-email-quic_akhilpo@quicinc.com>
References: <1671186084-11356-1-git-send-email-quic_akhilpo@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7nj7sIkSs85yu8qFeQJjI8XuEtFqVQHq
X-Proofpoint-ORIG-GUID: 7nj7sIkSs85yu8qFeQJjI8XuEtFqVQHq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-16_06,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 mlxscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212160091
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the newly added 'synced_poweroff' genpd flag. This allows
some clients (like adreno gpu driver) to request gdsc driver to ensure
a votable gdsc (like gpucc cx gdsc) has collapsed at hardware.

Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
---

(no changes since v1)

 drivers/clk/qcom/gdsc.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index 9e4d6ce891aa..575019ba4768 100644
--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -136,7 +136,8 @@ static int gdsc_update_collapse_bit(struct gdsc *sc, bool val)
 	return 0;
 }
 
-static int gdsc_toggle_logic(struct gdsc *sc, enum gdsc_status status)
+static int gdsc_toggle_logic(struct gdsc *sc, enum gdsc_status status,
+		bool force_sync)
 {
 	int ret;
 
@@ -149,7 +150,7 @@ static int gdsc_toggle_logic(struct gdsc *sc, enum gdsc_status status)
 	ret = gdsc_update_collapse_bit(sc, status == GDSC_OFF);
 
 	/* If disabling votable gdscs, don't poll on status */
-	if ((sc->flags & VOTABLE) && status == GDSC_OFF) {
+	if ((sc->flags & VOTABLE) && status == GDSC_OFF && !force_sync) {
 		/*
 		 * Add a short delay here to ensure that an enable
 		 * right after it was disabled does not put it in an
@@ -275,7 +276,7 @@ static int gdsc_enable(struct generic_pm_domain *domain)
 		gdsc_deassert_clamp_io(sc);
 	}
 
-	ret = gdsc_toggle_logic(sc, GDSC_ON);
+	ret = gdsc_toggle_logic(sc, GDSC_ON, false);
 	if (ret)
 		return ret;
 
@@ -352,7 +353,7 @@ static int gdsc_disable(struct generic_pm_domain *domain)
 	if (sc->pwrsts == PWRSTS_RET_ON)
 		return 0;
 
-	ret = gdsc_toggle_logic(sc, GDSC_OFF);
+	ret = gdsc_toggle_logic(sc, GDSC_OFF, domain->synced_poweroff);
 	if (ret)
 		return ret;
 
@@ -392,7 +393,7 @@ static int gdsc_init(struct gdsc *sc)
 
 	/* Force gdsc ON if only ON state is supported */
 	if (sc->pwrsts == PWRSTS_ON) {
-		ret = gdsc_toggle_logic(sc, GDSC_ON);
+		ret = gdsc_toggle_logic(sc, GDSC_ON, false);
 		if (ret)
 			return ret;
 	}
-- 
2.7.4

