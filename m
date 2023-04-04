Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E6C6D6B1B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 20:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235919AbjDDSDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 14:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234983AbjDDSDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 14:03:34 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438904687;
        Tue,  4 Apr 2023 11:03:34 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 334E5VV6000646;
        Tue, 4 Apr 2023 18:03:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=0BFYPQS1UqhfZZvnAAsFORkAxtcONmIhYtojA59W0HQ=;
 b=G+ZSC93oeHXb31ukD+/iSZIoLBhIy9I8jITJp5whjoOd2JJowFIvWUOJcT4hJSwSDbDe
 J0hrnGQWDBv/D3zT3UGEuZtMA1BWCMDv6qSNjuF0yDuJ1ROrgb3cAZuRl+Zv67l3uCK8
 NW77rDUi/39j7SSQ7Fz4lkTHZkNC8PS/Ben7VPli63lefNdS/fHd7uU0tqqDdR0qPJze
 nz/A4Kfh1e4C5J9OBvXsjPhsB9I0Cy21k95TIR4JFYkVFeFziNQcJXJvfi3Lw8gpFuan
 jIw2yU1GZEFMAnSJxXuM7D12vbCY1Vk+9X6FJgoTvPbuRRZSM1c5/qNrlgmrxHc76y8v Mw== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3prnbt0nth-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Apr 2023 18:03:30 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 334I0Lrn017842;
        Tue, 4 Apr 2023 18:03:25 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3ppdpkvtr7-1;
        Tue, 04 Apr 2023 18:03:25 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 334I3PZp021639;
        Tue, 4 Apr 2023 18:03:25 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-vnivarth-hyd.qualcomm.com [10.213.111.166])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 334I3OVm021638;
        Tue, 04 Apr 2023 18:03:25 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3994820)
        id 42E653B69; Tue,  4 Apr 2023 23:33:24 +0530 (+0530)
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        broonie@kernel.org, vkoul@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Cc:     quic_msavaliy@quicinc.com, dianders@chromium.org, mka@chromium.org,
        swboyd@chromium.org, quic_vtanuku@quicinc.com,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Subject: [PATCH 0/2] spi: Add DMA mode support to spi-qcom-qspi
Date:   Tue,  4 Apr 2023 23:33:18 +0530
Message-Id: <1680631400-28865-1-git-send-email-quic_vnivarth@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: OIanKax0CG2WIC_8UWTEf9Q49a-D9BVL
X-Proofpoint-GUID: OIanKax0CG2WIC_8UWTEf9Q49a-D9BVL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-04_09,2023-04-04_05,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 lowpriorityscore=0 mlxlogscore=305
 bulkscore=0 impostorscore=0 spamscore=0 clxscore=1011 adultscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304040165
X-Spam-Status: No, score=-0.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
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

Vijaya Krishna Nivarthi (2):
  arm64: dts: qcom: sc7280: Add stream-id of qspi to iommus
  spi: spi-qcom-qspi: Add DMA mode support

 arch/arm64/boot/dts/qcom/sc7280.dtsi |   1 +
 drivers/spi/spi-qcom-qspi.c          | 429 ++++++++++++++++++++++++++++++++---
 2 files changed, 399 insertions(+), 31 deletions(-)

-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by the Linux Foundation.

