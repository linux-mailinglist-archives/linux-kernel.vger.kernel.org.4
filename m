Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77CA1719AF7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 13:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbjFAL2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 07:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbjFAL2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 07:28:19 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2092123;
        Thu,  1 Jun 2023 04:28:18 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 351AuEPp003428;
        Thu, 1 Jun 2023 11:27:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=cfMQqCdL/Z44EbSVXa1lxsAa6Ha3jxDNZTaevoUb3Fs=;
 b=CTkU7QF4R9+0M7s+rxOYIc28mHHdRjTjAYQ00TjqVz0RA+zKoTJOOCIHTBgJUlhXApTm
 NqcpvqbZrd1VqMrZ7OfHvBfUtpZgE71bHCODCGjVrcPKpVdbLdeAI2p+2ZCEGrhcNKEP
 9uDyOGlF5pkTuGqhAxkhOIuxohmMWXIhls+ajjBanoZG0z2I3eWGcbE7niNGV34cC7Wf
 +suiPVjql+aOrqd8elwA2C9mFrQT2dvahPgBElfse9bUmHEogPbQze6JZH45WipLtPcg
 nwS5Xn0ZTp+SjQTAg77w1od6SW4zH+2WsSPN5HBeZ/IMd/v/lxEQcIpnK/VwGaZGO5a6 kA== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qxqne8dwg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jun 2023 11:27:49 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 351BRlCk021091
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Jun 2023 11:27:48 GMT
Received: from stor-berry.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 1 Jun 2023 04:27:47 -0700
From:   "Bao D. Nguyen" <quic_nguyenb@quicinc.com>
To:     <quic_asutoshd@quicinc.com>, <quic_cang@quicinc.com>,
        <bvanassche@acm.org>, <mani@kernel.org>,
        <stanley.chu@mediatek.com>, <adrian.hunter@intel.com>,
        <beanhuo@micron.com>, <avri.altman@wdc.com>,
        <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Alice Chao <alice.chao@mediatek.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 1/1] ufs: mcq: Fix the sq_head_slot wrap around logic
Date:   Thu, 1 Jun 2023 04:27:00 -0700
Message-ID: <f711489c6b95ec410e500543fd24ca9fc0f462cd.1685618737.git.quic_nguyenb@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: AaL5nLy1M8LHUbisPLPI8T9Gkaiy9ZSh
X-Proofpoint-GUID: AaL5nLy1M8LHUbisPLPI8T9Gkaiy9ZSh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_08,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2306010101
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the hwq's queue depth is not a multiple of 4s, the
logic used for wrapping around the increase-by-1 sq_head_slot
variable in ufshcd_mcq_sqe_search() will give an incorrect
result because the binary expression of the mask is not
a uniform of all 1s.

Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
---
 drivers/ufs/core/ufs-mcq.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index 66ac02e..8e5bc88 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -585,7 +585,6 @@ static bool ufshcd_mcq_sqe_search(struct ufs_hba *hba,
 {
 	struct ufshcd_lrb *lrbp = &hba->lrb[task_tag];
 	struct utp_transfer_req_desc *utrd;
-	u32 mask = hwq->max_entries - 1;
 	__le64  cmd_desc_base_addr;
 	bool ret = false;
 	u64 addr, match;
@@ -610,7 +609,10 @@ static bool ufshcd_mcq_sqe_search(struct ufs_hba *hba,
 			ret = true;
 			goto out;
 		}
-		sq_head_slot = (sq_head_slot + 1) & mask;
+
+		sq_head_slot++;
+		if (sq_head_slot == hwq->max_entries)
+			sq_head_slot = 0;
 	}
 
 out:
-- 
2.7.4

