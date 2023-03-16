Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720C36BC2E4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 01:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjCPAhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 20:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjCPAho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 20:37:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449FEB3E30;
        Wed, 15 Mar 2023 17:37:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABA1661ECD;
        Thu, 16 Mar 2023 00:37:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 142F9C433D2;
        Thu, 16 Mar 2023 00:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678927051;
        bh=u/ft7HTwZ+Z6VuhAoZZItau7bQuBduCh0LEE7+zRQUo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Cp05I6EpWB8tsUhJYtUzoxh1XY60cptZy5ImwIXljSlbkA7cdWNPvuBMKmA7w7k2w
         1cs1ugze9/9bHS3ukrZaeV+soeg3FfEVUH9KKiC+VzJ5IqBghikduhxzi5xe5tIgiV
         k2UQJYMv7uBo8W10L52pvo3tx2HQ7Bh/r0P64dsJBI67mhAHU/wOMzcdF+YuYLadSb
         /lNayIgYjuYhbkZbEtKsYB3hHmK4ERYT6mxJmDPsaSAlkWpfWHfEUiytH8AerkYS6j
         hSyyO+R+zI88WaEUB4l0WaLAEvD2EV7UmLI5wnXLFLnSTNh3+VKRiOxr7L3Dds0FVv
         d+x96WqhyylIQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 96C0E1540395; Wed, 15 Mar 2023 17:37:30 -0700 (PDT)
Date:   Wed, 15 Mar 2023 17:37:30 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>,
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
Message-ID: <60f55a5d-213f-46b7-9294-c37f10f98252@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230201150815.409582-1-urezki@gmail.com>
 <20230201150815.409582-5-urezki@gmail.com>
 <ZAni8Q1NW9cWrvHJ@pc636>
 <20230315183648.5164af0f@gandalf.local.home>
 <d404a6b6-4ff9-930a-1cdc-fd730270fbe7@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d404a6b6-4ff9-930a-1cdc-fd730270fbe7@kernel.dk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 05:19:18PM -0600, Jens Axboe wrote:
> On 3/15/23 4:36 PM, Steven Rostedt wrote:
> > On Thu, 9 Mar 2023 14:45:21 +0100
> > Uladzislau Rezki <urezki@gmail.com> wrote:
> > 
> >>> The kvfree_rcu()'s single argument name is deprecated therefore
> >>> rename it to kvfree_rcu_mightsleep() variant. The goal is explicitly
> >>> underline that it is for sleepable contexts.
> >>>
> >>> Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
> >>> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> >>>  
> >> Could you please add you reviwed-by or Acked-by tags so we can bring
> >> our series with renaming for the next merge window?
> > 
> > I don't know. Perhaps we should just apply this patch and not worry about
> > sleeping and whatnot.

That does work, and I am guessing that the size increase is not a big
problem for you there.

> That's a cop out, just removing the one case you care about. Fact is
> the naming is awful, and the 1/2 argument thing is making it worse.
> If a big change is warranted, why not do it right and ACTUALLY
> get it right?

You both do realize that the kvfree_rcu_mightsleep() definition is
already in mainline, right?

Anyway, to sum up, kvfree_rcu_mightsleep()--or whatever the entire
community eventually decides to name it--can do any of the following:

1.	Put the pointer into an already allocated array of pointers.

2.	Allocate a new array of pointers, have the allocation succeed
	without sleeping, then put the pointer into an already allocated
	array of pointers.

3.	Allocate a new array of pointers, have the allocation succeed
	after sleeping, then put the pointer into an already allocated
	array of pointers.

4.	Attempt to allocate a new array of pointers, have the allocation
	fail (presumably after sleeping), then invoke synchronize_rcu()
	directly.

Too much fun!  ;-)

							Thanx, Paul
