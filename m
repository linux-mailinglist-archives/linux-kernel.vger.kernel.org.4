Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B677406EB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 01:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjF0Xlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 19:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjF0Xlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 19:41:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6446B1BE8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 16:41:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED3516121C
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 23:41:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58985C433C0;
        Tue, 27 Jun 2023 23:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687909298;
        bh=z1GvJ00vioZSiRR1ZOMBDf0vCKBMJUK0WdI5BOEKyqE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Qoq3/4aOvR1Agudfp3kFnBmCUjPOWezZ5961VI2989QztAU11hldcF7le97u+dp43
         94aw6uGRtqSvMw+DtPjDodqiL1TscNfFpASks2/qIwNRXRUdYTyurfcZ8Y7MkiQiem
         eknbZt+bh0+PFuDvMYHuiq5kgIWg4yAlvd71quLOHHglmFiy5DPhUG0ZlRBC+IAg5C
         yG9kbbX/Oj7Uv+In/mYI82WS0cwQ4I52ApYc8T6RxYh6LVoy5oFwHNY66zEj7E590Q
         eZIf6Z8b/I9GAOZq0g+LKm9DoAKb5jFCFnGAb8UzCq7h9v/6TwGocIYHPj7PVA8/v7
         KeFrUa5k0OgOg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id F0D6CCE3A0D; Tue, 27 Jun 2023 16:41:37 -0700 (PDT)
Date:   Tue, 27 Jun 2023 16:41:37 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dinh Nguyen <dinguyen@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux@roeck-us.net,
        vishal.moola@gmail.com, akpm@linux-foundation.org,
        sfr@canb.auug.org.au
Subject: Re: [PATCH] Revert "nios2: Convert __pte_free_tlb() to use ptdescs"
Message-ID: <8a2707a4-04d3-4bcf-b1ee-9a2ef15886a0@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230627221430.464073-1-dinguyen@kernel.org>
 <CAHk-=wgh1CDUTJD+F_utKnbW6d=wApBMC4D8hMfOs15bAn23Bg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgh1CDUTJD+F_utKnbW6d=wApBMC4D8hMfOs15bAn23Bg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 03:35:45PM -0700, Linus Torvalds wrote:
> On Tue, 27 Jun 2023 at 15:14, Dinh Nguyen <dinguyen@kernel.org> wrote:
> >
> > This reverts commit 6ebe94baa2b9ddf3ccbb7f94df6ab26234532734.
> >
> > The patch "nios2: Convert __pte_free_tlb() to use ptdescs" was supposed
> > to go together with a patchset that Vishal Moola had planned taking it
> > through the mm tree. By just having this patch, all NIOS2 builds are
> > broken.
> 
> This is now at least the third time just this merge window where some
> base tree was broken, and people thought that linux-next is some kind
> of testing ground for it all.
> 
> NO!
> 
> Linux-next is indeed for testing, and for finding situations where
> there are interactions between different trees.
> 
> But linux-next is *not* a replacement for "this tree has to work on
> its own". THAT testing needs to be done independently, and *before* a
> tree hits linux-next.
> 
> It is *NOT* ok to say "this will work in combination with that other
> tree". EVERY SINGLE TREE needs to work on its own, because otherwise
> you cannot bisect the end result sanely.
> 
> We apparently had the NIOS2 tree being broken. And the RCU tree was
> broken. And the KUnit tree was broken.
> 
> In all those cases, the base tree did not compile properly on its own,
> and linux-next "magically fixed" it by either having Stephen Rothwell
> literally fix the build breakage by hand, or by having some other tree
> hide the problem.
> 
> This is very much not ok.
> 
> I'm not sure why it happened so much this release, but this needs to
> stop. People need to realize that you can't just throw shit at the
> wall and see if it sticks. You need to test your own trees *first*,
> and *independently* of other peoples trees.
> 
> Then, if  you have done basic testing, you can then have it in
> linux-next and that hopefully then finds any issues with bad
> interactions with other trees, and maybe also ends up getting more
> coverage testing on odd architectures and with odd configurations.
> 
> But linux-next must not in *any* way be a replacement for doing basic
> testing on your own tree first.

On the off-chance that it helps someone else avoid my stupid mistakes,
here is exactly how I messed this up so badly:

1.	This API-name-change series went well, except for the usual
	lagging changes.  This *should* not be a problem, as you
	simply leave the old API in however long it takes for the
	change to get in.

2.	At some point -next was a single-argument kfree_rcu()-free zone.
	So I queued the offending commit on the -rcu tree's rcu/next
	branch, followed by a revert for my own testing.  The idea was
	to make new uses fail in -next testing.

	So far, so good.

3.	I noticed that -next was now free of kfree_rcu() calls.

	At this point, I made three stupid mistakes:

	a.	I failed to wait for mainline itself to be free of the
		single-argument kfree_rcu(), thus pulling the offending
		single-argument kfree_rcu() removal commit into my pull
		request a merge window too soon.  This is of course
		especially stupid since I tend to send you the RCU pull
		request early.

	b.	I failed to identify exactly which -next commit eliminated
		single-argument kfree_rcu().  Had I done so, I would
		have seen that this was in fact Stephen's rcu/next
		merge commit, which was never going to go to mainline.

	c.	Worst yet, out of force of habit, I left the revert
		from #2 above in my testing, thus failing to see the
		-rcu failure due to that remaining single-argument
		kfree_rcu() call.

So a combination of three stupid mistakes on my part made the RCU
happen.

As you say, testing *exactly* the commit heading up the pull request
merged with your master branch would have spotted this, and I will
of course make sure that I do this in the future.

And again, please accept my apologies for this mess.

							Thanx, Paul
