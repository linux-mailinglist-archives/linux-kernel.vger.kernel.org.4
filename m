Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F1A6A762A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 22:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjCAV3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 16:29:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCAV3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 16:29:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA606E8B;
        Wed,  1 Mar 2023 13:29:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15B43614B4;
        Wed,  1 Mar 2023 21:29:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C984C433EF;
        Wed,  1 Mar 2023 21:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677706181;
        bh=d39jRn8NUTafv5tSLxpXQQAMRtg500xyOXL35qot2Vw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=bzxCoJW1K4uZ7UQSnWA0eUPtaTBEXg9+w+NTKLiT4mDf+Zsoz2XZ8DbiUoDkuoID4
         Qk8qXEzR+2cQ9+dx2vktwDw9FmY0TgAccC9Jq5ik/vsNexha98MRXHsOuaU/JqOf1p
         +vM2o+hrOp6YWSJrBHpaqKPLh5bA0aRymoV/X3bJxvWA+fBQySzCphFMpEKOiprqvX
         kzIsVVfEim9Nvd8gHpF2rqyTIG4SJoJXd6K/kbxWWxUITwsXYqwXzllARz823YJr9I
         JAy2zg/5cE0eET9n8xhz3JwAt6CJeaHXo950lxs3g8n+dCZU3jx1bjFGlwkweHeiCO
         kSC5VvYxj+Z1g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id F38755C03F0; Wed,  1 Mar 2023 13:29:40 -0800 (PST)
Date:   Wed, 1 Mar 2023 13:29:40 -0800
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
Message-ID: <20230301212940.GH2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230228164124.77c126d2@gandalf.local.home>
 <CAEXW_YQ515_DOLVUm48GvDADuaY2mSrYTaKa7u6jYDNqBncJww@mail.gmail.com>
 <20230228190846.79b06089@gandalf.local.home>
 <CAFULd4aY3Y8tyLN70oebZDagBebvH0erwRxKDaEX8L83Xo8gYw@mail.gmail.com>
 <20230301113813.4f16a689@gandalf.local.home>
 <CAFULd4aWZ+fvVZ+MEt6JD1rFaQZeO5DDWAHtPKOrx8R8DETFBw@mail.gmail.com>
 <20230301200820.GF2948950@paulmck-ThinkPad-P17-Gen-1>
 <20230301151826.014c5977@gandalf.local.home>
 <20230301203645.GG2948950@paulmck-ThinkPad-P17-Gen-1>
 <20230301154641.695778bf@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301154641.695778bf@gandalf.local.home>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2023 at 03:46:41PM -0500, Steven Rostedt wrote:
> On Wed, 1 Mar 2023 12:36:45 -0800
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > Some years down the road, should cmpxchg_success() be on the tip of
> > the tongue of every kernel hacker, perhaps.  Or perhaps not.
> 
> A bit of a catch-22 I would say. It will only become something everyone
> knows if it exists.
> 
> > In the meantime, we have yet another abysmally documented atomic
> 
> Is it?

Is sure is.

> > operation that is not well known throughout the community.  And then the
> > people coming across this curse everyone who had anything to do with it,
> > as they search the source code, dig through assembly output, and so on
> > trying to work out exactly what this thing does.
> > 
> > Sorry, but no way.
> > 
> > Again, unless there is some sort of forward-progress argument or
> > similar convincing argument.
> 
> Speaking of forward progress...
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/atomic_t.txt#n316

Yes, that is probably the best starting point.

And if you have been around long enough, you know that this is in fact
the best starting point.  Plus if you can correctly interpret the words
in that document.  And if you are familiar with the entire document.
But otherwise, good luck learning the semantics for something like
atomic_fetch_add_release().

> Anyway, I'm guessing this will not become part of rcu any time soon. But
> for the ring buffer, I would happily take it.

Certainly not unless someone comes up with a good reason for it.

							Thanx, Paul
