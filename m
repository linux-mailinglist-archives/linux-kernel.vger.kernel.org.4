Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5956A6C6DCF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 17:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbjCWQhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 12:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbjCWQgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 12:36:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFAD399E2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 09:35:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7A78627F6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 16:34:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6552BC433EF;
        Thu, 23 Mar 2023 16:34:57 +0000 (UTC)
Date:   Thu, 23 Mar 2023 12:34:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        "Jose E. Marchesi" <jose.marchesi@oracle.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracepoint: Fix CFI failures with tp_stub_func
Message-ID: <20230323123455.36dd83f6@gandalf.local.home>
In-Reply-To: <ZBx9+ZyiF6LoKbPr@FVFF77S0Q05N.cambridge.arm.com>
References: <20230323114012.2162285-1-mark.rutland@arm.com>
        <20230323085321.0f8d1b98@gandalf.local.home>
        <ZBxX/uu/s5IKBQOw@FVFF77S0Q05N.cambridge.arm.com>
        <ZBx9+ZyiF6LoKbPr@FVFF77S0Q05N.cambridge.arm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Mar 2023 16:27:37 +0000
Mark Rutland <mark.rutland@arm.com> wrote:

> On Thu, Mar 23, 2023 at 01:45:34PM +0000, Mark Rutland wrote:
> > On Thu, Mar 23, 2023 at 08:53:21AM -0400, Steven Rostedt wrote:  
> > > On Thu, 23 Mar 2023 11:40:12 +0000
> > > Mark Rutland <mark.rutland@arm.com> wrote:  
> 
> > > > diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> > > > index 6811e43c1b5c2..1640926441910 100644
> > > > --- a/include/linux/tracepoint.h
> > > > +++ b/include/linux/tracepoint.h
> > > > @@ -303,6 +303,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
> > > >  	__section("__tracepoints_strings") = #_name;			\
> > > >  	extern struct static_call_key STATIC_CALL_KEY(tp_func_##_name);	\
> > > >  	int __traceiter_##_name(void *__data, proto);			\
> > > > +	void __tracestub_##_name(void *, proto);			\
> > > >  	struct tracepoint __tracepoint_##_name	__used			\
> > > >  	__section("__tracepoints") = {					\
> > > >  		.name = __tpstrtab_##_name,				\
> > > > @@ -310,6 +311,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
> > > >  		.static_call_key = &STATIC_CALL_KEY(tp_func_##_name),	\
> > > >  		.static_call_tramp = STATIC_CALL_TRAMP_ADDR(tp_func_##_name), \
> > > >  		.iterator = &__traceiter_##_name,			\
> > > > +		.stub = &__tracestub_##_name,				\
> > > >  		.regfunc = _reg,					\
> > > >  		.unregfunc = _unreg,					\
> > > >  		.funcs = NULL };					\
> > > > @@ -330,6 +332,9 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
> > > >  		}							\
> > > >  		return 0;						\
> > > >  	}								\
> > > > +	void __tracestub_##_name(void *__data, proto)			\
> > > > +	{								\
> > > > +	}								\  
> > > 
> > > I purposely did not do this because this adds over a thousand stub
> > > functions! It adds one for *every* tracepoint (and that is a superset of
> > > trace events).
> > > 
> > > Is there some other way we could do this?
> > > 
> > > C really really needs a way to make a generic void do_nothing(...) function!
> > > 
> > > I added some compiler folks to the Cc to hear our grievances.  
> > 
> > I pulled in Sami, who did much of the kCFI work, and PeterZ too...
> > 
> > We can't have a generic function that's compatible will all function
> > prototypes, since that mechanism would undermine the CFI scheme. Either callers
> > would always have to omit the check, or we're have to have a special "always
> > compatible" type hash, and both would be gigantic targets for attack.
> > 
> > Can we avoid the stub entirely? e.g. make hte call conditional on the func
> > pointer not being some bad value (e.g. like the error pointers?). That way we
> > could avoid the call, and we wouldn't need the stub implementation.  
> 
> Along those lines (and as Peter also suggested over IRC), would something like
> the below be preferable?

So we had this discussion a while ago:

See befe6d946551 ("tracepoint: Do not fail unregistering a probe due to memory failure")

Where I believe one answer was to use NULL instead of a stub.

I have to go back and re-read that thread. Mathieu was involved with all
this too.

And as I mentioned in my other reply. There was a more complex solution
that could handle this if the stub solution ended up being an issue.

Repeated again so Mathieu doesn't have to search for it.

    [ Note, this version does use undefined compiler behavior (assuming that
      a stub function with no parameters or return, can be called by a location
      that thinks it has parameters but still no return value. Static calls
      do the same thing, so this trick is not without precedent.

      There's another solution that uses RCU tricks and is more complex, but
      can be an alternative if this solution becomes an issue.

      Link: https://lore.kernel.org/lkml/20210127170721.58bce7cc@gandalf.local.home/
    ]

-- Steve


> 
> Mark.
> 
> ---->8----  
> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> index 6811e43c1b5c..b8017e906049 100644
> --- a/include/linux/tracepoint.h
> +++ b/include/linux/tracepoint.h
> @@ -33,6 +33,8 @@ struct trace_eval_map {
>  
>  #define TRACEPOINT_DEFAULT_PRIO	10
>  
> +void tp_stub_func(void);
> +
>  extern struct srcu_struct tracepoint_srcu;
>  
>  extern int
> @@ -324,6 +326,8 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>  		if (it_func_ptr) {					\
>  			do {						\
>  				it_func = READ_ONCE((it_func_ptr)->func); \
> +				if (it_func == tp_stub_func)		\
> +					continue;			\
>  				__data = (it_func_ptr)->data;		\
>  				((void(*)(void *, proto))(it_func))(__data, args); \
>  			} while ((++it_func_ptr)->func);		\
> diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
> index 8d1507dd0724..dcf5a637429f 100644
> --- a/kernel/tracepoint.c
> +++ b/kernel/tracepoint.c
> @@ -99,7 +99,7 @@ struct tp_probes {
>  };
>  
>  /* Called in removal of a func but failed to allocate a new tp_funcs */
> -static void tp_stub_func(void)
> +void tp_stub_func(void)
>  {
>  	return;
>  }

