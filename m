Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EED1723465
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 03:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbjFFBOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 21:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbjFFBOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 21:14:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD07100
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 18:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686013998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pC5sG/OJcZgKnubuci+7fn1G+3p3NcyJirieddMJY8Y=;
        b=TCSc7rS91YRq6KQSK8JRwDDNGRRvKyitunoIZoWHD6CPA3U6OxVi8S65C47TjqCD2Tkb2z
        3PTPjjdQ7odT1/5Vi/3RcmGjG40+XHwJ6mosP2tfxdBMA1IQRY6LZVvh+vyhfy3p+Sch6P
        AqYc1A6GoMvyANRiFxIdEmQ5Wx3e3V0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-259-XQhx8fhaPUu579ubvTcy2g-1; Mon, 05 Jun 2023 21:13:15 -0400
X-MC-Unique: XQhx8fhaPUu579ubvTcy2g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 01E633C01E00;
        Tue,  6 Jun 2023 01:13:15 +0000 (UTC)
Received: from localhost (ovpn-12-83.pek2.redhat.com [10.72.12.83])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B736240CFD46;
        Tue,  6 Jun 2023 01:13:13 +0000 (UTC)
Date:   Tue, 6 Jun 2023 09:13:09 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm/vmalloc: do not output a spurious warning when huge
 vmalloc() fails
Message-ID: <ZH6IJV8MATRtIjb/@MiWiFi-R3L-srv>
References: <20230605201107.83298-1-lstoakes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605201107.83298-1-lstoakes@gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/23 at 09:11pm, Lorenzo Stoakes wrote:
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

LGTM,

Reviewed-by: Baoquan He <bhe@redhat.com>

> +		if (!fatal_signal_pending(current) && page_order == 0)
>  			warn_alloc(gfp_mask, NULL,
> -				"vmalloc error: size %lu, page order %u, failed to allocate pages",
> -				area->nr_pages * PAGE_SIZE, page_order);
> +				"vmalloc error: size %lu, failed to allocate pages",
> +				area->nr_pages * PAGE_SIZE);
>  		goto fail;
>  	}
>  
> -- 
> 2.40.1
> 

