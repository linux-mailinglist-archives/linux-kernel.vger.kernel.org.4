Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71927728150
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 15:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236569AbjFHNZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 09:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234352AbjFHNZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 09:25:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8977EE57
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 06:25:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 201F864AAE
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 13:25:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23040C433D2;
        Thu,  8 Jun 2023 13:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686230707;
        bh=ffrwrWEfJmcH+mGcOtv3y3UnYs5C7RZS0GATvAwY41Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cg+2xuY/4+rpa2cfGcg68qce/lhCIanbmtEhverETP9h5fY//9MpXiOhA1RqzPwvP
         AybeqvuPLNoylj8jktjjGJjwIP9k7ivIgceiLTM0y2kABNVq6OM55oXrR2SFxjRnLR
         8gGmqxHWDaf4n13rDHWVUbkCx/ne1Y5X1ZNvfXpRNllaGC7dIcia2lC4OyelexoBGL
         5ExtBggIOGWj7+Rn33e4GGzXqiCe4AAE6RMZmtXmDF+cl5j2K5Qn4E05tCydqz8ZDn
         1NOlhEGSbKn2Hpw5/r6tv3403BD+PsASt9EqOK+7EGpePFvjBNxgV3xmB1CSkvW5GC
         D1px0+c9XbBHQ==
Date:   Thu, 8 Jun 2023 15:25:04 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/idle: disable tick in idle=poll idle entry
Message-ID: <ZIHWsAC+n6mrDyFT@lothringen>
References: <ZIEqlkIASx2F2DRF@tpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIEqlkIASx2F2DRF@tpad>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 10:10:46PM -0300, Marcelo Tosatti wrote:
> 
> Commit a5183862e76fdc25f36b39c2489b816a5c66e2e5 
> ("tick/nohz: Conditionally restart tick on idle exit") allows
> a nohz_full CPU to enter idle and return from it with the 
> scheduler tick disabled (since the tick might be undesired noise).
> 
> The idle=poll case still unconditionally restarts the tick when entering
> idle.
> 
> To reduce the noise for that case as well, stop the tick when entering
> idle, for the idle=poll case.
> 
> tick_nohz_idle_exit (called if the NEED_RESCHED bit is set) 
> is responsible for re-enabling the tick when necessary. 
> 
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> 
> ---
> 
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index 342f58a329f5..fdc240988ea9 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -276,7 +276,7 @@ static void do_idle(void)
>  		 * idle as we know that the IPI is going to arrive right away.
>  		 */
>  		if (cpu_idle_force_poll || tick_check_broadcast_expired()) {
> -			tick_nohz_idle_restart_tick();
> +			tick_nohz_idle_stop_tick();
>  			cpu_idle_poll();

cpu_idle_poll() re-enables interrupts and only checks need_resched(). If an
interrupt happens and queues a new timer without waking up a task, the timer
gets ignored.

>  		} else {
>  			cpuidle_idle_call();
> 
