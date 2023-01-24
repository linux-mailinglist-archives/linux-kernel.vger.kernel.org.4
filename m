Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6D867A00A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 18:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbjAXRWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 12:22:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233728AbjAXRWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 12:22:18 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 22F844A20D
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 09:22:12 -0800 (PST)
Received: (qmail 173989 invoked by uid 1000); 24 Jan 2023 12:22:11 -0500
Date:   Tue, 24 Jan 2023 12:22:11 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
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
Message-ID: <Y9ATwzit6V/aUolL@rowland.harvard.edu>
References: <20220921173109.GA1214281@paulmck-ThinkPad-P17-Gen-1>
 <YytfFiMT2Xsdwowf@rowland.harvard.edu>
 <YywXuzZ/922LHfjI@hirez.programming.kicks-ass.net>
 <114ECED5-FED1-4361-94F7-8D9BC02449B7>
 <Y8lynRI35cFeuqb5@rowland.harvard.edu>
 <280fb8f6-f1fd-76ce-7851-cf720820c44e@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <280fb8f6-f1fd-76ce-7851-cf720820c44e@huaweicloud.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 04:54:42PM +0100, Jonas Oberhauser wrote:
> 
> 
> On 1/19/2023 5:41 PM, Alan Stern wrote:
> > On Thu, Jan 19, 2023 at 12:22:50PM +0100, Jonas Oberhauser wrote:
> > > 
> > > On 1/19/2023 3:28 AM, Alan Stern wrote:
> > > > > This is a permanent error; I've given up. Sorry it didn't
> > > > work out.
> > > [It seems the e-mail still reached me through the mailing list]
> > [For everyone else, Jonas is referring to the fact that the last two
> > emails I sent to his huaweicloud.com address could not be delivered, so
> > I copied them off-list to his huawei.com address.]
> > 
> > > > > I consider that a hack though and don't like it.
> > > > It _is_ a bit of a hack, but not a huge one.  srcu_read_lock() really
> > > > is a lot like a load, in that it returns a value obtained by reading
> > > > something from memory (along with some other operations, though, so it
> > > > isn't a simple straightforward read -- perhaps more like an
> > > > atomic_inc_return_relaxed).
> > > The issue I have with this is that it might create accidental ordering. How
> > > does it behave when you throw fences in the mix?
> > I think this isn't going to be a problem.  Certainly any real
> > implementation of scru_read_lock() is going to involve some actual load
> > operations, so any unintentional ordering caused by fences will also
> > apply to real executions.  Likewise for srcu_read_unlock and store
> > operations.
> 
> Note that there may indeed be reads in the implementation, but most likely
> not from the srcu_read_unlock()s of other threads. Most probably from the
> synchronize_srcu() calls. So the rfe edges being added are probably not
> corresponding to any rfe edges in the implementation.
> 
> That said, I believe there may indeed not be any restrictions in behavior
> caused by this, because any code that relies on the order being a certain
> thing would need to use some other ordering mechanism, and that would
> probably restrict the behavior anyways.
> 
> It does have the negative side-effect of creating an explosion of
> permutations though, by ordering all unlocks() in a total way and also
> sometimes allowing multiple options for each lock() (e.g., lock();unlock()
> || lock();unlock()  has 4 executions instead of 1).

That's true.  It would be nice if there was a class of write-like events 
which couldn't be read from and didn't contribute to the coherence 
ordering.

Alan

> Anyways, not much to be done about it right now.
> 
> best wishes, jonas
> 
