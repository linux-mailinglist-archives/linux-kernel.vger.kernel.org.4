Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87AEE740342
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 20:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjF0Sav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 14:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjF0Sas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 14:30:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20C2196;
        Tue, 27 Jun 2023 11:30:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68DAA611F1;
        Tue, 27 Jun 2023 18:30:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB1EC433C0;
        Tue, 27 Jun 2023 18:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687890646;
        bh=tcZ+3vm9cH5jQj4NG8CSTVBsxB73M2eQkLj5zaxouYM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Q7s2c+ZhmU8vnX4J+1Jj3TvQzSNo5ObwfGC5+n0dqQ82h1sPjv4AwNhP94v3T/Sby
         vT72KQiOK2XHMjRAZYZONW1hauNxdOqEq4PpYj33tyIRX+Y206JrAIackI+87JuM3P
         DZhkSwMeuqBPdxTCvvwJp9i2oG099Du+wUxKvrmqPoAqvSND9REirK2i+Vd68RUSGQ
         g6wfc0DmikOp2FNxmf6mPU7J0h/txh1QTo4X1jss8PigPzo7mdbm+FakcoGPAhJZNo
         O6EEq6Tc2XPLdtl55VEJ3BXccSZU3MTgp8up1MxrjATgdOiQjTJNQsYKPL1zeJ8q25
         dtO68s8cJK41A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 497E0CE39D6; Tue, 27 Jun 2023 11:30:46 -0700 (PDT)
Date:   Tue, 27 Jun 2023 11:30:46 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        mingo@kernel.org, tglx@linutronix.de, rcu@vger.kernel.org
Subject: Re: [GIT PULL] RCU changes for v6.5
Message-ID: <fcc987bb-4ce4-4816-a909-cffa4c3f24ff@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <963d6eb8-6520-4c33-bbe8-6c76205bfd3d@paulmck-laptop>
 <CAHk-=whn4DGusRgq7ihBmu7vPBhvSDZsYN_ctef94E1rVbf5jA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whn4DGusRgq7ihBmu7vPBhvSDZsYN_ctef94E1rVbf5jA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 10:56:21AM -0700, Linus Torvalds wrote:
> On Sun, 25 Jun 2023 at 08:35, Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/rcu.2023.06.22a
> >
> > o       Eliminate the single-argument variant of k[v]free_rcu() now
> >         that all uses have been converted to k[v]free_rcu_mightsleep().
> 
> Well, clearly not all users had been.
> 
> The base of this RCU was v6.4-rc1, and when that commit was done, we
> still had a single-argument variant:
> 
>   7e3f926bf453 ("rcu/kvfree: Eliminate k[v]free_rcu() single argument macro")
> 
> but look here:
> 
>      git grep 'kfree_rcu([^,()][^,()]*)' 7e3f926bf453
> 
> results in
> 
>    7e3f926bf453:drivers/infiniband/sw/rxe/rxe_verbs.c:     kfree_rcu(mr);
> 
> so the RCU tree itself can not possibly have built cleanly.
> 
> How the heck did this pass testing in linux-next? Did linux-next just
> assume that it was a merge error, and fix it up?

Because idiot here failed to notice that the needed change was only
in -next, and not yet in mainline.

What I needed to have done instead was to keep this commit in -next,
but not send it to mainline until the v6.6 merge window.  Or maybe to
send it as a separate pull request once the rdma commit hit mainline.

> Anyway, I *did* fix it up, changing the 'kfree_rcu()' to
> 'kfree_rcu_mightsleep()', but no, this was not a merge artifact. This
> was purely "the RCU tree did not build on its own", and as a result
> the tree does not bisect cleanly if you have rdma enabled.
> 
> Adding rdma people to the participants just to let them know that this
> happened, but it's not their fault. This is on the RCU tree, and lack
> of proper coverage testing.

Apologies to all for my confusion, and thank you Linus for cleaning up
my mess!

							Thanx, Paul
