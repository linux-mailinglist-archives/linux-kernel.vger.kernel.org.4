Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6A467AB48
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 09:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234864AbjAYIEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 03:04:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234079AbjAYIET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 03:04:19 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A463F2BE
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 00:04:18 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1F0F21FEC6;
        Wed, 25 Jan 2023 08:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1674633857; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w2zAQ050thACMQf74nb0AbuOfBM8Mh5wKq9lwzEQNQw=;
        b=DlzVb5eUU8M4wLQzumk5AyLWTYfdboA/monTb0IeANtflQLNGnZ2obikPjkEhcGzpxGvSm
        yZBszOmsbJbQlelQMdM3pyF4nXZunqQPczHfum5kXe7DUE3q2Bt2ppWiDwD5etOset4Uu2
        1EA4TfxnNz6dVqXfIx8NrFR2tCIOczo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F34641358F;
        Wed, 25 Jan 2023 08:04:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BatMOYDi0GNiawAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 25 Jan 2023 08:04:16 +0000
Date:   Wed, 25 Jan 2023 09:04:16 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mm/madvise: add vmstat statistics for
 madvise_[cold|pageout]
Message-ID: <Y9DigKf0w712t0OO@dhcp22.suse.cz>
References: <20230125005457.4139289-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125005457.4139289-1-minchan@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 24-01-23 16:54:57, Minchan Kim wrote:
> madvise LRU manipulation APIs need to scan address ranges to find
> present pages at page table and provides advice hints for them.
> 
> Likewise pg[scan/steal] count on vmstat, madvise_pg[scanned/hinted]
> shows the proactive reclaim efficiency so this patch adds those
> two statistics in vmstat.
> 
> 	madvise_pgscanned, madvise_pghinted
> 
> Since proactive reclaim using process_madvise(2) as userland
> memory policy is popular(e.g,. Android ActivityManagerService),
> those stats are helpful to know how efficiently the policy works
> well.

The usecase description is still too vague. What are those values useful
for? Is there anything actionable based on those numbers? How do you
deal with multiple parties using madvise resp. process_madvise so that
their stats are combined?

In the previous version I have also pointed out that this might be
easily achieved by tracepoints. Your counterargument was a convenience
in a large scale monitoring without going much into details. Presumably
this is because your fleet based monitoring already collects
/proc/vmstat while tracepoints based monitoring would require additional
changes. This alone is rather weak argument to be honest because
deploying tracepoints monitoring is quite trivial and can be done
outside of the said memory reclaim agent.

> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---
> 
> * From v1 - https://lore.kernel.org/linux-mm/20230117231632.2734737-1-minchan@kernel.org/
>   * not relying on the pageout for accounting - mhocko
>   * drop unnecessary changes - mhocko
>   
>  include/linux/vm_event_item.h | 2 ++
>  mm/madvise.c                  | 8 ++++++++
>  mm/vmstat.c                   | 2 ++
>  3 files changed, 12 insertions(+)
> 
> diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
> index 7f5d1caf5890..3c117858946d 100644
> --- a/include/linux/vm_event_item.h
> +++ b/include/linux/vm_event_item.h
> @@ -52,6 +52,8 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
>  		PGSCAN_FILE,
>  		PGSTEAL_ANON,
>  		PGSTEAL_FILE,
> +		MADVISE_PGSCANNED,
> +		MADVISE_PGHINTED,
>  #ifdef CONFIG_NUMA
>  		PGSCAN_ZONE_RECLAIM_FAILED,
>  #endif
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 7db6622f8293..d2624e77f729 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -344,6 +344,8 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>  	spinlock_t *ptl;
>  	struct folio *folio = NULL;
>  	LIST_HEAD(folio_list);
> +	unsigned int nr_scanned = 0;
> +	unsigned int nr_hinted = 0;
>  	bool pageout_anon_only_filter;
>  
>  	if (fatal_signal_pending(current))
> @@ -357,6 +359,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>  		pmd_t orig_pmd;
>  		unsigned long next = pmd_addr_end(addr, end);
>  
> +		nr_scanned += HPAGE_PMD_NR;
>  		tlb_change_page_size(tlb, HPAGE_PMD_SIZE);
>  		ptl = pmd_trans_huge_lock(pmd, vma);
>  		if (!ptl)
> @@ -414,6 +417,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>  			}
>  		} else
>  			folio_deactivate(folio);
> +		nr_hinted += HPAGE_PMD_NR;
>  huge_unlock:
>  		spin_unlock(ptl);
>  		if (pageout)
> @@ -431,6 +435,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>  	arch_enter_lazy_mmu_mode();
>  	for (; addr < end; pte++, addr += PAGE_SIZE) {
>  		ptent = *pte;
> +		nr_scanned++;
>  
>  		if (pte_none(ptent))
>  			continue;
> @@ -508,6 +513,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>  			}
>  		} else
>  			folio_deactivate(folio);
> +		nr_hinted++;
>  	}
>  
>  	arch_leave_lazy_mmu_mode();
> @@ -515,6 +521,8 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>  	if (pageout)
>  		reclaim_pages(&folio_list);
>  	cond_resched();
> +	count_vm_events(MADVISE_PGSCANNED, nr_scanned);
> +	count_vm_events(MADVISE_PGHINTED, nr_hinted);
>  
>  	return 0;
>  }
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 1ea6a5ce1c41..84acc90820e1 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1283,6 +1283,8 @@ const char * const vmstat_text[] = {
>  	"pgscan_file",
>  	"pgsteal_anon",
>  	"pgsteal_file",
> +	"madvise_pgscanned",
> +	"madvise_pghinted",
>  
>  #ifdef CONFIG_NUMA
>  	"zone_reclaim_failed",
> -- 
> 2.39.1.405.gd4c25cc71f-goog

-- 
Michal Hocko
SUSE Labs
