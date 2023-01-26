Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4DF67D326
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 18:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbjAZR2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 12:28:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbjAZR2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 12:28:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C08569B0A
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 09:27:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C70CB81EC3;
        Thu, 26 Jan 2023 17:27:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1273EC433D2;
        Thu, 26 Jan 2023 17:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674754047;
        bh=C9DPduSJN49w2aJL07oo9HEwA59sZ5h+51ZoAP6pWmk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=mlhONz+YVANknW+/iMcnirDtC6dO3xyzjm3nJYRzU0F6DqW7fAAdspeFnq5ApVpqU
         Yq2FkJiO4Rua69tMlM7obKQe1TS/ks3E1MaxZDd3l887LTVFRbJ8rvRK50yA8rX+G5
         2Zny67+NCrk54BZJVc9bzvkN1FLByAarCaE7ApKq663ecrkaK1jtFWgydyrP/dPKX4
         WTnrYtu9O1KzwNfR52+J6AB18LXI7tjZLwpmcaKY9uLDYoSF8mrhXSFOSjs2Qux2us
         Oz6TWX6/34uOAePk5LKHlLRPBoNFLhLl7wq+bmJrY1iACaf2t9Tjc26kiTWvRO6NB5
         xlmU8DNaGJQyQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B2AE15C0510; Thu, 26 Jan 2023 09:27:26 -0800 (PST)
Date:   Thu, 26 Jan 2023 09:27:26 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Suren Baghdasaryan <surenb@google.com>, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, mingo@redhat.com, will@kernel.org,
        luto@kernel.org, songliubraving@fb.com, peterx@redhat.com,
        david@redhat.com, dhowells@redhat.com, hughd@google.com,
        bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        jannh@google.com, shakeelb@google.com, tatashin@google.com,
        edumazet@google.com, gthelen@google.com, gurua@google.com,
        arjunroy@google.com, soheil@google.com, hughlynch@google.com,
        leewalsh@google.com, posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com, elver@go
Subject: Re: [PATCH v3 1/7] kernel/fork: convert vma assignment to a memcpy
Message-ID: <20230126172726.GA682281@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230125233554.153109-1-surenb@google.com>
 <20230125233554.153109-2-surenb@google.com>
 <20230125162159.a66e5ef05fecb405e85ffec9@linux-foundation.org>
 <CAJuCfpG5HyMP3RM1jTJxCnN4WUz4APAcxbkOT48ZtJDXcb3z3w@mail.gmail.com>
 <20230125173449.5472cffc989dfab4b83c491d@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125173449.5472cffc989dfab4b83c491d@linux-foundation.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 05:34:49PM -0800, Andrew Morton wrote:
> On Wed, 25 Jan 2023 16:50:01 -0800 Suren Baghdasaryan <surenb@google.com> wrote:
> 
> > On Wed, Jan 25, 2023 at 4:22 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > >
> > > On Wed, 25 Jan 2023 15:35:48 -0800 Suren Baghdasaryan <surenb@google.com> wrote:
> > >
> > > > Convert vma assignment in vm_area_dup() to a memcpy() to prevent compiler
> > > > errors when we add a const modifier to vma->vm_flags.
> > > >
> > > > ...
> > > >
> > > > --- a/kernel/fork.c
> > > > +++ b/kernel/fork.c
> > > > @@ -482,7 +482,7 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
> > > >                * orig->shared.rb may be modified concurrently, but the clone
> > > >                * will be reinitialized.
> > > >                */
> > > > -             *new = data_race(*orig);
> > > > +             memcpy(new, orig, sizeof(*new));
> > >
> > > The data_race() removal is unchangelogged?
> > 
> > True. I'll add a note in the changelog about that. Ideally I would
> > like to preserve it but I could not find a way to do that.
> 
> Perhaps Paul can comment?
> 
> I wonder if KCSAN knows how to detect this race, given that it's now in
> a memcpy.  I assume so.

I ran an experiment memcpy()ing between a static array and an onstack
array, and KCSAN did not complain.  But maybe I was setting it up wrong.

This is what I did:

	long myid = (long)arg; /* different value for each task */
	static unsigned long z1[10] = { 0 };
	unsigned long z2[10];

	...

	memcpy(z1, z2, ARRAY_SIZE(z1) * sizeof(z1[0]));
	for (zi = 0; zi < ARRAY_SIZE(z1); zi++)
		z2[zi] += myid;
	memcpy(z2, z1, ARRAY_SIZE(z1) * sizeof(z1[0]));

Adding Marco on CC for his thoughts.

						Thanx, Paul
