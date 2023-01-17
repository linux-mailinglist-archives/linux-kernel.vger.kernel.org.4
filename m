Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51B766E2E1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 16:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjAQP4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 10:56:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjAQP4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 10:56:36 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 2E36A2B29C
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 07:56:34 -0800 (PST)
Received: (qmail 169915 invoked by uid 1000); 17 Jan 2023 10:56:34 -0500
Date:   Tue, 17 Jan 2023 10:56:34 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
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
Message-ID: <Y8bFMgDSUZymXUsS@rowland.harvard.edu>
References: <Y8Qog8qf7wIx2Kve@rowland.harvard.edu>
 <20230115181052.GJ2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8RmEtBnwqOzNhsK@rowland.harvard.edu>
 <20230116042329.GN2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8WTXS73qTBpUzcI@rowland.harvard.edu>
 <20230116190652.GZ2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8WjmTFnqbAnS1Pz@rowland.harvard.edu>
 <20230116221357.GA2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8aKlNY4Z0z2Yqs0@andrea>
 <20230117151416.GI2948950@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117151416.GI2948950@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 07:14:16AM -0800, Paul E. McKenney wrote:
> On Tue, Jan 17, 2023 at 12:46:28PM +0100, Andrea Parri wrote:
> > This was reminiscent of old discussions, in fact, we do have:
> > 
> > [tools/memory-model/Documentation/litmus-tests.txt]
> > 
> > e.	Although sleepable RCU (SRCU) is now modeled, there
> > 	are some subtle differences between its semantics and
> > 	those in the Linux kernel.  For example, the kernel
> > 	might interpret the following sequence as two partially
> > 	overlapping SRCU read-side critical sections:
> > 
> > 		 1  r1 = srcu_read_lock(&my_srcu);
> > 		 2  do_something_1();
> > 		 3  r2 = srcu_read_lock(&my_srcu);
> > 		 4  do_something_2();
> > 		 5  srcu_read_unlock(&my_srcu, r1);
> > 		 6  do_something_3();
> > 		 7  srcu_read_unlock(&my_srcu, r2);
> > 
> > 	In contrast, LKMM will interpret this as a nested pair of
> > 	SRCU read-side critical sections, with the outer critical
> > 	section spanning lines 1-7 and the inner critical section
> > 	spanning lines 3-5.
> > 
> > 	This difference would be more of a concern had anyone
> > 	identified a reasonable use case for partially overlapping
> > 	SRCU read-side critical sections.  For more information
> > 	on the trickiness of such overlapping, please see:
> > 	https://paulmck.livejournal.com/40593.html
> 
> Good point, if we do change the definition, we also need to update
> this documentation.
> 
> > More recently/related,
> > 
> >   https://lore.kernel.org/lkml/20220421230848.GA194034@paulmck-ThinkPad-P17-Gen-1/T/#m2a8701c7c377ccb27190a6679e58b0929b0b0ad9
> 
> It would not be a bad thing for LKMM to be able to show people the
> error of their ways when they try non-nested partially overlapping SRCU
> read-side critical sections.  Or, should they find some valid use case,
> to help them prove their point.  ;-)

Isn't it true that the current code will flag srcu-bad-nesting if a 
litmus test has non-nested overlapping SRCU read-side critical sections?

And if it is true, is there any need to change the memory model at this 
point?

(And if it's not true, that's most likely due to a bug in herd7.)

Alan
