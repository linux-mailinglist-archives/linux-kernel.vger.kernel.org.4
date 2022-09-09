Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88BD75B4033
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 21:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbiIITvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 15:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiIITvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 15:51:09 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FD12E6B9;
        Fri,  9 Sep 2022 12:51:08 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 289IJ1NY018025;
        Fri, 9 Sep 2022 19:40:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=wHW1vNz16ltIDMS+8hT4yCgVJQqCNH1NVloPPsitZoE=;
 b=D0ZOzjw6MsK0FF4bC4oAi2TFPsNcj/9Cv01k0ryLfkE34BJaAC9qtWoQRdJzs56JH4yG
 FcWCjtJFHA6LMWhhWdKlGtrkTnuNvWxX5SERreZxM+RP7CAUMu8U1VDUj2QFNSQK9YYs
 6L+PHxMLGa8dkzmIhwbkSq0aP8MMHjqANoTNhvYrZQhmxZl3Es0A0nBgbX+93qpaKfCC
 MQYKMe+TLA5vQLzRkzZ8NaEszScAm08ki7NU2x9qA6nzj+c0eXk6oG7Whoq/DYw812Nv
 OhH/SgGv58+oPvUxWGBISuwNhR1sODozS3purx7y70eOQQ8ibireAhR5BxyeDftC6+SB ig== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jfujq42ne-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Sep 2022 19:40:16 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 289JeFb1019667
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 9 Sep 2022 19:40:15 GMT
Received: from hu-amelende-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 9 Sep 2022 12:40:14 -0700
From:   Anjelique Melendez <quic_amelende@quicinc.com>
To:     <corbet@lwn.net>, <sre@kernel.org>, <robh+dt@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <quic_collinsd@quicinc.com>
CC:     <krzysztof.kozlowski+dt@linaro.org>, <vkoul@kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Anjelique Melendez <quic_amelende@quicinc.com>
Subject: [PATCH v5 0/2] add support for PON GEN3 device
Date:   Fri, 9 Sep 2022 12:39:16 -0700
Message-ID: <20220909193915.20057-1-quic_amelende@quicinc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Lt0PEa-5rPL6KHM2R1y1Ic2evwV-iM0u
X-Proofpoint-GUID: Lt0PEa-5rPL6KHM2R1y1Ic2evwV-iM0u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-09_09,2022-09-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1011
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

Changes from v4:
  - Updated commit message for patch 1/2

Changes from v3:
  - Addressed Krysztof's comments on patch 1/2
    - Added missing minItems/maxItems
    - Merged if statments with same constraints together
    - Removed description from "reg-names"
    
Changes from v2:
  - Added new "qcom,pmk8350-pon" compatible string as per Krysztof's
    advice
  - Updated dt logic to use comptaible strings to decide constraints
    as per Krysztof's comment
  - Added new patch (v3 2/2) to support new compatible string

Changes from v1:
  - Updated path which was missing Documentation/devicetree prefix
  - Updated CC list

New patch series to separate this patch from applied patches.
Comments from original patch can be found
https://lore.kernel.org/linux-arm-msm/27515993-18f3-8891-4835-9b6a8d7f86b0@quicinc.com/

David Collins (1):
  dt-bindings: power: reset: qcom-pon: Add new compatible
    "qcom,pmk8350-pon"

Anjelique Melendez (1):
  power: reset: qcom-pon: add support for qcom,pmk8350-pon compatible string

 Documentation/devicetree/bindings/power/reset/qcom,pon.yaml | 50 +++++++++++++++++++++++++++---
 drivers/power/reset/qcom-pon.c | 1 +
 2 file changed, 47 insertions(+), 4 deletions(-)
-- 
2.35.1

