Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3042C65BFCF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 13:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233068AbjACMYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 07:24:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbjACMYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 07:24:17 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C5EF581
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 04:24:15 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 92F0438B17;
        Tue,  3 Jan 2023 12:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1672748654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+7Jsn1eqHNc7UcnzZ6QQ9qgpbyDEmgmQmcW4o6pE8FE=;
        b=f7crYuVZh+fY7/U7c8ENdcFQmDY4hjAnT6KBRzbwPvkwwakLKgtr01ia0SSIU2C4TV1LHd
        s49hcG0z8cuwJxP9ViU9zIMcuasR9PbL1SD4Szcw9frJXYYvpU4GDojvUWCtHxeCq76v9O
        nvI/IjIfxJH8kY7hkJOCjkYqSg6XK88=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 764D52C141;
        Tue,  3 Jan 2023 12:24:14 +0000 (UTC)
Date:   Tue, 3 Jan 2023 13:24:11 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     akpm@linux-foundation.org, frederic@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kthread_worker: Flush all delayed works when destroy
 kthread worker
Message-ID: <Y7Qea58f5R58pMhn@alley>
References: <20221223131601.237244-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221223131601.237244-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2022-12-23 21:16:01, Zqiang wrote:
> When destroy a kthread worker, only flush all current works on
> kthread worker, this is not very sufficient, there may be some
> delayed works in the pending state,

Great catch!

> this commit therefore add
> flush delayed works function in kthread_destroy_worker().
> 
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -1375,6 +1375,35 @@ void kthread_flush_worker(struct kthread_worker *worker)
>  }
>  EXPORT_SYMBOL_GPL(kthread_flush_worker);
>  
> +/**
> + * kthread_flush_delayed_works - flush all current delayed works on a
> + * kthread_worker.
> + * @worker: worker to flush
> + *
> + * Wait until all currently executing or pending delayed works are
> + * queued completed.

It is not clear to me what "queued completed" means. I am not a native
speaker but this does not look like a meaningful English.

My understanding is that the function queues all pending delayed
work items immediately. It does not wait until they are proceed.

I am not sure if this is a correct behavior. The delayed work
items are often used for periodic events. The work usually
queues itself to be proceed later again. In this case,
it rather should get canceled.

Another problem is that the kthread_worker API tries to behave
the same way as the classic workqueue API. And destroy_workqueue()
ignores delayed works. Well, it might be an implementation limitation
because the classic workqueues do not have list of delayed work
items.

A compromise might be to just add the warning in
kthread_destroy_worker() when worker->delayed_work_list is not empty.
The caller will be responsible for queuing or canceling all delayed
work items before calling kthread_destroy_worker().

We should also document this expectation in the description
of kthread_destroy_worker().

> + */
> +void kthread_flush_delayed_works(struct kthread_worker *worker)
> +{
> +	unsigned long flags;
> +	struct kthread_delayed_work *dwork;
> +	struct kthread_work *work;
> +
> +	raw_spin_lock_irqsave(&worker->lock, flags);
> +	while (!list_empty(&worker->delayed_work_list)) {
> +		work = list_first_entry(&worker->delayed_work_list,
> +					struct kthread_work, node);
> +		list_del_init(&work->node);

This is racy. It removes the work from the list before deleting
the timer. kthread_delayed_work_timer_fn() would warn when
it gets triggered in the meantime.

A safe solution would be to delete the timer using
kthread_cancel_delayed_work_timer(). It would make sure
that the work will not be queued when timer is proceed
in the meantime.

> +		dwork = container_of(work, struct kthread_delayed_work, work);
> +		raw_spin_unlock_irqrestore(&worker->lock, flags);
> +		if (del_timer_sync(&dwork->timer))
> +			kthread_queue_work(worker, &dwork->work);
> +		raw_spin_lock_irqsave(&worker->lock, flags);
> +	}
> +	raw_spin_unlock_irqrestore(&worker->lock, flags);
> +}
> +EXPORT_SYMBOL_GPL(kthread_flush_delayed_works);
> +
>  /**
>   * kthread_destroy_worker - destroy a kthread worker
>   * @worker: worker to be destroyed
> @@ -1391,8 +1420,10 @@ void kthread_destroy_worker(struct kthread_worker *worker)
>  	if (WARN_ON(!task))
>  		return;
>  
> +	kthread_flush_delayed_works(worker);
>  	kthread_flush_worker(worker);
>  	kthread_stop(task);
> +	WARN_ON(!list_empty(&worker->delayed_work_list));

I would personally just add this warning.

Also we should update the function description. The caller is
responsible for handling delayed work items. They should either
be queued immediately or canceled when this function
is called.

>  	WARN_ON(!list_empty(&worker->work_list));
>  	kfree(worker);

Best Regards,
Petr
