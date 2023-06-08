Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC911728A34
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 23:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237030AbjFHVXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 17:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236177AbjFHVXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 17:23:07 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 159E62D51;
        Thu,  8 Jun 2023 14:23:06 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.27.212])
        by linux.microsoft.com (Postfix) with ESMTPSA id 47F3E20C145C;
        Thu,  8 Jun 2023 14:23:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 47F3E20C145C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1686259385;
        bh=Nvrn68Ucat+XefKIbkKsoNwVILT76QIukgyRjjI67b8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qo0M3T/QCmZMtpJ2HLB404s0zg8InmVkCqpBZL/o/ipvc+HGmwQlq7A/CqvEFmclK
         EpawRhNjfgB+2pvPNsQJhDtftkrbBfRB9aTcBPh2JJ2bDyIIkFJn3N7t7xB3IZ0vqI
         UKMVcZobolxtIM3UwHSvOMyv4oGWWeln+5FDvPNQ=
Date:   Thu, 8 Jun 2023 14:22:56 -0700
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, ast@kernel.org,
        dcook@linux.microsoft.com
Subject: Re: [PATCH v2 3/5] tracing/user_events: Add auto cleanup and a flag
 to persist events
Message-ID: <20230608212256.GA134@W11-BEAU-MD.localdomain>
References: <20230605233900.2838-1-beaub@linux.microsoft.com>
 <20230605233900.2838-4-beaub@linux.microsoft.com>
 <20230608162557.00be5f89@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608162557.00be5f89@gandalf.local.home>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 04:25:57PM -0400, Steven Rostedt wrote:
> On Mon,  5 Jun 2023 16:38:58 -0700
> Beau Belgrave <beaub@linux.microsoft.com> wrote:
> 
> > Currently user events need to be manually deleted via the delete IOCTL
> > call or via the dynamic_events file. Most operators and processes wish
> > to have these events auto cleanup when they are no longer used by
> > anything to prevent them piling without manual maintenance. However,
> > some operators may not want this, such as pre-registering events via the
> > dynamic_events tracefs file.
> > 
> > Add a persist flag to user facing header and honor it within the
> > register IOCTL call. Add max flag as well to ensure that only known
> > flags can be used now and in the future. Update user_event_put() to
> > attempt an auto delete of the event if it's the last reference. The
> > auto delete must run in a work queue to ensure proper behavior of
> > class->reg() invocations that don't expect the call to go away from
> > underneath them during the unregister. Add work_struct to user_event
> > struct to ensure we can do this reliably.
> > 
> > Link: https://lore.kernel.org/linux-trace-kernel/20230518093600.3f119d68@rorschach.local.home/
> 
> Since there still seems to be some controversy over the persistent events,
> could we hold off on implementing them until next merge window? That is, I
> would like to only have the fd owned events for this release, which would
> give us time to hash out any of the issues with persistent events.
> 
> If they are not in, then they are not an API, but once they are in, then we
> are stuck with them. I believe everyone is fine with the fd owned events,
> right?
> 

I am fine with this approach, however, FD owned events only means that
anyone using the /sys/kernel/tracing/dynamic_events will have the event
deleted immediately.

Should we flat out issue an error instead of having it work, but then
removed immediately?

NOTE:
I'm waiting for the other user_event patches to land in the tracing
for-next since there will be conflicts and I want to make sure I get
good coverage with catching all the put/get refs.

> > 
> > Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> > Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
> > ---
> >  include/uapi/linux/user_events.h |  10 ++-
> >  kernel/trace/trace_events_user.c | 118 +++++++++++++++++++++++++++----
> >  2 files changed, 114 insertions(+), 14 deletions(-)
> > 
> >
> 
> That is we can keep all the code of this patch, but:
> 
> >  static __always_inline __must_check
> > @@ -1609,7 +1695,8 @@ static int user_event_create(const char *raw_command)
> >  
> >  	mutex_lock(&group->reg_mutex);
> >  
> > -	ret = user_event_parse_cmd(group, name, &user, 0);
> > +	/* Dyn events persist, otherwise they would cleanup immediately */
> > +	ret = user_event_parse_cmd(group, name, &user, USER_EVENT_REG_PERSIST);
> >  
> >  	if (!ret)
> >  		user_event_put(user, false);
> > @@ -1843,8 +1930,13 @@ static int user_event_parse(struct user_event_group *group, char *name,
> >  
> 
> Add here:
> 
> 	if (reg_flags) {
> 		/* Holding off implementing PERSIST events */
> 		ret = -EINVAL;
> 		goto put_user_lock;
> 	}
> 
> Which also reminds me. We should return EINVAL if any flags that we do not
> know about is set. Otherwise when we do implement new flags, the user will
> not know if they are taking effect or not.
> 

We do that in user_reg_get, but point taken, some flag could come
through dynamic_events interface and then we'd miss it.

Thanks,
-Beau

> -- Steve
> 
> 
> >  	user->reg_flags = reg_flags;
> >  
> > -	/* Ensure we track self ref and caller ref (2) */
> > -	refcount_set(&user->refcnt, 2);
> > +	if (user->reg_flags & USER_EVENT_REG_PERSIST) {
> > +		/* Ensure we track self ref and caller ref (2) */
> > +		refcount_set(&user->refcnt, 2);
> > +	} else {
> > +		/* Ensure we track only caller ref (1) */
> > +		refcount_set(&user->refcnt, 1);
> > +	}
> >  
> >  	dyn_event_init(&user->devent, &user_event_dops);
> >  	dyn_event_add(&user->devent, &user->call);
> > @@ -2066,8 +2158,8 @@ static long user_reg_get(struct user_reg __user *ureg, struct user_reg *kreg)
> >  	if (ret)
> >  		return ret;
> >  
> > -	/* Ensure no flags, since we don't support any yet */
> > -	if (kreg->flags != 0)
> > +	/* Ensure only valid flags */
> > +	if (kreg->flags & ~(USER_EVENT_REG_MAX-1))
> >  		return -EINVAL;
> >  
> >  	/* Ensure supported size */
