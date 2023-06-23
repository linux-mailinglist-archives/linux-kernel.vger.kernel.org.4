Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1558873B92F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 15:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbjFWN57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 09:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbjFWN55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 09:57:57 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC038E48;
        Fri, 23 Jun 2023 06:57:56 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35NDsO1A014885;
        Fri, 23 Jun 2023 13:57:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=xUP22ueERUeqwsBoTBGp+gr9uvkxyM222vtHDY4eZrc=;
 b=Iy7vNdb6D4TeqtYSQkHhU9XTgWPtCv/OMS2Mn/evCL6cZZ3U6a5RVVNwIQpLHuGcG1fW
 UfZS+lVk2wgTx+o4r35WKK3bD0l6CUCQBPUimyZnIiKNcX1CwN3K1AB9oHWOI7mNZmTV
 Twn7RtjEKqlMnr07x2QHgzHgTEYRVkfp3y2TlORKcpZQTr1oAZuhAZo1v2tN0a/Qg1MB
 4+Nm4AE5Zywt6r3iLv0ftT3EdhR55QaJeHEIWGDuF5dKszCVeg6wq1DdbgmWlUapcELF
 kGDmvsGfg1c2LbaNUMxDnTw1NrLunp/zz6zaDaeyfRL5pod7qCf8LYVAL89JGB/gKtDb tg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rc2rcnce2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 13:57:52 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35NDvp0K021284
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 13:57:51 GMT
Received: from ekangupt-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 23 Jun 2023 06:57:48 -0700
From:   Ekansh Gupta <quic_ekangupt@quicinc.com>
To:     <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>
CC:     Ekansh Gupta <quic_ekangupt@quicinc.com>,
        <ekangupt@qti.qualcomm.com>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>,
        <fastrpc.upstream@qti.qualcomm.com>, stable <stable@kernel.org>
Subject: [PATCH v2] misc: fastrpc: Pass proper scm arguments for static process init
Date:   Fri, 23 Jun 2023 19:27:44 +0530
Message-ID: <1687528664-25235-1-git-send-email-quic_ekangupt@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: TsaPkDHEMeg7k1Dlyb3kLCMwxCKRrd2M
X-Proofpoint-GUID: TsaPkDHEMeg7k1Dlyb3kLCMwxCKRrd2M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_08,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 impostorscore=0 adultscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306230127
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
Changes in v2:
  - Removed redundant code

 drivers/misc/fastrpc.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 30d4d04..9a7074a 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1278,10 +1278,11 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 
 		/* Map if we have any heap VMIDs associated with this ADSP Static Process. */
 		if (fl->cctx->vmcount) {
+			u64 src_perms = BIT(QCOM_SCM_VMID_HLOS);
+
 			err = qcom_scm_assign_mem(fl->cctx->remote_heap->phys,
 							(u64)fl->cctx->remote_heap->size,
-							&fl->cctx->perms,
-							fl->cctx->vmperms, fl->cctx->vmcount);
+							&src_perms, fl->cctx->vmperms, fl->cctx->vmcount);
 			if (err) {
 				dev_err(fl->sctx->dev, "Failed to assign memory with phys 0x%llx size 0x%llx err %d",
 					fl->cctx->remote_heap->phys, fl->cctx->remote_heap->size, err);
@@ -1322,13 +1323,18 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 	return 0;
 err_invoke:
 	if (fl->cctx->vmcount) {
-		struct qcom_scm_vmperm perm;
+		u64 src_perms = 0;
+		struct qcom_scm_vmperm dst_perms;
+		u32 i;
 
-		perm.vmid = QCOM_SCM_VMID_HLOS;
-		perm.perm = QCOM_SCM_PERM_RWX;
+		for (i = 0; i < fl->cctx->vmcount; i++)
+			src_perms |= BIT(fl->cctx->vmperms[i].vmid);
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

