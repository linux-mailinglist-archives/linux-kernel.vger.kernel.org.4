Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533CD6B77C2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 13:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjCMMl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 08:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjCMMlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 08:41:19 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9999A52F65;
        Mon, 13 Mar 2023 05:41:18 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32DBABB4009745;
        Mon, 13 Mar 2023 12:40:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=qcppdkim1;
 bh=GSBLp78dcLJUo81PqS68p2voIQ9C1DQmMhPbqlXQWgs=;
 b=e/QEE1O7IgMpI0+kv+UfnjHPwj5UZ0KlpH4QGkw5WDjYfOFFiX+YOd1GwS+kSVLWWyDh
 CHv/6jx36JOEoedg/+iqcuzSjKS7UmXb2NThp5WYYPRzg0dVolHcGa15hgmQHi265mxO
 rzu3SvcAOjU7jzFTyR/y6wdC5d2sd+YuRIstZq0+iMraETOR5ogXUe8IWVgkjlyEED+5
 ed+Pfff2nPGAqDV16UrLEPhc22sj9bmzC3maohalbWpKb8HPc2vqFcKajVVlOlJ7WEPn
 p9RrJHcadGP0rnQM3k42Nj/uYMuZPxm2wReE3kahVIQnhNQ5KDCNQgLtPnsDBu8SZCaY NA== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pa1qgrcay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Mar 2023 12:40:51 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 32DCelpu022400;
        Mon, 13 Mar 2023 12:40:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3p8jqkna06-1;
        Mon, 13 Mar 2023 12:40:47 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32DCelkF022392;
        Mon, 13 Mar 2023 12:40:47 GMT
Received: from kbajaj-linux.qualcomm.com (kbajaj-linux.qualcomm.com [10.214.66.129])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 32DCelMb022391;
        Mon, 13 Mar 2023 12:40:47 +0000
Received: from kbajaj-linux.qualcomm.com (localhost [127.0.0.1])
        by kbajaj-linux.qualcomm.com (Postfix) with ESMTP id 5B2142A3;
        Mon, 13 Mar 2023 18:10:46 +0530 (IST)
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
Subject: [PATCH v2 2/5] dt-bindings: arm: msm: Add bindings for multi channel DDR in LLCC
Date:   Mon, 13 Mar 2023 18:10:37 +0530
Message-Id: <20230313124040.9463-3-quic_kbajaj@quicinc.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230313124040.9463-1-quic_kbajaj@quicinc.com>
References: <20230313124040.9463-1-quic_kbajaj@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: M_3ZUgZGXRB_BD1gLn-dHmWd5ysD-KDy
X-Proofpoint-GUID: M_3ZUgZGXRB_BD1gLn-dHmWd5ysD-KDy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_05,2023-03-13_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 mlxlogscore=880 spamscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2303130102
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

