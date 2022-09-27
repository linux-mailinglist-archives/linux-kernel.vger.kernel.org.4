Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F465EB669
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 02:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiI0AmR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 26 Sep 2022 20:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiI0AmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 20:42:14 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B544AD6A
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 17:42:13 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28QLVpXW019559
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 17:42:12 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jum2s8yrx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 17:42:12 -0700
Received: from twshared10425.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 17:42:11 -0700
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
        id 580ACD6D8A56; Mon, 26 Sep 2022 17:42:09 -0700 (PDT)
From:   Song Liu <song@kernel.org>
To:     <linux-kernel@vger.kernel.org>
CC:     <rostedt@goodmis.org>, <kernel-team@fb.com>,
        Song Liu <song@kernel.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: [PATCH v2] ftrace: fix recursive locking direct_mutex in ftrace_modify_direct_caller
Date:   Mon, 26 Sep 2022 17:41:46 -0700
Message-ID: <20220927004146.1215303-1-song@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: COKlcT1hkJM_YE1q-kLApcCDLXx9kPY2
X-Proofpoint-ORIG-GUID: COKlcT1hkJM_YE1q-kLApcCDLXx9kPY2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-26_11,2022-09-22_02,2022-06-22_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Naveen reported recursive locking of direct_mutex with sample
ftrace-direct-modify.ko:

[   74.762406] WARNING: possible recursive locking detected
[   74.762887] 6.0.0-rc6+ #33 Not tainted
[   74.763216] --------------------------------------------
[   74.763672] event-sample-fn/1084 is trying to acquire lock:
[   74.764152] ffffffff86c9d6b0 (direct_mutex){+.+.}-{3:3}, at: \
    register_ftrace_function+0x1f/0x180
[   74.764922]
[   74.764922] but task is already holding lock:
[   74.765421] ffffffff86c9d6b0 (direct_mutex){+.+.}-{3:3}, at: \
    modify_ftrace_direct+0x34/0x1f0
[   74.766142]
[   74.766142] other info that might help us debug this:
[   74.766701]  Possible unsafe locking scenario:
[   74.766701]
[   74.767216]        CPU0
[   74.767437]        ----
[   74.767656]   lock(direct_mutex);
[   74.767952]   lock(direct_mutex);
[   74.768245]
[   74.768245]  *** DEADLOCK ***
[   74.768245]
[   74.768750]  May be due to missing lock nesting notation
[   74.768750]
[   74.769332] 1 lock held by event-sample-fn/1084:
[   74.769731]  #0: ffffffff86c9d6b0 (direct_mutex){+.+.}-{3:3}, at: \
    modify_ftrace_direct+0x34/0x1f0
[   74.770496]
[   74.770496] stack backtrace:
[   74.770884] CPU: 4 PID: 1084 Comm: event-sample-fn Not tainted ...
[   74.771498] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), ...
[   74.772474] Call Trace:
[   74.772696]  <TASK>
[   74.772896]  dump_stack_lvl+0x44/0x5b
[   74.773223]  __lock_acquire.cold.74+0xac/0x2b7
[   74.773616]  lock_acquire+0xd2/0x310
[   74.773936]  ? register_ftrace_function+0x1f/0x180
[   74.774357]  ? lock_is_held_type+0xd8/0x130
[   74.774744]  ? my_tramp2+0x11/0x11 [ftrace_direct_modify]
[   74.775213]  __mutex_lock+0x99/0x1010
[   74.775536]  ? register_ftrace_function+0x1f/0x180
[   74.775954]  ? slab_free_freelist_hook.isra.43+0x115/0x160
[   74.776424]  ? ftrace_set_hash+0x195/0x220
[   74.776779]  ? register_ftrace_function+0x1f/0x180
[   74.777194]  ? kfree+0x3e1/0x440
[   74.777482]  ? my_tramp2+0x11/0x11 [ftrace_direct_modify]
[   74.777941]  ? __schedule+0xb40/0xb40
[   74.778258]  ? register_ftrace_function+0x1f/0x180
[   74.778672]  ? my_tramp1+0xf/0xf [ftrace_direct_modify]
[   74.779128]  register_ftrace_function+0x1f/0x180
[   74.779527]  ? ftrace_set_filter_ip+0x33/0x70
[   74.779910]  ? __schedule+0xb40/0xb40
[   74.780231]  ? my_tramp1+0xf/0xf [ftrace_direct_modify]
[   74.780678]  ? my_tramp2+0x11/0x11 [ftrace_direct_modify]
[   74.781147]  ftrace_modify_direct_caller+0x5b/0x90
[   74.781563]  ? 0xffffffffa0201000
[   74.781859]  ? my_tramp1+0xf/0xf [ftrace_direct_modify]
[   74.782309]  modify_ftrace_direct+0x1b2/0x1f0
[   74.782690]  ? __schedule+0xb40/0xb40
[   74.783014]  ? simple_thread+0x2a/0xb0 [ftrace_direct_modify]
[   74.783508]  ? __schedule+0xb40/0xb40
[   74.783832]  ? my_tramp2+0x11/0x11 [ftrace_direct_modify]
[   74.784294]  simple_thread+0x76/0xb0 [ftrace_direct_modify]
[   74.784766]  kthread+0xf5/0x120
[   74.785052]  ? kthread_complete_and_exit+0x20/0x20
[   74.785464]  ret_from_fork+0x22/0x30
[   74.785781]  </TASK>

Fix this by using register_ftrace_function_nolock in
ftrace_modify_direct_caller.

Fixes: 53cd885bc5c3 ("ftrace: Allow IPMODIFY and DIRECT ops on the same function")
Reported-and-tested-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Signed-off-by: Song Liu <song@kernel.org>

---
Changes v1 => v2:
1. Update comment before ftrace_modify_direct_caller().
2. Add lockdep_assert_held(&direct_mutex) to ftrace_modify_direct_caller().
---
 kernel/trace/ftrace.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 439e2ab6905e..8b1e0f4c1a65 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5427,6 +5427,8 @@ static struct ftrace_ops stub_ops = {
  * it is safe to modify the ftrace record, where it should be
  * currently calling @old_addr directly, to call @new_addr.
  *
+ * This is called with direct_mutex locked.
+ *
  * Safety checks should be made to make sure that the code at
  * @rec->ip is currently calling @old_addr. And this must
  * also update entry->direct to @new_addr.
@@ -5439,6 +5441,8 @@ int __weak ftrace_modify_direct_caller(struct ftrace_func_entry *entry,
 	unsigned long ip = rec->ip;
 	int ret;
 
+	lockdep_assert_held(&direct_mutex);
+
 	/*
 	 * The ftrace_lock was used to determine if the record
 	 * had more than one registered user to it. If it did,
@@ -5461,7 +5465,7 @@ int __weak ftrace_modify_direct_caller(struct ftrace_func_entry *entry,
 	if (ret)
 		goto out_lock;
 
-	ret = register_ftrace_function(&stub_ops);
+	ret = register_ftrace_function_nolock(&stub_ops);
 	if (ret) {
 		ftrace_set_filter_ip(&stub_ops, ip, 1, 0);
 		goto out_lock;
-- 
2.30.2

