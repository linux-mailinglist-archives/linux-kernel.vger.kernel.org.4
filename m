Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B396A9471
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 10:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjCCJvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 04:51:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjCCJvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 04:51:24 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF6E1A962;
        Fri,  3 Mar 2023 01:51:19 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3232J47Y023300;
        Fri, 3 Mar 2023 09:51:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=MBXFQbQ8/M6oYQhXzB4/74DABc5E0kzDDAvaw1vFhYY=;
 b=coXAMzJKR8rFwqXS1aDyy8FjQm3aL3Mo95ksawoHe0EwYMzG+/gHHc1NJA/+yLueYkh8
 2oWSbbY+07t0D1TUfmZWINhB1RYs1SYX6BYIitqdUaD0eyFmsyOLrPyTK6ig9lXZHYhi
 G4+rcmt8Zv5TCtmetcSTxcoUSyuC6OTiHHQDsMtLD6ormJgliksmtOSaK9WdkKNcwVs3
 aQn5av3McZqCmK/b2VsXL9PCjoAyRRLDRnzI3JPuXMu+MOdegLCwBvOS/iMBs72AKGsV
 OdButnqCkTMEHB3nLPcPTk6G3MfipLs+QNpl+tPKXzL5lIm6S1lkDtZT8G8QKNWib1Lk Cw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p3801s13b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Mar 2023 09:51:13 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3239pCSA027369
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 Mar 2023 09:51:12 GMT
Received: from fenglinw2-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Fri, 3 Mar 2023 01:51:09 -0800
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
To:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lee@kernel.org>, <pavel@ucw.cz>, <krzysztof.kozlowski@linaro.org>
CC:     <quic_collinsd@quicinc.com>, <quic_subbaram@quicinc.com>,
        <quic_fenglinw@quicinc.com>
Subject: [PATCH v8 0/2]  Add LED driver for flash module in QCOM PMICs
Date:   Fri, 3 Mar 2023 17:50:21 +0800
Message-ID: <20230303095023.538917-1-quic_fenglinw@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: K0mQJBoGAtKM6TBJPiFnRADeUN6_HwD9
X-Proofpoint-GUID: K0mQJBoGAtKM6TBJPiFnRADeUN6_HwD9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-03_01,2023-03-02_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 adultscore=0
 spamscore=0 bulkscore=0 mlxscore=0 suspectscore=0 clxscore=1015
 mlxlogscore=628 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2303030087
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initial driver and binding document changes for supporting flash LED
module in Qualcomm Technologies, Inc. PMICs.

Changes in V8:
  1. Introduce a helper function 'flcdev_to_qcom_fled()'.
  2. Rename 'struct qcom_flash_chip' as 'struct qcom_flash_data' and
     remove 'qcom_flash_led' data pointers from it to avoid interwoven
     reference. Also remove the 'dev' pointer.
  3. Remove 'v4l2_flash' data pointer in 'struct qcom_flash_led' and
     move it to 'struct qcom_flash_data'.
	
Changes in V7:
  1. Fix compilation issue reported by kernel test robot

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
 drivers/leds/flash/leds-qcom-flash.c          | 773 ++++++++++++++++++
 4 files changed, 905 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/qcom,spmi-flash-led.yaml
 create mode 100644 drivers/leds/flash/leds-qcom-flash.c

-- 
2.25.1

