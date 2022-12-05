Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A27364381B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 23:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbiLEW2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 17:28:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbiLEW2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 17:28:42 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2402DBBA;
        Mon,  5 Dec 2022 14:28:41 -0800 (PST)
Received: from kbox (unknown [76.135.50.127])
        by linux.microsoft.com (Postfix) with ESMTPSA id BCAE020B83CB;
        Mon,  5 Dec 2022 14:28:40 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BCAE020B83CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1670279320;
        bh=02fdSSqi1nj7DINRsO7t1ZiUf0Tw7LbKSnqROR3MKi0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BQIFtMEu8U0W/YPK85WplAf5xGUvujv0OzuADs2Fwu0PwkRT+N3gsyVFusomkOWsC
         UsLhrhJKELe+reiUfy2WPOfAAVGHIEBJaQZmm6aBUENllHsHU4w+ah/JV7TIKph9aW
         eYs6ZP4yI9d2P7LUeLWRALgs1XyESOIeSlbnxxoQ=
Date:   Mon, 5 Dec 2022 14:28:37 -0800
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org,
        dcook@linux.microsoft.com, alanau@linux.microsoft.com,
        brauner@kernel.org, akpm@linux-foundation.org,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 11/11] tracing/user_events: Limit global user_event
 count
Message-ID: <20221205222837.GB2270@kbox>
References: <20221205210017.23440-1-beaub@linux.microsoft.com>
 <20221205210017.23440-12-beaub@linux.microsoft.com>
 <18c4f109-522d-989d-23bb-2794791c2688@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18c4f109-522d-989d-23bb-2794791c2688@efficios.com>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2022 at 04:33:34PM -0500, Mathieu Desnoyers wrote:
> On 2022-12-05 16:00, Beau Belgrave wrote:
> > Operators want to be able to ensure enough tracepoints exist on the
> > system for kernel components as well as for user components. Since there
> > are only up to 64K events, by default allow up to half to be used by
> > user events.
> > 
> > Add a boot parameter (user_events_max=%d) and a kernel sysctl parameter
> > (kernel.user_events_max) to set a global limit that is honored among all
> > groups on the system. This ensures hard limits can be setup to prevent
> > user processes from consuming all event IDs on the system.
> > 
> > Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
> > ---
> >   kernel/trace/trace_events_user.c | 57 ++++++++++++++++++++++++++++++++
> >   1 file changed, 57 insertions(+)
> > 
> > diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
> > index 36def244a755..754942ba92a1 100644
> > --- a/kernel/trace/trace_events_user.c
> > +++ b/kernel/trace/trace_events_user.c
> > @@ -20,6 +20,7 @@
> >   #include <linux/types.h>
> >   #include <linux/uaccess.h>
> >   #include <linux/highmem.h>
> > +#include <linux/init.h>
> >   #include <linux/user_events.h>
> >   #include "trace.h"
> >   #include "trace_dynevent.h"
> > @@ -61,6 +62,12 @@ struct user_event_group {
> >   /* Group for init_user_ns mapping, top-most group */
> >   static struct user_event_group *init_group;
> > +/* Max allowed events for the whole system */
> > +static unsigned int max_user_events = 32768;
> > +
> > +/* Current number of events on the whole system */
> > +static unsigned int current_user_events;
> > +
> >   /*
> >    * Stores per-event properties, as users register events
> >    * within a file a user_event might be created if it does not
> > @@ -1247,6 +1254,11 @@ static int destroy_user_event(struct user_event *user)
> >   	kfree(EVENT_NAME(user));
> >   	kfree(user);
> > +	if (current_user_events > 0)
> > +		current_user_events--;
> 
> What holds the user_events mutex that guarantees that non-atomic decrement
> is safe here ?
> 

All callers of destroy_user_event hold the event_mutex, since it removes
the call from the system. This is the same for when the
current_user_events get incremented.

Maybe add a lock_dep statement here to make it clear?

Thanks,
-Beau

> Thanks,
> 
> Mathieu
> 
> > +	else
> > +		pr_alert("BUG: Bad current_user_events\n");
> > +
> >   	return ret;
> >   }
> > @@ -1732,6 +1744,11 @@ static int user_event_parse(struct user_event_group *group, char *name,
> >   	mutex_lock(&event_mutex);
> > +	if (current_user_events >= max_user_events) {
> > +		ret = -EMFILE;
> > +		goto put_user_lock;
> > +	}
> > +
> >   	ret = user_event_trace_register(user);
> >   	if (ret)
> > @@ -1743,6 +1760,7 @@ static int user_event_parse(struct user_event_group *group, char *name,
> >   	dyn_event_init(&user->devent, &user_event_dops);
> >   	dyn_event_add(&user->devent, &user->call);
> >   	hash_add(group->register_table, &user->node, key);
> > +	current_user_events++;
> >   	mutex_unlock(&event_mutex);
> > @@ -2369,6 +2387,43 @@ static int create_user_tracefs(void)
> >   	return -ENODEV;
> >   }
> > +static int __init set_max_user_events(char *str)
> > +{
> > +	if (!str)
> > +		return 0;
> > +
> > +	if (kstrtouint(str, 0, &max_user_events))
> > +		return 0;
> > +
> > +	return 1;
> > +}
> > +__setup("user_events_max=", set_max_user_events);
> > +
> > +static int set_max_user_events_sysctl(struct ctl_table *table, int write,
> > +				      void *buffer, size_t *lenp, loff_t *ppos)
> > +{
> > +	int ret;
> > +
> > +	mutex_lock(&event_mutex);
> > +
> > +	ret = proc_douintvec(table, write, buffer, lenp, ppos);
> > +
> > +	mutex_unlock(&event_mutex);
> > +
> > +	return ret;
> > +}
> > +
> > +static struct ctl_table user_event_sysctls[] = {
> > +	{
> > +		.procname	= "user_events_max",
> > +		.data		= &max_user_events,
> > +		.maxlen		= sizeof(unsigned int),
> > +		.mode		= 0644,
> > +		.proc_handler	= set_max_user_events_sysctl,
> > +	},
> > +	{}
> > +};
> > +
> >   static int __init trace_events_user_init(void)
> >   {
> >   	int ret;
> > @@ -2398,6 +2453,8 @@ static int __init trace_events_user_init(void)
> >   	if (dyn_event_register(&user_event_dops))
> >   		pr_warn("user_events could not register with dyn_events\n");
> > +	register_sysctl_init("kernel", user_event_sysctls);
> > +
> >   	return 0;
> >   }
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
