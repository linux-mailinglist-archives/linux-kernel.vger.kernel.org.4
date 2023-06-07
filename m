Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77513725870
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 10:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239359AbjFGIse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 04:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237815AbjFGIsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 04:48:32 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBAF11F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 01:48:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E33B41FDAA;
        Wed,  7 Jun 2023 08:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686127709; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4nuQ9zLS68BCE4lTKPyHUGHAuv4TPfQjF/DOF3031s0=;
        b=T0FTkw8Y/YEC/IL1O4BJBomDGULhPsbWtQZAwyLk+kag29HOqfG+K3r4mmcFlVMt7CziyY
        3qhQO+ZWFqp89VxMDO5hoQzJlW6DJGEA0q69uIy7NPG2d76PHMc4q+Q69aEmkGrGmetIJZ
        MI21lemIIQo8muMfUz41Y7kBONpGTjI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D5E2E1346D;
        Wed,  7 Jun 2023 08:48:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id f3h9M11EgGSqSQAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 07 Jun 2023 08:48:29 +0000
Date:   Wed, 7 Jun 2023 10:48:29 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Haifeng Xu <haifeng.xu@shopee.com>
Cc:     rppt@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mm_init.c: drop 'nid' parameter from
 check_for_memory()
Message-ID: <ZIBEXbRrcHNRl5D7@dhcp22.suse.cz>
References: <20230607032402.4679-1-haifeng.xu@shopee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607032402.4679-1-haifeng.xu@shopee.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 07-06-23 03:24:02, Haifeng Xu wrote:
> The node_id in pgdat has already been set in free_area_init_node(),
> so use it internally instead of passing a redundant parameter.

Yes and this even improves the code because having both pgdat and nid
arguments is confusing and can be error prone because those might
mismatch and we would end up allocating from a different node in the
end.

> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/mm_init.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index b82718d596c3..78e67041ae9f 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -1725,7 +1725,7 @@ static void __init free_area_init_node(int nid)
>  }
>  
>  /* Any regular or high memory on that node ? */
> -static void check_for_memory(pg_data_t *pgdat, int nid)
> +static void check_for_memory(pg_data_t *pgdat)
>  {
>  	enum zone_type zone_type;
>  
> @@ -1733,9 +1733,9 @@ static void check_for_memory(pg_data_t *pgdat, int nid)
>  		struct zone *zone = &pgdat->node_zones[zone_type];
>  		if (populated_zone(zone)) {
>  			if (IS_ENABLED(CONFIG_HIGHMEM))
> -				node_set_state(nid, N_HIGH_MEMORY);
> +				node_set_state(pgdat->node_id, N_HIGH_MEMORY);
>  			if (zone_type <= ZONE_NORMAL)
> -				node_set_state(nid, N_NORMAL_MEMORY);
> +				node_set_state(pgdat->node_id, N_NORMAL_MEMORY);
>  			break;
>  		}
>  	}
> @@ -1887,7 +1887,7 @@ void __init free_area_init(unsigned long *max_zone_pfn)
>  		/* Any memory on that node */
>  		if (pgdat->node_present_pages)
>  			node_set_state(nid, N_MEMORY);
> -		check_for_memory(pgdat, nid);
> +		check_for_memory(pgdat);
>  	}
>  
>  	memmap_init();
> -- 
> 2.25.1

-- 
Michal Hocko
SUSE Labs
