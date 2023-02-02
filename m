Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935436883D3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 17:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjBBQLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 11:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232491AbjBBQL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 11:11:29 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477D66B9BA;
        Thu,  2 Feb 2023 08:11:19 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 312EbJKm017301;
        Thu, 2 Feb 2023 16:11:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=kLp6U+99a0FTm58M4V66rH/euSzf63BAL0NqOFS90Ws=;
 b=KAQ/hbVRLPFIkUL2XpRKaduNxZHXAb1idu7t3o6YbnlqP8kviFlKH5c3S38GA4SaRB8b
 /X1Ft64uUG3MCdkvRSzuavXgT9o5vfPYMKhfXVAZX/6E/JVnaepcdiDwzNEgW22tbVNR
 gUDt/ZsM0n/2NJwgHswqQcI5TDF7anFv1LodZ6AoQTpQXwiRrlAqUPRyzlgEDVqKmWsC
 CHNl/9s3rY9LyNtcP2wflSHvL1/nT6qegoMzJippfYuaWlqxp0oQg4kXe+wHslHy8QDo
 iJlNzDNDq5phwb097mFSNp27g5TAFBu37rsfxq810l8Nwf1i0qc/uV3eo3SYFIUSBL35 hw== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nfqt3jy10-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 16:11:06 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 312GB5we031900
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 2 Feb 2023 16:11:05 GMT
Received: from hu-ahari-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 2 Feb 2023 08:11:01 -0800
From:   Anjana Hari <quic_ahari@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <alim.akhtar@samsung.com>, <avri.altman@wdc.com>,
        <bvanassche@acm.org>, <konrad.dybcio@linaro.org>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_narepall@quicinc.com>, <quic_nitirawa@quicinc.com>,
        <quic_rampraka@quicinc.com>, Anjana Hari <quic_ahari@quicinc.com>
Subject: [PATCH v5 0/1] scsi: ufs: Add hibernation callbacks
Date:   Thu, 2 Feb 2023 21:40:44 +0530
Message-ID: <20230202161045.3956-1-quic_ahari@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: SgR9sbVAiNG0W1rPZsZDNXos_aM6WuhD
X-Proofpoint-GUID: SgR9sbVAiNG0W1rPZsZDNXos_aM6WuhD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-02_10,2023-02-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 bulkscore=0 adultscore=0 mlxlogscore=780 impostorscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302020144
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v5:
-Removed extra hba->restore member introduced in previous
patch, moved the concerned code to ufshcd_system_restore.

v4:
-Addressed comments from Bart, removed runtime pm related
code.
-Address kernel bot compilation issues.

v3:
-Address compilation issues

v2:
- Addressed Bart's comments
- Moved core and host related changes to single patch
- Note to Bart: Regrading the comment to pass "restore" as an
argument instead of adding a new member to ufs_hba structure, adding
new function argument in core file (ufshcd.c) is forcing us to make
changes to other vendor files to fix the compilation errors. Hence
we have retained our original change. Please let us know your inputs
on this.

Initial version:
- Adds hibernation callbacks - freeze, restore and thaw,
	required for suspend to disk feature.


Anjana Hari (1):
  scsi: ufs: Add hibernation callbacks

 drivers/ufs/core/ufshcd.c   | 51 +++++++++++++++++++++++++++++++++++++
 drivers/ufs/host/ufs-qcom.c |  8 +++++-
 include/ufs/ufshcd.h        |  4 +++
 3 files changed, 62 insertions(+), 1 deletion(-)

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc., is a member of Code Aurora Forum, a Linux Foundation Collaborative Project

