Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32D265D421
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 14:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234711AbjADNan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 08:30:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239363AbjADNaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 08:30:24 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D67234754
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 05:24:15 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C14CE3F4F6;
        Wed,  4 Jan 2023 13:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1672838653; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RyfIJ6gjYshx31FNKwyOcXwR4Zep67IZ6ANu2M3YhZo=;
        b=OIv0DI2TcJniSkMT5Tymcr5qs+mqxzWJHWsjBON08fDiutJDvSnRaLv6YfjvEYikBJUn4M
        4KMgZ4U/kk0a0iy4N2whmVZEhl2BZNnjueBF95Nvb/ImzMaQ3sq6fLLa4Nj/TqrYmw5BGF
        NNvGZ3sL03vvxd+EggF6fmDDxtHA3QM=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5F0A02C141;
        Wed,  4 Jan 2023 13:24:13 +0000 (UTC)
Date:   Wed, 4 Jan 2023 14:24:11 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        zyhtheonly@gmail.com, zyhtheonly@yeah.net, zwp10758@gmail.com
Subject: Re: [PATCH] sched: print parent comm in sched_show_task()
Message-ID: <Y7V9+1AhGhgP52xO@alley>
References: <20221227161400.GA7646@didi-ThinkCentre-M930t-N000>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221227161400.GA7646@didi-ThinkCentre-M930t-N000>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-12-28 00:14:00, Tio Zhang wrote:
> Knowing who the parent is might be useful for debugging.
> For example, we can sometimes resolve kernel hung tasks by stopping
> the person who begins those hung tasks.
> With the parent's name printed in sched_show_task(),
> it might be helpful to let people know which "service" should be operated.

> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8854,6 +8854,7 @@ void sched_show_task(struct task_struct *p)
>  {
>  	unsigned long free = 0;
>  	int ppid;
> +	char pcomm[TASK_COMM_LEN];
>  
>  	if (!try_get_task_stack(p))
>  		return;
> @@ -8867,11 +8868,13 @@ void sched_show_task(struct task_struct *p)
>  #endif
>  	ppid = 0;

We need to intialized pcomm here:

	pcomm[0] = '\0';

Otherwise, it would include a garbage when pid_alive(p) returns false below..

>  	rcu_read_lock();
> -	if (pid_alive(p))
> +	if (pid_alive(p)) {
>  		ppid = task_pid_nr(rcu_dereference(p->real_parent));
> +		get_task_comm(pcomm, rcu_dereference(p->real_parent));
> +	}
>  	rcu_read_unlock();
> -	pr_cont(" stack:%-5lu pid:%-5d ppid:%-6d flags:0x%08lx\n",
> -		free, task_pid_nr(p), ppid,
> +	pr_cont(" stack:%-5lu pid:%-5d ppid:%-6d parent:%-15.15s
> flags:0x%08lx\n",

It would print:  .... parent:xxx flags:0000

Some people might be confused whether the flags are from
the task or from the parent.

A solution would be to move the parent value to another line.
It would even better solve the situation when the task
is not alive and we could not get information about the parent:

	if (pid_alive(p)) {
		struct parent = rcu_dereference(p->real_parent);

		pr_info("parent:%-15.15s ppid:%-6d\n",
			parent->comm, task_pid_nr(parent));
	}

> +		free, task_pid_nr(p), ppid, pcomm,
>  		read_task_thread_flags(p));
>  
>  	print_worker_info(KERN_INFO, p);

Best Regards,
Petr
