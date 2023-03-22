Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810EA6C4E82
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjCVOvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjCVOvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:51:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6F316AD6;
        Wed, 22 Mar 2023 07:49:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B0F8B20EDA;
        Wed, 22 Mar 2023 14:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679496564; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WStsIEd2k7RdaTJPjgss3dQsnOiCKbIVzQh6g0XMjJw=;
        b=keua6vrzqFvD9d24VxKeN+P/9uXoYODOqtrErIG/mFeIbZVehzKEskAJmBFCi0Y8xj7WKJ
        pmcGiXtk38EgR4HUZMpxbVMjRpbT/7Vrs/+Ks0XGUOUlTjb50+aaMtBeacMHGQzY1kN1mf
        FM6J86xeBjnsaz6TLcApLK3UK5S0+us=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679496564;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WStsIEd2k7RdaTJPjgss3dQsnOiCKbIVzQh6g0XMjJw=;
        b=XDCCaVhwYzaOWYZn/gP36NSxpReGq7etaOQhGQ5VLmoob+pUe/n+MnmvWWMlCIgQIM3z77
        KSRc22i5edVyCsBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 806FB138E9;
        Wed, 22 Mar 2023 14:49:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OzqNHnQVG2RpNQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 22 Mar 2023 14:49:24 +0000
Message-ID: <ed44b114-36f3-1ca6-726d-5187314aea49@suse.cz>
Date:   Wed, 22 Mar 2023 15:49:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 04/14] mm: handle hashdist initialization in
 mm/mm_init.c
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Doug Berger <opendmb@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-mm@kvack.org
References: <20230321170513.2401534-1-rppt@kernel.org>
 <20230321170513.2401534-5-rppt@kernel.org>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230321170513.2401534-5-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/21/23 18:05, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> 
> The hashdist variable must be initialized before the first call to
> alloc_large_system_hash() and free_area_init() looks like a better place
> for it than page_alloc_init().
> 
> Move hashdist handling to mm/mm_init.c
> 
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> Acked-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Looks like this will move the fixup_hashdist() call earlier, but can't
result in seeing less N_MEMORY nodes than before, right?
I wonder if the whole thing lacks hotplug support anyway, what if system
boots with one node and more are added later? Hmm.

> ---
>  mm/mm_init.c    | 22 ++++++++++++++++++++++
>  mm/page_alloc.c | 18 ------------------
>  2 files changed, 22 insertions(+), 18 deletions(-)
> 
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 68d0187c7886..2e60c7186132 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -607,6 +607,25 @@ int __meminit early_pfn_to_nid(unsigned long pfn)
>  
>  	return nid;
>  }
> +
> +int hashdist = HASHDIST_DEFAULT;
> +
> +static int __init set_hashdist(char *str)
> +{
> +	if (!str)
> +		return 0;
> +	hashdist = simple_strtoul(str, &str, 0);
> +	return 1;
> +}
> +__setup("hashdist=", set_hashdist);
> +
> +static inline void fixup_hashdist(void)
> +{
> +	if (num_node_state(N_MEMORY) == 1)
> +		hashdist = 0;
> +}
> +#else
> +static inline void fixup_hashdist(void) {}
>  #endif /* CONFIG_NUMA */
>  
>  #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
> @@ -1855,6 +1874,9 @@ void __init free_area_init(unsigned long *max_zone_pfn)
>  	}
>  
>  	memmap_init();
> +
> +	/* disable hash distribution for systems with a single node */
> +	fixup_hashdist();
>  }
>  
>  /**
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index c56c147bdf27..ff6a2fff2880 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6383,28 +6383,10 @@ static int page_alloc_cpu_online(unsigned int cpu)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_NUMA
> -int hashdist = HASHDIST_DEFAULT;
> -
> -static int __init set_hashdist(char *str)
> -{
> -	if (!str)
> -		return 0;
> -	hashdist = simple_strtoul(str, &str, 0);
> -	return 1;
> -}
> -__setup("hashdist=", set_hashdist);
> -#endif
> -
>  void __init page_alloc_init(void)
>  {
>  	int ret;
>  
> -#ifdef CONFIG_NUMA
> -	if (num_node_state(N_MEMORY) == 1)
> -		hashdist = 0;
> -#endif
> -
>  	ret = cpuhp_setup_state_nocalls(CPUHP_PAGE_ALLOC,
>  					"mm/page_alloc:pcp",
>  					page_alloc_cpu_online,

