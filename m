Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8642F6C8FCE
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 18:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbjCYReX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 13:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbjCYReG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 13:34:06 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FA29EC4
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 10:33:59 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id g19so4488734qts.9
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 10:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1679765638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E6Aj0mbJD/qZB0r2J2tLnHasIPmuosonkIp69GrjB7E=;
        b=Y0ARwJXZKYTnxN/qpI5CVYzmurO4mC3453dcb5GLWg6JjriSKj0CM3lb+Msiqq3XWO
         8HbIL+kk+3wbPn+tXBcGbmQKysL7d06+QRHdQYwQ3p0g0UcR6SNyLI7wxwREnGr+UCHq
         aSKCZrC2vRIuhioqVrVNyibAqvhLuYcxJlqJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679765638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E6Aj0mbJD/qZB0r2J2tLnHasIPmuosonkIp69GrjB7E=;
        b=AwQ8s/74B/1BIHVbzg2KczXMIrdSnvEw5O/Ktp7Uf7bI56Hu5+6Os85J47im/fXLMU
         92Z+6QxLEIG3v6ckmQmXxpgk8bB0mMaN2FNOUYNGNLl12B+sG9Uk6WWxZktR1prvT5Bx
         aZD0rfGCo1N++APTxDQgPNgj7hgVBl4LLQrR/0M0Yeym1EshRt/66RvEiJc0Aqq1B1YJ
         zlCn0i5n/nErjITKPCwS6qGf5erdoAIrwlcJcga9Oz85zyAE/appQoCubmio/wA2tHJN
         T7uw6w1Ls2pr2hFOpx39i7seHBM5kN9gBHSDvXi20lcDMUWOsN9HcOeqk/buqjzDumrw
         LOhw==
X-Gm-Message-State: AO0yUKWML3ZEP4Pquq3a4l03r5cvmMu6Nx46Nb0zOjNghbAkrxoAI+UB
        L7GLdd43rCB4KUXwpwXpSl7vXTOCgyWTVGUkGyQ=
X-Google-Smtp-Source: AK7set/CmKjhmjvVfu3VgHk3NFiY73TLBKFZ9sR9voGoRKmwo6xyEu0cGZniNtSZAxfO2TZZVtCdJQ==
X-Received: by 2002:ac8:5b96:0:b0:3bf:c9d1:4276 with SMTP id a22-20020ac85b96000000b003bfc9d14276mr11467681qta.5.1679765638478;
        Sat, 25 Mar 2023 10:33:58 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id m4-20020ac84444000000b003e37ee54b5dsm6762764qtn.90.2023.03.25.10.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 10:33:58 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang1.zhang@intel.com>
Cc:     rcu@vger.kernel.org
Subject: [PATCH v2 06/13] rcu: Fix set/clear TICK_DEP_BIT_RCU_EXP bitmask race
Date:   Sat, 25 Mar 2023 17:33:09 +0000
Message-Id: <20230325173316.3118674-7-joel@joelfernandes.org>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
In-Reply-To: <20230325173316.3118674-1-joel@joelfernandes.org>
References: <20230325173316.3118674-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zqiang <qiang1.zhang@intel.com>

For kernels built with CONFIG_NO_HZ_FULL=y, the following scenario can result
in the scheduling-clock interrupt remaining enabled on a holdout CPU after
its quiescent state has been reported:

	CPU1                                                 CPU2
rcu_report_exp_cpu_mult                          synchronize_rcu_expedited_wait
   acquires rnp->lock                               mask = rnp->expmask;
                                                    for_each_leaf_node_cpu_mask(rnp, cpu, mask)
   rnp->expmask = rnp->expmask & ~mask;                rdp = per_cpu_ptr(&rcu_data, cpu1);
   for_each_leaf_node_cpu_mask(rnp, cpu, mask)
      rdp = per_cpu_ptr(&rcu_data, cpu1);
      if (!rdp->rcu_forced_tick_exp)
             continue;                                 rdp->rcu_forced_tick_exp = true;
                                                       tick_dep_set_cpu(cpu1, TICK_DEP_BIT_RCU_EXP);

The problem is that CPU2's sampling of rnp->expmask is obsolete by the
time it invokes tick_dep_set_cpu(), and CPU1 is not guaranteed to see
CPU2's store to ->rcu_forced_tick_exp in time to clear it.  And even if
CPU1 does see that store, it might invoke tick_dep_clear_cpu() before
CPU2 got around to executing its tick_dep_set_cpu(), which would still
leave the victim CPU with its scheduler-clock tick running.

Either way, an nohz_full real-time application running on the victim
CPU would have its latency needlessly degraded.

Note that expedited RCU grace periods look at context-tracking
information, and so if the CPU is executing in nohz_full usermode
throughout, that CPU cannot be victimized in this manner.

This commit therefore causes synchronize_rcu_expedited_wait to hold
the rcu_node structure's ->lock when checking for holdout CPUs, setting
TICK_DEP_BIT_RCU_EXP, and invoking tick_dep_set_cpu(), thus preventing
this race.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree_exp.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 249c2967d9e6..7cc4856da081 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -594,6 +594,7 @@ static void synchronize_rcu_expedited_wait(void)
 	struct rcu_data *rdp;
 	struct rcu_node *rnp;
 	struct rcu_node *rnp_root = rcu_get_root();
+	unsigned long flags;
 
 	trace_rcu_exp_grace_period(rcu_state.name, rcu_exp_gp_seq_endval(), TPS("startwait"));
 	jiffies_stall = rcu_exp_jiffies_till_stall_check();
@@ -602,17 +603,17 @@ static void synchronize_rcu_expedited_wait(void)
 		if (synchronize_rcu_expedited_wait_once(1))
 			return;
 		rcu_for_each_leaf_node(rnp) {
+			raw_spin_lock_irqsave_rcu_node(rnp, flags);
 			mask = READ_ONCE(rnp->expmask);
 			for_each_leaf_node_cpu_mask(rnp, cpu, mask) {
 				rdp = per_cpu_ptr(&rcu_data, cpu);
 				if (rdp->rcu_forced_tick_exp)
 					continue;
 				rdp->rcu_forced_tick_exp = true;
-				preempt_disable();
 				if (cpu_online(cpu))
 					tick_dep_set_cpu(cpu, TICK_DEP_BIT_RCU_EXP);
-				preempt_enable();
 			}
+			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 		}
 		j = READ_ONCE(jiffies_till_first_fqs);
 		if (synchronize_rcu_expedited_wait_once(j + HZ))
-- 
2.40.0.348.gf938b09366-goog

