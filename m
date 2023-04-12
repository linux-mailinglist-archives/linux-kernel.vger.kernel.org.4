Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0576DFA1C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 17:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjDLPa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 11:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjDLPaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 11:30:23 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0CD30C0;
        Wed, 12 Apr 2023 08:29:59 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33C8Le9w006517;
        Wed, 12 Apr 2023 15:29:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=F8vDMqMjSMjWPygyLGBglPmaN7Yght1TL/B3+UASA1I=;
 b=jE5wRATXHAbFimvFIj1yUJ/laPvAu+CgKyG72+A2qQVnP1lpwjk4vBRzE2jm7Ic5xrez
 juin3EY5KvL+J0rLbjxswj+j8r8IbRj38Xi0N7icHNuI5cCVifcWGxBNmlh6lU/wVadh
 UNxL7LEDCAeRldfjY3InFvcuqxyITYZ86ohzX+0ghCFQYaygRtFdIUpF/NrE3NN0rd6b
 6teZIX8rEJWR8ySex3vHTxz8i6tMkjQTnUsJ+cQJ6u34N7SCcnjDoa+83gFccCVOF3yf
 5aqv7a6TpiZ2jS49OrbryDYS1Rs3xdJ9tONj2v2uGLm/B7cXO7FJKCyctYj6H7SsTojN pQ== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pwchbtcyb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 15:29:55 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 33CFTpw4027880;
        Wed, 12 Apr 2023 15:29:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3pu1bksugf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 12 Apr 2023 15:29:51 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33CFToPb027866;
        Wed, 12 Apr 2023 15:29:50 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-vnivarth-hyd.qualcomm.com [10.213.111.166])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 33CFTo6h027862;
        Wed, 12 Apr 2023 15:29:50 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3994820)
        id D4D38453F; Wed, 12 Apr 2023 20:59:49 +0530 (+0530)
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        broonie@kernel.org, vkoul@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Cc:     quic_msavaliy@quicinc.com, dianders@chromium.org, mka@chromium.org,
        swboyd@chromium.org, quic_vtanuku@quicinc.com,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Subject: [V2 0/3] spi: Add DMA mode support to spi-qcom-qspi
Date:   Wed, 12 Apr 2023 20:59:44 +0530
Message-Id: <1681313387-8376-1-git-send-email-quic_vnivarth@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: P5-0wPoFMA81XyyH7rgFzHK-rqbyDsOX
X-Proofpoint-GUID: P5-0wPoFMA81XyyH7rgFzHK-rqbyDsOX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-12_06,2023-04-12_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 mlxlogscore=383 suspectscore=0 adultscore=0 spamscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304120134
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are large number of QSPI irqs that fire during boot/init and later
on every suspend/resume.
This could be made faster by doing DMA instead of PIO.
Below is comparison for number of interrupts raised in 2 acenarios...
Boot up and stabilise
Suspend/Resume

Sequence   PIO    DMA
=======================
Boot-up    69088  19284
S/R        5066   3430

Though we have not made measurements for speed, power we expect
the performance to be better with DMA mode and no regressions were
encountered in testing.

Vijaya Krishna Nivarthi (3):
  spi: dt-bindings: qcom,spi-qcom-qspi: Add iommus binding for qspi
  arm64: dts: qcom: sc7280: Add stream-id of qspi to iommus
  spi: spi-qcom-qspi: Add DMA mode support
---
v1 -> v2:
- Added documentation file to the series
- Made changes to driver based on HPG re-review
---
 .../bindings/spi/qcom,spi-qcom-qspi.yaml           |   3 +
 arch/arm64/boot/dts/qcom/sc7280.dtsi               |   1 +
 drivers/spi/spi-qcom-qspi.c                        | 434 +++++++++++++++++++--
 3 files changed, 407 insertions(+), 31 deletions(-)

-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by the Linux Foundation.

