Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F1F6ED394
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 19:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbjDXRfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 13:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232059AbjDXRf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 13:35:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCDC72B3;
        Mon, 24 Apr 2023 10:35:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD43262751;
        Mon, 24 Apr 2023 17:35:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41724C433EF;
        Mon, 24 Apr 2023 17:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682357721;
        bh=nXQw2FTN4L9FcEBusW5At9AwsWIZ0aI4hKgyyBuVBbM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=RubTyWpPSBAEuQnvW6S4VWaSxBXouhmnfRtYg38Pc64g+tzHKCAqlKdcJHmmvJw+9
         7UAREttRfTy80T04G1TyNdpXLCqTWq3jMB2jW8LVwwFpmhHMMUm4BXpcu96sFJvZ9R
         dIlcuN6EmC9nLKwG1xoZO1yelXi/DEkvHNAozr3l7OLKLDkWsWUJuKhmFn4bYWeI6e
         GzsC+3vbPMQFmG3LHqcrMF4Qm7w+jRjjCUsVErpgend15cMRg3U6JqMXYqxf1cvG13
         I+sJEmSWtFW3tQFchTzV4FT1QyEBPgkThp5KtKvqruotkqDvOWfFhxbzuWW4lDcOIS
         lgYY5sVZkUjCg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id D245415404E7; Mon, 24 Apr 2023 10:35:20 -0700 (PDT)
Date:   Mon, 24 Apr 2023 10:35:20 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 0/4 v2] rcu/nocb: Shrinker related boring fixes
Message-ID: <20d8070f-5113-4b3b-871f-ca543e049065@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230329160203.191380-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329160203.191380-1-frederic@kernel.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 06:01:59PM +0200, Frederic Weisbecker wrote:
> Changes since v1 (https://lore.kernel.org/lkml/20230322194456.2331527-1-frederic@kernel.org/):
> 
> * Use mutex_trylock() to avoid inverted dependency chain against
>   allocations.
> 
> * WARN if an rdp is part of nocb mask but is not offloaded
> 
> Tested through shrinker debugfs interface.

I pulled this one in, thank you!

As discussed, we do need some way to test lazy callbacks, but that should
not block this series.  And it might well be a separate test.

							Thanx, Paul

> Frederic Weisbecker (4):
>   rcu/nocb: Protect lazy shrinker against concurrent (de-)offloading
>   rcu/nocb: Fix shrinker race against callback enqueuer
>   rcu/nocb: Recheck lazy callbacks under the ->nocb_lock from shrinker
>   rcu/nocb: Make shrinker to iterate only NOCB CPUs
> 
>  kernel/rcu/tree_nocb.h | 52 ++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 47 insertions(+), 5 deletions(-)
> 
> -- 
> 2.34.1
> 
