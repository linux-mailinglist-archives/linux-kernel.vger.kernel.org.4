Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4175966AD19
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 18:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjANRmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 12:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjANRmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 12:42:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FA1B75D
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 09:42:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0690D60C02
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 17:42:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56357C433D2;
        Sat, 14 Jan 2023 17:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673718127;
        bh=DBr2dfvAo+ffnzn+Wni3YbAR6iSPBoC4vY82PM0Jahg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=OaBN2HYJ+O5q3up7QbqPgBXjnFumGzmZokN2JvCmC/wkcWtH1lMZx3YLrNFCuQILj
         S8ZjwuTlMET2EarScsGrD6+gfiI8l9nqnHVbNJwww5AU2fic3CNEIpTZg+NEDK9Dot
         nvl96TB0s7g6MPatHn0QKc20s7KoQGiICm6G4I8L4RRCUFVm5y7qav4K5ABUzJlJtY
         k9J62GoA1BGPPb0HUAJm8fRi9A2P5Zh96Ngytm70FIIwfAZ7MxYNUyvVlxXilABMG4
         TV3q7CistXZ1serN7wn1PCqlgHtITB2mTV7ddjJH5x0304BJgc354XNKpvsOycG7vo
         sy9NHC9+AVZ0w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id F1AB55C0AF8; Sat, 14 Jan 2023 09:42:06 -0800 (PST)
Date:   Sat, 14 Jan 2023 09:42:06 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jonas Oberhauser <jonas.oberhauser@huawei.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
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
Message-ID: <20230114174206.GD2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220921173109.GA1214281@paulmck-ThinkPad-P17-Gen-1>
 <YytfFiMT2Xsdwowf@rowland.harvard.edu>
 <YywXuzZ/922LHfjI@hirez.programming.kicks-ass.net>
 <114ECED5-FED1-4361-94F7-8D9BC02449B7>
 <Y8GI+dbJ3uadVzSb@rowland.harvard.edu>
 <06a8aef7eb8d46bca34521a80880dae3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06a8aef7eb8d46bca34521a80880dae3@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 05:05:11PM +0000, Jonas Oberhauser wrote:
> -----Original Message-----
> From: Alan Stern [mailto:stern@rowland.harvard.edu] 
> Sent: Friday, January 13, 2023 5:38 PM
> 
> > Strictly speaking, this is not right.  It should say: For each process/CPU/task/whatever, an RCU grace period includes at least one moment in time during which that process is not within an RCU read-side critical section.  There does not have to be any single moment during which no processes are executing a critical section.
> 
> I see. I guess the other thing is more like a quiescent period.

"Quiescent period" was in fact my original name for "grace period"
back in the day, but a chorus of objections eventually prompted me to
instead label it a "grace period".

Perhaps you have given an improved rationale for their objections.  ;-)

>                                                                 I
> think the fact that RCU/safe memory reclamation(SMR) don't require a
> quiescent period is an important distinction, and even though we have
> our own SMR I never thought too deeply about this distinction.

If you want non-abysmal performance and scalability on modern hardware,
the distinction is critically important.  After all, the speed of light
really is finite, and atoms are of non-zero size.  And to the complete
surprise of my forty-years-ago self, these laws of physics seriously
constrain modern computing devices.

							Thanx, Paul
