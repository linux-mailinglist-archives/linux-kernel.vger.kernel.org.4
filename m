Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B0C6AB1A5
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 19:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjCESFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 13:05:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjCESF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 13:05:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92402CDD7;
        Sun,  5 Mar 2023 10:05:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 068D260B4B;
        Sun,  5 Mar 2023 18:05:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A160C433EF;
        Sun,  5 Mar 2023 18:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678039525;
        bh=mTv0i3HFNwyEjaj1TI8i2X3pSZ54/PzZ+U4eMXghe/M=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=I3Ha+xHyFcPWGDqAgSBQmM5ilFRiwoXsGyedT91ugUFfq5aDL3TOrE6Tnmo/gTc9s
         7hl4zvpkDcHY+ruLWmjQQQ2hTcrAaphup7zGrd26RMAez2wO0aYhCCZPI+ZUqksy/u
         rfsZ4tdvjpr7RdM8BH3/EiFFvtnFeAb6T92plBO/LrK2Gsnp5k//f+uQLHMYcWoaui
         /Sfq7ps4QpH30Q3rNI/BF8jRuLO8MYsF2Ye66z2t8D2iDAbYEIwSOzIBiT4nfPGnh7
         xbK9PZrWMCcZ79tAP2J80Z4HLTXW7YD+nM41TpT8XK5tq3LopDxSLcHdRCTPl3p75u
         EOCxubBypCtkw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id ED82E5C035B; Sun,  5 Mar 2023 10:05:24 -0800 (PST)
Date:   Sun, 5 Mar 2023 10:05:24 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Jens Axboe <axboe@kernel.dk>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Bryan Tan <bryantan@vmware.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Eric Dumazet <edumazet@google.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Ariel Levkovich <lariel@nvidia.com>,
        Theodore Ts'o <tytso@mit.edu>, Julian Anastasov <ja@ssi.bg>
Subject: Re: [PATCH 13/13] rcu/kvfree: Eliminate k[v]free_rcu() single
 argument macro
Message-ID: <20230305180524.GL1301832@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <ZAR//FKO4syzapk6@pc636>
 <D8B84631-860B-41CF-8311-88E220C7254F@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D8B84631-860B-41CF-8311-88E220C7254F@joelfernandes.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 05, 2023 at 07:56:33AM -0500, Joel Fernandes wrote:
> 
> 
> > On Mar 5, 2023, at 6:41 AM, Uladzislau Rezki <urezki@gmail.com> wrote:
> > 
> > ﻿
> >> 
> >>>> On Mar 5, 2023, at 5:29 AM, Joel Fernandes <joel@joelfernandes.org> wrote:
> >>> 
> >>> ﻿Hi, All,
> >>> 
> >>>> On Wed, Feb 1, 2023 at 10:11 AM Uladzislau Rezki (Sony)
> >>>> <urezki@gmail.com> wrote:
> >>>> 
> >>>> For a single argument invocations a new kfree_rcu_mightsleep()
> >>>> and kvfree_rcu_mightsleep() macroses are used. This is done in
> >>>> order to prevent users from calling a single argument from
> >>>> atomic contexts as "_mightsleep" prefix signals that it can
> >>>> schedule().
> >>>> 
> >>> 
> >>> Since this commit in -dev branch [1] suggests more users still need
> >>> conversion, let us drop this single patch for 6.4 and move the rest of
> >>> the series forward? Let me know if you disagree.
> >>> https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?h=dev&id=9bf5e3a2626ed474d080f695007541b6ecd6e60b
> >>> 
> >>> All -- please supply Ack/Review tags for patches 1-12.
> >> 
> >> Or put another way, what is the transition plan for these remaining users?
> >> 
> >> I am getting on a plane right now but I can research which users are remaining later.
> >> 
> > I am not sure. I think we can cover it on the meeting.
> 
> Cool, thanks.

My current plan is as follows:

1.	Addition of kvfree_rcu_mightsleep() went into v6.3.

2.	After creating branches, I send out the series, including 12/12.
	The -rcu tree's "dev" branch continues to have a revert to avoid
	breaking -next until we achieve clean -next and clean "dev"
	branch.

3.	Any conversion patches that get maintainer acks go into v6.4.
	Along with a checkpatch error, as Joel notes below.

4.	There are periodic checks for new code using the single-argument
	forms of kfree_rcu() and kvfree_rcu().	Patches are produced
	for them, or responses to the patches introducing them, as
	appropriate.  A coccinelle script might be helpful, perhaps
	even as part of kernel test robot or similar.

5.	The -rcu tree's "dev" branch will revert to unclean from time
	to time as maintainers choose to take conversion patches into
	their own trees.

6.	Once mainline is clean, we push 12/12 into the next merge
	window.

7.	We then evaluate whether further cleanups are needed.

> > My feeling is
> > that, we introduced "_mightsleep" macros first and after that try to
> > convert users.

> One stopgap could be to add a checkpatch error if anyone tries to use old API,
> and then in the meanwhile convert all users.
> Though, that requires people listening to checkpatch complaints.

Every person who listens is that much less hassle.  It doesn't have to
be perfect.  ;-)

							Thanx, Paul

> Thanks,
> 
>  - Joel
> 
> 
> > 
> > @Paul what is your view?
> > 
> > Thanks!
> > 
> > --
> > Uladzislau Rezki
