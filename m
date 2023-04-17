Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4196E3E96
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 06:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjDQEoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 00:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjDQEoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 00:44:10 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0622D62;
        Sun, 16 Apr 2023 21:44:09 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33H2tcDw003018;
        Mon, 17 Apr 2023 04:44:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=kOr6fLDudhDfZ6l2BHMtwGUUEg+aggLzC+teQI5csXc=;
 b=Vakpm52Y30UWa663oz43W9Wrgo4QB/nDtDD7SHRyBOnhbbpKe+MX5LyEiHLzRmzpvP+7
 vC0EJlJGQSfi8+bLceH8h0IYZ+Zq1A68VPeVfQrtcarO2apj79F6+FNSsvJ4W6hPODie
 hzMwexrSFB4/Lk4DT7gDS5MRsmoe/z7QhTi5P4L8GSFFMmp3vU/O3RW6Nw3fwcyZrZU8
 bH3cBnx2156812xGzPDVhvkELIwOIUmtIKzpQ18ykSuAyYfT+70MvO4E02y2/ENYOZx8
 YvyAPc+qEn5o/M4VarntJInl2TqKBT4CmPKQu27HzHuh2ZIbX0xvWCuJpSpRoOi9tiqd Dw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pyn2x2gxq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 04:44:05 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33H4i4Cg027814
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 04:44:04 GMT
Received: from kathirav-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Sun, 16 Apr 2023 21:44:01 -0700
From:   Kathiravan T <quic_kathirav@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <quic_kathirav@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] clk: qcom: ipq5332: fix the src parameter in ftbl_gcc_apss_axi_clk_src
Date:   Mon, 17 Apr 2023 10:13:42 +0530
Message-ID: <20230417044342.9406-1-quic_kathirav@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: B4Hy5O2JbShcyOsZ2ji6SzdYb13WYziy
X-Proofpoint-ORIG-GUID: B4Hy5O2JbShcyOsZ2ji6SzdYb13WYziy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-17_02,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=875
 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1011
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304170041
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

480MHz is derived from P_GPLL4_OUT_AUX not from P_GPLL4_OUT_MAIN. Update
the freq_tbl with the correct src.

Fixes: 3d89d52970fd ("clk: qcom: add Global Clock controller (GCC) driver for IPQ5332 SoC")
Reported-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
---
 drivers/clk/qcom/gcc-ipq5332.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/gcc-ipq5332.c b/drivers/clk/qcom/gcc-ipq5332.c
index bdb4a0a11d07..8cacbfb10c72 100644
--- a/drivers/clk/qcom/gcc-ipq5332.c
+++ b/drivers/clk/qcom/gcc-ipq5332.c
@@ -366,7 +366,7 @@ static struct clk_rcg2 gcc_adss_pwm_clk_src = {
 };
 
 static const struct freq_tbl ftbl_gcc_apss_axi_clk_src[] = {
-	F(480000000, P_GPLL4_OUT_MAIN, 2.5, 0, 0),
+	F(480000000, P_GPLL4_OUT_AUX, 2.5, 0, 0),
 	F(533333333, P_GPLL0_OUT_MAIN, 1.5, 0, 0),
 	{ }
 };
-- 
2.17.1

