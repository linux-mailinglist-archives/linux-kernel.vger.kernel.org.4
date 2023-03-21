Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C71EF6C2697
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 01:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjCUAzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 20:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjCUAz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 20:55:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E2B34038
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 17:55:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 31840B811BC
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 00:55:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1C29C4339B;
        Tue, 21 Mar 2023 00:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679360118;
        bh=ek7/AteWZYhmTEqsmUJlialhZknBT1IZtRC5ItpzjTg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=POkf0iCa8BfQoAsVCpZXGJGRvObfxJO83+BBkjjmYs+2/ObTWuByWoP3CrVn1lZ0R
         sI6OQmL76cNsKAilP93ONJY4ybZiw43QopjIfDae9TU/kqfBMV6u+35YGlzCDclfkb
         Fcm5C52oP/2rPTJSN4z9gyJE7kUUPCiKjD6+Z5zA/R76UyoyQyEwUxYj7eBSJcMGfd
         9BdAYwHp/FDQMEpZ+a4byl3QH/iDk/J6+Jb2tzUTFnvR1BMKMAq1eBqH6ciTr2MCmk
         yhQLEEDVWD6Nq9hB/hHli5S/mijpGDHKGx38Gt1kWY8z0ydpdPQDO4aMz2VmmqBLWY
         +B3lLrccWj6jg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 70F00154039D; Mon, 20 Mar 2023 17:55:18 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@meta.com, rostedt@goodmis.org, jgross@suse.com,
        mingo@kernel.org, peterz@infradead.org, corbet@lwn.net,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH CSDlock 3/4] locking/csd_lock: Remove per-CPU data indirection from CSD lock debugging
Date:   Mon, 20 Mar 2023 17:55:15 -0700
Message-Id: <20230321005516.50558-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.0.rc2
In-Reply-To: <0c368b66-71b2-442f-a8f7-e6decc4be2d6@paulmck-laptop>
References: <0c368b66-71b2-442f-a8f7-e6decc4be2d6@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The diagnostics added by this commit were extremely useful in one instance:

a5aabace5fb8 ("locking/csd_lock: Add more data to CSD lock debugging")

However, they have not seen much action since, and there have been some
concerns expressed that the complexity is not worth the benefit.

Therefore, manually revert the following commit preparatory commit:

de7b09ef658d ("locking/csd_lock: Prepare more CSD lock debugging")

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 kernel/smp.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index 038d666f327b..7a85bcddd9dc 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -31,12 +31,8 @@
 
 #define CSD_TYPE(_csd)	((_csd)->node.u_flags & CSD_FLAG_TYPE_MASK)
 
-struct cfd_percpu {
-	call_single_data_t	csd;
-};
-
 struct call_function_data {
-	struct cfd_percpu	__percpu *pcpu;
+	call_single_data_t	__percpu *csd;
 	cpumask_var_t		cpumask;
 	cpumask_var_t		cpumask_ipi;
 };
@@ -59,8 +55,8 @@ int smpcfd_prepare_cpu(unsigned int cpu)
 		free_cpumask_var(cfd->cpumask);
 		return -ENOMEM;
 	}
-	cfd->pcpu = alloc_percpu(struct cfd_percpu);
-	if (!cfd->pcpu) {
+	cfd->csd = alloc_percpu(call_single_data_t);
+	if (!cfd->csd) {
 		free_cpumask_var(cfd->cpumask);
 		free_cpumask_var(cfd->cpumask_ipi);
 		return -ENOMEM;
@@ -75,7 +71,7 @@ int smpcfd_dead_cpu(unsigned int cpu)
 
 	free_cpumask_var(cfd->cpumask);
 	free_cpumask_var(cfd->cpumask_ipi);
-	free_percpu(cfd->pcpu);
+	free_percpu(cfd->csd);
 	return 0;
 }
 
@@ -730,7 +726,7 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 
 		cpumask_clear(cfd->cpumask_ipi);
 		for_each_cpu(cpu, cfd->cpumask) {
-			call_single_data_t *csd = &per_cpu_ptr(cfd->pcpu, cpu)->csd;
+			call_single_data_t *csd = per_cpu_ptr(cfd->csd, cpu);
 
 			if (cond_func && !cond_func(cpu, info))
 				continue;
@@ -774,7 +770,7 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 		for_each_cpu(cpu, cfd->cpumask) {
 			call_single_data_t *csd;
 
-			csd = &per_cpu_ptr(cfd->pcpu, cpu)->csd;
+			csd = per_cpu_ptr(cfd->csd, cpu);
 			csd_lock_wait(csd);
 		}
 	}
-- 
2.40.0.rc2

