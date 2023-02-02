Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E7D6875EA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 07:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjBBGe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 01:34:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjBBGe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 01:34:27 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A1A20D0C;
        Wed,  1 Feb 2023 22:34:26 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3124Oscx009309;
        Thu, 2 Feb 2023 06:34:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=SD+Uulm2RDb3jeFAH3JgTFpfb8auI2A6K79Gn0pNxUY=;
 b=cuxscoOXDKnzgrLObBz1AS34mzcplNpXMF+m2g5gl0ei0pI6gPo/uYsVvPSXEuTeGOQN
 Kcp9qKB8lfkWm2yvc13rkke5jzyWUer+BDRf4ncw1VKhH+2OI5t16+dpe9xxz4ZznTlq
 tV0WeVt8lI0i9mM8nDBu8YdISDhDub9L3dCX2Nu6Ki3G9msYZKe3nWA/0wMr5eDun4tQ
 Bg1wp1Wm0PZ4UUfRCD0s/rPOPPMIxV1zlp+cyvVaKDXswMRSB/HiZ9znsdpBWI/2XvBC
 elHhViUrn54F7V08nR2eMuYg1IASKb+aIGuV9b1o8j2pgPR3TvMLswJ/ip3j15GrsNTX 4A== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nfvgbhbe0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 06:34:19 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3126YIZJ010389
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 2 Feb 2023 06:34:18 GMT
Received: from fenglinw2-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 1 Feb 2023 22:34:15 -0800
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
To:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <pavel@ucw.cz>, <krzysztof.kozlowski@linaro.org>, <lee@kernel.org>
CC:     <quic_collinsd@quicinc.com>, <quic_subbaram@quicinc.com>,
        <quic_fenglinw@quicinc.com>
Subject: [PATCH v6 0/2] Add LED driver for flash module in QCOM PMICs
Date:   Thu, 2 Feb 2023 14:29:04 +0800
Message-ID: <20230202062906.211565-1-quic_fenglinw@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rdqTfPc9X1DsaiiDVC7fCk5QHVKUazPF
X-Proofpoint-ORIG-GUID: rdqTfPc9X1DsaiiDVC7fCk5QHVKUazPF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-01_15,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 spamscore=0 mlxscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 phishscore=0 clxscore=1015 mlxlogscore=693 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302020060
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initial driver and binding document changes for supporting flash LED
module in Qualcomm Technologies, Inc. PMICs.

Changes in V6:
  1. Update the driver to address review comments from Jones,Lee.

Changes in V5:
  1. Add MODULE_DEVICE_TABLE for auto-loading.

Changes in V4:
  1. Added Tested-By tag.
  2. Addressed review comments in the binding change and added
     Reviewed-by tag.

Changes in V3:
  1. Updated the driver to use regmap_field for register access.
  2. Adressed the review comments in binding document change.

Changes in V2:
  1. Addressed review comments in binding change, thanks Krzysztof!
  2. Updated driver to address the compilation issue reported by
     kernel test robot.


Fenglin Wu (2):
  leds: flash: add driver to support flash LED module in QCOM PMICs
  dt-bindings: leds: add QCOM flash LED controller

 .../bindings/leds/qcom,spmi-flash-led.yaml    | 116 +++
 drivers/leds/flash/Kconfig                    |  15 +
 drivers/leds/flash/Makefile                   |   1 +
 drivers/leds/flash/leds-qcom-flash.c          | 768 ++++++++++++++++++
 4 files changed, 900 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/qcom,spmi-flash-led.yaml
 create mode 100644 drivers/leds/flash/leds-qcom-flash.c

-- 
2.25.1

