Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906447464BB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 23:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjGCVMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 17:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjGCVMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 17:12:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03688E5B
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 14:12:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B8F361053
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 21:12:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96053C433C8;
        Mon,  3 Jul 2023 21:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688418752;
        bh=ruVNyp+wgVPpv/PvkXf7gipmm7L9xtJR3otX3qUNWqc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aUgyU1WDHpVlF1e5MmfUQhBI6Sm7J0OTxlfGwyi+uThm/oLz589Y9NGyxRbbqU2TK
         EmgIOAY7nI1giWAW+VTZJCNhKFc8eLKmV8uqWqnoxlhZS0ToFCA5x/Ex5RElT0qbhm
         ONb6SKzZ/kiuIeQW3QLM6sHrZfhcdfCVphwhLvgO21mVx8w1Akhddaee8FLzzn9OCR
         Ivnu62djF5Iwmb+plnUv7EMcbZBzTdjNDbC9+8O0bfQOoniGKm82aXhupkNqdT0Nfl
         3RkOsK9dfho/JtWmW7cN+6kNfrxgvbGYTFJ5k+0fOtsbKGY/wVjVN65vpU6t1Xj19k
         l7OkcnFdJ69LA==
Date:   Mon, 3 Jul 2023 23:12:28 +0200
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
Subject: Re: [patch 16/45] posix-timers: Consolidate timer setup
Message-ID: <ZKM5vMK_F32Qwg98@localhost.localdomain>
References: <20230606132949.068951363@linutronix.de>
 <20230606142031.928021762@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230606142031.928021762@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Tue, Jun 06, 2023 at 04:37:44PM +0200, Thomas Gleixner a écrit :
> hrtimer based and CPU timers have their own way to install the new interval
> and to reset overrun and signal handling related data.
> 
> Create a helper function and do the same operation for all variants.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  kernel/time/posix-cpu-timers.c |   15 +--------------
>  kernel/time/posix-timers.c     |   23 +++++++++++++++++------
>  kernel/time/posix-timers.h     |    1 +
>  3 files changed, 19 insertions(+), 20 deletions(-)
> 
> --- a/kernel/time/posix-cpu-timers.c
> +++ b/kernel/time/posix-cpu-timers.c
> @@ -709,21 +709,8 @@ static int posix_cpu_timer_set(struct k_
>  		trigger_base_recalc_expires(timer, p);
>  
>  	unlock_task_sighand(p, &flags);
> -	/*
> -	 * Install the new reload setting, and
> -	 * set up the signal and overrun bookkeeping.
> -	 */
> -	timer->it_interval = timespec64_to_ktime(new->it_interval);
>  
> -	/*
> -	 * This acts as a modification timestamp for the timer,
> -	 * so any automatic reload attempt will punt on seeing
> -	 * that we have reset the timer manually.
> -	 */
> -	timer->it_requeue_pending = (timer->it_requeue_pending + 2) &
> -		~REQUEUE_PENDING;
> -	timer->it_overrun_last = 0;
> -	timer->it_overrun = -1;
> +	posix_timer_set_common(timer, new);

So before this patch if a posix cpu timer is set with:

   .it_value = 0,
   .it_interval = 5

a further retrieval would return the same. But after this patch
it will return:

   .it_value = 0,
   .it_interval = 0

That's an ABI change, not sure if it matters though...
