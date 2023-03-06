Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA3856AC442
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 16:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbjCFPBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 10:01:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjCFPBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 10:01:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6692FCCC;
        Mon,  6 Mar 2023 07:01:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D020260FC6;
        Mon,  6 Mar 2023 15:01:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31D21C4339B;
        Mon,  6 Mar 2023 15:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678114869;
        bh=QnaL793fLV7vfvFBBVpMTU+ONTzfUG7XKVZMMdedEBQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=BP9XLDsWka8dwZirqHYx9N3GMqiVry9LtAiJVaevzTOf1NX4sD4WZRaTFZuqRF8ti
         b7irTN5OAy8uxAlMIfJilu8u3qfJyISGrn1NqM/tYVEqyiy5WSaDWVFNScwcRTmXx6
         a5UGTn2G791Oids8vxVawWAw+lvjO8FNe2MD/bTG0iWr9vYNsyweH50BFLiDS1a1du
         ywN2TWJJhEySSo/nTpig10jVhWDBCDGdek3+t32kSCce9Uh/SMIPp3AUGF6KNKZVQ4
         fAd5lNC17l0GTlIXn/UuKxL+15bVK4jHREoreClsKJt7yFlnVpeI4XWdPv+47UtB10
         gatxxKtMZHiLg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B04145C00F1; Mon,  6 Mar 2023 07:01:08 -0800 (PST)
Date:   Mon, 6 Mar 2023 07:01:08 -0800
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
Message-ID: <20230306150108.GT1301832@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <ZAR//FKO4syzapk6@pc636>
 <D8B84631-860B-41CF-8311-88E220C7254F@joelfernandes.org>
 <20230305180524.GL1301832@paulmck-ThinkPad-P17-Gen-1>
 <20230306144948.GA3280216@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230306144948.GA3280216@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 02:49:48PM +0000, Joel Fernandes wrote:
> On Sun, Mar 05, 2023 at 10:05:24AM -0800, Paul E. McKenney wrote:
> > On Sun, Mar 05, 2023 at 07:56:33AM -0500, Joel Fernandes wrote:
> > > 
> > > 
> > > > On Mar 5, 2023, at 6:41 AM, Uladzislau Rezki <urezki@gmail.com> wrote:
> > > > 
> > > > ﻿
> > > >> 
> > > >>>> On Mar 5, 2023, at 5:29 AM, Joel Fernandes <joel@joelfernandes.org> wrote:
> > > >>> 
> > > >>> ﻿Hi, All,
> > > >>> 
> > > >>>> On Wed, Feb 1, 2023 at 10:11 AM Uladzislau Rezki (Sony)
> > > >>>> <urezki@gmail.com> wrote:
> > > >>>> 
> > > >>>> For a single argument invocations a new kfree_rcu_mightsleep()
> > > >>>> and kvfree_rcu_mightsleep() macroses are used. This is done in
> > > >>>> order to prevent users from calling a single argument from
> > > >>>> atomic contexts as "_mightsleep" prefix signals that it can
> > > >>>> schedule().
> > > >>>> 
> > > >>> 
> > > >>> Since this commit in -dev branch [1] suggests more users still need
> > > >>> conversion, let us drop this single patch for 6.4 and move the rest of
> > > >>> the series forward? Let me know if you disagree.
> > > >>> https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?h=dev&id=9bf5e3a2626ed474d080f695007541b6ecd6e60b
> > > >>> 
> > > >>> All -- please supply Ack/Review tags for patches 1-12.
> > > >> 
> > > >> Or put another way, what is the transition plan for these remaining users?
> > > >> 
> > > >> I am getting on a plane right now but I can research which users are remaining later.
> > > >> 
> > > > I am not sure. I think we can cover it on the meeting.
> > > 
> > > Cool, thanks.
> > 
> > My current plan is as follows:
> > 
> > 1.	Addition of kvfree_rcu_mightsleep() went into v6.3.
> > 
> > 2.	After creating branches, I send out the series, including 12/12.
> > 	The -rcu tree's "dev" branch continues to have a revert to avoid
> > 	breaking -next until we achieve clean -next and clean "dev"
> > 	branch.
> > 
> > 3.	Any conversion patches that get maintainer acks go into v6.4.
> > 	Along with a checkpatch error, as Joel notes below.
> > 
> > 4.	There are periodic checks for new code using the single-argument
> > 	forms of kfree_rcu() and kvfree_rcu().	Patches are produced
> > 	for them, or responses to the patches introducing them, as
> > 	appropriate.  A coccinelle script might be helpful, perhaps
> > 	even as part of kernel test robot or similar.
> > 
> > 5.	The -rcu tree's "dev" branch will revert to unclean from time
> > 	to time as maintainers choose to take conversion patches into
> > 	their own trees.
> > 
> > 6.	Once mainline is clean, we push 12/12 into the next merge
> > 	window.
> 
> Since in theory, mainline could also be after 6.4-rc1, I am assuming next merge
> window could also mean 6.5 right? But yes, agreed.

I would rather not waste Linus's time with a separate pull request for
this.  It is after all not a regression.  ;-)

> > 7.	We then evaluate whether further cleanups are needed.
> > 
> > > > My feeling is
> > > > that, we introduced "_mightsleep" macros first and after that try to
> > > > convert users.
> > 
> > > One stopgap could be to add a checkpatch error if anyone tries to use old API,
> > > and then in the meanwhile convert all users.
> > > Though, that requires people listening to checkpatch complaints.
> > 
> > Every person who listens is that much less hassle.  It doesn't have to
> > be perfect.  ;-)
> 
> The below checkpatch change can catch at least simple single-arg uses (i.e.
> not having compound expressions inside of k[v]free_rcu() args). I will submit
> a proper patch to it which we can include in this set.
> 
> Thoughts?
> ---
>  scripts/checkpatch.pl | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 78cc595b98ce..fc73786064b3 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -6362,6 +6362,15 @@ sub process {
>  			}
>  		}
>  
> +# check for soon-to-be-deprecated single-argument k[v]free_rcu() API
> +		if ($line =~ /\bk[v]?free_rcu\s*\([^(]+\)/) {
> +			if ($line =~ /\bk[v]?free_rcu\s*\([^,]+\)/) {
> +				ERROR("DEPRECATED_API",
> +				      "Single-argument k[v]free_rcu() API is deprecated, please pass an rcu_head object." . $herecurr);

Nice!

But could you please also tell them what to use instead?  Sure, they
could look it up, but if it tells them directly, they are less likely
to ignore it.

							Thanx, Paul

> +			}
> +		}
> +
> +
>  # check for unnecessary "Out of Memory" messages
>  		if ($line =~ /^\+.*\b$logFunctions\s*\(/ &&
>  		    $prevline =~ /^[ \+]\s*if\s*\(\s*(\!\s*|NULL\s*==\s*)?($Lval)(\s*==\s*NULL\s*)?\s*\)/ &&
> -- 
> 2.40.0.rc0.216.gc4246ad0f0-goog
> 
