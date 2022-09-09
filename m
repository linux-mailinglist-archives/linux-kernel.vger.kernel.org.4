Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4355B4015
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 21:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiIITqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 15:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbiIITp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 15:45:27 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833B93BC60;
        Fri,  9 Sep 2022 12:42:22 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 289JWWc3022342;
        Fri, 9 Sep 2022 19:41:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=h02mNx2EPfukJ8KeZkU7qKUi1nlfwjxtfdCaxPTiFIY=;
 b=JHCGxnfH7nT9c97aUxUtFtUi2OIdRukHGYDRkYBjDDmu+O5zJGOtTwiYK44eDB63Er7n
 iankjXn+bJZrJU3GKzhFMxnj6FoTdRvt5+fNNBNWdHVcG+r66iTQ9RPjD9BQkqe/PNSc
 +7HgpKlW19LVlSoAiaYAXEV+bjzKGaO4sjKYRxlZJ+WoCBsgJrY3PGrXf8Trd0C/5Whn
 yDo2QWthNTAehbABDxIETbmCH98L9qCo4MA6vQ+nMGV0KC3ziERiyU8cae0AwpBM/miC
 s7cx0zDQh/3ZF/POFybmkYWbExqmssCrVmEfW/BoyP8sz2QnuNhgtlqb2rc7arZ9YBqn uw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jfupqbfmd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Sep 2022 19:41:13 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 289JfCcX020403
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 9 Sep 2022 19:41:12 GMT
Received: from hu-amelende-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 9 Sep 2022 12:41:12 -0700
From:   Anjelique Melendez <quic_amelende@quicinc.com>
To:     <corbet@lwn.net>, <sre@kernel.org>, <robh+dt@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>
CC:     <krzysztof.kozlowski+dt@linaro.org>, <vkoul@kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Anjelique Melendez <quic_amelende@quicinc.com>
Subject: [PATCH v5 2/2] power: reset: qcom-pon: add support for qcom,pmk8350-pon compatible string
Date:   Fri, 9 Sep 2022 12:40:39 -0700
Message-ID: <20220909194038.20515-2-quic_amelende@quicinc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220909194038.20515-1-quic_amelende@quicinc.com>
References: <20220909194038.20515-1-quic_amelende@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jOIN7hXB7hEEz6A3UTXq2qwX9lWSBErY
X-Proofpoint-ORIG-GUID: jOIN7hXB7hEEz6A3UTXq2qwX9lWSBErY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-09_09,2022-09-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 clxscore=1015 priorityscore=1501 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209090069
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the new "qcom,pmk8350-pon" comptaible string.

Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
---
 drivers/power/reset/qcom-pon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/reset/qcom-pon.c b/drivers/power/reset/qcom-pon.c
index 4a688741a88a..16bc01738be9 100644
--- a/drivers/power/reset/qcom-pon.c
+++ b/drivers/power/reset/qcom-pon.c
@@ -82,6 +82,7 @@ static const struct of_device_id pm8916_pon_id_table[] = {
 	{ .compatible = "qcom,pm8916-pon", .data = (void *)GEN1_REASON_SHIFT },
 	{ .compatible = "qcom,pms405-pon", .data = (void *)GEN1_REASON_SHIFT },
 	{ .compatible = "qcom,pm8998-pon", .data = (void *)GEN2_REASON_SHIFT },
+	{ .compatible = "qcom,pmk8350-pon", .data = (void *)GEN2_REASON_SHIFT },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, pm8916_pon_id_table);
-- 
2.35.1

