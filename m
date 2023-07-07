Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A542F74AA60
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 07:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbjGGFVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 01:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjGGFVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 01:21:02 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE22D2684;
        Thu,  6 Jul 2023 22:20:45 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3674q9Rg028621;
        Fri, 7 Jul 2023 05:20:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=tk+0xUjaXkcqSWaSR/rbMXpZdnO8MOFFvzF8RgLDr74=;
 b=Z9BzoRL+qF7bKdu44q3Jk3BoC/R0W4vdV4bR9JuzmAuUSSuvXFpdJTEi5VrfSDB6NuW1
 kYw3uHCVHmQJ+/A8YFbpgkRS8b0RYZ1AB3y/6kg3BTQNw1qelGFgI6M6k5ybwXQ8jWKH
 dKtVEIjIFaDuhGRe7tU1ShyySBy/m2qFXhzLQEGp667js7BCeWuJ9fZ9S1ZaCKvFn4Dw
 QBLr377gvTmsLDN3VVLOZBz7gFwRvFrv+0h2D//MrdOYWUMAWqV5HRf+TXD2pvBQzIsl
 pMd7TwlqrIv3IC0/qTZfPqyuZ6J+agry+tRvy7Bavt7vVF3JyLCcyRidEruzqjDykUDu 4Q== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rp9vp097f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jul 2023 05:20:42 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3675KI4W029603;
        Fri, 7 Jul 2023 05:20:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3rjd7kp70a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 07 Jul 2023 05:20:18 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3675KH9B029571;
        Fri, 7 Jul 2023 05:20:18 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3675KGaf029563;
        Fri, 07 Jul 2023 05:20:18 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 398854EF7; Fri,  7 Jul 2023 10:50:17 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linus.walleij@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH v3 4/4] pinctrl: qcom-pmic-gpio: Add support for pmx75
Date:   Fri,  7 Jul 2023 10:50:09 +0530
Message-Id: <1688707209-30151-5-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1688707209-30151-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1688707209-30151-1-git-send-email-quic_rohiagar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nl6-sXjJkpl2v0qjpaky9Be2sJhsbSVr
X-Proofpoint-ORIG-GUID: nl6-sXjJkpl2v0qjpaky9Be2sJhsbSVr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_02,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 phishscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 impostorscore=0
 mlxlogscore=930 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2307070049
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pmx75 pmic support gpio controller so add compatible in the driver.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
index f1918fe..deded9c 100644
--- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
@@ -1253,6 +1253,7 @@ static const struct of_device_id pmic_gpio_of_match[] = {
 	/* pmx55 has 11 GPIOs with holes on 3, 7, 10, 11 */
 	{ .compatible = "qcom,pmx55-gpio", .data = (void *) 11 },
 	{ .compatible = "qcom,pmx65-gpio", .data = (void *) 16 },
+	{ .compatible = "qcom,pmx75-gpio", .data = (void *) 16 },
 	{ },
 };
 
-- 
2.7.4

