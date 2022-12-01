Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F9763F8EC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 21:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbiLAUVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 15:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiLAUVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 15:21:08 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 4DC83BEE04
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 12:21:07 -0800 (PST)
Received: (qmail 501838 invoked by uid 1000); 1 Dec 2022 15:21:06 -0500
Date:   Thu, 1 Dec 2022 15:21:06 -0500
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
Message-ID: <Y4kMskpQGOvlPyYf@rowland.harvard.edu>
References: <20221201121808.20785-1-jonas.oberhauser@huaweicloud.com>
 <Y4jQC9ejAQqJFTo+@rowland.harvard.edu>
 <6abbb72eef6149eb842a3351ecea7af5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6abbb72eef6149eb842a3351ecea7af5@huawei.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 05:21:45PM +0000, Jonas Oberhauser wrote:
> Thanks a lot for the helpful and detailed comments!
> Three minor points before I send a new patch:
> 
> > even if W' or R' (or both!) is plain.	
> 
> The "is" sounds slightly weird to me in the sentence because the last part I read is 
> "(or both!)", so I would slightly prefer "are" here.

People are pretty casual about subject-verb number agreement these days 
(there's a growing tendency in English for people to make the verb agree 
with the last noun occurring in the subject rather than the subject as a 
whole), so that should be okay.

> > On the other hand, if you change the second "dependencies" to "ones" and "unmarked" to "plain", maybe the whole thing will fit on one line.
> 
> It fits even if I changed the second dependencies to "those" instead of "ones", i.e.,
> (* Redefine dependencies to include those carried through plain accesses *)
> 
> which I would prefer.

Fine.

> > if you replaced the whole conditional with a simple
> >	WRITE_ONCE(*y, *z2);
> > then the litmus test would become an example of OOTA!
> 
> In my opinion it is already an example of OOTA, which I would define as an
>    rfi | ctrl | addr | data | fence
> cycle.

That's not an unreasonable point of view (if you put rfe rather than 
rfi), but to me OOTA suggests something more: a value arising as if by 
magic rather than as a result of a computation.  In your version of the 
litmus test there is WRITE_ONCE(*y, 1), so it's a little understandable 
that you could end up with 1 as the final values of x and y.  But in my 
version, no values get computed anywhere, so the final value of x and y 
might just as easily be 1 or 56789 -- it literally arises "out of thin 
air".

> Let me know if you agree with these deviations from your suggestion
> and have a great time,

Yes; with those changes you can add:

Reviewed-by: Alan Stern <stern@rowland.harvard.edu>

> jonas
> 
> PS: 
> > When a colon is followed by a clause (as opposed to a list), it is customary to capitalize the first letter of that clause, just like we capitalize the first letter at the start of a sentence.
> 
> In German, we also capitalize after a colon; but my English teachers used to deduct many points throughout my adolescent life whenever I capitalized like that. I still remember some of that red ink with near perfect clarity. So I eventually really took it to heart and started pedantically not-capitalizing after every colon.
> Now the only time it ever mattered in my adult life, I find that I should do it German Style (or, as I just learned, APA & AP Style).
> I suppose life is that way sometimes.

Indeed.

Alan
