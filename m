Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 005465F55D9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 15:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiJENxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 09:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiJENxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 09:53:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45C85C35A
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 06:53:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4E38AB81E06
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 13:53:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB90C433C1;
        Wed,  5 Oct 2022 13:53:02 +0000 (UTC)
Date:   Wed, 5 Oct 2022 09:53:05 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ross Zwisler <zwisler@kernel.org>
Subject: Re: [PATCH] tracing: Do not free snapshot if tracer is on cmdline
Message-ID: <20221005095305.707ec79b@gandalf.local.home>
In-Reply-To: <20221005220856.d2c2db5a499a79874f0c96e3@kernel.org>
References: <20221004180452.6cf967f8@gandalf.local.home>
        <20221005220856.d2c2db5a499a79874f0c96e3@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Oct 2022 22:08:56 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Looks good to me.
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

Unfortunately, this is causing a failure in one of my tests. I'm still
trying to figure out how it is an issue.

-- Steve

> 
> > ---
> >  kernel/trace/trace.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > index def721de68a0..871e2b592969 100644
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> > @@ -6432,7 +6432,7 @@ int tracing_set_tracer(struct trace_array *tr, const char *buf)
> >  	tr->current_trace = &nop_trace;
> >  
> >  #ifdef CONFIG_TRACER_MAX_TRACE
> > -	had_max_tr = tr->allocated_snapshot;
> > +	had_max_tr = tr->current_trace->use_max_tr;
> >  
> >  	if (had_max_tr && !t->use_max_tr) {
> >  		/*
