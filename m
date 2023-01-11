Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED824666157
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 18:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236627AbjAKRFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 12:05:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235681AbjAKREt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 12:04:49 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id E54D73F126
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 09:02:01 -0800 (PST)
Received: (qmail 717901 invoked by uid 1000); 11 Jan 2023 12:01:53 -0500
Date:   Wed, 11 Jan 2023 12:01:53 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Jonas Oberhauser <jonas.oberhauser@huawei.com>
Cc:     "paulmck@kernel.org" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "parri.andrea" <parri.andrea@gmail.com>, will <will@kernel.org>,
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
Message-ID: <Y77rgeg+UgozV/oF@rowland.harvard.edu>
References: <20220921173109.GA1214281@paulmck-ThinkPad-P17-Gen-1>
 <YytfFiMT2Xsdwowf@rowland.harvard.edu>
 <YywXuzZ/922LHfjI@hirez.programming.kicks-ass.net>
 <114ECED5-FED1-4361-94F7-8D9BC02449B7>
 <Y77QbG9lVXX9/B87@rowland.harvard.edu>
 <768ffe7edc7f4ddfacd5b0a8e844ed84@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <768ffe7edc7f4ddfacd5b0a8e844ed84@huawei.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 04:45:46PM +0000, Jonas Oberhauser wrote:
> 
> 
> -----Original Message-----
> From: Alan Stern [mailto:stern@rowland.harvard.edu] 
> > On Wed, Jan 11, 2023 at 11:33:33AM +0000, Jonas Oberhauser wrote:
> > > Considering how much effort it is to keep the documentation up-to-date 
> > > even for small changes, I'm extremely oscillation-averse.
> > > Interestingly as I go through the documentation while preparing each 
> > > patch I often find some remarks hinting at the content of the patch, 
> > > e.g. "fences don't link events on different CPUs" and "rcu-fence is 
> > > able to link events on different CPUs.  (Perhaps this fact should lead 
> > > us to say that rcu-fence isn't really a fence at all!)" in the current 
> > > explanation.txt.
> >
> > > [...] that I'll use strong-order right away, and then rename the handful of 
> > > other fences-but-not-really-at-all to '-order' as well.
> > 
> > Minor snag: There already is an rcu-order relation in the memory model.
> > Maybe we need a different word from "order".  Or maybe rcu-order should be renamed.
> 
> Yeah, I noticed (it's in the same section I'm quoting from above). There are
> some other minor things that might need editing in that section, e.g.,
> "Written symbolically, X ->rcu-fence Y means
> there are fence events E and F such that:
> 
>         X ->po E ->rcu-order F ->po Y."
> But in fact the definition is
>     let rcu-fence = po ; rcu-order ; po?
> which allows for F = Y and not F ->po Y.

Yeah, that should be fixed.

> I'll need to get a better understanding of rcu-order before I can form an
> opinion of how things could be organized. The only thing I'm certain of is that
> strong-order and rcu-fence should end up with the same suffix :D
> 
> Just looking at it from afar, it almost looks like there's a simpler,
> non-recursive definition of rcu-order trying to come out. I assume you've tried
> various things and they don't work xP ?

What is there to try?  As far as I know, the only construct in the cat 
language that can be used to get the effect of counting is a recursive 
definition.

> Is it because you use the recursion to "count" the grace periods and read-side
> critical sections, in the sense of maintaining the inequality invariant between
> them? I wonder if there's a "pumping lemma" that can show this can't be done
> with a non-recursive definition.

Such a lemma would have to be based on the other constructs available in 
the language.  The only things I can think of which even come close are 
the * and + operators, and they are insufficient (because they are no 
stronger than regular expressions, which are well known to be too weak 
-- there isn't even a regular expression for strings in which the 
parentheses are balanced).

Alan
