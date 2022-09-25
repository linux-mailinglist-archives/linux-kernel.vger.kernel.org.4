Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0BB35E94EB
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 19:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbiIYRbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 13:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232795AbiIYRbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 13:31:17 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041B72ED79
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 10:31:15 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id y2so2925130qtv.5
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 10:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=6Kuxk8rqToAIi+KWtXYDTt/k1nGpW4B/9707Tr2qqFA=;
        b=A9JGyQ34aMSBbCgPlwGw6UnoxEVJf4nWwXQFt8DQqr2ZRX9k0yyocFBv7R+nwJA5Md
         9bgfO+Ga25JbPzdNvIdhpE4zzPYx9Hy5GybjTS+HXLJ8SMiJvdq9aVQsT5hbe8VSr701
         Iq5KmNUVCZdu1I96FWYf5Y2I+OzNagIbtLrRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=6Kuxk8rqToAIi+KWtXYDTt/k1nGpW4B/9707Tr2qqFA=;
        b=lRPaF6nLq1AhjxnR7DkNUdIOjNhn3WINarm2s/d/RD1tqFL3lncyt3ZQwqnS9PMS9V
         CLDKxWJQJk+ukc4hoDc3wkcWF6jM+PHWc4gE0OBta1TcEU0tbgGYx4QAswqYoO+HOq4F
         ciPJDvwkrW8WkN3/zFKk5sg81LFTEzudKjw2zpGTVXCBDuf8oCDtADiJywlA/qM3x0qT
         pADLg/BWzFCclDy+KNQL3KNOcZOjfdRK6MBFwL81h+YJsy/T3MSrV0rvDIK2az47lHi5
         UUNfrg5fUFJbjt9KyfAHzGy/GV5xroApiWCQA32swzq7vJKI7sBUFxfBkCHSWC8+4jYn
         ee5A==
X-Gm-Message-State: ACrzQf2p297zBMqcp9ZmzLL975mcmt0iuzhNnkhEPg60Z45gzFHdcYYD
        GBLddxUsNoBqpsr8gfwadA+/gg==
X-Google-Smtp-Source: AMsMyM5s891B7uhkODjOz3jQs4qf6gXPhlAMXQH7E9Y86JDEvLQDVFV6B+FTwg+lIJ5Vt2Yiqyu75Q==
X-Received: by 2002:a05:622a:38a:b0:35d:6ca:ff91 with SMTP id j10-20020a05622a038a00b0035d06caff91mr15059197qtx.532.1664127074058;
        Sun, 25 Sep 2022 10:31:14 -0700 (PDT)
Received: from localhost (48.230.85.34.bc.googleusercontent.com. [34.85.230.48])
        by smtp.gmail.com with ESMTPSA id bj36-20020a05620a192400b006ceb8f36302sm10130246qkb.71.2022.09.25.10.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 10:31:13 -0700 (PDT)
Date:   Sun, 25 Sep 2022 17:31:13 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH v6 1/4] rcu: Make call_rcu() lazy to save power
Message-ID: <YzCQYW6yRRBWWMXk@google.com>
References: <20220923214408.GC4196@paulmck-ThinkPad-P17-Gen-1>
 <4AE2CA06-8D91-42D7-9EE5-0C99BA7F9D13@joelfernandes.org>
 <20220924211132.GE4196@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220924211132.GE4196@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

Back to Mutt for this one ;-)

Replies below:

On Sat, Sep 24, 2022 at 02:11:32PM -0700, Paul E. McKenney wrote:
[...]
> > >> +     */
> > >> +    if (lazy && rhp) {
> > >> +        rcu_cblist_flush_enqueue(&rcl, &rdp->nocb_bypass, NULL);
> > >> +        rcu_cblist_enqueue(&rcl, rhp);
> > > 
> > > Would it makes sense to enqueue rhp onto ->nocb_bypass first, NULL out
> > > rhp, then let the rcu_cblist_flush_enqueue() be common code?  Or did this
> > > function grow a later use of rhp that I missed?
> > 
> > No that could be done, but it prefer to keep it this
> >  way because rhp is a function parameter and I
> > prefer not to modify those since it could add a
> > bug in future where rhp passed by user is now
> > NULL for some reason, half way through the
> > function.
> 
> I agree that changing a function parameter is bad practice.
> 
> So the question becomes whether introducing a local would outweigh
> consolidating this code.  Could you please at least give it a shot?
> 
> > >> +        WRITE_ONCE(rdp->lazy_len, 0);
> > >> +    } else {
> > >> +        rcu_cblist_flush_enqueue(&rcl, &rdp->nocb_bypass, rhp);
> > >> +        WRITE_ONCE(rdp->lazy_len, 0);
> > > 
> > > This WRITE_ONCE() can be dropped out of the "if" statement, correct?
> > 
> > Yes will update.
> 
> Thank you!
> 
> > > If so, this could be an "if" statement with two statements in its "then"
> > > clause, no "else" clause, and two statements following the "if" statement.
> > 
> > I don’t think we can get rid of the else part but I’ll see what it looks like.
> 
> In the function header, s/rhp/rhp_in/, then:
> 
> 	struct rcu_head *rhp = rhp_in;
> 
> And then:
> 
> 	if (lazy && rhp) {
> 		rcu_cblist_enqueue(&rdp->nocb_bypass, rhp);
> 		rhp = NULL;

This enqueues on to the bypass list, where as if lazy && rhp, I want to queue
the new rhp on to the main cblist. So the pseudo code in my patch is:

if (lazy and rhp) then
	1. flush bypass CBs on to main list.
	2. queue new CB on to main list.
else
	1. flush bypass CBs on to main list
	2. queue new CB on to bypass list.

> 	}
> 	rcu_cblist_flush_enqueue(&rcl, &rdp->nocb_bypass, rhp);
> 	WRITE_ONCE(rdp->lazy_len, 0);
> 
> Or did I mess something up?

So the rcu_cblist_flush_enqueue() has to happen before the
rcu_cblist_enqueue() to preserve the ordering of flushing into the main list,
and queuing on to the main list for the "if". Where as in your snip, the
order is reversed.

If I consolidate it then, it looks like the following. However, it is a bit
more unreadable. I could instead just take the WRITE_ONCE out of both if/else
and move it to after the if/else, that would be cleanest. Does that sound
good to you? Thanks!

---8<-----------------------

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 1a182b9c4f6c..bd3f54d314e8 100644
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
@@ -348,14 +349,13 @@ static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 	 * If the new CB requested was a lazy one, queue it onto the main
 	 * ->cblist so we can take advantage of a sooner grade period.
 	 */
-	if (lazy && rhp) {
-		rcu_cblist_flush_enqueue(&rcl, &rdp->nocb_bypass, NULL);
-		rcu_cblist_enqueue(&rcl, rhp);
-		WRITE_ONCE(rdp->lazy_len, 0);
-	} else {
-		rcu_cblist_flush_enqueue(&rcl, &rdp->nocb_bypass, rhp);
-		WRITE_ONCE(rdp->lazy_len, 0);
-	}
+	if (lazy && rhp)
+		rhp = NULL;
+	rcu_cblist_flush_enqueue(&rcl, &rdp->nocb_bypass, rhp);
+	if (lazy && rhp_in)
+		rcu_cblist_enqueue(&rcl, rhp_in);
+
+	WRITE_ONCE(rdp->lazy_len, 0);
 
 	rcu_segcblist_insert_pend_cbs(&rdp->cblist, &rcl);
 	WRITE_ONCE(rdp->nocb_bypass_first, j);
