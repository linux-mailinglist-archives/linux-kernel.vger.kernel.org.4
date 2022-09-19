Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A627B5BD3B7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 19:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiISRag convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 19 Sep 2022 13:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbiISRab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 13:30:31 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC4622B16
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 10:30:29 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28JHMRwq018435
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 10:30:29 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jpmfxkxmd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 10:30:29 -0700
Received: from twshared2273.16.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 19 Sep 2022 10:30:27 -0700
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
        id 849C4D1E5FFA; Mon, 19 Sep 2022 10:30:15 -0700 (PDT)
From:   Song Liu <song@kernel.org>
To:     <linux-kernel@vger.kernel.org>
CC:     <rostedt@goodmis.org>, <kernel-team@fb.com>,
        Song Liu <song@kernel.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: [PATCH] ftrace: fix recursive locking direct_mutex in ftrace_modify_direct_caller
Date:   Mon, 19 Sep 2022 10:29:55 -0700
Message-ID: <20220919172955.1196326-1-song@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: y90Y-duKizbMf3ZeuAywrDpFYmkOCUcn
X-Proofpoint-ORIG-GUID: y90Y-duKizbMf3ZeuAywrDpFYmkOCUcn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_05,2022-09-16_01,2022-06-22_01
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
 kernel/trace/ftrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 439e2ab6905e..d308d0674805 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5461,7 +5461,7 @@ int __weak ftrace_modify_direct_caller(struct ftrace_func_entry *entry,
 	if (ret)
 		goto out_lock;
 
-	ret = register_ftrace_function(&stub_ops);
+	ret = register_ftrace_function_nolock(&stub_ops);
 	if (ret) {
 		ftrace_set_filter_ip(&stub_ops, ip, 1, 0);
 		goto out_lock;
-- 
2.30.2

