Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4AC678884
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 21:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbjAWUlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 15:41:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232711AbjAWUlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 15:41:35 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id AB5548A5B
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 12:41:08 -0800 (PST)
Received: (qmail 140283 invoked by uid 1000); 23 Jan 2023 15:41:08 -0500
Date:   Mon, 23 Jan 2023 15:41:08 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc:     Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
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
Message-ID: <Y87w5KHZ2UP2aLLG@rowland.harvard.edu>
References: <20220921173109.GA1214281@paulmck-ThinkPad-P17-Gen-1>
 <YytfFiMT2Xsdwowf@rowland.harvard.edu>
 <YywXuzZ/922LHfjI@hirez.programming.kicks-ass.net>
 <114ECED5-FED1-4361-94F7-8D9BC02449B7>
 <Y87m5KcSaieYZyeM@rowland.harvard.edu>
 <d1a576ee-4af4-6053-8ae2-dc04fdd1b73b@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d1a576ee-4af4-6053-8ae2-dc04fdd1b73b@huaweicloud.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 09:06:54PM +0100, Jonas Oberhauser wrote:
> 
> 
> On 1/23/2023 8:58 PM, Alan Stern wrote:
> > On Mon, Jan 23, 2023 at 05:16:27PM +0100, Jonas Oberhauser wrote:
> > > On 1/19/2023 5:41 PM, Alan Stern wrote:
> > > 
> > > > But when you're comparing grace periods or critical sections to each other,
> > > > things get a little ambiguous.  Should G1 be considered to come before
> > > > G2 when t1(G1) < t1(G2), when t2(G1) < t2(G2), or when t2(G1) < t1(G2)?
> > > > Springing for (po ; rcu-order ; po?) amounts to choosing the second
> > > > alternative.
> > > Aha, I see! Powerful notation indeed.
> > > Keeping that in mind, wouldn't it make sense for pb also be changed to
> > > `...;po?` ?
> > You mean changing the definition of pb to either:
> > 
> > 	prop ; strong-fence ; hb* ; po? ; [Marked]
> > 
> > or
> > 
> > 	prop ; strong-fence ; hb* ; [Marked] ; po? ; [Marked]
> 
> Oh no, not at all!
> 
> I mean that
>     pb = prop ; po ; {strong ordering-operation} ; po ; hb* ; [Marked]
> could instead be
>     pb = prop ; po ; {strong ordering-operation} ; po? ; hb* ; [Marked]
> 
> (note that the po ; ... ; po part is actually folded inside the actual
> definition of strong fence).

This goes back to the original herd models, before the LKMM came about: 
The fencerel() macro uses po on both sides.  I believe the motivating 
idea back then was that ordering should apply only to memory accesses 
(which can in practice be observed), not to other types of events such 
as memory barriers.

> > rcu-fence is different because rcu-order has to begin and end with
> > either a grace period or a critical section, and both of these restrict
> > the execution order of surrounding events:
> > 
> > 	If X is a synchronize_rcu() or rcu_read_unlock() then events
> > 	po-before X must execute before X;
> > 
> > 	If X is a synchronize_rcu() or rcu_read_lock() then events
> > 	po-after X must execute after X.
> > 
> I believe so do the strong ordering-operations in pb.

But the beginning and end of a pb link (for example, overwrite and hb) 
don't need to be strong-ordering operations.

Alan
