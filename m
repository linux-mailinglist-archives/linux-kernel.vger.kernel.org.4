Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496D267553F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 14:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjATNJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 08:09:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjATNJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 08:09:37 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2443EC6D
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 05:09:35 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id ACFC45F9E7;
        Fri, 20 Jan 2023 13:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1674220174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XjqgFtVUkUjbCCMGAoadZ1mxvxex83rO/FB4iaCTZXY=;
        b=BSsv+L1mqvz4MbLUgk9m3et8S5Jg0NjIL+ZZ5z6rzfYMOTH2/W2jhdo8pVm6zsLwu7SsH7
        AYaZoeU+6ITyoJ00RPjehurQGzOjll/pslTCaQ221NmB3jC0X+3vlJPz28c2TxRk5Hs/17
        jvCsTjQj+KLHG2/QM3Fuq/iCpsG8ry8=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4B2682C141;
        Fri, 20 Jan 2023 13:09:34 +0000 (UTC)
Date:   Fri, 20 Jan 2023 14:09:33 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     yu.c.chen@intel.com, juri.lelli@redhat.com, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, zyhtheonly@gmail.com,
        zwp10758@gmail.com, zyhtheonly@yeah.net
Subject: Re: [PATCH v2] sched: print parent comm in sched_show_task()
Message-ID: <Y8qSjUbVhjYaRFg4@alley>
References: <20230119110642.GA6463@didi-ThinkCentre-M930t-N000>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119110642.GA6463@didi-ThinkCentre-M930t-N000>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2023-01-19 19:06:42, Tio Zhang wrote:
> Knowing who the parent is might be useful for debugging.
> For example, we can sometimes resolve kernel hung tasks by stopping
> the person who begins those hung tasks.
> With the parent's name printed in sched_show_task(),
> it might be helpful to let people know which "service" should be operated.
> Also, we move the parent info to a following new line while keeping the
> original line the same.
> And we would print "parent:unknown         ppid:<NULL>"
> when the task is not alive.
> 
> Signed-off-by: Tio Zhang <tiozhang@didiglobal.com>
> ---
>  kernel/sched/core.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index cb2aa2b54c7a..5690a5700f9e 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8854,6 +8854,7 @@ void sched_show_task(struct task_struct *p)
>  {
>  	unsigned long free = 0;
>  	int ppid;
> +	char *pcomm = NULL;
>  
>  	if (!try_get_task_stack(p))
>  		return;
> @@ -8867,13 +8868,22 @@ void sched_show_task(struct task_struct *p)
>  #endif
>  	ppid = 0;
>  	rcu_read_lock();
> -	if (pid_alive(p))
> -		ppid = task_pid_nr(rcu_dereference(p->real_parent));
> +	if (pid_alive(p)) {
> +		struct task_struct *parent = rcu_dereference(p->real_parent);
> +
> +		ppid = task_pid_nr(parent);
> +		pcomm = parent->comm;
> +	}
>  	rcu_read_unlock();
>  	pr_cont(" stack:%-5lu pid:%-5d ppid:%-6d flags:0x%08lx\n",
>  		free, task_pid_nr(p), ppid,

This prints "ppid:0" when pid_alive() returns false.

>  		read_task_thread_flags(p));
>  
> +	if (!ppid)
> +		pr_info("parent:unknown         ppid:<NULL>\n");

This prints "ppid:<NULL>". The inconsistency is weird.

Also there is no need to print ppid twice. I would remove it
from the " stack:..." line as it was done in the previous version
of the patch.

> +	else

> +		pr_info("parent:%-15.15s ppid:%-6d\n", pcomm, ppid);

"pcomm" must not be accessed after rcu_read_unlock(). The parent might
disappear in the meantime.

I suggest to got back to the previous version and just add printing
"parent:unknown         ppid:<NULL>\n" when pid_alive(p) fails.

Best Regards,
Petr
