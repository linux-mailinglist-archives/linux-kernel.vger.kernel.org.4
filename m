Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 128AB6E40E2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 09:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjDQH2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 03:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjDQH2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 03:28:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6E530C6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 00:28:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1267421A46;
        Mon, 17 Apr 2023 07:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681716478; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WQ1R4sZvD1Du39W5RTulU4BAsSwlbCyckcS5wsqWjl0=;
        b=cfmkvv25zNgiKJq6AOdiBFoS6/TgJZACH3uGf2koIfOprJcCsuoLLV0HQL0hBoxJHFnrj4
        JhhUUCt3syIwh5rDFn9emXtzTcvLrswa+Hd7O3/+uoJDiG06YdFZ6JWg+VD7gm7de3uyvZ
        Kfi2fJIbdrIGWb3Fp9gaRFdM7YcnxFE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681716478;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WQ1R4sZvD1Du39W5RTulU4BAsSwlbCyckcS5wsqWjl0=;
        b=W5QLXKEq944ybE5GqdoMHBrt5hoebhZ4R2faxEs0VUmc3AZtYnUlHdyv4am9DA5OqruYDn
        AqsN6BiKHXsNMhDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E62B013319;
        Mon, 17 Apr 2023 07:27:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0DwyN/30PGRQIAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 17 Apr 2023 07:27:57 +0000
Message-ID: <d3db48f8-779c-f990-a5e3-c720b8bcabdb@suse.cz>
Date:   Mon, 17 Apr 2023 09:27:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] lib/show_mem.c: Use for_each_populated_zone() simplify
 code
Content-Language: en-US
To:     Yajun Deng <yajun.deng@linux.dev>, hannes@cmpxchg.org,
        mhocko@suse.com, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
References: <20230417035226.4013584-1-yajun.deng@linux.dev>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230417035226.4013584-1-yajun.deng@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/17/23 05:52, Yajun Deng wrote:
> The __show_mem() needs to iterate over all zones that have memory, we can
> simplify the code by using for_each_populated_zone().
> 
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

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

