Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 753FF64E9FD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 12:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbiLPLIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 06:08:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiLPLIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 06:08:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09441EA0;
        Fri, 16 Dec 2022 03:08:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9C760B81D2A;
        Fri, 16 Dec 2022 11:08:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94EF1C433D2;
        Fri, 16 Dec 2022 11:08:12 +0000 (UTC)
Date:   Fri, 16 Dec 2022 06:08:10 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing: Do not synchronize freeing of trigger filter
 on boot up
Message-ID: <20221216060810.4e541bc4@gandalf.local.home>
In-Reply-To: <20221216044022.GA2467686@paulmck-ThinkPad-P17-Gen-1>
References: <20221214084954.e759647a2f5f1a38bc78b371@kernel.org>
        <20221214200333.GA3208104@paulmck-ThinkPad-P17-Gen-1>
        <20221215100241.73a30da8@gandalf.local.home>
        <20221215170256.GG4001@paulmck-ThinkPad-P17-Gen-1>
        <20221215135102.556ee076@gandalf.local.home>
        <20221215190158.GK4001@paulmck-ThinkPad-P17-Gen-1>
        <20221215173913.5432bfbf@gandalf.local.home>
        <20221215231027.GS4001@paulmck-ThinkPad-P17-Gen-1>
        <20221215184202.7ebb3055@gandalf.local.home>
        <20221216010118.GU4001@paulmck-ThinkPad-P17-Gen-1>
        <20221216044022.GA2467686@paulmck-ThinkPad-P17-Gen-1>
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

On Thu, 15 Dec 2022 20:40:22 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> On Thu, Dec 15, 2022 at 05:01:18PM -0800, Paul E. McKenney wrote:
> > On Thu, Dec 15, 2022 at 06:42:02PM -0500, Steven Rostedt wrote:  
> > > On Thu, 15 Dec 2022 15:10:27 -0800
> > > "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > >   
> > > > The nice thing about the current placement of rcu_scheduler_starting()
> > > > is that there is not yet any other task to switch to.  ;-)  
> > > 
> > > Fair enough. Anyway the last patch appears to do the job.
> > > 
> > > Reported-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > > Tested-by: Steven Rostedt (Google) <rostedt@goodmis.org>  
> > 
> > Applied, thank you!  
> 
> And I should have checked up on urgency.  Normal process would hold this
> one until the v6.3 merge window, but please let me know if you would
> like it in v6.2.  It is after all a bug fix.
> 

Yes, any fix that fixes a lockdep splat is considered urgent and should be
pushed ASAP. As it makes finding other lockdep splats more difficult (as
the first splat shuts down lockdep).

Please send this during the merge window, as I have to carry it internally
until it makes it into mainline.

Thanks!

-- Steve
