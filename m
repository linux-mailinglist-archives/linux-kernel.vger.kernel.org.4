Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED61D6B9843
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 15:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjCNOto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 10:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjCNOtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 10:49:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9CC94A47
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 07:49:40 -0700 (PDT)
Date:   Tue, 14 Mar 2023 15:49:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678805379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7YFHckriCMIdr9kUoM7FMHDbsRQmaXCTgjXnH75tQxI=;
        b=M7gUTRd/kSXb7qsh0vrZrpFeaz4XLoFh5yIf2+7UUmdmp9qNADGZOyt+Pyi35oIZO2o2Y2
        XxG0Sp156I00LT6NYxWpn6G634j2U1L2eC4tHoxqAG/InsfqYXwjlZseg6l27A6YEsruqW
        TWZuaIkkyD0RIRtncu3p1GyQzfxERdBE3wyv5Q10vpdpJZg5vCHHTsJ7HEcC8al64vtKhd
        2kp9k2LGaxIX1JtrXmLocE3fl7dpTNMW2qHhCaQ4WM7qVO3PYjIVD73KDGlfK/4eYTplLx
        Z6DZyM12eWBrvMBwmVFl04vi966c4sk3lxuahgZJgZoSUczKnn6EovkactaBOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678805379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7YFHckriCMIdr9kUoM7FMHDbsRQmaXCTgjXnH75tQxI=;
        b=ok2uJZxOpaJzGf/a4ZbOllQHSWQntHtcfoD8M4+j3+hqMP6Fo3RoFhuBY2IxosvLYx5Ecw
        0sZuSTAiYNtFM/CA==
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
To:     Frederic Weisbecker <frederic@kernel.org>
cc:     linux-kernel@vger.kernel.org,
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
In-Reply-To: <ZBB1frBCnpG741ma@localhost.localdomain>
Message-ID: <d9b95aba-c37d-961c-3ec4-68f222b6df89@linutronix.de>
References: <20230301141744.16063-1-anna-maria@linutronix.de> <20230301141744.16063-17-anna-maria@linutronix.de> <ZBB1frBCnpG741ma@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-168046067-1678805378=:5218"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-168046067-1678805378=:5218
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Tue, 14 Mar 2023, Frederic Weisbecker wrote:

> Le Wed, Mar 01, 2023 at 03:17:42PM +0100, Anna-Maria Behnsen a écrit :
> > diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
> > new file mode 100644
> > index 000000000000..5a600de3623b
> > --- /dev/null
> > +++ b/kernel/time/timer_migration.c
> > +static bool tmigr_active_up(struct tmigr_group *group,
> > +			    struct tmigr_group *child,
> > +			    void *ptr)
> > +{
> > +	union tmigr_state curstate, newstate;
> > +	struct tmigr_walk *data = ptr;
> > +	bool walk_done;
> > +	u32 childmask;
> > +
> > +	childmask = data->childmask;
> > +	newstate = curstate = data->groupstate;
> > +
> > +retry:
> > +	walk_done = true;
> > +
> > +	if (newstate.migrator == TMIGR_NONE) {
> > +		newstate.migrator = (u8)childmask;
> > +
> > +		/* Changes need to be propagated */
> > +		walk_done = false;
> > +	}
> > +
> > +	newstate.active |= (u8)childmask;
> > +
> > +	newstate.seq++;
> 
> Are you sure you need this seq counter? What bad scenario can happen without it?
> 

Without the seq counter we might get an inconsistent overall state of the
groups when the order of propagating two changes of the child to the parent
changes. To clarify what I mean, let me give you an example what happens
without seqcount (maybe this should be described more detailed in the union
tmigr_state description...).

Let's take three groups and four CPUs (CPU2 and CPU3 as well as Group C
will not change during the scenario):

   	      	  Group A
		  migrator = Group B
		  active = Group B, Group C
	       /             \
    Group B			Group C
    migrator = CPU0		migrator = CPU2
    active = CPU0		active = CPU2
     /    \ 			 /  \
   CPU0   CPU1	 	      CPU2  CPU3
  active  idle               active idle


1. CPU0 goes idle (changes are updated in Group B; afterwards current
states of Group B and Group A are stored in the data for walking the
hierarchy):

   	      	  Group A
		  migrator = Group B
		  active = Group B, Group C
	       /             \
    Group B			Group C
->  migrator = TMIGR_NONE	migrator = CPU2
->  active =    		active = CPU2
     /    \ 			 /  \
   CPU0   CPU1	 	      CPU2  CPU3
-> idle   idle               active idle


2. CPU1 comes out of idle (changes are update in Group B; afterwards
current states of Group B and Group A are stored in the data for walking
the hierarchy):

   	      	  Group A
		  migrator = Group B
		  active = Group B, Group C
	       /             \
    Group B			Group C
->  migrator = CPU1		migrator = CPU2
->  active = CPU1   		active = CPU2
     /    \ 			 /  \
   CPU0   CPU1	 	      CPU2  CPU3
   idle -> active            active idle


3. Here comes the change of the order: Propagating the changes of
   2. through the hierarchy to group A - nothing to be done, because Group
   B is already up to date.

4. Propagating the changes of 1. through the hierarchy to group A:

   	      	  Group A
	      ->  migrator = Group C
	      ->  active =  Group C
	       /             \
    Group B			Group C
    migrator = CPU1		migrator = CPU2
    active = CPU1   		active = CPU2
     /    \ 			 /  \
   CPU0   CPU1	 	      CPU2  CPU3
   idle  active              active idle

And now we have this inconsistent overall state...

Thanks,

	Anna-Maria
--8323329-168046067-1678805378=:5218--
