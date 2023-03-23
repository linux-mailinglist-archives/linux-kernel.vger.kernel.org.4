Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0A76C6DB4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 17:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbjCWQe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 12:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbjCWQea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 12:34:30 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 582B538B47
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 09:33:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF29D2F4;
        Thu, 23 Mar 2023 09:33:38 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.31.167])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F2E0F3F766;
        Thu, 23 Mar 2023 09:32:53 -0700 (PDT)
Date:   Thu, 23 Mar 2023 16:32:51 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        "Jose E. Marchesi" <jose.marchesi@oracle.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] tracepoint: Fix CFI failures with tp_stub_func
Message-ID: <ZBx/M+bwvywwHo0z@FVFF77S0Q05N.cambridge.arm.com>
References: <20230323114012.2162285-1-mark.rutland@arm.com>
 <20230323085321.0f8d1b98@gandalf.local.home>
 <20230323122650.5a1f2db7@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323122650.5a1f2db7@gandalf.local.home>
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 12:26:50PM -0400, Steven Rostedt wrote:
> On Thu, 23 Mar 2023 08:53:21 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > > --- a/include/linux/tracepoint.h
> > > +++ b/include/linux/tracepoint.h
> > > @@ -303,6 +303,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
> > >  	__section("__tracepoints_strings") = #_name;			\
> > >  	extern struct static_call_key STATIC_CALL_KEY(tp_func_##_name);	\
> > >  	int __traceiter_##_name(void *__data, proto);			\
> > > +	void __tracestub_##_name(void *, proto);			\
> > >  	struct tracepoint __tracepoint_##_name	__used			\
> > >  	__section("__tracepoints") = {					\
> > >  		.name = __tpstrtab_##_name,				\
> > > @@ -310,6 +311,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
> > >  		.static_call_key = &STATIC_CALL_KEY(tp_func_##_name),	\
> > >  		.static_call_tramp = STATIC_CALL_TRAMP_ADDR(tp_func_##_name), \
> > >  		.iterator = &__traceiter_##_name,			\
> > > +		.stub = &__tracestub_##_name,				\
> > >  		.regfunc = _reg,					\
> > >  		.unregfunc = _unreg,					\
> > >  		.funcs = NULL };					\
> > > @@ -330,6 +332,9 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
> > >  		}							\
> > >  		return 0;						\
> > >  	}								\
> > > +	void __tracestub_##_name(void *__data, proto)			\
> > > +	{								\
> > > +	}								\  
> > 
> > I purposely did not do this because this adds over a thousand stub
> > functions! It adds one for *every* tracepoint (and that is a superset of
> > trace events).
> 
> And the commit that added this code:
> 
>   befe6d946551 ("tracepoint: Do not fail unregistering a probe due to memory failure")
> 
> Has this in the change log:
> 
>     [ Note, this version does use undefined compiler behavior (assuming that
>       a stub function with no parameters or return, can be called by a location
>       that thinks it has parameters but still no return value. Static calls
>       do the same thing, so this trick is not without precedent.
> 
>       There's another solution that uses RCU tricks and is more complex, but
>       can be an alternative if this solution becomes an issue.
> 
>       Link: https://lore.kernel.org/lkml/20210127170721.58bce7cc@gandalf.local.home/
>     ]

FWIW, I'd be happy with that approach too -- we just happened to race with our
last replies. :)

Mark.
