Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6DB07227D4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 15:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbjFENs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 09:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbjFENsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 09:48:55 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC799C;
        Mon,  5 Jun 2023 06:48:54 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 355CPW1K030950;
        Mon, 5 Jun 2023 13:48:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=9z0PA9AKMhKUQkcp6ir2m1Wg6FOKEV1od3lPMM0PPU4=;
 b=Bq7xd2ufY9cppAx86CotK85mvdpegQo3DJdVdsRerO9HLyHQoDLL6p70ufGrk/PXNt7P
 h+0m7ztKMkrI+xESO+c7ak3NJC3TElBNhxJFnbqoDb9b5EspX7JYWiM9l3rLxAWK/mOq
 jJwLdDiV4luLgXwqHO1wXVeb/4yDw24l6mdMtcIXtMIi0FHDmZBWG4JTmCzT1yRqMxRP
 QK63XyN5vRqTFTRZRU4Mew3ijsSVkAi5PDZLQWCgI8b3eRXJjHoLBoNNEH9LTOaaiOpi
 ua6SY4AMXY8xdBK8sZ3s5BMNFH1merQETyZ2/X40HlsQZFMzX4RwbU9AHwZaY7uzIRXv WA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r1ahp903h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Jun 2023 13:48:50 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 355DmnJM024996
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 5 Jun 2023 13:48:49 GMT
Received: from ekangupt-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 5 Jun 2023 06:48:46 -0700
From:   Ekansh Gupta <quic_ekangupt@quicinc.com>
To:     <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>
CC:     Ekansh Gupta <quic_ekangupt@quicinc.com>,
        <ekangupt@qti.qualcomm.com>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <bkumar@qti.qualcomm.com>,
        <fastrpc.upstream@qti.qualcomm.com>, stable <stable@kernel.org>
Subject: [PATCH v1] misc: fastrpc: Pass proper scm arguments for static process init
Date:   Mon, 5 Jun 2023 19:18:38 +0530
Message-ID: <1685972918-30371-1-git-send-email-quic_ekangupt@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: P19P0KUy9CZKD-Vk_8zPLktbAn2t2ACn
X-Proofpoint-ORIG-GUID: P19P0KUy9CZKD-Vk_8zPLktbAn2t2ACn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-05_28,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1011 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306050120
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory is allocated for dynamic loading when audio daemon is trying
to attach to audioPD on DSP side. This memory is allocated from
reserved CMA memory region and needs ownership assignment to
new VMID in order to use it from audioPD.

In the current implementation, arguments are not correctly passed
to the scm call which might result in failure of dynamic loading
on audioPD. Added changes to pass correct arguments during daemon
attach request.

Fixes: 	0871561055e6 ("misc: fastrpc: Add support for audiopd")
Cc: stable <stable@kernel.org>
Tested-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
---
 drivers/misc/fastrpc.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 30d4d04..b7335dd 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1278,10 +1278,23 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 
 		/* Map if we have any heap VMIDs associated with this ADSP Static Process. */
 		if (fl->cctx->vmcount) {
+			u64 src_perms = BIT(QCOM_SCM_VMID_HLOS);
+			struct qcom_scm_vmperm *dst_perms;
+			u32 i;
+
+			dst_perms = kcalloc(fl->cctx->vmcount,
+							sizeof(struct qcom_scm_vmperm), GFP_KERNEL);
+			if (!dst_perms)
+				return -ENOMEM;
+			for (i = 0; i < fl->cctx->vmcount; i++) {
+				dst_perms[i].vmid = fl->cctx->vmperms[i].vmid;
+				dst_perms[i].perm = fl->cctx->vmperms[i].perm;
+			}
+
 			err = qcom_scm_assign_mem(fl->cctx->remote_heap->phys,
 							(u64)fl->cctx->remote_heap->size,
-							&fl->cctx->perms,
-							fl->cctx->vmperms, fl->cctx->vmcount);
+							&src_perms, dst_perms, fl->cctx->vmcount);
+			kfree(dst_perms);
 			if (err) {
 				dev_err(fl->sctx->dev, "Failed to assign memory with phys 0x%llx size 0x%llx err %d",
 					fl->cctx->remote_heap->phys, fl->cctx->remote_heap->size, err);
@@ -1322,13 +1335,19 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 	return 0;
 err_invoke:
 	if (fl->cctx->vmcount) {
-		struct qcom_scm_vmperm perm;
+		u64 src_perms = 0;
+		struct qcom_scm_vmperm dst_perms;
+		u32 i;
 
-		perm.vmid = QCOM_SCM_VMID_HLOS;
-		perm.perm = QCOM_SCM_PERM_RWX;
+		for (i = 0; i < fl->cctx->vmcount; i++) {
+			src_perms |= BIT(fl->cctx->vmperms[i].vmid);
+		}
+
+		dst_perms.vmid = QCOM_SCM_VMID_HLOS;
+		dst_perms.perm = QCOM_SCM_PERM_RWX;
 		err = qcom_scm_assign_mem(fl->cctx->remote_heap->phys,
 						(u64)fl->cctx->remote_heap->size,
-						&fl->cctx->perms, &perm, 1);
+						&src_perms, &dst_perms, 1);
 		if (err)
 			dev_err(fl->sctx->dev, "Failed to assign memory phys 0x%llx size 0x%llx err %d",
 				fl->cctx->remote_heap->phys, fl->cctx->remote_heap->size, err);
-- 
2.7.4

