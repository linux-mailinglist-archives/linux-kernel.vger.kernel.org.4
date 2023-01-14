Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24B566AD25
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 18:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjANRxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 12:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjANRxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 12:53:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5E293FA
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 09:53:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 980E4B80A2B
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 17:53:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B56BC433EF;
        Sat, 14 Jan 2023 17:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673718824;
        bh=oXALt+EPJvN0Uy1dnPMcanJkrT58sgBbaTGWyK8W39o=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=AedGyrZMRyns/tAqi5EdNLw0F47PHBBuKbsna02iTCDkVpF9M6R8JWmQjX/Xgjw+t
         kg89Q8zBaRsWEUz93Gn4QHlNW2FGIYroLhCXWtTIOgjTCGrr2saNSwtR1xm4Zw+fpO
         yR4daM3XyMGXKedBK+aRLGZC1FegFgQ7VGr6K802N/h7YxADTN4E5fZi4hgngvXY6h
         44CxPRgbE7vuzlSsKbgZES/Cv4bintQSAu1KuX51EG8PzN8ELp3YaafIXIcXTRSmEX
         vhagPgAxMR2crGyeV4yeTYaMarBOyWcYIlwBqBF9zHYaE8CwBfhULTK2gH+0Axi+ES
         1roZyUVLdFjng==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A12625C0AF8; Sat, 14 Jan 2023 09:53:43 -0800 (PST)
Date:   Sat, 14 Jan 2023 09:53:43 -0800
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
Message-ID: <20230114175343.GF2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220921173109.GA1214281@paulmck-ThinkPad-P17-Gen-1>
 <YytfFiMT2Xsdwowf@rowland.harvard.edu>
 <YywXuzZ/922LHfjI@hirez.programming.kicks-ass.net>
 <114ECED5-FED1-4361-94F7-8D9BC02449B7>
 <Y77QbG9lVXX9/B87@rowland.harvard.edu>
 <4c1abc7733794519ad7c5153ae8b58f9@huawei.com>
 <Y8GGmstFlgg91RMp@rowland.harvard.edu>
 <20230113200706.GI4028633@paulmck-ThinkPad-P17-Gen-1>
 <20230113203241.GA2958699@paulmck-ThinkPad-P17-Gen-1>
 <136d019d8c8049f6b737627df830e66f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <136d019d8c8049f6b737627df830e66f@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 08:43:42PM +0000, Jonas Oberhauser wrote:
> 
> 
> -----Original Message-----
> From: Paul E. McKenney [mailto:paulmck@kernel.org] 
> 
> > (* Compute matching pairs of Srcu-lock and Srcu-unlock *) let srcu-rscs = ([Srcu-lock] ; rfi ; [Srcu-unlock]) & loc
> 
> How does the Srcu-unlock read from the Srcu-lock? Is there something in your model or in herd that lets it understand lock and unlock should be treated as writes resp. reads from that specific location?
> 
> Or do you mean that value given to Srcu-unlock should be the value produced by Srcu-lock?

Yes, and in the Linux kernel one does something like this:

	idx = srcu_read_lock(&mysrcu);
	// critical section
	srcu_read_unlock(&mysrcu, idx);

> Perhaps the closest to what you want is to express that as a data dependency if you know how to teach herd that Srcu-unlock is a read and Srcu-lock depends on its second input :D (I have no idea how to do that, hence the questions above)

Given that both you and Alan suggested it, I must try it.  ;-)

> Then you could flag if there's a data dependency from more than one event, meaning that the value is not purely the Srcu-lock-produced value.

Good point, thank you!

> That doesn't guarantee you that you don't do some nasty stuff with constant values though. 

That is the purpose of this statement in the srcu_read_unlock()
implementation:

	WARN_ON_ONCE(idx & ~0x1);

But yes, this WARN_ON_ONCE() can of course be fooled.

> Could you maybe use an opaque datatype for the values?

We could put it in a struct or something.  The problem with making it
completely opaque is that the users must store it somewhere, which means
that the compiler needs to know how big it is.  Of course, languages
other than C have other ways to make this happen.  And correspondingly
slower build times.  ;-)

							Thanx, Paul
