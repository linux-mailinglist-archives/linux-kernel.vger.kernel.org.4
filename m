Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62F26226E5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 10:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbiKIJ2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 04:28:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiKIJ2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 04:28:13 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E541BEB4
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 01:28:11 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A981qS5005483;
        Wed, 9 Nov 2022 09:26:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=IGlfqAanlK48mImb41Tw+3F6UP5C64sbnIN3RocolP8=;
 b=fK3wkGjgTU1/q9Vajt0tN+tfevRtk+kpEsBVa2sPzlFlUHJisQ2kQIwWndZVdNHRwaeG
 ogP/2hHsovdeovZ60a2DQYP6M+8PGuxgWFtAL8ksEP3bJHV/5IGVnrA3WENmvFpmwXyk
 M51JziNq8qgQSZdMxF3SNvjnvTsG3gNQ1yLvRZE+XOJaq2Ypc2Y8G3qO/yxXNjVCoI9B
 hwTSOddWODCJRfGb/PoRPx53YA8V4gRxGY/e6Gg5rqDuXe5qx1ncdJSTwh+K+v1MhW3Y
 /+mJi3dkfenyyT0UBZ9yztDFF1EVqWdCWyMK4OHEPA2vl7krmCM4GlLMR2xM33VR2sXu gg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kr68ngh68-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Nov 2022 09:26:55 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A99QsHa021939
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 9 Nov 2022 09:26:54 GMT
Received: from quicinc.com (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 9 Nov 2022
 01:26:51 -0800
From:   Pavankumar Kondeti <quic_pkondeti@quicinc.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        <kasan-dev@googlegroups.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Pavankumar Kondeti <quic_pkondeti@quicinc.com>
Subject: [PATCH] mm/kfence: remove hung_task cruft
Date:   Wed, 9 Nov 2022 14:56:46 +0530
Message-ID: <1667986006-25420-1-git-send-email-quic_pkondeti@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 64oPdNQofgGegYgIaFrSNehMaTYkmIqm
X-Proofpoint-ORIG-GUID: 64oPdNQofgGegYgIaFrSNehMaTYkmIqm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_03,2022-11-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 malwarescore=0 mlxlogscore=869 suspectscore=0 clxscore=1011
 priorityscore=1501 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211090072
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit fdf756f71271 ("sched: Fix more TASK_state comparisons") makes
hung_task not to monitor TASK_IDLE tasks. The special handling to
workaround hung_task warnings is not required anymore.

Signed-off-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
---
 mm/kfence/core.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index 1417888..08f5bd6 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -26,7 +26,6 @@
 #include <linux/random.h>
 #include <linux/rcupdate.h>
 #include <linux/sched/clock.h>
-#include <linux/sched/sysctl.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
@@ -799,16 +798,7 @@ static void toggle_allocation_gate(struct work_struct *work)
 	/* Enable static key, and await allocation to happen. */
 	static_branch_enable(&kfence_allocation_key);
 
-	if (sysctl_hung_task_timeout_secs) {
-		/*
-		 * During low activity with no allocations we might wait a
-		 * while; let's avoid the hung task warning.
-		 */
-		wait_event_idle_timeout(allocation_wait, atomic_read(&kfence_allocation_gate),
-					sysctl_hung_task_timeout_secs * HZ / 2);
-	} else {
-		wait_event_idle(allocation_wait, atomic_read(&kfence_allocation_gate));
-	}
+	wait_event_idle(allocation_wait, atomic_read(&kfence_allocation_gate));
 
 	/* Disable static key and reset timer. */
 	static_branch_disable(&kfence_allocation_key);
-- 
2.7.4

