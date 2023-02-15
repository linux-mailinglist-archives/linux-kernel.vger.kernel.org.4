Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84506697B37
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 12:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233891AbjBOL4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 06:56:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbjBOL4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 06:56:46 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D88628842;
        Wed, 15 Feb 2023 03:56:44 -0800 (PST)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PGxPD6f26zrRvN;
        Wed, 15 Feb 2023 19:56:16 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.61) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 15 Feb 2023 19:56:40 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <naveen.n.rao@linux.ibm.com>, <anil.s.keshavamurthy@intel.com>,
        <davem@davemloft.net>, <mhiramat@kernel.org>, <ast@kernel.org>,
        <peterz@infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [PATCH 1/3] kprobes: Fixed probe nodes not correctly removed when forcibly unoptimized
Date:   Wed, 15 Feb 2023 19:54:28 +0800
Message-ID: <20230215115430.236046-2-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.30.GIT
In-Reply-To: <20230215115430.236046-1-yangjihong1@huawei.com>
References: <20230215115430.236046-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.61]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When unoptimize_kprobe forcibly unoptimize the kprobe, simply queue it in
the freeing_list, and do_free_cleaned_kprobes directly reclaims the kprobe
if unoptimizing_list is empty (see do_unoptimize_kprobes), which may cause
WARN or UAF problems.

The specific scenarios are as follows:

                          Thread1
arm_kprobe(p)
  mutex_lock(&kprobe_mutex)
  __arm_kprobe(kp)
    p = get_optimized_kprobe(p->addr)
    if (unlikely(_p))
      unoptimize_kprobe(_p, true)  // now _p is queued in freeing_list
  mutex_unlock(&kprobe_mutex)

                           Thread2
kprobe_optimizer
  mutex_lock(&kprobe_mutex)
  do_unoptimize_kprobes
    if (list_empty(&unoptimizing_list))
      return;  // here directly returned and does not process freeing_list.
  ...
  do_free_cleaned_kprobes
    foreach op in freeing_list:
      WARN_ON_ONCE(!kprobe_unused(&op->kp))  // WANR will be triggered here.
      free_aggr_kprobe((&op->kp)  // Delete op->kp directly, if access hash
                                  // list later, UAF problem will be triggered.
  mutex_unlock(&kprobe_mutex)

The freeing_list needs to be processed in do_unoptimize_kprobes regardless
of whether unoptimizing_list is empty.

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 kernel/kprobes.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 1c18ecf9f98b..0730e595f4c1 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -556,10 +556,9 @@ static void do_unoptimize_kprobes(void)
 	lockdep_assert_cpus_held();
 
 	/* Unoptimization must be done anytime */
-	if (list_empty(&unoptimizing_list))
-		return;
+	if (!list_empty(&unoptimizing_list))
+		arch_unoptimize_kprobes(&unoptimizing_list, &freeing_list);
 
-	arch_unoptimize_kprobes(&unoptimizing_list, &freeing_list);
 	/* Loop on 'freeing_list' for disarming */
 	list_for_each_entry_safe(op, tmp, &freeing_list, list) {
 		/* Switching from detour code to origin */
-- 
2.30.GIT

