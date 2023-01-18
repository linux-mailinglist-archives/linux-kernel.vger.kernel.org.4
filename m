Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D50A667136F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 06:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjARF5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 00:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjARFyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 00:54:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FB35421B
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 21:53:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98A9C61633
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 05:53:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73B85C433EF;
        Wed, 18 Jan 2023 05:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674021225;
        bh=Li0EPMHtSKQ7wkJMyWtwCEqB+BQ3FhQiHQm1YGZAm0g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LP7iYAc68vJ7CcKxOti6Tiv/s+840HikPidjdAwxKpYBkpZd0BWIBTNb4B+odqgGN
         TQZHAxW0MeTrpejtn6CqQeZXjy+y6HOHxNU8W4e2Id1lbaD0mxP/J8uCegqpPH6wWp
         etuqQXalH+jjMqf7MdzprNI+F6FVZLCf2UM5J02lkFmf2BXlkzGP1cuvmJknMLsv30
         gl2EQmp0Xnww9iEjSh7ACJZaWpJBcUV9VrfANpbwFdm6KSeYUPcbOLs5njPA5RBSnC
         TkIudFQwRjBZVqpaCkpgShlj8wf2Mg0Nf1YU/frrvGe6+XNdbbnIIEKtLFGWTLCx6t
         QprStRxqEI6lA==
Date:   Wed, 18 Jan 2023 07:53:32 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     akpm@linux-foundation.org, mhocko@suse.com, vbabka@suse.cz,
        david@redhat.com, quic_charante@quicinc.com,
        lizhe.67@bytedance.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v4] mm/page_ext: Do not allocate space for
 page_ext->flags if not needed
Message-ID: <Y8eJXOgKQfrmzeDi@kernel.org>
References: <20230117202103.1412449-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117202103.1412449-1-pasha.tatashin@soleen.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 08:21:03PM +0000, Pasha Tatashin wrote:
> There is 8 byte page_ext->flags field allocated per page whenever
> CONFIG_PAGE_EXTENSION is enabled. However, not every user of page_ext
> uses flags. Therefore, check whether flags is needed at least by one
> user and if so allocate space for it.
> 
> For example when page_table_check is enabled, on a machine with 128G
> of memory before the fix:
> 
> [    2.244288] allocated 536870912 bytes of page_ext
> after the fix:
> [    2.160154] allocated 268435456 bytes of page_ext
> 
> Also, add a kernel-doc comment before page_ext_operations that describes
> the fields, and remove check if need() is set, as that is now a required
> field.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Acked-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  include/linux/page_ext.h | 18 ++++++++++++++++++
>  mm/page_ext.c            | 14 ++++++++++++--
>  mm/page_owner.c          |  1 +
>  mm/page_table_check.c    |  1 +
>  4 files changed, 32 insertions(+), 2 deletions(-)
> 
> Changelog:
> v4: Addressed comments from Mike Rapoport, added Acked-by's.
> v3: Added comment before page_ext_operations, removed check if
>     need is null.
> v2: Fixed field name in page_owner.c that caused build error.
> 
> diff --git a/include/linux/page_ext.h b/include/linux/page_ext.h
> index 22be4582faae..67314f648aeb 100644
> --- a/include/linux/page_ext.h
> +++ b/include/linux/page_ext.h
> @@ -7,15 +7,33 @@
>  #include <linux/stackdepot.h>
>  
>  struct pglist_data;
> +
> +/**
> + * struct page_ext_operations - per page_ext client operations
> + * @offset: Offset to the client's data within page_ext. Offset is returned to
> + *          the client by page_ext_init.
> + * @size: The size of the client data within page_ext.
> + * @need: Function that returns true if client requires page_ext.
> + * @init: (optional) Called to initialize client once page_exts are allocated.
> + * @need_shared_flags: True when client is using shared page_ext->flags
> + *                     field.
> + *
> + * Each Page Extension client must define page_ext_operations in
> + * page_ext_ops array.
> + */
>  struct page_ext_operations {
>  	size_t offset;
>  	size_t size;
>  	bool (*need)(void);
>  	void (*init)(void);
> +	bool need_shared_flags;
>  };
>  
>  #ifdef CONFIG_PAGE_EXTENSION
>  
> +/*
> + * The page_ext_flags users must set need_shared_flags to true.
> + */
>  enum page_ext_flags {
>  	PAGE_EXT_OWNER,
>  	PAGE_EXT_OWNER_ALLOCATED,
> diff --git a/mm/page_ext.c b/mm/page_ext.c
> index 4ee522fd381c..e2c22ffdbb81 100644
> --- a/mm/page_ext.c
> +++ b/mm/page_ext.c
> @@ -71,6 +71,7 @@ static bool need_page_idle(void)
>  }
>  static struct page_ext_operations page_idle_ops __initdata = {
>  	.need = need_page_idle,
> +	.need_shared_flags = true,
>  };
>  #endif
>  
> @@ -86,7 +87,7 @@ static struct page_ext_operations *page_ext_ops[] __initdata = {
>  #endif
>  };
>  
> -unsigned long page_ext_size = sizeof(struct page_ext);
> +unsigned long page_ext_size;
>  
>  static unsigned long total_usage;
>  static struct page_ext *lookup_page_ext(const struct page *page);
> @@ -106,7 +107,16 @@ static bool __init invoke_need_callbacks(void)
>  	bool need = false;
>  
>  	for (i = 0; i < entries; i++) {
> -		if (page_ext_ops[i]->need && page_ext_ops[i]->need()) {
> +		if (page_ext_ops[i]->need()) {
> +			if (page_ext_ops[i]->need_shared_flags) {
> +				page_ext_size = sizeof(struct page_ext);
> +				break;
> +			}
> +		}
> +	}
> +
> +	for (i = 0; i < entries; i++) {
> +		if (page_ext_ops[i]->need()) {
>  			page_ext_ops[i]->offset = page_ext_size;
>  			page_ext_size += page_ext_ops[i]->size;
>  			need = true;
> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index 2d27f532df4c..f0553bedb39d 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -99,6 +99,7 @@ struct page_ext_operations page_owner_ops = {
>  	.size = sizeof(struct page_owner),
>  	.need = need_page_owner,
>  	.init = init_page_owner,
> +	.need_shared_flags = true,
>  };
>  
>  static inline struct page_owner *get_page_owner(struct page_ext *page_ext)
> diff --git a/mm/page_table_check.c b/mm/page_table_check.c
> index 93e633c1d587..25d8610c0042 100644
> --- a/mm/page_table_check.c
> +++ b/mm/page_table_check.c
> @@ -45,6 +45,7 @@ struct page_ext_operations page_table_check_ops = {
>  	.size = sizeof(struct page_table_check),
>  	.need = need_page_table_check,
>  	.init = init_page_table_check,
> +	.need_shared_flags = false,
>  };
>  
>  static struct page_table_check *get_page_table_check(struct page_ext *page_ext)
> -- 
> 2.39.0.314.g84b9a713c41-goog
> 

-- 
Sincerely yours,
Mike.
