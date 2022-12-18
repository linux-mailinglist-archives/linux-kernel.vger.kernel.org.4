Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4848264FD68
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 03:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiLRCBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 21:01:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiLRCBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 21:01:14 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D52F587
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 18:01:13 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id z12so5835875qtv.5
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 18:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9YL+FuLJ7qlz9APPs3z3TsrBC7PZN8ufUdCHbvSz3uA=;
        b=QOCDkq5P5nAvWc91YSNw5WGopKLBbYCesUMTZ/UAQCW1JkMZlfjxNVaOTwDd7aiKVS
         eCErS/jnF7akLL66EUKAiVSiVRCU6HdAgTGj00IQCQ6WTsY9Q3gUr6KM/C1wGbC+A5Jp
         uspD4UXnggM0BWLUAxt7Vx9kMcxSCG4A8J4io=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9YL+FuLJ7qlz9APPs3z3TsrBC7PZN8ufUdCHbvSz3uA=;
        b=NuYq2QI3IPvYjIQRhUimJ7n2ZWiv4L1p/PdWAdCRuWfRpD9waf5fLigm/zoqmuhqPP
         SqgCTmbPxauLEv6CE6hqCBnDT7FneGKC5OFCLyXn76gnvnRTc/3gIWxcah2gDQLSadga
         pDXmkHizz/6YvtvLpdiWWzt49QrbStULuLKTh6nmxi5PXU47XvLsRgwhev2Gafu3+Awo
         xoNoqzsLGr5qWBAYTZbevBdSSBoDrlp52AvTshe72eEEnT/YVOzUYGEWCsB91Vrt/csh
         F4DrwPkcJ22g5GJnlesvo2X6SUHRmWkED4tLNxyx2FQoNmTMIy9GEBciMsX53UK+fjNN
         lj9w==
X-Gm-Message-State: ANoB5pmiczIvf36HwAPoCAVcR7jvm6VmtRiWXsjZ0jTXoMn5zBZO/ECh
        Q6QyJZdCNgapLTlGr1XrgyfASA==
X-Google-Smtp-Source: AA0mqf6Uub/rQD9NpXq+yYYrHzYSh++cuSGYQ0k9M+NzTzMe5h6LjJ4MQ2sGRj3Ff04qVTJr641oJg==
X-Received: by 2002:ac8:465a:0:b0:3a6:9f4e:22b5 with SMTP id f26-20020ac8465a000000b003a69f4e22b5mr52883265qto.20.1671328872527;
        Sat, 17 Dec 2022 18:01:12 -0800 (PST)
Received: from localhost (48.230.85.34.bc.googleusercontent.com. [34.85.230.48])
        by smtp.gmail.com with ESMTPSA id g4-20020a05620a40c400b006fa16fe93bbsm4594096qko.15.2022.12.17.18.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Dec 2022 18:01:11 -0800 (PST)
Date:   Sun, 18 Dec 2022 02:01:11 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rcu: Fix opposite might_sleep() check in
 rcu_blocking_is_gp()
Message-ID: <Y550Z+MOq1IX3Wb4@google.com>
References: <20221215035755.2820163-1-qiang1.zhang@intel.com>
 <20221217010345.GF4001@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB5880526CB255AFF91F0D76A2DAE79@PH0PR11MB5880.namprd11.prod.outlook.com>
 <PH0PR11MB588000890D537044BBAA209EDAE79@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20221217051759.GK4001@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221217051759.GK4001@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2022 at 09:17:59PM -0800, Paul E. McKenney wrote:
> On Sat, Dec 17, 2022 at 02:44:47AM +0000, Zhang, Qiang1 wrote:
> > 
> > On Thu, Dec 15, 2022 at 11:57:55AM +0800, Zqiang wrote:
> > > Currently, if the system is in the RCU_SCHEDULER_INACTIVE state, invoke
> > > synchronize_rcu_*() will implies a grace period and return directly,
> > > so there is no sleep action due to waiting for a grace period to end,
> > > but this might_sleep() check is the opposite. therefore, this commit
> > > puts might_sleep() check in the correct palce.
> > > 
> > > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > >
> > >Queued for testing and review, thank you!
> > >
> > >I was under the impression that might_sleep() did some lockdep-based
> > >checking, but I am unable to find it.  If there really is such checking,
> > >that would be a potential argument for leaving this code as it is.
> > >
> > >
> > >__might_sleep
> > >   __might_resched(file, line, 0)
> > >      rcu_sleep_check()
> > >
> > >Does it refer to this rcu_sleep_check() ?
> > >
> > >If so, when in the RCU_SCHEDULER_INACTIVE state,  the debug_lockdep_rcu_enabled() is always
> > >return false, so the RCU_LOCKDEP_WARN() also does not produce an actual warning.
> > 
> > and when the system_state == SYSTEM_BOOTING, we just did  rcu_sleep_check()  and then  return.
> 
> Very good, thank you!
> 
> Thoughts from others?

Please consider this as a best-effort comment that might be missing details:

The might_sleep() was added in 18fec7d8758d ("rcu: Improve synchronize_rcu()
diagnostics")

Since it is illegal to call a blocking API like synchronize_rcu() in a
non-preemptible section, is there any harm in just calling might_sleep()
uncomditionally in rcu_block_is_gp() ? I think it is a bit irrelevant if
synchronize_rcu() is called from a call path, before scheduler is
initialized, or after. The fact that it was even called from a
non-preemptible section is a red-flag, considering if such non-preemptible
section may call synchronize_rcu() API in the future, after full boot up,
even if rarely.

For this reason, IMHO there is still value in doing the might_sleep() check
unconditionally. Say if a common code path is invoked both before
RCU_SCHEDULER_INIT and *very rarely* after RCU_SCHEDULER_INIT.

Or is there more of a point in doing this check if scheduler is initialized
from RCU perspective ?

If not, I would do something like this:

---8<-----------------------

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 79aea7df4345..23c2303de9f4 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3435,11 +3435,12 @@ static int rcu_blocking_is_gp(void)
 {
 	int ret;
 
+	might_sleep();  /* Check for RCU read-side critical section. */
+
 	// Invoking preempt_model_*() too early gets a splat.
 	if (rcu_scheduler_active == RCU_SCHEDULER_INACTIVE ||
 	    preempt_model_full() || preempt_model_rt())
 		return rcu_scheduler_active == RCU_SCHEDULER_INACTIVE;
-	might_sleep();  /* Check for RCU read-side critical section. */
 	preempt_disable();
 	/*
 	 * If the rcu_state.n_online_cpus counter is equal to one,
