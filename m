Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A461A6E958A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 15:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjDTNNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 09:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjDTNN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 09:13:28 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C779510D2;
        Thu, 20 Apr 2023 06:13:26 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33KAojq8008756;
        Thu, 20 Apr 2023 13:13:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=vBAYLqsA8WAZJPKBw43y4LR0EoTqn8Mb69DmXULEdgw=;
 b=QntS+Cb0U6FyBetpLNG6E3asfhZ4Gk0makPvb+jhkXv4ZYtzU2hCXCA6mcTLBsiFJqUr
 TUbqvZ3y03lWuDLtSZxzBrcucBSz8zwfVh8ly9gvYXtFdh5cE90MzX3XLcuubORNKSbj
 ZxYCJzdIuCWSsAUtg0zeyCHrfk1hETz4JkkHLLuxsCch+EV0gWeV9Wbt/p3lRwoq5C82
 qzAJb/BhGfxyBzldu+88jXGPqoGYhTFZY4/bi2rGKb6ighlIwpEK2z54TBn/pYTwUJpU
 1B0Knl4QI+nsaSz+Jfd0UgvYLRpNdbCTzobQIXsZ+S5KY9P9UHHfX0xaZe1XRjqxMSVQ 9g== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q2xuhs2yt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Apr 2023 13:13:23 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 33KDDI7g012041;
        Thu, 20 Apr 2023 13:13:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3pyn0kkgpn-1;
        Thu, 20 Apr 2023 13:13:18 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33KDDItC012036;
        Thu, 20 Apr 2023 13:13:18 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-vnivarth-hyd.qualcomm.com [10.213.111.166])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 33KDDITF012035;
        Thu, 20 Apr 2023 13:13:18 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3994820)
        id C26FF47A4; Thu, 20 Apr 2023 18:43:17 +0530 (+0530)
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
Subject: [PATCH v4 0/5] spi: Add DMA mode support to spi-qcom-qspi
Date:   Thu, 20 Apr 2023 18:43:09 +0530
Message-Id: <1681996394-13099-1-git-send-email-quic_vnivarth@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1KU1PZ87wOuYX2M1TLsXaFogAJE9qhtF
X-Proofpoint-GUID: 1KU1PZ87wOuYX2M1TLsXaFogAJE9qhtF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-20_09,2023-04-20_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 phishscore=0 spamscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=365 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304200107
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are large number of QSPI irqs that fire during boot/init and later
on every suspend/resume.
This could be made faster by doing DMA instead of PIO.
Below is comparison for number of interrupts raised in 2 scenarios...
Boot up and stabilise
Suspend/Resume

Sequence   PIO    DMA
=======================
Boot-up    69088  19284
S/R        5066   3430

Speed test results...
spi-nor read times in sec after 2 min uptime
============================================
PIO - Iterations-1000, min=3.18, max=3.74, avg=3.53
DMA - Iterations-1000, min=1.21, max=2.28, avg=1.79

spi-nor write times in sec after 2 min uptime
=============================================
PIO - Iterations-1000, min=3.20, max=8.24, avg=3.58
DMA - Iterations-1000, min=1.25, max=5.13, avg=1.82

Further testing performed...
a) multiple entries in sgt (simulated by max_dma_len = 1024)
b) fallback to pio (simulated by dma setup failure)

Vijaya Krishna Nivarthi (5):
  spi: dt-bindings: qcom,spi-qcom-qspi: Add iommus
  arm64: dts: qcom: sc7180: Add stream-id of qspi to iommus
  arm64: dts: qcom: sc7280: Add stream-id of qspi to iommus
  arm64: dts: qcom: sdm845: Add stream-id of qspi to iommus
  spi: spi-qcom-qspi: Add DMA mode support
---
v3 -> v4:
- Dropped unaligned dma buffer handling
- Added sdm845, sc7180 dtsis to the series

v2 -> v3:
- Modified commit messages
- Made a change to driver based on re-review

v1 -> v2:
- Added documentation file to the series
- Made changes to driver based on HPG re-review
---
 .../bindings/spi/qcom,spi-qcom-qspi.yaml           |   3 +
 arch/arm64/boot/dts/qcom/sc7180.dtsi               |   1 +
 arch/arm64/boot/dts/qcom/sc7280.dtsi               |   1 +
 arch/arm64/boot/dts/qcom/sdm845.dtsi               |   1 +
 drivers/spi/spi-qcom-qspi.c                        | 292 +++++++++++++++++++--
 5 files changed, 271 insertions(+), 27 deletions(-)

-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by the Linux Foundation.

