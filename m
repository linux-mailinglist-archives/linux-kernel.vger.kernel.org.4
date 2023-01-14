Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2901266A9F6
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 08:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjANHcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 02:32:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjANHcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 02:32:07 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970DE2124
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 23:32:06 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id h10so16283374qvq.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 23:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ger4KU2Dz1Vds6traYL5dkaNpaTLAmJJXmZXIGQX0Go=;
        b=l6natnlT8vZp5PX2iQevJjy3+OPB86O+uFWg3f8ui7GNca947pzG9q4trP8XwOfmN7
         HJXWPTiscg+HTrapAKJEKSgasjEpWbY+kwFeQPJQxfAlMgOd8CU8gtn3291Sb7visRZw
         1cPvPavPJhn/gVtZsuyuwzfm9hbnc8CTUT+ZJDBM8kXp2b6GGBRfJWoH4HI2oywwjxKJ
         6bgXqlQU7slphPyd6r0V7zeOl+/Ifif72+by4bbY3DpogwlCfGOQ+0bq83Ghid1ZgPjr
         dPtYem45/5NCpaGfPg3o7UvRJ4C2HSEX9D++2kRe2iO8ib46vltk3+QG7qd8OY3k43pW
         ur8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ger4KU2Dz1Vds6traYL5dkaNpaTLAmJJXmZXIGQX0Go=;
        b=h4AC4VNY/NpvuXBVMZFpoFg/8y3pYqLynibR5sRqwPMidp+o64D5CUUYeXL30rawk+
         4OmxTAS45IwKbQcJz0QUDzCTZhLaafwSpcwvCtMz5163I2i3Ahs+rTIjwOz9xP+lHNF6
         rz/a0BjQScZBmBNX/rkTx8NOMgRWI6Z7A9ZPwUNiM476qZsb8Whiqhe8JhBy1d6z8Y69
         TcMJ8hXJFLkqd0buYSBcsVN3NegJcbFXqH/0FM/K87YH92P//JSbimlGtP0XgZn/XQd6
         5OuDDhKScQkTb5zbWv/zq8/Vs/ne9AgHe9PVORvukGQbNgWd04osmcSINm3dfPXgYbZj
         ee0Q==
X-Gm-Message-State: AFqh2kpYUqUqipTL6XzdJAQIp9XnbAIkOp4blJYt81tbSZUFnU+It5l8
        z01d3C8evUguZSWz/AmrBgI=
X-Google-Smtp-Source: AMrXdXvesyww/w6Xe8QvYhchlxrT6S7HVfagJBYMOXB4mutPAAdRicpPcWicbz4/tXET4PPeYnNB6Q==
X-Received: by 2002:a0c:aa07:0:b0:531:9e7a:6778 with SMTP id d7-20020a0caa07000000b005319e7a6778mr16744561qvb.1.1673681525761;
        Fri, 13 Jan 2023 23:32:05 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id l14-20020a05620a28ce00b007062139ecb3sm2222815qkp.95.2023.01.13.23.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 23:32:05 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 6F93427C0054;
        Sat, 14 Jan 2023 02:32:03 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sat, 14 Jan 2023 02:32:04 -0500
X-ME-Sender: <xms:c1rCYxGo4nTnGlmsEw_EiLJ2dfcxTqRzA-Rk2XZMZ60FK_JZg68DMw>
    <xme:c1rCY2XxIl1607TjFifkhSKAZ8h3kmnj_tO_gifCTR2ZBsREXZAswiDzh1pztBZAE
    C_XbaCc_glmvOArOA>
X-ME-Received: <xmr:c1rCYzLePSPZbPaGh1-HU8JOLZYMSur4co0Y4WTCEkCXwPGs04rUByhucPcofQUurrk54elTttKdJOsJtBS3QsOqTcD-74e2vsU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrleelgdduuddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:c1rCY3Hz8w178VT_zUhrBAWc5H2IlevYHI-BFYF7dmEwsrWrIeLw3w>
    <xmx:c1rCY3XxBcSziyrAg9WtxthZbCVLR5ySa-pGgc_eM2DM0_yU8pgcRQ>
    <xmx:c1rCYyOJOVz_Z0bBWAnHYjeQCuNhWCdlZpl7AO_PE0BjNQJowt4_Ow>
    <xmx:c1rCY5Iz_qXh7gBrae-rgQ_-gBDz9tZM0ady_Q8aHkKDKYV3rFS5Hw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Jan 2023 02:32:02 -0500 (EST)
Date:   Fri, 13 Jan 2023 23:32:01 -0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 2/3] rcu: Equip sleepable RCU with lockdep dependency
 graph checks
Message-ID: <Y8JacQO1PW7va7rf@Boquns-Mac-mini.local>
References: <20230113065955.815667-1-boqun.feng@gmail.com>
 <20230113130330.1027-1-hdanton@sina.com>
 <20230113235809.1085-1-hdanton@sina.com>
 <20230114071832.1162-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230114071832.1162-1-hdanton@sina.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 14, 2023 at 03:18:32PM +0800, Hillf Danton wrote:
> On Fri, 13 Jan 2023 16:17:59 -0800 Boqun Feng <boqun.feng@gmail.com>
> > On Sat, Jan 14, 2023 at 07:58:09AM +0800, Hillf Danton wrote:
> > > On 13 Jan 2023 09:58:10 -0800 Boqun Feng <boqun.feng@gmail.com>
> > > > On Fri, Jan 13, 2023 at 09:03:30PM +0800, Hillf Danton wrote:
> > > > > On 12 Jan 2023 22:59:54 -0800 Boqun Feng <boqun.feng@gmail.com>
> > > > > > --- a/kernel/rcu/srcutree.c
> > > > > > +++ b/kernel/rcu/srcutree.c
> > > > > > @@ -1267,6 +1267,8 @@ static void __synchronize_srcu(struct srcu_struct *ssp, bool do_norm)
> > > > > >  {
> > > > > >  	struct rcu_synchronize rcu;
> > > > > >  
> > > > > > +	srcu_lock_sync(&ssp->dep_map);
> > > > > > +
> > > > > >  	RCU_LOCKDEP_WARN(lockdep_is_held(ssp) ||
> > > > > >  			 lock_is_held(&rcu_bh_lock_map) ||
> > > > > >  			 lock_is_held(&rcu_lock_map) ||
> > > > > > -- 
> > > > > > 2.38.1
> > > > > 
> > > > > The following deadlock is able to escape srcu_lock_sync() because the
> > > > > __lock_release folded in sync leaves one lock on the sync side.
> > > > > 
> > > > > 	cpu9		cpu0
> > > > > 	---		---
> > > > > 	lock A		srcu_lock_acquire(&ssp->dep_map);
> > > > > 	srcu_lock_sync(&ssp->dep_map);
> > > > > 			lock A
> > > > 
> > > > But isn't it just the srcu_mutex_ABBA test case in patch #3, and my run
> > > > of lockdep selftest shows we can catch it. Anything subtle I'm missing?
> > > 
> > > I am leaning to not call it ABBA deadlock, because B is unlocked.
> > > 
> > > 	task X		task Y
> > > 	---		---
> > > 	lock A
> > > 	lock B
> > > 			lock B
> > > 	unlock B
> > > 	wait_for_completion E
> > > 
> > > 			lock A
> > > 			complete E
> > > 
> > > And no deadlock should be detected/caught after B goes home.
> > 
> > Your example makes me more confused.. given the case:
> > 
> > 	task X		task Y
> > 	---		---
> > 	mutex_lock(A);
> > 			srcu_read_lock(B);
> > 	synchronze_srcu(B);
> > 			mutex_lock(A);
> > 
> > isn't it a deadlock?
> 
> Yes and nope, see below.
> 
> > If your example, A, B or E which one is srcu?
> 
> A and B are mutex, and E is completion in my example to show the failure
> of catching deadlock in case of non-fake lock. Now see srcu after your change.
> 
>  	task X			task Y
>  	---			---
>  	mutex_lock(A);
>  				srcu_read_lock(B);
> 				srcu_lock_acquire(&B->dep_map);
> 				a) lock_map_acquire_read(&B->dep_map);
>  	synchronze_srcu(B);
> 	__synchronize_srcu(B);
> 	srcu_lock_sync(&B->dep_map);
> 	lock_map_sync(&B->dep_map);
> 	lock_sync(&B->dep_map);
> 	__lock_acquire(&B->dep_map);

At this time, lockdep add dependency A -> B in the dependency graph.

> 				b) lock_map_acquire_read(&B->dep_map);
> 	__lock_release(&B->dep_map);
> 				c) lock_map_acquire_read(&B->dep_map);
>  				mutex_lock(A);

and here, lockdep will try to add dependency B -> A into the dependency
graph, and find that A -> B -> A will form a circle (with strong
dependency), therefore lockdep knows it's a deadlock.

>  
> No deadlock could be detected if taskY takes mutexA after taskX releases B,

The timing that taskX releases B doesn't master, since lockdep uses
graph to detect deadlocks rather than after-fact detection.

> and how taskY acquires B does not matter as per the a), b) and c) modes in
> the above chart, again because releasing lock can break deadlock in general.

I have test cases showing the above deadlock can be detected, so if you
think there is a deadlock that may dodge from my change, feel free to
add a test case in lib/locking-selftest.c ;-)

Regards,
Boqun

