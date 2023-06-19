Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDB1735689
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 14:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjFSMQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 08:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjFSMQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 08:16:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3915A11D;
        Mon, 19 Jun 2023 05:16:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BED6E60BC0;
        Mon, 19 Jun 2023 12:16:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03282C433C0;
        Mon, 19 Jun 2023 12:16:43 +0000 (UTC)
Date:   Mon, 19 Jun 2023 13:16:41 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the slab tree with the mm tree
Message-ID: <ZJBHKTFRhsCzdJLe@arm.com>
References: <20230619140330.28437ac3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619140330.28437ac3@canb.auug.org.au>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2023 at 02:03:30PM +1000, Stephen Rothwell wrote:
> diff --cc mm/slab_common.c
> index 43c008165f56,90ecaface410..000000000000
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@@ -892,24 -876,17 +890,24 @@@ new_kmalloc_cache(int idx, enum kmalloc
>   		flags |= SLAB_CACHE_DMA;
>   	}
>   
>  +	if (minalign > ARCH_KMALLOC_MINALIGN) {
>  +		aligned_size = ALIGN(aligned_size, minalign);
>  +		aligned_idx = __kmalloc_index(aligned_size, false);
>  +	}
>  +
> + 	/*
> + 	 * If CONFIG_MEMCG_KMEM is enabled, disable cache merging for
> + 	 * KMALLOC_NORMAL caches.
> + 	 */
> + 	if (IS_ENABLED(CONFIG_MEMCG_KMEM) && (type == KMALLOC_NORMAL))
> + 		flags |= SLAB_NO_MERGE;
> + 
>  -	kmalloc_caches[type][idx] = create_kmalloc_cache(
>  -					kmalloc_info[idx].name[type],
>  -					kmalloc_info[idx].size, flags, 0,
>  -					kmalloc_info[idx].size);
>  +	if (!kmalloc_caches[type][aligned_idx])
>  +		kmalloc_caches[type][aligned_idx] = create_kmalloc_cache(
>  +					kmalloc_info[aligned_idx].name[type],
>  +					aligned_size, flags);
>  +	if (idx != aligned_idx)
>  +		kmalloc_caches[type][idx] = kmalloc_caches[type][aligned_idx];
> - 
> - 	/*
> - 	 * If CONFIG_MEMCG_KMEM is enabled, disable cache merging for
> - 	 * KMALLOC_NORMAL caches.
> - 	 */
> - 	if (IS_ENABLED(CONFIG_MEMCG_KMEM) && (type == KMALLOC_NORMAL))
> - 		kmalloc_caches[type][idx]->refcount = -1;
>   }
>   
>   /*

Thanks Stephen. The resolution looks fine to me.

-- 
Catalin
