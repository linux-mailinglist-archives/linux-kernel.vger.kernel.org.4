Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A8172391A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 09:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235105AbjFFHfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 03:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbjFFHfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 03:35:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A72C11B
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 00:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686036892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u9hoKMrz96Ll5ESBHtQB3MXK47tj0oxLzUbKMv/mlKw=;
        b=Q6CLA2nn/9fnyk7E5zqZDq0mpzEFYvld4KMycCcvRV5d5cQba6JER3L8n7wUXEl+OBjd9D
        jD6cQHfrnGZ1DaEKd3nZUeRN3zmAeJ79ulsrvIpVAcwGumiXXWti5wKHCUweypGW4dk1RQ
        gEPd9X8TqMZBW9E9jFoCPWYi/6XB4fM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-KKo3_ZooO4eMXI9NmTVNLw-1; Tue, 06 Jun 2023 03:34:49 -0400
X-MC-Unique: KKo3_ZooO4eMXI9NmTVNLw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-30c6060eb32so6697290f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 00:34:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686036888; x=1688628888;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u9hoKMrz96Ll5ESBHtQB3MXK47tj0oxLzUbKMv/mlKw=;
        b=HjUowVvX8y225kNTOCAAFaPIG+mqETpxWWY13drt+90CyBNdeEKdJSbT4ZRqrAvWwZ
         QcrIYLS+yqXwJT0RAm6Y8zB78m6/jnPWQqhAP6Qq/P0RQfHVxBHrIea+T8+c3kRScpky
         MrnwM10ZSgG89nurVaKLdtHFTcT1n8uEppn7OZHCGn5hC+6QbxEesMXyIoPZhntW3ch9
         jILOGi1s5PKxrds0A/GhbJqFvLy8P81q6m7r7EczXKNVfXy6IEq0f0ImfGnRwO/zVG4r
         JgGfBmvlsAuwxaX8kQf0txUKnNyc0hFcRV0uiMV8Fdw3/q2de3vZ6i2VCOyqSG+A2dQh
         pvfw==
X-Gm-Message-State: AC+VfDxJA5kQMkJLiHlMGn4pYygLepydZ2LQAWg4CaYtCzstOZxXlCE6
        0FuAaTCHXyTxoIBebz2wleQjLjYr9wBlmeELWOPnjhH735DQLRYjkfA5AYBczcGMA2Jf26Ohq8Y
        glrA0nETrj6VHrUvVm7/jikuU
X-Received: by 2002:a5d:4806:0:b0:30e:3d9b:727e with SMTP id l6-20020a5d4806000000b0030e3d9b727emr1240564wrq.40.1686036888617;
        Tue, 06 Jun 2023 00:34:48 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4s5ED6h8jf4mO/b4ODuAk+dC38c2/SLsl2G0aipZa3onD8s4Avvb9wkLi5uIWlBLWrNvcrnQ==
X-Received: by 2002:a5d:4806:0:b0:30e:3d9b:727e with SMTP id l6-20020a5d4806000000b0030e3d9b727emr1240548wrq.40.1686036888266;
        Tue, 06 Jun 2023 00:34:48 -0700 (PDT)
Received: from ?IPV6:2003:cb:c709:d100:ce7e:d566:43f8:2b24? (p200300cbc709d100ce7ed56643f82b24.dip0.t-ipconnect.de. [2003:cb:c709:d100:ce7e:d566:43f8:2b24])
        by smtp.gmail.com with ESMTPSA id g9-20020adfe409000000b0030ae53550f5sm11716503wrm.51.2023.06.06.00.34.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 00:34:47 -0700 (PDT)
Message-ID: <74ec0a14-c18d-3249-e331-fa4c9c821d01@redhat.com>
Date:   Tue, 6 Jun 2023 09:34:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] mm/vmalloc: do not output a spurious warning when huge
 vmalloc() fails
Content-Language: en-US
To:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Baoquan He <bhe@redhat.com>, Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>
References: <20230605201107.83298-1-lstoakes@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230605201107.83298-1-lstoakes@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.06.23 22:11, Lorenzo Stoakes wrote:
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
>   mm/vmalloc.c | 17 +++++++++++++----
>   1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index ab606a80f475..e563f40ad379 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3149,11 +3149,20 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>   	 * allocation request, free them via vfree() if any.
>   	 */
>   	if (area->nr_pages != nr_small_pages) {
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
>   			warn_alloc(gfp_mask, NULL,
> -				"vmalloc error: size %lu, page order %u, failed to allocate pages",
> -				area->nr_pages * PAGE_SIZE, page_order);
> +				"vmalloc error: size %lu, failed to allocate pages",
> +				area->nr_pages * PAGE_SIZE);
>   		goto fail;
>   	}
>   

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

