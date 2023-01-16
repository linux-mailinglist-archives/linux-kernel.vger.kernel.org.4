Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E1466B9CA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 10:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbjAPJFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 04:05:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232491AbjAPJEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 04:04:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC85166E2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 01:01:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03B4160E84
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 09:01:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CF74C433EF;
        Mon, 16 Jan 2023 09:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673859661;
        bh=9bVcYyAmNQfF4Oyy4yApCgMyxztzFQv5/kHOxY7QRho=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J7cKanBnmSw7efZUH2ZUOOBpWOmVeEL2rxypmpb6+8ZLaoyUJGvSY1VQg0vG68Gsj
         zy/OSZr5mCeiwjE2zvXgWA8Ahfq52t0k/0oYmPpUMq30X6xQmmw8sTD3A+GLY8jwmc
         3c8xxriC2AtTyI8U0jCHasvRTf3R/mBTZuuiWFMP2nCw3dJ0ch3vOHbsxP6xB98oZP
         HEZokEKW3bSYYEq88XhiElMmiEGIG+VDFxBQipfWZJcOSeMmZoxdiGsrhI1lQW/wpM
         5KZJNlkr828mAn6YW5opjYHm7O9dgMUHI8+XAgTognOh28jCe5ycE+667VWtElIsOu
         t2EoASduivrlA==
Date:   Mon, 16 Jan 2023 11:00:48 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     akpm@linux-foundation.org, mhocko@suse.com, vbabka@suse.cz,
        david@redhat.com, quic_charante@quicinc.com,
        lizhe.67@bytedance.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v3] mm/page_ext: Do not allocate space for
 page_ext->flags if not needed
Message-ID: <Y8USQBPlMNTTIyIO@kernel.org>
References: <20230113154253.92480-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113154253.92480-1-pasha.tatashin@soleen.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 03:42:53PM +0000, Pasha Tatashin wrote:
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
> Also, add a comment before page_ext_operations that describes the
> field, and remove check if need() is set, as that is now a required

Nit: fields

> field.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  include/linux/page_ext.h | 19 +++++++++++++++++++
>  mm/page_ext.c            | 14 ++++++++++++--
>  mm/page_owner.c          |  1 +
>  mm/page_table_check.c    |  1 +
>  4 files changed, 33 insertions(+), 2 deletions(-)
> 
> Changelog:
> v2: Fixed field name in page_owner.c that caused build error.
> v3: Added comment before page_ext_operations, removed check if
>     need is null.
> 
> diff --git a/include/linux/page_ext.h b/include/linux/page_ext.h
> index 22be4582faae..be0b465c7d78 100644
> --- a/include/linux/page_ext.h
> +++ b/include/linux/page_ext.h
> @@ -7,15 +7,31 @@
>  #include <linux/stackdepot.h>
>  
>  struct pglist_data;
> +
> +/*

Please make it kerneldoc.

> + * Each Page Extension client must define page_ext_operations in
> + * page_ext_ops array.
> + * offset  offset to the client's data within page_ext. Offset is returned to
> + *         the client by page_ext_init.
> + * size    the size of the client data within page_ext.
> + * need()  function that returns true if client requires page_ext
> + * init()  (optional) called to initialize client once page_exts are allocated.
> + * using_shared_ext_flags  true when client is using shared page_ext->flags
> + *         field.
> + */
>  struct page_ext_operations {
>  	size_t offset;
>  	size_t size;
>  	bool (*need)(void);
>  	void (*init)(void);
> +	bool using_shared_ext_flags;

I'd s/using_shared_ext_flags/need_shared_flags.

>  };
>  
>  #ifdef CONFIG_PAGE_EXTENSION
>  
> +/*
> + * The page_ext_flags users must set using_shared_ext_flags to true.
> + */
>  enum page_ext_flags {
>  	PAGE_EXT_OWNER,
>  	PAGE_EXT_OWNER_ALLOCATED,
> @@ -31,6 +47,9 @@ enum page_ext_flags {
>   * page_ext helps us add more information about the page.
>   * All page_ext are allocated at boot or memory hotplug event,
>   * then the page_ext for pfn always exists.
> + * Note: that if none of the users of page_ext is setting

I'd drop that ^that

> + * using_shared_ext_flags to true, the field cannot be used,
> + * as it will be overlapped with another data.
>   */
>  struct page_ext {
>  	unsigned long flags;
> diff --git a/mm/page_ext.c b/mm/page_ext.c
> index 4ee522fd381c..d14dbd44fa49 100644
> --- a/mm/page_ext.c
> +++ b/mm/page_ext.c
> @@ -71,6 +71,7 @@ static bool need_page_idle(void)
>  }
>  static struct page_ext_operations page_idle_ops __initdata = {
>  	.need = need_page_idle,
> +	.using_shared_ext_flags = true,
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
> +			if (page_ext_ops[i]->using_shared_ext_flags) {
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
> index 2d27f532df4c..1a62ab3fc00e 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -99,6 +99,7 @@ struct page_ext_operations page_owner_ops = {
>  	.size = sizeof(struct page_owner),
>  	.need = need_page_owner,
>  	.init = init_page_owner,
> +	.using_shared_ext_flags = true,
>  };
>  
>  static inline struct page_owner *get_page_owner(struct page_ext *page_ext)
> diff --git a/mm/page_table_check.c b/mm/page_table_check.c
> index 93e633c1d587..74cfe89d5f53 100644
> --- a/mm/page_table_check.c
> +++ b/mm/page_table_check.c
> @@ -45,6 +45,7 @@ struct page_ext_operations page_table_check_ops = {
>  	.size = sizeof(struct page_table_check),
>  	.need = need_page_table_check,
>  	.init = init_page_table_check,
> +	.using_shared_ext_flags = false,
>  };
>  
>  static struct page_table_check *get_page_table_check(struct page_ext *page_ext)
> -- 
> 2.39.0.314.g84b9a713c41-goog
> 
> 

-- 
Sincerely yours,
Mike.
