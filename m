Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8156B74A3D7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 20:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbjGFSeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 14:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjGFSeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 14:34:13 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E201BEE
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 11:34:12 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 366ETa63002849;
        Thu, 6 Jul 2023 18:34:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=ojbBXIyB80quZcyQc7gM+InzCsPHAEd1XC8UsJOufNY=;
 b=ibFl8Ce5z2qONYRbw1xdW7Q4Thi2QinlATH7uku0w1qMOaCB6ShPvJ0woRKUjEgatmAc
 NQyFEkfxomWn0fvWJrT6KjNP1oSfnrEp43UFVQ2PHvZh/wvnm2WErLG3853hty5gPL9W
 MD76Ac9TUoTe50L1V33pU7stPdISm2monSi4Nz8fAEn7uDgrXfVCTWV0or2ils/XHTkE
 TVdxVbKKrnv47cdXpI5tYZBXMgHe9qCw0GsQ/lEdcoW1e7caTrkRMPPZzn6Vn214g9hj
 s1zGTSR2NeQqsaJoctaxTPNcmRbb3oszZZOa9qQGzmjfyd0fPqUFjIoJRAj630f8bZzy 6Q== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rn5ht3y9r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jul 2023 18:34:07 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 366IY5hT026669
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Jul 2023 18:34:06 GMT
Received: from blr-ubuntu-498.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 6 Jul 2023 11:34:03 -0700
From:   Pintu Kumar <quic_pintu@quicinc.com>
To:     <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>
CC:     <quic_pintu@quicinc.com>, <pintu.ping@gmail.com>
Subject: [PATCH v2] mm: cma: print cma name as well in cma_alloc debug
Date:   Fri, 7 Jul 2023 00:03:34 +0530
Message-ID: <1688668414-12350-1-git-send-email-quic_pintu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1688668070-8408-1-git-send-email-quic_pintu@quicinc.com>
References: <1688668070-8408-1-git-send-email-quic_pintu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Vu31gbRtfVCEy2GJhRtQrn_nCbI8yiXZ
X-Proofpoint-GUID: Vu31gbRtfVCEy2GJhRtQrn_nCbI8yiXZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_13,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 clxscore=1015 malwarescore=0 suspectscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=735 lowpriorityscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307060165
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index a4cfe99..4880f72 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -436,8 +436,8 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
 	if (!cma || !cma->count || !cma->bitmap)
 		goto out;
 
-	pr_debug("%s(cma %p, count %lu, align %d)\n", __func__, (void *)cma,
-		 count, align);
+	pr_debug("%s(cma %p, name: %s, count %lu, align %d)\n", __func__,
+		(void *)cma, cma->name, count, align);
 
 	if (!count)
 		goto out;
-- 
2.7.4

