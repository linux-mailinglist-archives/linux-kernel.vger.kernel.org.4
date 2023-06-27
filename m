Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A22173FA81
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 12:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjF0Kv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 06:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbjF0KvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 06:51:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7582210D7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 03:51:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCBEC6112A
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 10:51:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B914BC433C8;
        Tue, 27 Jun 2023 10:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687863083;
        bh=AWdtvtdK2jeau/jeOTJfvqMbtrKaNLL/5enJRmd48p8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WxTCxhmFsYZwZAUnypYzQp7zr1OKXl0Mi2bRwdzxg/ZAvpHWhxe9rosI/V62DZDV7
         KHDSwySXmrwBEAoaf2f61S7I4I0brjbOImFxNjUn5o62koGAJkf+RDDoi1un0ZS2lF
         E9gJ0KzkHL+kz0qsV81blsPD/wtAvZIcCM0PMJCqhW0XXotxid2x0XTU7ublct0oqg
         DD41l5RIvfP9y3nSHS0maF3mFMUTVzoCCIXxpBDQtO8SZAtiFR0AZ0nwZhmWGXlM0m
         C/Uq23M6YgreJX2yGwlxZIBZLDwNOjh2yGGn0Q2EQVzHrtTvRW1vExnmyVb49gGoSM
         V4+m5UWLiRmNA==
Date:   Tue, 27 Jun 2023 12:51:20 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        John Stultz <jstultz@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch 12/45] posix-cpu-timers: Simplify posix_cpu_timer_set()
Message-ID: <ZJq/KHqjChLWtypG@lothringen>
References: <20230606132949.068951363@linutronix.de>
 <20230606142031.705286109@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606142031.705286109@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 04:37:37PM +0200, Thomas Gleixner wrote:
> Avoid the late sighand lock/unlock dance when a timer is not armed to
> enforce reevaluation of the timer base so that the process wide CPU timer
> sampling can be disabled.
> 
> Do it right at the point where the arming decision is made which already
> has sighand locked.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  kernel/time/posix-cpu-timers.c |   38 +++++++++++++-------------------------
>  1 file changed, 13 insertions(+), 25 deletions(-)
> 
> --- a/kernel/time/posix-cpu-timers.c
> +++ b/kernel/time/posix-cpu-timers.c
> @@ -720,10 +720,14 @@ static int posix_cpu_timer_set(struct k_
>  	/*
>  	 * Arm the timer if it is not disabled, the new expiry value has
>  	 * not yet expired and the timer requires signal delivery.
> -	 * SIGEV_NONE timers are never armed.
> +	 * SIGEV_NONE timers are never armed. In case the timer is not
> +	 * armed, enforce the reevaluation of the timer base so that the
> +	 * process wide cputime counter can be disabled eventually.
>  	 */
>  	if (!sigev_none && new_expires && now < new_expires)
>  		arm_timer(timer, p);
> +	else
> +		trigger_base_recalc_expires(timer, p);

We don't need a recalc if sigev_none, right?

Thanks.

>  
>  	unlock_task_sighand(p, &flags);
>  	/*
