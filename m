Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E0E6D867E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 21:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234432AbjDETEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 15:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232950AbjDETEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 15:04:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899612724;
        Wed,  5 Apr 2023 12:04:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C1DC627F1;
        Wed,  5 Apr 2023 19:04:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73F8EC433D2;
        Wed,  5 Apr 2023 19:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680721444;
        bh=e4c27EW3p/fchHHTLKK42Yf7bC/xrI/7ZxdOW3nfM9Y=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=da5fuIPsJ0s9oWr938Ig4+fQ2XUwGiOoanj6S82Wqe4CUXULTYHLGowqQkn9UYI49
         FiIoefGyr4gqmGYT5x0rMQNRBnBw6jSeqkSvPniUJWVokz8bUCc/bPBD6ujb8IjN5T
         37mif5ljtdRlDLbWmBp1hafcsmsECmkCuBiyGb6uu4VmBLFXxiLz/JCgFqhOtZ3GPz
         1DRTHkhVJmlJRcCVMiTW5RTgCtt7guYKEjl7QOO6Vdwn819OsXuKZj4iKla086naI1
         CDEsHMsN//xaxBDkzaR8m4gVZxOYQXdN13g7q8pRrs8arJbGbyu6+XYbitczpAFxjS
         g5jV5xRB7ys+A==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 05E4115404B4; Wed,  5 Apr 2023 12:04:04 -0700 (PDT)
Date:   Wed, 5 Apr 2023 12:04:03 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Zqiang <qiang1.zhang@intel.com>, frederic@kernel.org,
        joel@joelfernandes.org, qiang.zhang1211@gmail.com,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu/kvfree: Invoke debug_rcu_bhead_unqueue() with check
 bnode->snap is done
Message-ID: <bb56bb43-fc3e-42fd-9bdb-78e70a400daf@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230405021359.606321-1-qiang1.zhang@intel.com>
 <ZC2Jh6CaeHHpkWLW@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZC2Jh6CaeHHpkWLW@pc636>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2023 at 04:45:27PM +0200, Uladzislau Rezki wrote:
> On Wed, Apr 05, 2023 at 10:13:59AM +0800, Zqiang wrote:
> > This commit make debug_rcu_bhead_unqueue() be invoked with check
> > the bnode structure's->snap is done in kvfree_rcu_bulk().
> > 
> > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > ---
> >  kernel/rcu/tree.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 3461fc2640b9..17b5d115aec1 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -2943,8 +2943,8 @@ kvfree_rcu_bulk(struct kfree_rcu_cpu *krcp,
> >  	unsigned long flags;
> >  	int i;
> >  
> > -	debug_rcu_bhead_unqueue(bnode);
> >  	if (!WARN_ON_ONCE(!poll_state_synchronize_rcu_full(&bnode->gp_snap))) {
> > +		debug_rcu_bhead_unqueue(bnode);
> >  		rcu_lock_acquire(&rcu_callback_map);
> >  		if (idx == 0) { // kmalloc() / kfree().
> >  			trace_rcu_invoke_kfree_bulk_callback(
> > -- 
> > 2.32.0
> >
> Since we leak, looks like correct to me:
> 
> Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Queued for v6.5, thank you both!

							Thanx, Paul
