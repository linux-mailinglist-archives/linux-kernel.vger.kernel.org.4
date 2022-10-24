Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522DF60A4C3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 14:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbiJXMPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 08:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233161AbiJXMOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 08:14:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BB931DD0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 04:55:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20E04612E4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 11:54:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DBDBC433C1;
        Mon, 24 Oct 2022 11:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666612469;
        bh=/o+mi3lqLRFkJ7ON565vkXhmtzUNxmeBz98aaAWoL/o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SFgncGQwAjO9MyLrbGxP8Pz9fziukwMyBVefnpDoyTRqHqE4ETly6+FvTKZZZXs5j
         lwOxgMLfvEjZfa+j1jd+8KXTsXOO0s/kqU/LQvPorh0IqKn0YkrFZ6+v/xKIwBdhch
         NEXwbbBR4JZG+5Y1Q6xsesdqkbyvlGDL7HGTVYejKmFP1vB3inLU6U79LfFAlL5grr
         8UFLCbzjzgXZJRillYBJzoZ3MlQJ3ktTIo6eDi68ev3lWlYVhb/vaZDybclLzl06Hu
         dam8tzXpjgshwgI7ecZzEomgH0H71zjcFUS10wL+bPabaNgXI6wVo8yZ5Fr59zcfNO
         3pNKk+k4gWTBw==
Date:   Mon, 24 Oct 2022 13:54:26 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     mtosatti@redhat.com, cl@linux.com, tglx@linutronix.de,
        mingo@kernel.org, peterz@infradead.org, pauld@redhat.com,
        neelx@redhat.com, oleksandr@natalenko.name, atomlin@atomlin.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v8 3/5] mm/vmstat: Do not queue vmstat_update if tick is
 stopped
Message-ID: <20221024115426.GA1287228@lothringen>
References: <20220924152227.819815-1-atomlin@redhat.com>
 <20220924152227.819815-4-atomlin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220924152227.819815-4-atomlin@redhat.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 24, 2022 at 04:22:25PM +0100, Aaron Tomlin wrote:
> From: Marcelo Tosatti <mtosatti@redhat.com>
> 
> From the vmstat shepherd, for CPUs that have the tick stopped, do not
> queue local work to flush the per-CPU vmstats, since in that case the
> flush is performed on return to userspace or when entering idle. Also
> cancel any delayed work on the local CPU, when entering idle on nohz
> full CPUs. Per-CPU pages can be freed remotely from housekeeping CPUs.
> 
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> ---
>  mm/vmstat.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 472175642bd9..3b9a497965b4 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -29,6 +29,7 @@
>  #include <linux/page_ext.h>
>  #include <linux/page_owner.h>
>  #include <linux/migrate.h>
> +#include <linux/tick.h>
>  
>  #include "internal.h"
>  
> @@ -1990,19 +1991,23 @@ static void vmstat_update(struct work_struct *w)
>   */
>  void quiet_vmstat(void)
>  {
> +	struct delayed_work *dw;
> +
>  	if (system_state != SYSTEM_RUNNING)
>  		return;
>  
>  	if (!is_vmstat_dirty())
>  		return;
>  
> +	refresh_cpu_vm_stats(false);
> +
>  	/*
> -	 * Just refresh counters and do not care about the pending delayed
> -	 * vmstat_update. It doesn't fire that often to matter and canceling
> -	 * it would be too expensive from this path.
> -	 * vmstat_shepherd will take care about that for us.
> +	 * If the tick is stopped, cancel any delayed work to avoid
> +	 * interruptions to this CPU in the future.
>  	 */
> -	refresh_cpu_vm_stats(false);
> +	dw = &per_cpu(vmstat_work, smp_processor_id());
> +	if (delayed_work_pending(dw) && tick_nohz_tick_stopped())
> +		cancel_delayed_work(dw);

This is doing the costly cancel_delayed_work() which is only necessary
right before entering entering in user.

There are places where the tick is stopped but it's not necessary to
cancel the work:

* nohz_full enter idle
* idle IRQs
* nohz_full exit idle
* nohz_full IRQ exit

I suggest having quiet_vmstat_enter_user() which does:

void quiet_vmstat_enter_user(void)
{
	quiet_vmstat();
	if (delayed_work_pending(dw) && tick_nohz_tick_stopped())
	   cancel_delayed_work(dw);
}

And call this one only before leaving the kernel. The rest can use quiet_vmstat().

Thanks.
