Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B6B722049
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 09:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbjFEH4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 03:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbjFEH4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 03:56:21 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E976D3
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 00:55:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5AC4421B2E;
        Mon,  5 Jun 2023 07:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1685951758; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VXaHPB8BNlakUIWezyFQAa9Z7HVGOiJDan/Axrkf5zw=;
        b=JRpD4ctcwVaV1ctLM7gUmzd8wphoKwPD89Xjc7W0ASoydOMvjV+rP2Ny+ndcvJhV8ChVFD
        Nakek+HhLzEPUDA7Va7N5PLilODa1xEa7M3RuIr4LuL9a+un+g69hcac86Hr3zIICnP25i
        BUEvti0BBDtYIAVvQPAhWpBto9p8lp4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 40F1E139C8;
        Mon,  5 Jun 2023 07:55:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BdQ1Dw6VfWRceQAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 05 Jun 2023 07:55:58 +0000
Date:   Mon, 5 Jun 2023 09:55:57 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2 2/3] vmstat: skip periodic vmstat update for nohz full
 CPUs
Message-ID: <ZH2VDaF9uODTqAfV@dhcp22.suse.cz>
References: <20230602185757.110910188@redhat.com>
 <20230602190115.521067386@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602190115.521067386@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 02-06-23 15:57:59, Marcelo Tosatti wrote:
> The interruption caused by vmstat_update is undesirable 
> for certain aplications:
> 
> oslat   1094.456862: sys_mlock(start: 7f7ed0000b60, len: 1000)
> oslat   1094.456971: workqueue_queue_work: ... function=vmstat_update ...
> oslat   1094.456974: sched_switch: prev_comm=oslat ... ==> next_comm=kworker/5:1 ...
> kworker 1094.456978: sched_switch: prev_comm=kworker/5:1 ==> next_comm=oslat ...
> 
> The example above shows an additional 7us for the
> 
>        	oslat -> kworker -> oslat
> 
> switches. In the case of a virtualized CPU, and the vmstat_update  
> interruption in the host (of a qemu-kvm vcpu), the latency penalty
> observed in the guest is higher than 50us, violating the acceptable
> latency threshold.

I personally find the above problem description insufficient. I have
asked several times and only got piece by piece information each time.
Maybe there is a reason to be secretive but it would be great to get at
least some basic expectations described  and what they are based on.

E.g. workloads are running on isolated cpus with nohz full mode to
shield off any kernel interruption. Yet there are operations that update
counters (like mlock, but not mlock alone) that update per cpu counters
that will eventually get flushed and that will cause some interference.
Now the host/guest transition and intereference. How that happens when
the guest is running on an isolated and dedicated cpu?

> Skip periodic updates for nohz full CPUs. Any callers who
> need precise values should use a snapshot of the per-CPU
> counters, or use the global counters with measures to 
> handle errors up to thresholds (see calculate_normal_threshold).

I would rephrase this paragraph. 
In kernel users of vmstat counters either require the precise value and
they are using zone_page_state_snapshot interface or they can live with
an imprecision as the regular flushing can happen at arbitrary time and
cumulative error can grow (see calculate_normal_threshold).

From that POV the regular flushing can be postponed for CPUs that have
been isolated from the kernel interference withtout critical
infrastructure ever noticing. Skip regular flushing from vmstat_shepherd
for all isolated CPUs to avoid interference with the isolated workload.

> Suggested by Michal Hocko.
> 
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> 
> ---
> 
> v2: use cpu_is_isolated		(Michal Hocko)
> 
> Index: linux-vmstat-remote/mm/vmstat.c
> ===================================================================
> --- linux-vmstat-remote.orig/mm/vmstat.c
> +++ linux-vmstat-remote/mm/vmstat.c
> @@ -28,6 +28,7 @@
>  #include <linux/mm_inline.h>
>  #include <linux/page_ext.h>
>  #include <linux/page_owner.h>
> +#include <linux/sched/isolation.h>
>  
>  #include "internal.h"
>  
> @@ -2022,6 +2023,16 @@ static void vmstat_shepherd(struct work_
>  	for_each_online_cpu(cpu) {
>  		struct delayed_work *dw = &per_cpu(vmstat_work, cpu);
>  
> +		/*
> +		 * Skip periodic updates for isolated CPUs.
> +		 * Any callers who need precise values should use
> +		 * a snapshot of the per-CPU counters, or use the global
> +		 * counters with measures to handle errors up to
> +		 * thresholds (see calculate_normal_threshold).
> +		 */
> +		if (cpu_is_isolated(cpu))
> +			continue;
> +
>  		if (!delayed_work_pending(dw) && need_update(cpu))
>  			queue_delayed_work_on(cpu, mm_percpu_wq, dw, 0);
>  
> 

-- 
Michal Hocko
SUSE Labs
