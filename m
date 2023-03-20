Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593F56C2088
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 19:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjCTS5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 14:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbjCTS4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:56:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E593F34C26;
        Mon, 20 Mar 2023 11:49:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6DF3D617AB;
        Mon, 20 Mar 2023 18:49:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C82FBC433D2;
        Mon, 20 Mar 2023 18:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679338151;
        bh=devyTB+QoK7CaJDUcCzWWOhMtGdTJWI5jCOOpMU6ijQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=uT6z5RPhXU2o0TXjF8VQYBtImQGEeaj2IkFJ5hI/YCoh4j5jKSNRcDXz5HfiE2HlG
         dCIPrd2blcImsEQf6cXt4hxOJ3ViRSDGsPqToUTfbrIG9hOqZMbtBH8WxO2Qv49kci
         Jz5dYH+kD7udko8qNfYSVsYthK0E+AooxfQV1N0BQ3yEGdl03KS+FrA+pJSaiR46wf
         yzM7SyrZuGCIA4l5t3nbUumyLbBPzhdTbs5Mz3/Onh/mWevqJhbQpTz/fygkunDIDc
         g5jUtj3sAMZ5J4mGI8a1U4hPu+mREsjDA8Mi7PS9DOQ0bSVAkxE67bCU6PW1l35jvV
         Ext9Ck2P0xHlA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 5A3581540395; Mon, 20 Mar 2023 11:49:11 -0700 (PDT)
Date:   Mon, 20 Mar 2023 11:49:11 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Douglas RAILLARD <douglas.raillard@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "open list:TRACING" <linux-kernel@vger.kernel.org>,
        "open list:TRACING" <linux-trace-kernel@vger.kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org
Subject: Re: [PATCH] rcu: Fix rcu_torture_read ftrace event
Message-ID: <f7e2761d-0db8-49a4-82ad-8876578d2ddb@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230306122744.236790-1-douglas.raillard@arm.com>
 <20230320112015.2271da9c@gandalf.local.home>
 <5a4e5058-2b5c-4c65-9811-66bf68128583@paulmck-laptop>
 <20230320133650.5388a05e@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320133650.5388a05e@gandalf.local.home>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 01:36:50PM -0400, Steven Rostedt wrote:
> On Mon, 20 Mar 2023 09:58:11 -0700
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > On Mon, Mar 20, 2023 at 11:20:15AM -0400, Steven Rostedt wrote:
> > > 
> > > [ Wondering why this didn't get picked up in v6.3-rc3, I see that the
> > >   maintainers of RCU were not Cc'd :-( ]
> > > 
> > > This is a bug that will cause unwanted results. I have a patch that will not
> > > let the kernel build when code like this is added.
> > > 
> > >   https://patchwork.kernel.org/project/linux-trace-kernel/patch/20230309221302.642e82d9@gandalf.local.home/
> > > 
> > > ( The kernel robot even failed when applying the above patch, because it
> > >   caught the code that this patch fixes )
> > > 
> > > On Mon,  6 Mar 2023 12:27:43 +0000
> > > Douglas RAILLARD <douglas.raillard@arm.com> wrote:
> > >   
> > > > From: Douglas Raillard <douglas.raillard@arm.com>
> > > > 
> > > > Fix the rcutorturename field so that its size is correctly reported in
> > > > the text format embedded in trace.dat files. As it stands, it is
> > > > reported as being of size 1:  
> > > 
> > > And that the offsets of the following fields will be incorrect as well.
> > >   
> > > > 
> > > >     field:char rcutorturename[8];   offset:8;       size:1; signed:0;
> > > >   
> > > 
> > > Please add:
> > > 
> > > Cc: stable@vger.kernel.org
> > > Fixes: 04ae87a52074e ("ftrace: Rework event_create_dir()")  
> > 
> > Thank you, Steve!
> > 
> > With those fixes, and with an ack or better from Steve, I will be happy
> > to pull this in to -rcu.  How urgent is this?  The default destination
> > would be the v6.5 merge window (not the upcoming one, but the one after
> > that), so if you need it sooner, please let me know.
> 
> I would like my patch to get in this release, so if you can get it into
> this release too (before the next merge window) that would be great. This is
> a real bug. User space tooling can not parse this trace event (when it use
> to, so it is a regression), and my patch that prevents other trace events
> from making the same mistake will make this code as is fail the build.
> 
> For this patch:
> 
>  Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Fair enough, thank you all!

							Thanx, Paul

> -- Steve
> 
> 
> > >   
> > > > Signed-off-by: Douglas Raillard <douglas.raillard@arm.com>
> > > > ---
> > > >  include/trace/events/rcu.h | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
> > > > index 90b2fb0292cb..012fa0d171b2 100644
> > > > --- a/include/trace/events/rcu.h
> > > > +++ b/include/trace/events/rcu.h
> > > > @@ -768,7 +768,7 @@ TRACE_EVENT_RCU(rcu_torture_read,
> > > >  	TP_ARGS(rcutorturename, rhp, secs, c_old, c),
> > > >  
> > > >  	TP_STRUCT__entry(
> > > > -		__field(char, rcutorturename[RCUTORTURENAME_LEN])
> > > > +		__array(char, rcutorturename, RCUTORTURENAME_LEN)
> > > >  		__field(struct rcu_head *, rhp)
> > > >  		__field(unsigned long, secs)
> > > >  		__field(unsigned long, c_old)  
> > >   
> 
