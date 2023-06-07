Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E744725470
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 08:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235185AbjFGGj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 02:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234201AbjFGGj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 02:39:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06DA10C3
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 23:39:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47E19633F8
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 06:39:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B7ABC433D2;
        Wed,  7 Jun 2023 06:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686119964;
        bh=UISjTsiRCRSInrIvyE5FgvbQwpHYWJ7g5Pd31zSUVG0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jezxN5vpNEgL7CI2kIWk6axf3PVPFkgG1cIa9UUJMUVFVal2nYT32BrYB3FgdMuG1
         nVMzp3rhutYuE6ulNHctoUgD8XIbduiHHthQ9f7HGdicY0/5BKcwsmUGxkIZ05YyfR
         kbaQ9QoMg+IkTzKPXDcJU1MvG5JyVmiSGdgR/T2ZeYd2EgZdDmXp8w00FOl8opKf3F
         bNYKyGgsFcboLNW+6v+wWS6W5e45fxb6udpRtblYQrKNz5RW9ChPggk27Ghe5RCf8Q
         IZna0cP1/0brHZ+dHOAAs9oJGa5xVI4fHNs6SSJB2ueQSJyUvK270mz3f5q0YJ57ix
         HpmwPcLZWTTsA==
Date:   Wed, 7 Jun 2023 09:39:00 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Haifeng Xu <haifeng.xu@shopee.com>
Cc:     mhocko@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mm_init.c: drop 'nid' parameter from
 check_for_memory()
Message-ID: <20230607063900.GD52412@kernel.org>
References: <20230607032402.4679-1-haifeng.xu@shopee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607032402.4679-1-haifeng.xu@shopee.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 03:24:02AM +0000, Haifeng Xu wrote:
> The node_id in pgdat has already been set in free_area_init_node(),
> so use it internally instead of passing a redundant parameter.
> 
> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

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
> 

-- 
Sincerely yours,
Mike.
