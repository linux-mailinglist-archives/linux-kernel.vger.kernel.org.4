Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF4276FC35E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 12:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234331AbjEIKBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 06:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbjEIKBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 06:01:50 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D7E2123;
        Tue,  9 May 2023 03:01:49 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3497fSvT021933;
        Tue, 9 May 2023 10:01:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=ttHqVUtYxGm2GfLDGfwf/4RVm6rJoKZE1mkkB2ydqig=;
 b=EzekHIz7qw2FbDBDmabdU1gF5gn6+uU6qeDCe7jPBcy1MpvGrrYb96sYHiU5uwZ02TwB
 rH2kq1dKWoot0qn3oyw7SIwVFXUEtMvRWAR19mD6sKv98DF1ZBby3YDBztnsr5KiRXoc
 BgJ4DQD/7cDUgyp4jDpvrBPOj1mndZEyr4WvRjebT4nBDYd/PUlLnZW96S0Vh2WacqzA
 UKu9MQA0JZ69OgOHAgLzE2pQg4fFlrSJu14xWW4A1xLe0HJ7/YjC1MqXXvuF+00KSu4L
 Qby83jOlQSkEhBinLKi5ppxPpCFfsRrlWUixa2UCNtElQwrO+VvZjgO3blKjTherRzHr AA== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qf7859b5k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 May 2023 10:01:45 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 349A1fCF012853;
        Tue, 9 May 2023 10:01:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3qdy5bg8bm-1;
        Tue, 09 May 2023 10:01:41 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 349A1eHH012848;
        Tue, 9 May 2023 10:01:40 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-vnivarth-hyd.qualcomm.com [10.213.111.166])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 349A1eKZ012845;
        Tue, 09 May 2023 10:01:40 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3994820)
        id EC4734A00; Tue,  9 May 2023 15:31:39 +0530 (+0530)
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        broonie@kernel.org, quic_vnivarth@quicinc.com,
        dianders@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_msavaliy@quicinc.com, mka@chromium.org, swboyd@chromium.org,
        quic_vtanuku@quicinc.com, quic_ptalari@quicinc.com
Subject: [PATCH] spi: spi-geni-qcom: Select FIFO mode for chip select
Date:   Tue,  9 May 2023 15:31:36 +0530
Message-Id: <1683626496-9685-1-git-send-email-quic_vnivarth@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: kC3pOJCSCrGUdeNrfWl7FsaGGE_tnSC9
X-Proofpoint-GUID: kC3pOJCSCrGUdeNrfWl7FsaGGE_tnSC9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-09_06,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 mlxlogscore=529
 lowpriorityscore=0 malwarescore=0 mlxscore=0 impostorscore=0 clxscore=1011
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305090078
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Spi geni driver switches between FIFO and DMA modes based on xfer length.
FIFO mode relies on M_CMD_DONE_EN interrupt for completion while DMA mode
relies on XX_DMA_DONE.
During dynamic switching, if FIFO mode is chosen, FIFO related interrupts
are enabled and DMA related interrupts are disabled. And viceversa.
Chip select shares M_CMD_DONE_EN interrupt with FIFO to check completion.
Now, if a chip select operation is preceded by a DMA xfer, M_CMD_DONE_EN
interrupt would have been disabled and hence it will never receive one
resulting in timeout.

For chip select, in addition to setting the xfer mode to FIFO,
select_mode() to FIFO so that required interrupts are enabled.

Fixes: e5f0dfa78ac7 ("spi: spi-geni-qcom: Add support for SE DMA mode")
Suggested-by: Praveen Talari <quic_ptalari@quicinc.com>
Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
---
 drivers/spi/spi-geni-qcom.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 8a7d1c2..e423efc 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -294,6 +294,8 @@ static void spi_geni_set_cs(struct spi_device *slv, bool set_flag)
 	mas->cs_flag = set_flag;
 	/* set xfer_mode to FIFO to complete cs_done in isr */
 	mas->cur_xfer_mode = GENI_SE_FIFO;
+	geni_se_select_mode(se, mas->cur_xfer_mode);
+
 	reinit_completion(&mas->cs_done);
 	if (set_flag)
 		geni_se_setup_m_cmd(se, SPI_CS_ASSERT, 0);
-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by the Linux Foundation.

