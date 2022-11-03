Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60109618725
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 19:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbiKCSLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 14:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiKCSLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 14:11:10 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD48BC6;
        Thu,  3 Nov 2022 11:11:05 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A3EGMxv018288;
        Thu, 3 Nov 2022 18:10:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=OG3ZTVkiPmyvpPF5mJKUEJHl0NC19XqSJrIaLunOOLI=;
 b=aQdody+5AW4ELl+RJ+vKsU3uRtZqsxe3OKiBi3CEMwl5a5PebEugYri7sF4FdwnUJkGy
 l+vJIdb3+mZi8FDzNjE5pV1x8nF4U3J/Fz1sfSBtRhkJZivoqYWImgw7NLP5cAXyCjzH
 5ORdQGpLSa+JCvGmmo2pwnmEKyGwRGpBH2auHeOJ6GYc0yaHDqkU2iD6oVESVYoiHOGx
 /Ldjyfe+jqUNXT6TK+1YBs36S3eHEhqWkbhpDPMBTK3GVouDG3b8Bb3ZFQmZgA2aaanh
 zmlFK8g+vJuLyRa9epWICMSCWgKa7oP6sZBNmgAsB6UP6WFigYJk6W7Za0MKDyeInbB5 VA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3km6yjjd6v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 18:10:58 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A3IAvPD027804
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 3 Nov 2022 18:10:57 GMT
Received: from th-lint-050.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 3 Nov 2022 11:10:56 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     Johan Hovold <johan@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] pinctrl: qcom: sc8280xp: Rectify UFS reset pins
Date:   Thu, 3 Nov 2022 11:10:51 -0700
Message-ID: <20221103181051.26912-1-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4Iq4sCA--5RnHfNi21eqtdGhJXNZ8Csr
X-Proofpoint-GUID: 4Iq4sCA--5RnHfNi21eqtdGhJXNZ8Csr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-03_04,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 adultscore=0 clxscore=1011 phishscore=0 bulkscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211030123
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anjana Hari <quic_ahari@quicinc.com>

UFS reset pin offsets are wrongly configured for SC8280XP,
correcting the same for both UFS instances here.

Signed-off-by: Anjana Hari <quic_ahari@quicinc.com>
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 drivers/pinctrl/qcom/pinctrl-sc8280xp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-sc8280xp.c b/drivers/pinctrl/qcom/pinctrl-sc8280xp.c
index aa2075390f3e..e96c00686a25 100644
--- a/drivers/pinctrl/qcom/pinctrl-sc8280xp.c
+++ b/drivers/pinctrl/qcom/pinctrl-sc8280xp.c
@@ -1873,8 +1873,8 @@ static const struct msm_pingroup sc8280xp_groups[] = {
 	[225] = PINGROUP(225, hs3_mi2s, phase_flag, _, _, _, _, egpio),
 	[226] = PINGROUP(226, hs3_mi2s, phase_flag, _, _, _, _, egpio),
 	[227] = PINGROUP(227, hs3_mi2s, phase_flag, _, _, _, _, egpio),
-	[228] = UFS_RESET(ufs_reset, 0xf1004),
-	[229] = UFS_RESET(ufs1_reset, 0xf3004),
+	[228] = UFS_RESET(ufs_reset, 0xf1000),
+	[229] = UFS_RESET(ufs1_reset, 0xf3000),
 	[230] = SDC_QDSD_PINGROUP(sdc2_clk, 0xe8000, 14, 6),
 	[231] = SDC_QDSD_PINGROUP(sdc2_cmd, 0xe8000, 11, 3),
 	[232] = SDC_QDSD_PINGROUP(sdc2_data, 0xe8000, 9, 0),
-- 
2.17.1

