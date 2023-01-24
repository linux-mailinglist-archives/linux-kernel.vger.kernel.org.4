Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6D167A275
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 20:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234077AbjAXTPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 14:15:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjAXTPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 14:15:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DCF84B76F
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 11:15:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E233C61321
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 19:15:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46494C433EF;
        Tue, 24 Jan 2023 19:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674587736;
        bh=SMDLPhu/DywlnBQbTaniMHkTpiP3Ms5pbX4GkCRe/lA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=G9uYxIZm1trBy+CSL1YKM/GZg8/Lwotb3GatYUj5Et0fPJ/GwfrLjc7Hw98YgXZPO
         mLg+Ih2tpToKFLS0IRQ1VL/Qz4K7IYbO8cu3+uAiIot7qwg2QeysFUeSXg6ileHuWG
         cvRMe86mReZrke3WjH0ZB+ENAwxgH8uPeeValWs7YC+DAoYc1TIKn1YzLJvDaLQHcS
         hVJTpYisgmEhS8Uf3ZP42+hXf37GwSnzarGSCwtAIJfii+uPmDXeeS/VwDyhxTUGYM
         pgPgPDFEp3VLjZgVpw1JCFb8G4dVNUcXKj6aWIO7qabaYr2CDggT2uFU0bpD1VmAe2
         yQhVYoAkhWMRQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D48E15C06D0; Tue, 24 Jan 2023 11:15:35 -0800 (PST)
Date:   Tue, 24 Jan 2023 11:15:35 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
        parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        dlustig@nvidia.com, joel@joelfernandes.org, urezki@gmail.com,
        quic_neeraju@quicinc.com, frederic@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/memory-model Flag suspicious use of srcu cookies
Message-ID: <20230124191535.GT2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230124143951.23372-1-jonas.oberhauser@huaweicloud.com>
 <Y9ATHMm/iVG8goln@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9ATHMm/iVG8goln@rowland.harvard.edu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 12:19:24PM -0500, Alan Stern wrote:
> On Tue, Jan 24, 2023 at 03:39:51PM +0100, Jonas Oberhauser wrote:
> > The herd model of LKMM deviates from actual implementations in the
> > range of cookies that might be returned by srcu_lock() and similar
> > functions.  As a consequence, code that relies on srcu_lock()
> > returning specific values might pass on the herd model but fail in
> > the real world.
> > 
> > This patch flags any code that looks at the value of a cookie
> > without passing it on to an srcu_unlock().  This indicates that the
> > cookie value might be being used in ways that can lead herd to
> > produce incorrect results, as in the following (contrived) case:
> > 
> > P0(struct srcu_struct *ss)
> > {
> > 	int r = srcu_read_lock(ss);
> > 	if (r==0)
> > 		srcu_read_unlock(ss, r);
> > }
> > 
> > Without this patch, the code passes herd7 without any warnings.
> > 
> > With this patch, this code is flagged with illegal-srcu-cookie-ctrl,
> > indicating that a cookie is used to compute a control condition.
> > Such scenarios potentially lead to other branches of the code that
> > are possible in real usage not being evaluated by herd7.  In this
> > example, this affects the branch where r!=0, which would lead to
> > an unmatched read side critical section and thus to hangs of
> > synchronize_srcu() calls.
> > 
> > Besides use of cookies in control conditions, the patch also flags
> > use in address computation and any time a cookie is inspected but
> > not later passed to srcu_read_unlock().
> > 
> > Signed-off-by: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
> > ---
> 
> Acked-by: Alan Stern <stern@rowland.harvard.edu>

Thank you both!

I wordsmithed the commit log as follows, but then realized that this
depends on Alan's earlier patch.

Did I miss the official version?  The latest one I have is
message-id Y8q9zjxA620GAFu2@rowland.harvard.edu.

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

This patch flags any code that looks at the value of a cookie
without passing it on to an srcu_unlock().  This indicates that the
cookie value might be being used in ways that can lead herd to
produce incorrect results, as in the following (contrived) case:

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
+ * Check that srcu cookies are only used for passing to srcu_unlock()
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


