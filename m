Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48AB967D1C5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 17:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbjAZQg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 11:36:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbjAZQgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 11:36:25 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 2D6AD6F204
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 08:36:09 -0800 (PST)
Received: (qmail 265554 invoked by uid 1000); 26 Jan 2023 11:36:08 -0500
Date:   Thu, 26 Jan 2023 11:36:08 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc:     paulmck@kernel.org, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
        urezki@gmail.com, quic_neeraju@quicinc.com, frederic@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] tools/memory-model: Make ppo a subrelation of po
Message-ID: <Y9Kr+GntQyGKPH3K@rowland.harvard.edu>
References: <20230126134604.2160-1-jonas.oberhauser@huaweicloud.com>
 <20230126134604.2160-3-jonas.oberhauser@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126134604.2160-3-jonas.oberhauser@huaweicloud.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 02:46:04PM +0100, Jonas Oberhauser wrote:
> As stated in the documentation and implied by its name, the ppo
> (preserved program order) relation is intended to link po-earlier
> to po-later instructions under certain conditions.  However, a
> corner case currently allows instructions to be linked by ppo that
> are not executed by the same thread, i.e., instructions are being
> linked that have no po relation.
> 
> This happens due to the mb/strong-fence relations, which (as one
> case) provide order when locks are passed between threads followed
> by an smp_mb__after_unlock_lock() fence.  This is illustrated in
> the following litmus test (as can be seen when using herd7 with
> `doshow ppo`):
> 
> P0(int *x, int *y)
> {
>     spin_lock(x);
>     spin_unlock(x);
> }
> 
> P1(int *x, int *y)
> {
>     spin_lock(x);
>     smp_mb__after_unlock_lock();
>     *y = 1;
> }
> 
> The ppo relation will link P0's spin_lock(x) and P1's *y=1, because
> P0 passes a lock to P1 which then uses this fence.
> 
> The patch makes ppo a subrelation of po by eliminating this possibility
> from mb (but not strong-fence) and relying explicitly on mb|gp instead
> of strong-fence when defining ppo.
> 
> Signed-off-by: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
> ---

This changes the meaning of the fence relation, which is used in 
w-pre-bounded, w-post-bounded, ww-vis, wr-vis, and rw-xbstar.  Have you 
checked that they won't be affected by the change?

>  tools/memory-model/linux-kernel.cat | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
> index 6e531457bb73..815fdafacaef 100644
> --- a/tools/memory-model/linux-kernel.cat
> +++ b/tools/memory-model/linux-kernel.cat
> @@ -36,7 +36,9 @@ let wmb = [W] ; fencerel(Wmb) ; [W]
>  let mb = ([M] ; fencerel(Mb) ; [M]) |
>  	([M] ; fencerel(Before-atomic) ; [RMW] ; po? ; [M]) |
>  	([M] ; po? ; [RMW] ; fencerel(After-atomic) ; [M]) |
> -	([M] ; po? ; [LKW] ; fencerel(After-spinlock) ; [M]) |
> +	([M] ; po? ; [LKW] ; fencerel(After-spinlock) ; [M])
> +let gp = po ; [Sync-rcu | Sync-srcu] ; po?
> +let strong-fence = mb | gp |
>  (*
>   * Note: The po-unlock-lock-po relation only passes the lock to the direct
>   * successor, perhaps giving the impression that the ordering of the
> @@ -50,10 +52,9 @@ let mb = ([M] ; fencerel(Mb) ; [M]) |
>   *)
>  	([M] ; po-unlock-lock-po ;
>  		[After-unlock-lock] ; po ; [M])
> -let gp = po ; [Sync-rcu | Sync-srcu] ; po?
> -let strong-fence = mb | gp
>  
> -let nonrw-fence = strong-fence | po-rel | acq-po
> +

Extra blank line.

> +let nonrw-fence = mb | gp | po-rel | acq-po
>  let fence = nonrw-fence | wmb | rmb
>  let barrier = fencerel(Barrier | Rmb | Wmb | Mb | Sync-rcu | Sync-srcu |
>  		Before-atomic | After-atomic | Acquire | Release |
> -- 
> 2.17.1

Alan
