Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD87C6626D3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 14:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234863AbjAINVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 08:21:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237204AbjAINVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 08:21:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D7318C;
        Mon,  9 Jan 2023 05:21:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3FF46105C;
        Mon,  9 Jan 2023 13:21:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8036FC433EF;
        Mon,  9 Jan 2023 13:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673270465;
        bh=A8Z7PC5fQ2LhCYjjgfJ+OrKuPgq9Nqpw7uPlNhfuLeA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NJzKHS0xacz55kBjwSiTEi8rSR3hWX0H3TWY+nYjq5hCm2ir1cXbCdHTLwCVZ3h04
         YoCEt8OTDzpWfBsIaQAQC2VdGT/+/03wicO4wRV3M2nF+EDnzFx64fE8GGb5/MR+xb
         LDjUedYg7jA4aEg0kEV1PADnOYdZ/0K11yQ5HVUh0z867zutCPTrOAQU/3VsStJ6CA
         0IGqIKh+m95e/tQ3d7gKwceTZHW9FD1suEdzcoLajR14xC27FcmYJ/R6ZCweh90Niu
         cs2i0STYqEWOlh/CZ9Ysq18FHlhBKY/FD1r2/1mL/dWfHicU2c10D8kcoNwyzFh3RB
         tmlOPtMcCrEzw==
Date:   Mon, 9 Jan 2023 14:21:01 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Zqiang <qiang1.zhang@intel.com>, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Safe access to rcu_node structure's->exp_tasks
Message-ID: <Y7wUvZ/kVmpxvm14@lothringen>
References: <20221224052553.263199-1-qiang1.zhang@intel.com>
 <20230106034146.GM4028633@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230106034146.GM4028633@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2023 at 07:41:46PM -0800, Paul E. McKenney wrote:
> On Sat, Dec 24, 2022 at 01:25:53PM +0800, Zqiang wrote:
> > For kernels built with CONFIG_PREEMPT_RCU=y, the following scenario
> > can result system oops.
> > 
> >            CPU1                                           CPU2
> > rcu_preempt_deferred_qs_irqrestore                rcu_print_task_exp_stall
> >   if (special.b.blocked)                            READ_ONCE(rnp->exp_tasks) != NULL
> >     raw_spin_lock_rcu_node
> >     np = rcu_next_node_entry(t, rnp)
> >     if (&t->rcu_node_entry == rnp->exp_tasks)
> >       WRITE_ONCE(rnp->exp_tasks, np)
> >       ....
> >       raw_spin_unlock_irqrestore_rcu_node
> >                                                     raw_spin_lock_irqsave_rcu_node
> >                                                     t = list_entry(rnp->exp_tasks->prev,
> >                                                         struct task_struct, rcu_node_entry)
> >                                                     (if rnp->exp_tasks is NULL
> >                                                        will trigger oops)
> > 
> > This problem is that CPU2 accesses rcu_node structure's->exp_tasks
> > without holding the rcu_node structure's ->lock and CPU2 did not
> > observe CPU1's change to rcu_node structure's->exp_tasks in time,
> > if rcu_node structure's->exp_tasks is set null pointer by CPU1, after
> > that CPU2 accesses members of rcu_node structure's->exp_tasks will
> > trigger oops.
> > 
> > This commit therefore allows rcu_node structure's->exp_tasks to be
> > accessed while holding rcu_node structure's ->lock.
> > 
> > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> 
> Apologies for the delay and thank you for the reminder!
> 
> Please check the wordsmithed version below, which I have queued.
> 
> 						Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit 389b0eafd72829fd63548f7ff4e8d6ac90fa1f98
> Author: Zqiang <qiang1.zhang@intel.com>
> Date:   Sat Dec 24 13:25:53 2022 +0800
> 
>     rcu: Protect rcu_print_task_exp_stall() ->exp_tasks access
>     
>     For kernels built with CONFIG_PREEMPT_RCU=y, the following scenario can
>     result in a NULL-pointer dereference:
>     
>                CPU1                                           CPU2
>     rcu_preempt_deferred_qs_irqrestore                rcu_print_task_exp_stall
>       if (special.b.blocked)                            READ_ONCE(rnp->exp_tasks) != NULL
>         raw_spin_lock_rcu_node
>         np = rcu_next_node_entry(t, rnp)
>         if (&t->rcu_node_entry == rnp->exp_tasks)
>           WRITE_ONCE(rnp->exp_tasks, np)
>           ....
>           raw_spin_unlock_irqrestore_rcu_node
>                                                         raw_spin_lock_irqsave_rcu_node
>                                                         t = list_entry(rnp->exp_tasks->prev,
>                                                             struct task_struct, rcu_node_entry)
>                                                         (if rnp->exp_tasks is NULL, this
>                                                            will dereference a NULL pointer)
>     
>     The problem is that CPU2 accesses the rcu_node structure's->exp_tasks
>     field without holding the rcu_node structure's ->lock and CPU2 did
>     not observe CPU1's change to rcu_node structure's ->exp_tasks in time.
>     Therefore, if CPU1 sets rcu_node structure's->exp_tasks pointer to NULL,
>     then CPU2 might dereference that NULL pointer.
>     
>     This commit therefore holds the rcu_node structure's ->lock while
>     accessing that structure's->exp_tasks field.
>     
>     Signed-off-by: Zqiang <qiang1.zhang@intel.com>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index 7cc4856da0817..902e7c8709c7e 100644
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -803,9 +803,11 @@ static int rcu_print_task_exp_stall(struct rcu_node *rnp)
>  	int ndetected = 0;
>  	struct task_struct *t;
>  
> -	if (!READ_ONCE(rnp->exp_tasks))
> -		return 0;
>  	raw_spin_lock_irqsave_rcu_node(rnp, flags);
> +	if (!READ_ONCE(rnp->exp_tasks)) {

Does it have to be READ_ONCE then?

Thanks.

> +		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> +		return 0;
> +	}
>  	t = list_entry(rnp->exp_tasks->prev,
>  		       struct task_struct, rcu_node_entry);
>  	list_for_each_entry_continue(t, &rnp->blkd_tasks, rcu_node_entry) {
