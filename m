Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCCB9737B59
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 08:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjFUG3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 02:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjFUG26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 02:28:58 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC7B1BF6;
        Tue, 20 Jun 2023 23:28:31 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35L4tULC005728;
        Wed, 21 Jun 2023 06:28:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=KRueZjDVXXVePjkpXei4lkDqfz5xHDID1SW6e9AveoI=;
 b=YNjQEqCwa6K8rOnbTI9c4FtvSwxKhq9MSc2+vAXrXRIpANzbEmYbsLOFr65+gi5mDZ6K
 Gh4ihFs9zS9VzXd88o9P6M7DqmiWXzx/H2kz9LgDu8xQd/7KDLTphpxHpg4Pz46f2SQt
 KF7Z/yNwLcaC3gxCb11Hy3Ms9NRnqjTWqezqaAUbxE4VspmNyQRS4zbMqwTGtsp9unxy
 zEUVaIEOkNGz6T5cgLdH2uKyNY3C36QFtQwOll4g5jtj2AoDlZ3XZkUkfgMvxSubxzrv
 DPm7z2szCCrA4Ukt5AS/lxUXoPpjisiYowz2wYc/yqSmZcVmdcF3q/esJ4VutwN74dSc CA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rbqu2ge41-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 06:28:27 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35L6SRSg021086
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 06:28:27 GMT
Received: from ekangupt-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 20 Jun 2023 23:28:24 -0700
From:   Ekansh Gupta <quic_ekangupt@quicinc.com>
To:     <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>
CC:     Ekansh Gupta <quic_ekangupt@quicinc.com>,
        <ekangupt@qti.qualcomm.com>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>,
        <fastrpc.upstream@qti.qualcomm.com>, stable <stable@kernel.org>
Subject: [PATCH v1] misc: fastrpc: Fix DSP capabilities request
Date:   Wed, 21 Jun 2023 11:58:20 +0530
Message-ID: <1687328900-3039-1-git-send-email-quic_ekangupt@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: pKTgKlN2rfBEpKEYf19_3iwXhFchIYv9
X-Proofpoint-GUID: pKTgKlN2rfBEpKEYf19_3iwXhFchIYv9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_04,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306210053
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Incorrect remote arguments are getting passed when requesting for
capabilities from DSP. Also there is no requirement to update the
PD type as it might cause problems for any PD other than user PD.
In addition to this, the collected capability information is not
getting copied properly to user. Add changes to address these
problems and get correct DSP capabilities.

Fixes: 6c16fd8bdd40 ("misc: fastrpc: Add support to get DSP capabilities")
Cc: stable <stable@kernel.org>
Tested-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
---
 drivers/misc/fastrpc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 30d4d04..776c596 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1693,9 +1693,8 @@ static int fastrpc_get_info_from_dsp(struct fastrpc_user *fl, uint32_t *dsp_attr
 	args[0].length = sizeof(dsp_attr_buf_len);
 	args[0].fd = -1;
 	args[1].ptr = (u64)(uintptr_t)&dsp_attr_buf[1];
-	args[1].length = dsp_attr_buf_len;
+	args[1].length = dsp_attr_buf_len * sizeof(uint32_t);
 	args[1].fd = -1;
-	fl->pd = USER_PD;
 
 	return fastrpc_internal_invoke(fl, true, FASTRPC_DSP_UTILITIES_HANDLE,
 				       FASTRPC_SCALARS(0, 1, 1), args);
@@ -1723,7 +1722,7 @@ static int fastrpc_get_info_from_kernel(struct fastrpc_ioctl_capability *cap,
 	if (!dsp_attributes)
 		return -ENOMEM;
 
-	err = fastrpc_get_info_from_dsp(fl, dsp_attributes, FASTRPC_MAX_DSP_ATTRIBUTES_LEN);
+	err = fastrpc_get_info_from_dsp(fl, dsp_attributes, FASTRPC_MAX_DSP_ATTRIBUTES);
 	if (err == DSP_UNSUPPORTED_API) {
 		dev_info(&cctx->rpdev->dev,
 			 "Warning: DSP capabilities not supported on domain: %d\n", domain);
@@ -1776,7 +1775,7 @@ static int fastrpc_get_dsp_info(struct fastrpc_user *fl, char __user *argp)
 	if (err)
 		return err;
 
-	if (copy_to_user(argp, &cap.capability, sizeof(cap.capability)))
+	if (copy_to_user(argp, &cap, sizeof(cap)))
 		return -EFAULT;
 
 	return 0;
-- 
2.7.4

