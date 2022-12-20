Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912A6652812
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 21:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234055AbiLTUva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 15:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiLTUv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 15:51:28 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22C81DDF4;
        Tue, 20 Dec 2022 12:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=utF2L97VTLzBvBE0W7STX0hn0LhXyXYGIWEv+sIJxEw=; b=bUQ67hcytEz9bTHS66gO5YXbS2
        nZKStusnH31EMAAIxxg0Sqo4hNxktWHcY1H0sSPBzPZXI07VthxrU2+UvNgfZGbLmaOhLF71eSTLu
        AvZ+uyH2nbkV4ezLjfHgwXokdvwYg+eTbParlPlnsY3rZPpPN7D9HDS95JDcqTeRnA29hKoIrhtkr
        aZPYLyIYe+G7E66U/hnQWjJr2ziv0h4VH6hHCgwGVlbajSRU6STkwRuiBchfv+jgzdvelfpdYabzC
        rj4zVZBP1uD6o7yz9CUtZRirDtzuHV79rQGfW3OJUB4LqvxAJUEie5nvEgfP4hB1dXKA27sutfhDi
        nphYSDbw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p7ja5-002AbV-4e; Tue, 20 Dec 2022 20:51:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EF6D7300E86;
        Tue, 20 Dec 2022 21:51:09 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C5D2B20F04E94; Tue, 20 Dec 2022 21:51:09 +0100 (CET)
Date:   Tue, 20 Dec 2022 21:51:09 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>, rafael@kernel.org,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, len.brown@intel.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RFC/RFT PATCH 1/2] sched/core: Check and schedule ksoftirq
Message-ID: <Y6IgPVacKInH9tgv@hirez.programming.kicks-ass.net>
References: <20221215184300.1592872-1-srinivas.pandruvada@linux.intel.com>
 <20221215184300.1592872-2-srinivas.pandruvada@linux.intel.com>
 <Y5xURk3CkzhIjmmq@hirez.programming.kicks-ass.net>
 <20221216220748.GA1967978@lothringen>
 <Y6BMAp6A731F8ZL4@hirez.programming.kicks-ass.net>
 <5ae0d53990c29aa25648cbf32ef3b16e9bec911c.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ae0d53990c29aa25648cbf32ef3b16e9bec911c.camel@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 02:54:55PM -0800, srinivas pandruvada wrote:

> But after ksoftirqd_run_end(), which will renable local irq, this may
> further cause more soft irq pending. Here RCU soft irq entry continues

Right you are.. what about if we spell the idle.c thing like so instead?

Then we repeat the softirq thing every time we drop out of the idle loop
for a reschedule.

diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index f26ab2675f7d..6dce49813bcc 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -381,8 +381,13 @@ void play_idle_precise(u64 duration_ns, u64 latency_ns)
 	hrtimer_start(&it.timer, ns_to_ktime(duration_ns),
 		      HRTIMER_MODE_REL_PINNED_HARD);
 
-	while (!READ_ONCE(it.done))
+	while (!READ_ONCE(it.done)) {
+		rt_mutex_lock(&per_cpu(ksoftirq_lock, cpu));
+		__run_ksoftirqd(smp_processor_id());
+		rt_mutex_unlock(&per_cpu(ksoftirq_lock, cpu));
+
 		do_idle();
+	}
 
 	cpuidle_use_deepest_state(0);
 	current->flags &= ~PF_IDLE;
