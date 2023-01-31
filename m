Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8913C68256A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 08:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjAaHNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 02:13:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjAaHNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 02:13:12 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D8235248
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 23:13:10 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30V5kRiA001382;
        Tue, 31 Jan 2023 07:10:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : mime-version : content-type; s=qcppdkim1;
 bh=F4RRYkiYOtFZBpcMTlSVNOJPPWM6D1p845UbKpbXCSI=;
 b=jeD1DwNEJSroRBVtx/XSrllJOE4AUMlEvzn6l+nLNXV8mWDvyn8fcaCwEdX9W4gPMYtM
 fYptlFXPm5sDRGzJiONSZsMZmCxZY1n99IMN8omPTXAdWge5GGNLrg1xdAj0Gola06DZ
 2QoVSB94TQzNR+wsFIcFyJ7trg07IUPjvCoVcFtz5CjKyOHxSgWLE8CGCLfzZ0Q5H9ZH
 sAWufmpO2nxadETf27H8rGSMu4ATbv7vgEuigNC2SuAg6rVXB2BCn0FMvGUqRpQ7nqcu
 tAJCD7bTq64bT0iXdqESGeSfnJUu4zr1wvKxtGiFzB8GH2Y2fkD0rfx8hX3BJvkQAQc9 YA== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ncuxanq5h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 07:10:55 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30V7Aswg004493
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 07:10:54 GMT
Received: from hu-sbhattip-lv.qualcomm.com (10.49.16.6) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 30 Jan 2023 23:10:53 -0800
Date:   Mon, 30 Jan 2023 23:10:52 -0800
From:   Sukadev Bhattiprolu <quic_sukadev@quicinc.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Rik van Riel <riel@surriel.com>, Roman Gushchin <guro@fb.com>,
        "Vlastimil Babka" <vbabka@suse.cz>, Joonsoo Kim <js1304@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Chris Goldsworthy <quic_cgoldswo@quicinc.com>,
        "Georgi Djakov" <quic_c_gdjako@quicinc.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] mm,page_alloc,cma: configurable CMA utilization
Message-ID: <20230131071052.GB19285@hu-sbhattip-lv.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: z5gfestaWUOue40cCcdJwI_QTyCmf296
X-Proofpoint-GUID: z5gfestaWUOue40cCcdJwI_QTyCmf296
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_02,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 malwarescore=0 bulkscore=0 clxscore=1011 priorityscore=1501 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301310065
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Commit 16867664936e ("mm,page_alloc,cma: conditionally prefer cma pageblocks for movable allocations")
added support to use CMA pages when more than 50% of total free pages in
the zone are free CMA pages.

However, with multiplatform kernels a single binary is used across different
targets of varying memory sizes. A low memory target using one such kernel
would incur allocation failures even when sufficient memory is available in
the CMA region. On these targets we would want to utilize a higher percentage
of the CMA region and reduce the allocation failures, even if it means that a
subsequent cma_alloc() would take longer.

Make the percentage of CMA utilization a configurable parameter to allow
for such usecases.

Signed-off-by: Sukadev Bhattiprolu <quic_sukadev@quicinc.com>
---
Note:	There was a mention about it being the last resort to making this
	percentage configurable (https://lkml.org/lkml/2020/3/12/751). But
	as explained above, multi-platform kernels for varying memory size
	targets would need this to be configurable.
---
 include/linux/mm.h |  1 +
 kernel/sysctl.c    |  8 ++++++++
 mm/page_alloc.c    | 18 +++++++++++++++---
 mm/util.c          |  2 ++
 4 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8f857163ac89..e4e5d508e9eb 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -203,6 +203,7 @@ extern unsigned long sysctl_admin_reserve_kbytes;
 
 extern int sysctl_overcommit_memory;
 extern int sysctl_overcommit_ratio;
+extern int sysctl_cma_utilization_ratio;
 extern unsigned long sysctl_overcommit_kbytes;
 
 int overcommit_ratio_handler(struct ctl_table *, int, void *, size_t *,
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 137d4abe3eda..2dce6a908aa6 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2445,6 +2445,14 @@ static struct ctl_table vm_table[] = {
 		.extra2		= SYSCTL_ONE,
 	},
 #endif
+	{
+		.procname	= "cma_utilization_ratio",
+		.data		= &sysctl_cma_utilization_ratio,
+		.maxlen		= sizeof(sysctl_cma_utilization_ratio),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ONE,
+	},
 	{ }
 };
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0745aedebb37..b72db3824687 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3071,6 +3071,20 @@ __rmqueue_fallback(struct zone *zone, int order, int start_migratetype,
 
 }
 
+static __always_inline bool zone_can_use_cma_pages(struct zone *zone)
+{
+	unsigned long cma_free_pages;
+	unsigned long zone_free_pages;
+
+	cma_free_pages = zone_page_state(zone, NR_FREE_CMA_PAGES);
+	zone_free_pages = zone_page_state(zone, NR_FREE_PAGES);
+
+	if (cma_free_pages > zone_free_pages / sysctl_cma_utilization_ratio)
+		return true;
+
+	return false;
+}
+
 /*
  * Do the hard work of removing an element from the buddy allocator.
  * Call me with the zone->lock already held.
@@ -3087,9 +3101,7 @@ __rmqueue(struct zone *zone, unsigned int order, int migratetype,
 		 * allocating from CMA when over half of the zone's free memory
 		 * is in the CMA area.
 		 */
-		if (alloc_flags & ALLOC_CMA &&
-		    zone_page_state(zone, NR_FREE_CMA_PAGES) >
-		    zone_page_state(zone, NR_FREE_PAGES) / 2) {
+		if (alloc_flags & ALLOC_CMA && zone_can_use_cma_pages(zone)) {
 			page = __rmqueue_cma_fallback(zone, order);
 			if (page)
 				return page;
diff --git a/mm/util.c b/mm/util.c
index b56c92fb910f..4de81f04b249 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -781,6 +781,8 @@ void folio_copy(struct folio *dst, struct folio *src)
 }
 
 int sysctl_overcommit_memory __read_mostly = OVERCOMMIT_GUESS;
+
+int sysctl_cma_utilization_ratio __read_mostly = 2;
 int sysctl_overcommit_ratio __read_mostly = 50;
 unsigned long sysctl_overcommit_kbytes __read_mostly;
 int sysctl_max_map_count __read_mostly = DEFAULT_MAX_MAP_COUNT;
-- 
2.17.1

