Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48396749D2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 04:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjATDPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 22:15:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjATDO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 22:14:59 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09FE246B5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 19:14:58 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id n2so2999841qvo.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 19:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4xKzm9ndNgAZ3n1qGRub6U8C9Gfc3KHDIIF/tjQDlEM=;
        b=m44zaOQkQ6ybI6EyHHLAMaKTSDPlX152AcKKf/sdncMKOtzTj5XdOkYow8SRBzCSWh
         EtIkORMprMVXC2tqTdODJ1BMRULcWsZa8H8Eb7HponRkwZEw8BCsxdbry0jorzjdyPMo
         hNKDLBH8k5iXsaC9wFlQ8M9/5tWc30NrUj0WU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4xKzm9ndNgAZ3n1qGRub6U8C9Gfc3KHDIIF/tjQDlEM=;
        b=u/mYEgVMJtIoPDLYMBkCiUBRZMJj1g8nEStFdZWVIoMxkqWnaPl8PUsZEXzmXqhknB
         yTfyh3hTGps5EUtiT9YgJNfBNCCrMUswVHx6xs+hjouF6XNmAWiN4ah+zxzM1e/14TS7
         zxEEMHlPBjnYjpmSAPDT3JACSYsayU+S9B0n5pXrEZ50zmQcugbf/aO1Qx8vns25GsGr
         yDxC5Vf+ZkFY8PjTzqVzeCU5tsP4d/d//hrLsbArt8Dso/9Z+HZLcw7eTN7nf02RSlG1
         1ygOw7xaSmzgYkYcH8QkHeDoMjaHlu7gsu/SIBKrYK86XyBvxDYLlY68mhOvhAOItH22
         FnOA==
X-Gm-Message-State: AFqh2kos+STO82ky84WbwmDyyLtqmGdJ8SUPVVItjkxBopwYrLd9xvoo
        40M8344Ucd2VknW36r1LX8/HNcoDT4wHqP1U
X-Google-Smtp-Source: AMrXdXtpT0zkxvA6pOTV7mgIcAXwUW5c9AzZqy9wFlj68ECsfrrn7DoOmRWSp+Jeeku//5n831bY8w==
X-Received: by 2002:a05:6214:5d11:b0:534:a476:e10 with SMTP id me17-20020a0562145d1100b00534a4760e10mr18371006qvb.25.1674184497085;
        Thu, 19 Jan 2023 19:14:57 -0800 (PST)
Received: from localhost (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id q6-20020a05620a0d8600b006fa43e139b5sm25312634qkl.59.2023.01.19.19.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 19:14:56 -0800 (PST)
Date:   Fri, 20 Jan 2023 03:14:55 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Zqiang <qiang1.zhang@intel.com>, frederic@kernel.org,
        quic_neeraju@quicinc.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] rcu: Remove impossible wakeup rcu GP kthread action
 from rcu_report_qs_rdp()
Message-ID: <Y8oHL0uuSEef5aiI@google.com>
References: <20230118073014.2020743-1-qiang1.zhang@intel.com>
 <20230118180714.GD2948950@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118180714.GD2948950@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 10:07:14AM -0800, Paul E. McKenney wrote:
> On Wed, Jan 18, 2023 at 03:30:14PM +0800, Zqiang wrote:
> > When inovke rcu_report_qs_rdp(), if current CPU's rcu_data structure's ->
> > grpmask has not been cleared from the corresponding rcu_node structure's
> > ->qsmask, after that will clear and report quiescent state, but in this
> > time, this also means that current grace period is not end, the current
> > grace period is ongoing, because the rcu_gp_in_progress() currently return
> > true, so for non-offloaded rdp, invoke rcu_accelerate_cbs() is impossible
> > to return true.
> > 
> > This commit therefore remove impossible rcu_gp_kthread_wake() calling.
> > 
> > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> 
> Queued (wordsmithed as shown below, as always, please check) for further
> testing and review, thank you both!
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit fbe3e300ec8b3edd2b8f84dab4dc98947cf71eb8
> Author: Zqiang <qiang1.zhang@intel.com>
> Date:   Wed Jan 18 15:30:14 2023 +0800
> 
>     rcu: Remove never-set needwake assignment from rcu_report_qs_rdp()
>     
>     The rcu_accelerate_cbs() function is invoked by rcu_report_qs_rdp()
>     only if there is a grace period in progress that is still blocked
>     by at least one CPU on this rcu_node structure.  This means that
>     rcu_accelerate_cbs() should never return the value true, and thus that
>     this function should never set the needwake variable and in turn never
>     invoke rcu_gp_kthread_wake().
>     
>     This commit therefore removes the needwake variable and the invocation
>     of rcu_gp_kthread_wake() in favor of a WARN_ON_ONCE() on the call to
>     rcu_accelerate_cbs().  The purpose of this new WARN_ON_ONCE() is to
>     detect situations where the system's opinion differs from ours.
>     
>     Signed-off-by: Zqiang <qiang1.zhang@intel.com>
>     Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index b2c2045294780..7a3085ad0a7df 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1956,7 +1956,6 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
>  {
>  	unsigned long flags;
>  	unsigned long mask;
> -	bool needwake = false;
>  	bool needacc = false;
>  	struct rcu_node *rnp;
>  
> @@ -1988,7 +1987,12 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
>  		 * NOCB kthreads have their own way to deal with that...
>  		 */
>  		if (!rcu_rdp_is_offloaded(rdp)) {
> -			needwake = rcu_accelerate_cbs(rnp, rdp);
> +			/*
> +			 * The current GP has not yet ended, so it
> +			 * should not be possible for rcu_accelerate_cbs()
> +			 * to return true.  So complain, but don't awaken.
> +			 */
> +			WARN_ON_ONCE(rcu_accelerate_cbs(rnp, rdp));
>  		} else if (!rcu_segcblist_completely_offloaded(&rdp->cblist)) {
>  			/*
>  			 * ...but NOCB kthreads may miss or delay callbacks acceleration
> @@ -2000,8 +2004,6 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
>  		rcu_disable_urgency_upon_qs(rdp);
>  		rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
>  		/* ^^^ Released rnp->lock */
> -		if (needwake)
> -			rcu_gp_kthread_wake();

AFAICS, there is almost no compiler benefit of doing this, and zero runtime
benefit of doing this. The WARN_ON_ONCE() also involves a runtime condition
check of the return value of rcu_accelerate_cbs(), so you still have a
branch. Yes, maybe slightly smaller code without the wake call, but I'm not
sure that is worth it.

And, if the opinion of system differs, its a bug anyway, so more added risk.


>  
>  		if (needacc) {
>  			rcu_nocb_lock_irqsave(rdp, flags);

And when needacc = true, rcu_accelerate_cbs_unlocked() tries to do a wake up
anyway, so it is consistent with nocb vs !nocb.

So I am not a fan of this change. ;-)

thanks,

 - Joel

