Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248FC609FB5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 13:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbiJXLEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 07:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiJXLEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 07:04:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0981742AF5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 04:03:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 94301B80DB5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 11:03:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E387EC433D6;
        Mon, 24 Oct 2022 11:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666609394;
        bh=3p6vEdxFEex3ws6zgpDgG9A0svbChvzTuL3cIfkLL2Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aEkKljZZA3CxWKUxfs4KTGpDT0B19Xva2azDkW+c+JfxB98Y/Q5wO3XAqSghfeEZB
         tqxCMnHa0teb3RyXnAAXUGDXZbZyY73iQphwINW6k9pnm7BGEte+qOrkW87Ezngngp
         HctiSoYp43kDXmOaEK+WZX7llGvIGWpgEUPUximwdJmYfJLTL/L8C4N9Y/eJFri9iV
         k1JWJ3Lhrrtgj8VftoNVlQXczKmbKpaMtUmFwXQIaDsN9yh5S27+YNGUFywFBiIA9S
         ixFedqedyu+htxeEW+CSqKSquRymkMOAjY+Y2vxYOEpo1HrhCtDvzehSZ7t+mdlpJV
         B6vTViv5Fl/qA==
Date:   Mon, 24 Oct 2022 13:03:11 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     mtosatti@redhat.com, cl@linux.com, tglx@linutronix.de,
        mingo@kernel.org, peterz@infradead.org, pauld@redhat.com,
        neelx@redhat.com, oleksandr@natalenko.name, atomlin@atomlin.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v8 3/5] mm/vmstat: Do not queue vmstat_update if tick is
 stopped
Message-ID: <20221024110311.GA1285913@lothringen>
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
>  }
>  
>  /*
> @@ -2024,6 +2029,9 @@ static void vmstat_shepherd(struct work_struct *w)
>  	for_each_online_cpu(cpu) {
>  		struct delayed_work *dw = &per_cpu(vmstat_work, cpu);
>  
> +		if (tick_nohz_tick_stopped_cpu(cpu))
> +			continue;
> +
>  		if (!delayed_work_pending(dw) && per_cpu(vmstat_dirty, cpu))
>  			queue_delayed_work_on(cpu, mm_percpu_wq, dw, 0);

All these checks are racy though. You may well eventually:

1) Arm the timer after the CPU has entered in userspace
2) Not arm the timer when the CPU has entered the kernel

How about converting that to an IPI instead? This should be a good candidate
for the future IPI deferment.

Another possible way to go is this:

1) vmstat_shepherd completely ignores nohz_full CPUs
2) vmstat_work is only ever armed locally
3) A nohz_full CPU turning its local vmstat as dirty checks if vmstat_work is
   pending. If not, queue it, possibly through a self IPI (IRQ_WORK) to get
   away with current locking context.
3) Fold on idle if dirty
4) Fold on user enter and disarm vmstat_work if pending

Does that sound possible?

Thanks.


>  
> -- 
> 2.37.1
> 
