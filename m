Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B786CFFC5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 11:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjC3J2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 05:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjC3J2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 05:28:17 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492D8AC
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 02:28:15 -0700 (PDT)
Received: from SHSend.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTP id 32U9RSYw099410;
        Thu, 30 Mar 2023 17:27:28 +0800 (+08)
        (envelope-from Ziwei.Dai@unisoc.com)
Received: from ziwei-lenovo.spreadtrum.com (10.0.74.54) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Thu, 30 Mar 2023 17:27:26 +0800
From:   Ziwei Dai <ziwei.dai@unisoc.com>
To:     <paulmck@kernel.org>, <frederic@kernel.org>,
        <quic_neeraju@quicinc.com>, <josh@joshtriplett.org>,
        <rostedt@goodmis.org>, <mathieu.desnoyers@efficios.com>,
        <jiangshanlai@gmail.com>, <joel@joelfernandes.org>,
        <rcu@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <shuang.wang@unisoc.com>,
        <yifan.xin@unisoc.com>, <ke.wang@unisoc.com>,
        <xuewen.yan@unisoc.com>, <zhiguo.niu@unisoc.com>,
        <ziwei.dai@unisoc.com>, <zhaoyang.huang@unisoc.com>
Subject: [PATCH] rcu: Make sure new krcp free business is handled after the wanted rcu grace period.
Date:   Thu, 30 Mar 2023 17:27:20 +0800
Message-ID: <1680168440-20511-1-git-send-email-ziwei.dai@unisoc.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.0.74.54]
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com 32U9RSYw099410
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS,
        T_PDS_OTHER_BAD_TLD autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: 代子为 (Ziwei Dai) <ziwei.dai@ziwei-lenovo.spreadtrum.com>

In kfree_rcu_monitor(), new free business at krcp is attached to any free
channel at krwp. kfree_rcu_monitor() is responsible to make sure new free
business is handled after the rcu grace period. But if there is any none-free
channel at krwp already, that means there is an on-going rcu work,
which will cause the kvfree_call_rcu()-triggered free business is done
before the wanted rcu grace period ends.

This commit ignores krwp which has non-free channel at kfree_rcu_monitor(),
to fix the issue that kvfree_call_rcu() loses effectiveness.

Below is the css_set obj "from_cset" use-after-free issue caused by
kvfree_call_rcu() losing effectiveness.
Core 0 calls rcu_read_lock(), then use "from_cset", then hard irq comes.
Core 1 calls kfree_rcu(cset, rcu_head), willing to free "from_cset" after new gp.
Core 2 frees "from_cset" after current gp end. "from_cset" is reallocated.
Core 0 references "from_cset"'s member, which causes crash.

Core 0					Core 1				       	Core 2
count_memcg_event_mm()
|rcu_read_lock()  <---
|mem_cgroup_from_task()
 |// <css_set ptr> is the "from_cset" mentioned on core 1
 |<css_set ptr> = rcu_dereference((task)->cgroups)
 |// Hard irq comes, current task is scheduled out.

			Core 1:
			cgroup_attach_task()
			|cgroup_migrate()
			 |cgroup_migrate_execute()
			  |css_set_move_task(task, from_cset, to_cset, true)
			  |cgroup_move_task(task, to_cset)
			   |rcu_assign_pointer(.., to_cset)
			   |...
			|cgroup_migrate_finish()
			 |put_css_set_locked(from_cset)
			  |from_cset->refcount return 0
			  |kfree_rcu(cset, rcu_head) <--- means to free from_cset after new gp
			   |add_ptr_to_bulk_krc_lock()
			   |schedule_delayed_work(&krcp->monitor_work, ..)

			kfree_rcu_monitor()
			|krcp->bulk_head[0]'s work attached to krwp->bulk_head_free[]
			|queue_rcu_work(system_wq, &krwp->rcu_work)
			 |if rwork->rcu.work is not in WORK_STRUCT_PENDING_BIT state,
			 |call_rcu(&rwork->rcu, rcu_work_rcufn) <--- request a new gp

								// There is a perious call_rcu(.., rcu_work_rcufn)
								// gp end, rcu_work_rcufn() is called.
								rcu_work_rcufn()
								|__queue_work(.., rwork->wq, &rwork->work);
								Core 2：
								// or there is a pending kfree_rcu_work() work called.
								|kfree_rcu_work()
								|krwp->bulk_head_free[0] bulk is freed before new gp end!!!
								|The "from_cset" mentioned on core 1 is freed before new gp end.
Core 0:
// the task is schedule in after many ms.
 |<css_set ptr>->subsys[(subsys_id) <--- caused kernel crash, because <css_set ptr>="from_cset" is freed.

Signed-off-by: Ziwei Dai <ziwei.dai@unisoc.com>

:#	modified:   tree.c
---
 kernel/rcu/tree.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 8e880c0..f6451a8 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3107,15 +3107,16 @@ static void kfree_rcu_monitor(struct work_struct *work)
 	for (i = 0; i < KFREE_N_BATCHES; i++) {
 		struct kfree_rcu_cpu_work *krwp = &(krcp->krw_arr[i]);
 
-		// Try to detach bulk_head or head and attach it over any
-		// available corresponding free channel. It can be that
-		// a previous RCU batch is in progress, it means that
-		// immediately to queue another one is not possible so
-		// in that case the monitor work is rearmed.
-		if ((!list_empty(&krcp->bulk_head[0]) && list_empty(&krwp->bulk_head_free[0])) ||
-			(!list_empty(&krcp->bulk_head[1]) && list_empty(&krwp->bulk_head_free[1])) ||
-				(READ_ONCE(krcp->head) && !krwp->head_free)) {
-
+		// Try to detach bulk_head or head and attach it, only when
+		// all channels are free.  Any channel is not free means at krwp
+		// there is on-going rcu work to handle krwp's free business.
+		if (!list_empty(&krwp->bulk_head_free[0]) ||
+			!list_empty(&krwp->bulk_head_free[1]) ||
+				krwp->head_free)
+			continue;
+		if (!list_empty(&krcp->bulk_head[0]) ||
+			!list_empty(&krcp->bulk_head[1]) ||
+			READ_ONCE(krcp->head)) {
 			// Channel 1 corresponds to the SLAB-pointer bulk path.
 			// Channel 2 corresponds to vmalloc-pointer bulk path.
 			for (j = 0; j < FREE_N_CHANNELS; j++) {
-- 
1.9.1

