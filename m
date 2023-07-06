Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A74F7494DD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 07:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbjGFFKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 01:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjGFFKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 01:10:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32218B2;
        Wed,  5 Jul 2023 22:10:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 828D3617E0;
        Thu,  6 Jul 2023 05:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F034C433C7;
        Thu,  6 Jul 2023 05:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688620215;
        bh=UmRuzOJt+ryrnFuwX+ytQQxkA5mGM4cYrZAvC81+VW0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nOiFQFT1HxSRxmkGVv0BKxN1bSNrGkM9k0rrQi/q8xjFFDS+FbE4O7QswwAJPr33l
         FONsFjjCfhtmpZYa+ePf2RdY8xMi6aQLoNroCJYDph2EOgj4mQsDEsqFsPZUVKlTOU
         Z1CylwK/DH6fzlHN01+ycm9TbCXXv3diLuSAot3AHa4zbdRaXjB5ZmFHMSHMaOJTn3
         +hUPxvdYxyOZ01DMH2QkNms8f70Gt+ZlzhYN9vuT+JG70RumgxZoapzWR9ZvqB4Ycp
         VOoo8aHVc8sNWtYVUpNYtrecP94vjk8iKcJQX/VjqlbQ3o7tv+HBKzltzGA7aSroqr
         HdtdTpL6AKBOw==
Date:   Thu, 6 Jul 2023 14:10:12 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] fprobe: Ensure running fprobe_exit_handler() finished
 before calling rethook_free()
Message-Id: <20230706141012.c1a0ae0901e0fdec7b3078c7@kernel.org>
In-Reply-To: <20230705212657.5968daf7@gandalf.local.home>
References: <20230628012305.978e34d44f1a53fe20327fde@kernel.org>
        <168796344232.46347.7947681068822514750.stgit@devnote2>
        <20230705212657.5968daf7@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jul 2023 21:26:57 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 28 Jun 2023 23:44:02 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Ensure running fprobe_exit_handler() has finished before
> > calling rethook_free() in the unregister_fprobe() so that caller can free
> > the fprobe right after unregister_fprobe().
> > 
> > unregister_fprobe() ensured that all running fprobe_entry/exit_handler()
> > have finished by calling unregister_ftrace_function() which synchronizes
> > RCU. But commit 5f81018753df ("fprobe: Release rethook after the
> > ftrace_ops is unregistered") changed to call rethook_free() after
> > unregister_ftrace_function(). So call rethook_stop() to make rethook
> > disabled before unregister_ftrace_function() and ensure it again.
> 
> I'm confused. I still don't understand why it is bad to call
> unregister_ftrace_function() *before* rethook_free().
> 
> Can you show the race condition you are trying to avoid?

Yes. This is ensuring all handlers exit when returning from
unregister_fprobe() so that the caller can release the data which will be
accessed from the handlers. The entry handler is safe because
unregister_ftrace_function() waits for the ftrace handlers. But that is
not enough for the exit handler.

With only Jiri's patch, following flow can happen;

------
 CPU1                              CPU2
 call unregister_fprobe()
 ...
                                   __fprobe_handler()
                                   rethook_hook() on probed function
 unregister_ftrace_function()
                                   return from probed function
                                   rethook hooks
                                   find rh->handler == fprobe_exit_handler
                                   call fprobe_exit_handler()
 rethook_free():
   set rh->handler = NULL;
 return from unreigster_fprobe;
                                   call fp->exit_handler() <- (*)

(*) In this point, the exit handler is called after returning from 
unregister_fprobe().
------

So, this patch changes it as following;
------
 CPU1                              CPU2
 call unregister_fprobe()
 ...
 rethook_stop():
   set rh->handler = NULL;
                                   __fprobe_handler()
                                   rethook_hook() on probed function
 unregister_ftrace_function()
                                   return from probed function
                                   rethook hooks
                                   find rh->handler == NULL
                                   return from rethook
 rethook_free()
 return from unreigster_fprobe;
------

I can also just put a synchronize_sched_rcu() right after rethook_free()
to wait for all running fprobe_exit_handler() too.

Thank you,

> 
> -- Steve
> 
> 
> 
> > 
> > Fixes: 5f81018753df ("fprobe: Release rethook after the ftrace_ops is
> > unregistered") Cc: stable@vger.kernel.org
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  include/linux/rethook.h |    1 +
> >  kernel/trace/fprobe.c   |    3 +++
> >  kernel/trace/rethook.c  |   13 +++++++++++++
> >  3 files changed, 17 insertions(+)
> > 
> > diff --git a/include/linux/rethook.h b/include/linux/rethook.h
> > index c8ac1e5afcd1..bdbe6717f45a 100644
> > --- a/include/linux/rethook.h
> > +++ b/include/linux/rethook.h
> > @@ -59,6 +59,7 @@ struct rethook_node {
> >  };
> >  
> >  struct rethook *rethook_alloc(void *data, rethook_handler_t handler);
> > +void rethook_stop(struct rethook *rh);
> >  void rethook_free(struct rethook *rh);
> >  void rethook_add_node(struct rethook *rh, struct rethook_node *node);
> >  struct rethook_node *rethook_try_get(struct rethook *rh);
> > diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> > index 0121e8c0d54e..75517667b54f 100644
> > --- a/kernel/trace/fprobe.c
> > +++ b/kernel/trace/fprobe.c
> > @@ -364,6 +364,9 @@ int unregister_fprobe(struct fprobe *fp)
> >  		    fp->ops.saved_func != fprobe_kprobe_handler))
> >  		return -EINVAL;
> >  
> > +	if (fp->rethook)
> > +		rethook_stop(fp->rethook);
> > +
> >  	ret = unregister_ftrace_function(&fp->ops);
> >  	if (ret < 0)
> >  		return ret;
> > diff --git a/kernel/trace/rethook.c b/kernel/trace/rethook.c
> > index 60f6cb2b486b..468006cce7ca 100644
> > --- a/kernel/trace/rethook.c
> > +++ b/kernel/trace/rethook.c
> > @@ -53,6 +53,19 @@ static void rethook_free_rcu(struct rcu_head *head)
> >  		kfree(rh);
> >  }
> >  
> > +/**
> > + * rethook_stop() - Stop using a rethook.
> > + * @rh: the struct rethook to stop.
> > + *
> > + * Stop using a rethook to prepare for freeing it. If you want to wait
> > for
> > + * all running rethook handler before calling rethook_free(), you need to
> > + * call this first and wait RCU, and call rethook_free().
> > + */
> > +void rethook_stop(struct rethook *rh)
> > +{
> > +	WRITE_ONCE(rh->handler, NULL);
> > +}
> > +
> >  /**
> >   * rethook_free() - Free struct rethook.
> >   * @rh: the struct rethook to be freed.
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
