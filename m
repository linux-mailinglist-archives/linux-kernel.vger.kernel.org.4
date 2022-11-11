Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCAE36254DC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 09:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbiKKIEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 03:04:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232988AbiKKIEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 03:04:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E3569DEA;
        Fri, 11 Nov 2022 00:04:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8D003B823FF;
        Fri, 11 Nov 2022 08:04:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21029C433C1;
        Fri, 11 Nov 2022 08:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668153885;
        bh=UH08BgNIy0Ir2cfbIMbIdEh7C7tlvhLyxSSliZqjUek=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=S8mj79k718mREVoqdFRhDIGz19Y3+5qssHA769RxwE12gayAl6Hko04Ii158uV0qQ
         RTEatj47R5rMD8o1/qXhRS1aBGI6SdpsXaEFyG8ZD7dpy+9iufmzxSeY3shJ4K9AK7
         iOJ9o3b8LMfs+kavNNC9bMeXhCBVnym7MUzHW3WHlbEdBGY4AaT45ZFvw7CEJTGkPk
         bBDUKkuxiS/fKFqjjbCT/QTox1g7JjTZCnG8wKuz5PoyMMVSfZulaAO0cmRmPkaR2Q
         Tq098x8mzG6c/avZ8GKeP06EvqiuSSaeJzIbCqyEEGEXFNmbHTxV9kfVdMIMOei7ND
         CK7tvZqISskuw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C4A395C0A59; Fri, 11 Nov 2022 00:04:42 -0800 (PST)
Date:   Fri, 11 Nov 2022 00:04:42 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     frederic@kernel.org, joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] srcu: Make Tiny SRCU synchronize_srcu() more complete
Message-ID: <20221111080442.GU725751@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221109073638.935473-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109073638.935473-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 03:36:38PM +0800, Zqiang wrote:
> This commit add lockdep detection for illegal use synchronize_srcu()
> in same-type SRCU (or in RCU) read-side critical section and support
> early boot operations.
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

Queued and pushed with the usual wordsmithing (please check), thank you!

							Thanx, Paul

> ---
>  kernel/rcu/srcutiny.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
> index 33adafdad261..b12fb0cec44d 100644
> --- a/kernel/rcu/srcutiny.c
> +++ b/kernel/rcu/srcutiny.c
> @@ -197,6 +197,16 @@ void synchronize_srcu(struct srcu_struct *ssp)
>  {
>  	struct rcu_synchronize rs;
>  
> +	RCU_LOCKDEP_WARN(lockdep_is_held(ssp) ||
> +			lock_is_held(&rcu_bh_lock_map) ||
> +			lock_is_held(&rcu_lock_map) ||
> +			lock_is_held(&rcu_sched_lock_map),
> +			"Illegal synchronize_srcu() in same-type SRCU (or in RCU) read-side critical section");
> +
> +	if (rcu_scheduler_active == RCU_SCHEDULER_INACTIVE)
> +		return;
> +
> +	might_sleep();
>  	init_rcu_head_on_stack(&rs.head);
>  	init_completion(&rs.completion);
>  	call_srcu(ssp, &rs.head, wakeme_after_rcu);
> -- 
> 2.25.1
> 
