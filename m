Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92B06A7F1A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 10:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjCBJ4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 04:56:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbjCBJzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 04:55:40 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC45D3BD81;
        Thu,  2 Mar 2023 01:55:38 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3229YJHD004515;
        Thu, 2 Mar 2023 09:55:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=AM578yABCSbi2S/v8a/9eF8C2ncMOmdSTsQVpBlB91w=;
 b=Q1aIRj7mTlapLe4/6c4XvSsx3O3BPS3I7imkBGIztvCAFUHobHc3ta1SW8sXPO9kgSFO
 NX2GERGRfQHawApjlmAMJzqIot95LJj+AgRbwP2l0gxjVYHR5FxOQqaON2JBtnxBJeCv
 S0biSCvMWV3si0WwFdKNCX/Cf5DOqejHFjQrFBEb8HMX3xoqHOQvWvmeMgQQE4pqM5dU
 ltYGzLi65zgXP7sXzR68QTc5NcgUecM1Ejk0kU6tKZ086iVakSddGhsKlDoHKeb0bM4V
 Bi0sC8VojRNHb4QQBXRC901W2yGDK5Fp8lTPWzo3suNsKzwasf5Ye33p8Vbw35g+ZkLa Og== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p25jwk30a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Mar 2023 09:55:31 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3229tT9i024171
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 2 Mar 2023 09:55:30 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 2 Mar 2023 01:55:27 -0800
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Varadarajan Narayanan <quic_varada@quicinc.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/8] usb: dwc3: core: Handle fladj becoming zero
Date:   Thu, 2 Mar 2023 15:25:08 +0530
Message-ID: <6f5cd1d796fb7c666348cc611b2f8178c009e2e4.1677749625.git.quic_varada@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1677749625.git.quic_varada@quicinc.com>
References: <cover.1677749625.git.quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: W3cp4ljq052XZKO42MTuzhmB2scGRbhk
X-Proofpoint-ORIG-GUID: W3cp4ljq052XZKO42MTuzhmB2scGRbhk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_04,2023-03-02_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 suspectscore=0 phishscore=0
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2303020086
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In dwc3_ref_clk_period, the computation

	fladj = div64_u64(125000ULL * NSEC_PER_SEC, (u64)rate * period);
	fladj -= 125000;

could turn out to be zero. If fladj is zero, the following
FIELD_PREP clears out that field and the user overridden value
set in the DTS using "snps,quirk-frame-length-adjustment" is
lost. Ensure to retain the user overridden value if the above
evaluates to 0.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 drivers/usb/dwc3/core.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 476b636..63af83b 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -401,6 +401,33 @@ static void dwc3_ref_clk_period(struct dwc3 *dwc)
 	fladj -= 125000;
 
 	/*
+	 * Since rate = NSEC_PER_SEC / period and period = NSEC_PER_SEC / rate
+	 * above calculation could turn out to be zero.
+	 *
+	 * if (dwc->ref_clk)
+	 *	125000 * NSEC_PER_SEC    125000 * NSEC_PER_SEC
+	 *	--------------------- => ---------------------
+	 *	    rate * period         rate * NSEC_PER_SEC
+	 *					 ------------
+	 *					     rate
+	 * else
+	 *	125000 * NSEC_PER_SEC    125000 * NSEC_PER_SEC
+	 *	--------------------- => ---------------------
+	 *	    rate * period        NSEC_PER_SEC * period
+	 *				 ------------
+	 *				    period
+	 * Hence, the calculation
+	 *	div64_u64(125000ULL * NSEC_PER_SEC, (u64)rate * period)
+	 * returns 125000ULL and fladj -= 125000 sets fladj to zero.
+	 * If fladj is zero, the following FIELD_PREP clears out that
+	 * field and the user overridden value set in the DTS using
+	 * "snps,quirk-frame-length-adjustment" is lost. Ensure to retain
+	 * the user overridden value if the above calculation evaluates to 0.
+	 */
+	if (fladj == 0)
+		fladj = FIELD_GET(DWC3_GFLADJ_REFCLK_FLADJ_MASK, dwc->fladj);
+
+	/*
 	 * The documented 240MHz constant is scaled by 2 to get PLS1 as well.
 	 */
 	decr = 480000000 / rate;
-- 
2.7.4

