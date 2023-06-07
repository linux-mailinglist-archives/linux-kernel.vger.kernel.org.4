Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC7D725BAB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 12:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239230AbjFGKdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 06:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234423AbjFGKdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 06:33:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8E5EA
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 03:33:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 486C0219F7;
        Wed,  7 Jun 2023 10:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686134015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2GQDwm9XkXFV1nznF3vSR6+NBAxeeNTuAQMVtcoe+2I=;
        b=I1TTb94ckPTKnPVhzz6RBMCKJSPvHt55awTKzeRhsiiJDlx93lQ76y3oJSKU86F9H99TeM
        aqYhiPKTXEfFpzgE8oZxI8WTbWx52u86xBIlDGnO4CH0F3rgh17wJj2xDZTJVOhrX7imTw
        4q7a7mP8wNqHfZb38UIR6VTvXLzLByU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 349971346D;
        Wed,  7 Jun 2023 10:33:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id H1IxDP9cgGR/BAAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 07 Jun 2023 10:33:35 +0000
Date:   Wed, 7 Jun 2023 12:33:34 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Haifeng Xu <haifeng.xu@shopee.com>
Cc:     david@redhat.com, rppt@kernel.org, osalvador@suse.de,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mm/mm_init.c: remove reset_node_present_pages()
Message-ID: <ZIBc/tgaKsPYU5CT@dhcp22.suse.cz>
References: <d92273f6-28be-dc37-3ca5-a9579a75f8c4@redhat.com>
 <20230607025056.1348-1-haifeng.xu@shopee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607025056.1348-1-haifeng.xu@shopee.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 07-06-23 02:50:56, Haifeng Xu wrote:
> reset_node_present_pages() only get called in hotadd_init_pgdat(), move
> the action that clear present pages to free_area_init_core_hotplug(), so
> the helper can be removed.

There is no explanation why moving the action is desirable and/or
needed. I do agree that removing this trivial helper which only has a
single caller. I guess the incentive is an overal simplification but
please spell that out.

> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
> Suggested-by: David Hildenbrand <david@redhat.com>

The patch itself makes sense
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
> v2:
> - declare 'struct zone' within the for loop
> - fix comment layout
> ---
>  mm/memory_hotplug.c | 18 ------------------
>  mm/mm_init.c        | 15 +++++++++++++--
>  2 files changed, 13 insertions(+), 20 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 65e385f34679..ee1c0d9a4d5a 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1172,16 +1172,6 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
>  	return ret;
>  }
>  
> -static void reset_node_present_pages(pg_data_t *pgdat)
> -{
> -	struct zone *z;
> -
> -	for (z = pgdat->node_zones; z < pgdat->node_zones + MAX_NR_ZONES; z++)
> -		z->present_pages = 0;
> -
> -	pgdat->node_present_pages = 0;
> -}
> -
>  /* we are OK calling __meminit stuff here - we have CONFIG_MEMORY_HOTPLUG */
>  static pg_data_t __ref *hotadd_init_pgdat(int nid)
>  {
> @@ -1204,14 +1194,6 @@ static pg_data_t __ref *hotadd_init_pgdat(int nid)
>  	 */
>  	build_all_zonelists(pgdat);
>  
> -	/*
> -	 * When memory is hot-added, all the memory is in offline state. So
> -	 * clear all zones' present_pages because they will be updated in
> -	 * online_pages() and offline_pages().
> -	 * TODO: should be in free_area_init_core_hotplug?
> -	 */
> -	reset_node_present_pages(pgdat);
> -
>  	return pgdat;
>  }
>  
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 78e67041ae9f..a02ba9a79b3d 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -1507,6 +1507,8 @@ void __ref free_area_init_core_hotplug(struct pglist_data *pgdat)
>  	pgdat->kswapd_order = 0;
>  	pgdat->kswapd_highest_zoneidx = 0;
>  	pgdat->node_start_pfn = 0;
> +	pgdat->node_present_pages = 0;
> +
>  	for_each_online_cpu(cpu) {
>  		struct per_cpu_nodestat *p;
>  
> @@ -1514,8 +1516,17 @@ void __ref free_area_init_core_hotplug(struct pglist_data *pgdat)
>  		memset(p, 0, sizeof(*p));
>  	}
>  
> -	for (z = 0; z < MAX_NR_ZONES; z++)
> -		zone_init_internals(&pgdat->node_zones[z], z, nid, 0);
> +	/*
> +	 * When memory is hot-added, all the memory is in offline state. So
> +	 * clear all zones' present_pages and managed_pages because they will
> +	 * be updated in online_pages() and offline_pages().
> +	 */
> +	for (z = 0; z < MAX_NR_ZONES; z++) {
> +		struct zone *zone = pgdat->node_zones + z;
> +
> +		zone->present_pages = 0;
> +		zone_init_internals(zone, z, nid, 0);
> +	}
>  }
>  #endif
>  
> -- 
> 2.25.1

-- 
Michal Hocko
SUSE Labs
