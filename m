Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4470605363
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 00:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbiJSWrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 18:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbiJSWrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 18:47:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B056188AAD;
        Wed, 19 Oct 2022 15:47:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DA989B8260A;
        Wed, 19 Oct 2022 22:47:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 506FBC4314A;
        Wed, 19 Oct 2022 22:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666219621;
        bh=fFc3hA0ZPr//nb0oSgszXsNmNDNbjld6HNvW7I07HJ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Oy/1fcvMSiFHp/xKwJ9CqwfRJHoqRkZcrv5jCD4aB/NXbeEvG+CAwUn+1laykl7t5
         MMmXgTMbAhBmVfvWRKyYlC5jUxmRPZ6dEJEz0m9ZwTUj4tfcDKHGlv9zWZk+A+WIg0
         EqUOn0Qr+yCnEZl+/MBE/objul/fDbsW25LyJ9tkZ7Pq6SRXK/2/7uPjOk/JmrDBtJ
         mVGDhL9L+jbomtlachTuFWKndhB7zvpLpYgWGxho7hvOURaDR6/s/GPVo+BLtxO4uV
         B56yRqi+MUbeTK0SrMpyjd1/6lJenX52g0gLYrHty/L61W6B5paQBeYXfdxCgTivgS
         7jlhUKv59foUw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id AF2425C0A40; Wed, 19 Oct 2022 15:47:00 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Yipeng Zou <zouyipeng@huawei.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 6/8] rcu: Remove rcu_is_idle_cpu()
Date:   Wed, 19 Oct 2022 15:46:57 -0700
Message-Id: <20221019224659.2499511-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20221019224652.GA2499358@paulmck-ThinkPad-P17-Gen-1>
References: <20221019224652.GA2499358@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yipeng Zou <zouyipeng@huawei.com>

The commit 3fcd6a230fa7 ("x86/cpu: Avoid cpuinfo-induced IPIing of
idle CPUs") introduced rcu_is_idle_cpu() in order to identify the
current CPU idle state.  But commit f3eca381bd49 ("x86/aperfmperf:
Replace arch_freq_get_on_cpu()") switched to using MAX_SAMPLE_AGE,
so rcu_is_idle_cpu() is no longer used.  This commit therefore removes it.

Fixes: f3eca381bd49 ("x86/aperfmperf: Replace arch_freq_get_on_cpu()")
Signed-off-by: Yipeng Zou <zouyipeng@huawei.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcutiny.h | 2 --
 include/linux/rcutree.h | 2 --
 kernel/rcu/tree.c       | 6 ------
 3 files changed, 10 deletions(-)

diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index 9bc025aa79a30..5c271bf3a1e7e 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -146,8 +146,6 @@ static inline void rcu_virt_note_context_switch(void) { }
 static inline void rcu_cpu_stall_reset(void) { }
 static inline int rcu_jiffies_till_stall_check(void) { return 21 * HZ; }
 static inline void rcu_irq_exit_check_preempt(void) { }
-#define rcu_is_idle_cpu(cpu) \
-	(is_idle_task(current) && !in_nmi() && !in_hardirq() && !in_serving_softirq())
 static inline void exit_rcu(void) { }
 static inline bool rcu_preempt_need_deferred_qs(struct task_struct *t)
 {
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 70795386b9ffa..4003bf6cfa1c2 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -87,8 +87,6 @@ bool poll_state_synchronize_rcu_full(struct rcu_gp_oldstate *rgosp);
 void cond_synchronize_rcu(unsigned long oldstate);
 void cond_synchronize_rcu_full(struct rcu_gp_oldstate *rgosp);
 
-bool rcu_is_idle_cpu(int cpu);
-
 #ifdef CONFIG_PROVE_RCU
 void rcu_irq_exit_check_preempt(void);
 #else
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 5ec97e3f7468f..f6561aa401c04 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -301,12 +301,6 @@ static bool rcu_dynticks_in_eqs(int snap)
 	return !(snap & RCU_DYNTICKS_IDX);
 }
 
-/* Return true if the specified CPU is currently idle from an RCU viewpoint.  */
-bool rcu_is_idle_cpu(int cpu)
-{
-	return rcu_dynticks_in_eqs(rcu_dynticks_snap(cpu));
-}
-
 /*
  * Return true if the CPU corresponding to the specified rcu_data
  * structure has spent some time in an extended quiescent state since
-- 
2.31.1.189.g2e36527f23

