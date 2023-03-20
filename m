Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79EFF6C1E51
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 18:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232922AbjCTRlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 13:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232789AbjCTRlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:41:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659B7F945;
        Mon, 20 Mar 2023 10:37:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71BA161755;
        Mon, 20 Mar 2023 17:36:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B166AC433EF;
        Mon, 20 Mar 2023 17:36:54 +0000 (UTC)
Date:   Mon, 20 Mar 2023 13:36:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Douglas RAILLARD <douglas.raillard@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "open list:TRACING" <linux-kernel@vger.kernel.org>,
        "open list:TRACING" <linux-trace-kernel@vger.kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org
Subject: Re: [PATCH] rcu: Fix rcu_torture_read ftrace event
Message-ID: <20230320133650.5388a05e@gandalf.local.home>
In-Reply-To: <5a4e5058-2b5c-4c65-9811-66bf68128583@paulmck-laptop>
References: <20230306122744.236790-1-douglas.raillard@arm.com>
        <20230320112015.2271da9c@gandalf.local.home>
        <5a4e5058-2b5c-4c65-9811-66bf68128583@paulmck-laptop>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Mar 2023 09:58:11 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> On Mon, Mar 20, 2023 at 11:20:15AM -0400, Steven Rostedt wrote:
> > 
> > [ Wondering why this didn't get picked up in v6.3-rc3, I see that the
> >   maintainers of RCU were not Cc'd :-( ]
> > 
> > This is a bug that will cause unwanted results. I have a patch that will not
> > let the kernel build when code like this is added.
> > 
> >   https://patchwork.kernel.org/project/linux-trace-kernel/patch/20230309221302.642e82d9@gandalf.local.home/
> > 
> > ( The kernel robot even failed when applying the above patch, because it
> >   caught the code that this patch fixes )
> > 
> > On Mon,  6 Mar 2023 12:27:43 +0000
> > Douglas RAILLARD <douglas.raillard@arm.com> wrote:
> >   
> > > From: Douglas Raillard <douglas.raillard@arm.com>
> > > 
> > > Fix the rcutorturename field so that its size is correctly reported in
> > > the text format embedded in trace.dat files. As it stands, it is
> > > reported as being of size 1:  
> > 
> > And that the offsets of the following fields will be incorrect as well.
> >   
> > > 
> > >     field:char rcutorturename[8];   offset:8;       size:1; signed:0;
> > >   
> > 
> > Please add:
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 04ae87a52074e ("ftrace: Rework event_create_dir()")  
> 
> Thank you, Steve!
> 
> With those fixes, and with an ack or better from Steve, I will be happy
> to pull this in to -rcu.  How urgent is this?  The default destination
> would be the v6.5 merge window (not the upcoming one, but the one after
> that), so if you need it sooner, please let me know.

I would like my patch to get in this release, so if you can get it into
this release too (before the next merge window) that would be great. This is
a real bug. User space tooling can not parse this trace event (when it use
to, so it is a regression), and my patch that prevents other trace events
from making the same mistake will make this code as is fail the build.

For this patch:

 Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve


> >   
> > > Signed-off-by: Douglas Raillard <douglas.raillard@arm.com>
> > > ---
> > >  include/trace/events/rcu.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
> > > index 90b2fb0292cb..012fa0d171b2 100644
> > > --- a/include/trace/events/rcu.h
> > > +++ b/include/trace/events/rcu.h
> > > @@ -768,7 +768,7 @@ TRACE_EVENT_RCU(rcu_torture_read,
> > >  	TP_ARGS(rcutorturename, rhp, secs, c_old, c),
> > >  
> > >  	TP_STRUCT__entry(
> > > -		__field(char, rcutorturename[RCUTORTURENAME_LEN])
> > > +		__array(char, rcutorturename, RCUTORTURENAME_LEN)
> > >  		__field(struct rcu_head *, rhp)
> > >  		__field(unsigned long, secs)
> > >  		__field(unsigned long, c_old)  
> >   

