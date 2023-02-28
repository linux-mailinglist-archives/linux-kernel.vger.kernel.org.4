Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37DD76A5EC3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 19:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjB1S1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 13:27:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjB1S1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 13:27:42 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDEF0166FE;
        Tue, 28 Feb 2023 10:27:34 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31SFbeXD015229;
        Tue, 28 Feb 2023 18:27:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=JISsqcbzGbAnTkSOPNXA4pSRDZXcEEaKP0m9rZvARmM=;
 b=HpgQSc6rVXGotwG4recLpqFsUFE4aMR0vWoPwV4xmvxnrldjaIpNkqCTk3iMKTQy4dwH
 LPBGws9gtOijnEnCh8qydQP6UsW9EEU9Sw6i2q8yBcbJ5oD0mMxEFvK5NuqLPBLYvT7t
 6BysCl/O5zSM1uqBwSG5LViIq07yYUBD5K+IIOObUNFyD3kbumxQi+1sOdxzEhLIaoCH
 tMtWwdYI4cSqP/0Dn9Z8eBeFc01hoJ2n98xlWEX5qjPKdw+oVxjlB6792AWwytpo2Wux
 TMUgM6IW3vq2G4QZb/U9SNf0JkSF5CG0P0F8dCfFgx75eZ/RN7tQz33hDQjCS2JOdxag 7Q== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p1f7n1kqk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Feb 2023 18:27:24 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31SIRNct011485
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Feb 2023 18:27:23 GMT
Received: from asutoshd-linux1.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 28 Feb 2023 10:27:23 -0800
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
Subject: [PATCH v1 1/1] ufs: mcq: qcom: Fix Smatch static checker warning
Date:   Tue, 28 Feb 2023 10:27:06 -0800
Message-ID: <80523aada69f5cab90cac76c84aa153b1ea648ad.1677608784.git.quic_asutoshd@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QuEE7mbaArZKNVBtKPhikmZCf5MhJE0b
X-Proofpoint-ORIG-GUID: QuEE7mbaArZKNVBtKPhikmZCf5MhJE0b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-02-28_15,2023-02-28_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=975 clxscore=1011 mlxscore=0
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302280153
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch (c263b4ef737e: "scsi: ufs: core: mcq: Configure resource
regions") from Jan 13, 2023, leads to the following Smatch static
checker warning:

drivers/ufs/host/ufs-qcom.c:1455 ufs_qcom_mcq_config_resource() warn:
passing zero to 'PTR_ERR'
drivers/ufs/host/ufs-qcom.c:1469 ufs_qcom_mcq_config_resource() info:
returning a literal zero is cleaner

Fix the above warnings.

Fixes: c263b4ef737e ("scsi: ufs: core: mcq: Configure resource regions")
Reported-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>
---
 drivers/ufs/host/ufs-qcom.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 34fc453f3eb1..cb20c7136c2c 100644
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
@@ -1466,7 +1466,7 @@ static int ufs_qcom_mcq_config_resource(struct ufs_hba *hba)
 	/* Explicitly allocate MCQ resource from ufs_mem */
 	res_mcq = devm_kzalloc(hba->dev, sizeof(*res_mcq), GFP_KERNEL);
 	if (!res_mcq)
-		return ret;
+		return -ENOMEM;
 
 	res_mcq->start = res_mem->start +
 			 MCQ_SQATTR_OFFSET(hba->mcq_capabilities);
@@ -1478,7 +1478,7 @@ static int ufs_qcom_mcq_config_resource(struct ufs_hba *hba)
 	if (ret) {
 		dev_err(hba->dev, "Failed to insert MCQ resource, err=%d\n",
 			ret);
-		goto insert_res_err;
+		return ret;
 	}
 
 	res->base = devm_ioremap_resource(hba->dev, res_mcq);
@@ -1495,8 +1495,6 @@ static int ufs_qcom_mcq_config_resource(struct ufs_hba *hba)
 ioremap_err:
 	res->base = NULL;
 	remove_resource(res_mcq);
-insert_res_err:
-	devm_kfree(hba->dev, res_mcq);
 	return ret;
 }
 
-- 
2.7.4

