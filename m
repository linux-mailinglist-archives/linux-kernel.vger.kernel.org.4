Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE4C6FBB18
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 00:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233920AbjEHWcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 18:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233976AbjEHWb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 18:31:59 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07A665AA
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 15:31:58 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 348JOsrS002212;
        Mon, 8 May 2023 22:31:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=B9yD/+CYrKVcypcEgjmGEaQX//z09PC+3sHaWn9qNXY=;
 b=fip0cDRmD8TGviS8pvRKyVtChRoKOPG4Uqplmf2abB2QcojmY1eCz5DLB2pLzNRgncMH
 uTfDfdYcK21C6QvR3vjRC7L44pFQ1M1vmWusmcg0fUskZe80tf9XSie5VXF9M3MKqYRh
 KzOBmZQlVz8LcGF1iG/g4LDjmrwF2HsHPB6DIcxxnRWczbxVrpnwgMqdZzV8exidM/Ma
 k2J+xvWY0tAeFuOEI4BfcSyXV7em+Msee1ed/MT2Luf5LS3PUCeBWkwFphD8wSCdreAd
 LibmmQPyRerz/Eo/b71/wSANSs1vBLO8IXMLhyE8oT2Zw2P7jB4DOenw7plQ+EWopzIb Gg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf7770ah6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 May 2023 22:31:48 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 348LZuea015246;
        Mon, 8 May 2023 22:31:48 GMT
Received: from localhost.localdomain (dhcp-10-191-130-46.vpn.oracle.com [10.191.130.46])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3qf77f5pca-3;
        Mon, 08 May 2023 22:31:47 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     peterz@infradead.org, paulmck@kernel.org, jgross@suse.com,
        vschneid@redhat.com, yury.norov@gmail.com, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 2/2] smp: Reduce NMI traffic from CSD waiters to CSD destination.
Date:   Tue,  9 May 2023 08:31:24 +1000
Message-Id: <20230508223124.1438167-3-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230508223124.1438167-1-imran.f.khan@oracle.com>
References: <20230508223124.1438167-1-imran.f.khan@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-08_16,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305080149
X-Proofpoint-GUID: rDEMgUGpwh1Lrqbkr3GQOK8wEb2tQVkb
X-Proofpoint-ORIG-GUID: rDEMgUGpwh1Lrqbkr3GQOK8wEb2tQVkb
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On systems with hundreds of CPUs, if few hundred or most of the CPUs
detect a CSD hang, then all of these waiters endup sending an NMI to
destination CPU to dump its backtrace.
Depending on the number of such NMIs, destination CPU can spent
a significant amount of time handling these NMIs and thus making
it more difficult for this CPU to address those pending CSDs timely.
In worst case it can happen that by the time destination CPU is done
handling all of the above mentioned backtrace NMIs, csd wait time
may have elapsed and all of the waiters start sending backtrace NMI
again and this behaviour continues in loop.

To avoid the above mentioned scenario, issue backtrace NMI only from
first waiter. The other waiters to same CSD destination can make use
of backtrace obtained via fist waiter's NMI.

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
 kernel/smp.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index b7ccba677a0a0..a1cd21ea8b308 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -43,6 +43,8 @@ static DEFINE_PER_CPU_ALIGNED(struct call_function_data, cfd_data);
 
 static DEFINE_PER_CPU_SHARED_ALIGNED(struct llist_head, call_single_queue);
 
+static DEFINE_PER_CPU(atomic_t, trigger_backtrace) = ATOMIC_INIT(1);
+
 static void __flush_smp_call_function_queue(bool warn_cpu_offline);
 
 int smpcfd_prepare_cpu(unsigned int cpu)
@@ -242,7 +244,8 @@ static bool csd_lock_wait_toolong(struct __call_single_data *csd, u64 ts0, u64 *
 			 *bug_id, !cpu_cur_csd ? "unresponsive" : "handling this request");
 	}
 	if (cpu >= 0) {
-		dump_cpu_task(cpu);
+		if (atomic_cmpxchg_acquire(&per_cpu(trigger_backtrace, cpu), 1, 0))
+			dump_cpu_task(cpu);
 		if (!cpu_cur_csd) {
 			pr_alert("csd: Re-sending CSD lock (#%d) IPI from CPU#%02d to CPU#%02d\n", *bug_id, raw_smp_processor_id(), cpu);
 			arch_send_call_function_single_ipi(cpu);
@@ -423,9 +426,14 @@ static void __flush_smp_call_function_queue(bool warn_cpu_offline)
 	struct llist_node *entry, *prev;
 	struct llist_head *head;
 	static bool warned;
+	atomic_t *tbt;
 
 	lockdep_assert_irqs_disabled();
 
+	/* Allow waiters to send backtrace NMI from here onwards */
+	tbt = this_cpu_ptr(&trigger_backtrace);
+	atomic_set_release(tbt, 1);
+
 	head = this_cpu_ptr(&call_single_queue);
 	entry = llist_del_all(head);
 	entry = llist_reverse_order(entry);
-- 
2.34.1

