Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C875863ACEC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 16:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbiK1PsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 10:48:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232424AbiK1PsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 10:48:07 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EA7A198
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 07:48:06 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id EEABC21B20;
        Mon, 28 Nov 2022 15:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1669650484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VRG51kohfD387vXDAcVs+Eyr77C58RyR3DMFs8PVI4A=;
        b=e/yyG3rrXwEYTSvYmM+E7f0MEBAib6h35woMeQccMbv/thoByid5rYbE9BECzm36r3Yjg/
        z172bP3IpjSuhitnCyUsduUCWzwhRBbkvvjGWb1zrg369pIS2aQ/qtH1yu8pibIhDc6Yvg
        kiV5WqLId8+6TJJzlb/DD+fKej9RpVc=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D46D02C143;
        Mon, 28 Nov 2022 15:48:04 +0000 (UTC)
Date:   Mon, 28 Nov 2022 16:48:04 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     akpm@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/hung_task: print real_parent->comm, pid in
 check_hung_task
Message-ID: <Y4TYNF8jRSkGii/U@alley>
References: <20221124112526.GA21832@didi-ThinkCentre-M930t-N000>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221124112526.GA21832@didi-ThinkCentre-M930t-N000>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-11-24 19:25:26, Tio Zhang wrote:
> We can avoid a hung task by fixing the process who causes it.
> But sometimes it is difficult to find out which service 
> the bad process belongs to by only knowing its pid and comm.
> Since userspace tools to learn who launches the bad process
> do not always work when we get a hung task, 
> it is helpful printing the parent by kernel.

Could you please be more specific how the information about
the parent helped to debug the problem?

Was it really important who started the process?
Was it related to some cgroup limits or permissions?

> Signed-off-by: Tio Zhang <tiozhang@didiglobal.com>
> ---
>  kernel/hung_task.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/hung_task.c b/kernel/hung_task.c
> index c71889f3f3fc..33543d27bd5c 100644
> --- a/kernel/hung_task.c
> +++ b/kernel/hung_task.c
> @@ -89,6 +89,7 @@ static struct notifier_block panic_block = {
>  
>  static void check_hung_task(struct task_struct *t, unsigned long timeout)
>  {
> +	struct task_struct *p = t->real_parent;

IMHO, this should be read using rcu_dereference(t->real_parent).

Note that check_hung_task() is already called under
rcu_read_lock() from check_hung_uninterruptible_tasks().

>  	unsigned long switch_count = t->nvcsw + t->nivcsw;
>  
>  	/*
> @@ -129,8 +130,8 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
>  	if (sysctl_hung_task_warnings) {
>  		if (sysctl_hung_task_warnings > 0)
>  			sysctl_hung_task_warnings--;
> -		pr_err("INFO: task %s:%d blocked for more than %ld seconds.\n",
> -		       t->comm, t->pid, (jiffies - t->last_switch_time) / HZ);
> +		pr_err("INFO: task %s:%d, parent %s:%d blocked for more than %ld seconds.\n",
> +		       t->comm, t->pid, p->comm, p->pid, (jiffies - t->last_switch_time) / HZ);

IMHO, this is a wrong place. The formulation creates more harm than
good. It might confuse people that both processes are blocked. Or it
makes the feeling that the parent somehow created the deadlock.

But if I get it correctly, the information about the parent is
needed only in special situations where only a particular parent
triggers the lockup.

>  		pr_err("      %s %s %.*s\n",
>  			print_tainted(), init_utsname()->release,
>  			(int)strcspn(init_utsname()->version, " "),

Alternative solution would be to print the parent in
sched_show_task() that is called here as well.

sched_show_task() prints many useful information that might
be useful for debugging. And the parent is just yet another
information that might bu useful.

Also sched_show_task() is called in more situations where
this information might be useful as well.

Best Regards,
Petr
