Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE20D5F1DE5
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 18:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbiJAQwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 12:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiJAQv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 12:51:57 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA0A2EF09;
        Sat,  1 Oct 2022 09:51:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 797FDCE08CA;
        Sat,  1 Oct 2022 16:51:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A46AC433C1;
        Sat,  1 Oct 2022 16:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664643112;
        bh=F8WRoqMCSj2TJbGQouaKOuAszC23BoBrbhgxWFwgxKo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=DSsOt/tC4b9dPORWo7gWBdEMfnaplEK6Jb3tTod26Qy37MbMuyCbKghSXbDmRpkrB
         QrQpntakd0RGd2x53QH/ef3j+L9RwJtaMVDZjOMFUtoTAx5TyN3Ua3gMWlC/6Mp+mF
         k4t0HzT6va77VK4crYIsTWO2GlmaL3M+8S0re+DzKpmaTqTMCG5p2l58kbkMK1RtbD
         sBjcs/JweoKft4JbbdaLjWhAFnwAR5ZgpP1xDX9YJyOAFILTm9m8RHfIaI+FkYApBZ
         8/pedb+4s6Aq9kqM41lU6N+Xn7vnLYz19tjwu/jLTusVF6QkrHLHyIowt04yUBeKHf
         IUNtB6M5bCJeQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1987D5C05A8; Sat,  1 Oct 2022 09:51:52 -0700 (PDT)
Date:   Sat, 1 Oct 2022 09:51:52 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, rostedt@goodmis.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH RFC v2 rcu 1/8] srcu: Convert ->srcu_lock_count and
 ->srcu_unlock_count to atomic
Message-ID: <20221001165152.GO4196@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220929180714.GA2874192@paulmck-ThinkPad-P17-Gen-1>
 <20220929180731.2875722-1-paulmck@kernel.org>
 <87ill4vrb9.fsf@jogness.linutronix.de>
 <20220930153506.GD4196@paulmck-ThinkPad-P17-Gen-1>
 <87wn9k7g4o.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wn9k7g4o.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 10:43:43PM +0206, John Ogness wrote:
> On 2022-09-30, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> >> > -	this_cpu_inc(ssp->sda->srcu_lock_count[idx]);
> >> > +	this_cpu_inc(ssp->sda->srcu_lock_count[idx].counter);
> >> 
> >> Is there any particular reason that you are directly modifying
> >> @counter instead of raw_cpu_ptr()+atomic_long_inc() that do you in
> >> __srcu_read_lock_nmisafe() of patch 2?
> >
> > Performance.  From what I can see, this_cpu_inc() is way faster than
> > atomic_long_inc() on x86 and s390.  Maybe also on loongarch.  No idea
> > on arm64.
> 
> Yeah, that's what I figured. I just wanted to make sure.
> 
> FWIW, the rest of the series looks pretty straight forward to me.

Thank you for looking it over!  The updated patch is shown below.
The full series is in -rcu at branch srcunmisafe.2022.09.30a.  Feel free
to pull it into your printk() series if that makes things easier for you.

							Thanx, Paul

------------------------------------------------------------------------

commit 24511d0b754db760d4e1a08fc48a180f6a5a948b
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Thu Sep 15 12:09:30 2022 -0700

    srcu: Convert ->srcu_lock_count and ->srcu_unlock_count to atomic
    
    NMI-safe variants of srcu_read_lock() and srcu_read_unlock() are needed
    by printk(), which on many architectures entails read-modify-write
    atomic operations.  This commit prepares Tree SRCU for this change by
    making both ->srcu_lock_count and ->srcu_unlock_count by atomic_long_t.
    
    [ paulmck: Apply feedback from John Ogness. ]
    
    Link: https://lore.kernel.org/all/20220910221947.171557773@linutronix.de/
    
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
    Cc: Thomas Gleixner <tglx@linutronix.de>
    Cc: John Ogness <john.ogness@linutronix.de>
    Cc: Petr Mladek <pmladek@suse.com>

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index e3014319d1ad..0c4eca07d78d 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -23,8 +23,8 @@ struct srcu_struct;
  */
 struct srcu_data {
 	/* Read-side state. */
-	unsigned long srcu_lock_count[2];	/* Locks per CPU. */
-	unsigned long srcu_unlock_count[2];	/* Unlocks per CPU. */
+	atomic_long_t srcu_lock_count[2];	/* Locks per CPU. */
+	atomic_long_t srcu_unlock_count[2];	/* Unlocks per CPU. */
 
 	/* Update-side state. */
 	spinlock_t __private lock ____cacheline_internodealigned_in_smp;
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 1c304fec89c0..25e9458da6a2 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -417,7 +417,7 @@ static unsigned long srcu_readers_lock_idx(struct srcu_struct *ssp, int idx)
 	for_each_possible_cpu(cpu) {
 		struct srcu_data *cpuc = per_cpu_ptr(ssp->sda, cpu);
 
-		sum += READ_ONCE(cpuc->srcu_lock_count[idx]);
+		sum += atomic_long_read(&cpuc->srcu_lock_count[idx]);
 	}
 	return sum;
 }
@@ -434,7 +434,7 @@ static unsigned long srcu_readers_unlock_idx(struct srcu_struct *ssp, int idx)
 	for_each_possible_cpu(cpu) {
 		struct srcu_data *cpuc = per_cpu_ptr(ssp->sda, cpu);
 
-		sum += READ_ONCE(cpuc->srcu_unlock_count[idx]);
+		sum += atomic_long_read(&cpuc->srcu_unlock_count[idx]);
 	}
 	return sum;
 }
@@ -503,10 +503,10 @@ static bool srcu_readers_active(struct srcu_struct *ssp)
 	for_each_possible_cpu(cpu) {
 		struct srcu_data *cpuc = per_cpu_ptr(ssp->sda, cpu);
 
-		sum += READ_ONCE(cpuc->srcu_lock_count[0]);
-		sum += READ_ONCE(cpuc->srcu_lock_count[1]);
-		sum -= READ_ONCE(cpuc->srcu_unlock_count[0]);
-		sum -= READ_ONCE(cpuc->srcu_unlock_count[1]);
+		sum += atomic_long_read(&cpuc->srcu_lock_count[0]);
+		sum += atomic_long_read(&cpuc->srcu_lock_count[1]);
+		sum -= atomic_long_read(&cpuc->srcu_unlock_count[0]);
+		sum -= atomic_long_read(&cpuc->srcu_unlock_count[1]);
 	}
 	return sum;
 }
@@ -636,7 +636,7 @@ int __srcu_read_lock(struct srcu_struct *ssp)
 	int idx;
 
 	idx = READ_ONCE(ssp->srcu_idx) & 0x1;
-	this_cpu_inc(ssp->sda->srcu_lock_count[idx]);
+	this_cpu_inc(ssp->sda->srcu_lock_count[idx].counter);
 	smp_mb(); /* B */  /* Avoid leaking the critical section. */
 	return idx;
 }
@@ -650,7 +650,7 @@ EXPORT_SYMBOL_GPL(__srcu_read_lock);
 void __srcu_read_unlock(struct srcu_struct *ssp, int idx)
 {
 	smp_mb(); /* C */  /* Avoid leaking the critical section. */
-	this_cpu_inc(ssp->sda->srcu_unlock_count[idx]);
+	this_cpu_inc(ssp->sda->srcu_unlock_count[idx].counter);
 }
 EXPORT_SYMBOL_GPL(__srcu_read_unlock);
 
@@ -1687,8 +1687,8 @@ void srcu_torture_stats_print(struct srcu_struct *ssp, char *tt, char *tf)
 			struct srcu_data *sdp;
 
 			sdp = per_cpu_ptr(ssp->sda, cpu);
-			u0 = data_race(sdp->srcu_unlock_count[!idx]);
-			u1 = data_race(sdp->srcu_unlock_count[idx]);
+			u0 = data_race(atomic_long_read(&sdp->srcu_unlock_count[!idx]));
+			u1 = data_race(atomic_long_read(&sdp->srcu_unlock_count[idx]));
 
 			/*
 			 * Make sure that a lock is always counted if the corresponding
@@ -1696,8 +1696,8 @@ void srcu_torture_stats_print(struct srcu_struct *ssp, char *tt, char *tf)
 			 */
 			smp_rmb();
 
-			l0 = data_race(sdp->srcu_lock_count[!idx]);
-			l1 = data_race(sdp->srcu_lock_count[idx]);
+			l0 = data_race(atomic_long_read(&sdp->srcu_lock_count[!idx]));
+			l1 = data_race(atomic_long_read(&sdp->srcu_lock_count[idx]));
 
 			c0 = l0 - u0;
 			c1 = l1 - u1;
