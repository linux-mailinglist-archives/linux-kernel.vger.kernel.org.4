Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A7E5F72E3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 04:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiJGCr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 22:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiJGCrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 22:47:55 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587AFF1937
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 19:47:54 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id cn9so2127293qtb.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 19:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=q2+dZU83RktXX3g8pGSaseFPEu7PHwNMwK6Ew4vSHcA=;
        b=WpmJoIu/9GlwnUA1Ml9g4YFSQ4iY9vupDSvC6N5onPVzbnqBfs2SbsmIvmghkFLIpH
         vhBjrilt01QHE8KcEtgwUCHWDKozAByCxubMwMpRyXKz2KTCT1/Aq4VqROALCg/gmTk/
         XU3FRAZGh1uz/1DR++S6sIf51f+hD5je5awNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=q2+dZU83RktXX3g8pGSaseFPEu7PHwNMwK6Ew4vSHcA=;
        b=5hc0KiHn7+VGNxg6oxjx06FuSpfWzG08HoYE10eo5/I/2uetNE1n2L7xy+G5obNn1z
         Bq/cSwfUE70zqedaR+iNlCVkmzABFDkWyvBhjN2TtGQpSEM9jeAb4Jfvep+KFaa+bSKq
         7ozufdv6QJAQeUoxuae8QyqfeepHceQxzJ2fYotBMqJ8EwjBDpfExPxiby2HoUW9zWtr
         cCYyfya8JmoCxH/K5fhGwHvuE8KzouKP59o8y2rpy+l+M+bXV2x0GHESnIdPLCz1cEMn
         Wqtg9FPuqU+Lh7A1t5XvVq8G8SNMlO0Jlph4QLUylYen+PXRQRCK9kogZW8PhYNtWDoD
         YdWg==
X-Gm-Message-State: ACrzQf229D8mt/H0s82IbetARuvnUyaSFA/VMA5gXkovrcnzODHf7Jlq
        u5iPGAbxxAloLYmGcJfcBwyKAw==
X-Google-Smtp-Source: AMsMyM48nndas4y2gq/i/3Q/hqBLEwArjAHrvSc9owNzLn8ST728oYMva28sTy4XlRl9v6vSC52kFw==
X-Received: by 2002:a05:622a:216:b0:35d:43c8:2dfb with SMTP id b22-20020a05622a021600b0035d43c82dfbmr2794408qtx.568.1665110873483;
        Thu, 06 Oct 2022 19:47:53 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id w9-20020a05620a424900b006ce7d9dea7asm894990qko.13.2022.10.06.19.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 19:47:53 -0700 (PDT)
Date:   Fri, 7 Oct 2022 02:47:52 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, paulmck@kernel.org, rostedt@goodmis.org,
        youssefesmat@google.com, surenb@google.com
Subject: Re: [PATCH v7 01/11] rcu: Wake up nocb gp thread on
 rcu_barrier_entrain()
Message-ID: <Yz+TWF8ksVK7YzQ0@google.com>
References: <20221004024157.2470238-1-joel@joelfernandes.org>
 <20221004024157.2470238-2-joel@joelfernandes.org>
 <20221004222853.GA323878@lothringen>
 <c634e41e-3c6c-0896-0873-b9d1bb317cea@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c634e41e-3c6c-0896-0873-b9d1bb317cea@joelfernandes.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 06:57:59PM -0400, Joel Fernandes wrote:
> Hi Frederic,
> 
> On 10/4/2022 6:28 PM, Frederic Weisbecker wrote:
> > On Tue, Oct 04, 2022 at 02:41:47AM +0000, Joel Fernandes (Google) wrote:
> >> From: Frederic Weisbecker <frederic@kernel.org>
> >>
> >> In preparation of RCU lazy changes, wake up the RCU nocb gp thread if
> > 
> > It's more than just prep work for a new feature, it's a regression fix.
> 
> Oh ok, both our fixes are equivalent but I chose yours since its cleaner. I was
> fixing Lazy CBs since I can actually trigger this issue.
> 
> >> needed after an entrain. Otherwise, the RCU barrier callback can wait in
> >> the queue for several seconds before the lazy callbacks in front of it
> >> are serviced.
> > 
> > It's not about lazy callbacks here (but you can mention the fact that
> > waking nocb_gp if necessary after flushing bypass is a beneficial side
> > effect for further lazy implementation).
> > 
> > So here is the possible bad scenario:
> > 
> > 1) CPU 0 is nocb, it queues a callback
> > 2) CPU 0 goes idle (or userspace with nohz_full) forever
> > 3) The grace period related to that callback elapses
> > 4) The callback is moved to the done list (but is not invoked yet), there are no more pending for CPU 0
> > 5) CPU 1 calls rcu_barrier() and entrains to CPU 0 cblist
> 
> CPU 1 can only entrain into CPU 0 if the CPU is offline:
> 
> 		if (!rcu_rdp_cpu_online(rdp)) {
> 			rcu_barrier_entrain(rdp);
> 			WARN_ON_ONCE(READ_ONCE(rdp->barrier_seq_snap) != gseq);
> 			raw_spin_unlock_irqrestore(&rcu_state.barrier_lock,
> 			...
> 			continue;
> 		}
> 
> Otherwise an IPI does the entraining. So I do not see how CPU 0 being idle
> causes the cross-CPU entraining.
> 
> > 6) CPU 1 waits forever
> 
> But, I agree it can still wait forever, once the IPI handler does the
> entraining, since nothing will do the GP thread wakeup.
> 
> >>
> >> Reported-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > 
> > Fixes: 5d6742b37727 ("rcu/nocb: Use rcu_segcblist for no-CBs CPUs")
> 
> So, do you mind writing a proper patch with a proper commit message and Fixes
> tag then? It can independent of this series and add my Reported-by tag, thanks!

And a small hunk went into the wrong patch so I pulled it back into this one,
here is the updated version of this patch:

(Don't pull this as Frederic will post this one separately, just posting here
 for reference).
---8<-----------------------

From: Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH] rcu: Wake up nocb gp thread on rcu_barrier_entrain()

In preparation of RCU lazy changes, wake up the RCU nocb gp thread if
needed after an entrain. Otherwise, the RCU barrier callback can wait in
the queue for several seconds before the lazy callbacks in front of it
are serviced.

Reported-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree.c      | 11 +++++++++++
 kernel/rcu/tree.h      |  1 +
 kernel/rcu/tree_nocb.h |  4 ++++
 3 files changed, 16 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 5ec97e3f7468..04f33191e5ed 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3894,6 +3894,8 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
 {
 	unsigned long gseq = READ_ONCE(rcu_state.barrier_sequence);
 	unsigned long lseq = READ_ONCE(rdp->barrier_seq_snap);
+	bool wake_nocb = false;
+	bool was_done = false;
 
 	lockdep_assert_held(&rcu_state.barrier_lock);
 	if (rcu_seq_state(lseq) || !rcu_seq_state(gseq) || rcu_seq_ctr(lseq) != rcu_seq_ctr(gseq))
@@ -3902,6 +3904,7 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
 	rdp->barrier_head.func = rcu_barrier_callback;
 	debug_rcu_head_queue(&rdp->barrier_head);
 	rcu_nocb_lock(rdp);
+	was_done = rcu_rdp_is_offloaded(rdp) && !rcu_segcblist_pend_cbs(&rdp->cblist);
 	WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies));
 	if (rcu_segcblist_entrain(&rdp->cblist, &rdp->barrier_head)) {
 		atomic_inc(&rcu_state.barrier_cpu_count);
@@ -3909,7 +3912,15 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
 		debug_rcu_head_unqueue(&rdp->barrier_head);
 		rcu_barrier_trace(TPS("IRQNQ"), -1, rcu_state.barrier_sequence);
 	}
+
+	/*
+	 * If bypass list was non-empty, wake up the nocb GP thread otherwise
+	 * bypass/lazy CBs may not be noticed, and can cause real long delays!
+	 */
+	wake_nocb = was_done && rcu_segcblist_pend_cbs(&rdp->cblist);
 	rcu_nocb_unlock(rdp);
+	if (wake_nocb)
+		wake_nocb_gp(rdp, false);
 	smp_store_release(&rdp->barrier_seq_snap, gseq);
 }
 
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index d4a97e40ea9c..41faaf8eb872 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -443,6 +443,7 @@ static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 				  unsigned long j);
 static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 				bool *was_alldone, unsigned long flags);
+static bool wake_nocb_gp(struct rcu_data *rdp, bool force);
 static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_empty,
 				 unsigned long flags);
 static int rcu_nocb_need_deferred_wakeup(struct rcu_data *rdp, int level);
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index f77a6d7e1356..6caade0683dd 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1558,6 +1558,10 @@ static void rcu_init_one_nocb(struct rcu_node *rnp)
 {
 }
 
+static bool wake_nocb_gp(struct rcu_data *rdp, bool force)
+{
+}
+
 static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 				  unsigned long j)
 {
-- 
2.38.0.rc1.362.ged0d419d3c-goog

