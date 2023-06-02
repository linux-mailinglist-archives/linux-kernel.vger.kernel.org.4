Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C924720C0F
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 00:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236454AbjFBWvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 18:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234860AbjFBWvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 18:51:09 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF9071BB
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 15:51:04 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-3f7f864525fso26620771cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 15:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1685746264; x=1688338264;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TKh7G4ng+3UxG9GlKhZFKNP2hqzFVCli3no9g2iTE4Q=;
        b=h2rPZeajkV6A9NKcRy8lAuwN4jb7qbuRKd70KeMC3t07qkHw6F5W0zF/PdCrjT9tAH
         AhIcGnaeJ+jdBFtdrt8g6Cs22cMYOgR/wC5UNczlXDFrsDOl0BBcg6JCXYNOcXBfOsAP
         AKAyLmPMn3WKvrpjK8XkeMaLoZv4EbtFbq6rg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685746264; x=1688338264;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TKh7G4ng+3UxG9GlKhZFKNP2hqzFVCli3no9g2iTE4Q=;
        b=cowcTDCYRTnWA8RCt5iykG+eDI1JVQE2o+1r7+//XKSCkPPDLT3jCmVbbVmy2A9pzU
         Zec6NJkYPLisG5hRkFzkCegegVuijECno+nOVx9cdY4waRdjn3WX2J2iCd5G4CImA9xm
         6v15KnzFOF8tW8eWqt7/1YI2AOXp9Y557NMv36fzlB+rd1t4exqN61x/lbCS8TBJWrl8
         0U6XO5ZscvvGHs60ACYdr2HLIUb2HoB31n9JYLPu0clDUJpOxT8asWpwciI7QYsG8+Dg
         1kB7SlV2+Dc6S9feyrtLT0/ysCtym1s3nrDxTTDsuuwtxPko+VJ5i8vdXH86mjQKd3ZS
         qqGA==
X-Gm-Message-State: AC+VfDxrp964J6PEyAEWljblBNBkVzeYls/fwDU5GrA8sqMapMX9yJT0
        mkLfZFThDFj21n7vshjsy7VLvg==
X-Google-Smtp-Source: ACHHUZ6z+Qm7ezl/VndW9Nq6+fcUGMGGerFi0l9dMXOr6xPvw+iXH4gyeaGERV3yYI7CUWlMICIOEw==
X-Received: by 2002:a05:622a:355:b0:3f6:c5cd:dc5e with SMTP id r21-20020a05622a035500b003f6c5cddc5emr18316573qtw.23.1685746263995;
        Fri, 02 Jun 2023 15:51:03 -0700 (PDT)
Received: from localhost (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id e6-20020a05622a110600b003f7a54fa72fsm1390379qty.0.2023.06.02.15.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 15:51:03 -0700 (PDT)
Date:   Fri, 2 Jun 2023 22:51:02 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Subject: Re: [PATCH 1/9] rcu: Assume IRQS disabled from rcu_report_dead()
Message-ID: <20230602225102.GA2756690@google.com>
References: <20230531101736.12981-1-frederic@kernel.org>
 <20230531101736.12981-2-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531101736.12981-2-frederic@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 12:17:28PM +0200, Frederic Weisbecker wrote:
> rcu_report_dead() is the last RCU word from the CPU down through the
> hotplug path. It is called in the idle loop right before the CPU shuts
> down for good. Because it removes the CPU from the grace period state
> machine and reports an ultimate quiescent state if necessary, no further
> use of RCU is allowed. Therefore it is expected that IRQs are disabled
> upon calling this function and are not to be re-enabled again until the
> CPU shuts down.
> 
> Remove the IRQs disablement from that function and verify instead that
> it is actually called with IRQs disabled as it is expected at that
> special point in the idle path.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  kernel/rcu/tree.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index fae9b4e29c93..bc4e7c9b51cb 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -4476,11 +4476,16 @@ void rcu_cpu_starting(unsigned int cpu)
>   */
>  void rcu_report_dead(unsigned int cpu)
>  {
> -	unsigned long flags, seq_flags;
> +	unsigned long flags;
>  	unsigned long mask;
>  	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
>  	struct rcu_node *rnp = rdp->mynode;  /* Outgoing CPU's rdp & rnp. */
>  
> +	/*
> +	 * IRQS must be disabled from now on and until the CPU dies, or an interrupt
> +	 * may introduce a new READ-side while it is actually off the QS masks.
> +	 */
> +	lockdep_assert_irqs_disabled();
>  	// Do any dangling deferred wakeups.
>  	do_nocb_deferred_wakeup(rdp);
>  
> @@ -4488,7 +4493,6 @@ void rcu_report_dead(unsigned int cpu)
>  
>  	/* Remove outgoing CPU from mask in the leaf rcu_node structure. */
>  	mask = rdp->grpmask;
> -	local_irq_save(seq_flags);

True, IRQs should be disabled here. The idle loop disables irqs before
calling cpuhp_report_idle_dead() which calls rcu_report_dead().

I was curious about this path called from cpu_die_early() in ARM, in which
case it is an existing bug if it did not already disable interrupts. So your
lockdep check is a good thing in that regard.

For this patch:
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel


>  	arch_spin_lock(&rcu_state.ofl_lock);
>  	raw_spin_lock_irqsave_rcu_node(rnp, flags); /* Enforce GP memory-order guarantee. */
>  	rdp->rcu_ofl_gp_seq = READ_ONCE(rcu_state.gp_seq);
> @@ -4502,8 +4506,6 @@ void rcu_report_dead(unsigned int cpu)
>  	WRITE_ONCE(rnp->qsmaskinitnext, rnp->qsmaskinitnext & ~mask);
>  	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>  	arch_spin_unlock(&rcu_state.ofl_lock);
> -	local_irq_restore(seq_flags);
> -
>  	rdp->cpu_started = false;
>  }
>  
> -- 
> 2.40.1
> 
