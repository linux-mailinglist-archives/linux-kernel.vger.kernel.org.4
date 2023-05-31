Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE350717DBE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 13:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235426AbjEaLKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 07:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235407AbjEaLKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 07:10:36 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24D012E
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 04:10:34 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34V7el0v001988;
        Wed, 31 May 2023 11:10:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=w0KeEXQFRBlqfa9GOpSBvyxn8umTaMqKZQuHqMXdjpA=;
 b=BYrFiJLHtjk0VQJVQznbTf3qdu1iPJckp2ZIih/aQTDZhMVPYozPTSYAHxhOlecPmkTR
 9ZH52rjZPZCxfqFQ9K3S9vrtVb/CuyBIhXTlhU7LpScdMlFj5cmhFT9+2HtwxJ5xpyt4
 9D2RvYeJjQcmetD8QkqqOmqFeBiYrS7SclkWfxtQwa9Q3XSBHcMNGgAM/9rFyTUCfKgq
 iD8GNsp4h4GhYWsZYxINCaXF40ziPeAdkpYhqAnJwUeTYR7OahDyiaOKSvf0j2/DXNaG
 cPXx83bjZKrFe5txEnDeL10GGwfCOao+zoO0sfIpSMHjB2OMrJ3lYcB+05+rkP6L/wrL MQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qx0sbrkeg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 11:10:21 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34VBAHxM016538
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 11:10:18 GMT
Received: from hu-charante-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 31 May 2023 04:10:15 -0700
From:   Charan Teja Kalla <quic_charante@quicinc.com>
To:     <akpm@linux-foundation.org>, <hannes@cmpxchg.org>,
        <minchan@kernel.org>
CC:     <quic_pkondeti@quicinc.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Charan Teja Kalla <quic_charante@quicinc.com>
Subject: [PATCH] mm: madvise: fix uneven accounting of psi
Date:   Wed, 31 May 2023 16:39:34 +0530
Message-ID: <1685531374-6091-1-git-send-email-quic_charante@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vIMLouYFIPeLAVxXQXv94qn2SwORAR8K
X-Proofpoint-ORIG-GUID: vIMLouYFIPeLAVxXQXv94qn2SwORAR8K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_06,2023-05-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 clxscore=1011 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305310096
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A folio turns into a Workingset during:
1) shrink_active_list() placing the folio from active to inactive list.
2) When a workingset transition is happening during the folio refault.

And when Workingset is set on a folio, PSI for memory can be accounted
during a) That folio is being reclaimed and b) Refault of that folio.

There exists clients who can do the proactive reclaim using the system
calls like madvise(), whose folios can be safely treated as inactive
folios assuming the client knows that these folios are not needed in the
near future thus wanted to reclaim them. For such folios psi is not
accounted uniformly:
a) A folio started at inactive and moved to active as part of accesses.
Workingset is absent on the folio thus madvise(MADV_PAGEOUT) don't
account such folios for PSI.

b) When the same folio transition from inactive->active and then to
inactive through shrink_active_list(). Workingset is set on the folio
thus madvise(MADV_PAGEOUT) account such folios for PSI.

c) When the same folio is part of active list directly as a result of
folio refault and this was a workingset folio prior to eviction.
Workingset is set on the folio thus madvise(MADV_PAGEOUT) account such
folios for PSI.

As said about the MADV_PAGEOUT on a folio is accounted in b) and c) but
not in a) which is inconsistent. Remove this inconsistency by always not
considering the PSI for folios that are getting reclaimed through
madvise(MADV_PAGEOUT) by clearing the Workingset on a folio. This
consistency of clearing the workingset was chosen under the assumption
that client knows these folios are not in active use thus reclaiming
them hence not eligible as workingset folios. Probably it is the same
reason why workingset is not set on a folio through MADV_COLD but during
the shrink_active_list() though both the actions make the folio put onto
the inactive list.

This patch is tested on Android, Snapdragon SoC with 8Gb RAM, 4GB swap
mounted on zram which has 2GB of backingdev. The test case involved
launching some memory hungry apps in an order and do the proactive
reclaim for the app that went to background using madvise(MADV_PAGEOUT).
We are seeing ~40% less total values of psi mem some and full when this
patch is combined with [1].

[1]https://lore.kernel.org/all/20220214214921.419687-1-hannes@cmpxchg.org/T/#u

Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
---
 mm/madvise.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 340125d..3410c39 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -409,8 +409,10 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 			if (folio_isolate_lru(folio)) {
 				if (folio_test_unevictable(folio))
 					folio_putback_lru(folio);
-				else
+				else {
+					folio_clear_workingset(folio);
 					list_add(&folio->lru, &folio_list);
+				}
 			}
 		} else
 			folio_deactivate(folio);
@@ -503,8 +505,10 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 			if (folio_isolate_lru(folio)) {
 				if (folio_test_unevictable(folio))
 					folio_putback_lru(folio);
-				else
+				else {
+					folio_clear_workingset(folio);
 					list_add(&folio->lru, &folio_list);
+				}
 			}
 		} else
 			folio_deactivate(folio);
-- 
2.7.4

