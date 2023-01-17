Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C90466E767
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 21:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjAQUGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 15:06:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233576AbjAQUDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 15:03:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB74E46D7A
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 10:55:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8739161517
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 18:55:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA500C433EF;
        Tue, 17 Jan 2023 18:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673981721;
        bh=lePYMONWKvhkYMMAlniOQNFGCWBqE1qRndW98IbdVkk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=TytnkMSh3EiWS+tiseZ8ZRFb+MTmQz4SK4HKEDIyuY2bp+7Myt/eeEEwCEPS8OcYm
         DRn2LapfuckNCAxEMykp9raKwLfhSqnCAcKR8DXyGP6+f02drxSjBJFNDvnJL4ad7a
         9aZeKwgxe7Fa0GGGKZ3wOCz17KXKRE2QbHPHqXIESoNcbiZDiBzQxhiQDhYaycbOMt
         yLL8AbJc4pODOFqst9sZ8jSbaxZa1Ch7jnxMcpUie4q80XgzSKo5uch3ydDZxXiUgM
         lnR5Nsp/scVkpjmaFngGmUX44MNPJ0eIxD3JU4LFCjmYfvlPjJGHOysFK8ePejMsnF
         FQ8GCgi0pmatQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7DF785C0543; Tue, 17 Jan 2023 10:55:21 -0800 (PST)
Date:   Tue, 17 Jan 2023 10:55:21 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>, will <will@kernel.org>,
        "boqun.feng" <boqun.feng@gmail.com>, npiggin <npiggin@gmail.com>,
        dhowells <dhowells@redhat.com>,
        "j.alglave" <j.alglave@ucl.ac.uk>,
        "luc.maranget" <luc.maranget@inria.fr>, akiyks <akiyks@gmail.com>,
        dlustig <dlustig@nvidia.com>, joel <joel@joelfernandes.org>,
        urezki <urezki@gmail.com>,
        quic_neeraju <quic_neeraju@quicinc.com>,
        frederic <frederic@kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Internal vs. external barriers (was: Re: Interesting LKMM litmus
 test)
Message-ID: <20230117185521.GN2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230116042329.GN2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8WTXS73qTBpUzcI@rowland.harvard.edu>
 <20230116190652.GZ2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8WjmTFnqbAnS1Pz@rowland.harvard.edu>
 <20230116221357.GA2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8aKlNY4Z0z2Yqs0@andrea>
 <20230117151416.GI2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8bFMgDSUZymXUsS@rowland.harvard.edu>
 <20230117174308.GK2948950@paulmck-ThinkPad-P17-Gen-1>
 <306bf79f-51db-473f-636c-e1d7d1dc685e@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <306bf79f-51db-473f-636c-e1d7d1dc685e@huaweicloud.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 07:27:29PM +0100, Jonas Oberhauser wrote:
> On 1/17/2023 6:43 PM, Paul E. McKenney wrote:
> > On Tue, Jan 17, 2023 at 10:56:34AM -0500, Alan Stern wrote:
> > > On Tue, Jan 17, 2023 at 07:14:16AM -0800, Paul E. McKenney wrote:
> > > > On Tue, Jan 17, 2023 at 12:46:28PM +0100, Andrea Parri wrote:
> > > > > This was reminiscent of old discussions, in fact, we do have:
> > > > > 
> > > > > [tools/memory-model/Documentation/litmus-tests.txt]
> > > > > 
> > > > > e.	Although sleepable RCU (SRCU) is now modeled, there
> > > > > 	are some subtle differences between its semantics and
> > > > > 	those in the Linux kernel.  For example, the kernel
> > > > > 	might interpret the following sequence as two partially
> > > > > 	overlapping SRCU read-side critical sections:
> > > > > 
> > > > > 		 1  r1 = srcu_read_lock(&my_srcu);
> > > > > 		 2  do_something_1();
> > > > > 		 3  r2 = srcu_read_lock(&my_srcu);
> > > > > 		 4  do_something_2();
> > > > > 		 5  srcu_read_unlock(&my_srcu, r1);
> > > > > 		 6  do_something_3();
> > > > > 		 7  srcu_read_unlock(&my_srcu, r2);
> > > > > 
> > > > > 	In contrast, LKMM will interpret this as a nested pair of
> > > > > 	SRCU read-side critical sections, with the outer critical
> > > > > 	section spanning lines 1-7 and the inner critical section
> > > > > 	spanning lines 3-5.
> > > > > 
> > > > > 	This difference would be more of a concern had anyone
> > > > > 	identified a reasonable use case for partially overlapping
> > > > > 	SRCU read-side critical sections.  For more information
> > > > > 	on the trickiness of such overlapping, please see:
> > > > > 	https://paulmck.livejournal.com/40593.html
> > > > Good point, if we do change the definition, we also need to update
> > > > this documentation.
> > > > 
> > > > > More recently/related,
> > > > > 
> > > > >    https://lore.kernel.org/lkml/20220421230848.GA194034@paulmck-ThinkPad-P17-Gen-1/T/#m2a8701c7c377ccb27190a6679e58b0929b0b0ad9
> > > > It would not be a bad thing for LKMM to be able to show people the
> > > > error of their ways when they try non-nested partially overlapping SRCU
> > > > read-side critical sections.  Or, should they find some valid use case,
> > > > to help them prove their point.  ;-)
> > > Isn't it true that the current code will flag srcu-bad-nesting if a
> > > litmus test has non-nested overlapping SRCU read-side critical sections?
> > Now that you mention it, it does indeed, flagging srcu-bad-nesting.
> > 
> > Just to see if I understand, different-values yields true if the set
> > contains multiple elements with the same value mapping to different
> > values.  Or, to put it another way, if the relation does not correspond
> > to a function.
> > 
> > Or am I still missing something?
> 
> based on https://lkml.org/lkml/2019/1/10/155:

Ah, thank you for the pointer!

> I think different-values(r) is the same as r \ same-values, where
> same-values links all reads and writes that have the same value (e.g.,
> "write 5 to x" and "read 5 from y").
> 
> With this in mind, I think the idea is to 1) forbid partial overlap, and
> using the different-values to 2) force them to provide the appropriate
> value.
> This works because apparently srcu-lock is a read and srcu-unlock is a
> write, so in case of
> int r1 = srcu-lock(&ss);   ==>  Read(&ss, x), r1 := x
> ...
> srcu-unlock(&ss, r1);  ==> Write(&ss, r1), which is Write(&ss, x)
> 
> This guarantees that the read and write have the same value, hence
> different-values(...) will be the empty relation, and so no flag.

Might it instead match the entire event?

> > > And if it is true, is there any need to change the memory model at this
> > > point?
> > > 
> > > (And if it's not true, that's most likely due to a bug in herd7.)
> > Agreed, changes must wait for SRCU support in herd7.
> > 
> > At which point something roughly similar to this might work?
> > 
> > let srcu-rscs = return_value(Srcu-lock) ; (dep | rfi)* ;
> > 		parameter(Srcu-unlock, 2)
> 
> I would like instead to be able to give names to the arguments of events
> that become dependency relations, like
>    event srcu_unlock(struct srcu_struct *srcu_addr, struct srcu_token
> *srcu_data)
> and then
>     let srcu-rscs = [Srcu-lock] ; srcu_data ; (data; rfi)*
> 
> Personally I would also like to not have Linux-specific primitives in
> herd7/cat, that means that to understand LKMM you also need to understand
> the herd7 tool, and sounds quite brittle.
> 
> I would prefer if herd7 had some means to define custom events/instructions
> and uninterpreted relations between them, like
> 
> relation rf : [write] x [read]
> [read] <= range(rf)
> empty rf ;rf^-1 \ id
> 
> and some way to say
> [read] ; .return <= rf^-1 ; .data
> (where .return is a functional relation relating every event to the value it
> returns, and .xyz is the functional relation relating every event to the
> value of its argument xyz).

I am glad that I asked rather than kneejerk filing a bug report.  ;-)

Other thoughts?

							Thanx, Paul
