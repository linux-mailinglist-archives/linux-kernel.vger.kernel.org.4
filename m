Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B156C7A66
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 09:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbjCXIzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 04:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbjCXIy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 04:54:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F63225E35;
        Fri, 24 Mar 2023 01:54:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D21D933777;
        Fri, 24 Mar 2023 08:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679648088; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NS9d7ZaLCL3KAZXneGHf8Dn544Z5QXJS4scN7Mds7nw=;
        b=zITtHtc902VVsVw7+zKr5bkxsv6Mbx1+fbpm2ia5zTF3EWIm2QMai2vAIfAe0doNtU/crP
        T4sFLJuba0H6TQ3fzAdSP47lDfthRbDB3jBwo3m0IQp+jh4qaGUTXbU6gX3dhCFVp2t3v8
        Sw1x9MwzQ/ARwVXmI/EwXcFa4XoasH0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679648088;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NS9d7ZaLCL3KAZXneGHf8Dn544Z5QXJS4scN7Mds7nw=;
        b=3DYCY3JP15PbKY5gZ4FAa9lC1CjGdXRUVpIXWH0RgpGHW3/IZRgwg0RpSKBDovX8Kj9oF6
        cb8Dk7t0WzpREZAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9432E133E5;
        Fri, 24 Mar 2023 08:54:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id R/EgI1hlHWRkDQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 24 Mar 2023 08:54:48 +0000
Message-ID: <d6c83572-17e1-93d4-65a0-d480989e54fb@suse.cz>
Date:   Fri, 24 Mar 2023 09:54:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v8 11/11] tracing/user_events: Limit global user_event
 count
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Beau Belgrave <beaub@linux.microsoft.com>
Cc:     rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        dcook@linux.microsoft.com, alanau@linux.microsoft.com,
        brauner@kernel.org, akpm@linux-foundation.org,
        ebiederm@xmission.com, keescook@chromium.org, tglx@linutronix.de,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20230221211143.574-1-beaub@linux.microsoft.com>
 <20230221211143.574-12-beaub@linux.microsoft.com>
 <20230324081824.b917c2944da217e5239e1223@kernel.org>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230324081824.b917c2944da217e5239e1223@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/23 01:18, Masami Hiramatsu (Google) wrote:
> Hi Beau,
> 
> On Tue, 21 Feb 2023 13:11:43 -0800
> Beau Belgrave <beaub@linux.microsoft.com> wrote:
> 
>> Operators want to be able to ensure enough tracepoints exist on the
>> system for kernel components as well as for user components. Since there
>> are only up to 64K events, by default allow up to half to be used by
>> user events.
>> 
>> Add a boot parameter (user_events_max=%d) and a kernel sysctl parameter
>> (kernel.user_events_max) to set a global limit that is honored among all
>> groups on the system. This ensures hard limits can be setup to prevent
>> user processes from consuming all event IDs on the system.
> 
> sysctl is good to me, but would we really need the kernel parameter?
> The user_events starts using when user-space is up, so I think setting
> the limit with sysctl is enough.
> 
> BTW, Vlastimil tried to add 'sysctl.*' kernel parameter support(*). If we
> need a kernel cmdline support, I think this is more generic way. But it
> seems the discussion has been stopped.

It was actually merged in 5.8. So sysctl should be sufficient with that.
But maybe it's weird to start adding sysctls, when the rest of tracing
tunables is AFAIK under /sys/kernel/tracing/ ?


> (*) https://patchwork.kernel.org/project/linux-mm/patch/20200427180433.7029-2-vbabka@suse.cz/
> 
> Thank you,
> 
>> 
>> Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
>> ---
>>  kernel/trace/trace_events_user.c | 59 ++++++++++++++++++++++++++++++++
>>  1 file changed, 59 insertions(+)
>> 
>> diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
>> index 222f2eb59c7c..6a5ebe243999 100644
>> --- a/kernel/trace/trace_events_user.c
>> +++ b/kernel/trace/trace_events_user.c
>> @@ -20,6 +20,7 @@
>>  #include <linux/types.h>
>>  #include <linux/uaccess.h>
>>  #include <linux/highmem.h>
>> +#include <linux/init.h>
>>  #include <linux/user_events.h>
>>  #include "trace.h"
>>  #include "trace_dynevent.h"
>> @@ -61,6 +62,12 @@ struct user_event_group {
>>  /* Group for init_user_ns mapping, top-most group */
>>  static struct user_event_group *init_group;
>>  
>> +/* Max allowed events for the whole system */
>> +static unsigned int max_user_events = 32768;
>> +
>> +/* Current number of events on the whole system */
>> +static unsigned int current_user_events;
>> +
>>  /*
>>   * Stores per-event properties, as users register events
>>   * within a file a user_event might be created if it does not
>> @@ -1241,6 +1248,8 @@ static int destroy_user_event(struct user_event *user)
>>  {
>>  	int ret = 0;
>>  
>> +	lockdep_assert_held(&event_mutex);
>> +
>>  	/* Must destroy fields before call removal */
>>  	user_event_destroy_fields(user);
>>  
>> @@ -1257,6 +1266,11 @@ static int destroy_user_event(struct user_event *user)
>>  	kfree(EVENT_NAME(user));
>>  	kfree(user);
>>  
>> +	if (current_user_events > 0)
>> +		current_user_events--;
>> +	else
>> +		pr_alert("BUG: Bad current_user_events\n");
>> +
>>  	return ret;
>>  }
>>  
>> @@ -1744,6 +1758,11 @@ static int user_event_parse(struct user_event_group *group, char *name,
>>  
>>  	mutex_lock(&event_mutex);
>>  
>> +	if (current_user_events >= max_user_events) {
>> +		ret = -EMFILE;
>> +		goto put_user_lock;
>> +	}
>> +
>>  	ret = user_event_trace_register(user);
>>  
>>  	if (ret)
>> @@ -1755,6 +1774,7 @@ static int user_event_parse(struct user_event_group *group, char *name,
>>  	dyn_event_init(&user->devent, &user_event_dops);
>>  	dyn_event_add(&user->devent, &user->call);
>>  	hash_add(group->register_table, &user->node, key);
>> +	current_user_events++;
>>  
>>  	mutex_unlock(&event_mutex);
>>  
>> @@ -2386,6 +2406,43 @@ static int create_user_tracefs(void)
>>  	return -ENODEV;
>>  }
>>  
>> +static int __init set_max_user_events(char *str)
>> +{
>> +	if (!str)
>> +		return 0;
>> +
>> +	if (kstrtouint(str, 0, &max_user_events))
>> +		return 0;
>> +
>> +	return 1;
>> +}
>> +__setup("user_events_max=", set_max_user_events);
>> +
>> +static int set_max_user_events_sysctl(struct ctl_table *table, int write,
>> +				      void *buffer, size_t *lenp, loff_t *ppos)
>> +{
>> +	int ret;
>> +
>> +	mutex_lock(&event_mutex);
>> +
>> +	ret = proc_douintvec(table, write, buffer, lenp, ppos);
>> +
>> +	mutex_unlock(&event_mutex);
>> +
>> +	return ret;
>> +}
>> +
>> +static struct ctl_table user_event_sysctls[] = {
>> +	{
>> +		.procname	= "user_events_max",
>> +		.data		= &max_user_events,
>> +		.maxlen		= sizeof(unsigned int),
>> +		.mode		= 0644,
>> +		.proc_handler	= set_max_user_events_sysctl,
>> +	},
>> +	{}
>> +};
>> +
>>  static int __init trace_events_user_init(void)
>>  {
>>  	int ret;
>> @@ -2415,6 +2472,8 @@ static int __init trace_events_user_init(void)
>>  	if (dyn_event_register(&user_event_dops))
>>  		pr_warn("user_events could not register with dyn_events\n");
>>  
>> +	register_sysctl_init("kernel", user_event_sysctls);
>> +
>>  	return 0;
>>  }
>>  
>> -- 
>> 2.25.1
>> 
> 
> 

