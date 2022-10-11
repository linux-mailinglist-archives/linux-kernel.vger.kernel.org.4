Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49175FAA6A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 04:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbiJKCAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 22:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJKCAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 22:00:43 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5528660527
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 19:00:42 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id x8so1001453qtv.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 19:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vv2dJz5tlq73HXaoaG/mq43YykBqoKsaIM/hqD5FsXg=;
        b=VYvyIXKE8VJUyeay6YvtK2lh0IxanH33tOABo5696GTXpSfEMEy/liGKszi+gBRFf9
         J3bgy7AaBZWGM8z0e7UAZzkg+u+DPG7z7YuRRyhJZut5o2sqh6QadjZD9XRqJOyGW1nI
         +vXlwGS6eXe8ag1qaQlwlBDB7yMyeYM4YNrSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vv2dJz5tlq73HXaoaG/mq43YykBqoKsaIM/hqD5FsXg=;
        b=DaKn/ZkhiQ2BTdbXHQAYVfRy3TiklzODf8LKuON8vGlZzDzdZ98RSZFgM7rAtoQmnZ
         Ke8fMtaizbr/+e7Nubk5t05eNWqoIUeoKoMwFi/LKJ4dolLCFiV3BYaKW1yT0vQ0F9su
         DAGXgCZ8fX860+WP/ImHZOfgBg+Fy1BkfdXFj0FxqEDG6MuK8JnJCmknXDXuqCWaM4r5
         1jI6lGeOytGFx5f+NUbZLH1OCJPGIG1zFyxQJQHHdKR/rTGob01dsp3/WGB3RS0fNfjv
         4mYUfsRPvbh4AGdcnHrHti/1nuvNdeUo190voLHafBOPEwrK3DJwJH/QzkJw9PJSSsGy
         6eKA==
X-Gm-Message-State: ACrzQf2eDsp9pkJMoXfMKEzqjEJX3Y5V25javOzJiUIQBIPelLiOE+md
        8dh/khDmCzLmFErVFlo1z9W00IPEDk12Zg==
X-Google-Smtp-Source: AMsMyM62WQ3Jl+CBGbBmMt+cEAX15iFN/EwCTBSK21LInLBw1clDk3mXnFeFmn9ORJhRyGRldIotBw==
X-Received: by 2002:a05:622a:5a0b:b0:35b:b8fc:874f with SMTP id fy11-20020a05622a5a0b00b0035bb8fc874fmr17417913qtb.267.1665453641322;
        Mon, 10 Oct 2022 19:00:41 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id h10-20020a05620a284a00b006e2a1999263sm11644725qkp.62.2022.10.10.19.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 19:00:40 -0700 (PDT)
Date:   Tue, 11 Oct 2022 02:00:40 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] rcu/nocb: Spare bypass locking upon normal enqueue
Message-ID: <Y0TOSE3ZM/3uHRWX@google.com>
References: <20221010223956.1041247-1-frederic@kernel.org>
 <20221010223956.1041247-3-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221010223956.1041247-3-frederic@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 12:39:56AM +0200, Frederic Weisbecker wrote:
> When a callback is to be enqueued to the normal queue and not the bypass
> one, a flush to the bypass queue is always tried anyway. This attempt
> involves locking the bypass lock unconditionally. Although it is
> guaranteed not to be contended at this point, because only call_rcu()
> can lock the bypass lock without holding the nocb lock, it's still not
> free and the operation can easily be spared most of the time by just
> checking if the bypass list is empty. The check is safe as nobody can
> queue nor flush the bypass concurrently.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  kernel/rcu/tree_nocb.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index 094fd454b6c3..30c3d473ffd8 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -423,8 +423,10 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
>  		if (*was_alldone)
>  			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
>  					    TPS("FirstQ"));
> -		WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, j));
> -		WARN_ON_ONCE(rcu_cblist_n_cbs(&rdp->nocb_bypass));
> +		if (rcu_cblist_n_cbs(&rdp->nocb_bypass)) {
> +			WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, j));
> +			WARN_ON_ONCE(rcu_cblist_n_cbs(&rdp->nocb_bypass));
> +		}
>  		return false; // Caller must enqueue the callback.
>  	}

Instead of this, since as you mentioned that the bypass lock is not contended
in this path, isn't it unnecessary to even check or attempt to acquire the
lock in call_rcu() path? So how about something like the following, or would
this not work for some reason?

Thanks.

---8<-----------------------

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index ad8d4e52ae92..6235e72cca07 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3950,7 +3950,7 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
 	debug_rcu_head_queue(&rdp->barrier_head);
 	rcu_nocb_lock(rdp);
 	was_done = rcu_rdp_is_offloaded(rdp) && !rcu_segcblist_pend_cbs(&rdp->cblist);
-	WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies, false));
+	WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies, false, false));
 	if (rcu_segcblist_entrain(&rdp->cblist, &rdp->barrier_head)) {
 		atomic_inc(&rcu_state.barrier_cpu_count);
 	} else {
@@ -4379,7 +4379,7 @@ void rcutree_migrate_callbacks(int cpu)
 	my_rdp = this_cpu_ptr(&rcu_data);
 	my_rnp = my_rdp->mynode;
 	rcu_nocb_lock(my_rdp); /* irqs already disabled. */
-	WARN_ON_ONCE(!rcu_nocb_flush_bypass(my_rdp, NULL, jiffies, false));
+	WARN_ON_ONCE(!rcu_nocb_flush_bypass(my_rdp, NULL, jiffies, false, false));
 	raw_spin_lock_rcu_node(my_rnp); /* irqs already disabled. */
 	/* Leverage recent GPs and set GP for new callbacks. */
 	needwake = rcu_advance_cbs(my_rnp, rdp) ||
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 1d803d39f0d1..0adb8f97a56d 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -442,7 +442,7 @@ static struct swait_queue_head *rcu_nocb_gp_get(struct rcu_node *rnp);
 static void rcu_nocb_gp_cleanup(struct swait_queue_head *sq);
 static void rcu_init_one_nocb(struct rcu_node *rnp);
 static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
-				  unsigned long j, bool lazy);
+				  unsigned long j, bool lazy, bool nolock);
 static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 				bool *was_alldone, unsigned long flags,
 				bool lazy);
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index c9a791407650..2164f5d79dec 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -328,7 +328,7 @@ static void wake_nocb_gp_defer(struct rcu_data *rdp, int waketype,
  * Note that this function always returns true if rhp is NULL.
  */
 static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp_in,
-				     unsigned long j, bool lazy)
+				     unsigned long j, bool lazy, bool nolock)
 {
 	struct rcu_cblist rcl;
 	struct rcu_head *rhp = rhp_in;
@@ -359,7 +359,8 @@ static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp_
 
 	rcu_segcblist_insert_pend_cbs(&rdp->cblist, &rcl);
 	WRITE_ONCE(rdp->nocb_bypass_first, j);
-	rcu_nocb_bypass_unlock(rdp);
+	if (!nolock)
+		rcu_nocb_bypass_unlock(rdp);
 	return true;
 }
 
@@ -372,13 +373,14 @@ static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp_
  * Note that this function always returns true if rhp is NULL.
  */
 static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
-				  unsigned long j, bool lazy)
+				  unsigned long j, bool lazy, bool nolock)
 {
 	if (!rcu_rdp_is_offloaded(rdp))
 		return true;
 	rcu_lockdep_assert_cblist_protected(rdp);
-	rcu_nocb_bypass_lock(rdp);
-	return rcu_nocb_do_flush_bypass(rdp, rhp, j, lazy);
+	if (!nolock)
+		rcu_nocb_bypass_lock(rdp);
+	return rcu_nocb_do_flush_bypass(rdp, rhp, j, lazy, nolock);
 }
 
 /*
@@ -391,7 +393,7 @@ static void rcu_nocb_try_flush_bypass(struct rcu_data *rdp, unsigned long j)
 	if (!rcu_rdp_is_offloaded(rdp) ||
 	    !rcu_nocb_bypass_trylock(rdp))
 		return;
-	WARN_ON_ONCE(!rcu_nocb_do_flush_bypass(rdp, NULL, j, false));
+	WARN_ON_ONCE(!rcu_nocb_do_flush_bypass(rdp, NULL, j, false, false));
 }
 
 /*
@@ -473,7 +475,7 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
 					    TPS("FirstQ"));
 
-		WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, j, false));
+		WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, j, false, true));
 		WARN_ON_ONCE(rcu_cblist_n_cbs(&rdp->nocb_bypass));
 		return false; // Caller must enqueue the callback.
 	}
@@ -487,7 +489,7 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 		rcu_nocb_lock(rdp);
 		*was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
 
-		if (!rcu_nocb_flush_bypass(rdp, rhp, j, lazy)) {
+		if (!rcu_nocb_flush_bypass(rdp, rhp, j, lazy, true)) {
 			if (*was_alldone)
 				trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
 						    TPS("FirstQ"));
@@ -1136,7 +1138,7 @@ static long rcu_nocb_rdp_deoffload(void *arg)
 	 * return false, which means that future calls to rcu_nocb_try_bypass()
 	 * will refuse to put anything into the bypass.
 	 */
-	WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies, false));
+	WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies, false, false));
 	/*
 	 * Start with invoking rcu_core() early. This way if the current thread
 	 * happens to preempt an ongoing call to rcu_core() in the middle,
@@ -1717,7 +1719,7 @@ static bool wake_nocb_gp(struct rcu_data *rdp, bool force)
 }
 
 static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
-				  unsigned long j, bool lazy)
+				  unsigned long j, bool lazy, bool nolock)
 {
 	return true;
 }
