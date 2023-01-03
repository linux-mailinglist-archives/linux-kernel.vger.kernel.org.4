Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F9165BF28
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 12:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237117AbjACLil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 06:38:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237565AbjACLhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 06:37:55 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 59842D114
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 03:34:46 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB2361516;
        Tue,  3 Jan 2023 03:35:27 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.37.13])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 488053F663;
        Tue,  3 Jan 2023 03:34:45 -0800 (PST)
Date:   Tue, 3 Jan 2023 11:34:37 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        revest@chromium.org
Subject: Re: [PATCH 2/3] ftrace: export ftrace_free_filter() to modules
Message-ID: <Y7QSzYIHwQVWXAjf@FVFF77S0Q05N>
References: <20221103170907.931465-1-mark.rutland@arm.com>
 <20221103170907.931465-3-mark.rutland@arm.com>
 <20221122165938.353ee7c0@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122165938.353ee7c0@gandalf.local.home>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 04:59:38PM -0500, Steven Rostedt wrote:
> On Thu,  3 Nov 2022 17:09:06 +0000
> Mark Rutland <mark.rutland@arm.com> wrote:
> 
> FYI, the subject should start with a capital letter.
> 
>   ftrace: Export ftrace_free_filter() to modules

Ah; I'll fix all three patches for v2.

[...]

> >   *
> >   * Filters denote which functions should be enabled when tracing is enabled
> >   * If @ip is NULL, it fails to update filter.
> > + *
> > + * This can allocate memory which must be freed before @ops can be freed,
> > + * either by remvoing eached filtered addr or by using
> > + * ftrace_free_filter(@ops).
> >   */
> >  int ftrace_set_filter_ip(struct ftrace_ops *ops, unsigned long ip,
> >  			 int remove, int reset)
> > @@ -5856,7 +5865,11 @@ EXPORT_SYMBOL_GPL(ftrace_set_filter_ip);
> >   *
> >   * Filters denote which functions should be enabled when tracing is enabled
> >   * If @ips array or any ip specified within is NULL , it fails to update filter.
> > - */
> > + *
> > + * This can allocate memory which must be freed before @ops can be freed,
> > + * either by remvoing eached filtered addr or by using
> > + * ftrace_free_filter(@ops).
> > +*/
> >  int ftrace_set_filter_ips(struct ftrace_ops *ops, unsigned long *ips,
> >  			  unsigned int cnt, int remove, int reset)
> >  {
> > @@ -5898,6 +5911,10 @@ ftrace_set_regex(struct ftrace_ops *ops, unsigned char *buf, int len,
> >   *
> >   * Filters denote which functions should be enabled when tracing is enabled.
> >   * If @buf is NULL and reset is set, all functions will be enabled for tracing.
> > + *
> > + * This can allocate memory which must be freed before @ops can be freed,
> > + * either by remvoing eached filtered addr or by using
> > + * ftrace_free_filter(@ops).
> >   */
> >  int ftrace_set_filter(struct ftrace_ops *ops, unsigned char *buf,
> >  		       int len, int reset)
> > @@ -5917,6 +5934,10 @@ EXPORT_SYMBOL_GPL(ftrace_set_filter);
> >   * Notrace Filters denote which functions should not be enabled when tracing
> >   * is enabled. If @buf is NULL and reset is set, all functions will be enabled
> >   * for tracing.
> > + *
> > + * This can allocate memory which must be freed before @ops can be freed,
> > + * either by remvoing eached filtered addr or by using
> 
> I love how you cut and pasted two typos four times. ;-)

Ugh; that is the power of automation and little sleep...

I'll fix that up.

Mark.

> 
> -- Steve
> 
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
> 
