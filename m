Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8534C7171CC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 01:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjE3XhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 19:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233353AbjE3XhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 19:37:00 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E93106;
        Tue, 30 May 2023 16:36:59 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34UN4pWA011423;
        Tue, 30 May 2023 23:36:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=EE//b1snTAVZKu4seqX0NMsp4006NwEPtqjn92nqbh8=;
 b=O+iBmk3ASDZAsT1S/73hUUONQLOZlpL95DNOKWCjTUigCg8AedS/t+aq/RTM7tjOyFpM
 IrffRpgeuorB8S8ZoOQgNdZFSp0cMNe76ROQKjJUdgd7eYHzdUt4C4+2S1qhijEGM+CI
 p4S8jz/f/q7DZW/R0sHu7vYV9vc/uSwr4Ur4jSXM3L57w4ZpvcY282+gRLji+zF4M7cV
 wpd8q2pWJKZooDEg5CW7Kzaw9Pjud4Ks9Nn3WXjCLOsem1ID+KoP1Je2xrhNHQ3uVRhn
 whvT4OZ4r23E71xovgzD9nsAnMeP6Llrvg2n/yzHJzeJ5+mYgREds/uSJEmPuUC3FvwV nA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qw8v4tbfn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 23:36:50 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34UNan1C001333
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 23:36:49 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 30 May 2023 16:36:49 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/3] dt-bindings: reserved-memory: rmtfs: Allow guard pages
Date:   Tue, 30 May 2023 16:36:41 -0700
Message-ID: <20230530233643.4044823-2-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230530233643.4044823-1-quic_bjorande@quicinc.com>
References: <20230530233643.4044823-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: nUnLj9DhM4-9yxA-PRdmxfa_Xu2l5vBs
X-Proofpoint-GUID: nUnLj9DhM4-9yxA-PRdmxfa_Xu2l5vBs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_17,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305300193
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some Qualcomm platforms it's required that the rmtfs memory is not
placed adjacent to allocations performed by other clients. Some
DeviceTree authors have solved this by reserving the space around
the region, but this prevents such author to use rely on the OS to place
the region, through the use of "size" (instead of a fixed location).

So introduce a flag to indicate that guard pages should be carved at the
beginning and end of the memory region. The user shall account for the
two 4k blocks in the defined size.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---

Changes since v1:
- Drop qcom,alloc-size in favour of using reserved-memory/size
- Introduce explicit property to signal that guard pages should be
  carved out from this region (rather than always do it in the dynamic
  case).

 .../bindings/reserved-memory/qcom,rmtfs-mem.yaml           | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.yaml b/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.yaml
index bab982f00485..26e24e7b08cf 100644
--- a/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.yaml
+++ b/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.yaml
@@ -26,6 +26,13 @@ properties:
     description: >
       identifier of the client to use this region for buffers
 
+  qcom,use-guard-pages:
+    type: boolean
+    description: >
+      Indicates that the OS should ignore the first and last 4k block of the
+      memory region, for the purpose of ensuring that the allocation is not
+      adjacent to other protected regions.
+
   qcom,vmid:
     $ref: /schemas/types.yaml#/definitions/uint32-array
     description: >
-- 
2.25.1

