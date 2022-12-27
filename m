Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B153656846
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 09:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiL0IQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 03:16:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiL0IQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 03:16:10 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3DB2602;
        Tue, 27 Dec 2022 00:16:09 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BR6R39d012211;
        Tue, 27 Dec 2022 08:16:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=glbJFwxELcZxlNzcfMHFFIDJ7+hBaZVgwuD7n2eEr6U=;
 b=GZy9YWkXoZwHL/Dd0ZoJgRsvItYgcWqDQJTVASn6044Cd3jim0CPsYcxLRJ72pctxAC7
 7/mxm68zOk05b4nsrFcSBELh4u7akvsG/9JS7Kh6GEaiB2H82WRN167di/65g9xiIFmo
 qUeO1elRkYvYVnxx0xo2CdWOP9WT9/tKyLhyU8MIr2rW6NM7OJnQAHI79s+Hs7oS2zzl
 Oiw2wXF3fhBSWrSTUb42xDZCCsoiBBzcPema/PT1RzjyphrLTV04LeexoUCUYGYB/kQm
 DdiWvL6OR4Kq1daCYbPRMggNCgBSTVmKzCxKkA4fPZkgUdhfnvRsva2tPYpZhdtMNaFN hw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mnrd1c62a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Dec 2022 08:16:04 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BR8G3KY002474
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Dec 2022 08:16:03 GMT
Received: from fenglinw2-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 27 Dec 2022 00:16:01 -0800
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
To:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <pavel@ucw.cz>, <krzysztof.kozlowski@linaro.org>
CC:     <quic_collinsd@quicinc.com>, <quic_subbaram@quicinc.com>,
        <quic_fenglinw@quicinc.com>
Subject: [RESEND PATCH v5 0/2] Add LED driver for flash module in QCOM PMICs
Date:   Tue, 27 Dec 2022 16:15:21 +0800
Message-ID: <20221227081523.2277797-1-quic_fenglinw@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: MimFBRweEFd1nqkYwTftrjy7D3z4sluk
X-Proofpoint-GUID: MimFBRweEFd1nqkYwTftrjy7D3z4sluk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-27_04,2022-12-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 spamscore=0 malwarescore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=703
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212270067
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
 drivers/leds/flash/leds-qcom-flash.c          | 701 ++++++++++++++++++
 4 files changed, 833 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/qcom,spmi-flash-led.yaml
 create mode 100644 drivers/leds/flash/leds-qcom-flash.c

-- 
2.25.1

