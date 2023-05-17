Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B557067D6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 14:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbjEQMS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 08:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbjEQMSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 08:18:25 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FB010E9;
        Wed, 17 May 2023 05:18:24 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34HC1BNn015354;
        Wed, 17 May 2023 12:18:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=2u3BfMePA2tfNmr/HMzpxolG9jJcyPkro5D6meuJ8sI=;
 b=TRN7O/x4T2tDVy1NGe5QAcpzvgekH6IoYlZtY2izXr79q2agSLDb+dGakEBiK/EvtqWl
 4piRqiUfYVeqMKQYzLM7y3iokW00pDF02srvrL0lHOm/flcIH0r+O28pj9xiGRC84Pet
 pTkj+J/JuGdr+w6G29r4Eyh9QqD1yZUyTg0M8sxlYLkgOOHtlXUlyT6QDuPlwlKDyara
 HYW8wHc+XDMCpqUiKB93D3BHEfSss/vmGChw3ygbdT6FwrQMKBMPWyObAvxWobrMKBrA
 eBoh7KPgKhwDishq+s7Ut5/2WWQcAnTVCGZ1rBxZoHAE4Yb5flgkyIiIHNMuunZy4kDT jQ== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qmwnr863x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 12:18:21 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34HCIHoQ022258;
        Wed, 17 May 2023 12:18:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3qj3mk69qk-1;
        Wed, 17 May 2023 12:18:17 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34HCIHBV022252;
        Wed, 17 May 2023 12:18:17 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-vnivarth-hyd.qualcomm.com [10.213.111.166])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 34HCIHdd022250;
        Wed, 17 May 2023 12:18:17 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3994820)
        id 71B704B3C; Wed, 17 May 2023 17:48:16 +0530 (+0530)
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        broonie@kernel.org, quic_vnivarth@quicinc.com,
        dianders@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_msavaliy@quicinc.com, mka@chromium.org, swboyd@chromium.org,
        quic_vtanuku@quicinc.com, quic_ptalari@quicinc.com
Subject: [PATCH v2 0/2] spi-geni-qcom: Add new interfaces and utilise them to do map/unmap in framework for SE DMA
Date:   Wed, 17 May 2023 17:48:12 +0530
Message-Id: <1684325894-30252-1-git-send-email-quic_vnivarth@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dLNKqUw9VhoSS_gi9j1fjApY0GzrCn-k
X-Proofpoint-ORIG-GUID: dLNKqUw9VhoSS_gi9j1fjApY0GzrCn-k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_02,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=601
 clxscore=1015 malwarescore=0 priorityscore=1501 spamscore=0 phishscore=0
 adultscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305170100
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A "known issue" during implementation of SE DMA for spi geni driver was
that it does DMA map/unmap internally instead of in spi framework.
Current patches remove this hiccup and also clean up code a bit.

Testing revealed no regressions and results with 1000 iterations of
reading from EC showed no loss of performance.
Results
=======
Before - Iteration 999, min=5.10, max=5.17, avg=5.14, ints=25129
After  - Iteration 999, min=5.10, max=5.20, avg=5.15, ints=25153

Vijaya Krishna Nivarthi (2):
  soc: qcom: geni-se: Add interfaces geni_se_tx_init_dma() and
    geni_se_rx_init_dma()
  spi: spi-geni-qcom: Do not do DMA map/unmap inside driver, use
    framework instead
---
v1 -> v2:
- Modified interfaces arguments and accordingly calls to them
- Added dma_max_len to driver

 drivers/soc/qcom/qcom-geni-se.c  |  67 ++++++++++++++++++-------
 drivers/spi/spi-geni-qcom.c      | 103 +++++++++++++++++++--------------------
 include/linux/soc/qcom/geni-se.h |   4 ++
 3 files changed, 103 insertions(+), 71 deletions(-)

-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by the Linux Foundation.

