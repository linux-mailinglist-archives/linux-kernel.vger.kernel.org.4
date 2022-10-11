Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4788E5FBE2D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 01:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbiJKXLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 19:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiJKXK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 19:10:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185AD9E0D1;
        Tue, 11 Oct 2022 16:10:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CA127B816EC;
        Tue, 11 Oct 2022 23:10:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37901C433D6;
        Tue, 11 Oct 2022 23:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665529856;
        bh=6sfltLiSJCXJ/ss+Zwctl8HVRRAsesAuRle+uv+gD7s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ERRRog/S4vSFRtBd3hogfj9Gke3BJCcNXopgqC3DE7xCZmCkGLhMLDrGc2Mj7BOkv
         dDkMRa2VpCxvqRDJ/lxpTW0Kfuf6Rv4+ZVJD3gVwFcXrHGIQuzx+Bl4Wn5dAtTdKTq
         sFAkzDhutxp45K/lpmBXVMKhqKBhWv5ePKjx0C7qxkd6CTMmAdGjfBnMWQ1AgCH0an
         QvfSnrZQlx797DilDR1WhmO/LHhVdG3JVkFUI7UN7CBmMAu7u+h5LW2fVriVQ9wLHX
         JprGdaSrJ8FEn+E/T79mwBswwzvKYpYl3VL9hW1dsWTE7PmnBivmrlI1fCy3O/MF5k
         pz9qYbmXTIkyw==
Date:   Wed, 12 Oct 2022 01:10:53 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, paulmck@kernel.org, rostedt@goodmis.org,
        youssefesmat@google.com, surenb@google.com
Subject: Re: [PATCH v8 02/13] rcu: Make call_rcu() lazy to save power
Message-ID: <20221011231053.GA1052831@lothringen>
References: <20221011180142.2742289-1-joel@joelfernandes.org>
 <20221011180142.2742289-3-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221011180142.2742289-3-joel@joelfernandes.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 06:01:31PM +0000, Joel Fernandes (Google) wrote:
> @@ -269,10 +294,14 @@ static void wake_nocb_gp_defer(struct rcu_data *rdp, int waketype,
>  	raw_spin_lock_irqsave(&rdp_gp->nocb_gp_lock, flags);
>  
>  	/*
> -	 * Bypass wakeup overrides previous deferments. In case
> -	 * of callback storm, no need to wake up too early.
> +	 * Bypass wakeup overrides previous deferments. In case of
> +	 * callback storm, no need to wake up too early.
>  	 */
> -	if (waketype == RCU_NOCB_WAKE_BYPASS) {
> +	if (waketype == RCU_NOCB_WAKE_LAZY &&
> +	    READ_ONCE(rdp->nocb_defer_wakeup) == RCU_NOCB_WAKE_NOT) {

No need for READ_ONCE() here.

> +		mod_timer(&rdp_gp->nocb_timer, jiffies + jiffies_till_flush);
> +		WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
> +	} else if (waketype == RCU_NOCB_WAKE_BYPASS) {
>  		mod_timer(&rdp_gp->nocb_timer, jiffies + 2);
>  		WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
>  	} else {
> @@ -611,6 +682,8 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
>  	unsigned long flags;
>  	bool gotcbs = false;
>  	unsigned long j = jiffies;
> +	bool lazy = false;
> +	long lazy_ncbs;

Looks like lazy_ncbs can be declared withing the loop, as well as bypass_cbs.

Anyway, apart from such boring cosmectics:

Acked-by: Frederic Weisbecker <frederic@kernel.org>

Thanks!
