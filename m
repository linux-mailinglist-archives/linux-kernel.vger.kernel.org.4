Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5581D67D0DB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 17:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbjAZQDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 11:03:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232483AbjAZQDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 11:03:05 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 19D10DBE1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 08:02:52 -0800 (PST)
Received: (qmail 263998 invoked by uid 1000); 26 Jan 2023 11:02:52 -0500
Date:   Thu, 26 Jan 2023 11:02:52 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
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
Subject: Re: [Patch 2/2] tools/memory-model: Provide exact SRCU semantics
Message-ID: <Y9KkLHWzuIQ8sDwq@rowland.harvard.edu>
References: <Y9GO3xEYkIQq/qSl@rowland.harvard.edu>
 <Y9GPI/g23YWx+0Ce@rowland.harvard.edu>
 <Y9GPVnK6lQbY6vCK@rowland.harvard.edu>
 <c44183e7-44ae-4be3-bb47-517067a112b5@huaweicloud.com>
 <Y9Gyuj+2UFefUdJS@rowland.harvard.edu>
 <edadb690-e791-0e9c-e641-ea8876abe96e@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <edadb690-e791-0e9c-e641-ea8876abe96e@huaweicloud.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 12:30:14PM +0100, Jonas Oberhauser wrote:
> 
> 
> On 1/25/2023 11:52 PM, Alan Stern wrote:
> > On Wed, Jan 25, 2023 at 10:04:29PM +0100, Jonas Oberhauser wrote:
> > > 
> > > On 1/25/2023 9:21 PM, Alan Stern wrote:
> > > >    (* Validate nesting *)
> > > >    flag ~empty Srcu-lock \ domain(srcu-rscs) as unmatched-srcu-lock
> > > >    flag ~empty Srcu-unlock \ range(srcu-rscs) as unmatched-srcu-unlock
> > > > +flag ~empty (srcu-rscs^-1 ; srcu-rscs) \ id as multiple-srcu-matches
> > > [...]
> > > >    // SRCU
> > > > -srcu_read_lock(X)  __srcu{srcu-lock}(X)
> > > > -srcu_read_unlock(X,Y) { __srcu{srcu-unlock}(X,Y); }
> > > > +srcu_read_lock(X) __load{srcu-lock}(*X)
> > > > +srcu_read_unlock(X,Y) { __store{srcu-unlock}(*X,Y); }
> > > > +srcu_down_read(X) __load{srcu-lock}(*X)
> > > > +srcu_up_read(X,Y) { __store{srcu-unlock}(*X,Y); }
> > > How do you feel about introducing Srcu-up and Srcu-down with this patch?
> > Why invent new classes for them?  They are literally the same operation
> > as Srcu-lock and Srcu-unlock; the only difference is how the kernel's
> > lockdep checker treats them.
> I don't think they're necessarily implemented in a compatible way, so
> 
> r = srcu_lock(s);
> srcu_up(s,r);
> 
> might not actually work, but would currently be ok'ed by LKMM.

I'll let Paul answer this.

>  With
> different classes you could state
>   flag ~empty [Srcu-lock];srcu-rscs;[Srcu-up] as srcu-mismatch-lock-to-up
>   flag ~empty [Srcu-down];srcu-rscs;[Srcu-unlock] as
> srcu-mismatch-down-to-unlock
> 
> I think with the current implementation this code might work, but I don't
> feel like this is inherently true.
> 
> You could then also go ahead and define the "same CPU" requirement as a flag
> for lock and unlock specifically, like
>   flag ~empty [Srcu-lock];srcu-rscs & ext as srcu-lock-unlock-mismatch-CPU
> or so.

Bear in mind that the herd7 model is not obliged to find and warn about 
all possible bugs in a litmus test.  Especially if the same code would 
generate a warning or error when run in the kernel.

Alan
