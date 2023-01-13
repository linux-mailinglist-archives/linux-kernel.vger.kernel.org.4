Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7556266A3BB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 20:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbjAMTys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 14:54:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbjAMTyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 14:54:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D86888DDC
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 11:54:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 154BCB821DF
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 19:54:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90CB0C433D2;
        Fri, 13 Jan 2023 19:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673639671;
        bh=Y/w6vJeJuHUinD9KGK3kerO1AhLkFCVJWK8dB6aZrEY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=pJmT5Pvvo80X5igVBOPtwUrPD1cNfy7bqXsPVWT0YUga6gGRoD4sol1R1RUyhvN2l
         F2gT5vI0b67gg5fwwkTqjG0F7CDNUBxUDPMhCDUT0Ogz4pYjqq4Q5GnkK5SP/tC2lM
         qaN7zt7ErIco6vB3iZNrrJ3BbSZeQEgq8BkoGifp9NcNgHrwGvsrh5of9mJxFAQGvC
         a09Sp5e67SkHxpYs4QNUfEzBjV3gzAh6iLSA6j5K6JmD2MMhOEk793KzHLgxu2Mybq
         +KJzWkiFk4t+x4njhjW/Uc7IzJ/npy+2iKWSjfxcHB0PI7Dr/MWXslxtx8iS1uVtPx
         iLBaWHPjn4OPQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2D53E5C06D0; Fri, 13 Jan 2023 11:54:31 -0800 (PST)
Date:   Fri, 13 Jan 2023 11:54:31 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Jonas Oberhauser <jonas.oberhauser@huawei.com>,
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
Message-ID: <20230113195431.GH4028633@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220921173109.GA1214281@paulmck-ThinkPad-P17-Gen-1>
 <YytfFiMT2Xsdwowf@rowland.harvard.edu>
 <YywXuzZ/922LHfjI@hirez.programming.kicks-ass.net>
 <114ECED5-FED1-4361-94F7-8D9BC02449B7>
 <Y77rgeg+UgozV/oF@rowland.harvard.edu>
 <07579baee4b84532a76ea8b0b33052bb@huawei.com>
 <20230112215716.GS4028633@paulmck-ThinkPad-P17-Gen-1>
 <Y8GI+dbJ3uadVzSb@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8GI+dbJ3uadVzSb@rowland.harvard.edu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 11:38:17AM -0500, Alan Stern wrote:
> On Thu, Jan 12, 2023 at 01:57:16PM -0800, Paul E. McKenney wrote:
> 
> > I will risk sharing the intuition behind the rcu-order counting rule.
> > 
> > In the code, an RCU read-side critical section begins with rcu_read_lock()
> > and ends with the matching rcu_read_unlock().  RCU read-side critical
> > section may be nested, in which case RCU cares only about the outermost
> > of the nested set.
> > 
> > An RCU grace period includes at least one moment in time during which
> > each and every process/CPU/task/whatever is not within an RCU read-side
> > critical section.
> 
> Strictly speaking, this is not right.  It should say: For each 
> process/CPU/task/whatever, an RCU grace period includes at least one 
> moment in time during which that process is not within an RCU read-side 
> critical section.  There does not have to be any single moment during 
> which no processes are executing a critical section.
> 
> For example, the following is acceptable:
> 
> CPU 0:               start of synchronize_rcu()......end
> CPU 1:  rcu_lock().....................rcu_unlock()
> CPU 2:                    rcu_lock().......................rcu_unlock()

You are quite right, thank you!  Yes, the time outside of an RCU
read-side critical section for a given process/CPU/task/whatever need
not be simultaneous with any other process/CPU/task/whatever.

							Thanx, Paul
