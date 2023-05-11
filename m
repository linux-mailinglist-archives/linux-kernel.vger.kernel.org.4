Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93BC06FFBD3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 23:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239188AbjEKVYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 17:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239165AbjEKVYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 17:24:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2F965B0;
        Thu, 11 May 2023 14:24:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05A6965201;
        Thu, 11 May 2023 21:24:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E9D0C433EF;
        Thu, 11 May 2023 21:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683840282;
        bh=UOflfLgEeoZpb6Dxi4Ad16jc/o/hkcHW7SxdcdNZDTo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ZQ5tCpkeK2S/wt17bdldj3QZj7qCuSGqJbs4FW7NnLMjVqP/DgabNrsyTzYaM7IVZ
         /er5JIWZR2SrAN4QNUHoBOBnax81nQuza4T3mYqLI7kGJ/27wGBBAVe41X6DPo4LYH
         sTHNz0dkCann91PGkxV0DwVl10U5kOk2xk4POopHmAPmFk8wmArmChFh5cAk0i4G15
         ye2k0F0hFnfRr3nbf7s6Re2NI99l8fQfNm7Z8Y1VXg+Zwh9yctLlFbz0IRfar474S7
         roaSTG4h27zHVYUls+q4gZ3bfsVhNwVEnMwLfn7x5lM+3BQJKjPrbZem0s4DQdf63O
         gMWghX2MWl/YA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 012FACE0FED; Thu, 11 May 2023 14:24:41 -0700 (PDT)
Date:   Thu, 11 May 2023 14:24:41 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, akiyks@gmail.com, linux-doc@vger.kernel.org,
        kernel-team@meta.com, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH locking/atomic 18/19] locking/atomic: Refrain from
 generating duplicate fallback kernel-doc
Message-ID: <20796f12-5a8b-4a4d-96f7-4604c782ec21@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <19135936-06d7-4705-8bc8-bb31c2a478ca@paulmck-laptop>
 <20230510181717.2200934-18-paulmck@kernel.org>
 <ZF0haDfyL3At3Ijw@FVFF77S0Q05N.cambridge.arm.com>
 <20230511193856.GA2296992@hirez.programming.kicks-ass.net>
 <c619d689-e7b5-4136-9bd3-8f41954f43cd@paulmck-laptop>
 <20230511200142.GC2296992@hirez.programming.kicks-ass.net>
 <613a2d06-30f1-4140-aa6c-16d5298d9909@paulmck-laptop>
 <20230511204633.GF2296992@hirez.programming.kicks-ass.net>
 <20230511204806.GA2298690@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511204806.GA2298690@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 10:48:06PM +0200, Peter Zijlstra wrote:
> On Thu, May 11, 2023 at 10:46:33PM +0200, Peter Zijlstra wrote:
> > On Thu, May 11, 2023 at 01:25:18PM -0700, Paul E. McKenney wrote:
> > > On Thu, May 11, 2023 at 10:01:42PM +0200, Peter Zijlstra wrote:
> > > > On Thu, May 11, 2023 at 12:53:46PM -0700, Paul E. McKenney wrote:
> > > > > Do you have an alternative suggestion for generating the kernel-doc?
> > > > > The current lack of it is problematic.
> > > > 
> > > > I've never found a lack of kernel-doc to be a problem. And I'm very much
> > > > against complicating the scripts to add it.
> > > 
> > > I am sure that you have not recently found the lack of kernel-doc for
> > > the atomic operations to be a problem, given that you wrote many of
> > > these functions.
> > 
> > Sure; but I meant in general -- I've *never* used kernel-doc. Comments I
> > occasionally read, and sometimes they're not even broken either, but
> > kernel-doc, nope.

I am not arguing that *you* need kernel-doc, and I must admit that I
also tend to look much more carefully at the code than the comments.
But not everyone has your level of code-reading talent, nor does everyone
have my half century of practice reading code.

(OK, OK, so it won't really be a half century until this coming
September!)

> > > OK, you mentioned concerns about documentation people nitpicking.  This
> > > can be dealt with.  The added scripting is not that large or complex.
> > > 
> > > > Also, there's Documentation/atomic_t.txt
> > > 
> > > Yes, if you very carefully read that document end to end, correctly
> > > interpreting it all, you will know what you need to.  Of course, first
> > > you have to find it.  And then you must avoid any lapses while reading
> > > it while under pressure.  Not particularly friendly to someone trying
> > > to chase a bug.
> > 
> > It's either brief and terse or tediously long -- I vastly prefer the
> > former, my brain can much better parse structure than English prose.

Agreed, English prose does have its challenges, no two ways about it.

But in order to successfully communicate with someone, it is necessary
to start where that person is, not where we might prefer them to be.
And there are quite a few people who benefit from a bit of English prose.

As long as we are picking on languages, there are some who assert that
Dutch is the easiest language for native English speakers to learn.
I know nothing myself, but for the purposes of this discussion, I will
assume that this is because Dutch uses similar words but is better
structured than is English.  As opposed, say, that Dutch is messed up
almost exactly the same ways that English is.  ;-)

> > Also, I find, pressure is never conductive to anything, except prehaps
> > cooking rice and steam trains (because nothing is as delicous as a
> > pressure cooked train -- oh wait).
> > 
> > Add enough pressure and the human brain reduces to driven and can't read
> 
> Just in case it weren't clear: s/driven/drivel/

You know, my brain auto-corrected and I didn't even notice.  And I still
sometimes wonder why I fail to spot bugs.  ;-)

> > even the most coherent of text no matter how easy to find.
> > 
> > In such situations it's for the manager to take the pressure away and
> > the engineer to think in relative peace.

I won't argue, having forced that a few times back in past lives.
"No, you don't have to get this done by Friday, and if anyone tells
you differently, you tell them to talk to me."  In one memorable case,
once pressure was relieved, they actually got it done before Friday.

Still, that is no reason to make that poor engineer's life even harder.
After all, there never have been more than a handful of managers that
I had that kind of influence over.  Plus there is the occasional true
emergency, though admittedly far fewer true emergencies that proclaimed
emergencies.

But suppose your response to someone nitpicking the atomic-operation
kernel-doc could simply be "Not my problem, go talk to Paul."  I would
of course be plenty happy to respond appropriately to people who expect
to read a long series of kernel-doc entries for atomic operations as
if it was a novel.  For some appropriate definition of "appropriately",
of course.

Would that help?

							Thanx, Paul
