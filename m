Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9B5722882
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 16:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234172AbjFEONn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 10:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233825AbjFEONZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 10:13:25 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25AC81985;
        Mon,  5 Jun 2023 07:12:36 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 355DQNb1010118;
        Mon, 5 Jun 2023 14:11:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=J6spjeZSHivNH3RNmesMtSKJnvJqRAmSwJdeKD0qAjs=;
 b=PzNaT1cv091teOjH/TOAOdnVwxTN+HqoZGqgfkHl3ztdWaDpZNq/mq1NIZiyxR1VPOEK
 7PEXGmQfg+f3mFR8gmk2xfgU8Pl+oCdyzgNgRD/8JJ+96R3zz3n6QKhfvyjl1mMWRnR4
 Xzl+fipzl0D+6jEt2NQ59LqeRGvWbZMf+IywDraaHIsyjaxidc4lTooTDs2RmQzVkuvU
 HngTz/b4/8x9DyhEbQQff013/ToXe8PjiJeFPRh01vYFOB7K4N8UWPPkgT++79tYYraR
 +cOcmssb99DeH7GIu5chFoTiRWbEVJp9ClwYPNqQuZKbNFu/0es9kPlL3lbsLlZAI2S1 Fg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qyx9p3qxp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Jun 2023 14:11:25 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 355EBO20011354
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 5 Jun 2023 14:11:24 GMT
Received: from ekangupt-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 5 Jun 2023 07:11:21 -0700
From:   Ekansh Gupta <quic_ekangupt@quicinc.com>
To:     <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>
CC:     Ekansh Gupta <quic_ekangupt@quicinc.com>,
        <ekangupt@qti.qualcomm.com>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <bkumar@qti.qualcomm.com>,
        <fastrpc.upstream@qti.qualcomm.com>, stable <stable@kernel.org>
Subject: [PATCH v1] misc: fastrpc: Fix remote heap allocation request
Date:   Mon, 5 Jun 2023 19:41:16 +0530
Message-ID: <1685974276-23435-1-git-send-email-quic_ekangupt@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2pQAyMiJqJNcepXDyO2d-h4qiX3A9b99
X-Proofpoint-GUID: 2pQAyMiJqJNcepXDyO2d-h4qiX3A9b99
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-05_28,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 clxscore=1015 mlxscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2306050123
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remote heap is used by DSP audioPD on need basis. This memory is
allocated from reserved CMA memory region and is then shared with
audioPD to use it for it's functionality.

Current implementation of remote heap is not allocating the memory
from CMA region, instead it is allocating the memory from SMMU
context bank. The arguments passed to scm call for the reassignment
of ownership is also not correct. Added changes to allocate CMA
memory and have a proper ownership reassignment.

Fixes: 532ad70c6d44 ("misc: fastrpc: Add mmap request assigning for static PD pool")
Cc: stable <stable@kernel.org>
Tested-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
---
 drivers/misc/fastrpc.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 30d4d04..f5fc2de 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1866,7 +1866,11 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 		return -EINVAL;
 	}
 
-	err = fastrpc_buf_alloc(fl, fl->sctx->dev, req.size, &buf);
+	if (req.flags == ADSP_MMAP_REMOTE_HEAP_ADDR)
+		err = fastrpc_remote_heap_alloc(fl, dev, req.size, &buf);
+	else
+		err = fastrpc_buf_alloc(fl, dev, req.size, &buf);
+
 	if (err) {
 		dev_err(dev, "failed to allocate buffer\n");
 		return err;
@@ -1905,12 +1909,22 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 
 	/* Add memory to static PD pool, protection thru hypervisor */
 	if (req.flags == ADSP_MMAP_REMOTE_HEAP_ADDR && fl->cctx->vmcount) {
-		struct qcom_scm_vmperm perm;
+		u64 src_perms = BIT(QCOM_SCM_VMID_HLOS);
+		struct qcom_scm_vmperm *dst_perms;
+		u32 i;
 
-		perm.vmid = QCOM_SCM_VMID_HLOS;
-		perm.perm = QCOM_SCM_PERM_RWX;
-		err = qcom_scm_assign_mem(buf->phys, buf->size,
-			&fl->cctx->perms, &perm, 1);
+		dst_perms = kcalloc(fl->cctx->vmcount,
+			sizeof(struct qcom_scm_vmperm), GFP_KERNEL);
+		if (!dst_perms)
+			return -ENOMEM;
+		for (i = 0; i < fl->cctx->vmcount; i++) {
+			dst_perms[i].vmid = fl->cctx->vmperms[i].vmid;
+			dst_perms[i].perm = fl->cctx->vmperms[i].perm;
+		}
+
+		err = qcom_scm_assign_mem(buf->phys,(u64)buf->size,
+			&src_perms, dst_perms, fl->cctx->vmcount);
+		kfree(dst_perms);
 		if (err) {
 			dev_err(fl->sctx->dev, "Failed to assign memory phys 0x%llx size 0x%llx err %d",
 					buf->phys, buf->size, err);
-- 
2.7.4

