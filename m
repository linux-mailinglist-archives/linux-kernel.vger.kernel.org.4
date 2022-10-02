Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1514F5F23F4
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 17:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbiJBPz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 11:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiJBPzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 11:55:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1201EADD;
        Sun,  2 Oct 2022 08:55:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 364E5B80D79;
        Sun,  2 Oct 2022 15:55:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C83FC433D6;
        Sun,  2 Oct 2022 15:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664726119;
        bh=60yjIqhu9W6mf5WUQp0m0OVsUhI2+K+Fws9+lwO/lU8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pZ5a1r9w7AbPWNcCRr7ytp0Fah01bQhJgNNMXiaXaF6NMQhheXx0nq1rFNsPmmfTR
         04s0rTMUZIenetyGK2y5LnT8WfEq7lFJkyNW1fl+TE7Uw2lqDDK3MBhKu2rEr7Z4iU
         QUkAWg1X6fpJiQWLvjRdEbqgc8UoxNjmvMQQwm2OGumjlM0OZhyU9RWNsAyQPz5IwS
         ZafVKECJepFUqJrT4uYk5ptmWDyxqo+TZw+E6bVJ+Bln6gekjfGb/GdkJbYj6Boln9
         cVfs0iMbP6JCMhVV4ExSA5j6EoK9x2ZK5D0UTZKed1Y/nGjYCpm0Bk+SamSgDrD8Dx
         bIDpBLs8+dNWw==
Date:   Sun, 2 Oct 2022 17:55:16 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, rostedt@goodmis.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH RFC v2 rcu 2/8] srcu: Create an srcu_read_lock_nmisafe()
 and srcu_read_unlock_nmisafe()
Message-ID: <20221002155516.GB292620@lothringen>
References: <20220929180714.GA2874192@paulmck-ThinkPad-P17-Gen-1>
 <20220929180731.2875722-2-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929180731.2875722-2-paulmck@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 11:07:25AM -0700, Paul E. McKenney wrote:
> @@ -1090,7 +1121,7 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
>  	int ss_state;
>  
>  	check_init_srcu_struct(ssp);
> -	idx = srcu_read_lock(ssp);
> +	idx = __srcu_read_lock_nmisafe(ssp);

Why do we need to force the atomic based version here (even if CONFIG_NEED_SRCU_NMI_SAFE=y)?

>  	ss_state = smp_load_acquire(&ssp->srcu_size_state);
>  	if (ss_state < SRCU_SIZE_WAIT_CALL)
>  		sdp = per_cpu_ptr(ssp->sda, 0);
> @@ -1123,7 +1154,7 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
>  		srcu_funnel_gp_start(ssp, sdp, s, do_norm);
>  	else if (needexp)
>  		srcu_funnel_exp_start(ssp, sdp_mynode, s);
> -	srcu_read_unlock(ssp, idx);
> +	__srcu_read_unlock_nmisafe(ssp, idx);
>  	return s;
>  }
>  
> @@ -1427,13 +1458,13 @@ void srcu_barrier(struct srcu_struct *ssp)
>  	/* Initial count prevents reaching zero until all CBs are posted. */
>  	atomic_set(&ssp->srcu_barrier_cpu_cnt, 1);
>  
> -	idx = srcu_read_lock(ssp);
> +	idx = __srcu_read_lock_nmisafe(ssp);

And same here?

Thanks.

>  	if (smp_load_acquire(&ssp->srcu_size_state) < SRCU_SIZE_WAIT_BARRIER)
>  		srcu_barrier_one_cpu(ssp, per_cpu_ptr(ssp->sda, 0));
>  	else
>  		for_each_possible_cpu(cpu)
>  			srcu_barrier_one_cpu(ssp, per_cpu_ptr(ssp->sda, cpu));
> -	srcu_read_unlock(ssp, idx);
> +	__srcu_read_unlock_nmisafe(ssp, idx);
>  
>  	/* Remove the initial count, at which point reaching zero can happen. */
>  	if (atomic_dec_and_test(&ssp->srcu_barrier_cpu_cnt))
> -- 
> 2.31.1.189.g2e36527f23
> 
