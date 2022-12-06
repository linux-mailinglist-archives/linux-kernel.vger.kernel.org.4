Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C92643B0E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 03:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233621AbiLFCA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 21:00:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiLFCAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 21:00:25 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8535213E06;
        Mon,  5 Dec 2022 18:00:24 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B61qDeO027449;
        Tue, 6 Dec 2022 02:00:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=ZjCqy0ftJDbg3rlALbusHYYHmUH+soAqAEw5gjrlgLQ=;
 b=bQ8JXmofmXdUIjoLVSVDe93IxEYaK7s83tGp9V9JWLbmP6AqK/FZvTpjcU49LkGguICG
 j9spwB7ThQTmRCZK6VRwG563cGv3rufq7tbz2MMgPAe6538anECli6vF/Hmt5ERj+WGE
 s5giq0LdGVbpPOd7xEX7/VnArTzpEBbVPAKJHB1cr4YGNnMx10OKJX0GCt154tv/rNT7
 1zTqoS5HkIglOWHJw8NAsDcMkZyzfAH45p18yw6c3iZmfa65QxKhjN0zWnlaxNK5Fbb5
 GNW9gTMfgaWCcDslQjDqGEIi1C+B1rtFCfZ5TIK2y8+oYwKYna4J7nolzsC1jLh6W13h rA== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m7wdxwy0j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Dec 2022 02:00:19 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2B620JRA020494
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 6 Dec 2022 02:00:19 GMT
Received: from aiquny2-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 5 Dec 2022 18:00:17 -0800
From:   Maria Yu <quic_aiquny@quicinc.com>
To:     <mathieu.poirier@linaro.org>, <andersson@kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Maria Yu <quic_aiquny@quicinc.com>, <quic_clew@quicinc.com>,
        <quic_mojha@quicinc.com>
Subject: [PATCH v6 1/1] remoteproc: core: do pm_relax when in RPROC_OFFLINE state
Date:   Tue, 6 Dec 2022 09:59:57 +0800
Message-ID: <20221206015957.2616-2-quic_aiquny@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221206015957.2616-1-quic_aiquny@quicinc.com>
References: <20221206015957.2616-1-quic_aiquny@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _A-JQLjfrjqpDngPxYjnDoKQjYTfF0bF
X-Proofpoint-ORIG-GUID: _A-JQLjfrjqpDngPxYjnDoKQjYTfF0bF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-05_01,2022-12-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 clxscore=1015 adultscore=0 mlxscore=0 phishscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212060012
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure that pm_relax() happens even when the remoteproc
is stopped before the crash handler work is scheduled.

Signed-off-by: Maria Yu <quic_aiquny@quicinc.com>
---
 drivers/remoteproc/remoteproc_core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 8768cb64f560..7419e1460f2a 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1862,12 +1862,18 @@ static void rproc_crash_handler_work(struct work_struct *work)
 
 	mutex_lock(&rproc->lock);
 
-	if (rproc->state == RPROC_CRASHED || rproc->state == RPROC_OFFLINE) {
+	if (rproc->state == RPROC_CRASHED) {
 		/* handle only the first crash detected */
 		mutex_unlock(&rproc->lock);
 		return;
 	}
 
+	if (rproc->state == RPROC_OFFLINE) {
+		/* Don't recover if the remote processor was stopped */
+		mutex_unlock(&rproc->lock);
+		goto out;
+	}
+
 	rproc->state = RPROC_CRASHED;
 	dev_err(dev, "handling crash #%u in %s\n", ++rproc->crash_cnt,
 		rproc->name);
@@ -1877,6 +1883,7 @@ static void rproc_crash_handler_work(struct work_struct *work)
 	if (!rproc->recovery_disabled)
 		rproc_trigger_recovery(rproc);
 
+out:
 	pm_relax(rproc->dev.parent);
 }
 
-- 
2.17.1

