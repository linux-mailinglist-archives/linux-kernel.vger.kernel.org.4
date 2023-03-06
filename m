Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8A26AC395
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 15:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbjCFOmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 09:42:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbjCFOmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 09:42:33 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507702A145;
        Mon,  6 Mar 2023 06:42:15 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 326Dgfil005007;
        Mon, 6 Mar 2023 14:41:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=/2QNenuQo6MbSF7cRXmwd59aJmgafR20m5SsTmAQTOU=;
 b=Nk34kNHI75clCX0DD2icUXU5HDxodW80So7KgJibghJSbWxHN3WzTX2+NQKdOGTZ7avl
 FV2M50DYYZAeBBUtlan5ZeMDQrTmD9CPnRMTaePbKpbEQd1sDnJK3atbODzFM4ntjXqx
 64TE0PCsybNj3/JlXAqojxf8jhhCM/34VddaW8Uw8KcfKXfgm0euEeYvc7XXOcxnrrCM
 xopl4pgLphfKSISmEgOXgua0eEMgehjLZ9Ei592PtL6ycx5A+fYD/MMROyzFnUF8KS8K
 24XCqaHTCr4XwczbxlwwRFXCrsGX6TA42dU4zGRPwi92YDXlUGS9WsEaMuLjopnmM9nf IA== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p418751mm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 14:41:50 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 326EfjpM011970;
        Mon, 6 Mar 2023 14:41:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3p4fft5hsq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 06 Mar 2023 14:41:45 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 326EfjQE011965;
        Mon, 6 Mar 2023 14:41:45 GMT
Received: from mdalam-linux.qualcomm.com (mdalam-linux.qualcomm.com [10.201.2.71])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 326EfiSw011964;
        Mon, 06 Mar 2023 14:41:45 +0000
Received: by mdalam-linux.qualcomm.com (Postfix, from userid 466583)
        id D735412010CA; Mon,  6 Mar 2023 20:11:43 +0530 (IST)
From:   Md Sadre Alam <quic_mdalam@quicinc.com>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mani@kernel.org
Cc:     quic_sjaganat@quicinc.com, quic_srichara@quicinc.com,
        quic_varada@quicinc.com, Md Sadre Alam <quic_mdalam@quicinc.com>
Subject: [PATCH 1/5] mtd: nand: raw: qcom_nandc: Use devm_platform_get_and_ioremap_resource()
Date:   Mon,  6 Mar 2023 20:11:41 +0530
Message-Id: <20230306144141.15360-1-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ag-00pLbdU9YvMST_nueD7Ca12fmZqS_
X-Proofpoint-ORIG-GUID: ag-00pLbdU9YvMST_nueD7Ca12fmZqS_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_08,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=821 bulkscore=0 suspectscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303060129
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/mtd/nand/raw/qcom_nandc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index 198a44794d2d..5cc1cbc9517d 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -3269,8 +3269,7 @@ static int qcom_nandc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	nandc->base = devm_ioremap_resource(dev, res);
+	nandc->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(nandc->base))
 		return PTR_ERR(nandc->base);
 
-- 
2.17.1

