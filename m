Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADCB36AC43C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 16:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjCFPAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 10:00:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbjCFPAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 10:00:11 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC052A9B6;
        Mon,  6 Mar 2023 07:00:07 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3266RFn2000531;
        Mon, 6 Mar 2023 14:46:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=5JRGOQbm0JBuLxYt4MzA6HybTg38jSMU6E2GDw++4aI=;
 b=YvcQA/w0B4Eh5GEtqz1bFrzdyRybeccuvt7or/616AUwSXvc/Amkmx7z16nh+ZMEH31j
 ahZKViNqmJuhXjGVofKRGcQ8II/Q4a/UwuBhrCcVd1zjaMsk5J61zjv8+pPoY/IYMfSD
 BLoiELGjaDdL2pelJC4fR1E32upGn5zW2PiOq6V2AQlU9mqrKKsFcB9awm3fOG8/niHi
 IeVIJ25M7TVK9eiXhov3z36vlnxaHDKUbNViO3OOnJ5RnYDS6uGcAiP45OlbN3ezMUOe
 AO8zYMEfqQeUFJiDTFCMAboZ+FkcxU7w1BfXHmUjTo/N4bKlkD5yAdQmSgrAvA302t9B Tw== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p417d4y1p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 14:46:46 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 326EkheE017348;
        Mon, 6 Mar 2023 14:46:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3p4fft5j33-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 06 Mar 2023 14:46:43 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 326EfjQG011965;
        Mon, 6 Mar 2023 14:46:43 GMT
Received: from mdalam-linux.qualcomm.com (mdalam-linux.qualcomm.com [10.201.2.71])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 326EkhVT017343;
        Mon, 06 Mar 2023 14:46:43 +0000
Received: by mdalam-linux.qualcomm.com (Postfix, from userid 466583)
        id 51EE712010CA; Mon,  6 Mar 2023 20:16:42 +0530 (IST)
From:   Md Sadre Alam <quic_mdalam@quicinc.com>
To:     andersson@kernel.org, agross@kernel.org, konrad.dybcio@linaro.org,
        linus.walleij@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_sjaganat@quicinc.com, quic_srichara@quicinc.com,
        quic_varada@quicinc.com, quic_mdalam@quicinc.com
Subject: [PATCH 4/5] pinctrl: qcom: Use devm_platform_get_and_ioremap_resource()
Date:   Mon,  6 Mar 2023 20:16:41 +0530
Message-Id: <20230306144641.21955-1-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IYc9OB0druSbGCCo8z-rf0Daqc6MsuQj
X-Proofpoint-ORIG-GUID: IYc9OB0druSbGCCo8z-rf0Daqc6MsuQj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_08,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0 mlxlogscore=656
 phishscore=0 clxscore=1011 adultscore=0 priorityscore=1501 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303060130
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---
 drivers/pinctrl/qcom/pinctrl-msm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index daeb79a9a602..e25e7b5cdda2 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -1480,8 +1480,7 @@ int msm_pinctrl_probe(struct platform_device *pdev,
 				return PTR_ERR(pctrl->regs[i]);
 		}
 	} else {
-		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-		pctrl->regs[0] = devm_ioremap_resource(&pdev->dev, res);
+		pctrl->regs[0] = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 		if (IS_ERR(pctrl->regs[0]))
 			return PTR_ERR(pctrl->regs[0]);
 
-- 
2.17.1

