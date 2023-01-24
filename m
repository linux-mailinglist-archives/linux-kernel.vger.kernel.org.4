Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D940B679FFE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 18:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234791AbjAXRT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 12:19:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234780AbjAXRT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 12:19:26 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id B7B294AA68
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 09:19:24 -0800 (PST)
Received: (qmail 173859 invoked by uid 1000); 24 Jan 2023 12:19:24 -0500
Date:   Tue, 24 Jan 2023 12:19:24 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc:     paulmck@kernel.org, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
        urezki@gmail.com, quic_neeraju@quicinc.com, frederic@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/memory-model Flag suspicious use of srcu cookies
Message-ID: <Y9ATHMm/iVG8goln@rowland.harvard.edu>
References: <20230124143951.23372-1-jonas.oberhauser@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124143951.23372-1-jonas.oberhauser@huaweicloud.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 03:39:51PM +0100, Jonas Oberhauser wrote:
> The herd model of LKMM deviates from actual implementations in the
> range of cookies that might be returned by srcu_lock() and similar
> functions.  As a consequence, code that relies on srcu_lock()
> returning specific values might pass on the herd model but fail in
> the real world.
> 
> This patch flags any code that looks at the value of a cookie
> without passing it on to an srcu_unlock().  This indicates that the
> cookie value might be being used in ways that can lead herd to
> produce incorrect results, as in the following (contrived) case:
> 
> P0(struct srcu_struct *ss)
> {
> 	int r = srcu_read_lock(ss);
> 	if (r==0)
> 		srcu_read_unlock(ss, r);
> }
> 
> Without this patch, the code passes herd7 without any warnings.
> 
> With this patch, this code is flagged with illegal-srcu-cookie-ctrl,
> indicating that a cookie is used to compute a control condition.
> Such scenarios potentially lead to other branches of the code that
> are possible in real usage not being evaluated by herd7.  In this
> example, this affects the branch where r!=0, which would lead to
> an unmatched read side critical section and thus to hangs of
> synchronize_srcu() calls.
> 
> Besides use of cookies in control conditions, the patch also flags
> use in address computation and any time a cookie is inspected but
> not later passed to srcu_read_unlock().
> 
> Signed-off-by: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
> ---

Acked-by: Alan Stern <stern@rowland.harvard.edu>

>  tools/memory-model/linux-kernel.bell | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/memory-model/linux-kernel.bell b/tools/memory-model/linux-kernel.bell
> index 6e702cda15e1..db5993acc241 100644
> --- a/tools/memory-model/linux-kernel.bell
> +++ b/tools/memory-model/linux-kernel.bell
> @@ -58,7 +58,8 @@ flag ~empty Rcu-unlock \ range(rcu-rscs) as unbalanced-rcu-unlock
>  
>  (* Compute matching pairs of nested Srcu-lock and Srcu-unlock *)
>  let carry-srcu-data = (data ; [~ Srcu-unlock] ; rf)*
> -let srcu-rscs = ([Srcu-lock] ; carry-srcu-data ; data ; [Srcu-unlock]) & loc
> +let pass-cookie = carry-srcu-data ; data
> +let srcu-rscs = ([Srcu-lock] ; pass-cookie ; [Srcu-unlock]) & loc
>  
>  (* Validate nesting *)
>  flag ~empty Srcu-lock \ domain(srcu-rscs) as unbalanced-srcu-lock
> @@ -71,6 +72,15 @@ flag ~empty rcu-rscs & (po ; [Sync-srcu] ; po) as invalid-sleep
>  (* Validate SRCU dynamic match *)
>  flag ~empty different-values(srcu-rscs) as bad-srcu-value-match
>  
> +(*
> + * Check that srcu cookies are only used for passing to srcu_unlock()
> + * Note: this check is only approximate
> + *)
> +flag ~empty [Srcu-lock] ; pass-cookie ; rf ;
> +	[~ domain(pass-cookie ; [Srcu-unlock])] as suspicious-srcu-cookie-use
> +flag ~empty [Srcu-lock] ; carry-srcu-data ; ctrl as illegal-srcu-cookie-ctrl
> +flag ~empty [Srcu-lock] ; carry-srcu-data ; addr as illegal-srcu-cookie-addr
> +
>  (* Compute marked and plain memory accesses *)
>  let Marked = (~M) | IW | Once | Release | Acquire | domain(rmw) | range(rmw) |
>  		LKR | LKW | UL | LF | RL | RU | Srcu-lock | Srcu-unlock
> -- 
> 2.17.1
> 
