Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800A6631B34
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 09:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiKUIWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 03:22:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiKUIWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 03:22:37 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87F22BC6;
        Mon, 21 Nov 2022 00:22:35 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AL7PNDe000663;
        Mon, 21 Nov 2022 08:22:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=V1LU8LRl+xf+WYxTE4dHJDvpPMGsaDqm739lkesWJ2A=;
 b=QBqDDd+1JJ6kPwqNqKTRDtlW6s85yk6hNLmsDPfSgujA6L2gqyfmiTnndhr32DmswyYw
 Fx4rbVa4iwR6PQpLqMGznpPYuonAiJcD6EZ9vo2LSWDc/Itu8Z8AsT/pTyTQnJeJdr6N
 4UsXJaadqPVRHi7w5wadyL9Wf6l1tb0xIFfe1v+1rAbX+CMi0tZt02fm1eTt/nTn6MW0
 oy8ShlaH4k0VUtzHxBG8fGLn+E/sMAfgNgVQc4TZijSTFu4ms4rQpYf1xvquf71fBAqP
 X3djEy/49D1FRK1ilx3kxJrLAkefa7/BMmqUZCG8Q693JgngJbF4NiKhq1PHbCvyzZsT Mw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kxrkv3vte-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 08:22:23 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AL8MLwm023983
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 08:22:21 GMT
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 21 Nov 2022 00:22:16 -0800
From:   Tao Zhang <quic_taozha@quicinc.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Tao Zhang <quic_taozha@quicinc.com>,
        Jinlong Mao <quic_jinlmao@quicinc.com>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <bjorn.andersson@linaro.org>
Subject: [PATCH v1 1/9] dt-bindings: arm: Add support for DSB element
Date:   Mon, 21 Nov 2022 16:21:05 +0800
Message-ID: <1669018873-4718-2-git-send-email-quic_taozha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1669018873-4718-1-git-send-email-quic_taozha@quicinc.com>
References: <1669018873-4718-1-git-send-email-quic_taozha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0lD9WR4V62kOV1EdrWWgWEy7w4YXd3rt
X-Proofpoint-ORIG-GUID: 0lD9WR4V62kOV1EdrWWgWEy7w4YXd3rt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-21_05,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 mlxlogscore=838 malwarescore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211210065
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add property "qcom,dsb-elem-size" to support DSB(Discrete Single
Bit) element for TPDA. Specifies the DSB element size supported
by each monitor connected to the aggregator on each port. Should
be specified in pairs (port, dsb element size).

Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
---
 Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
index c46ddea..e3b58b5 100644
--- a/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
@@ -58,6 +58,13 @@ properties:
     minItems: 1
     maxItems: 2
 
+  qcom,dsb-elem-size:
+    description: |
+      Specifies the DSB element size supported by each monitor
+      connected to the aggregator on each port. Should be specified
+      in pairs (port, dsb element size).
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+
   clocks:
     maxItems: 1
 
@@ -100,6 +107,8 @@ examples:
        compatible = "qcom,coresight-tpda", "arm,primecell";
        reg = <0x6004000 0x1000>;
 
+       qcom,dsb-elem-size = <0 32>;
+
        clocks = <&aoss_qmp>;
        clock-names = "apb_pclk";
 
-- 
2.7.4

