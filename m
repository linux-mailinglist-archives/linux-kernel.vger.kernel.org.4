Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5D16BC4D8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 04:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjCPDoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 23:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjCPDoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 23:44:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F975FA58;
        Wed, 15 Mar 2023 20:44:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B0DF0B81FB0;
        Thu, 16 Mar 2023 03:44:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5280BC433D2;
        Thu, 16 Mar 2023 03:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678938258;
        bh=rfAaKei5aTbv7MhFvjG/YTHF977bYSdcuAxSVLtmcJA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=gzNyckXiFZEUto2TxsDWvPIjhIma/LIx7BNFLmPeqqJxTQuUfBwJtdBEWb+gLQlLS
         1/1rzUu5cOYqQR+qwihEl2U04NBUgkaW5oisP1Vs/gcqJVJ7CircXEjvgqZZB5YESj
         B5INV2RfeHLtUty/1KxfgiyALozvJvWps5dCgMi8G0E78jdiQ7ajSqeHaDhQcsoyRQ
         IhjwYjn/44kgvZxdHB5+YsHGw1d6gN5/yDLqBXOQf+p9/QmkYZoHQU0OszF1J0k3bV
         PxHsdx4X1Sa2o84L5wOU+nlBU7DFLm0ALYurL1czZXVaizWMGF8GSF8Knv+QIu/XNJ
         acFAVc/2jJuwQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id D583B1540395; Wed, 15 Mar 2023 20:44:17 -0700 (PDT)
Date:   Wed, 15 Mar 2023 20:44:17 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Uladzislau Rezki <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Bryan Tan <bryantan@vmware.com>,
        Eric Dumazet <edumazet@google.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Ariel Levkovich <lariel@nvidia.com>,
        Theodore Ts'o <tytso@mit.edu>, Julian Anastasov <ja@ssi.bg>
Subject: Re: [PATCH 04/13] tracing: Rename kvfree_rcu() to
 kvfree_rcu_mightsleep()
Message-ID: <29b54f07-b4ce-4eab-bbc2-281672bca5a5@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230201150815.409582-1-urezki@gmail.com>
 <20230201150815.409582-5-urezki@gmail.com>
 <ZAni8Q1NW9cWrvHJ@pc636>
 <20230315183648.5164af0f@gandalf.local.home>
 <d404a6b6-4ff9-930a-1cdc-fd730270fbe7@kernel.dk>
 <60f55a5d-213f-46b7-9294-c37f10f98252@paulmck-laptop>
 <20230315222323.7afe82e7@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315222323.7afe82e7@gandalf.local.home>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 10:23:23PM -0400, Steven Rostedt wrote:
> On Wed, 15 Mar 2023 17:37:30 -0700
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > 
> > That does work, and I am guessing that the size increase is not a big
> > problem for you there.
> 
> Well, I was fine with it as long as it stayed in the headers, where
> ugliness is warmly welcomed. Just ask all the #ifdefs.
> 
> > 
> > > That's a cop out, just removing the one case you care about. Fact is
> > > the naming is awful, and the 1/2 argument thing is making it worse.
> > > If a big change is warranted, why not do it right and ACTUALLY
> > > get it right?  
> > 
> > You both do realize that the kvfree_rcu_mightsleep() definition is
> > already in mainline, right?
> > 
> > Anyway, to sum up, kvfree_rcu_mightsleep()--or whatever the entire
> > community eventually decides to name it--can do any of the following:
> > 
> > 1.	Put the pointer into an already allocated array of pointers.
> > 
> > 2.	Allocate a new array of pointers, have the allocation succeed
> > 	without sleeping, then put the pointer into an already allocated
> > 	array of pointers.
> > 
> > 3.	Allocate a new array of pointers, have the allocation succeed
> > 	after sleeping, then put the pointer into an already allocated
> > 	array of pointers.
> > 
> > 4.	Attempt to allocate a new array of pointers, have the allocation
> > 	fail (presumably after sleeping), then invoke synchronize_rcu()
> > 	directly.
> > 
> > Too much fun!  ;-)
> > 
> 
>   kvfree_rcu_kitchen_sink() ?
> 
>   kvfree_rcu_goldie_locks()?
> 
> I honestly like the name "headless" as that perfectly describes the
> difference between kvfree_rcu(arg1, arg2) and kvfree_rcu(arg1).
> 
> Whereas mightsleep() is confusing to me because it doesn't tell me why
> kvfree_rcu() has two args and kvfree_rcu_mightsleep() has only one.
> Usually, code that has two sleep variants is about limiting the
> functionality of the atomic friendly one.

	kvfree_rcu_alloc_head()?
	kvfree_rcu_dynhead()?
	kvfree_rcu_gearhead()?
	kvfree_rcu_radiohead()?
	kvfree_rcu_getahead()?

I don't know about you guys, but to me, kvfree_rcu_mightsleep() is
sounding better and better by comparison...

							Thanx, Paul
