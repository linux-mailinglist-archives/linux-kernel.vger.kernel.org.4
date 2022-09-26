Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5095EB2D2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 23:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbiIZVHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 17:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbiIZVHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 17:07:15 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F127D74BBA
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 14:07:13 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id h21so4943585qta.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 14:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=0wdi4kgudkAb4vWVe47b6KGKTVhagjKJq/jMRG97Bao=;
        b=bcm1YizUgOx35Th41pxQLygSgGQ8jyp6MEye2SGFyVwz0rs4p7kTpWVWULVgx0pGJ9
         h2JsGiknEQLzuCje4vbEfAkZk9pvKZ9EvFitWNH+s8V0Kc8IfpZTe0rbJHyDEz/bUdRM
         /noPBgFOekxAV26cnbFTjfdwChuMZ/LMGa1Sc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=0wdi4kgudkAb4vWVe47b6KGKTVhagjKJq/jMRG97Bao=;
        b=LtczraLe34sGy02l4pCCnftX4IOFtYz+rQmpB0THcFuIpI8bky5CzEwNo2tDIjo1rl
         WWe9HmQ60hR2/E3t6Hw58uKt3iviSzKvwRN5bmxx8iNrTPmLgyVn4uiFtOBfTi3h0s6C
         CNlFU+dl9ZA5sEX8UyDQT1e+XmM9GrtwT4vuZ1CMmbZOXOr7uo9dme2PdWCDp3EzIXO7
         Z4CDFXW1ZJXaEfComwJU7wNEx0FLruBqmd8zkGD4mLZfRvFZUc1KLO8kwZOGeHu536YV
         PstzVycTPD6D76wuiroRripNnUy88BCLIbY65lk6sO586mG8SwoWarxYj8L6TThkChwe
         lpow==
X-Gm-Message-State: ACrzQf1bpHY5JxMX/jrlNUbOLJJCIOJmmMV9bUCfo2+W9JYuI/yQX65S
        HZAsWXtmNjp6YTRRVyZ3H6/V8g==
X-Google-Smtp-Source: AMsMyM6Ldbfr41q0acFWXiqG+4YB40QCxNYIyY5kFPtGDHq+cjlmsifNF1np3zreqFMvVFPgAv7XwQ==
X-Received: by 2002:ac8:5995:0:b0:35c:e39a:176b with SMTP id e21-20020ac85995000000b0035ce39a176bmr19956188qte.567.1664226433088;
        Mon, 26 Sep 2022 14:07:13 -0700 (PDT)
Received: from localhost (48.230.85.34.bc.googleusercontent.com. [34.85.230.48])
        by smtp.gmail.com with ESMTPSA id f6-20020a05620a20c600b006b949afa980sm11656927qka.56.2022.09.26.14.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 14:07:12 -0700 (PDT)
Date:   Mon, 26 Sep 2022 21:07:12 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH v6 1/4] rcu: Make call_rcu() lazy to save power
Message-ID: <YzIUgAMOPg+jBKsp@google.com>
References: <20220923214408.GC4196@paulmck-ThinkPad-P17-Gen-1>
 <4AE2CA06-8D91-42D7-9EE5-0C99BA7F9D13@joelfernandes.org>
 <20220924211132.GE4196@paulmck-ThinkPad-P17-Gen-1>
 <YzCQYW6yRRBWWMXk@google.com>
 <20220926174240.GO4196@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220926174240.GO4196@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Mon, Sep 26, 2022 at 10:42:40AM -0700, Paul E. McKenney wrote:
[..]
> > > > >> +        WRITE_ONCE(rdp->lazy_len, 0);
> > > > >> +    } else {
> > > > >> +        rcu_cblist_flush_enqueue(&rcl, &rdp->nocb_bypass, rhp);
> > > > >> +        WRITE_ONCE(rdp->lazy_len, 0);
> > > > > 
> > > > > This WRITE_ONCE() can be dropped out of the "if" statement, correct?
> > > > 
> > > > Yes will update.
> > > 
> > > Thank you!
> > > 
> > > > > If so, this could be an "if" statement with two statements in its "then"
> > > > > clause, no "else" clause, and two statements following the "if" statement.
> > > > 
> > > > I don’t think we can get rid of the else part but I’ll see what it looks like.
> > > 
> > > In the function header, s/rhp/rhp_in/, then:
> > > 
> > > 	struct rcu_head *rhp = rhp_in;
> > > 
> > > And then:
> > > 
> > > 	if (lazy && rhp) {
> > > 		rcu_cblist_enqueue(&rdp->nocb_bypass, rhp);
> > > 		rhp = NULL;
> > 
> > This enqueues on to the bypass list, where as if lazy && rhp, I want to queue
> > the new rhp on to the main cblist. So the pseudo code in my patch is:
> > 
> > if (lazy and rhp) then
> > 	1. flush bypass CBs on to main list.
> > 	2. queue new CB on to main list.
> 
> And the difference is here, correct?  I enqueue to the bypass list,
> which is then flushed (in order) to the main list.  In contrast, you
> flush the bypass list, then enqueue to the main list.  Either way,
> the callback referenced by rhp ends up at the end of ->cblist.
> 
> Or am I on the wrong branch of this "if" statement?

But we have to flush first, and then queue the new one. Otherwise wouldn't
the callbacks be invoked out of order? Or did I miss something?

> > else
> > 	1. flush bypass CBs on to main list
> > 	2. queue new CB on to bypass list.
> > 
> > > 	}
> > > 	rcu_cblist_flush_enqueue(&rcl, &rdp->nocb_bypass, rhp);
> > > 	WRITE_ONCE(rdp->lazy_len, 0);
> > > 
> > > Or did I mess something up?
> > 
> > So the rcu_cblist_flush_enqueue() has to happen before the
> > rcu_cblist_enqueue() to preserve the ordering of flushing into the main list,
> > and queuing on to the main list for the "if". Where as in your snip, the
> > order is reversed.
> 
> Did I pick the correct branch of the "if" statement above?  Or were you
> instead talking about the "else" clause?
> 
> I would have been more worried about getting cblist->len right.

Hmm, I think my concern was more the ordering of callbacks, and moving the
write to length should be Ok.

> > If I consolidate it then, it looks like the following. However, it is a bit
> > more unreadable. I could instead just take the WRITE_ONCE out of both if/else
> > and move it to after the if/else, that would be cleanest. Does that sound
> > good to you? Thanks!
> 
> Let's first figure out whether or not we are talking past one another.  ;-)

Haha yeah :-)

thanks,

 - Joel


> 
> 							Thanx, Paul
> 
> > ---8<-----------------------
> > 
> > diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> > index 1a182b9c4f6c..bd3f54d314e8 100644
> > --- a/kernel/rcu/tree_nocb.h
> > +++ b/kernel/rcu/tree_nocb.h
> > @@ -327,10 +327,11 @@ static void wake_nocb_gp_defer(struct rcu_data *rdp, int waketype,
> >   *
> >   * Note that this function always returns true if rhp is NULL.
> >   */
> > -static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> > +static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp_in,
> >  				     unsigned long j, unsigned long flush_flags)
> >  {
> >  	struct rcu_cblist rcl;
> > +	struct rcu_head *rhp = rhp_in;
> >  	bool lazy = flush_flags & FLUSH_BP_LAZY;
> >  
> >  	WARN_ON_ONCE(!rcu_rdp_is_offloaded(rdp));
> > @@ -348,14 +349,13 @@ static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> >  	 * If the new CB requested was a lazy one, queue it onto the main
> >  	 * ->cblist so we can take advantage of a sooner grade period.
> >  	 */
> > -	if (lazy && rhp) {
> > -		rcu_cblist_flush_enqueue(&rcl, &rdp->nocb_bypass, NULL);
> > -		rcu_cblist_enqueue(&rcl, rhp);
> > -		WRITE_ONCE(rdp->lazy_len, 0);
> > -	} else {
> > -		rcu_cblist_flush_enqueue(&rcl, &rdp->nocb_bypass, rhp);
> > -		WRITE_ONCE(rdp->lazy_len, 0);
> > -	}
> > +	if (lazy && rhp)
> > +		rhp = NULL;
> > +	rcu_cblist_flush_enqueue(&rcl, &rdp->nocb_bypass, rhp);
> > +	if (lazy && rhp_in)
> > +		rcu_cblist_enqueue(&rcl, rhp_in);
> > +
> > +	WRITE_ONCE(rdp->lazy_len, 0);
> >  
> >  	rcu_segcblist_insert_pend_cbs(&rdp->cblist, &rcl);
> >  	WRITE_ONCE(rdp->nocb_bypass_first, j);
