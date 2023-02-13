Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9714694D84
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 17:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjBMQ4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 11:56:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjBMQ4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 11:56:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C44B1E5D4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 08:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676307285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m63A0UYMrPfeTx3fTqBjhgB5JqyruQ1Co1X3bBWcTX8=;
        b=Zn7kNb+zZeVzKpPcX4FMaMSzaQkRiW8LWOjQvCJeGeWBUwqcOuVD78t/2TTwuvjZMMjmab
        kjNhYUqzqPqPiM3krujI2Stgo7qp4aBuyN21OwJNt/6okinCZPal5+macvz4hv2AjHQekm
        VjLvNffBavahhhuwmLlnzJrqnpVUYjY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-152-kz-sUmkIMqebDQjpXGgA6A-1; Mon, 13 Feb 2023 11:54:44 -0500
X-MC-Unique: kz-sUmkIMqebDQjpXGgA6A-1
Received: by mail-qk1-f198.google.com with SMTP id op8-20020a05620a534800b0073b2e9d5061so2688511qkn.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 08:54:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676307284;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m63A0UYMrPfeTx3fTqBjhgB5JqyruQ1Co1X3bBWcTX8=;
        b=OmtXYFxFqQWMIZebmPhHKLTZgj+yzWrTMSwfp7Jw3tylLVLD8n4tkv9YvFzKrPWnzt
         gUgRcaymbtOgiZqA7oOY2AMxFUWdMQoMGqOAzWqylF640wEhbmBBBvXIHDawUmvL1VOz
         y2D76ElP3OClf3hcpWhXIrL5EljIsJlUdw6Mc9dytKo+A+IhSqgc7DPT8IKkfBA+BNKZ
         F52YQ+TTbIAbbp5yznTDoBnt2NIKxaANHm9wKGZuWiwgvzHR/2xL3oAtITEeaMj28FJ2
         HlVGJiSO/eJX5KN933trq8gyJL9VpDQ6ayunad7imZ5Kjy8tYckNIOhrKeTA3BoKYy/t
         EtOQ==
X-Gm-Message-State: AO0yUKWYJE+SfLISWJrqC+YI0u3Uo9ZZEVyFkMpcO7ir399Ro/H6Fb0W
        y+wuL242+/x012Ixj9sMZ/bU62y41+HyYYMyYTsSwehx55qfaFQoTGmdVx2QZc0d6EZf0JwxbjF
        559gGBIoSlcxdziz3YLL+BVtM
X-Received: by 2002:a05:622a:1744:b0:3b8:5dfe:c3dc with SMTP id l4-20020a05622a174400b003b85dfec3dcmr51622277qtk.3.1676307283965;
        Mon, 13 Feb 2023 08:54:43 -0800 (PST)
X-Google-Smtp-Source: AK7set/bZK0fGlLrzcqnZmqrkUdMTLY5whSyLkUFhgWouOol/Vo4g6Zjd7Y3hifjs/aebgHexEqazg==
X-Received: by 2002:a05:622a:1744:b0:3b8:5dfe:c3dc with SMTP id l4-20020a05622a174400b003b85dfec3dcmr51622245qtk.3.1676307283683;
        Mon, 13 Feb 2023 08:54:43 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id m127-20020a37bc85000000b00720750365b9sm10096783qkf.129.2023.02.13.08.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 08:54:43 -0800 (PST)
Date:   Mon, 13 Feb 2023 11:54:42 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     david@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
        kernel@collabora.com, Paul Gofman <pgofman@codeweavers.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm/userfaultfd: Support WP on multiple VMAs
Message-ID: <Y+prUgFQqmytC/5M@x1n>
References: <20230213163124.2850816-1-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230213163124.2850816-1-usama.anjum@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 09:31:23PM +0500, Muhammad Usama Anjum wrote:
> mwriteprotect_range() errors out if [start, end) doesn't fall in one
> VMA. We are facing a use case where multiple VMAs are present in one
> range of interest. For example, the following pseudocode reproduces the
> error which we are trying to fix:
> 
> - Allocate memory of size 16 pages with PROT_NONE with mmap
> - Register userfaultfd
> - Change protection of the first half (1 to 8 pages) of memory to
>   PROT_READ | PROT_WRITE. This breaks the memory area in two VMAs.
> - Now UFFDIO_WRITEPROTECT_MODE_WP on the whole memory of 16 pages errors
>   out.
> 
> This is a simple use case where user may or may not know if the memory
> area has been divided into multiple VMAs.
> 
> Reported-by: Paul Gofman <pgofman@codeweavers.com>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> Changes since v1:
> - Correct the start and ending values passed to uffd_wp_range()
> ---
>  mm/userfaultfd.c | 38 ++++++++++++++++++++++----------------
>  1 file changed, 22 insertions(+), 16 deletions(-)
> 
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 65ad172add27..bccea08005a8 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -738,9 +738,12 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
>  			unsigned long len, bool enable_wp,
>  			atomic_t *mmap_changing)
>  {
> +	unsigned long end = start + len;
> +	unsigned long _start, _end;
>  	struct vm_area_struct *dst_vma;
>  	unsigned long page_mask;
>  	int err;

I think this needs to be initialized or it can return anything when range
not mapped.

> +	VMA_ITERATOR(vmi, dst_mm, start);
>  
>  	/*
>  	 * Sanitize the command parameters:
> @@ -762,26 +765,29 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
>  	if (mmap_changing && atomic_read(mmap_changing))
>  		goto out_unlock;
>  
> -	err = -ENOENT;
> -	dst_vma = find_dst_vma(dst_mm, start, len);
> +	for_each_vma_range(vmi, dst_vma, end) {
> +		err = -ENOENT;
>  
> -	if (!dst_vma)
> -		goto out_unlock;
> -	if (!userfaultfd_wp(dst_vma))
> -		goto out_unlock;
> -	if (!vma_can_userfault(dst_vma, dst_vma->vm_flags))
> -		goto out_unlock;
> +		if (!dst_vma->vm_userfaultfd_ctx.ctx)
> +			break;
> +		if (!userfaultfd_wp(dst_vma))
> +			break;
> +		if (!vma_can_userfault(dst_vma, dst_vma->vm_flags))
> +			break;
>  
> -	if (is_vm_hugetlb_page(dst_vma)) {
> -		err = -EINVAL;
> -		page_mask = vma_kernel_pagesize(dst_vma) - 1;
> -		if ((start & page_mask) || (len & page_mask))
> -			goto out_unlock;
> -	}
> +		if (is_vm_hugetlb_page(dst_vma)) {
> +			err = -EINVAL;
> +			page_mask = vma_kernel_pagesize(dst_vma) - 1;
> +			if ((start & page_mask) || (len & page_mask))
> +				break;
> +		}
>  
> -	uffd_wp_range(dst_mm, dst_vma, start, len, enable_wp);
> +		_start = (dst_vma->vm_start > start) ? dst_vma->vm_start : start;
> +		_end = (dst_vma->vm_end < end) ? dst_vma->vm_end : end;
>  
> -	err = 0;
> +		uffd_wp_range(dst_mm, dst_vma, _start, _end - _start, enable_wp);
> +		err = 0;
> +	}
>  out_unlock:
>  	mmap_read_unlock(dst_mm);
>  	return err;

This whole patch also changes the abi, so I'm worried whether there can be
app that relies on the existing behavior.

Is this for the new pagemap effort?  Can this just be done in the new
interface rather than changing the old?

Side note: in your other pagemap series, you can optimize "WP_ENGAGE &&
!GET" to not do generic pgtable walk at all, but use what it does in this
patch for the initial round or wr-protect.

Thanks,

-- 
Peter Xu

