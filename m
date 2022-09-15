Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F655B9872
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 12:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiIOKEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 06:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiIOKEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 06:04:31 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BF8B68;
        Thu, 15 Sep 2022 03:04:27 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28F5jlvb030887;
        Thu, 15 Sep 2022 10:04:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=Zd5FJR3/2b2i9zCMWP/ALmP4REaiFxNaIZ1vKdn5YWg=;
 b=mN5GbLG/yewRDO2ogBu4SiYt9tpUZlFgDryJc9+668o+WfI8Cmw6RXjqOwMkxfuqS/yg
 Aue/gtyOAmyn3dzdXI72akcTt7HyPyZYJ5LAB3B4bSKke90VrAk28jtX2p4Tdj1H/jsR
 AszQet3+2thsti+GIsNfkFmwjgfZ9L3rtjh0DVxgQriFWaVFru4WJU/4D8juEe4ph+Yd
 1aJQh63Z48+XY+MhEmIPRsukc5cckCfiVrIdf741sFqnNDuYeCooaDYQBukVb+eACzbt
 i8RauCFSfe4h3L2TvrOwHJSpqayaJcjnR3j1ZlnVzHzwPKbyUVZ6kYgv9Wt0mt5eRzMS aw== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jkwjerrqk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Sep 2022 10:04:26 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28FA4QdK003583
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Sep 2022 10:04:26 GMT
Received: from ecbld-sh026-lnx.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 15 Sep 2022 03:04:23 -0700
From:   Maria Yu <quic_aiquny@quicinc.com>
To:     <mathieu.poirier@linaro.org>
CC:     Maria Yu <quic_aiquny@quicinc.com>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_clew@quicinc.com>
Subject: [PATCH v2] remoteproc: core: do pm relax when in RPROC_OFFLINE
Date:   Thu, 15 Sep 2022 18:04:16 +0800
Message-ID: <1663236256-52289-1-git-send-email-quic_aiquny@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <128dc161-8949-1146-bf8b-310aa33c06a8@quicinc.com>
References: <128dc161-8949-1146-bf8b-310aa33c06a8@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: GUcUaCA29oXrTBSkGSr235y_pnjGUpIH
X-Proofpoint-GUID: GUcUaCA29oXrTBSkGSr235y_pnjGUpIH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-15_06,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=945 clxscore=1015 impostorscore=0
 adultscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209150055
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RPROC_OFFLINE state indicate there is no recovery process
is in progress and no chance to do the pm_relax.
Because when recovering from crash, rproc->lock is hold and
state is RPROC_CRASHED -> RPROC_OFFLINE -> RPROC_RUNNING,
and then unlock rproc->lock.
When the state is in RPROC_OFFLINE it means separate request
of rproc_stop was done and no need to hold the wakeup source
in crash handler to recover any more.

Signed-off-by: Maria Yu <quic_aiquny@quicinc.com>
---
 drivers/remoteproc/remoteproc_core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index e5279ed9a8d7..247ced6b0655 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1956,6 +1956,17 @@ static void rproc_crash_handler_work(struct work_struct *work)
 	if (rproc->state == RPROC_CRASHED || rproc->state == RPROC_OFFLINE) {
 		/* handle only the first crash detected */
 		mutex_unlock(&rproc->lock);
+		/*
+		 * RPROC_OFFLINE state indicate there is no recovery process
+		 * is in progress and no chance to have pm_relax in place.
+		 * Because when recovering from crash, rproc->lock is hold and
+		 * state is RPROC_CRASHED -> RPROC_OFFLINE -> RPROC_RUNNING,
+		 * and then unlock rproc->lock.
+		 * RPROC_OFFLINE is only an intermediate state in recovery
+		 * process.
+		 */
+		if (rproc->state == RPROC_OFFLINE)
+			pm_relax(rproc->dev.parent);
 		return;
 	}
 
-- 
2.7.4

