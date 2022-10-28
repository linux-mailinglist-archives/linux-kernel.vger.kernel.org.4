Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F4073611C5F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 23:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiJ1VXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 17:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiJ1VXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 17:23:51 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135D324B323
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 14:23:50 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id bb5so4276296qtb.11
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 14:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RL3a1QvTi10woW8r1NIP0e6W2srZjdBCp4K2+POgfew=;
        b=Fr4/Y1/ER/tRbcOP8K4/TUh3OPUbRbO79POCrbJ9o4JsHqNb3LXaG/pXiAiQ80fDRn
         hO1uemm/j+qrbPImOexZ2pUQVDq9tbewV80Sljqor/02+N1zqZRZiRzgBheNSu7IGB1u
         CdS43BLYxl/993V6SmXhVss+CAvEBxDZTls3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RL3a1QvTi10woW8r1NIP0e6W2srZjdBCp4K2+POgfew=;
        b=Sjpm45iJr1Y4mMxRRJWzhR1NyBy1+eqBjpVqDwNtyq0uEaciUbp0JgI2RaSwIGwntJ
         U9HlcrknsjMZyfUrUDGl3QdFmok52OyEU8IzJb1KAObxryT2QB5AcPqHCe2bPOKC/qyd
         7mIEZAQDyAoVqjxWQjH68GoVffV5i0za6Jy3gthvfXXZ2+4qIOPSrBrA7lAof4SjBPq7
         7uY8ACzhkLoQxW3NNNkuCfjFCdV9qIIfia8n4v/mJ+fi+2UXbKBkZG0KBKwxZte0h9cA
         YwJ1e26PBMDgYXgJmIYxMhilb3+D5nDJSerAVw1X6vTJms7I85k/A6I+Bl8aECOdJQ1a
         bn4g==
X-Gm-Message-State: ACrzQf2LLpopAV+PxQvRMzLfDVOW7vvyn7GJjoRJLvVcqHVAtqsRUiSP
        Pp25pULd4JFc1l9dJd8WxuCrog==
X-Google-Smtp-Source: AMsMyM5x10xdWt2fqbHiPzuf9eHT/FWd01HIjpg+ZgIY8HrNXHkSneEJVD+xeB5JeiYJeN453SJnHw==
X-Received: by 2002:ac8:5806:0:b0:39c:e444:772c with SMTP id g6-20020ac85806000000b0039ce444772cmr1314664qtg.593.1666992229098;
        Fri, 28 Oct 2022 14:23:49 -0700 (PDT)
Received: from localhost (48.230.85.34.bc.googleusercontent.com. [34.85.230.48])
        by smtp.gmail.com with ESMTPSA id ff12-20020a05622a4d8c00b0039cb5c9dbacsm2920296qtb.22.2022.10.28.14.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 14:23:48 -0700 (PDT)
Date:   Fri, 28 Oct 2022 21:23:47 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org
Subject: Re: [PATCH rcu 13/14] workqueue: Make queue_rcu_work() use
 call_rcu_flush()
Message-ID: <Y1xIY77sFTyxgAsU@google.com>
References: <20221019225138.GA2499943@paulmck-ThinkPad-P17-Gen-1>
 <20221019225144.2500095-13-paulmck@kernel.org>
 <CAEXW_YQgSwMYisZVctXkjFu6_5YhFCpL_E5o5H4oJooS5Syp+g@mail.gmail.com>
 <20221024031540.GU5600@paulmck-ThinkPad-P17-Gen-1>
 <Y1ZtyjxKCcV0Hfjn@pc636>
 <Y1aDy3maaO39ClSU@pc636>
 <Y1ahs83258Lok9+O@google.com>
 <20221024153958.GY5600@paulmck-ThinkPad-P17-Gen-1>
 <Y1a8ei1h7SzyYZx9@pc636>
 <20221024164819.GA5600@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024164819.GA5600@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 09:48:19AM -0700, Paul E. McKenney wrote:
> On Mon, Oct 24, 2022 at 06:25:30PM +0200, Uladzislau Rezki wrote:
> > >
> > > You guys might need to agree on the definition of "good" here.  Or maybe
> > > understand the differences in your respective platforms' definitions of
> > > "good".  ;-)
> > >
> > Indeed. Bad is when once per-millisecond infinitely :) At least in such use
> > workload a can detect a power delta and power gain. Anyway, below is a new
> > trace where i do not use "flush" variant for the kvfree_rcu():
> > 
> > <snip>
> > 1. Home screen swipe:
> >          rcuop/0-15      [003] d..1  1792.767750: rcu_batch_start: rcu_preempt CBs=1003 bl=10
> >          rcuop/2-33      [002] d..1  1792.771717: rcu_batch_start: rcu_preempt CBs=934 bl=10
> >          rcuop/3-40      [001] d..1  1794.811816: rcu_batch_start: rcu_preempt CBs=1508 bl=11
> >          rcuop/1-26      [003] d..1  1797.116382: rcu_batch_start: rcu_preempt CBs=2127 bl=16
> >          rcuop/4-48      [001] d..1  1797.124422: rcu_batch_start: rcu_preempt CBs=95 bl=10
> >          rcuop/5-55      [002] d..1  1797.124731: rcu_batch_start: rcu_preempt CBs=143 bl=10
> >          rcuop/6-62      [005] d..1  1798.911719: rcu_batch_start: rcu_preempt CBs=132 bl=10
> >          rcuop/2-33      [002] d..1  1803.003966: rcu_batch_start: rcu_preempt CBs=3797 bl=29
> >          rcuop/0-15      [003] d..1  1803.004707: rcu_batch_start: rcu_preempt CBs=2969 bl=23
> > 2. App launches:
> >          rcuop/4-48      [005] d..1  1831.087612: rcu_batch_start: rcu_preempt CBs=6141 bl=47
> >          rcuop/7-69      [007] d..1  1831.095578: rcu_batch_start: rcu_preempt CBs=5464 bl=42
> >          rcuop/5-55      [004] d..1  1832.703571: rcu_batch_start: rcu_preempt CBs=8461 bl=66
> >          rcuop/0-15      [004] d..1  1833.731603: rcu_batch_start: rcu_preempt CBs=2548 bl=19
> >          rcuop/1-26      [006] d..1  1833.743691: rcu_batch_start: rcu_preempt CBs=2567 bl=20
> >          rcuop/2-33      [006] d..1  1833.744005: rcu_batch_start: rcu_preempt CBs=2359 bl=18
> >          rcuop/3-40      [006] d..1  1833.744286: rcu_batch_start: rcu_preempt CBs=3681 bl=28
> >          rcuop/4-48      [002] d..1  1838.079777: rcu_batch_start: rcu_preempt CBs=10444 bl=81
> >          rcuop/7-69      [001] d..1  1838.080375: rcu_batch_start: rcu_preempt CBs=12572 bl=98
> >            <...>-62      [002] d..1  1838.080646: rcu_batch_start: rcu_preempt CBs=14135 bl=110
> >          rcuop/6-62      [000] d..1  1838.087722: rcu_batch_start: rcu_preempt CBs=10839 bl=84
> >            <...>-62      [003] d..1  1839.227022: rcu_batch_start: rcu_preempt CBs=1834 bl=14
> >            <...>-26      [001] d..1  1839.963315: rcu_batch_start: rcu_preempt CBs=5769 bl=45
> >          rcuop/2-33      [001] d..1  1839.966485: rcu_batch_start: rcu_preempt CBs=3789 bl=29
> >            <...>-40      [001] d..1  1839.966596: rcu_batch_start: rcu_preempt CBs=6425 bl=50
> >          rcuop/2-33      [005] d..1  1840.541272: rcu_batch_start: rcu_preempt CBs=825 bl=10
> >          rcuop/2-33      [005] d..1  1840.547724: rcu_batch_start: rcu_preempt CBs=44 bl=10
> >          rcuop/2-33      [005] d..1  1841.075759: rcu_batch_start: rcu_preempt CBs=516 bl=10
> >          rcuop/0-15      [002] d..1  1841.695716: rcu_batch_start: rcu_preempt CBs=6312 bl=49
> >          rcuop/0-15      [003] d..1  1841.709714: rcu_batch_start: rcu_preempt CBs=39 bl=10
> >          rcuop/5-55      [004] d..1  1843.112442: rcu_batch_start: rcu_preempt CBs=16007 bl=125
> >          rcuop/5-55      [004] d..1  1843.115444: rcu_batch_start: rcu_preempt CBs=7901 bl=61
> >          rcuop/6-62      [001] dn.1  1843.123983: rcu_batch_start: rcu_preempt CBs=8427 bl=65
> >          rcuop/6-62      [006] d..1  1843.412383: rcu_batch_start: rcu_preempt CBs=981 bl=10
> >          rcuop/0-15      [003] d..1  1844.659812: rcu_batch_start: rcu_preempt CBs=1851 bl=14
> >          rcuop/0-15      [003] d..1  1844.667790: rcu_batch_start: rcu_preempt CBs=135 bl=10
> > <snip>
> > 
> > it is much more better. But. As i wrote earlier there is a patch that i have submitted
> > some time ago improving kvfree_rcu() batching:
> > 
> > <snip>
> > commit 51824b780b719c53113dc39e027fbf670dc66028
> > Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > Date:   Thu Jun 30 18:33:35 2022 +0200
> > 
> >     rcu/kvfree: Update KFREE_DRAIN_JIFFIES interval
> > 
> >     Currently the monitor work is scheduled with a fixed interval of HZ/20,
> >     which is roughly 50 milliseconds. The drawback of this approach is
> >     low utilization of the 512 page slots in scenarios with infrequence
> >     kvfree_rcu() calls.  For example on an Android system:
> > <snip>
> > 
> > The trace that i posted was taken without it.
> 
> And if I am not getting too confused, that patch is now in mainline.
> So it does make sense to rely on it, then.  ;-)

Vlad's patch to change the KFREE_DRAIN_JIFFIES to 5 seconds seems reasonable
to me. However, can we unify KFREE_DRAIN_JIFFIES and LAZY_FLUSH_JIFFIES ?

One at 5 and other at 10 seems odd, especially because the former seems to
negate the effects of the latter and anyone tweaking that in the future (say
via new command line options) should probably tweak them together to increase
batching.

Testing shows significantly better batching with Vlad's updates, however I am
wondering why the rcu_callback fires in pairs like that from separate
kworkers:

     kworker/6:1-157     [006] d..1   288.861610: rcu_callback: rcu_preempt  rhp=0000000079b895f9 func=rcu_work_rcufn 1214
     kworker/4:2-158     [004]  d..1   288.861612: rcu_callback: rcu_preempt rhp=00000000d83fcc90 func=rcu_work_rcufn 798

I wonder if the queued kwork is executing twice accidentally, or something.
This kernel does have the additional trace patch below, fyi.

Another thought I have is, if we can just keep the kvfree_rcu() mapped to
call_rcu() via a config option say CONFIG_RCU_LAZY_KFREE, or something.
Because I am personally not much a fan of the kfree_rcu() induced additional
timer wake ups and kworker queue+wakeup which we don't need per-se, if we are
already batching with Lazyfied-call_rcu. Too many moving parts which might
hurt power.

---8<-----------------------

From: Joel Fernandes <joelaf@google.com>
Subject: [PATCH] debug: reorder trace_rcu_callback

Signed-off-by: Joel Fernandes <joelaf@google.com>
---
 kernel/rcu/tree.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 73feb09fd51b..a7c175e9533a 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2978,10 +2978,6 @@ __call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy)
 	}
 
 	check_cb_ovld(rdp);
-	if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags, lazy))
-		return; // Enqueued onto ->nocb_bypass, so just leave.
-	// If no-CBs CPU gets here, rcu_nocb_try_bypass() acquired ->nocb_lock.
-	rcu_segcblist_enqueue(&rdp->cblist, head);
 	if (__is_kvfree_rcu_offset((unsigned long)func))
 		trace_rcu_kvfree_callback(rcu_state.name, head,
 					 (unsigned long)func,
@@ -2990,6 +2986,11 @@ __call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy)
 		trace_rcu_callback(rcu_state.name, head,
 				   rcu_segcblist_n_cbs(&rdp->cblist));
 
+	if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags, lazy))
+		return; // Enqueued onto ->nocb_bypass, so just leave.
+	// If no-CBs CPU gets here, rcu_nocb_try_bypass() acquired ->nocb_lock.
+	rcu_segcblist_enqueue(&rdp->cblist, head);
+
 	/* Go handle any RCU core processing required. */
 	if (IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
 	    unlikely(rcu_segcblist_is_offloaded(&rdp->cblist))) {
-- 
2.38.1.273.g43a17bfeac-goog

