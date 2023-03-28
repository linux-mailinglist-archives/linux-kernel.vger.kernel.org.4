Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA976CBB47
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 11:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbjC1JlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 05:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232970AbjC1JlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 05:41:04 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DB172B8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 02:40:49 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id DF8BD219DC;
        Tue, 28 Mar 2023 09:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679996447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qD0q3bnfRRfK9P5PPhlEeT7uY9in6BWiZD98LqDkZkc=;
        b=ZExHa1DSQcaCllJva2zxxj2MxPTr5VTCg0W9BBZbWMmvavqWhyLKXH9OG93shfhigdUP5Z
        9MK512ALv3d6P0zUf0KJx7frhUfw3oc4JZuxNh/9C6cY0JAUtyO80Yu8lyMQcrFjHOm8BJ
        r5vvt4YKm+wfPSTLh0mc2R3Nd652GJg=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 861CF2C141;
        Tue, 28 Mar 2023 09:40:47 +0000 (UTC)
Date:   Tue, 28 Mar 2023 11:40:46 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     yu.c.chen@intel.com, akpm@linux-foundation.org,
        juri.lelli@redhat.com, mingo@redhat.com, peterz@infradead.org,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        zyhtheonly@gmail.com, zwp10758@gmail.com, zyhtheonly@yeah.net
Subject: Re: [PATCH v3] sched: print parent comm in sched_show_task()
Message-ID: <ZCK2HuorPgSwWZpw@alley>
References: <ZCGBaQIHIC8GMNtn@alley>
 <20230328034438.GA8421@didi-ThinkCentre-M930t-N000>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328034438.GA8421@didi-ThinkCentre-M930t-N000>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2023-03-28 11:44:59, Tio Zhang wrote:
> Knowing who the parent is might be useful for debugging.
> For example, we can sometimes resolve kernel hung tasks by stopping
> the person who begins those hung tasks.
> With the parent's name printed in sched_show_task(),
> it might be helpful to let people know which "service" should be operated.
> Also, we move the parent info to a following new line.
> It would be better to solve the situation when the task
> is not alive and we could not get information about the parent.
> 
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8865,14 +8864,19 @@ void sched_show_task(struct task_struct *p)
>  #ifdef CONFIG_DEBUG_STACK_USAGE
>  	free = stack_not_used(p);
>  #endif
> -	ppid = 0;
> +
> +	pr_cont(" stack:%-5lu pid:%-5d flags:0x%08lx\n",
> +		free, task_pid_nr(p), read_task_thread_flags(p));
> +
>  	rcu_read_lock();
> -	if (pid_alive(p))
> -		ppid = task_pid_nr(rcu_dereference(p->real_parent));
> +	if (pid_alive(p)) {
> +		struct task_struct *parent = rcu_dereference(p->real_parent);
> +
> +		pr_info("parent:%-15.15s ppid:%-6d", parent->comm, task_pid_nr(parent));

There is a missing new line delimiter "\n".

> +	} else {
> +		pr_info("parent:unknown         ppid:<NULL>\n");
> +	}
>  	rcu_read_unlock();
> -	pr_cont(" stack:%-5lu pid:%-5d ppid:%-6d flags:0x%08lx\n",
> -		free, task_pid_nr(p), ppid,
> -		read_task_thread_flags(p));
>  
>  	print_worker_info(KERN_INFO, p);
>  	print_stop_info(KERN_INFO, p);

Otherwise, it looks good. With the added new line delimiter:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
