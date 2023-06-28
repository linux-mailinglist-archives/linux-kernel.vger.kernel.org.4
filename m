Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94BB6740B0F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 10:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbjF1IUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 04:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233725AbjF1IOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:14:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B8535AE
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 01:09:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AAB6C61329
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 07:34:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C47DC433CA;
        Wed, 28 Jun 2023 07:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687937648;
        bh=wMjh2mW4JXYa3sX6Q+SyiFJ+70tkbGtKkJXlOrezZnQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NxJpNPK4Awt3qiDCFtIjjIyLKcrvXKrb4g+qeaQjkGbbphdluOdGtfcmR5h1FXxRq
         TbccwUiiBusOwwG87ua1KKhM9iw54JzgBYbTrkpBFYrIPbN88HH5H4BJV4NgbJ1x6f
         cJzz6WBhAFTAIpXcNtLLi1aQpxnJv32DkX6OSqtqy8ILBq1IoWVgriMdVrKFsv9LvC
         ugM+RBXvjoCUBZZjxxjejjpUxieXewm3oJTOtskXnbLadIEXWvrC3/7rlrEvQRocf3
         pBB6qbWuNDCvOaHzApMXzg0ra+Ld02PxQ5TzZec5qH2VqDbUb+tPIUGc/XfD8ILZTs
         lLAd/kIEL6tSQ==
Date:   Wed, 28 Jun 2023 10:33:17 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Song Shuai <songshuaishuai@tinylab.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memblock: report failures when memblock_can_resize is
 not set
Message-ID: <20230628073317.GO52412@kernel.org>
References: <20230624032607.921173-1-songshuaishuai@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230624032607.921173-1-songshuaishuai@tinylab.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 24, 2023 at 11:26:07AM +0800, Song Shuai wrote:
> The callers of memblock_reserve() do not check the return value
> presuming that memblock_reserve() always succeeds, but there are
> cases where it may fail.
> 
> Having numerous memblock reservations at early boot where
> memblock_can_resize is unset may exhaust the INIT_MEMBLOCK_REGIONS sized
> memblock.reserved regions array and an attempt to double this array via
> memblock_double_array() will fail and will return -1 to the caller.
> 
> When this happens the system crashes anyway, but it's hard to identify
> the reason for the crash.
> 
> Add a panic message to memblock_double_array() to aid debugging of the
> cases when too many regions are reserved before memblock can resize
> memblock.reserved array.
> 
> Link: https://lore.kernel.org/linux-kernel/20230614131746.3670303-1-songshuaishuai@tinylab.org/
> Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>

This is queued now, it will appear in memblock/for-next after the merge
window closes.

Thanks!

> ---
>  mm/memblock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 3feafea06ab2..1b8e902490e5 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -419,7 +419,7 @@ static int __init_memblock memblock_double_array(struct memblock_type *type,
>  	 * of memory that aren't suitable for allocation
>  	 */
>  	if (!memblock_can_resize)
> -		return -1;
> +		panic("memblock: cannot resize %s array\n", type->name);
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
