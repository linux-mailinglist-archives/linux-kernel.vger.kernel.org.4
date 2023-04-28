Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B656F1D11
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 19:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346342AbjD1RBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 13:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjD1RAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 13:00:55 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38DFE2703
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 10:00:54 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33SF4XSx031617;
        Fri, 28 Apr 2023 17:00:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=+QMy/l384YvGQZ5Q1IRZPWRi2K6puso7UHybf7DN4AY=;
 b=EbkYj/GwAotd4c9mOdbYHlF9HjFfE/6WCa8mfFk2QLALMvqnKBdTFvBN+YvU4StSpTPt
 zVa2mHuopaimttBTU5sFsdYHrbiQA7NVIl5jQ009qpNMx7yUY3gOTX+hz3egRf2LbgKY
 nRZawliVwClP2dJWw7/Qi5eqmoM7s57HRWWKgFzwI1ylaO7v/of1dfFJCNJ+MbYY5aot
 UjQ9XXZoMEiv8kEzJRou7dGBfd1/QZ3sadV+C3J2v9VoH+jjrIrzozRb6zg+hR4MvBsg
 Fp7WCGs4KTescVjI8iYvWKp1UCW0PfR8624VVQt3pSrmSFSO2xCA3n8EkTJFr9NtlrVB NQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q46gbxwq8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Apr 2023 17:00:25 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33SFlOMh029935;
        Fri, 28 Apr 2023 17:00:24 GMT
Received: from localhost.localdomain (dhcp-10-191-130-53.vpn.oracle.com [10.191.130.53])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3q461b1n2g-2;
        Fri, 28 Apr 2023 17:00:23 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     peterz@infradead.org, paulmck@kernel.org, jgross@suse.com,
        vschneid@redhat.com, yury.norov@gmail.com, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/2] smp: Reduce logging due to dump_stack of CSD waiters.
Date:   Sat, 29 Apr 2023 03:00:05 +1000
Message-Id: <20230428170006.1241472-2-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230428170006.1241472-1-imran.f.khan@oracle.com>
References: <20230428170006.1241472-1-imran.f.khan@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-28_04,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=915
 adultscore=0 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304280136
X-Proofpoint-GUID: uTolTkvX5GzRBumGrt1tMhrKR3wGkRXw
X-Proofpoint-ORIG-GUID: uTolTkvX5GzRBumGrt1tMhrKR3wGkRXw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a waiter is waiting for CSD lock, its call stack will not change
between first and subsequent hang detection for the same CSD lock.
So dump_stack for the waiter only for first time detection.

This avoids excessive logging on large scale systems(with hundreds
of CPUs) where repetitive dump_stack from hundreds of CPUs can flood
the console.

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
 kernel/smp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index ab3e5dad6cfe9..b7ccba677a0a0 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -248,7 +248,8 @@ static bool csd_lock_wait_toolong(struct __call_single_data *csd, u64 ts0, u64 *
 			arch_send_call_function_single_ipi(cpu);
 		}
 	}
-	dump_stack();
+	if (firsttime)
+		dump_stack();
 	*ts1 = ts2;
 
 	return false;
-- 
2.34.1

