Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3BFB6B7DD8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 17:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjCMQmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 12:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjCMQmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 12:42:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DCBA26E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 09:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678725688;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7SWY7Mn5/0csa+Fcuc39rkRFfDeJwVi+4x0f1XY+QmE=;
        b=gcCDb7jnhTgTZJDcxBHue6NV3ueilIjzd7ILbjZIec/Yxa1XaCM2vC0k+2nle/FuoyUrZk
        DbnwAAUTAmQLQ9VU+4rXaXgcX0D6hzr4BKXranNW4huBzZnHz+vGe14loCMiwl/9vILQPA
        iaOxOEus1bRM4TwQ629ld7YScK5+bQI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-536-lI1J63r0PWiplx5fa3Mfwg-1; Mon, 13 Mar 2023 12:41:25 -0400
X-MC-Unique: lI1J63r0PWiplx5fa3Mfwg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D8C8085CBE8;
        Mon, 13 Mar 2023 16:41:24 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4CDFA202701E;
        Mon, 13 Mar 2023 16:41:24 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 0807740134450; Mon, 13 Mar 2023 13:41:06 -0300 (-03)
Date:   Mon, 13 Mar 2023 13:41:06 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Vlastimil Babka <vbabka@suse.cz>,
        Leonardo Bras <leobras@redhat.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Russell King <linux@armlinux.org.uk>,
        Huacai Chen <chenhuacai@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, x86@kernel.org,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v4 01/12] mm/vmstat: remove remote node draining
Message-ID: <ZA9SImzAVxuFiOxb@tpad>
References: <20230305133657.255737580@redhat.com>
 <20230305134053.436759976@redhat.com>
 <015212c4-8e3b-253a-f307-56a3e331060e@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <015212c4-8e3b-253a-f307-56a3e331060e@suse.cz>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 06:11:30PM +0100, Vlastimil Babka wrote:
> On 3/5/23 14:36, Marcelo Tosatti wrote:
> > Draining of pages from the local pcp for a remote zone should not be
> > necessary, since once the system is low on memory (or compaction on a
> > zone is in effect), drain_all_pages should be called freeing any unused
> > pcps.
> 
> Hmm I can't easily say this is a good idea without a proper evaluation. It's
> true that drain_all_pages() will be called from
> __alloc_pages_direct_reclaim(), but if you look closely, it's only after
> __perform_reclaim() and subsequent get_page_from_freelist() failure, which
> means very low on memory. There's also kcompactd_do_work() caller, but that
> shouldn't respond to order-0 pressure.
> 
> Maybe part of the problem is that pages sitting in pcplist are not counted
> as NR_FREE_PAGES, so watermark checks will not "see" them as available. That
> would be true for both local and remote nodes as we process the zonelist,
> but if pages are stuck on remote pcplists, it could make the problem worse
> than if they stayed only in local ones.
> 
> But the good news should be that for this series you shouldn't actually need
> this patch, AFAIU. Last year Mel did the "Drain remote per-cpu directly"
> series and followups, so remote draining of pcplists is today done without
> sending an IPI to the remote CPU.

Vlastimil,

Sent -v5 which should address the concerns regarding pages stuck on
remote pcplists. Let me know if you have other concerns.

> BTW I kinda like the implementation that relies on "per-cpu spin lock"
> that's used mostly locally thus uncontended, and only rarely remotely. Much
> simpler than complicated cmpxchg schemes, wonder if those are really still
> such a win these days, e.g. in SLUB or here in vmstat...

Good question (to which i don't know the answer).

Thanks.

> > For reference, the original commit which introduces remote node
> > draining is 4037d452202e34214e8a939fa5621b2b3bbb45b7.
> > 
> > Acked-by: David Hildenbrand <david@redhat.com>
> > Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> > 
> > Index: linux-vmstat-remote/include/linux/mmzone.h
> > ===================================================================
> > --- linux-vmstat-remote.orig/include/linux/mmzone.h
> > +++ linux-vmstat-remote/include/linux/mmzone.h
> > @@ -679,9 +679,6 @@ struct per_cpu_pages {
> >  	int high;		/* high watermark, emptying needed */
> >  	int batch;		/* chunk size for buddy add/remove */
> >  	short free_factor;	/* batch scaling factor during free */
> > -#ifdef CONFIG_NUMA
> > -	short expire;		/* When 0, remote pagesets are drained */
> > -#endif
> >  
> >  	/* Lists of pages, one per migrate type stored on the pcp-lists */
> >  	struct list_head lists[NR_PCP_LISTS];
> > Index: linux-vmstat-remote/mm/vmstat.c
> > ===================================================================
> > --- linux-vmstat-remote.orig/mm/vmstat.c
> > +++ linux-vmstat-remote/mm/vmstat.c
> > @@ -803,20 +803,16 @@ static int fold_diff(int *zone_diff, int
> >   *
> >   * The function returns the number of global counters updated.
> >   */
> > -static int refresh_cpu_vm_stats(bool do_pagesets)
> > +static int refresh_cpu_vm_stats(void)
> >  {
> >  	struct pglist_data *pgdat;
> >  	struct zone *zone;
> >  	int i;
> >  	int global_zone_diff[NR_VM_ZONE_STAT_ITEMS] = { 0, };
> >  	int global_node_diff[NR_VM_NODE_STAT_ITEMS] = { 0, };
> > -	int changes = 0;
> >  
> >  	for_each_populated_zone(zone) {
> >  		struct per_cpu_zonestat __percpu *pzstats = zone->per_cpu_zonestats;
> > -#ifdef CONFIG_NUMA
> > -		struct per_cpu_pages __percpu *pcp = zone->per_cpu_pageset;
> > -#endif
> >  
> >  		for (i = 0; i < NR_VM_ZONE_STAT_ITEMS; i++) {
> >  			int v;
> > @@ -826,44 +822,8 @@ static int refresh_cpu_vm_stats(bool do_
> >  
> >  				atomic_long_add(v, &zone->vm_stat[i]);
> >  				global_zone_diff[i] += v;
> > -#ifdef CONFIG_NUMA
> > -				/* 3 seconds idle till flush */
> > -				__this_cpu_write(pcp->expire, 3);
> > -#endif
> >  			}
> >  		}
> > -#ifdef CONFIG_NUMA
> > -
> > -		if (do_pagesets) {
> > -			cond_resched();
> > -			/*
> > -			 * Deal with draining the remote pageset of this
> > -			 * processor
> > -			 *
> > -			 * Check if there are pages remaining in this pageset
> > -			 * if not then there is nothing to expire.
> > -			 */
> > -			if (!__this_cpu_read(pcp->expire) ||
> > -			       !__this_cpu_read(pcp->count))
> > -				continue;
> > -
> > -			/*
> > -			 * We never drain zones local to this processor.
> > -			 */
> > -			if (zone_to_nid(zone) == numa_node_id()) {
> > -				__this_cpu_write(pcp->expire, 0);
> > -				continue;
> > -			}
> > -
> > -			if (__this_cpu_dec_return(pcp->expire))
> > -				continue;
> > -
> > -			if (__this_cpu_read(pcp->count)) {
> > -				drain_zone_pages(zone, this_cpu_ptr(pcp));
> > -				changes++;
> > -			}
> > -		}
> > -#endif
> >  	}
> >  
> >  	for_each_online_pgdat(pgdat) {
> > @@ -880,8 +840,7 @@ static int refresh_cpu_vm_stats(bool do_
> >  		}
> >  	}
> >  
> > -	changes += fold_diff(global_zone_diff, global_node_diff);
> > -	return changes;
> > +	return fold_diff(global_zone_diff, global_node_diff);
> >  }
> >  
> >  /*
> > @@ -1867,7 +1826,7 @@ int sysctl_stat_interval __read_mostly =
> >  #ifdef CONFIG_PROC_FS
> >  static void refresh_vm_stats(struct work_struct *work)
> >  {
> > -	refresh_cpu_vm_stats(true);
> > +	refresh_cpu_vm_stats();
> >  }
> >  
> >  int vmstat_refresh(struct ctl_table *table, int write,
> > @@ -1877,6 +1836,8 @@ int vmstat_refresh(struct ctl_table *tab
> >  	int err;
> >  	int i;
> >  
> > +	drain_all_pages(NULL);
> > +
> >  	/*
> >  	 * The regular update, every sysctl_stat_interval, may come later
> >  	 * than expected: leaving a significant amount in per_cpu buckets.
> > @@ -1931,7 +1892,7 @@ int vmstat_refresh(struct ctl_table *tab
> >  
> >  static void vmstat_update(struct work_struct *w)
> >  {
> > -	if (refresh_cpu_vm_stats(true)) {
> > +	if (refresh_cpu_vm_stats()) {
> >  		/*
> >  		 * Counters were updated so we expect more updates
> >  		 * to occur in the future. Keep on running the
> > @@ -1994,7 +1955,7 @@ void quiet_vmstat(void)
> >  	 * it would be too expensive from this path.
> >  	 * vmstat_shepherd will take care about that for us.
> >  	 */
> > -	refresh_cpu_vm_stats(false);
> > +	refresh_cpu_vm_stats();
> >  }
> >  
> >  /*
> > Index: linux-vmstat-remote/mm/page_alloc.c
> > ===================================================================
> > --- linux-vmstat-remote.orig/mm/page_alloc.c
> > +++ linux-vmstat-remote/mm/page_alloc.c
> > @@ -3176,26 +3176,6 @@ static int rmqueue_bulk(struct zone *zon
> >  	return allocated;
> >  }
> >  
> > -#ifdef CONFIG_NUMA
> > -/*
> > - * Called from the vmstat counter updater to drain pagesets of this
> > - * currently executing processor on remote nodes after they have
> > - * expired.
> > - */
> > -void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp)
> > -{
> > -	int to_drain, batch;
> > -
> > -	batch = READ_ONCE(pcp->batch);
> > -	to_drain = min(pcp->count, batch);
> > -	if (to_drain > 0) {
> > -		spin_lock(&pcp->lock);
> > -		free_pcppages_bulk(zone, to_drain, pcp, 0);
> > -		spin_unlock(&pcp->lock);
> > -	}
> > -}
> > -#endif
> > -
> >  /*
> >   * Drain pcplists of the indicated processor and zone.
> >   */
> > 
> > 
> > 
> 
> 
> 

