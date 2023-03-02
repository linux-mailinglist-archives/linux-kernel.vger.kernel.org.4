Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529E06A89EF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 20:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjCBT6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 14:58:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjCBT5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 14:57:52 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A55B48E31;
        Thu,  2 Mar 2023 11:57:51 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1677787067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BQXtIuVdKd6aYDdz0BrUrqG+XHrNJCfdUZckqmV0CGk=;
        b=lKgPdymx4ineOUjiWIUNWjOABTzLnRXZY8vvYPeuGMuZWqnHBPU9P2t7cAZ2XErOH9TERp
        mZFVRGlsJDT9mmyXB2vyT/So853g8vXuVt0VrWgeqBDYsl2CQQ0l/JwodkN74KwAeCGd7h
        GbpcdgKqBRioGBN6RgjmRl6VGTdc6mG/ld1dhiHAbSFr325qgbqtxcA6nLqVVVwzYoamSw
        5bzTiusEtufwdgqd2sHwYpbUlebWmaJfgTvsT4WsSdbX//sVYn4zvF7Fe7ewscZJUCIgOq
        D1Om2f5V4LFfkUtA+45GZzB61yGT32SHDtw4CnLx9Ttz5eih0506JYBj2XPFog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1677787067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BQXtIuVdKd6aYDdz0BrUrqG+XHrNJCfdUZckqmV0CGk=;
        b=Ivxb5hj77f/zf0BVQiuddIlSIi9XtkPI5IZVsai/WeryhUuVI7T0Rj3XQdt8Hfl+dPYn3e
        khSAw2pY/t5rqSBQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: [PATCH printk v1 17/18] rcu: Add atomic write enforcement for rcu stalls
Date:   Thu,  2 Mar 2023 21:02:17 +0106
Message-Id: <20230302195618.156940-18-john.ogness@linutronix.de>
In-Reply-To: <20230302195618.156940-1-john.ogness@linutronix.de>
References: <20230302195618.156940-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Invoke the atomic write enforcement functions for rcu stalls to
ensure that the information gets out to the consoles.

It is important to note that if there are any legacy consoles
registered, they will be attempting to directly print from the
printk-caller context, which may jeopardize the reliability of the
atomic consoles. Optimally there should be no legacy consoles
registered.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/rcu/tree_stall.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 5653560573e2..25207a213e7a 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -8,6 +8,7 @@
  */
 
 #include <linux/kvm_para.h>
+#include <linux/console.h>
 
 //////////////////////////////////////////////////////////////////////////////
 //
@@ -551,6 +552,7 @@ static void rcu_check_gp_kthread_expired_fqs_timer(void)
 
 static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
 {
+	enum cons_prio prev_prio;
 	int cpu;
 	unsigned long flags;
 	unsigned long gpa;
@@ -566,6 +568,8 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
 	if (rcu_stall_is_suppressed())
 		return;
 
+	prev_prio = cons_atomic_enter(CONS_PRIO_EMERGENCY);
+
 	/*
 	 * OK, time to rat on our buddy...
 	 * See Documentation/RCU/stallwarn.rst for info on how to debug
@@ -620,6 +624,8 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
 	panic_on_rcu_stall();
 
 	rcu_force_quiescent_state();  /* Kick them all. */
+
+	cons_atomic_exit(CONS_PRIO_EMERGENCY, prev_prio);
 }
 
 static void print_cpu_stall(unsigned long gps)
-- 
2.30.2

