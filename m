Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 212D5728958
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 22:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234054AbjFHU0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 16:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbjFHU0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 16:26:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513D02D68;
        Thu,  8 Jun 2023 13:26:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9EE361575;
        Thu,  8 Jun 2023 20:26:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6189FC4339B;
        Thu,  8 Jun 2023 20:25:59 +0000 (UTC)
Date:   Thu, 8 Jun 2023 16:25:57 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, ast@kernel.org,
        dcook@linux.microsoft.com
Subject: Re: [PATCH v2 3/5] tracing/user_events: Add auto cleanup and a flag
 to persist events
Message-ID: <20230608162557.00be5f89@gandalf.local.home>
In-Reply-To: <20230605233900.2838-4-beaub@linux.microsoft.com>
References: <20230605233900.2838-1-beaub@linux.microsoft.com>
        <20230605233900.2838-4-beaub@linux.microsoft.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  5 Jun 2023 16:38:58 -0700
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> Currently user events need to be manually deleted via the delete IOCTL
> call or via the dynamic_events file. Most operators and processes wish
> to have these events auto cleanup when they are no longer used by
> anything to prevent them piling without manual maintenance. However,
> some operators may not want this, such as pre-registering events via the
> dynamic_events tracefs file.
> 
> Add a persist flag to user facing header and honor it within the
> register IOCTL call. Add max flag as well to ensure that only known
> flags can be used now and in the future. Update user_event_put() to
> attempt an auto delete of the event if it's the last reference. The
> auto delete must run in a work queue to ensure proper behavior of
> class->reg() invocations that don't expect the call to go away from
> underneath them during the unregister. Add work_struct to user_event
> struct to ensure we can do this reliably.
> 
> Link: https://lore.kernel.org/linux-trace-kernel/20230518093600.3f119d68@rorschach.local.home/

Since there still seems to be some controversy over the persistent events,
could we hold off on implementing them until next merge window? That is, I
would like to only have the fd owned events for this release, which would
give us time to hash out any of the issues with persistent events.

If they are not in, then they are not an API, but once they are in, then we
are stuck with them. I believe everyone is fine with the fd owned events,
right?

> 
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
> ---
>  include/uapi/linux/user_events.h |  10 ++-
>  kernel/trace/trace_events_user.c | 118 +++++++++++++++++++++++++++----
>  2 files changed, 114 insertions(+), 14 deletions(-)
> 
>

That is we can keep all the code of this patch, but:

>  static __always_inline __must_check
> @@ -1609,7 +1695,8 @@ static int user_event_create(const char *raw_command)
>  
>  	mutex_lock(&group->reg_mutex);
>  
> -	ret = user_event_parse_cmd(group, name, &user, 0);
> +	/* Dyn events persist, otherwise they would cleanup immediately */
> +	ret = user_event_parse_cmd(group, name, &user, USER_EVENT_REG_PERSIST);
>  
>  	if (!ret)
>  		user_event_put(user, false);
> @@ -1843,8 +1930,13 @@ static int user_event_parse(struct user_event_group *group, char *name,
>  

Add here:

	if (reg_flags) {
		/* Holding off implementing PERSIST events */
		ret = -EINVAL;
		goto put_user_lock;
	}

Which also reminds me. We should return EINVAL if any flags that we do not
know about is set. Otherwise when we do implement new flags, the user will
not know if they are taking effect or not.

-- Steve


>  	user->reg_flags = reg_flags;
>  
> -	/* Ensure we track self ref and caller ref (2) */
> -	refcount_set(&user->refcnt, 2);
> +	if (user->reg_flags & USER_EVENT_REG_PERSIST) {
> +		/* Ensure we track self ref and caller ref (2) */
> +		refcount_set(&user->refcnt, 2);
> +	} else {
> +		/* Ensure we track only caller ref (1) */
> +		refcount_set(&user->refcnt, 1);
> +	}
>  
>  	dyn_event_init(&user->devent, &user_event_dops);
>  	dyn_event_add(&user->devent, &user->call);
> @@ -2066,8 +2158,8 @@ static long user_reg_get(struct user_reg __user *ureg, struct user_reg *kreg)
>  	if (ret)
>  		return ret;
>  
> -	/* Ensure no flags, since we don't support any yet */
> -	if (kreg->flags != 0)
> +	/* Ensure only valid flags */
> +	if (kreg->flags & ~(USER_EVENT_REG_MAX-1))
>  		return -EINVAL;
>  
>  	/* Ensure supported size */

