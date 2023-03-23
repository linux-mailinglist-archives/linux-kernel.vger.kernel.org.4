Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A766C7096
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 19:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbjCWS4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 14:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbjCWS4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 14:56:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AB930EBF;
        Thu, 23 Mar 2023 11:56:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50F8A6286C;
        Thu, 23 Mar 2023 18:56:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9C2EC433D2;
        Thu, 23 Mar 2023 18:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679597767;
        bh=DMQPjPrXTRF9Z4qs+jIBK5nj08uLBL2UwkbNHFxoS7A=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=gpMPyHaKboX/t/jcGRDd9zFDawqGj+G5nLA2mtD474FAf+nn6HoLQW7b8HoL5cwip
         hsUglgcnxQao5HtpFfBmdSDV9Q3cSdJ5KswMBqaDzf3yJLWtmbokiof7Xo+G115hhn
         M5bnnVAdnYFPvvOkJNIeblToYgSIvvPwe3XxF+LNM2XMd2SWz8NbvbTkGDkz/3VSO2
         gq793gvjwSMzmRXGO2SNI1QMnYhsC8MeS5Tf4hFBqSNeTajkWC71l8Lpy8LY2CMVgX
         NTiNxO+AQ+PutlP3qZ/ojT2arfSkQ4mZXlLIsLsykQEXSxNOunuxYqiK8zEvYzKZ8k
         N9f3ppTJrH6Sw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 49E191540398; Thu, 23 Mar 2023 11:56:07 -0700 (PDT)
Date:   Thu, 23 Mar 2023 11:56:07 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     frederic@kernel.org, joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu-tasks: Make pr_info() output more clearly in
 cblist_init_generic()
Message-ID: <48a5bce5-0a06-4d71-b5f0-14dcea059765@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230323040011.143884-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323040011.143884-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 12:00:11PM +0800, Zqiang wrote:
> This commit use rtp->name instead of __func__, and output the value
> of rcu_task_cb_adjust in pr_info(), reduced pr_info() calls.
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

Queued, thank you!

							Thanx, Paul

> ---
>  kernel/rcu/tasks.h | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index 397309da3446..0cf958db4e44 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -270,10 +270,8 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
>  	}
>  	raw_spin_unlock_irqrestore(&rtp->cbs_gbl_lock, flags);
>  
> -	if (rcu_task_cb_adjust)
> -		pr_info("%s: Setting adjustable number of callback queues.\n", __func__);
> -
> -	pr_info("%s: Setting shift to %d and lim to %d.\n", __func__, data_race(rtp->percpu_enqueue_shift), data_race(rtp->percpu_enqueue_lim));
> +	pr_info("%s: Setting shift to %d and lim to %d rcu_task_cb_adjust=%d.\n", rtp->name,
> +			data_race(rtp->percpu_enqueue_shift), data_race(rtp->percpu_enqueue_lim), rcu_task_cb_adjust);
>  }
>  
>  // IRQ-work handler that does deferred wakeup for call_rcu_tasks_generic().
> -- 
> 2.25.1
> 
