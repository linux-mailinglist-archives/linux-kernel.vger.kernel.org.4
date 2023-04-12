Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05526DEAB9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 06:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjDLEty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 00:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjDLEtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 00:49:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DAB22D66;
        Tue, 11 Apr 2023 21:49:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E916162DDA;
        Wed, 12 Apr 2023 04:49:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53922C433EF;
        Wed, 12 Apr 2023 04:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681274990;
        bh=WxEKjhh9ECNx/FCgsG8Qoi+Pj1zpXY5UCPR66RZylCY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=RRJz+1Xvi/3Ufc3kwwGCMiCMBUq/ns3feoeGo/LiZAoyI7ZOG5Q1bvq3luWFB6a4S
         co2uvgux99lxd7SmzBTGR7m/xA2H0cSvu4YtOq2ZwgRV0slpQ0m+0tyBe04fi0ZTqX
         GJP2jWhaVf4AzPoteMihh6k5ZjOTAKnCHzd8KdPj/tBX08DZLCZxE+OvptQpB9fb0A
         4S0ZotbqRXLVcVnnWzFZPBHRQ7z44XIPTeaXvUQhO8rwfTcKte0SDUKGgFoD27Osk5
         bbajVAxRh6YBbhSt9C3Lp3dzrvzecQ3XKv2aGv1qqj05xSLoHfHwcpfIbdfZAvVKou
         peQT4iw6ABufA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id E66141540478; Tue, 11 Apr 2023 21:49:49 -0700 (PDT)
Date:   Tue, 11 Apr 2023 21:49:49 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     RCU <rcu@vger.kernel.org>, quic_neeraju@quicinc.com,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH 1/1] rcu/kvfree: Do not run a page work if a cache is
 disabled
Message-ID: <4c4d6919-6e06-45fd-9f55-c14bba9c8598@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230411131341.9910-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411131341.9910-1-urezki@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 03:13:41PM +0200, Uladzislau Rezki (Sony) wrote:
> By default the cache size is 5 pages per-cpu. But it can
> be disabled at boot time by setting the rcu_min_cached_objs
> to zero.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

That does get rid of a needless hrtimer &c in that case, good!

I have queued this with the usual wordsmithing below, so please check
it.

							Thanx, Paul

------------------------------------------------------------------------

commit 5e433764beec0134a9a677f399a6e4539eb8870d
Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
Date:   Tue Apr 11 15:13:41 2023 +0200

    rcu/kvfree: Do not run a page work if a cache is disabled
    
    By default the cache size is 5 pages per CPU, but it can be disabled at
    boot time by setting the rcu_min_cached_objs to zero.  When that happens,
    the current code will uselessly set an hrtimer to schedule refilling this
    cache with zero pages.  This commit therefore streamlines this process
    by simply refusing the set the hrtimer when rcu_min_cached_objs is zero.
    
    Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 41daae3239b5..f855d2a85597 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3247,6 +3247,10 @@ static void fill_page_cache_func(struct work_struct *work)
 static void
 run_page_cache_worker(struct kfree_rcu_cpu *krcp)
 {
+	// If cache disabled, bail out.
+	if (!rcu_min_cached_objs)
+		return;
+
 	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
 			!atomic_xchg(&krcp->work_in_progress, 1)) {
 		if (atomic_read(&krcp->backoff_page_cache_fill)) {
