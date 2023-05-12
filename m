Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B62700DA2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 19:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237858AbjELRH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 13:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjELRH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 13:07:56 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251742D48;
        Fri, 12 May 2023 10:07:56 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CENxnA001094;
        Fri, 12 May 2023 17:07:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=LAiuteAWsOV/vzIQ0ImQoj/ziFfYW5rZdBY2T6LsP30=;
 b=EAAYbIc33YdiTFMVU0z5aGB617JUCtA2fImJkufXN2nrTDQIGq6hb/IavbttRbv8TPt0
 oDVsuOkmLDqVdVpJcBYXWMSmuaNWK+4QHjIERXiaDbbdD2iPvA/CZl04LaIqprIeduFs
 w+saJVF+OrxuoBb+DiljCjS88Nwb4AyvGCz4m8oaqQwQ6w2YS5oskcXHalN6ZeX4OPJI
 NWet8qrojALE8s15IA7ibxp1QuyRNmC/adDDATVvkQ4PogZXYoNDxhLPMo5OEfJc8jbU
 YGEJHAmHbM9VVs8piu40TpCdgMKtj6NafuV7oD3gyADdRMCs3Nkf7PHiYpri8c7pO69u zg== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qh5g9ajpg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 17:07:52 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34CH7mbQ011252;
        Fri, 12 May 2023 17:07:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3qdy59v8pp-1;
        Fri, 12 May 2023 17:07:48 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34CH7mJq011247;
        Fri, 12 May 2023 17:07:48 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-vnivarth-hyd.qualcomm.com [10.213.111.166])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 34CH7lii011246;
        Fri, 12 May 2023 17:07:48 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3994820)
        id 2D5EA4B21; Fri, 12 May 2023 22:37:47 +0530 (+0530)
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        broonie@kernel.org, quic_vnivarth@quicinc.com,
        dianders@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_msavaliy@quicinc.com, mka@chromium.org, swboyd@chromium.org,
        quic_vtanuku@quicinc.com, quic_ptalari@quicinc.com
Subject: [PATCH 0/2] spi: spi-geni-qcom: Add new interfaces and utilise them to do map/unmap in framework for SE DMA
Date:   Fri, 12 May 2023 22:37:43 +0530
Message-Id: <1683911265-3395-1-git-send-email-quic_vnivarth@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: km-WdgY88ahjDW2t_Tusg9o6r81DubMi
X-Proofpoint-ORIG-GUID: km-WdgY88ahjDW2t_Tusg9o6r81DubMi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_10,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=523 mlxscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 adultscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305120142
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
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

 drivers/soc/qcom/qcom-geni-se.c  |  67 +++++++++++++++++++-------
 drivers/spi/spi-geni-qcom.c      | 101 ++++++++++++++++++++-------------------
 include/linux/soc/qcom/geni-se.h |   4 ++
 3 files changed, 105 insertions(+), 67 deletions(-)

-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by the Linux Foundation.

