Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F55B725B95
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 12:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238259AbjFGK1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 06:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233580AbjFGK1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 06:27:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C2D1BDA
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 03:27:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E6AFD219BF;
        Wed,  7 Jun 2023 10:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686133649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RcOzZrJWhoRnq3UjVu8IiEmZ1f/byTB2AbKHvJfMDX0=;
        b=rAi77/t94BXnu7pScTCKfbW5WjP5hkGGTuIgJrP2zFYfjopIP0nkfdiWlea1f4JBZQQyRx
        1VNxxfeR/0xx4ssCCkop5/XaNvdXf58l5X3Qa4Ykr9kT2UNZhyjNhuPAIWet+G7efEAxpP
        +nK331TAkSdzV8e6WjToYtIoEMzEVVE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D4D171346D;
        Wed,  7 Jun 2023 10:27:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JMHNMpFbgGTafwAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 07 Jun 2023 10:27:29 +0000
Date:   Wed, 7 Jun 2023 12:27:29 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Haifeng Xu <haifeng.xu@shopee.com>
Cc:     david@redhat.com, rppt@kernel.org, osalvador@suse.de,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm/memory_hotplug: remove
 reset_node_managed_pages() in hotadd_init_pgdat()
Message-ID: <ZIBbkULCQ8qEYrMG@dhcp22.suse.cz>
References: <f125f0db-30fe-5452-4669-3e48f7856569@redhat.com>
 <20230607024548.1240-1-haifeng.xu@shopee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607024548.1240-1-haifeng.xu@shopee.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 07-06-23 02:45:48, Haifeng Xu wrote:
> managed pages has already been set to 0 in free_area_init_core_hotplug(),
> via zone_init_internals() on each zone. It's pointless to reset again.
> 
> Furthermore, reset_node_managed_pages() no longer needs to be exposed
> outside of mm/memblock.c. Remove declaration in include/linux/memblock.h
> and define it as static.
> 
> In addtion to this, the only caller of reset_node_managed_pages() is
> reset_all_zones_managed_pages(), which is annotated with __init, so it
> should be safe to also mark reset_node_managed_pages() as __init.
> 
> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
> Suggested-by: David Hildenbrand <david@redhat.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
> v2:
> - unexport reset_node_managed_pages()
> - mark reset_node_managed_pages() as __init
> - update commit message
> ---
>  include/linux/memblock.h | 1 -
>  mm/memblock.c            | 2 +-
>  mm/memory_hotplug.c      | 1 -
>  3 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index f82ee3fac1cd..f71ff9f0ec81 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -128,7 +128,6 @@ int memblock_clear_nomap(phys_addr_t base, phys_addr_t size);
>  
>  void memblock_free_all(void);
>  void memblock_free(void *ptr, size_t size);
> -void reset_node_managed_pages(pg_data_t *pgdat);
>  void reset_all_zones_managed_pages(void);
>  
>  /* Low level functions */
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 3feafea06ab2..da4264528e1e 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -2122,7 +2122,7 @@ static unsigned long __init free_low_memory_core_early(void)
>  
>  static int reset_managed_pages_done __initdata;
>  
> -void reset_node_managed_pages(pg_data_t *pgdat)
> +static void __init reset_node_managed_pages(pg_data_t *pgdat)
>  {
>  	struct zone *z;
>  
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 8e0fa209d533..65e385f34679 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1210,7 +1210,6 @@ static pg_data_t __ref *hotadd_init_pgdat(int nid)
>  	 * online_pages() and offline_pages().
>  	 * TODO: should be in free_area_init_core_hotplug?
>  	 */
> -	reset_node_managed_pages(pgdat);
>  	reset_node_present_pages(pgdat);
>  
>  	return pgdat;
> -- 
> 2.25.1

-- 
Michal Hocko
SUSE Labs
