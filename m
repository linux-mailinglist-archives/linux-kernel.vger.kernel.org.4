Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4575C003B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 16:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiIUOqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 10:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiIUOqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 10:46:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E881F89CD3;
        Wed, 21 Sep 2022 07:46:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8518A62C2D;
        Wed, 21 Sep 2022 14:46:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D69FEC43470;
        Wed, 21 Sep 2022 14:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663771600;
        bh=uclQIQLTJ0Fjb3CMUb437WvxBUVstCALy43H9B1aM3o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=poUcQfpnFSk0s3jba6jl0usVmXnqhhc8ZwIQXuDlfJn/WKUg8XfowqH9RI6mOPv1x
         2sKqq6GQzhoV5sbxB5igLaEYwFT7NBF4vnNCxsrtiYlrBYrX3QToGEj5L0fEK6S/9i
         ET59zIIlq4VMND3YCFqqywtu/EtXAzI4ouHw7tnwvomJvABVf4KU9blwAg4wvzQEQW
         fZ0flbTl+uKXqQI8GwUdOfcL95hJo8i3kfyijvnJbxi1CxyiHV1GE8iZFMbWr52IJA
         rcbTW3B0XFO/3DbPf9e3CowvCx2GBDm8Z2Y+PccCq0PMW2Bbe7ipZHduFVPA1aALf3
         jn9nJcRbkjTHg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7E4955C0AC7; Wed, 21 Sep 2022 07:46:40 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH RFC rcu 4/4] srcu: Check for consistent global per-srcu_struct NMI safety
Date:   Wed, 21 Sep 2022 07:46:38 -0700
Message-Id: <20220921144638.1201361-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220921144620.GA1200846@paulmck-ThinkPad-P17-Gen-1>
References: <20220921144620.GA1200846@paulmck-ThinkPad-P17-Gen-1>
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

This commit adds runtime checks to verify that a given srcu_struct uses
consistent NMI-safe (or not) read-side primitives globally, but based
on the per-CPU data.  These global checks are made by the grace-period
code that must scan the srcu_data structures anyway, and are done only
in kernels built with CONFIG_PROVE_RCU=y.

Link: https://lore.kernel.org/all/20220910221947.171557773@linutronix.de/

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>
---
 kernel/rcu/srcutree.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 09a11f2c2042..5772b8659c89 100644
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

