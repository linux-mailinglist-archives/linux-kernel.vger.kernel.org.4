Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE92E6A219F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 19:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjBXSiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 13:38:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjBXSiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 13:38:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B9B193D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 10:37:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8025461965
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 18:37:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA517C433EF;
        Fri, 24 Feb 2023 18:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677263878;
        bh=TC98hb+qk7hO+lq27ShJ3rKwrFkLj/D1f5ociwnE7XU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=idmmN9RvbSDJWLCDZyaagXwM9K6aXCW7PW1s8890ib9vIikoQGjzfoF6F75/GWapV
         19m0le2CE7Tt5asT9OeDiX3okgUKboi5RH3bxgnUgl9wwB08hX9HxsQ+JEWxSy9yh3
         j5IOf0DkeQBi5SsdUKSqt7ALa4W5Ds070/tHMa7CU1j8O42W9bvoQyZ3QXKcL0q7r7
         x1Vb/HOo7G5yatHdqAH6Tn6lFzlViACsyjGZfXtEXkKpvg0QIf1k2T7zkQTYMhLXMe
         niBi4vCv1OZ3nRJWhnI5lAY4QStMSxrmp1NCwWVgRQ82BFAMirw7ajYC7pnZ5q6MKk
         nlvVT3eQ9ag5w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6AE955C0BE7; Fri, 24 Feb 2023 10:37:58 -0800 (PST)
Date:   Fri, 24 Feb 2023 10:37:58 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        dlustig@nvidia.com, joel@joelfernandes.org, urezki@gmail.com,
        quic_neeraju@quicinc.com, frederic@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] tools/memory-model: Make ppo a subrelation of po
Message-ID: <20230224183758.GQ2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230224135251.24989-1-jonas.oberhauser@huaweicloud.com>
 <Y/jYm0AZfPHkIalK@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/jYm0AZfPHkIalK@rowland.harvard.edu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 10:32:43AM -0500, Alan Stern wrote:
> On Fri, Feb 24, 2023 at 02:52:51PM +0100, Jonas Oberhauser wrote:
> > As stated in the documentation and implied by its name, the ppo
> > (preserved program order) relation is intended to link po-earlier
> > to po-later instructions under certain conditions.  However, a
> > corner case currently allows instructions to be linked by ppo that
> > are not executed by the same thread, i.e., instructions are being
> > linked that have no po relation.
> > 
> > This happens due to the mb/strong-fence/fence relations, which (as
> > one case) provide order when locks are passed between threads
> > followed by an smp_mb__after_unlock_lock() fence.  This is
> > illustrated in the following litmus test (as can be seen when using
> > herd7 with `doshow ppo`):
> > 
> > P0(int *x, int *y)
> > {
> >     spin_lock(x);
> >     spin_unlock(x);
> > }
> > 
> > P1(int *x, int *y)
> > {
> >     spin_lock(x);
> >     smp_mb__after_unlock_lock();
> >     *y = 1;
> > }
> > 
> > The ppo relation will link P0's spin_lock(x) and P1's *y=1, because
> > P0 passes a lock to P1 which then uses this fence.
> > 
> > The patch makes ppo a subrelation of po by letting fence contribute
> > to ppo only in case the fence links events of the same thread.
> > 
> > Signed-off-by: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
> > ---
> >  tools/memory-model/linux-kernel.cat | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
> > index cfc1b8fd46da..adf3c4f41229 100644
> > --- a/tools/memory-model/linux-kernel.cat
> > +++ b/tools/memory-model/linux-kernel.cat
> > @@ -82,7 +82,7 @@ let rwdep = (dep | ctrl) ; [W]
> >  let overwrite = co | fr
> >  let to-w = rwdep | (overwrite & int) | (addr ; [Plain] ; wmb)
> >  let to-r = (addr ; [R]) | (dep ; [Marked] ; rfi)
> > -let ppo = to-r | to-w | fence | (po-unlock-lock-po & int)
> > +let ppo = to-r | to-w | (fence & int) | (po-unlock-lock-po & int)
> >  
> >  (* Propagation: Ordering from release operations and strong fences. *)
> >  let A-cumul(r) = (rfe ; [Marked])? ; r
> 
> Acked-by: Alan Stern <stern@rowland.harvard.edu>

Queued for the v6.4 merge window (not the current one), thank you both!

							Thanx, Paul
