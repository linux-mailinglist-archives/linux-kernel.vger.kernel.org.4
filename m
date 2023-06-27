Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5699973FA45
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 12:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjF0Kdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 06:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjF0Kds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 06:33:48 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6A5C9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 03:33:46 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35R6DeUa022382;
        Tue, 27 Jun 2023 10:33:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=KNfM7LtSPiwBmqZlNfK7ibDUjnF4FMfkSTe1KSMBQEA=;
 b=NIHdoA++jQ2lUqsWmW4PYcagoLjDwqAsSH2dgCsSHUftWqz78VP0uBRMsU5qRLYitFzU
 uMecvmP7hJzTmvbMEeBh/1+LmjnmY80HCkfm7+TmAMhXFZS1r8QIXAp/kYvhJECxnfrQ
 zAvU6CMu2LmTxEFs/RRwLrj2JvAxgE+IA1pcmdhwvJOEmQZOS+wEudfvhJHPOAmgISg6
 f4KGTpiuKc1Kbv+p4nmEtZggjh61aAMtIId3epGvn3DOWpgZPEvWkKXTbmrQSvHF705T
 yJgGMjRI10q8cZySuPXvKX+CLDziCBvAefV8TvmRnnfOh2fw4vGRL3bJyy7HP4Lu3Luy 9Q== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rfartacnv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jun 2023 10:33:35 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35RAXZkQ026200
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jun 2023 10:33:35 GMT
Received: from hu-charante-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 27 Jun 2023 03:33:32 -0700
From:   Charan Teja Kalla <quic_charante@quicinc.com>
To:     <akpm@linux-foundation.org>, <surenb@google.com>,
        <hannes@cmpxchg.org>, <minchan@kernel.org>
CC:     <quic_pkondeti@quicinc.com>, <quic_smanapra@quicinc.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Charan Teja Kalla <quic_charante@quicinc.com>
Subject: [PATCH V2] mm: madvise: fix uneven accounting of psi
Date:   Tue, 27 Jun 2023 16:03:12 +0530
Message-ID: <1687861992-8722-1-git-send-email-quic_charante@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UM7BJlhXhIMhYVR-PACN7WE7fg6XDZyc
X-Proofpoint-ORIG-GUID: UM7BJlhXhIMhYVR-PACN7WE7fg6XDZyc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-27_06,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1011
 bulkscore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306270096
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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

This accounting of PSI for memory is not consistent in the cases where
clients use madvise(COLD/PAGEOUT) to deactivate or proactively reclaim a
folio:
a) A folio started at inactive and moved to active as part of accesses.
Workingset is absent on the folio thus madvise(MADV_PAGEOUT) don't
account such folios for PSI.

b) When the same folio transition from inactive->active and then to
inactive through shrink_active_list(). Workingset is set on the folio
thus madvise(MADV_PAGEOUT) account such folios for PSI.

c) When the same folio is part of active list directly as a result of
folio refault and this was a workingset folio prior to eviction.
Workingset is set on the folio thus both the operations of MADV_PAGEOUT
and reclaim of the MADV_COLD operated folio account for PSI.

d) madvise(MADV_COLD) transfers the folio from active list to inactive
list. Such folios may not have the Workingset thus reclaim operation
on such folio doesn't account for PSI.

As said above, the MADV_PAGEOUT on a folio is accounts for memory PSI in
b) and c) but not in a). Reclaim of a folio on which MADV_COLD is
performed accounts memory PSI in c) but not in d) which is an
inconsistent behaviour. Make this PSI accounting always consistent by
turning a folio into a workingset one whenever it is leaving the active
list. Also, accounting of PSI on a folio whenever it leaves the
active list as part of the MADV_COLD/PAGEOUT operation helps the users
whether they are operating on proper folios[1].

[1] https://lore.kernel.org/all/20230605180013.GD221380@cmpxchg.org/

Suggested-by: Suren Baghdasaryan <surenb@google.com>
Reported-by: Sai Manobhiram Manapragada <quic_smanapra@quicinc.com>
Reported-by: Pavan Kondeti <quic_pkondeti@quicinc.com>
Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
---
V2: Made changes as per the comments from Johannes/Suren.

V1: https://lore.kernel.org/all/1685531374-6091-1-git-send-email-quic_charante@quicinc.com/

 mm/madvise.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/madvise.c b/mm/madvise.c
index d9e7b42..76fb31f 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -413,6 +413,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 
 		folio_clear_referenced(folio);
 		folio_test_clear_young(folio);
+		folio_set_workingset(folio);
 		if (pageout) {
 			if (folio_isolate_lru(folio)) {
 				if (folio_test_unevictable(folio))
@@ -512,6 +513,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		 */
 		folio_clear_referenced(folio);
 		folio_test_clear_young(folio);
+		folio_set_workingset(folio);
 		if (pageout) {
 			if (folio_isolate_lru(folio)) {
 				if (folio_test_unevictable(folio))
-- 
2.7.4

