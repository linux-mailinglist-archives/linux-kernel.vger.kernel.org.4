Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44CF15BAEF2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 16:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbiIPOKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 10:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiIPOKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 10:10:09 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1139F4CA0A
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 07:10:07 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id s13so16668499qvq.10
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 07:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=D/nvdqaHFpe1zsfIJuakh3iZT0co15SWz9wcaywW0Nc=;
        b=Lxc6rGaMYj3BTp03h17nsZvZ1yGoIrwXZFUMpt8WIoL4Ihj3JR9s5Y9wpdySUXm9la
         pKCimgsi7ob7A3M5yWltfz98quADLsldNe6GgpYHyMV0tERq6E8lhGUjVIHdcMt7dakb
         qWCeZJq3w+Pyjzpnzz1zh7t0KzuLXCD6kQQKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=D/nvdqaHFpe1zsfIJuakh3iZT0co15SWz9wcaywW0Nc=;
        b=1CqyolNr833b2PnDmxYf5nfLHr9C3T6UywmKyaGijB1LPJEwh2TzVwyBKgCaVRmNwG
         qLd5b85rkOwcvr7YtdVE3N2ESCxfAV0OK01/tpPUTno9tf0Q5WNlxy3P9WgrgDDMrfTL
         3JxroJIbFoK3GNsgDHBzZoukZmDOppR+9c7rSSdNgVwm8AkDYttxWkg5k9HMyt+kIzMV
         daMRe/wHV7Q+3YCNxbhUktGqAdMuZCuOySbqwCJ0icZ/eOovN8qJr14C+Gjr7p91+yoU
         04iG+ZBqcphemf28ICHd+7bLwYcDUVZcQcMQgPz6lfxRhmBv39M+fHdRNZED7Rv1Oa9/
         ZLNg==
X-Gm-Message-State: ACrzQf3FAXdTNH3YnCamoF7Clu+YD94zePn6LkAQADPnttRW4BikoE8i
        4OEmfgviwnHcdemjzudsGLuVZA==
X-Google-Smtp-Source: AMsMyM5TniT6S1SCYiW4TGU4hf+uummzTjOmRnODlrqrT3s7hjL1vqPZ3SVSrfEtEoas7uMR3IRumQ==
X-Received: by 2002:a05:6214:c8b:b0:4ac:c1f7:660f with SMTP id r11-20020a0562140c8b00b004acc1f7660fmr4577227qvr.52.1663337406080;
        Fri, 16 Sep 2022 07:10:06 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id c18-20020a379a12000000b006b8d1914504sm6269991qke.22.2022.09.16.07.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 07:10:05 -0700 (PDT)
Date:   Fri, 16 Sep 2022 14:10:05 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH rcu/next 2/3] rcu: Move trace_rcu_callback() before
 bypassing
Message-ID: <YySDvbF/BfDhy40H@google.com>
References: <20220915001419.55617-1-joel@joelfernandes.org>
 <20220915001419.55617-3-joel@joelfernandes.org>
 <20220916110949.GB25456@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220916110949.GB25456@lothringen>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 01:09:49PM +0200, Frederic Weisbecker wrote:
> On Thu, Sep 15, 2022 at 12:14:18AM +0000, Joel Fernandes (Google) wrote:
> > If any CB is queued into the bypass list, then trace_rcu_callback() does
> > not show it. This makes it not clear when a callback was actually
> > queued, as you only end up getting a trace_rcu_invoke_callback() trace.
> > Fix it by moving trace_rcu_callback() before
> > trace_rcu_nocb_try_bypass().
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  kernel/rcu/tree.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 5ec97e3f7468..9fe581be8696 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -2809,10 +2809,7 @@ void call_rcu(struct rcu_head *head, rcu_callback_t func)
> >  	}
> >  
> >  	check_cb_ovld(rdp);
> > -	if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags))
> > -		return; // Enqueued onto ->nocb_bypass, so just leave.
> > -	// If no-CBs CPU gets here, rcu_nocb_try_bypass() acquired ->nocb_lock.
> > -	rcu_segcblist_enqueue(&rdp->cblist, head);
> > +
> >  	if (__is_kvfree_rcu_offset((unsigned long)func))
> >  		trace_rcu_kvfree_callback(rcu_state.name, head,
> >  					 (unsigned long)func,
> > @@ -2821,6 +2818,11 @@ void call_rcu(struct rcu_head *head, rcu_callback_t func)
> >  		trace_rcu_callback(rcu_state.name, head,
> >  				   rcu_segcblist_n_cbs(&rdp->cblist));
> >  
> > +	if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags))
> > +		return; // Enqueued onto ->nocb_bypass, so just leave.
> > +	// If no-CBs CPU gets here, rcu_nocb_try_bypass() acquired ->nocb_lock.
> > +	rcu_segcblist_enqueue(&rdp->cblist, head);
> > +
> >  	trace_rcu_segcb_stats(&rdp->cblist, TPS("SegCBQueued"));
> >  
> >  	/* Go handle any RCU core processing required. */
> 
> Two subtle changes induced here:
> 
> * rcu_segcblist_n_cbs() is now read lockless. It's just tracing so no huge deal
>   but still, if this races with callbacks invocation, we may on some rare occasion
>   read stale numbers on traces while enqueuing (think about rcu_top for example)
> 
> * trace_rcu_callback() will now show the number of callbacks _before_ enqueuing
>   instead of _after_. Not sure if it matters, but sometimes tools rely on trace
>   events.
> 
> To avoid all that, how about a new trace_rcu_nocb_bypass() instead?

Great points, thanks much and you rock. How about something like the
following? That way we don't need to add yet another trace point:

---8<-----------------------

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v2] rcu: Call trace_rcu_callback() also for bypassing

If any CB is queued into the bypass list, then trace_rcu_callback() does
not show it. This makes it not clear when a callback was actually
queued, as you only end up getting a trace_rcu_invoke_callback() trace.
Fix it by calling the tracing function even for bypass queue.

[Frederic: Hold lock while tracing]

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 5ec97e3f7468..85609ccbb8ed 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2728,6 +2728,22 @@ static void check_cb_ovld(struct rcu_data *rdp)
 	raw_spin_unlock_rcu_node(rnp);
 }
 
+/*
+ * Trace RCU callback helper, call after enqueuing callback.
+ * The ->cblist must be locked when called.
+ */
+static void trace_rcu_callback_locked(struct rcu_head *head,
+				      struct rcu_data *rdp)
+{
+	if (__is_kvfree_rcu_offset((unsigned long)head->func))
+		trace_rcu_kvfree_callback(rcu_state.name, head,
+					 (unsigned long)head->func,
+					 rcu_segcblist_n_cbs(&rdp->cblist));
+	else
+		trace_rcu_callback(rcu_state.name, head,
+				   rcu_segcblist_n_cbs(&rdp->cblist));
+}
+
 /**
  * call_rcu() - Queue an RCU callback for invocation after a grace period.
  * @head: structure to be used for queueing the RCU updates.
@@ -2809,17 +2825,14 @@ void call_rcu(struct rcu_head *head, rcu_callback_t func)
 	}
 
 	check_cb_ovld(rdp);
-	if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags))
+
+	if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags)) {
+		trace_rcu_callback_locked(head, rdp);
 		return; // Enqueued onto ->nocb_bypass, so just leave.
+	}
 	// If no-CBs CPU gets here, rcu_nocb_try_bypass() acquired ->nocb_lock.
 	rcu_segcblist_enqueue(&rdp->cblist, head);
-	if (__is_kvfree_rcu_offset((unsigned long)func))
-		trace_rcu_kvfree_callback(rcu_state.name, head,
-					 (unsigned long)func,
-					 rcu_segcblist_n_cbs(&rdp->cblist));
-	else
-		trace_rcu_callback(rcu_state.name, head,
-				   rcu_segcblist_n_cbs(&rdp->cblist));
+	trace_rcu_callback_locked(head, rdp);
 
 	trace_rcu_segcb_stats(&rdp->cblist, TPS("SegCBQueued"));
 
-- 
2.37.3.968.ga6b4b080e4-goog

