Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278505F3657
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 21:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiJCTd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 15:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiJCTd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 15:33:27 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06AF32B87
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 12:33:25 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id h28so7196811qka.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 12:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=lePyiPmExw2KXDKLG4cjFyFtMKGQ7Xh/iY5XHQgEblM=;
        b=Hix8xlvPddCvgw5Xssbvx7WB9VeTI5KtJ60Z5HYe2chYZGRc+G6N3XiCcWKHaSfcCr
         H3uDEVqbcLlLvRLbVhJOEol29uKyQQMQt+ZvKV9NDFpUkyAaHUd46YrmTYUjz2uDn23c
         0jTd3jn1EXwovgjLYZqa0jAAHF4KEpTEKD8hE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=lePyiPmExw2KXDKLG4cjFyFtMKGQ7Xh/iY5XHQgEblM=;
        b=TRMBp+yij0GfEfM3NuG+u8s5AASiEnqPXCc0V/MO5eKbHCBRsxYMCI+pIu+pdoyqnV
         Me8woIhuhDw6gAdMU1LHlifpmeXx4MddiRqvXOR9f7kZ7oHySP2tMEyDbiq+/0RfXWya
         5OSDSyarslFsvPBOZlZNhrKIdyeP3h0cjvQb7kDLlVwNt7AJfhw0krJvTlpuX0Kbw2tu
         NWz22ekR2Pwx/VvShWxkQqjFPbepIWq35Vh1+gbg7PT9tBuHnEpAydQSi0rv6eSD4GpJ
         kJaT2j8xIeIL2GNe8w5h5tvPSJsR4hbiH2iS74a3gnUu5gidzo++VDoHtaPVhElJ83Dj
         jnHA==
X-Gm-Message-State: ACrzQf1T2MMKTj0VYws2EuyNjz97r0TU6wrhZZ0juHsXk+OVpao/kNSn
        uvjW8wKArfOZ8/1nfN1uyY20fg==
X-Google-Smtp-Source: AMsMyM4x1vu03fABOw+7AgXbm+NGOfbucLk7z0++XMPW3+25p56r5ZQyaRpY3kmMr2XTNyxdif85Iw==
X-Received: by 2002:a05:620a:284b:b0:6b4:8685:2aa6 with SMTP id h11-20020a05620a284b00b006b486852aa6mr14871945qkp.780.1664825605062;
        Mon, 03 Oct 2022 12:33:25 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id bn1-20020a05620a2ac100b006cede93c765sm11773062qkb.28.2022.10.03.12.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 12:33:24 -0700 (PDT)
Date:   Mon, 3 Oct 2022 19:33:24 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH v6 1/4] rcu: Make call_rcu() lazy to save power
Message-ID: <Yzs5BC4SSM1A3BTO@google.com>
References: <20220926223751.GZ4196@paulmck-ThinkPad-P17-Gen-1>
 <A78761F4-5922-418A-AFA3-01101C399778@joelfernandes.org>
 <20220926235351.GC4196@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220926235351.GC4196@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 04:53:51PM -0700, Paul E. McKenney wrote:
> On Mon, Sep 26, 2022 at 07:33:17PM -0400, Joel Fernandes wrote:
> > 
> > 
> > > On Sep 26, 2022, at 6:37 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > 
> > > ﻿On Mon, Sep 26, 2022 at 09:07:12PM +0000, Joel Fernandes wrote:
> > >> Hi Paul,
> > >> 
> > >> On Mon, Sep 26, 2022 at 10:42:40AM -0700, Paul E. McKenney wrote:
> > >> [..]
> > >>>>>>>> +        WRITE_ONCE(rdp->lazy_len, 0);
> > >>>>>>>> +    } else {
> > >>>>>>>> +        rcu_cblist_flush_enqueue(&rcl, &rdp->nocb_bypass, rhp);
> > >>>>>>>> +        WRITE_ONCE(rdp->lazy_len, 0);
> > >>>>>>> 
> > >>>>>>> This WRITE_ONCE() can be dropped out of the "if" statement, correct?
> > >>>>>> 
> > >>>>>> Yes will update.
> > >>>>> 
> > >>>>> Thank you!
> > >>>>> 
> > >>>>>>> If so, this could be an "if" statement with two statements in its "then"
> > >>>>>>> clause, no "else" clause, and two statements following the "if" statement.
> > >>>>>> 
> > >>>>>> I don’t think we can get rid of the else part but I’ll see what it looks like.
> > >>>>> 
> > >>>>> In the function header, s/rhp/rhp_in/, then:
> > >>>>> 
> > >>>>>    struct rcu_head *rhp = rhp_in;
> > >>>>> 
> > >>>>> And then:
> > >>>>> 
> > >>>>>    if (lazy && rhp) {
> > >>>>>        rcu_cblist_enqueue(&rdp->nocb_bypass, rhp);
> > >>>>>        rhp = NULL;
> > >>>> 
> > >>>> This enqueues on to the bypass list, where as if lazy && rhp, I want to queue
> > >>>> the new rhp on to the main cblist. So the pseudo code in my patch is:
> > >>>> 
> > >>>> if (lazy and rhp) then
> > >>>>    1. flush bypass CBs on to main list.
> > >>>>    2. queue new CB on to main list.
> > >>> 
> > >>> And the difference is here, correct?  I enqueue to the bypass list,
> > >>> which is then flushed (in order) to the main list.  In contrast, you
> > >>> flush the bypass list, then enqueue to the main list.  Either way,
> > >>> the callback referenced by rhp ends up at the end of ->cblist.
> > >>> 
> > >>> Or am I on the wrong branch of this "if" statement?
> > >> 
> > >> But we have to flush first, and then queue the new one. Otherwise wouldn't
> > >> the callbacks be invoked out of order? Or did I miss something?
> > > 
> > > I don't think so...
> > > 
> > > We want the new callback to be last, right?  One way to do that is to
> > > flush the bypass, then queue the new callback onto ->cblist.  Another way
> > > to do that is to enqueue the new callback onto the end of the bypass,
> > > then flush the bypass.  Why wouldn't these result in the same order?
> > 
> > Yes you are right, sorry. I was fixated on the main list. Both your snippet and my patch will be equivalent then. However I find your snippet a bit confusing, as in it is not immediately obvious - why would we queue something on to a list, if we were about to flush it. But any way, it does make it a clever piece of code in some sense and I am ok with doing it this way ;-)
> 
> As long as the ->cblist.len comes out with the right value.  ;-)

The ->cblist.len's value is not effected by your suggested change, because
the bypass list's length is already accounted into the ->cblist.len, and for
the new rhp, after rcu_nocb_do_flush_bypass() is called, it either ends up in
the bypass list (if it is !lazy) or on the main cblist (if its lazy). So
everything just works. Below is the change. If its OK with you though, I will
put it in a separate commit just to be extra safe, since the code before it
was well tested and I am still testing it.

Thanks.

---8<-----------------------

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH] rcu: Refactor code a bit in rcu_nocb_do_flush_bypass()

This consolidates the code a bit and makes it cleaner. Functionally it
is the same.

Reported-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree_nocb.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index d69d058a78f9..1fc704d102a3 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -327,10 +327,11 @@ static void wake_nocb_gp_defer(struct rcu_data *rdp, int waketype,
  *
  * Note that this function always returns true if rhp is NULL.
  */
-static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
+static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp_in,
 				     unsigned long j, unsigned long flush_flags)
 {
 	struct rcu_cblist rcl;
+	struct rcu_head *rhp = rhp_in;
 	bool lazy = flush_flags & FLUSH_BP_LAZY;
 
 	WARN_ON_ONCE(!rcu_rdp_is_offloaded(rdp));
@@ -347,16 +348,15 @@ static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 	/*
 	 * If the new CB requested was a lazy one, queue it onto the main
 	 * ->cblist so that we can take advantage of the grace-period that will
-	 * happen regardless.
+	 * happen regardless. But queue it onto the bypass list first so that
+	 * the lazy CB is ordered with the existing CBs in the bypass list.
 	 */
 	if (lazy && rhp) {
-		rcu_cblist_flush_enqueue(&rcl, &rdp->nocb_bypass, NULL);
-		rcu_cblist_enqueue(&rcl, rhp);
-		WRITE_ONCE(rdp->lazy_len, 0);
-	} else {
-		rcu_cblist_flush_enqueue(&rcl, &rdp->nocb_bypass, rhp);
-		WRITE_ONCE(rdp->lazy_len, 0);
+		rcu_cblist_enqueue(&rdp->nocb_bypass, rhp);
+		rhp = NULL;
 	}
+	rcu_cblist_flush_enqueue(&rcl, &rdp->nocb_bypass, rhp);
+	WRITE_ONCE(rdp->lazy_len, 0);
 
 	rcu_segcblist_insert_pend_cbs(&rdp->cblist, &rcl);
 	WRITE_ONCE(rdp->nocb_bypass_first, j);
-- 
2.38.0.rc1.362.ged0d419d3c-goog

