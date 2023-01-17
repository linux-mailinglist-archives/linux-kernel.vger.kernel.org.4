Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C635766DCCE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 12:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236863AbjAQLqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 06:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236788AbjAQLqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 06:46:38 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1344305F7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 03:46:36 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id vw16so11570178ejc.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 03:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JTxBdBKn5Gn3RVawxsj7pf2hiKR8Mt7aw/W9+WAkxQ8=;
        b=GTKubUFvRJgayLS2gTLnkWDxAYiINCobj98DDLmBrTu66Shn/wde5gs9zo8wsbmOby
         Zdhq5MqYepvfig6QqR5l7CcLGwVtr2LSl7m+D5R5lqSwB++oTN3P1hODwrtX3cam8bOa
         QFLJ7wouBkIFZPCnVo42s4WF4/ZQp8Bl6xkVPXWTdcKqQp+5SfuI+hzT/ibbLZn/uBRd
         e3DInayNwYvbX1Nup9DwxDA/t+osZI6WOE6yafXCWPTM61HaI7thlohRA4Gb2XzzKOdR
         FO/2yYPqp67kL68eTvvOX/2fQboc/YfSuuDY7zZ3PQ5Ly6JZ8dKoD8hrvgr9mWVy6gQr
         7BIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JTxBdBKn5Gn3RVawxsj7pf2hiKR8Mt7aw/W9+WAkxQ8=;
        b=c3oolo1fnq54iUkC0PzBnklFXr7PA3SGuYWXlvBs1ghzZVw+UDh+YprB9wgVBdCzdJ
         RjLb8SfzKA0/PpDEgB1utsIFW84VjwnvZPclZPLFw+sN1v3ikUxMzKQYv8b+9/6e8wh5
         gBi7/QAMtM9XZPZKG0OfntZLlH+XUVpErMhX2w2pLy+tyyapAyhLk3CORZUnqRgQm69m
         muBYucVx1PSEVOEReHj24YHymhmNDoPW320bbNZ5r/ZLYJ9oa+h3OUh0bVMBZQvLDfrR
         MmvHbf1Y5N/phQ+XUqGHPq8V8/mrrNOCMLDTFJmxuzHhJmGBWFz6Rr2vk1Ax3RJr0FPC
         g3lw==
X-Gm-Message-State: AFqh2koo+WQHjNVUpAG0lqmWtg+pca9uq+hM7q3s6m73n2Ak0lcX/yBi
        8q6Om3DO1dYPLPB/mT2bozg=
X-Google-Smtp-Source: AMrXdXtvxvjTbD5m4UuueWB5MOH23w6hDxHRCaqYfB67xlF15Pe+QIRm11awqA7qbeQ+STv+AcNBlQ==
X-Received: by 2002:a17:907:2587:b0:847:410:ecf0 with SMTP id ad7-20020a170907258700b008470410ecf0mr2433180ejc.20.1673955995189;
        Tue, 17 Jan 2023 03:46:35 -0800 (PST)
Received: from andrea (host-95-250-29-117.retail.telecomitalia.it. [95.250.29.117])
        by smtp.gmail.com with ESMTPSA id b2-20020a17090630c200b00780b1979adesm12948172ejb.218.2023.01.17.03.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 03:46:34 -0800 (PST)
Date:   Tue, 17 Jan 2023 12:46:28 +0100
From:   Andrea Parri <parri.andrea@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
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
Subject: Re: Internal vs. external barriers (was: Re: Interesting LKMM litmus
 test)
Message-ID: <Y8aKlNY4Z0z2Yqs0@andrea>
References: <Y8MOOrrHntA9TyUk@rowland.harvard.edu>
 <20230115051510.GG2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8Qog8qf7wIx2Kve@rowland.harvard.edu>
 <20230115181052.GJ2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8RmEtBnwqOzNhsK@rowland.harvard.edu>
 <20230116042329.GN2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8WTXS73qTBpUzcI@rowland.harvard.edu>
 <20230116190652.GZ2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8WjmTFnqbAnS1Pz@rowland.harvard.edu>
 <20230116221357.GA2948950@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230116221357.GA2948950@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 02:13:57PM -0800, Paul E. McKenney wrote:
> On Mon, Jan 16, 2023 at 02:20:57PM -0500, Alan Stern wrote:
> > On Mon, Jan 16, 2023 at 11:06:52AM -0800, Paul E. McKenney wrote:
> > > On Mon, Jan 16, 2023 at 01:11:41PM -0500, Alan Stern wrote:
> > 
> > > > Why do you want to prohibit nesting?  Why would that be a better 
> > > > approximation?
> > > 
> > > Because the current LKMM gives wrong answers for nested critical
> > > sections.
> > 
> > I don't agree.  Or at least, it depends on whose definition of "nested 
> > critical sections" you adopt.
> 
> Fair point, and I have therefore updated the test's header comment
> to read as follows:
> 
> (*
>  * Result: Sometimes
>  *
>  * This demonstrates non-nested overlapping of SRCU read-side critical
>  * sections.  Unlike RCU, SRCU critical sections do not unconditionally
>  * nest.
>  *)
> 
> > >  For example, for the litmus test shown below, mainline
> > > LKMM will incorrectly report "Never".  The two SRCU read-side critical
> > > sections are independent, so the fact that P1()'s synchronize_srcu() is
> > > guaranteed to wait for the first on to complete says nothing about the
> > > second having completed.  Therefore, in Linux-kernel SRCU, the "exists"
> > > clause could be satisfied.
> > > 
> > > In contrast, the proposed change flags this as having nesting.
> > 
> > In fact, this litmus test has overlapping critical sections, not nested 
> > ones.  But the current LKML incorrectly _thinks_ they are nested, 
> > because it matches each lock with the first unmatched unlock.
> > 
> > If you write a litmus test that has properly nested (not overlapping!) 
> > read-side critical sections, the current LKMM will match the locks and 
> > unlocks correctly and will give the right answer.
> > 
> > So what you really want to do is rule out overlapping, not nesting.  But 
> > I guess there's no way to do one without the other.
> 
> None that I could see!

This was reminiscent of old discussions, in fact, we do have:

[tools/memory-model/Documentation/litmus-tests.txt]

e.	Although sleepable RCU (SRCU) is now modeled, there
	are some subtle differences between its semantics and
	those in the Linux kernel.  For example, the kernel
	might interpret the following sequence as two partially
	overlapping SRCU read-side critical sections:

		 1  r1 = srcu_read_lock(&my_srcu);
		 2  do_something_1();
		 3  r2 = srcu_read_lock(&my_srcu);
		 4  do_something_2();
		 5  srcu_read_unlock(&my_srcu, r1);
		 6  do_something_3();
		 7  srcu_read_unlock(&my_srcu, r2);

	In contrast, LKMM will interpret this as a nested pair of
	SRCU read-side critical sections, with the outer critical
	section spanning lines 1-7 and the inner critical section
	spanning lines 3-5.

	This difference would be more of a concern had anyone
	identified a reasonable use case for partially overlapping
	SRCU read-side critical sections.  For more information
	on the trickiness of such overlapping, please see:
	https://paulmck.livejournal.com/40593.html

More recently/related,

  https://lore.kernel.org/lkml/20220421230848.GA194034@paulmck-ThinkPad-P17-Gen-1/T/#m2a8701c7c377ccb27190a6679e58b0929b0b0ad9

Thanks,
  Andrea


> 
> 							Thanx, Paul
> 
> > Alan
> > 
> > > 							Thaxn, Paul
> > > 
> > > ------------------------------------------------------------------------
> > > 
> > > C C-srcu-nest-5
> > > 
> > > (*
> > >  * Result: Sometimes
> > >  *
> > >  * This demonstrates non-nesting of SRCU read-side critical sections.
> > >  * Unlike RCU, SRCU critical sections do not nest.
> > >  *)
> > > 
> > > {}
> > > 
> > > P0(int *x, int *y, struct srcu_struct *s1)
> > > {
> > > 	int r1;
> > > 	int r2;
> > > 	int r3;
> > > 	int r4;
> > > 
> > > 	r3 = srcu_read_lock(s1);
> > > 	r2 = READ_ONCE(*y);
> > > 	r4 = srcu_read_lock(s1);
> > > 	srcu_read_unlock(s1, r3);
> > > 	r1 = READ_ONCE(*x);
> > > 	srcu_read_unlock(s1, r4);
> > > }
> > > 
> > > P1(int *x, int *y, struct srcu_struct *s1)
> > > {
> > > 	WRITE_ONCE(*y, 1);
> > > 	synchronize_srcu(s1);
> > > 	WRITE_ONCE(*x, 1);
> > > }
> > > 
> > > locations [0:r1]
> > > exists (0:r1=1 /\ 0:r2=0)
