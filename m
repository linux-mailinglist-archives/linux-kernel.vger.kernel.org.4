Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9599D620222
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 23:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbiKGWHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 17:07:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbiKGWHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 17:07:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9462E1005B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 14:07:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31BFB612ED
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 22:07:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1559AC433D6;
        Mon,  7 Nov 2022 22:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667858850;
        bh=PvXRjaQGHtWIn4xfTEp+b3M0cMG924oUav4IfnO8WNw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V73OYOL3KAmCMoCN68zRllLyuD1x4y322Wc18vI/ycUEI4Vpnn3Eg1W17zUzNuJQV
         OtLNnxaE4/Rip/U/5gRS6m8HHANTKhxwoosiaU5EytMjvv10MGXlLFSGb1PEqZ345X
         6bocjMbdAeq+nB1yxCrZZpUiZaw8Ng+spdthWWoKg1BquNxS9/D8hbu3VSQQ8L8iFf
         4xoEhVb+DIdpnk3sVaqxNaMwFs58hJqPtngAdq3BhwJ9fLsA/kQBsk9yFc5sXyeEAE
         Ra9u4br2RZrb92AMKfAh84c105Ww4eUdAkzDSShPGf2bMgdHE0CQCXeqvKLxEezS7e
         YqWoe68R9V2gg==
Date:   Mon, 7 Nov 2022 23:07:27 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH v4 14/16] timer: Implement the hierarchical pull model
Message-ID: <20221107220727.GA10939@lothringen>
References: <20221104145737.71236-1-anna-maria@linutronix.de>
 <20221104145737.71236-15-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104145737.71236-15-anna-maria@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 03:57:35PM +0100, Anna-Maria Behnsen wrote:
> @@ -1859,6 +1863,36 @@ void forward_and_idle_timer_bases(unsigned long basej, u64 basem,
>  	 */
>  	is_idle = time_after(nextevt, basej + 1);
>  
> +	if (is_idle) {
> +		u64 next_tmigr;
> +
> +		next_tmigr = tmigr_cpu_deactivate(tevt->global);
> +
> +		tevt->global = KTIME_MAX;
> +
> +		/*
> +		 * If CPU is the last going idle in timer migration
> +		 * hierarchy, make sure CPU will wake up in time to handle
> +		 * remote timers. next_tmigr == KTIME_MAX if other CPUs are
> +		 * still active.
> +		 */
> +		if (next_tmigr < tevt->local) {
> +			u64 tmp;
> +
> +			/* If we missed a tick already, force 0 delta */
> +			if (next_tmigr < basem)
> +				next_tmigr = basem;
> +
> +			tmp = div_u64(next_tmigr - basem, TICK_NSEC);
> +
> +			nextevt = basej + (unsigned long)tmp;
> +			tevt->local = next_tmigr;
> +			is_idle = time_after(nextevt, basej + 1);
> +		} else {
> +			nextevt = nextevt_local;

That else part look unecessary.

> +		}
> +	}
> +
>  	/* We need to mark both bases in sync */
>  	base_local->is_idle = base_global->is_idle = is_idle;

Do we still need to maintain base_global->is_idle ?

(I'm going to do daily reviews on this patch because it's quite dense :)

Thanks.
