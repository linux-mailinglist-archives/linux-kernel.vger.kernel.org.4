Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 983096436EB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 22:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbiLEVdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 16:33:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbiLEVdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 16:33:17 -0500
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA492C64E;
        Mon,  5 Dec 2022 13:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1670275996;
        bh=b4IyhGJ3m6zNxw3owWYA/BBCmtAr/iUj4osvu+wxLOQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=u0gJQoTAMIcEyoxuj0pO7sjGJluy9w2J6EaiBtWm09eobUUbeXqpAsAf1i0Au+xbi
         bRCIm7bXVd0y/JPID9dXR2zs/VA+C5LuYxEZsv/txXQw87WsI4S/Iy/0xYCIqFGnEI
         tIwHD1QOxvFY6SBGZuFIEgfpE91z1knxpZ4a0G/rHzUOaMd2sGZV6xng9XwC6qtIsr
         udRJnNkjyt5haFM61XjGEIwkcxOY3ajaE8Mpz0U6tpSujDZsyOJN0Hzs/Fi+jB0P44
         NVZYr30EIgk8JKaUyKrZVcUs8pQD2s3vYYaY4ciug5e2H7Kd6kRsfdPALlD5NZivhD
         JsdAKlDDQPW+w==
Received: from [172.16.0.118] (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4NQxcC66zdzZ7l;
        Mon,  5 Dec 2022 16:33:15 -0500 (EST)
Message-ID: <18c4f109-522d-989d-23bb-2794791c2688@efficios.com>
Date:   Mon, 5 Dec 2022 16:33:34 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v5 11/11] tracing/user_events: Limit global user_event
 count
Content-Language: en-US
To:     Beau Belgrave <beaub@linux.microsoft.com>, rostedt@goodmis.org,
        mhiramat@kernel.org, dcook@linux.microsoft.com,
        alanau@linux.microsoft.com, brauner@kernel.org,
        akpm@linux-foundation.org
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221205210017.23440-1-beaub@linux.microsoft.com>
 <20221205210017.23440-12-beaub@linux.microsoft.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20221205210017.23440-12-beaub@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-05 16:00, Beau Belgrave wrote:
> Operators want to be able to ensure enough tracepoints exist on the
> system for kernel components as well as for user components. Since there
> are only up to 64K events, by default allow up to half to be used by
> user events.
> 
> Add a boot parameter (user_events_max=%d) and a kernel sysctl parameter
> (kernel.user_events_max) to set a global limit that is honored among all
> groups on the system. This ensures hard limits can be setup to prevent
> user processes from consuming all event IDs on the system.
> 
> Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
> ---
>   kernel/trace/trace_events_user.c | 57 ++++++++++++++++++++++++++++++++
>   1 file changed, 57 insertions(+)
> 
> diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
> index 36def244a755..754942ba92a1 100644
> --- a/kernel/trace/trace_events_user.c
> +++ b/kernel/trace/trace_events_user.c
> @@ -20,6 +20,7 @@
>   #include <linux/types.h>
>   #include <linux/uaccess.h>
>   #include <linux/highmem.h>
> +#include <linux/init.h>
>   #include <linux/user_events.h>
>   #include "trace.h"
>   #include "trace_dynevent.h"
> @@ -61,6 +62,12 @@ struct user_event_group {
>   /* Group for init_user_ns mapping, top-most group */
>   static struct user_event_group *init_group;
>   
> +/* Max allowed events for the whole system */
> +static unsigned int max_user_events = 32768;
> +
> +/* Current number of events on the whole system */
> +static unsigned int current_user_events;
> +
>   /*
>    * Stores per-event properties, as users register events
>    * within a file a user_event might be created if it does not
> @@ -1247,6 +1254,11 @@ static int destroy_user_event(struct user_event *user)
>   	kfree(EVENT_NAME(user));
>   	kfree(user);
>   
> +	if (current_user_events > 0)
> +		current_user_events--;

What holds the user_events mutex that guarantees that non-atomic 
decrement is safe here ?

Thanks,

Mathieu

> +	else
> +		pr_alert("BUG: Bad current_user_events\n");
> +
>   	return ret;
>   }
>   
> @@ -1732,6 +1744,11 @@ static int user_event_parse(struct user_event_group *group, char *name,
>   
>   	mutex_lock(&event_mutex);
>   
> +	if (current_user_events >= max_user_events) {
> +		ret = -EMFILE;
> +		goto put_user_lock;
> +	}
> +
>   	ret = user_event_trace_register(user);
>   
>   	if (ret)
> @@ -1743,6 +1760,7 @@ static int user_event_parse(struct user_event_group *group, char *name,
>   	dyn_event_init(&user->devent, &user_event_dops);
>   	dyn_event_add(&user->devent, &user->call);
>   	hash_add(group->register_table, &user->node, key);
> +	current_user_events++;
>   
>   	mutex_unlock(&event_mutex);
>   
> @@ -2369,6 +2387,43 @@ static int create_user_tracefs(void)
>   	return -ENODEV;
>   }
>   
> +static int __init set_max_user_events(char *str)
> +{
> +	if (!str)
> +		return 0;
> +
> +	if (kstrtouint(str, 0, &max_user_events))
> +		return 0;
> +
> +	return 1;
> +}
> +__setup("user_events_max=", set_max_user_events);
> +
> +static int set_max_user_events_sysctl(struct ctl_table *table, int write,
> +				      void *buffer, size_t *lenp, loff_t *ppos)
> +{
> +	int ret;
> +
> +	mutex_lock(&event_mutex);
> +
> +	ret = proc_douintvec(table, write, buffer, lenp, ppos);
> +
> +	mutex_unlock(&event_mutex);
> +
> +	return ret;
> +}
> +
> +static struct ctl_table user_event_sysctls[] = {
> +	{
> +		.procname	= "user_events_max",
> +		.data		= &max_user_events,
> +		.maxlen		= sizeof(unsigned int),
> +		.mode		= 0644,
> +		.proc_handler	= set_max_user_events_sysctl,
> +	},
> +	{}
> +};
> +
>   static int __init trace_events_user_init(void)
>   {
>   	int ret;
> @@ -2398,6 +2453,8 @@ static int __init trace_events_user_init(void)
>   	if (dyn_event_register(&user_event_dops))
>   		pr_warn("user_events could not register with dyn_events\n");
>   
> +	register_sysctl_init("kernel", user_event_sysctls);
> +
>   	return 0;
>   }
>   

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

