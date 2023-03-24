Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428C16C746C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 01:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjCXASe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 20:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjCXASb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 20:18:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2377CC05;
        Thu, 23 Mar 2023 17:18:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89C8A6291B;
        Fri, 24 Mar 2023 00:18:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF370C433D2;
        Fri, 24 Mar 2023 00:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679617109;
        bh=baE66WAvlZt1HEma7dXFYnUtrxITRNKnebLiWstMAi0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KdkjjS5Af4jGRn7QyBMyhVuzQXg8S/DTIrDEHFXwxZJTNxYSdpJ/ct0igEN4HIMYT
         xrkRTN+FquckOVHs4tLMgaZzhTX1J1xuvQD6psiXCwjpIN4ZTdva64kQB4WD376gSw
         wh0QVaTIhNWXj3t6kZzb7+sGcOs0Acx7Up3LIf0KaUFsC0/RM3kxQrpGBfqxSOPlTz
         NaQDXrQxl95qgqzjluwUNC4Ej1Zd5oDB4vdQSEDO3hqW5XPh/clzt6KAihIi8edsTW
         97/2cTTcGOXhPytXt4Xh8VOYriWkzP7ANGQzW9YIWM7BN36UL4eWJr8uAiRxSx47D8
         g6XZS/qBA1vmg==
Date:   Fri, 24 Mar 2023 08:18:24 +0800
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        dcook@linux.microsoft.com, alanau@linux.microsoft.com,
        brauner@kernel.org, akpm@linux-foundation.org,
        ebiederm@xmission.com, keescook@chromium.org, tglx@linutronix.de,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v8 11/11] tracing/user_events: Limit global user_event
 count
Message-Id: <20230324081824.b917c2944da217e5239e1223@kernel.org>
In-Reply-To: <20230221211143.574-12-beaub@linux.microsoft.com>
References: <20230221211143.574-1-beaub@linux.microsoft.com>
        <20230221211143.574-12-beaub@linux.microsoft.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Beau,

On Tue, 21 Feb 2023 13:11:43 -0800
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> Operators want to be able to ensure enough tracepoints exist on the
> system for kernel components as well as for user components. Since there
> are only up to 64K events, by default allow up to half to be used by
> user events.
> 
> Add a boot parameter (user_events_max=%d) and a kernel sysctl parameter
> (kernel.user_events_max) to set a global limit that is honored among all
> groups on the system. This ensures hard limits can be setup to prevent
> user processes from consuming all event IDs on the system.

sysctl is good to me, but would we really need the kernel parameter?
The user_events starts using when user-space is up, so I think setting
the limit with sysctl is enough.

BTW, Vlastimil tried to add 'sysctl.*' kernel parameter support(*). If we
need a kernel cmdline support, I think this is more generic way. But it
seems the discussion has been stopped.

(*) https://patchwork.kernel.org/project/linux-mm/patch/20200427180433.7029-2-vbabka@suse.cz/

Thank you,

> 
> Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
> ---
>  kernel/trace/trace_events_user.c | 59 ++++++++++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
> 
> diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
> index 222f2eb59c7c..6a5ebe243999 100644
> --- a/kernel/trace/trace_events_user.c
> +++ b/kernel/trace/trace_events_user.c
> @@ -20,6 +20,7 @@
>  #include <linux/types.h>
>  #include <linux/uaccess.h>
>  #include <linux/highmem.h>
> +#include <linux/init.h>
>  #include <linux/user_events.h>
>  #include "trace.h"
>  #include "trace_dynevent.h"
> @@ -61,6 +62,12 @@ struct user_event_group {
>  /* Group for init_user_ns mapping, top-most group */
>  static struct user_event_group *init_group;
>  
> +/* Max allowed events for the whole system */
> +static unsigned int max_user_events = 32768;
> +
> +/* Current number of events on the whole system */
> +static unsigned int current_user_events;
> +
>  /*
>   * Stores per-event properties, as users register events
>   * within a file a user_event might be created if it does not
> @@ -1241,6 +1248,8 @@ static int destroy_user_event(struct user_event *user)
>  {
>  	int ret = 0;
>  
> +	lockdep_assert_held(&event_mutex);
> +
>  	/* Must destroy fields before call removal */
>  	user_event_destroy_fields(user);
>  
> @@ -1257,6 +1266,11 @@ static int destroy_user_event(struct user_event *user)
>  	kfree(EVENT_NAME(user));
>  	kfree(user);
>  
> +	if (current_user_events > 0)
> +		current_user_events--;
> +	else
> +		pr_alert("BUG: Bad current_user_events\n");
> +
>  	return ret;
>  }
>  
> @@ -1744,6 +1758,11 @@ static int user_event_parse(struct user_event_group *group, char *name,
>  
>  	mutex_lock(&event_mutex);
>  
> +	if (current_user_events >= max_user_events) {
> +		ret = -EMFILE;
> +		goto put_user_lock;
> +	}
> +
>  	ret = user_event_trace_register(user);
>  
>  	if (ret)
> @@ -1755,6 +1774,7 @@ static int user_event_parse(struct user_event_group *group, char *name,
>  	dyn_event_init(&user->devent, &user_event_dops);
>  	dyn_event_add(&user->devent, &user->call);
>  	hash_add(group->register_table, &user->node, key);
> +	current_user_events++;
>  
>  	mutex_unlock(&event_mutex);
>  
> @@ -2386,6 +2406,43 @@ static int create_user_tracefs(void)
>  	return -ENODEV;
>  }
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
>  static int __init trace_events_user_init(void)
>  {
>  	int ret;
> @@ -2415,6 +2472,8 @@ static int __init trace_events_user_init(void)
>  	if (dyn_event_register(&user_event_dops))
>  		pr_warn("user_events could not register with dyn_events\n");
>  
> +	register_sysctl_init("kernel", user_event_sysctls);
> +
>  	return 0;
>  }
>  
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
