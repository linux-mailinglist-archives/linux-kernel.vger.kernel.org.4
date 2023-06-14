Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B529730495
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 18:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjFNQHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 12:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjFNQHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 12:07:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3DD1FCA
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 09:07:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F40A660FAA
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 16:07:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C99AC433C8;
        Wed, 14 Jun 2023 16:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686758862;
        bh=OV3jfhvD00wR731+Canfp/ZLczj9zpLC9E1ABGGYALA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=id9xKMWZKrqsIjjsKY4sPmy/UUNEAZPrtKia1/TUhVCQqzJGbe6eVODhg28YsDaIk
         LczjsjYql35+HdM2kcEN/MFBe9B3XcoWawx5ItWpqV0NnD4QjjPQjdWTSdVURwprjV
         h+X+rkLuR/7AulWfoglXkVSp+vpWdZFN07MWFIZFsF58UYzybiAOAXhszPWcyzcZSi
         Q8/9LnUiHasvzCGONlOrHrqjEY1/4S5D0pDIT/vfYU/0pv6bhxdDIQZHJl4SvLjeDs
         vjKe51kRqbI8Keah4xc7xrSfF5YkZ1N332xlrit+vz1exFDdYL74Nqvh3BJJi9xy60
         AyeBMIZhLyEQw==
Date:   Wed, 14 Jun 2023 19:07:10 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Song Shuai <songshuaishuai@tinylab.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memblock: Add error message when memblock_can_resize is
 not ready
Message-ID: <20230614160710.GH52412@kernel.org>
References: <20230614131746.3670303-1-songshuaishuai@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614131746.3670303-1-songshuaishuai@tinylab.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jun 14, 2023 at 09:17:46PM +0800, Song Shuai wrote:
> The memblock APIs are always correct, thus the callers usually don't
> handle the return code. But the failure caused by unready memblock_can_resize
> is hard to recognize without the return code. Like this piece of log:

Please make it clear that failure is in memblock_double_array(), e.g.

But when memblock_double_array() is called before memblock_can_resize
is true, it is hard to understand the actual reason for the failure.

> 
> ```
> [    0.000000] memblock_phys_alloc_range: 4096 bytes align=0x1000 from=0x0000000000000000 max_addr=0x0000000000000000 alloc_pmd_fixmap+0x14/0x1c
> [    0.000000] memblock_reserve: [0x000000017ffff000-0x000000017fffffff] memblock_alloc_range_nid+0xb8/0x128
> [    0.000000] Oops - store (or AMO) access fault [#1]
> ```
> 
> So add an error message for this kind of failure:
> 
> ```
> [    0.000000] memblock_phys_alloc_range: 4096 bytes align=0x1000 from=0x0000000000000000 max_addr=0x0000000000000000 alloc_pmd_fixmap+0x14/0x1c
> [    0.000000] memblock_reserve: [0x000000017ffff000-0x000000017fffffff] memblock_alloc_range_nid+0xb8/0x128
> [    0.000000] memblock: Can't double reserved array for area start 0x000000017ffff000 size 4096
> [    0.000000] Oops - store (or AMO) access fault [#1]
> ```
> 
> Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
> ---
>  mm/memblock.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 3feafea06ab2..ab952a164f62 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -418,8 +418,11 @@ static int __init_memblock memblock_double_array(struct memblock_type *type,
>  	/* We don't allow resizing until we know about the reserved regions
>  	 * of memory that aren't suitable for allocation
>  	 */
> -	if (!memblock_can_resize)
> +	if (!memblock_can_resize) {
> +		pr_err("memblock: Can't double %s array for area start %pa size %ld\n",
> +			type->name, &new_area_start, (unsigned long)new_area_size);

Most of the time memblock uses %llu and cast to u64 to print size, please
make this consistent.

>  		return -1;
> +	}
>  
>  	/* Calculate new doubled size */
>  	old_size = type->max * sizeof(struct memblock_region);
> -- 
> 2.20.1
> 
> 

-- 
Sincerely yours,
Mike.
