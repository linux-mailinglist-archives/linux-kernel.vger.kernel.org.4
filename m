Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B43815E968B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 00:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbiIYWAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 18:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiIYWAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 18:00:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E96F2A958;
        Sun, 25 Sep 2022 15:00:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C71C3614B5;
        Sun, 25 Sep 2022 22:00:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7DFCC433C1;
        Sun, 25 Sep 2022 22:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664143248;
        bh=JNT9ovwJ5a7LseZHc7f645e2mjUSE+d6MdNF4U9ZPMw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GlJLiDnRYX23aL6G0c7a9CJ21jrSAh4239BOFw2SnARtZrFBf8hnVx/KGwcQPsKi8
         64SArqQyosc1iyTJporjKpUqFfs3Pz67UaVZ5JjjnL3Xo8Q75qWdifuXPCUrD4FdfB
         1GPdwRpEfBn5XUp/8sm68BmN2/2PcMAGu6EGLzPrbFlyMHfR32RVn7tZO2xcvSROvu
         WKtNjL5OfdWY8SzVc7ny2qMMWAu+XRNtG9Y3/zn54K9L8ciTGsk2XXlUtu44D/yypU
         govK85Tg4QzzBgr7TPRxiMw4hAWUazdqoqfxcS5+o34kE0p9rKZ1vw9irMGh0zu6is
         U8Vo9cOWfyFEQ==
Date:   Mon, 26 Sep 2022 00:00:45 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, paulmck@kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH v6 1/4] rcu: Make call_rcu() lazy to save power
Message-ID: <20220925220045.GA182613@lothringen>
References: <19217A4C-7183-4D78-A714-FBFE7BB20742@joelfernandes.org>
 <22F29015-5962-433D-8815-E4154B4897DD@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <22F29015-5962-433D-8815-E4154B4897DD@joelfernandes.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 24, 2022 at 09:00:39PM -0400, Joel Fernandes wrote:
> 
> 
> > On Sep 24, 2022, at 7:28 PM, Joel Fernandes <joel@joelfernandes.org> wrote:
> > 
> > ﻿Hi Frederic, thanks for the response, replies
> > below courtesy fruit company’s device:
> > 
> >>> On Sep 24, 2022, at 6:46 PM, Frederic Weisbecker <frederic@kernel.org> wrote:
> >>> 
> >>> ﻿On Thu, Sep 22, 2022 at 10:01:01PM +0000, Joel Fernandes (Google) wrote:
> >>> @@ -3902,7 +3939,11 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
> >>>   rdp->barrier_head.func = rcu_barrier_callback;
> >>>   debug_rcu_head_queue(&rdp->barrier_head);
> >>>   rcu_nocb_lock(rdp);
> >>> -    WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies));
> >>> +    /*
> >>> +     * Flush the bypass list, but also wake up the GP thread as otherwise
> >>> +     * bypass/lazy CBs maynot be noticed, and can cause real long delays!
> >>> +     */
> >>> +    WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies, FLUSH_BP_WAKE));
> >> 
> >> This fixes an issue that goes beyond lazy implementation. It should be done
> >> in a separate patch, handling rcu_segcblist_entrain() as well, with "Fixes: " tag.
> > 
> > I wanted to do that, however on discussion with
> > Paul I thought of making this optimization only for
> > all lazy bypass CBs. That makes it directly related
> > this patch since the laziness notion is first
> > introduced here. On the other hand I could make
> > this change in a later patch since we are not
> > super bisectable anyway courtesy of the last
> > patch (which is not really an issue if the CONFIG
> > is kept off during someone’s bisection.
> 
> Or are we saying it’s worth doing the wake up for rcu barrier even for regular bypass CB? That’d save 2 jiffies on rcu barrier. If we agree it’s needed, then yes splitting the patch makes sense.
> 
> Please let me know your opinions, thanks,
> 
>  - Joel

Sure, I mean since we are fixing the buggy rcu_barrier_entrain() anyway, let's
just fix bypass as well. Such as in the following (untested):

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index b39e97175a9e..a0df964abb0e 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3834,6 +3834,8 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
 {
 	unsigned long gseq = READ_ONCE(rcu_state.barrier_sequence);
 	unsigned long lseq = READ_ONCE(rdp->barrier_seq_snap);
+	bool wake_nocb = false;
+	bool was_alldone = false;
 
 	lockdep_assert_held(&rcu_state.barrier_lock);
 	if (rcu_seq_state(lseq) || !rcu_seq_state(gseq) || rcu_seq_ctr(lseq) != rcu_seq_ctr(gseq))
@@ -3842,6 +3844,8 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
 	rdp->barrier_head.func = rcu_barrier_callback;
 	debug_rcu_head_queue(&rdp->barrier_head);
 	rcu_nocb_lock(rdp);
+	if (rcu_rdp_is_offloaded(rdp) && !rcu_segcblist_pend_cbs(&rdp->cblist))
+		was_alldone = true;
 	WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies));
 	if (rcu_segcblist_entrain(&rdp->cblist, &rdp->barrier_head)) {
 		atomic_inc(&rcu_state.barrier_cpu_count);
@@ -3849,7 +3853,12 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
 		debug_rcu_head_unqueue(&rdp->barrier_head);
 		rcu_barrier_trace(TPS("IRQNQ"), -1, rcu_state.barrier_sequence);
 	}
+	if (was_alldone && rcu_segcblist_pend_cbs(&rdp->cblist))
+		wake_nocb = true;
 	rcu_nocb_unlock(rdp);
+	if (wake_nocb)
+		wake_nocb_gp(rdp, false);
+
 	smp_store_release(&rdp->barrier_seq_snap, gseq);
 }
 
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index d4a97e40ea9c..925dd98f8b23 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -439,6 +439,7 @@ static void zero_cpu_stall_ticks(struct rcu_data *rdp);
 static struct swait_queue_head *rcu_nocb_gp_get(struct rcu_node *rnp);
 static void rcu_nocb_gp_cleanup(struct swait_queue_head *sq);
 static void rcu_init_one_nocb(struct rcu_node *rnp);
+static bool wake_nocb_gp(struct rcu_data *rdp, bool force);
 static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 				  unsigned long j);
 static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 538a0ed93946..e1701aa9c82c 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1600,6 +1600,10 @@ static void rcu_init_one_nocb(struct rcu_node *rnp)
 {
 }
 
+static bool wake_nocb_gp(struct rcu_data *rdp, bool force)
+{
+}
+
 static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 				  unsigned long j)
 {
