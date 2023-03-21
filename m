Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 870706C2F3A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 11:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjCUKkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 06:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjCUKkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 06:40:35 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9273F969;
        Tue, 21 Mar 2023 03:40:30 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id l12so13127641wrm.10;
        Tue, 21 Mar 2023 03:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679395229;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dj2Qn6oeOgRBAl4RZUHns/bCgUMdKYR3c35f0yuuFQk=;
        b=lX81PpD2FVxMC5jLUTnjzORBN/4dg68aqqBZHoqbGFGlUGlGMDpYS62ZOjfdpBRLNh
         hbmD0ofkoE0aYFOcO1oCcG66gZrbcDJJbJexY7eai8s6LHqrGmzYYv2p82g+PEM0W+88
         RfAq90w2sK4jkgMI/qWGWB5D7SXo1sb9OAoT3EgQTpEXVRw7ttNGNuzns+wzyHCmzmzE
         8f2t9IVIqSGj7+bTrNh2Al5R9ohFJwsXzjXd3mwn4K3U+cRgYlKHf0LXGUqBmQw+dWSZ
         wtqQVFlmHj91xYIC08smsu5MTUGLRTw84Iug3tEiwdQAHyxdmp0ZESA1K78Y65IeySRL
         qK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679395229;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dj2Qn6oeOgRBAl4RZUHns/bCgUMdKYR3c35f0yuuFQk=;
        b=IelbE/Zbi5Sf8BjTCJUh3vKHkyc8tISrUxAzV99BDsduyCgYMQIsO1niapiJ94SAap
         uNLJ2YUYn5beJKePcMrIUGWUEfgQcyQHJAw27S75Ag+7idhl+cUsrF2nEedLfzEnmpu3
         q0iy5ZFaam6tOtZnyNii1js20cU2DvlDWzot46tNMIQSdcA0p+KeIZ8iV35v5E6dyfiS
         QDFZmmMZVHDEXzAFOY+r7vhhVf0MCUnnutBiST2VOUo60bWFB8PvpwTCdWoPk3w2E8PG
         sclpwK6EEQfPhnBSFqWWJbNxG6rjnWv+mLu70fSvP77e2RLVsvojj/3T9bKJVt2Eya5J
         JiNA==
X-Gm-Message-State: AO0yUKXb5VeMDw6r5Egqb3R7e+6qscx9Xug6HN78yurQMCGsV5MTRipk
        rwqOnVc7HjELd9qd6UCbr9k=
X-Google-Smtp-Source: AK7set9Y+oOsTYzkxKCUS9hHGgVu/zZ4V8SCWWcLVRSYbQUX6isF/J+3eZ0+wK3jiM1bqPZ9zEcG0Q==
X-Received: by 2002:a5d:448e:0:b0:2d8:28a9:f9e6 with SMTP id j14-20020a5d448e000000b002d828a9f9e6mr1813360wrq.32.1679395228974;
        Tue, 21 Mar 2023 03:40:28 -0700 (PDT)
Received: from krava (net-93-147-243-166.cust.vodafonedsl.it. [93.147.243.166])
        by smtp.gmail.com with ESMTPSA id m9-20020adffa09000000b002c70d97af78sm11049879wrr.85.2023.03.21.03.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 03:40:28 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 21 Mar 2023 11:40:24 +0100
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Florent Revest <revest@chromium.org>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kpsingh@kernel.org
Subject: Re: [PATCH 1/7] ftrace: Let unregister_ftrace_direct_multi() call
 ftrace_free_filter()
Message-ID: <ZBmJmKlfwvur8A54@krava>
References: <20230316173811.1223508-1-revest@chromium.org>
 <20230316173811.1223508-2-revest@chromium.org>
 <ZBl9JahKr+50sBW0@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBl9JahKr+50sBW0@FVFF77S0Q05N>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 09:47:17AM +0000, Mark Rutland wrote:
> On Thu, Mar 16, 2023 at 06:38:05PM +0100, Florent Revest wrote:
> > A common pattern when using the ftrace_direct_multi API is to unregister
> > the ops and also immediately free its filter. We've noticed it's very
> > easy for users to miss calling ftrace_free_filter().
> > 
> > This adds a "free_filters" argument to unregister_ftrace_direct_multi()
> > to both remind the user they should free filters and also to make their
> > life easier.
> > 
> > Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> > Signed-off-by: Florent Revest <revest@chromium.org>
> > ---
> >  include/linux/ftrace.h                      | 6 ++++--
> >  kernel/bpf/trampoline.c                     | 2 +-
> >  kernel/trace/ftrace.c                       | 6 +++++-
> >  samples/ftrace/ftrace-direct-multi-modify.c | 3 +--
> >  samples/ftrace/ftrace-direct-multi.c        | 3 +--
> >  5 files changed, 12 insertions(+), 8 deletions(-)
> 
> This looks good to me; I see that the BPF code frees the filter in
> bpf_trampoline_put(), so it not doing so via unregister_ftrace_direct_multi()
> looks fine. FWIW:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>

yes, I was going to ack the next version ;-)

thanks,
jirka

> 
> Mark.
> 
> > 
> > diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> > index 366c730beaa3..5b68ee874bc1 100644
> > --- a/include/linux/ftrace.h
> > +++ b/include/linux/ftrace.h
> > @@ -407,7 +407,8 @@ int ftrace_modify_direct_caller(struct ftrace_func_entry *entry,
> >  				unsigned long new_addr);
> >  unsigned long ftrace_find_rec_direct(unsigned long ip);
> >  int register_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr);
> > -int unregister_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr);
> > +int unregister_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr,
> > +				   bool free_filters);
> >  int modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr);
> >  int modify_ftrace_direct_multi_nolock(struct ftrace_ops *ops, unsigned long addr);
> >  
> > @@ -446,7 +447,8 @@ static inline int register_ftrace_direct_multi(struct ftrace_ops *ops, unsigned
> >  {
> >  	return -ENODEV;
> >  }
> > -static inline int unregister_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
> > +static inline int unregister_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr,
> > +						 bool free_filters)
> >  {
> >  	return -ENODEV;
> >  }
> > diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> > index d0ed7d6f5eec..88bc23f1e10a 100644
> > --- a/kernel/bpf/trampoline.c
> > +++ b/kernel/bpf/trampoline.c
> > @@ -198,7 +198,7 @@ static int unregister_fentry(struct bpf_trampoline *tr, void *old_addr)
> >  	int ret;
> >  
> >  	if (tr->func.ftrace_managed)
> > -		ret = unregister_ftrace_direct_multi(tr->fops, (long)old_addr);
> > +		ret = unregister_ftrace_direct_multi(tr->fops, (long)old_addr, false);
> >  	else
> >  		ret = bpf_arch_text_poke(ip, BPF_MOD_CALL, old_addr, NULL);
> >  
> > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > index 29baa97d0d53..fa379cf91fdb 100644
> > --- a/kernel/trace/ftrace.c
> > +++ b/kernel/trace/ftrace.c
> > @@ -5804,7 +5804,8 @@ EXPORT_SYMBOL_GPL(register_ftrace_direct_multi);
> >   *  0 on success
> >   *  -EINVAL - The @ops object was not properly registered.
> >   */
> > -int unregister_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
> > +int unregister_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr,
> > +				   bool free_filters)
> >  {
> >  	struct ftrace_hash *hash = ops->func_hash->filter_hash;
> >  	int err;
> > @@ -5822,6 +5823,9 @@ int unregister_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
> >  	/* cleanup for possible another register call */
> >  	ops->func = NULL;
> >  	ops->trampoline = 0;
> > +
> > +	if (free_filters)
> > +		ftrace_free_filter(ops);
> >  	return err;
> >  }
> >  EXPORT_SYMBOL_GPL(unregister_ftrace_direct_multi);
> > diff --git a/samples/ftrace/ftrace-direct-multi-modify.c b/samples/ftrace/ftrace-direct-multi-modify.c
> > index b58c594efb51..196b43971cb5 100644
> > --- a/samples/ftrace/ftrace-direct-multi-modify.c
> > +++ b/samples/ftrace/ftrace-direct-multi-modify.c
> > @@ -151,8 +151,7 @@ static int __init ftrace_direct_multi_init(void)
> >  static void __exit ftrace_direct_multi_exit(void)
> >  {
> >  	kthread_stop(simple_tsk);
> > -	unregister_ftrace_direct_multi(&direct, my_tramp);
> > -	ftrace_free_filter(&direct);
> > +	unregister_ftrace_direct_multi(&direct, my_tramp, true);
> >  }
> >  
> >  module_init(ftrace_direct_multi_init);
> > diff --git a/samples/ftrace/ftrace-direct-multi.c b/samples/ftrace/ftrace-direct-multi.c
> > index c27cf130c319..ea0e88ee5e43 100644
> > --- a/samples/ftrace/ftrace-direct-multi.c
> > +++ b/samples/ftrace/ftrace-direct-multi.c
> > @@ -78,8 +78,7 @@ static int __init ftrace_direct_multi_init(void)
> >  
> >  static void __exit ftrace_direct_multi_exit(void)
> >  {
> > -	unregister_ftrace_direct_multi(&direct, (unsigned long) my_tramp);
> > -	ftrace_free_filter(&direct);
> > +	unregister_ftrace_direct_multi(&direct, (unsigned long) my_tramp, true);
> >  }
> >  
> >  module_init(ftrace_direct_multi_init);
> > -- 
> > 2.40.0.rc2.332.ga46443480c-goog
> > 
