Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129BD6A791C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 02:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjCBBm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 20:42:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjCBBm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 20:42:26 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D45580D4;
        Wed,  1 Mar 2023 17:41:59 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 321NUdGF019557;
        Thu, 2 Mar 2023 01:41:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=W5Fsj0D2PjEqi7yD+R6eoQDUqd0GGArIuCqk2z+tAGI=;
 b=f9YM4Yg9/eZQPYRd3j1t2EZqV8enTvuE7uaPsGgyTn78rxeVmMe9tIsbcsBOaYiv/7oB
 coLZpQzCxsBNeSuIukYmK9g2dlvQjGJVxrWn4lSEEojilIgfgo7tDszi3A2wnwRresEL
 Mcnd4divDnXL2dEaRUMb6afjxXT8V2IL8kGTYe4b8NNMGD6BxqfwZEVk//pVdQwdXymv
 VuEU5KR+YQbg/mp+VO94Za2o6ccR2sE7vk8VJZK50Tg+eFr3c0eO3C5+Ve8gNn8HblBz
 L+1XQAbihgjRW3rCi+5UfXWv89ZfGMkc1BO9LoUt5TmB1rUUNeccwJdTw602LEG9tOeQ dQ== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p2asps50w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Mar 2023 01:41:26 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3221fPPq010144
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 2 Mar 2023 01:41:25 GMT
Received: from asutoshd-linux1.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 1 Mar 2023 17:41:20 -0800
From:   Asutosh Das <quic_asutoshd@quicinc.com>
To:     <quic_cang@quicinc.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>
CC:     <quic_nguyenb@quicinc.com>, <quic_xiaosenh@quicinc.com>,
        <stanley.chu@mediatek.com>, <adrian.hunter@intel.com>,
        <bvanassche@acm.org>, <avri.altman@wdc.com>, <mani@kernel.org>,
        <beanhuo@micron.com>, Asutosh Das <quic_asutoshd@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "open list" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/1] ufs: mcq: qcom: Fix passing zero to PTR_ERR
Date:   Wed, 1 Mar 2023 17:41:06 -0800
Message-ID: <94ca99b327af634799ce5f25d0112c28cd00970d.1677721072.git.quic_asutoshd@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 72ft9D9LAwQDz6VfaaxDTcyu-YShsEqr
X-Proofpoint-ORIG-GUID: 72ft9D9LAwQDz6VfaaxDTcyu-YShsEqr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-01_17,2023-03-01_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 mlxscore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2303020010
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix an error case in ufs_qcom_mcq_config_resource(), where the
return value is set to 0 before passing it to PTR_ERR.

This led to Smatch warning:
drivers/ufs/host/ufs-qcom.c:1455 ufs_qcom_mcq_config_resource() warn:
passing zero to 'PTR_ERR'

Fixes: c263b4ef737e ("scsi: ufs: core: mcq: Configure resource regions")
Reported-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>

--
v1 -> v2
- Split to 2 patches
- Addressed Mani's comments
--
---
 drivers/ufs/host/ufs-qcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 34fc453f3eb1..43b1fc1ad33e 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -1451,8 +1451,8 @@ static int ufs_qcom_mcq_config_resource(struct ufs_hba *hba)
 		if (IS_ERR(res->base)) {
 			dev_err(hba->dev, "Failed to map res %s, err=%d\n",
 					 res->name, (int)PTR_ERR(res->base));
-			res->base = NULL;
 			ret = PTR_ERR(res->base);
+			res->base = NULL;
 			return ret;
 		}
 	}
-- 
2.7.4

