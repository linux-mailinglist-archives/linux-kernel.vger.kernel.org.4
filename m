Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5FDD6E2532
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 16:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjDNOG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 10:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjDNOGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:06:48 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE5DBBA8;
        Fri, 14 Apr 2023 07:06:30 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33EDiX4t032368;
        Fri, 14 Apr 2023 14:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=EKe2QrwUnzXz12XwmiQu3Ki5QHbBdv8NEZKMxWSPElM=;
 b=pczyRFsQITwiYwziOzBeOlHyQVSBYZHZwKDEm+gVuqvtUGJxd2+EMmwiFojeNWhdAzn8
 wg2W/mUi9p3DbvE72AQtGegW9m2QTf+9NoJCnHVvu5U+x4NMbiK647QdTxSl9jZGqJIP
 BwHm8q8jddKFm1zKy71jyK32ZM2Zi7RqfakheuVlekeuRE2FrxZJx9LZQrE+9Nn1Z7KR
 KkzSCAJGLQ3Cb5v5Zo6bwlG6OJ8+ciuH9HtV5AhEabe2atTKryG4vmr+hvsIMzepQ2he
 8YYmjM2PaH/MNbHPuDbfHqSq5CV0SWcbtSBDEoehcVvU/pcxwQNbLGkqwi9R1/RXscZG 1g== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3py1wpguvd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 14:06:01 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 33EE5vOw024648;
        Fri, 14 Apr 2023 14:05:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3pu1bkwpvv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 14 Apr 2023 14:05:57 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33EE5vlC024643;
        Fri, 14 Apr 2023 14:05:57 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-vnivarth-hyd.qualcomm.com [10.213.111.166])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 33EE5vTQ024642;
        Fri, 14 Apr 2023 14:05:57 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3994820)
        id 85DC1466C; Fri, 14 Apr 2023 19:35:56 +0530 (+0530)
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     quic_msavaliy@quicinc.com, dianders@chromium.org, mka@chromium.org,
        swboyd@chromium.org, quic_vtanuku@quicinc.com,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Subject: [PATCH v3 0/3] spi: Add DMA mode support to spi-qcom-qspi
Date:   Fri, 14 Apr 2023 19:35:50 +0530
Message-Id: <1681481153-24036-1-git-send-email-quic_vnivarth@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: F74-kWDR6i4unDVgIBqZLi47ef8HHvJw
X-Proofpoint-ORIG-GUID: F74-kWDR6i4unDVgIBqZLi47ef8HHvJw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-14_07,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 adultscore=0 priorityscore=1501 mlxscore=0 phishscore=0 impostorscore=0
 mlxlogscore=418 malwarescore=0 lowpriorityscore=0 clxscore=1011
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304140126
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
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
  spi: dt-bindings: qcom,spi-qcom-qspi: Add iommus
  arm64: dts: qcom: sc7280: Add stream-id of qspi to iommus
  spi: spi-qcom-qspi: Add DMA mode support
---
v2 -> v3:
- Modified commit messages
- Made a change to driver based on re-review

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

