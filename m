Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707266D969F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 14:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237969AbjDFMAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 08:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236785AbjDFMAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 08:00:33 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E94CA5EA;
        Thu,  6 Apr 2023 04:57:54 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33651gm9015184;
        Thu, 6 Apr 2023 11:57:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=1yteelog3Wl7kwUh4NMc2dyQp6RkZQkjQy5qXHC4OPs=;
 b=H7z+6UOU+jaSvC+xYGQfhcR6gJMRhVmjD/X6wzMthCir6ZuUktiGQrQUOIhpYC+Z1nCz
 w5FGUhI9s4Ma8FYHwBP53oZSITK6OdvkemEuGhj0fCDcq9FYlWC/0t+mTZ0pwxwRUOhp
 bFpUeNXRuzatytUGj1E2XshvX3vC4vf1z2cERc2U2LsB2ukcSczuibLh+Cnnt0sM6IHY
 xpnOJhSeA7MblWdlNgXgdXKV28+BcOzEK3/OiXnxEBDG7yFbGHKUB94uq5yVk72Musc+
 lSqBmllr4jKDcjzge6Oujc+r0FlfbZrOEeg0i0AbQMPB8dZLbeKwv/6cvS1KftavS3Sl /Q== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ps8h0ar84-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Apr 2023 11:57:51 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 336BvpAg005206
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Apr 2023 11:57:51 GMT
Received: from hu-tnimkar-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 6 Apr 2023 04:57:48 -0700
From:   Tushar Nimkar <quic_tnimkar@quicinc.com>
To:     <andersson@kernel.org>, <agross@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_lsrao@quicinc.com>, <quic_mkshah@quicinc.com>,
        <abel.vesa@linaro.org>, Tushar Nimkar <quic_tnimkar@quicinc.com>
Subject: [PATCH] soc: qcom: rpmh-rsc: Support RSC v3 minor versions
Date:   Thu, 6 Apr 2023 17:27:32 +0530
Message-ID: <20230406115732.9293-1-quic_tnimkar@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: DzVQL5mav8pmZ2SNF7m-JKzADzxYKEyC
X-Proofpoint-ORIG-GUID: DzVQL5mav8pmZ2SNF7m-JKzADzxYKEyC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_06,2023-04-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 adultscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 priorityscore=1501 clxscore=1011 mlxscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304060104
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RSC v3 register offsets are same for all minor versions of v3. Fix a
minor version check to pick correct offsets for all v3 minor versions.

Fixes: 40482e4f7364 ("soc: qcom: rpmh-rsc: Add support for RSC v3 register offsets")
Signed-off-by: Tushar Nimkar <quic_tnimkar@quicinc.com>
---
 drivers/soc/qcom/rpmh-rsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 0f8b2249f889..f93544f6d796 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -1073,7 +1073,7 @@ static int rpmh_rsc_probe(struct platform_device *pdev)
 	drv->ver.minor = rsc_id & (MINOR_VER_MASK << MINOR_VER_SHIFT);
 	drv->ver.minor >>= MINOR_VER_SHIFT;
 
-	if (drv->ver.major == 3 && drv->ver.minor == 0)
+	if (drv->ver.major == 3 && drv->ver.minor >= 0)
 		drv->regs = rpmh_rsc_reg_offset_ver_3_0;
 	else
 		drv->regs = rpmh_rsc_reg_offset_ver_2_7;
-- 
2.17.1

