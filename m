Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECAB6C828A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 17:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjCXQoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 12:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjCXQoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 12:44:04 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8330E113F2;
        Fri, 24 Mar 2023 09:44:02 -0700 (PDT)
Received: from kbox (unknown [76.135.27.212])
        by linux.microsoft.com (Postfix) with ESMTPSA id 6BC8B20FC3DB;
        Fri, 24 Mar 2023 09:44:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6BC8B20FC3DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1679676241;
        bh=xxBeia2D78dBK8d70oXp4Atwc+GmrqLlCnWbFHd1K2o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bW5ncnm9lcwFOnDxV+eVEh8UBtc2Iu7iL+S/bCe4UCuDWfojCFbM6JvkRb65/LVTa
         NsZm3LNC32boN3XjC5i3bQuEGAfrbYgIvC067oIT5o3bXNxoi/iTyUE82uAIUzgbZo
         7cxBwsqCkY4CdBmFifyrYG1vX6fXwd+vYAHfVaOA=
Date:   Fri, 24 Mar 2023 09:43:53 -0700
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        dcook@linux.microsoft.com, alanau@linux.microsoft.com,
        brauner@kernel.org, akpm@linux-foundation.org,
        ebiederm@xmission.com, keescook@chromium.org, tglx@linutronix.de,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v8 11/11] tracing/user_events: Limit global user_event
 count
Message-ID: <20230324164353.GA1790@kbox>
References: <20230221211143.574-1-beaub@linux.microsoft.com>
 <20230221211143.574-12-beaub@linux.microsoft.com>
 <20230324081824.b917c2944da217e5239e1223@kernel.org>
 <d6c83572-17e1-93d4-65a0-d480989e54fb@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6c83572-17e1-93d4-65a0-d480989e54fb@suse.cz>
X-Spam-Status: No, score=-17.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 09:54:48AM +0100, Vlastimil Babka wrote:
> On 3/24/23 01:18, Masami Hiramatsu (Google) wrote:
> > Hi Beau,
> > 
> > On Tue, 21 Feb 2023 13:11:43 -0800
> > Beau Belgrave <beaub@linux.microsoft.com> wrote:
> > 
> >> Operators want to be able to ensure enough tracepoints exist on the
> >> system for kernel components as well as for user components. Since there
> >> are only up to 64K events, by default allow up to half to be used by
> >> user events.
> >> 
> >> Add a boot parameter (user_events_max=%d) and a kernel sysctl parameter
> >> (kernel.user_events_max) to set a global limit that is honored among all
> >> groups on the system. This ensures hard limits can be setup to prevent
> >> user processes from consuming all event IDs on the system.
> > 
> > sysctl is good to me, but would we really need the kernel parameter?
> > The user_events starts using when user-space is up, so I think setting
> > the limit with sysctl is enough.
> > 
> > BTW, Vlastimil tried to add 'sysctl.*' kernel parameter support(*). If we
> > need a kernel cmdline support, I think this is more generic way. But it
> > seems the discussion has been stopped.
> 
> It was actually merged in 5.8. So sysctl should be sufficient with that.
> But maybe it's weird to start adding sysctls, when the rest of tracing
> tunables is AFAIK under /sys/kernel/tracing/ ?
> 

During the TraceFS meetings Steven runs I was asked to add a boot
parameter and sysctl for user_events to limit the max.

To me, it seems when user_events moves toward namespace awareness
sysctl might be easier to use from within a namespace to turn knobs.

Happy to change to whatever, but I want to see Steven and Masami agree
on the approach before doing so.

Steven, do you agree with Masami to move to just sysctl?

Thanks,
-Beau

> 
> > (*) https://patchwork.kernel.org/project/linux-mm/patch/20200427180433.7029-2-vbabka@suse.cz/
> > 
> > Thank you,
> > 
> >> 
> >> Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
> >> ---
> >>  kernel/trace/trace_events_user.c | 59 ++++++++++++++++++++++++++++++++
> >>  1 file changed, 59 insertions(+)
> >> 
> >> diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
> >> index 222f2eb59c7c..6a5ebe243999 100644
> >> --- a/kernel/trace/trace_events_user.c
> >> +++ b/kernel/trace/trace_events_user.c
> >> @@ -20,6 +20,7 @@
> >>  #include <linux/types.h>
> >>  #include <linux/uaccess.h>
> >>  #include <linux/highmem.h>
> >> +#include <linux/init.h>
> >>  #include <linux/user_events.h>
> >>  #include "trace.h"
> >>  #include "trace_dynevent.h"
> >> @@ -61,6 +62,12 @@ struct user_event_group {
> >>  /* Group for init_user_ns mapping, top-most group */
> >>  static struct user_event_group *init_group;
> >>  
> >> +/* Max allowed events for the whole system */
> >> +static unsigned int max_user_events = 32768;
> >> +
> >> +/* Current number of events on the whole system */
> >> +static unsigned int current_user_events;
> >> +
> >>  /*
> >>   * Stores per-event properties, as users register events
> >>   * within a file a user_event might be created if it does not
> >> @@ -1241,6 +1248,8 @@ static int destroy_user_event(struct user_event *user)
> >>  {
> >>  	int ret = 0;
> >>  
> >> +	lockdep_assert_held(&event_mutex);
> >> +
> >>  	/* Must destroy fields before call removal */
> >>  	user_event_destroy_fields(user);
> >>  
> >> @@ -1257,6 +1266,11 @@ static int destroy_user_event(struct user_event *user)
> >>  	kfree(EVENT_NAME(user));
> >>  	kfree(user);
> >>  
> >> +	if (current_user_events > 0)
> >> +		current_user_events--;
> >> +	else
> >> +		pr_alert("BUG: Bad current_user_events\n");
> >> +
> >>  	return ret;
> >>  }
> >>  
> >> @@ -1744,6 +1758,11 @@ static int user_event_parse(struct user_event_group *group, char *name,
> >>  
> >>  	mutex_lock(&event_mutex);
> >>  
> >> +	if (current_user_events >= max_user_events) {
> >> +		ret = -EMFILE;
> >> +		goto put_user_lock;
> >> +	}
> >> +
> >>  	ret = user_event_trace_register(user);
> >>  
> >>  	if (ret)
> >> @@ -1755,6 +1774,7 @@ static int user_event_parse(struct user_event_group *group, char *name,
> >>  	dyn_event_init(&user->devent, &user_event_dops);
> >>  	dyn_event_add(&user->devent, &user->call);
> >>  	hash_add(group->register_table, &user->node, key);
> >> +	current_user_events++;
> >>  
> >>  	mutex_unlock(&event_mutex);
> >>  
> >> @@ -2386,6 +2406,43 @@ static int create_user_tracefs(void)
> >>  	return -ENODEV;
> >>  }
> >>  
> >> +static int __init set_max_user_events(char *str)
> >> +{
> >> +	if (!str)
> >> +		return 0;
> >> +
> >> +	if (kstrtouint(str, 0, &max_user_events))
> >> +		return 0;
> >> +
> >> +	return 1;
> >> +}
> >> +__setup("user_events_max=", set_max_user_events);
> >> +
> >> +static int set_max_user_events_sysctl(struct ctl_table *table, int write,
> >> +				      void *buffer, size_t *lenp, loff_t *ppos)
> >> +{
> >> +	int ret;
> >> +
> >> +	mutex_lock(&event_mutex);
> >> +
> >> +	ret = proc_douintvec(table, write, buffer, lenp, ppos);
> >> +
> >> +	mutex_unlock(&event_mutex);
> >> +
> >> +	return ret;
> >> +}
> >> +
> >> +static struct ctl_table user_event_sysctls[] = {
> >> +	{
> >> +		.procname	= "user_events_max",
> >> +		.data		= &max_user_events,
> >> +		.maxlen		= sizeof(unsigned int),
> >> +		.mode		= 0644,
> >> +		.proc_handler	= set_max_user_events_sysctl,
> >> +	},
> >> +	{}
> >> +};
> >> +
> >>  static int __init trace_events_user_init(void)
> >>  {
> >>  	int ret;
> >> @@ -2415,6 +2472,8 @@ static int __init trace_events_user_init(void)
> >>  	if (dyn_event_register(&user_event_dops))
> >>  		pr_warn("user_events could not register with dyn_events\n");
> >>  
> >> +	register_sysctl_init("kernel", user_event_sysctls);
> >> +
> >>  	return 0;
> >>  }
> >>  
> >> -- 
> >> 2.25.1
> >> 
> > 
> > 
