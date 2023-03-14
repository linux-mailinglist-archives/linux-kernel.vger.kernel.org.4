Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1756B9A80
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 17:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbjCNQBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 12:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbjCNQBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 12:01:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8DA87375
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 09:01:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B8E961820
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 16:01:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B266C433EF;
        Tue, 14 Mar 2023 16:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678809683;
        bh=MmifNwjgZNLloiLUnexZsPDMf0EzznmXlu2+eeRriyk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hxe83OYp4Cte277OVGIEkfeuIIP/Ia5oqGaa8siCbpkF6gQE9jPh5OujZWOxA5Uad
         Lhr7FVCR0lnp0LHkCg//xVrd1dMIjvmso3H3e/ulYOHEjVCX3pQk62DkeDyP3YETo/
         rxMrxEFJdJGdmu1bJgNB/C0ENE6gnyq1NYYUDRWAtib9619bI8kvXwjy5hS5nH2snF
         fbYtdiuZjfIQUruIOcfq9hdmYT1a8YMHfCBwNc+YsvB8sbKKsHFR9aE3gKr4lD06tI
         xsraRvnhLig6ms0/7ykdVMq9H1zxuVqzv1sK1beCmzrO+ZYxdcGf5/J1qHiA+jfLMA
         kB5/rykybdJVg==
Date:   Tue, 14 Mar 2023 17:01:19 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH v5 16/18] timer: Implement the hierarchical pull model
Message-ID: <ZBCaT/0i7aCZffT3@localhost.localdomain>
References: <20230301141744.16063-1-anna-maria@linutronix.de>
 <20230301141744.16063-17-anna-maria@linutronix.de>
 <ZBB1frBCnpG741ma@localhost.localdomain>
 <d9b95aba-c37d-961c-3ec4-68f222b6df89@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d9b95aba-c37d-961c-3ec4-68f222b6df89@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Tue, Mar 14, 2023 at 03:49:38PM +0100, Anna-Maria Behnsen a écrit :
> On Tue, 14 Mar 2023, Frederic Weisbecker wrote:
> 
> > Le Wed, Mar 01, 2023 at 03:17:42PM +0100, Anna-Maria Behnsen a écrit :
> > > diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
> > > new file mode 100644
> > > index 000000000000..5a600de3623b
> > > --- /dev/null
> > > +++ b/kernel/time/timer_migration.c
> > > +static bool tmigr_active_up(struct tmigr_group *group,
> > > +			    struct tmigr_group *child,
> > > +			    void *ptr)
> > > +{
> > > +	union tmigr_state curstate, newstate;
> > > +	struct tmigr_walk *data = ptr;
> > > +	bool walk_done;
> > > +	u32 childmask;
> > > +
> > > +	childmask = data->childmask;
> > > +	newstate = curstate = data->groupstate;
> > > +
> > > +retry:
> > > +	walk_done = true;
> > > +
> > > +	if (newstate.migrator == TMIGR_NONE) {
> > > +		newstate.migrator = (u8)childmask;
> > > +
> > > +		/* Changes need to be propagated */
> > > +		walk_done = false;
> > > +	}
> > > +
> > > +	newstate.active |= (u8)childmask;
> > > +
> > > +	newstate.seq++;
> > 
> > Are you sure you need this seq counter? What bad scenario can happen without it?
> > 
> 
> Without the seq counter we might get an inconsistent overall state of the
> groups when the order of propagating two changes of the child to the parent
> changes. To clarify what I mean, let me give you an example what happens
> without seqcount (maybe this should be described more detailed in the union
> tmigr_state description...).
> 
> Let's take three groups and four CPUs (CPU2 and CPU3 as well as Group C
> will not change during the scenario):
> 
>    	      	  Group A
> 		  migrator = Group B
> 		  active = Group B, Group C
> 	       /             \
>     Group B			Group C
>     migrator = CPU0		migrator = CPU2
>     active = CPU0		active = CPU2
>      /    \ 			 /  \
>    CPU0   CPU1	 	      CPU2  CPU3
>   active  idle               active idle
> 
> 
> 1. CPU0 goes idle (changes are updated in Group B; afterwards current
> states of Group B and Group A are stored in the data for walking the
> hierarchy):
> 
>    	      	  Group A
> 		  migrator = Group B
> 		  active = Group B, Group C
> 	       /             \
>     Group B			Group C
> ->  migrator = TMIGR_NONE	migrator = CPU2
> ->  active =    		active = CPU2
>      /    \ 			 /  \
>    CPU0   CPU1	 	      CPU2  CPU3
> -> idle   idle               active idle
> 
> 
> 2. CPU1 comes out of idle (changes are update in Group B; afterwards
> current states of Group B and Group A are stored in the data for walking
> the hierarchy):
> 
>    	      	  Group A
> 		  migrator = Group B
> 		  active = Group B, Group C
> 	       /             \
>     Group B			Group C
> ->  migrator = CPU1		migrator = CPU2
> ->  active = CPU1   		active = CPU2
>      /    \ 			 /  \
>    CPU0   CPU1	 	      CPU2  CPU3
>    idle -> active            active idle
> 
> 
> 3. Here comes the change of the order: Propagating the changes of
>    2. through the hierarchy to group A - nothing to be done, because Group
>    B is already up to date.
> 
> 4. Propagating the changes of 1. through the hierarchy to group A:
> 
>    	      	  Group A
> 	      ->  migrator = Group C
> 	      ->  active =  Group C
> 	       /             \
>     Group B			Group C
>     migrator = CPU1		migrator = CPU2
>     active = CPU1   		active = CPU2
>      /    \ 			 /  \
>    CPU0   CPU1	 	      CPU2  CPU3
>    idle  active              active idle
> 
> And now we have this inconsistent overall state..

Ooh I see now. Also that can't ever wrap up since you can only ever have no more than 8 racers
competing on a given node.

Tricky ;)
