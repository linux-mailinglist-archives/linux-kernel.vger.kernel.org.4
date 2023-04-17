Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4326B6E419E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 09:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjDQHwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 03:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjDQHwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 03:52:51 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98CAF2D53
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 00:52:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4976F1F38D;
        Mon, 17 Apr 2023 07:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1681717967; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=942hx6BheCF77inT2+ijNDFupXE1Y+/wnPGlQXaujts=;
        b=oJqGLYLmTe0xOow/vToL1CjqFZrdKCjx7q8UhMUMxLbNVtym1YiAnPNw53zQXmPbhRbnso
        PWMjnLMuT8feuqFtGN6IN2bSlHxh9jFacP7IAjhCfymeDwmOtzU+cAk1SdMnEyAP4zB4X+
        8e7Sw6FmpXzYCndx0P9Yhcmwxew87kg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 20E5E1390E;
        Mon, 17 Apr 2023 07:52:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WTaABM/6PGSjLQAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 17 Apr 2023 07:52:47 +0000
Date:   Mon, 17 Apr 2023 09:52:46 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     hannes@cmpxchg.org, vbabka@suse.cz, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/show_mem.c: Use for_each_populated_zone() simplify
 code
Message-ID: <ZDz6znEFRp6JwvVN@dhcp22.suse.cz>
References: <20230417035226.4013584-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230417035226.4013584-1-yajun.deng@linux.dev>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 17-04-23 11:52:26, Yajun Deng wrote:
> The __show_mem() needs to iterate over all zones that have memory, we can
> simplify the code by using for_each_populated_zone().
> 
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>

Acked-by: Michal Hocko <mhocko@suse.com>
Thanks!

> ---
>  lib/show_mem.c | 19 ++++++-------------
>  1 file changed, 6 insertions(+), 13 deletions(-)
> 
> diff --git a/lib/show_mem.c b/lib/show_mem.c
> index 0d7585cde2a6..1485c87be935 100644
> --- a/lib/show_mem.c
> +++ b/lib/show_mem.c
> @@ -10,26 +10,19 @@
>  
>  void __show_mem(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
>  {
> -	pg_data_t *pgdat;
>  	unsigned long total = 0, reserved = 0, highmem = 0;
> +	struct zone *zone;
>  
>  	printk("Mem-Info:\n");
>  	__show_free_areas(filter, nodemask, max_zone_idx);
>  
> -	for_each_online_pgdat(pgdat) {
> -		int zoneid;
> +	for_each_populated_zone(zone) {
>  
> -		for (zoneid = 0; zoneid < MAX_NR_ZONES; zoneid++) {
> -			struct zone *zone = &pgdat->node_zones[zoneid];
> -			if (!populated_zone(zone))
> -				continue;
> +		total += zone->present_pages;
> +		reserved += zone->present_pages - zone_managed_pages(zone);
>  
> -			total += zone->present_pages;
> -			reserved += zone->present_pages - zone_managed_pages(zone);
> -
> -			if (is_highmem_idx(zoneid))
> -				highmem += zone->present_pages;
> -		}
> +		if (is_highmem(zone))
> +			highmem += zone->present_pages;
>  	}
>  
>  	printk("%lu pages RAM\n", total);
> -- 
> 2.25.1

-- 
Michal Hocko
SUSE Labs
