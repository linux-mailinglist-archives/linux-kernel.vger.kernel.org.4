Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036617465BD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 00:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjGCWaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 18:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjGCWav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 18:30:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82724E62
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 15:30:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08F7E61083
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 22:30:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8A63C433C7;
        Mon,  3 Jul 2023 22:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688423449;
        bh=sX9afl6YTod/zLy4ivkSOQmfH1eLxpMhhfEXxZF7uCM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kNl6kSpnOAp+fL/bDdNpnRPD5YrH/xjHiqx9tEkXTZjvljfzM8WEhxLjeKmNLk+TH
         7hrGyVYicoWbkWi5nap309IwRLfJJHQCN9LAn+l70V+kI4v7Sfvx2LjM2Ht1XjP22u
         6l+5xTAM9z0lfk4jhOzQxN+2NdyRKcW+CL2eUIb0CummivVyIIYqV6nLCW6D3NkUrV
         QoXtEbL06/aSUITI0VM2TrAZLmWFmAFr9X88yNNOMJsb9FpJZ9xM7QPZnJdfPUoebv
         /iW2DK8X0K3Q/T57SZOJ9ltNhbrUziPOhL1kDccqgq5wPfaAK4rBIW4HsEA+588PWN
         yt9mLJuc4ybow==
Date:   Tue, 4 Jul 2023 00:30:46 +0200
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
Subject: Re: [patch 17/45] posix-cpu-timers: Make k_itimer::it_active
 consistent
Message-ID: <ZKNMFv7VTIaTTJwe@lothringen>
References: <20230606132949.068951363@linutronix.de>
 <20230606142031.983662966@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606142031.983662966@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 04:37:45PM +0200, Thomas Gleixner wrote:
> @@ -787,6 +790,7 @@ static u64 collect_timerqueue(struct tim
>  
>  	while ((next = timerqueue_getnext(head))) {
>  		struct cpu_timer *ctmr;
> +		struct k_itimer *ktmr;
>  		u64 expires;
>  
>  		ctmr = container_of(next, struct cpu_timer, node);
> @@ -799,6 +803,8 @@ static u64 collect_timerqueue(struct tim
>  		/* See posix_cpu_timer_wait_running() */
>  		rcu_assign_pointer(ctmr->handling, current);
>  		cpu_timer_dequeue(ctmr);
> +		ktmr = container_of(ctmr, struct k_itimer, it.cpu);
> +		ktmr->it_active = 0;

Maybe move this to cpu_timer_fire() because:

1) Other posix-timer implementation set it_active = 0
   from their actual handler.

2) This place doesn't have the timer locked. Better Make
   sure we have this protection to avoid mistakes against
   potential future use of it_active.

Thanks.

>  		list_add_tail(&ctmr->elist, firing);
>  	}
>  
> 
