Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18EE6B6FF0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 08:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjCMHOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 03:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjCMHO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 03:14:27 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D9C34C16;
        Mon, 13 Mar 2023 00:14:21 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32D1od7Q022374;
        Mon, 13 Mar 2023 07:13:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=qcppdkim1;
 bh=GSBLp78dcLJUo81PqS68p2voIQ9C1DQmMhPbqlXQWgs=;
 b=T/pAhjUlJlIlhKChNCUWRZyikIVp7yQZkvhUjIz1QY19S8wFtb84Yeq8h6MoS8wZ8Jsx
 ycclMRud5Wib6ti3rK54aQw/7HVJlpDeFwj6oKs06iZTdVH2iimYi7wii7JDmdzmiqfb
 phdtr4YY1gKhXZksiLBgVKiOp48eYDpIuov69XgbRTcUp27Q+npE/+lhUm1MSBoOfHsg
 5flMg0t+FWk9jBTX2h0WCA1Dy68LBj0e3NA2l0bJ35mdA+rysJ+RJtaSgx8FTMM4bHFg
 sJEPlbRbJX+UIVqbm3rASJyUl+K4FvILelrOdWvpDIlNX5z8BdKdYXs4/7VJ/1pH2i5E iQ== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p8hvbm4dj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Mar 2023 07:13:50 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 32D7Dk6Z032134;
        Mon, 13 Mar 2023 07:13:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3p8jqkkykk-1;
        Mon, 13 Mar 2023 07:13:46 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32D7DkAH032129;
        Mon, 13 Mar 2023 07:13:46 GMT
Received: from kbajaj-linux.qualcomm.com (kbajaj-linux.qualcomm.com [10.214.66.129])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 32D7Dkbe032128;
        Mon, 13 Mar 2023 07:13:46 +0000
Received: from kbajaj-linux.qualcomm.com (localhost [127.0.0.1])
        by kbajaj-linux.qualcomm.com (Postfix) with ESMTP id 7CDB2D8;
        Mon, 13 Mar 2023 12:43:45 +0530 (IST)
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>
Cc:     Komal Bajaj <quic_kbajaj@quicinc.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 2/5] dt-bindings: arm: msm: Add bindings for multi channel DDR in LLCC
Date:   Mon, 13 Mar 2023 12:43:22 +0530
Message-Id: <20230313071325.21605-3-quic_kbajaj@quicinc.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230313071325.21605-1-quic_kbajaj@quicinc.com>
References: <20230313071325.21605-1-quic_kbajaj@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: SPsFs1G7o34ancrk3rg1eb27d_pV-KjU
X-Proofpoint-GUID: SPsFs1G7o34ancrk3rg1eb27d_pV-KjU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-12_10,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 phishscore=0 clxscore=1015 adultscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=880 spamscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303130058
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add description for additional nodes needed to support
mulitple channel DDR configurations in LLCC.

Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
---
 Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml
index 38efcad56dbd..9a4a76caf490 100644
--- a/Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml
+++ b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml
@@ -37,15 +37,24 @@ properties:
     items:
       - description: LLCC base register region
       - description: LLCC broadcast base register region
+      - description: Feature register to decide which LLCC configuration
+                     to use, this is optional
 
   reg-names:
     items:
       - const: llcc_base
       - const: llcc_broadcast_base
+      - const: multi_channel_register
 
   interrupts:
     maxItems: 1
 
+  multi-ch-bit-off:
+    items:
+      - description: Specifies the offset in bits into the multi_channel_register
+                     and the number of bits used to decide which LLCC configuration
+                     to use
+
 required:
   - compatible
   - reg
-- 
2.39.1

