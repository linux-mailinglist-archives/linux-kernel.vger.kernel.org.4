Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3839722FAE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 21:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235450AbjFETUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 15:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbjFETUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 15:20:47 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83BA0EE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 12:20:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 043FA1F8AB;
        Mon,  5 Jun 2023 19:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1685992813; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fk9hKNzcZ8kHfwYU6A35s2rZGW0gG6jzBk9enONxz1U=;
        b=Jo0yYNkNpmE8N1QPiKpa1SzLijBJVHUZeq58M45Xf20KNMG5bUZo6gEPJN0XuqN0JqfXuz
        bdXR1X76x0cLj4R9vP2xd4SP5F4QVyE7q6RJzQPPss/Hnl0IIyBYM2m/YtSvmqNa+5Q3Lp
        PvWkKWbvese4EvF7JDjbWUtcKDpEOGI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D7FA2139C8;
        Mon,  5 Jun 2023 19:20:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dBZPMmw1fmSvZgAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 05 Jun 2023 19:20:12 +0000
Date:   Mon, 5 Jun 2023 21:20:12 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v3 3/3] mm/vmstat: do not refresh stats for isolated CPUs
Message-ID: <ZH41bFWrc0LWae/U@dhcp22.suse.cz>
References: <20230605185627.923698377@redhat.com>
 <20230605190132.087124739@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605190132.087124739@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 05-06-23 15:56:30, Marcelo Tosatti wrote:
> schedule_work_on API uses the workqueue mechanism to
> queue a work item on a queue. A kernel thread, which
> runs on the target CPU, executes those work items.
> 
> Therefore, when using the schedule_work_on API,
> it is necessary for the kworker kernel thread to
> be scheduled in, for the work function to be executed.
> 
> Time sensitive applications such as SoftPLCs
> (https://tum-esi.github.io/publications-list/PDF/2022-ETFA-How_Real_Time_Are_Virtual_PLCs.pdf),
> have their response times affected by such interruptions.
> 
> The /proc/sys/vm/stat_refresh file was originally introduced
> with the goal to:
> 
> "Provide /proc/sys/vm/stat_refresh to force an immediate update of
>  per-cpu into global vmstats: useful to avoid a sleep(2) or whatever
>  before checking counts when testing.  Originally added to work around a
>  bug which left counts stranded indefinitely on a cpu going idle (an
>  inaccuracy magnified when small below-batch numbers represent "huge"
>  amounts of memory), but I believe that bug is now fixed: nonetheless,
>  this is still a useful knob."
> 
> Other than the potential interruption to a time sensitive application,
> if using SCHED_FIFO or SCHED_RR priority on the isolated CPU, then
> system hangs can occur:

The same thing can happen without isolated CPUs and this patch doesn't
help at all.

> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=978688

And this is an example of that...

> To avoid the problems above, do not schedule the work to synchronize
> per-CPU mm counters on isolated CPUs. Given the possibility for
> breaking existing userspace applications, avoid returning
> errors from access to /proc/sys/vm/stat_refresh.
> 
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

It would be really helpful to not post new versions while discussion of
the previous one is still not done.

Anyway
Nacked-by: Michal Hocko <mhocko@suse.com>

This is silently changing semantic and I do not think you have actually
shown this is a real life problem. To me it sounds like a theoretical
issue at most and it can be worked around by disalowing to use this
interface from userspace. stat_refresh is mostly for debugging purposes
and I strongly doubt it is ever used in environments you refer to in
this series.
> 
> ---
> v3: improve changelog		  (Michal Hocko)
> v2: opencode schedule_on_each_cpu (Michal Hocko)
> 
> Index: linux-vmstat-remote/mm/vmstat.c
> ===================================================================
> --- linux-vmstat-remote.orig/mm/vmstat.c
> +++ linux-vmstat-remote/mm/vmstat.c
> @@ -1881,8 +1881,13 @@ int vmstat_refresh(struct ctl_table *tab
>  		   void *buffer, size_t *lenp, loff_t *ppos)
>  {
>  	long val;
> -	int err;
>  	int i;
> +	int cpu;
> +	struct work_struct __percpu *works;
> +
> +	works = alloc_percpu(struct work_struct);
> +	if (!works)
> +		return -ENOMEM;
>  
>  	/*
>  	 * The regular update, every sysctl_stat_interval, may come later
> @@ -1896,9 +1901,24 @@ int vmstat_refresh(struct ctl_table *tab
>  	 * transiently negative values, report an error here if any of
>  	 * the stats is negative, so we know to go looking for imbalance.
>  	 */
> -	err = schedule_on_each_cpu(refresh_vm_stats);
> -	if (err)
> -		return err;
> +	cpus_read_lock();
> +	for_each_online_cpu(cpu) {
> +		struct work_struct *work;
> +
> +		if (cpu_is_isolated(cpu))
> +			continue;
> +		work = per_cpu_ptr(works, cpu);
> +		INIT_WORK(work, refresh_vm_stats);
> +		schedule_work_on(cpu, work);
> +	}
> +
> +	for_each_online_cpu(cpu) {
> +		if (cpu_is_isolated(cpu))
> +			continue;
> +		flush_work(per_cpu_ptr(works, cpu));
> +	}
> +	cpus_read_unlock();
> +	free_percpu(works);
>  	for (i = 0; i < NR_VM_ZONE_STAT_ITEMS; i++) {
>  		/*
>  		 * Skip checking stats known to go negative occasionally.
> 

-- 
Michal Hocko
SUSE Labs
