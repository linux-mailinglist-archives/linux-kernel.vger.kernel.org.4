Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB931723146
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 22:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjFEU0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 16:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjFEU0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 16:26:23 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C2A98
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 13:26:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E9AA121AD7;
        Mon,  5 Jun 2023 20:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685996779; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w0/hRPUBvyYGAAnuHnxG7Lh/Ffn2ioeZiKsBVO4DR9w=;
        b=ncX5oajq1jRuQtlP6aVCkVbF6nUa22ZCPAfyeeTz9B9EaNakNnCbQRatfLNuxjrSc0XmzX
        fLh1sHdgBgikbR3stSdVGlsn7OD0ZlkIGyVMTUmoGEWMLD/RYKGTYuHCtpOnu07OXL+7x1
        0nfiTIewKQQgQdZew1oG9tFI5a1FatM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685996779;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w0/hRPUBvyYGAAnuHnxG7Lh/Ffn2ioeZiKsBVO4DR9w=;
        b=O1j9Cc9aV/iGS69OzOWz+mty30H3encuxLqafdLKLzsD9UVfFa+PhvNT98wPNcpx5BnAyJ
        JIV6mgQfJlXvNfDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CB1B9139C7;
        Mon,  5 Jun 2023 20:26:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vQraMOtEfmRDBAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 05 Jun 2023 20:26:19 +0000
Message-ID: <75b40c68-ccf2-3786-9da1-1fa00c961eaf@suse.cz>
Date:   Mon, 5 Jun 2023 22:26:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] mm/vmalloc: do not output a spurious warning when huge
 vmalloc() fails
Content-Language: en-US
To:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Baoquan He <bhe@redhat.com>, Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
References: <20230605201107.83298-1-lstoakes@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230605201107.83298-1-lstoakes@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/5/23 22:11, Lorenzo Stoakes wrote:
> In __vmalloc_area_node() we always warn_alloc() when an allocation
> performed by vm_area_alloc_pages() fails unless it was due to a pending
> fatal signal.
> 
> However, huge page allocations instigated either by vmalloc_huge() or
> __vmalloc_node_range() (or a caller that invokes this like kvmalloc() or
> kvmalloc_node()) always falls back to order-0 allocations if the huge page
> allocation fails.
> 
> This renders the warning useless and noisy, especially as all callers
> appear to be aware that this may fallback. This has already resulted in at
> least one bug report from a user who was confused by this (see link).
> 
> Therefore, simply update the code to only output this warning for order-0
> pages when no fatal signal is pending.
> 
> Link: https://bugzilla.suse.com/show_bug.cgi?id=1211410
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

Thanks!

> ---
>  mm/vmalloc.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index ab606a80f475..e563f40ad379 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3149,11 +3149,20 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>  	 * allocation request, free them via vfree() if any.
>  	 */
>  	if (area->nr_pages != nr_small_pages) {
> -		/* vm_area_alloc_pages() can also fail due to a fatal signal */
> -		if (!fatal_signal_pending(current))
> +		/*
> +		 * vm_area_alloc_pages() can fail due to insufficient memory but
> +		 * also:-
> +		 *
> +		 * - a pending fatal signal
> +		 * - insufficient huge page-order pages
> +		 *
> +		 * Since we always retry allocations at order-0 in the huge page
> +		 * case a warning for either is spurious.
> +		 */
> +		if (!fatal_signal_pending(current) && page_order == 0)
>  			warn_alloc(gfp_mask, NULL,
> -				"vmalloc error: size %lu, page order %u, failed to allocate pages",
> -				area->nr_pages * PAGE_SIZE, page_order);
> +				"vmalloc error: size %lu, failed to allocate pages",
> +				area->nr_pages * PAGE_SIZE);
>  		goto fail;
>  	}
>  

