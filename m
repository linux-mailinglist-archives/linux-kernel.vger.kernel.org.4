Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107B571FFB4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 12:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235756AbjFBKuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 06:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234799AbjFBKuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 06:50:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F96C0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 03:50:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A85401FDEE;
        Fri,  2 Jun 2023 10:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1685703002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t1DN/Wo6XcgMrXruRd9Ka7Ol5rhbm9640awdkLIcF+4=;
        b=QqLjD+BMrdMw4IwsGo43XY+JxUOaJtm5EziVOxifQ7ak8F7yDcGWt+5Q2AOq5hYPljtptf
        RcSEqkywJP9QHuwBqBdAMcy6gcgCYsv5Fyxe33Sh2BA2CEE4k2uFkDOMT+2vEmvUUFKehJ
        gysqOQxvOdocHTd421mVS+VLpYt8abM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8BDDC13A2E;
        Fri,  2 Jun 2023 10:50:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id U3crH1rJeWSEYQAAMHmgww
        (envelope-from <mhocko@suse.com>); Fri, 02 Jun 2023 10:50:02 +0000
Date:   Fri, 2 Jun 2023 12:50:01 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 4/4] mm/vmstat: do not refresh stats for nohz_full CPUs
Message-ID: <ZHnJWdbCcL9+VIpx@dhcp22.suse.cz>
References: <20230530145234.968927611@redhat.com>
 <20230530145336.155097348@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530145336.155097348@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 30-05-23 11:52:38, Marcelo Tosatti wrote:
> The interruption caused by queueing work on nohz_full CPUs 
> is undesirable for certain aplications.
> 
> Fix by not refreshing per-CPU stats of nohz_full CPUs. 
> 
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> 
> ---
> 
> Index: linux-vmstat-remote/mm/vmstat.c
> ===================================================================
> --- linux-vmstat-remote.orig/mm/vmstat.c
> +++ linux-vmstat-remote/mm/vmstat.c
> @@ -1877,12 +1877,31 @@ static void refresh_vm_stats(struct work
>  	refresh_cpu_vm_stats(true);
>  }
>  
> +#ifdef CONFIG_NO_HZ_FULL
> +static inline const cpumask_t *tickless_cpumask(void)
> +{
> +	return tick_nohz_full_mask;
> +}
> +#else
> +static cpumask_t empty_cpumask;
> +static inline const cpumask_t *tickless_cpumask(void)
> +{
> +	return &empty_cpumask;
> +}
> +#endif
> +
>  int vmstat_refresh(struct ctl_table *table, int write,
>  		   void *buffer, size_t *lenp, loff_t *ppos)
>  {
>  	long val;
>  	int err;
>  	int i;
> +	cpumask_var_t dstmask;
> +
> +	if (!alloc_cpumask_var(&dstmask, GFP_KERNEL))
> +		return -ENOMEM;
> +
> +	cpumask_andnot(dstmask, cpu_possible_mask, tickless_cpumask());

Similar feedback to the patch 2. wouldn't it make more sense to opencode
schedule_on_each_cpu here and use cpu_is_isolated instead?

>  
>  	/*
>  	 * The regular update, every sysctl_stat_interval, may come later
> @@ -1896,7 +1915,9 @@ int vmstat_refresh(struct ctl_table *tab
>  	 * transiently negative values, report an error here if any of
>  	 * the stats is negative, so we know to go looking for imbalance.
>  	 */
> -	err = schedule_on_each_cpu(refresh_vm_stats);
> +	err = schedule_on_each_cpumask(refresh_vm_stats, dstmask);
> +	free_cpumask_var(dstmask);
> +
>  	if (err)
>  		return err;
>  	for (i = 0; i < NR_VM_ZONE_STAT_ITEMS; i++) {
> 

-- 
Michal Hocko
SUSE Labs
