Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E3A67A592
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 23:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbjAXWTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 17:19:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234638AbjAXWT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 17:19:28 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845EA474DC
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 14:19:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5390CCE1D1F
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 22:19:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A242C4339B;
        Tue, 24 Jan 2023 22:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674598756;
        bh=E9CEb/Om6Hy+Up6fo1SKkLOPr70TtHVIFf8zMboJk4k=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=cfMDTxFZigirAOrBCijf8moPeieSazr/1wZOIkuhak+YOw0HshUlh8Uz2ThyIZnON
         umBM8v0yDIq7GME5W79//K/UaZOefeQEFwsdVCdhmKb9V529QRut6tf4B8+fMUSNRz
         iCkIl4qxTyk1H0vgrpN5Fjc7/Q4/gR1SgZ8izjr15xJXMfbjGkkznXFOzYVUCULSid
         fC9WRZNvSagoRSCXBbj5IGnXrWlDyl8/NBBkDApzpYAybULrISsJW8Wa/BDS9GpleJ
         Z3hinQaLjR8Bi1OwW8gYzDJraIjETHQQ9mHvpNIrkD1xtzR6jUMoCv+3AT0/LX2/+f
         SeENb0Imv2Yhw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D11005C1183; Tue, 24 Jan 2023 14:19:15 -0800 (PST)
Date:   Tue, 24 Jan 2023 14:19:15 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>, parri.andrea@gmail.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com,
        joel@joelfernandes.org, urezki@gmail.com, quic_neeraju@quicinc.com,
        frederic@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/memory-model Flag suspicious use of srcu cookies
Message-ID: <20230124221915.GW2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230124143951.23372-1-jonas.oberhauser@huaweicloud.com>
 <Y9ATHMm/iVG8goln@rowland.harvard.edu>
 <20230124191535.GT2948950@paulmck-ThinkPad-P17-Gen-1>
 <87b8e8ba-a53d-c3e5-1478-9e6cc2b78fee@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87b8e8ba-a53d-c3e5-1478-9e6cc2b78fee@huaweicloud.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 08:36:53PM +0100, Jonas Oberhauser wrote:
> 
> 
> On 1/24/2023 8:15 PM, Paul E. McKenney wrote:
> > On Tue, Jan 24, 2023 at 12:19:24PM -0500, Alan Stern wrote:
> > > On Tue, Jan 24, 2023 at 03:39:51PM +0100, Jonas Oberhauser wrote:
> > > > The herd model of LKMM deviates from actual implementations in the
> > > > range of cookies that might be returned by srcu_lock() and similar
> > > > functions.  As a consequence, code that relies on srcu_lock()
> > > > returning specific values might pass on the herd model but fail in
> > > > the real world.
> > > > 
> > > > This patch flags any code that looks at the value of a cookie
> > > > without passing it on to an srcu_unlock().  This indicates that the
> > > > cookie value might be being used in ways that can lead herd to
> > > > produce incorrect results, as in the following (contrived) case:
> > > > 
> > > > P0(struct srcu_struct *ss)
> > > > {
> > > > 	int r = srcu_read_lock(ss);
> > > > 	if (r==0)
> > > > 		srcu_read_unlock(ss, r);
> > > > }
> > > > 
> > > > Without this patch, the code passes herd7 without any warnings.
> > > > 
> > > > With this patch, this code is flagged with illegal-srcu-cookie-ctrl,
> > > > indicating that a cookie is used to compute a control condition.
> > > > Such scenarios potentially lead to other branches of the code that
> > > > are possible in real usage not being evaluated by herd7.  In this
> > > > example, this affects the branch where r!=0, which would lead to
> > > > an unmatched read side critical section and thus to hangs of
> > > > synchronize_srcu() calls.
> > > > 
> > > > Besides use of cookies in control conditions, the patch also flags
> > > > use in address computation and any time a cookie is inspected but
> > > > not later passed to srcu_read_unlock().
> > > > 
> > > > Signed-off-by: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
> > > > ---
> > > Acked-by: Alan Stern <stern@rowland.harvard.edu>
> > Thank you both!
> > 
> > I wordsmithed the commit log as follows, but then realized that this
> > depends on Alan's earlier patch.
> 
> Yeah, I don't know if I did this correctly. I based it on the
> lkmm-srcu.2023.01.20a branch.
> Let me know if I should have done this differently.

You got it right.

> Looking through your changes to learn for future submissions:
> 
> > [...]
> > 
> > This patch flags any code that looks at the value of a cookie
> > without passing it on to an srcu_unlock().
> 
> You missed this one : )

No I didn't!  I missed *two*!  ;-)

Though that comment could be Srcu-unlock, I suppose.  But making it
srcu_read_unlock() seems more straightforward.  Update below!

							Thanx, Paul

------------------------------------------------------------------------

From: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
To: paulmck@kernel.org
Cc: stern@rowland.harvard.edu,
	parri.andrea@gmail.com,
	will@kernel.org,
	peterz@infradead.org,
	boqun.feng@gmail.com,
	npiggin@gmail.com,
	dhowells@redhat.com,
	j.alglave@ucl.ac.uk,
	luc.maranget@inria.fr,
	akiyks@gmail.com,
	dlustig@nvidia.com,
	joel@joelfernandes.org,
	urezki@gmail.com,
	quic_neeraju@quicinc.com,
	frederic@kernel.org,
	linux-kernel@vger.kernel.org,
	Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Subject: [PATCH] tools/memory-model Flag suspicious use of srcu cookies
Date: Tue, 24 Jan 2023 15:39:51 +0100

The herd model of LKMM deviates from actual implementations in the
range of cookies that might be returned by srcu_read_lock() and
similar functions.  As a consequence, code that makes special use of
values returned by srcu_read_lock() might pass in herd but fail in the
real world.

This patch flags any code that looks at the value of a cookie without
passing it on to an srcu_read_unlock().  This indicates that the cookie
value might be being used in ways that can lead herd to produce incorrect
results, as in the following (contrived) case:

P0(struct srcu_struct *ss)
{
	int r = srcu_read_lock(ss);
	if (r==0)
		srcu_read_unlock(ss, r);
}

Without this patch, the above code passes herd7 without any warnings.
However, real-world use of this code could result in SRCU grace-period
hangs.

With this patch, this code is flagged with illegal-srcu-cookie-ctrl,
indicating that a cookie is used to compute a control condition.
Real-world use of such code can result in executions that herd7 does
not evaluate.  In this example, when srcu_read_lock() returns a non-zero
value, there is no matching srcu_read_unlock(), which (as noted above)
would result in calls to synchronize_srcu() never returning.

Besides use of cookies in control conditions, the patch also flags use
in address computation and any time a cookie is inspected but not later
passed to srcu_read_unlock().

Signed-off-by: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
---
 tools/memory-model/linux-kernel.bell | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/memory-model/linux-kernel.bell b/tools/memory-model/linux-kernel.bell
index 6e702cda15e1..db5993acc241 100644
--- a/tools/memory-model/linux-kernel.bell
+++ b/tools/memory-model/linux-kernel.bell
@@ -58,7 +58,8 @@ flag ~empty Rcu-unlock \ range(rcu-rscs) as unbalanced-rcu-unlock
 
 (* Compute matching pairs of nested Srcu-lock and Srcu-unlock *)
 let carry-srcu-data = (data ; [~ Srcu-unlock] ; rf)*
-let srcu-rscs = ([Srcu-lock] ; carry-srcu-data ; data ; [Srcu-unlock]) & loc
+let pass-cookie = carry-srcu-data ; data
+let srcu-rscs = ([Srcu-lock] ; pass-cookie ; [Srcu-unlock]) & loc
 
 (* Validate nesting *)
 flag ~empty Srcu-lock \ domain(srcu-rscs) as unbalanced-srcu-lock
@@ -71,6 +72,15 @@ flag ~empty rcu-rscs & (po ; [Sync-srcu] ; po) as invalid-sleep
 (* Validate SRCU dynamic match *)
 flag ~empty different-values(srcu-rscs) as bad-srcu-value-match
 
+(*
+ * Check that srcu cookies are only used for passing to srcu_read_unlock()
+ * Note: this check is only approximate
+ *)
+flag ~empty [Srcu-lock] ; pass-cookie ; rf ;
+	[~ domain(pass-cookie ; [Srcu-unlock])] as suspicious-srcu-cookie-use
+flag ~empty [Srcu-lock] ; carry-srcu-data ; ctrl as illegal-srcu-cookie-ctrl
+flag ~empty [Srcu-lock] ; carry-srcu-data ; addr as illegal-srcu-cookie-addr
+
 (* Compute marked and plain memory accesses *)
 let Marked = (~M) | IW | Once | Release | Acquire | domain(rmw) | range(rmw) |
 		LKR | LKW | UL | LF | RL | RU | Srcu-lock | Srcu-unlock
-- 
2.17.1


