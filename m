Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30DC0688486
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 17:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbjBBQfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 11:35:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjBBQfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 11:35:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9589B69B08;
        Thu,  2 Feb 2023 08:35:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23FF861BD5;
        Thu,  2 Feb 2023 16:35:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76199C433D2;
        Thu,  2 Feb 2023 16:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675355717;
        bh=sJB5PjcCiNz59vcpHfygblfpnQpA8CSQNYxGt99O4OY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=O3TWcKUByefRTL6kifI0dHerIa8z1QeBSbXUDbt7f4TvDZL0YcV/TYbDz92/Y7AHE
         hmzjg0Wfq1JHOyABXYz0IVJTRl1VcjbAaER1aXWkd5w1e+W5w46FiMUBSwFyMyJKo0
         BNMGA580Cw/Av9hkzkTlA/HMzq7NFJRl5Vfh9xyYOAFxfYpi3nhKBFS2PBLsbolMbW
         Z7Venn6OyQHvtsKdJE1x2s3Tm/GAmOO6GZ4LcRV5CNzqo1WSzD5JskreVAmH2Dw8wJ
         x7A21GaOXZSIW59/q5iELEcZwpwr+IFPxXexExNf6vVJJVtSBzz22HD/XRKlSBC0xi
         qan5eC7i6OiuA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1490B5C0E5B; Thu,  2 Feb 2023 08:35:17 -0800 (PST)
Date:   Thu, 2 Feb 2023 08:35:17 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Jens Axboe <axboe@kernel.dk>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Bryan Tan <bryantan@vmware.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Eric Dumazet <edumazet@google.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Ariel Levkovich <lariel@nvidia.com>,
        Theodore Ts'o <tytso@mit.edu>, Julian Anastasov <ja@ssi.bg>
Subject: Re: [PATCH 00/13] Rename k[v]free_rcu() single argument to
 k[v]free_rcu_mightsleep()
Message-ID: <20230202163517.GY2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230201150815.409582-1-urezki@gmail.com>
 <20230201191211.GK2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9vcp2jADVzHl0AE@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9vcp2jADVzHl0AE@pc636>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2023 at 04:54:15PM +0100, Uladzislau Rezki wrote:
> On Wed, Feb 01, 2023 at 11:12:11AM -0800, Paul E. McKenney wrote:
> > On Wed, Feb 01, 2023 at 04:08:06PM +0100, Uladzislau Rezki (Sony) wrote:
> > > This small series is based on Paul's "dev" branch. Head is 6002817348a1c610dc1b1c01ff81654cdec12be4
> > > it renames a single argument of k[v]free_rcu() to its new k[v]free_rcu_mightsleep() name.
> > > 
> > > 1.
> > > The problem is that, recently we have run into a precedent when
> > > a user intended to give a second argument to kfree_rcu() API but
> > > forgot to do it in a code so a call became as a single argument
> > > of kfree_rcu() API.
> > > 
> > > 2.
> > > Such mistyping can lead to hidden bags where sleeping is forbidden.
> > > 
> > > 3.
> > > _mightsleep() prefix gives much more information for which contexts
> > > it can be used for.
> > 
> > Thank you!!!
> > 
> > I have queued these (aside from 10/13, which is being replaced by a
> > patch from Julian Anastasov) for further testing and review.  And with
> > the usual wordsmithing.
> > 
> Good. 10/13 will go with two arguments. So it is not needed. Just for
> confirmation.

Got it, thank you!

> BTW, i see two complains from the robot due to 10/13 patch uses an old API
> name.

Thank you for the heads up!  I will be careful not to expose the last in
the series to -next before they get something in.  Unless they take too
long.  ;-)

							Thanx, Paul

> > If testing goes well, I might try to get 1/13 into the next merge window,
> > which would simplify things if maintainers want to take their patches
> > separately.
> > 
> Thanks!
> 
> --
> Uladzislau Rezki
