Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B813C605395
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 01:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbiJSW7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 18:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbiJSW6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 18:58:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2021B1C97D5;
        Wed, 19 Oct 2022 15:58:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4BDE4B82620;
        Wed, 19 Oct 2022 22:58:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01CEAC4314D;
        Wed, 19 Oct 2022 22:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666220328;
        bh=uYczQLLZZuNFqlq5NKe5CWa3nO/1WLyhpggz2xg9uhA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q7M1Vv9lN62MBvoQb5g5kOtBWau7pjX4utTN721A0qI1T3bW4dJJ465cA0rrNCWZU
         ANWg7UiQUTzktsQaVP+ihkXfhqwFjV0sZqx/nuwYgBeX0T9J0a7LTYsC4GRYtc9ef1
         F2gCDcG418R5GTqMIZWJI+77HtI4oACAfA2X7DlJ8N57t/knxdBQkCRINgRoGGDS2D
         DkK3qIWyhQ2V+8cZiLGrXhdHH4iiFDX3ifV0Gtb+GL7Twu+Kpw7wNrmA+1T3GyJjOz
         t3G9FWGOW+shnkH3J2Num1HsvLc3XiZyQvthJ3KATqOHFim1VOZEPHcO3S30c3Gnjx
         Dy/UY6bj23tNA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B14B45C0920; Wed, 19 Oct 2022 15:58:47 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH v3 rcu 04/11] srcu: Check for consistent global per-srcu_struct NMI safety
Date:   Wed, 19 Oct 2022 15:58:39 -0700
Message-Id: <20221019225846.2501109-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20221019225838.GA2500612@paulmck-ThinkPad-P17-Gen-1>
References: <20221019225838.GA2500612@paulmck-ThinkPad-P17-Gen-1>
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

This commit adds runtime checks to verify that a given srcu_struct uses
consistent NMI-safe (or not) read-side primitives globally, but based
on the per-CPU data.  These global checks are made by the grace-period
code that must scan the srcu_data structures anyway, and are done only
in kernels built with CONFIG_PROVE_RCU=y.

Link: https://lore.kernel.org/all/20220910221947.171557773@linutronix.de/

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>
---
 kernel/rcu/srcutree.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 30575864fcfa3..87ae6f5c1edae 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -429,13 +429,18 @@ static unsigned long srcu_readers_lock_idx(struct srcu_struct *ssp, int idx)
 static unsigned long srcu_readers_unlock_idx(struct srcu_struct *ssp, int idx)
 {
 	int cpu;
+	unsigned long mask = 0;
 	unsigned long sum = 0;
 
 	for_each_possible_cpu(cpu) {
 		struct srcu_data *cpuc = per_cpu_ptr(ssp->sda, cpu);
 
 		sum += atomic_long_read(&cpuc->srcu_unlock_count[idx]);
+		if (IS_ENABLED(CONFIG_PROVE_RCU))
+			mask = mask | READ_ONCE(cpuc->srcu_nmi_safety);
 	}
+	WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && (mask & (mask >> 1)),
+		  "Mixed NMI-safe readers for srcu_struct at %ps.\n", ssp);
 	return sum;
 }
 
-- 
2.31.1.189.g2e36527f23

