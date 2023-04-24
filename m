Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976956EC8FA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 11:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjDXJdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 05:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjDXJc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 05:32:58 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9119F10F6;
        Mon, 24 Apr 2023 02:32:55 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33O8pedo018712;
        Mon, 24 Apr 2023 09:32:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=F5q53AN4braXVdROkRDfpWqFfH0WhKUr+63yWTr0/ok=;
 b=nu6xSZJOLqpVximq9d8UbmKSp+7ZNpz8aPCA6g9zLvzaUUXTRswN+kDOf+YyTT5+rn2K
 16P8YwiIHD34GPN1/PwLb9sDYVDXISGAbd876w1T6DAe/zu/vTR+uod5sROaq5AVE9MH
 jXBntifSvs6xoI+oCzVxy1YgPfEf+w8EFp+1Z2N5zqWXscAr8o3xXzMVtX1KT8DGbBwY
 SYj4xmUIoIT+76kAy6pB5t2VPdahc4x1UCfQy10OLE6T/Zt7NovfB6o9+4C/OTohe6qc
 +/hi6NZxD2C/T2YgpGiqwNs4Xw344mTG6qPlMVn8tBmK1gHlGAe0RdGNTvGGThXxfBD0 mg== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q48h3axnj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Apr 2023 09:32:48 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 33O9WiJp021140;
        Mon, 24 Apr 2023 09:32:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3q48nkpkme-1;
        Mon, 24 Apr 2023 09:32:44 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33O9WiA5021134;
        Mon, 24 Apr 2023 09:32:44 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-vnivarth-hyd.qualcomm.com [10.213.111.166])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 33O9WiWG021133;
        Mon, 24 Apr 2023 09:32:44 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3994820)
        id 510A347CE; Mon, 24 Apr 2023 15:02:43 +0530 (+0530)
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
Subject: [PATCH v5 0/5] spi: Add DMA mode support to spi-qcom-qspi
Date:   Mon, 24 Apr 2023 15:02:36 +0530
Message-Id: <1682328761-17517-1-git-send-email-quic_vnivarth@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Id3t7Yp1qaqrMNrFbSn42dYNQFNOoye3
X-Proofpoint-GUID: Id3t7Yp1qaqrMNrFbSn42dYNQFNOoye3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-24_06,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=382 mlxscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304240085
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
v4 -> v5:
- Added Reviewed-by tags to dtsis
- Addressed review comments in driver

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
 drivers/spi/spi-qcom-qspi.c                        | 218 ++++++++++++++++++++-
 5 files changed, 218 insertions(+), 6 deletions(-)

-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by the Linux Foundation.

