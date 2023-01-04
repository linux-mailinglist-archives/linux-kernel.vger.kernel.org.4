Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B5465D741
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 16:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjADPaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 10:30:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjADPaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 10:30:21 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8F4A11B9DD;
        Wed,  4 Jan 2023 07:30:20 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14DF4165C;
        Wed,  4 Jan 2023 07:31:02 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.37.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 601133F23F;
        Wed,  4 Jan 2023 07:30:19 -0800 (PST)
Date:   Wed, 4 Jan 2023 15:30:16 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, revest@chromium.org,
        rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] ftrace: Export ftrace_free_filter() to modules
Message-ID: <Y7WbiBXwdhwCMrEz@FVFF77S0Q05N>
References: <20230103124912.2948963-1-mark.rutland@arm.com>
 <20230103124912.2948963-3-mark.rutland@arm.com>
 <20230104235149.2416d0b57f6fba0f2f31ba77@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104235149.2416d0b57f6fba0f2f31ba77@kernel.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 11:51:49PM +0900, Masami Hiramatsu wrote:
> On Tue,  3 Jan 2023 12:49:11 +0000
> Mark Rutland <mark.rutland@arm.com> wrote:
> 
> > Setting filters on an ftrace ops results in some memory being allocated
> > for the filter hashes, which must be freed before the ops can be freed.
> > This can be done by removing every individual element of the hash by
> > calling ftrace_set_filter_ip() or ftrace_set_filter_ips() with `remove`
> > set, but this is somewhat error prone as it's easy to forget to remove
> > an element.
> > 
> > Make it easier to clean this up by exporting ftrace_free_filter(), which
> > can be used to clean up all of the filter hashes after an ftrace_ops has
> > been unregistered.
> > 
> > Using this, fix the ftrace-direct* samples to free hashes prior to being
> > unloaded. All other code either removes individual filters explicitly or
> > is built-in and already calls ftrace_free_filter().
> 
> So, it seems to fix memory leaks. Then, it may need to go to stable.
> 
> Fixes: e1067a07cfbc ("ftrace/samples: Add module to test multi direct modify interface")
> Fixes: 5fae941b9a6f ("ftrace/samples: Add multi direct interface test module")
> Cc: stable@vger.kernel.org
> 
> And 
> 
> Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Thanks!

Thanks!

Assuming Steve is also happy with the series, I assume one of you two will pick
this up and fold those in.

I've folded all those tags in my local branch (and pushed that to my
ftrace/ops-sample branch on kernel.org), so if you'd prefer I post a v3 with
those I'm quite happy to do so.

Thanks,
Mark.

> 
> > 
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > Cc: Florent Revest <revest@chromium.org>
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  kernel/trace/ftrace.c                       | 23 ++++++++++++++++++++-
> >  samples/ftrace/ftrace-direct-multi-modify.c |  1 +
> >  samples/ftrace/ftrace-direct-multi.c        |  1 +
> >  3 files changed, 24 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > index 442438b93fe98..750aa3f08b25a 100644
> > --- a/kernel/trace/ftrace.c
> > +++ b/kernel/trace/ftrace.c
> > @@ -1248,12 +1248,17 @@ static void free_ftrace_hash_rcu(struct ftrace_hash *hash)
> >  	call_rcu(&hash->rcu, __free_ftrace_hash_rcu);
> >  }
> >  
> > +/**
> > + * ftrace_free_filter - remove all filters for an ftrace_ops
> > + * @ops - the ops to remove the filters from
> > + */
> >  void ftrace_free_filter(struct ftrace_ops *ops)
> >  {
> >  	ftrace_ops_init(ops);
> >  	free_ftrace_hash(ops->func_hash->filter_hash);
> >  	free_ftrace_hash(ops->func_hash->notrace_hash);
> >  }
> > +EXPORT_SYMBOL_GPL(ftrace_free_filter);
> >  
> >  static struct ftrace_hash *alloc_ftrace_hash(int size_bits)
> >  {
> > @@ -5839,6 +5844,10 @@ EXPORT_SYMBOL_GPL(modify_ftrace_direct_multi);
> >   *
> >   * Filters denote which functions should be enabled when tracing is enabled
> >   * If @ip is NULL, it fails to update filter.
> > + *
> > + * This can allocate memory which must be freed before @ops can be freed,
> > + * either by removing each filtered addr or by using
> > + * ftrace_free_filter(@ops).
> >   */
> >  int ftrace_set_filter_ip(struct ftrace_ops *ops, unsigned long ip,
> >  			 int remove, int reset)
> > @@ -5858,7 +5867,11 @@ EXPORT_SYMBOL_GPL(ftrace_set_filter_ip);
> >   *
> >   * Filters denote which functions should be enabled when tracing is enabled
> >   * If @ips array or any ip specified within is NULL , it fails to update filter.
> > - */
> > + *
> > + * This can allocate memory which must be freed before @ops can be freed,
> > + * either by removing each filtered addr or by using
> > + * ftrace_free_filter(@ops).
> > +*/
> >  int ftrace_set_filter_ips(struct ftrace_ops *ops, unsigned long *ips,
> >  			  unsigned int cnt, int remove, int reset)
> >  {
> > @@ -5900,6 +5913,10 @@ ftrace_set_regex(struct ftrace_ops *ops, unsigned char *buf, int len,
> >   *
> >   * Filters denote which functions should be enabled when tracing is enabled.
> >   * If @buf is NULL and reset is set, all functions will be enabled for tracing.
> > + *
> > + * This can allocate memory which must be freed before @ops can be freed,
> > + * either by removing each filtered addr or by using
> > + * ftrace_free_filter(@ops).
> >   */
> >  int ftrace_set_filter(struct ftrace_ops *ops, unsigned char *buf,
> >  		       int len, int reset)
> > @@ -5919,6 +5936,10 @@ EXPORT_SYMBOL_GPL(ftrace_set_filter);
> >   * Notrace Filters denote which functions should not be enabled when tracing
> >   * is enabled. If @buf is NULL and reset is set, all functions will be enabled
> >   * for tracing.
> > + *
> > + * This can allocate memory which must be freed before @ops can be freed,
> > + * either by removing each filtered addr or by using
> > + * ftrace_free_filter(@ops).
> >   */
> >  int ftrace_set_notrace(struct ftrace_ops *ops, unsigned char *buf,
> >  			int len, int reset)
> > diff --git a/samples/ftrace/ftrace-direct-multi-modify.c b/samples/ftrace/ftrace-direct-multi-modify.c
> > index d52370cad0b6e..a825dbd2c9cfd 100644
> > --- a/samples/ftrace/ftrace-direct-multi-modify.c
> > +++ b/samples/ftrace/ftrace-direct-multi-modify.c
> > @@ -152,6 +152,7 @@ static void __exit ftrace_direct_multi_exit(void)
> >  {
> >  	kthread_stop(simple_tsk);
> >  	unregister_ftrace_direct_multi(&direct, my_tramp);
> > +	ftrace_free_filter(&direct);
> >  }
> >  
> >  module_init(ftrace_direct_multi_init);
> > diff --git a/samples/ftrace/ftrace-direct-multi.c b/samples/ftrace/ftrace-direct-multi.c
> > index ec1088922517d..d955a26506053 100644
> > --- a/samples/ftrace/ftrace-direct-multi.c
> > +++ b/samples/ftrace/ftrace-direct-multi.c
> > @@ -79,6 +79,7 @@ static int __init ftrace_direct_multi_init(void)
> >  static void __exit ftrace_direct_multi_exit(void)
> >  {
> >  	unregister_ftrace_direct_multi(&direct, (unsigned long) my_tramp);
> > +	ftrace_free_filter(&direct);
> >  }
> >  
> >  module_init(ftrace_direct_multi_init);
> > -- 
> > 2.30.2
> > 
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
