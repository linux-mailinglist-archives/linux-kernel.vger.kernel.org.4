Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72288722061
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 10:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbjFEIAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 04:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbjFEIAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 04:00:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681CF9E
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 00:59:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 22C6C1F8AE;
        Mon,  5 Jun 2023 07:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1685951998; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i4L3g+MtdfsEoM7Bo/IRfMUnuKT+xcWapx0/jpEiQr8=;
        b=PEbxtQuZZK8xEzBZGkDd8Q1N6IoKPhhS09HcpzZaVndMt0l3SLhgM0jLdqm18oeM5xu4MO
        unjLitffz9hUIE6hrk60LGuZUubTXenrTAxz4+PdlvivRMv3GaxrzSrBSGizxp8TaYjAcH
        UeiKwBvlsObSYgOdwA3+OHdRzwIx9G4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 018A4139C8;
        Mon,  5 Jun 2023 07:59:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sPPmOP2VfWRUewAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 05 Jun 2023 07:59:57 +0000
Date:   Mon, 5 Jun 2023 09:59:57 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2 3/3] mm/vmstat: do not refresh stats for nohz_full CPUs
Message-ID: <ZH2V/QxDrq7aq5fY@dhcp22.suse.cz>
References: <20230602185757.110910188@redhat.com>
 <20230602190115.545766386@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602190115.545766386@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 02-06-23 15:58:00, Marcelo Tosatti wrote:
> The interruption caused by queueing work on nohz_full CPUs 
> is undesirable for certain aplications.

This is not a proper changelog. I am not going to write a changelog for
you this time. Please explain why this is really needed and why this
approach is desired. E.g. why don't you prevent userspace from
refreshing stats if interference is not desirable. Also would it make
some sense to reduce flushing to cpumask of the calling process?
(certainly a daring thought but have you even considered it?)

> Fix by not refreshing per-CPU stats of nohz_full CPUs. 
> 
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> 
> ---
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
