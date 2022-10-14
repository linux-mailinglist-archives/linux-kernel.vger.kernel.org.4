Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6553A5FF072
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 16:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiJNOjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 10:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiJNOjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 10:39:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B14F1D4DE7;
        Fri, 14 Oct 2022 07:39:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 071EFB82355;
        Fri, 14 Oct 2022 14:39:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6641FC433C1;
        Fri, 14 Oct 2022 14:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665758339;
        bh=+/LWxZHh5+rRSm5v/5u0km05gGmDmFBODsWnb/6k6tU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=P08OpAutKf29WIlDc5S/eE47g3hC3PMTlRUK4Ui5gqyEfdcNbIQSl6Zn4Z/9XfIOj
         eU8iHpgP12yvQLG69GZhFOZJIO9VcWaCV+WoATpkYOWO5vQtk5TysceSXi+NOuJ1kL
         /BYV4LilxplMG94gGFYBEbVPEP3S/9ve97/ceeM1BD72RnwMiBsSmmmDUSwo/xWWJU
         1v8ts9lprfm0MD3Tvdj4gln1ekMUmRYeBZ/2EGmX+Prbka2gKZYx96YsNasl6DkhNR
         3mDuFKUMCNgqD+SRmKAhNb/zKn6Egx3TXZeGn46HP4/ittlnGB11L4/0hXVaDncRZo
         0uHPuriTKWoVQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 49EB05C32BF; Fri, 14 Oct 2022 07:38:56 -0700 (PDT)
Date:   Fri, 14 Oct 2022 07:38:56 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Zqiang <qiang1.zhang@intel.com>, frederic@kernel.org,
        quic_neeraju@quicinc.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Fix use __this_cpu_read() warning in preemptible
 code
Message-ID: <20221014143856.GF4221@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221013044148.2894320-1-qiang1.zhang@intel.com>
 <Y0gxQQzLdJLOp7wI@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0gxQQzLdJLOp7wI@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2022 at 03:39:45PM +0000, Joel Fernandes wrote:
> On Thu, Oct 13, 2022 at 12:41:48PM +0800, Zqiang wrote:
> > BUG: using __this_cpu_read() in preemptible [00000000]
> > code: rcu_torture_fqs/398
> > caller is __this_cpu_preempt_check+0x13/0x20
> > CPU: 3 PID: 398 Comm: rcu_torture_fqs Not tainted 6.0.0-rc1-yoctodev-standard+
> > Call Trace:
> > <TASK>
> > dump_stack_lvl+0x5b/0x86
> > dump_stack+0x10/0x16
> > check_preemption_disabled+0xe5/0xf0
> > __this_cpu_preempt_check+0x13/0x20
> > rcu_force_quiescent_state.part.0+0x1c/0x170
> > rcu_force_quiescent_state+0x1e/0x30
> > rcu_torture_fqs+0xca/0x160
> > ? rcu_torture_boost+0x430/0x430
> > kthread+0x192/0x1d0
> > ? kthread_complete_and_exit+0x30/0x30
> > ret_from_fork+0x22/0x30
> > </TASK>
> > 
> > When enable rcutorture.fqs_duration, the rcu_force_quiescent_state() be
> > invoked in rcu_torture_fqs task context, invoke __this_cpu_read() in
> > preemptible code section will trigger the above calltrace.
> 
> Makes sense, so in theory the GP thread might get migrated after sampling
> rcu_data.mynode but that's Ok since it wont change the behavior of the code
> following it AFAICS.
> 
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Thank you!  I will apply this on the next rebase.

							Thanx, Paul

> thanks,
> 
>  - Joel
> 
> > This commit convert __this_cpu_read() to raw_cpu_read() to avoid
> > this warning.
> > 
> > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > ---
> >  kernel/rcu/tree.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 96d678c9cfb6..282002e62cf3 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -2436,7 +2436,7 @@ void rcu_force_quiescent_state(void)
> >  	struct rcu_node *rnp_old = NULL;
> >  
> >  	/* Funnel through hierarchy to reduce memory contention. */
> > -	rnp = __this_cpu_read(rcu_data.mynode);
> > +	rnp = raw_cpu_read(rcu_data.mynode);
> >  	for (; rnp != NULL; rnp = rnp->parent) {
> >  		ret = (READ_ONCE(rcu_state.gp_flags) & RCU_GP_FLAG_FQS) ||
> >  		       !raw_spin_trylock(&rnp->fqslock);
> > -- 
> > 2.25.1
> > 
