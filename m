Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2670474E95D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 10:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjGKIuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 04:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjGKIuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 04:50:04 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22F21702;
        Tue, 11 Jul 2023 01:49:26 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36B6V6aG012944;
        Tue, 11 Jul 2023 08:48:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=Hb+/WvdSZOGcP0ZbVzWAswSwAieAH5nBltcHMk+zViw=;
 b=Qjf+m+UfJWRjrkd5aXIl5Ohk5TgWM0GeCwAxlyrzVCJXZ3chVT0Q9v4RWQncfOnCdaPW
 FlooWCQ18+dnZgP5xIJPG2MKwRmZKwNiD5zPwDW9Som/yKvC61YmYs9IF2chO9Td1YDP
 nqEEATwiZM2RHMxeJE/t2IBJbqG6aZg9zM2duwhNPUScxdujBJT3cKPDc4/72M66PBp+
 mtrR+ss9Ztgt+XEFkYGY5KjxXYcHaq3p4lI/nj2guFBzyiQaopBV7uPyIKjIi+hAs7ta
 Igw0OACc4EDqmDlyQyoUVug+E4VM1jvPMCCam+Igh2Tbpc20X8czUkirUFcdyeIyugTQ GQ== 
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rs0kr8d4u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 08:48:54 +0000
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
        by APTAIPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 36B8mpnd026641;
        Tue, 11 Jul 2023 08:48:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 3rq0vknygn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 11 Jul 2023 08:48:51 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36B8mokV026614;
        Tue, 11 Jul 2023 08:48:50 GMT
Received: from cbsp-sh-gv.qualcomm.com (CBSP-SH-gv.ap.qualcomm.com [10.231.249.68])
        by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 36B8moDS026613;
        Tue, 11 Jul 2023 08:48:50 +0000
Received: by cbsp-sh-gv.qualcomm.com (Postfix, from userid 393357)
        id 613FB4994; Tue, 11 Jul 2023 16:48:49 +0800 (CST)
From:   Ziqi Chen <quic_ziqichen@quicinc.com>
To:     quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        bvanassche@acm.org, mani@kernel.org, stanley.chu@mediatek.com,
        adrian.hunter@intel.com, beanhuo@micron.com, avri.altman@wdc.com,
        junwoo80.lee@samsung.com, martin.petersen@oracle.com,
        quic_ziqichen@quicinc.com, quic_nitirawa@quicinc.com
Cc:     linux-scsi@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1] scsi: ufs: qcom: Hold the mutex lock when config ESI
Date:   Tue, 11 Jul 2023 16:48:46 +0800
Message-Id: <1689065327-45039-1-git-send-email-quic_ziqichen@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: CGWuSHK50VGMgK2l1Ds9cVtPMEh9tt9z
X-Proofpoint-ORIG-GUID: CGWuSHK50VGMgK2l1Ds9cVtPMEh9tt9z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_04,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307110077
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lock the MSI descriptor storage of a device when config ESI.
Otherwise we would meet plenty of warnings during boot up.

Signed-off-by: Ziqi Chen <quic_ziqichen@quicinc.com>
---
 drivers/ufs/host/ufs-qcom.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index f36bcdb..d29e63e 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -1680,6 +1680,7 @@ static int ufs_qcom_config_esi(struct ufs_hba *hba)
 		goto out;
 	}
 
+	msi_lock_descs(hba->dev);
 	msi_for_each_desc(desc, hba->dev, MSI_DESC_ALL) {
 		ret = devm_request_irq(hba->dev, desc->irq,
 				       ufs_qcom_mcq_esi_handler,
@@ -1691,14 +1692,17 @@ static int ufs_qcom_config_esi(struct ufs_hba *hba)
 			break;
 		}
 	}
+	msi_unlock_descs(hba->dev);
 
 	if (ret) {
 		/* Rewind */
+		msi_lock_descs(hba->dev);
 		msi_for_each_desc(desc, hba->dev, MSI_DESC_ALL) {
 			if (desc == failed_desc)
 				break;
 			devm_free_irq(hba->dev, desc->irq, hba);
 		}
+		msi_unlock_descs(hba->dev);
 		platform_msi_domain_free_irqs(hba->dev);
 	} else {
 		if (host->hw_ver.major == 6 && host->hw_ver.minor == 0 &&
-- 
2.7.4

