Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 694D75B40DF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 22:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbiIIUoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 16:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbiIIUoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 16:44:16 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14911395B0;
        Fri,  9 Sep 2022 13:44:11 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 289KONNN005043;
        Fri, 9 Sep 2022 20:44:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=zQQbmiQSfvtk9LSOSEAG32jJrwWAkrYcxODC41R13/E=;
 b=gLHIESNY8LshCrlciAEE4UlTGeVb1Dg7e+brKbWIeR6VixyLQIVk55OBQ4mfEDdJLdWP
 ewPSZdgv2TUZiuUHYpfivY34KN78zW56I37/x6p8+nKnj73eANG/96F/cafblANxToai
 qyL8PF3vZOqYzrwjkuKx/D66RRPeWuQSxhfsUjB9+pViuIykWUtqtQOtQFrPddNwDAoE
 TW8Qa6hJeqP9oGO96j0AIgorHwwQpsO3uAy/VThxmGQFd8VvlE89WIXjf/RiK9kJL9Yx
 mi6J7uDyiVL6Vcqr+YhyNUyqibUlOb26ZGI835xgNzHA5kPox1JwaMhN+XKd/vcyOxUy lg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jfujq460u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Sep 2022 20:44:06 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 289Ki6DC018553
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 9 Sep 2022 20:44:06 GMT
Received: from hu-amelende-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 9 Sep 2022 13:44:05 -0700
From:   Anjelique Melendez <quic_amelende@quicinc.com>
To:     <corbet@lwn.net>, <sre@kernel.org>, <robh+dt@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>
CC:     <krzysztof.kozlowski+dt@linaro.org>, <vkoul@kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_collinsd@quicinc.com>,
        "Anjelique Melendez" <quic_amelende@quicinc.com>
Subject: [RESEND PATCH v5 0/2] add support for PON GEN3 device
Date:   Fri, 9 Sep 2022 13:42:07 -0700
Message-ID: <20220909204207.15820-1-quic_amelende@quicinc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: kDR9_DpmDFFPcfgxMaP6hz5hQYc_7chJ
X-Proofpoint-GUID: kDR9_DpmDFFPcfgxMaP6hz5hQYc_7chJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-09_10,2022-09-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209090072
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Resent with fixed path for dt-bindings.

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

