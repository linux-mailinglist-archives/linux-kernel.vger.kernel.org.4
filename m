Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081C174A3BF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 20:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjGFS2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 14:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjGFS2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 14:28:15 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839A71BC3
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 11:28:14 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 366ID4LW022096;
        Thu, 6 Jul 2023 18:28:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=uC9lIJHCOOldEmNMSWaPvJCJ3FW/F8uLoL3pWDa3K8M=;
 b=DwCbp/EblslmW0qKBUSibsK6WT/VPUTfZJ03FJMF0E4x20c4mlaC9ShDkW+TDFi3Egmx
 yj/YRfpK7IoqOn/Z7Xx8t/Pgn3MFzs8UbOCveBbO9tXezCv7qnqb9juTYMQaFztXUTjx
 uKvqa89UFpnJMLFngpt/mG7Jfi7ImGkBRZsdBrid8EL53yvu+nWp6y0rFDOBJhcxNn+K
 dhGmIw5hvdYHgZtk/DSoJ6AWUpOJsjK8wUIkstL1uaOh+fxO3nvwxauBpcNwQV6alFao
 3CNb0tKkyvf4x0hJG0af3uOC0hncHHP6TzxILSbBxeW5E0OaK44w8LJcIKPG3UoFne8D iA== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rnx4x0qtn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jul 2023 18:28:08 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 366IS7Zm018031
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Jul 2023 18:28:07 GMT
Received: from blr-ubuntu-498.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 6 Jul 2023 11:28:05 -0700
From:   Pintu Kumar <quic_pintu@quicinc.com>
To:     <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>
CC:     <quic_pintu@quicinc.com>, <pintu.ping@gmail.com>
Subject: [PATCH] mm: cma: print cma name as well in cma_alloc debug
Date:   Thu, 6 Jul 2023 23:57:50 +0530
Message-ID: <1688668070-8408-1-git-send-email-quic_pintu@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: V6Hzbj6Z9y9Fx6pzsJ_TC9_gHDnHu2OJ
X-Proofpoint-GUID: V6Hzbj6Z9y9Fx6pzsJ_TC9_gHDnHu2OJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_13,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 clxscore=1011 spamscore=0 mlxlogscore=713 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307060165
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CMA allocation can happen either from global cma or from
dedicated cma region.

Thus it is helpful to print cma name as well during initial
debugging to confirm cma regions were getting initialized or not.

Signed-off-by: Pintu Kumar <quic_pintu@quicinc.com>
Signed-off-by: Pintu Agarwal <pintu.ping@gmail.com>
---
 mm/cma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/cma.c b/mm/cma.c
index a4cfe99..96718b53 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -436,8 +436,8 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
 	if (!cma || !cma->count || !cma->bitmap)
 		goto out;
 
-	pr_debug("%s(cma %p, count %lu, align %d)\n", __func__, (void *)cma,
-		 count, align);
+	pr_info("%s(cma %p, name: %s, count %lu, align %d)\n", __func__,
+		(void *)cma, cma->name, count, align);
 
 	if (!count)
 		goto out;
-- 
2.7.4

