Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724346A7577
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 21:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjCAUgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 15:36:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjCAUgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 15:36:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE694391F;
        Wed,  1 Mar 2023 12:36:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 651CEB81037;
        Wed,  1 Mar 2023 20:36:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22957C433A4;
        Wed,  1 Mar 2023 20:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677703006;
        bh=oSLFq2fN9+ftITQzETKmIDZ2OmX+B6vJhUKDpk3NoU0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=kOuCrRC3SYDq/OKNNL58Mu7vN8091S3hA4rXP3XiKIks0toT2DkTCwUXeSAWrkUU2
         +yqvPp+TVuZRMRuVU1qUxnGnL/ZXh8PsUMPGOXfPhPeo/f8t0i+LKsFqvftFWzCXd9
         h7wANuqfiA4ryvI/P1kSGvhizJx15EH3BUPtGUMgXRMn/CyCYljJIf9hJ1NL0khMoV
         XAJyLS6RzxVrF35/fV0C3a0rf5aq7o37ypzigW6uZvjG0jsQOdYIK7AOm+2IS1peqq
         GFztBqH0j5CNF8ASlSDhXlcrJ7UQbb3ebKi3M1DWxee1qKyuOAl6yw2MPyhngkLmU+
         PJAO8EiRRv9sg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B5A0D5C03F0; Wed,  1 Mar 2023 12:36:45 -0800 (PST)
Date:   Wed, 1 Mar 2023 12:36:45 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH] rcu: use try_cmpxchg in check_cpu_stall
Message-ID: <20230301203645.GG2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230228160324.2a7c1012@gandalf.local.home>
 <20230228212911.GX2948950@paulmck-ThinkPad-P17-Gen-1>
 <20230228164124.77c126d2@gandalf.local.home>
 <CAEXW_YQ515_DOLVUm48GvDADuaY2mSrYTaKa7u6jYDNqBncJww@mail.gmail.com>
 <20230228190846.79b06089@gandalf.local.home>
 <CAFULd4aY3Y8tyLN70oebZDagBebvH0erwRxKDaEX8L83Xo8gYw@mail.gmail.com>
 <20230301113813.4f16a689@gandalf.local.home>
 <CAFULd4aWZ+fvVZ+MEt6JD1rFaQZeO5DDWAHtPKOrx8R8DETFBw@mail.gmail.com>
 <20230301200820.GF2948950@paulmck-ThinkPad-P17-Gen-1>
 <20230301151826.014c5977@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301151826.014c5977@gandalf.local.home>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2023 at 03:18:26PM -0500, Steven Rostedt wrote:
> On Wed, 1 Mar 2023 12:08:20 -0800
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > > Attached patch implements this suggestion.  
> > 
> > Please help me out here.
> > 
> > Why on earth are we even discussing making this change to code that
> > normally never executes?  Performance is not a consideration here.
> > 
> > What am I missing here?  Is there some sort of forward-progress
> > issue that this change addresses?
> 
> Well, we sorta hijacked this thread. It turned into a more general
> discussion, as there is code that this change will be useful for
> (ring_buffer.c), but we just happen to be having the discussion here.
> 
> Where it will at most remove some text and give you back a few extra bytes
> of memory ;-)
> 
> But if we do use cmpxchg_success() IMHO, it does improve readability.
> 
> > -	    cmpxchg(&rcu_state.jiffies_stall, js, jn) == js) {
> > +	    cmpxchg_success(&rcu_state.jiffies_stall, js, jn)) {

Some years down the road, should cmpxchg_success() be on the tip of
the tongue of every kernel hacker, perhaps.  Or perhaps not.

In the meantime, we have yet another abysmally documented atomic
operation that is not well known throughout the community.  And then the
people coming across this curse everyone who had anything to do with it,
as they search the source code, dig through assembly output, and so on
trying to work out exactly what this thing does.

Sorry, but no way.

Again, unless there is some sort of forward-progress argument or
similar convincing argument.

							Thanx, Paul
