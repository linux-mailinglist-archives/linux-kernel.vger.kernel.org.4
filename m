Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4699866E564
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 18:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbjAQR41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 12:56:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbjAQRxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 12:53:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035B04F851
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 09:43:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A929614F3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 17:43:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9AF1C433F1;
        Tue, 17 Jan 2023 17:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673977388;
        bh=eLHA1ULJgwnmzHeOYX5jr3rraRvGyW95xIRtTdxFUj8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=J4shsH/h560VVMk0TfCwUK6KhwCUvrQwXsvSZl6e+Sb6FNjTF5GACDuknfCN1PZ5F
         FpgqX80JSwn1HtGl8ATxBT1+fGS9nuCPCXR6nK2bPscSyx2uXnHma9+U6wn2UFIA+u
         rzQD3Lz/Yzl32mKp2IIxV3NyHvqw2C/BqA4pN5o5klPux1UIP8Nle1yBIhcK3HqSiI
         FW39GElv8f92bIi5Ab+rociYbk0AcCbZPHSH1UT5FK07FH9SQrNAXOWfIgp2xoq9LE
         hxP8AYj6SK0ZrNDGcCuR5lDv2OjGr0f5zFGQK6Xr4c0zYJSkgQlgSzlHBBtlmbA+fR
         3ACDRUz77/iNg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 68D1C5C0543; Tue, 17 Jan 2023 09:43:08 -0800 (PST)
Date:   Tue, 17 Jan 2023 09:43:08 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Andrea Parri <parri.andrea@gmail.com>,
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
Message-ID: <20230117174308.GK2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230115181052.GJ2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8RmEtBnwqOzNhsK@rowland.harvard.edu>
 <20230116042329.GN2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8WTXS73qTBpUzcI@rowland.harvard.edu>
 <20230116190652.GZ2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8WjmTFnqbAnS1Pz@rowland.harvard.edu>
 <20230116221357.GA2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8aKlNY4Z0z2Yqs0@andrea>
 <20230117151416.GI2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8bFMgDSUZymXUsS@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8bFMgDSUZymXUsS@rowland.harvard.edu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 10:56:34AM -0500, Alan Stern wrote:
> On Tue, Jan 17, 2023 at 07:14:16AM -0800, Paul E. McKenney wrote:
> > On Tue, Jan 17, 2023 at 12:46:28PM +0100, Andrea Parri wrote:
> > > This was reminiscent of old discussions, in fact, we do have:
> > > 
> > > [tools/memory-model/Documentation/litmus-tests.txt]
> > > 
> > > e.	Although sleepable RCU (SRCU) is now modeled, there
> > > 	are some subtle differences between its semantics and
> > > 	those in the Linux kernel.  For example, the kernel
> > > 	might interpret the following sequence as two partially
> > > 	overlapping SRCU read-side critical sections:
> > > 
> > > 		 1  r1 = srcu_read_lock(&my_srcu);
> > > 		 2  do_something_1();
> > > 		 3  r2 = srcu_read_lock(&my_srcu);
> > > 		 4  do_something_2();
> > > 		 5  srcu_read_unlock(&my_srcu, r1);
> > > 		 6  do_something_3();
> > > 		 7  srcu_read_unlock(&my_srcu, r2);
> > > 
> > > 	In contrast, LKMM will interpret this as a nested pair of
> > > 	SRCU read-side critical sections, with the outer critical
> > > 	section spanning lines 1-7 and the inner critical section
> > > 	spanning lines 3-5.
> > > 
> > > 	This difference would be more of a concern had anyone
> > > 	identified a reasonable use case for partially overlapping
> > > 	SRCU read-side critical sections.  For more information
> > > 	on the trickiness of such overlapping, please see:
> > > 	https://paulmck.livejournal.com/40593.html
> > 
> > Good point, if we do change the definition, we also need to update
> > this documentation.
> > 
> > > More recently/related,
> > > 
> > >   https://lore.kernel.org/lkml/20220421230848.GA194034@paulmck-ThinkPad-P17-Gen-1/T/#m2a8701c7c377ccb27190a6679e58b0929b0b0ad9
> > 
> > It would not be a bad thing for LKMM to be able to show people the
> > error of their ways when they try non-nested partially overlapping SRCU
> > read-side critical sections.  Or, should they find some valid use case,
> > to help them prove their point.  ;-)
> 
> Isn't it true that the current code will flag srcu-bad-nesting if a 
> litmus test has non-nested overlapping SRCU read-side critical sections?

Now that you mention it, it does indeed, flagging srcu-bad-nesting.

Just to see if I understand, different-values yields true if the set
contains multiple elements with the same value mapping to different
values.  Or, to put it another way, if the relation does not correspond
to a function.

Or am I still missing something?

> And if it is true, is there any need to change the memory model at this 
> point?
> 
> (And if it's not true, that's most likely due to a bug in herd7.)

Agreed, changes must wait for SRCU support in herd7.

At which point something roughly similar to this might work?

let srcu-rscs = return_value(Srcu-lock) ; (dep | rfi)* ;
		parameter(Srcu-unlock, 2)

Given an Srcu-down and an Srcu-up:

let srcu-rscs = ( return_value(Srcu-lock) ; (dep | rfi)* ;
		  parameter(Srcu-unlock, 2) ) |
		( return_value(Srcu-down) ; (dep | rf)* ;
		  parameter(Srcu-up, 2) )

Seem reasonable, or am I missing yet something else?

							Thanx, Paul
