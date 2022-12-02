Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C25E640F25
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 21:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234852AbiLBUWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 15:22:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbiLBUWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 15:22:14 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 01389F3C02
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 12:22:12 -0800 (PST)
Received: (qmail 538315 invoked by uid 1000); 2 Dec 2022 15:22:11 -0500
Date:   Fri, 2 Dec 2022 15:22:11 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Jonas Oberhauser <jonas.oberhauser@huawei.com>
Cc:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
        "will@kernel.org" <will@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "j.alglave@ucl.ac.uk" <j.alglave@ucl.ac.uk>,
        "luc.maranget@inria.fr" <luc.maranget@inria.fr>,
        "akiyks@gmail.com" <akiyks@gmail.com>,
        "dlustig@nvidia.com" <dlustig@nvidia.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "urezki@gmail.com" <urezki@gmail.com>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tools: memory-model: Make plain accesses carry
 dependencies
Message-ID: <Y4pec7lfQHwmH4V/@rowland.harvard.edu>
References: <20221201121808.20785-1-jonas.oberhauser@huaweicloud.com>
 <Y4jQC9ejAQqJFTo+@rowland.harvard.edu>
 <6abbb72eef6149eb842a3351ecea7af5@huawei.com>
 <Y4kMskpQGOvlPyYf@rowland.harvard.edu>
 <4905c14d2bc547a391d626416a20a2e9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4905c14d2bc547a391d626416a20a2e9@huawei.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 05:22:57PM +0000, Jonas Oberhauser wrote:
> > but to me OOTA suggests something more: a value arising as if by 
> > magic rather than as a result of a computation.  In your version of 
> > the litmus test there is WRITE_ONCE(*y, 1), so it's a little 
> > understandable that you could end up with 1 as the final values of x 
> > and y.  But in my version, no values get computed anywhere, so the 
> > final value of x and y might just as easily be 1 or 56789 -- it 
> > literally arises "out of thin air".
> 
> Maybe one can distinguish further between OOTA values (which are 
> arbitrary, not-computed values) and more generally OOTA behaviors.
> 
> How do you feel about examples like the one below:

There's something wrong with this example.

> void *y[2];
> void *x[2] = { (void*)&y[1], (void*)&y[0] };
> 
> P0() {
>     void **t = (void**)(x[0]);

Now t holds a pointer to y[1].

>     *t = (void*)(t-1);

And now y[1] holds a pointer to y[0].

> }
> P1() {
>     void **u = (void**)(x[1]);	

Now u holds a pointer to y[0].

>     *u = (void*)(u+1);

And now y[0] holds a pointer to y[1].

> }
> 
> In this test case the locations x[0] and x[1] exist in the program and 
> are accessed, but their addresses are never (explicitly) taken or 
> stored anywhere.

Although they are dereferened.

> Nevertheless t=&x[1] and u=&x[0] could happen in an appropriately weak 
> memory model (if the data races make you unhappy, you can add relaxed 
> atomic/marked accesses); but not arbitrary values --- if t is not 
> &x[1], it must be &y[1].

I don't see how.  The comments I added above show what values t and u 
must hold, regardless of how the program executes.  The contents of x[] 
never get changed, so there's no question about the values of t and u.

> To me, OOTA suggests simply that the computation can not happen 
> "organically" in a step-by-step way, but can only pop into existence 
> as a whole, "out of thin air" (unless one allows for very aggressive 
> speculation and rollback).

All right, this is more a matter of personal taste and interpretation.  
Is it the computation or the values that pops into existence?  You can 
think of these OOTA computations as arising in a (sort of) ordinary 
step-by-step way, provided you allow loads to read from stores that 
haven't happened yet (a very aggressive form of speculation indeed!).

> In this context I always picture the famous Baron Münchhausen, who 
> pulled himself from mire by his own hair. (Which is an obviously false 
> story because gentlemen at that time were wearing wigs, and a wig 
> could not possibly carry his weight...)

There is a comparable American expression, "pull oneself up by one's 
bootstraps", from which is derived the term "boot" for starting up a 
computer.  :-)

Alan
