Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80B36D8FF4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 09:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235894AbjDFHCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 03:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235888AbjDFHBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 03:01:15 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD09C9023;
        Thu,  6 Apr 2023 00:01:02 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3365CkUh013963;
        Thu, 6 Apr 2023 07:00:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=yVFSPWyKLLQm6rIim2QhXUlzQECFGAyZ5mMm/AEqlW0=;
 b=X3TcqE4TO/NwjfUFD/WagZn0Tb+ybUqzTZpRfqYE+4KQONAo6WIt183UgAOPqNFQUkZe
 GRmnWbqciCkLhBxEHCbKSAP/LUQSWoM/Mm7iPpY1ffeoeeJQNnl2GNeeQ1K8fQ2RZnIG
 fzy2SJJDxGYLq0zwApMv+7rH4YosDvGCCIQpkbUQNZuIHmZi0t/krcKlWtgR1Z8uIphO
 6eInIGiTdhXwFrByjYwL8pJrR2084mhjkYpyhB8rR6EJuBWesfYzbfAV/MV19tFCfd4G
 5Ugb4s/sHAhGNFOBW4+Hl6vaamUnC5H0bo7PaEOduWn4zBc3baOyiK1/+/l0GuOy4rLX Aw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ps8h0a5up-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Apr 2023 07:00:58 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33670vpt014704
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Apr 2023 07:00:57 GMT
Received: from devipriy-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 6 Apr 2023 00:00:52 -0700
From:   Devi Priya <quic_devipriy@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>, <quic_ipkumar@quicinc.com>
Subject: [PATCH V3 1/5] regulator: qcom_smd: Add s1 sub-node to mp5496 regulator
Date:   Thu, 6 Apr 2023 12:30:28 +0530
Message-ID: <20230406070032.22243-2-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230406070032.22243-1-quic_devipriy@quicinc.com>
References: <20230406070032.22243-1-quic_devipriy@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ZuNnjm_qIPtywj7c8jFB9eH2KZnAE3yW
X-Proofpoint-ORIG-GUID: ZuNnjm_qIPtywj7c8jFB9eH2KZnAE3yW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_02,2023-04-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 adultscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304060061
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding s1 sub-node entry to mp5496 regulator node.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
---
 Changes in V3:
	- Picked up the R-b tag

 .../devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml   | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml
index 8c45f53212b1..a8ca8e0b27f8 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml
@@ -22,7 +22,7 @@ description:
   Each sub-node is identified using the node's name, with valid values listed
   for each of the pmics below.
 
-  For mp5496, s2
+  For mp5496, s1, s2
 
   For pm2250, s1, s2, s3, s4, l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, l11,
   l12, l13, l14, l15, l16, l17, l18, l19, l20, l21, l22
-- 
2.17.1

