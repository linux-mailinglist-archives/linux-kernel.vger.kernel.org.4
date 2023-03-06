Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B253F6AC8D1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 17:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjCFQ4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 11:56:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjCFQ4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 11:56:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404E6E3B5;
        Mon,  6 Mar 2023 08:56:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6EDE561001;
        Mon,  6 Mar 2023 16:55:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6352C433D2;
        Mon,  6 Mar 2023 16:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678121701;
        bh=vAuCzr4fu58SsnQF+KaVkPyoc0/03dsJYRfNfWFMkgQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=FHzjaX3wQvVM7PUKV3x568t6U/9jd0qBj5bvw+LG/cd7vNp71EapVQE3HVwJskP0E
         vsozWWAip2YnaKmHxGWZFxQYp3dtCqKbUA8F82qVTfkWPkalo2WW23tpJU7Dsd3VBe
         IU+D+znElLSfHSHdsI9S7eRdIyWTuD1/lGnePRxPOkK0EvgJwBVTlv4SRj5qNZwmGL
         aA9w0oYPcK4NoY2tx8Vltw3wx1h61DcfJlgCM9+96TsDHUsfc0hJQIABIGSezqAKgh
         GnlPHh/MXIRABpgvXihWvw3y+uM6wTCD2Ou1cgU/5PBDuC8mrUzwzdmBHMLHH7P8Yp
         CPj0AtZfYUSZw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5D5105C0175; Mon,  6 Mar 2023 08:55:01 -0800 (PST)
Date:   Mon, 6 Mar 2023 08:55:01 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
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
Message-ID: <20230306165501.GX1301832@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <ZAR//FKO4syzapk6@pc636>
 <D8B84631-860B-41CF-8311-88E220C7254F@joelfernandes.org>
 <20230305180524.GL1301832@paulmck-ThinkPad-P17-Gen-1>
 <20230306144948.GA3280216@google.com>
 <20230306150108.GT1301832@paulmck-ThinkPad-P17-Gen-1>
 <20230306151203.GC3280216@google.com>
 <ZAYYBEnIZEfUhBYW@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAYYBEnIZEfUhBYW@pc636>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 05:42:44PM +0100, Uladzislau Rezki wrote:
> On Mon, Mar 06, 2023 at 03:12:03PM +0000, Joel Fernandes wrote:
> > On Mon, Mar 06, 2023 at 07:01:08AM -0800, Paul E. McKenney wrote:
> > [..] 
> > > > > 7.	We then evaluate whether further cleanups are needed.
> > > > > 
> > > > > > > My feeling is
> > > > > > > that, we introduced "_mightsleep" macros first and after that try to
> > > > > > > convert users.
> > > > > 
> > > > > > One stopgap could be to add a checkpatch error if anyone tries to use old API,
> > > > > > and then in the meanwhile convert all users.
> > > > > > Though, that requires people listening to checkpatch complaints.
> > > > > 
> > > > > Every person who listens is that much less hassle.  It doesn't have to
> > > > > be perfect.  ;-)
> > > > 
> > > > The below checkpatch change can catch at least simple single-arg uses (i.e.
> > > > not having compound expressions inside of k[v]free_rcu() args). I will submit
> > > > a proper patch to it which we can include in this set.
> > > > 
> > > > Thoughts?
> > > > ---
> > > >  scripts/checkpatch.pl | 9 +++++++++
> > > >  1 file changed, 9 insertions(+)
> > > > 
> > > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > > > index 78cc595b98ce..fc73786064b3 100755
> > > > --- a/scripts/checkpatch.pl
> > > > +++ b/scripts/checkpatch.pl
> > > > @@ -6362,6 +6362,15 @@ sub process {
> > > >  			}
> > > >  		}
> > > >  
> > > > +# check for soon-to-be-deprecated single-argument k[v]free_rcu() API
> > > > +		if ($line =~ /\bk[v]?free_rcu\s*\([^(]+\)/) {
> > > > +			if ($line =~ /\bk[v]?free_rcu\s*\([^,]+\)/) {
> > > > +				ERROR("DEPRECATED_API",
> > > > +				      "Single-argument k[v]free_rcu() API is deprecated, please pass an rcu_head object." . $herecurr);
> > > 
> > > Nice!
> > > 
> > > But could you please also tell them what to use instead?  Sure, they
> > > could look it up, but if it tells them directly, they are less likely
> > > to ignore it.
> > 
> > Sounds good, I will modify the warning to include the API to call and send
> > out a patch soon.
> > 
> Maybe compile warnings? Or is it too aggressive?

That is an excellent option if people ignore the checkpatch.pl warnings,
thus forcing us to delay past v6.5.  So Murphy would argue that we will
in fact take your good advice at some point.  ;-)

							Thanx, Paul
