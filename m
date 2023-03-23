Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5AC6C6D73
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 17:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjCWQ1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 12:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjCWQ1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 12:27:43 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5C0F610CE
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 09:27:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25A9E2F4;
        Thu, 23 Mar 2023 09:28:26 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.31.167])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DEF793F766;
        Thu, 23 Mar 2023 09:27:40 -0700 (PDT)
Date:   Thu, 23 Mar 2023 16:27:37 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        "Jose E. Marchesi" <jose.marchesi@oracle.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] tracepoint: Fix CFI failures with tp_stub_func
Message-ID: <ZBx9+ZyiF6LoKbPr@FVFF77S0Q05N.cambridge.arm.com>
References: <20230323114012.2162285-1-mark.rutland@arm.com>
 <20230323085321.0f8d1b98@gandalf.local.home>
 <ZBxX/uu/s5IKBQOw@FVFF77S0Q05N.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBxX/uu/s5IKBQOw@FVFF77S0Q05N.cambridge.arm.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 01:45:34PM +0000, Mark Rutland wrote:
> On Thu, Mar 23, 2023 at 08:53:21AM -0400, Steven Rostedt wrote:
> > On Thu, 23 Mar 2023 11:40:12 +0000
> > Mark Rutland <mark.rutland@arm.com> wrote:

> > > diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> > > index 6811e43c1b5c2..1640926441910 100644
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
> > 
> > Is there some other way we could do this?
> > 
> > C really really needs a way to make a generic void do_nothing(...) function!
> > 
> > I added some compiler folks to the Cc to hear our grievances.
> 
> I pulled in Sami, who did much of the kCFI work, and PeterZ too...
> 
> We can't have a generic function that's compatible will all function
> prototypes, since that mechanism would undermine the CFI scheme. Either callers
> would always have to omit the check, or we're have to have a special "always
> compatible" type hash, and both would be gigantic targets for attack.
> 
> Can we avoid the stub entirely? e.g. make hte call conditional on the func
> pointer not being some bad value (e.g. like the error pointers?). That way we
> could avoid the call, and we wouldn't need the stub implementation.

Along those lines (and as Peter also suggested over IRC), would something like
the below be preferable?

Mark.

---->8----
diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 6811e43c1b5c..b8017e906049 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -33,6 +33,8 @@ struct trace_eval_map {
 
 #define TRACEPOINT_DEFAULT_PRIO	10
 
+void tp_stub_func(void);
+
 extern struct srcu_struct tracepoint_srcu;
 
 extern int
@@ -324,6 +326,8 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 		if (it_func_ptr) {					\
 			do {						\
 				it_func = READ_ONCE((it_func_ptr)->func); \
+				if (it_func == tp_stub_func)		\
+					continue;			\
 				__data = (it_func_ptr)->data;		\
 				((void(*)(void *, proto))(it_func))(__data, args); \
 			} while ((++it_func_ptr)->func);		\
diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 8d1507dd0724..dcf5a637429f 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -99,7 +99,7 @@ struct tp_probes {
 };
 
 /* Called in removal of a func but failed to allocate a new tp_funcs */
-static void tp_stub_func(void)
+void tp_stub_func(void)
 {
 	return;
 }
