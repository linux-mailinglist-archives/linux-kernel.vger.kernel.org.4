Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6522A725CFD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 13:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239378AbjFGLXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 07:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240066AbjFGLX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 07:23:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C8A1720
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 04:23:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A201B63394
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 11:23:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66A54C433EF;
        Wed,  7 Jun 2023 11:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686137005;
        bh=692XokvxKzDQrzsRY0aIK8Ow6Q63x8VkG9gKJSs7Pqc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l9jqMmOfxNpxEBRsiMWKN3ziafDCD5xZkky5cqz2nXO3S7wnqKxVyyWuJA7hIer7U
         COvHylReJPdxeFRNY+cmqpKZDl4N7F8jdVbnepnmtZi3eXUnJ4tH5zvBjPsb3vgtSr
         JaZm2x/A6ACFuWHgYGRjqUHgM2ESd3APsRK9mZh5nPBVYRT4VD1X/HnhA0WdFIjGAn
         Hgj7o6eWMn1y3J078IvIXo3cxFUAyhJG372oicTmwA1b9tM/oI1U0M+ZjFYCLPhzlC
         wKsVkXXA8L5zefMFTV4ZceZbVwiQVf0ZWN8pdGmcZoYuBOjgO8RT5Luf4qtOyhmO89
         MWOrQBAOssFpw==
Date:   Wed, 7 Jun 2023 14:23:00 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Haifeng Xu <haifeng.xu@shopee.com>
Cc:     david@redhat.com, mhocko@kernel.org, osalvador@suse.de,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm/memory_hotplug: remove
 reset_node_managed_pages() in hotadd_init_pgdat()
Message-ID: <20230607112300.GF52412@kernel.org>
References: <f125f0db-30fe-5452-4669-3e48f7856569@redhat.com>
 <20230607024548.1240-1-haifeng.xu@shopee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607024548.1240-1-haifeng.xu@shopee.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 02:45:48AM +0000, Haifeng Xu wrote:
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

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

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
> 

-- 
Sincerely yours,
Mike.
