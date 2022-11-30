Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1789563E279
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 22:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiK3VG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 16:06:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiK3VGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 16:06:24 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E011862D7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 13:06:23 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id 124so1941447pfy.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 13:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1MVQAFtG5yXdmZSDQong4TWmdBnZ3CFxDrsEWW+IpWM=;
        b=U1h73Rz1N6fqj70eL7F6NuJsWcAnYsslfpPd6XulGFo97ZJBoukLpp7EkzkkPAQJ5B
         FmZKyY4n1Nrnur8VjpKG4Rm6z+Q1Fb+wzqvA4ga7JvOlKMOiLG86LTYU1wBR2gCR6xea
         g2RbrSkXff3zSPHaE+4ur5s9DiLYZaQGjpkkwKJnmSPYZgtS65EAr9CckDn83wNuZZET
         1y8w/rrMXgB2J5Bhf3vLBwTgNtcxWCS7HBaEj2c5e+Tg7liuZIiHC6QC2/ccwNc+xAds
         fOLTXTav/Du4jtHAd7z70ZqFlQcf/Mu4vZV4L060W/uafu98Qg+zaqOW3wZUnr4ozsLs
         yk2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1MVQAFtG5yXdmZSDQong4TWmdBnZ3CFxDrsEWW+IpWM=;
        b=NCueL2JQj24X9w1JA8YDzOI3y1SJcrEwMdakwf+trSICR0qIVXVnTVLqTPSe+cqW9d
         8U0R/y6rnqZgy5WeIidd8h5IyQ9vT5Jl9IqXyo3a01yBbHrfeHj4mS0EEdcIJwhiu20c
         wpoXqo2CYOu8LmdLjEIU9OBvPNtDwlznSXyyQAC0hr+IIKMApOGMj2zXmQC/1Sevm0Y3
         DdHbIJHT4qAc8yAwfHrLAJy5KdhUmWVoX31i/lDKZh+5yFWTqOKIrAoHCUGIDwJGnje2
         GVNid4g9caegJOJwZt7YzIfy3+Z1soukil9ZUKc1VWkBe6ztJ0Y/6XcQD18AD+faNWTx
         G8DQ==
X-Gm-Message-State: ANoB5pn2YVKcF1O655BAZzw6Vc7TXoZFe1Im5h+XWBDeFbPx8kPmARWF
        +FgXblq5LbevweHpadlfCko=
X-Google-Smtp-Source: AA0mqf7G4C9ZYREcVLtDsr5h6tP7fBJziJcl9w4YmOTtaPYsjtBVRF+t130Adlukl4M1ItgW4kmlYg==
X-Received: by 2002:aa7:88ca:0:b0:576:1216:c12d with SMTP id k10-20020aa788ca000000b005761216c12dmr884827pff.84.1669842382404;
        Wed, 30 Nov 2022 13:06:22 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id i190-20020a6287c7000000b0056c704abca7sm1772354pfe.220.2022.11.30.13.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 13:06:22 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 30 Nov 2022 11:06:20 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH v6 3/4] workqueue: Convert the idle_timer to a timer +
 work_struct
Message-ID: <Y4fFzBrjZiOQO9Te@slm.duckdns.org>
References: <20221128183109.446754-1-vschneid@redhat.com>
 <20221128183109.446754-4-vschneid@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128183109.446754-4-vschneid@redhat.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 06:31:08PM +0000, Valentin Schneider wrote:
> @@ -1806,7 +1808,9 @@ static void worker_enter_idle(struct worker *worker)
>  	/* idle_list is LIFO */
>  	list_add(&worker->entry, &pool->idle_list);
>  
> -	if (too_many_workers(pool) && !timer_pending(&pool->idle_timer))
> +	if (too_many_workers(pool) &&
> +	    !timer_pending(&pool->idle_timer) &&
> +	    !work_pending(&pool->idle_cull_work))

Just checking the timer should be enough here, I think.

>  		mod_timer(&pool->idle_timer, jiffies + IDLE_WORKER_TIMEOUT);
>  
>  	/* Sanity check nr_running. */
> @@ -2019,17 +2023,56 @@ static void destroy_worker(struct worker *worker)
>  	wake_up_process(worker->task);
>  }
>  
> +/*
> + * idle_worker_timeout - check if some idle workers can now be deleted.

Might as well turn it into a proper function comment starting w/ "/**" and
with argument list.

> + *
> + * The timer is armed in worker_enter_idle(). Note that it isn't disarmed in
> + * worker_leave_idle(), as a worker flicking between idle and active while its
> + * pool is at the too_many_workers() tipping point would cause too much timer
> + * housekeeping overhead. Since IDLE_WORKER_TIMEOUT is long enough, we just let
> + * it expire and re-evaluate things from there.
> + */
>  static void idle_worker_timeout(struct timer_list *t)
>  {
>  	struct worker_pool *pool = from_timer(pool, t, idle_timer);
> +	bool do_cull = false;
> +
> +	if (work_pending(&pool->idle_cull_work))
> +		return;
>  
>  	raw_spin_lock_irq(&pool->lock);
>  
> -	while (too_many_workers(pool)) {
> +	if (too_many_workers(pool)) {
>  		struct worker *worker;
>  		unsigned long expires;
>  
>  		/* idle_list is kept in LIFO order, check the last one */
> +		worker = list_entry(pool->idle_list.prev, struct worker, entry);
> +		expires = worker->last_active + IDLE_WORKER_TIMEOUT;
> +		do_cull = !time_before(jiffies, expires);
> +
> +		if (!do_cull)
> +			mod_timer(&pool->idle_timer, expires);
> +	}
> +	raw_spin_unlock_irq(&pool->lock);
> +
> +	if (do_cull)
> +		queue_work(system_unbound_wq, &pool->idle_cull_work);
> +}
> +
> +/*
> + * idle_cull_fn - cull workers that have been idle for too long.
> + */

Please turn it into a full function comment or drop the wings (ie. make it
an one-liner).

> +static void idle_cull_fn(struct work_struct *work)
> +{
> +	struct worker_pool *pool = container_of(work, struct worker_pool, idle_cull_work);
> +
> +	raw_spin_lock_irq(&pool->lock);
> +
> +	while (too_many_workers(pool)) {
> +		struct worker *worker;
> +		unsigned long expires;
> +

Other than that, looks great to me.

Thanks.

-- 
tejun
