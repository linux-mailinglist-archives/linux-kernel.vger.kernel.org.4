Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD2272DD99
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 11:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233274AbjFMJ0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 05:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239486AbjFMJZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 05:25:56 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C7E1A7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 02:25:55 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35D9C7K2012602;
        Tue, 13 Jun 2023 09:25:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=vYdncpcPO4FvW58HwL7LEjG2V6prrN7zDBN9KsJoPnE=;
 b=pcPXlQy/G2Hjp1Rtt7r3ZTiwnllnxGtnWqksKeJb5fFKJVbbnPWAymhnMQ8OcRDzXKT5
 WRmvREoRaUMB0x+nu3kle6RKdrqutFF708pc51RzFTpZnSVmsy6liI8SElLb4d/IfF4m
 v0SNHOgyf46Bgg84IRrtDO7pU6Ee2/5AdUtR68gXT1x1DG7zFLK4LIXPfQahA9SpekkH
 4sKoKBC+U/DBk9W+fIGwTHuHSMxrD0eNu3ceoH5gxuJou98JuLEh27L4chxLubtZeBia
 dha57FV8HNmymtOFh6IEBpdv9nSyH2dUngoxdkkm3FUjKmFo1+tbMEq7tvkBKHjzyCJ/ Bg== 
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r6ng4r18h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 09:25:41 +0000
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
        by APTAIPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 35D9PcUU019591;
        Tue, 13 Jun 2023 09:25:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APTAIPPMTA01.qualcomm.com (PPS) with ESMTP id 3r4j8kpmt4-1;
        Tue, 13 Jun 2023 09:25:38 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35D9OFSW018425;
        Tue, 13 Jun 2023 09:25:38 GMT
Received: from maow2-gv.ap.qualcomm.com (maow2-gv.qualcomm.com [10.232.193.133])
        by APTAIPPMTA01.qualcomm.com (PPS) with ESMTP id 35D9PbvZ019584;
        Tue, 13 Jun 2023 09:25:38 +0000
Received: by maow2-gv.ap.qualcomm.com (Postfix, from userid 399080)
        id 8973C21000DC; Tue, 13 Jun 2023 17:25:36 +0800 (CST)
From:   Kassey Li <quic_yingangl@quicinc.com>
To:     akpm@linux-foundation.org, vbabka@kernel.org
Cc:     Kassey Li <quic_yingangl@quicinc.com>, minchan@kernel.org,
        vbabka@suse.cz, iamjoonsoo.kim@lge.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH] mm/page_owner/cma: show pfn in cma/page_onwer with hex format
Date:   Tue, 13 Jun 2023 17:25:33 +0800
Message-Id: <20230613092533.15449-1-quic_yingangl@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: XsIjA2ZbUrhSb4_T029yCpUqvpTJePgp
X-Proofpoint-ORIG-GUID: XsIjA2ZbUrhSb4_T029yCpUqvpTJePgp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_04,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 mlxlogscore=767 phishscore=0 spamscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0 priorityscore=1501
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306130082
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pfn is more easy to read in CMA log, against with page_onwer
show in the same hex format.

Signed-off-by: Kassey Li <quic_yingangl@quicinc.com>
---
 mm/cma.c        | 4 ++--
 mm/page_owner.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/cma.c b/mm/cma.c
index 6268d6620254..a4cfe995e11e 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -483,8 +483,8 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
 		if (ret != -EBUSY)
 			break;
 
-		pr_debug("%s(): memory range at %p is busy, retrying\n",
-			 __func__, pfn_to_page(pfn));
+		pr_debug("%s(): memory range at pfn 0x%lx %p is busy, retrying\n",
+			 __func__, pfn, pfn_to_page(pfn));
 
 		trace_cma_alloc_busy_retry(cma->name, pfn, pfn_to_page(pfn),
 					   count, align);
diff --git a/mm/page_owner.c b/mm/page_owner.c
index 31169b3e7f06..c93baef0148f 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -418,7 +418,7 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
 	pageblock_mt = get_pageblock_migratetype(page);
 	page_mt  = gfp_migratetype(page_owner->gfp_mask);
 	ret += scnprintf(kbuf + ret, count - ret,
-			"PFN %lu type %s Block %lu type %s Flags %pGp\n",
+			"PFN 0x%lx type %s Block %lu type %s Flags %pGp\n",
 			pfn,
 			migratetype_names[page_mt],
 			pfn >> pageblock_order,
-- 
2.17.1

