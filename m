Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29CD36944D3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 12:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbjBMLpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 06:45:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjBMLpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 06:45:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8646D9ED0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 03:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676288700;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0+ZeLTi3RwaTIWgSUC2U7EO36k1sV0KfIaohOaQPFJ0=;
        b=QdXj1DURiGBiCyp8hc9Uu12sJF06HV+HAJWyUC9IwPr/2O3Iv+5H5KmS81JU+pOom/gtgl
        3ZlBYo1TOBamlHNcfZCsKBsmmknFdU+jjrgW1TwJF/sstqCGDxufEErMGofRTx1QjLLoqj
        cym0wIARjwHOBNmLt12EnJxp5iGmUfs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-80-3IOspj3jMje2uILRz87wqQ-1; Mon, 13 Feb 2023 06:44:59 -0500
X-MC-Unique: 3IOspj3jMje2uILRz87wqQ-1
Received: by mail-wr1-f71.google.com with SMTP id k12-20020a5d6d4c000000b002bff57fc7fcso2323481wri.19
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 03:44:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0+ZeLTi3RwaTIWgSUC2U7EO36k1sV0KfIaohOaQPFJ0=;
        b=zl9wW2Gp2F0xzoYBV4QfUa8TFo0j2bFPKKhEyPp/FhjQP1NZ46RO840LbpMDw0PXgC
         4KlmDAliDmU/dQhJ9Ajbv1BUJjmziLrTrVfMZYf5URKzEAVp9zv02aZPnddpcO1YM/pw
         JBngLODPH/zhxhkyl4qhGCn10w6OCS5yIgCDNcOoxDm7mCVBIOPmNEeDGswORPqgNeHY
         J0ou6ZY+yL7KkqrfvPK4AzydrFGpRdNzlaWfFcTdGn9LHhtceb0foOhMMuGJoyqAAGSS
         dJpcZNdaqF1KQ/DU9QOPmW23x8aODNfMEWBgYuO5z9vSMfOBZvHQknd448VO1U7ELT+N
         lyMw==
X-Gm-Message-State: AO0yUKU+EpZ3P7irM/wgvodFsG4p2eHJMqRr6HyuEFagWNjLo9fv2dOX
        3DrlTqRaGIwgUmJBNB/pmXPRWgMyZx4er7sT2FOMcsuBm4LIqazE1TGeXC2CV9zQVAC+vdUFhK+
        Z1iGRqBS+8jHqGo3Hz3Yk2Dts
X-Received: by 2002:adf:facb:0:b0:2c5:6081:5b3f with SMTP id a11-20020adffacb000000b002c560815b3fmr295685wrs.69.1676288698159;
        Mon, 13 Feb 2023 03:44:58 -0800 (PST)
X-Google-Smtp-Source: AK7set/EYPGVXwim1I2tkSzj4v4myRkfwwZoPbqOHpnSsyujra3BNHRZ2ULGYKrsKxTdYPZdrd9b7w==
X-Received: by 2002:adf:facb:0:b0:2c5:6081:5b3f with SMTP id a11-20020adffacb000000b002c560815b3fmr295666wrs.69.1676288697913;
        Mon, 13 Feb 2023 03:44:57 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:6d00:5870:9639:1c17:8162? (p200300cbc7056d00587096391c178162.dip0.t-ipconnect.de. [2003:cb:c705:6d00:5870:9639:1c17:8162])
        by smtp.gmail.com with ESMTPSA id y15-20020adfee0f000000b002c3efca57e1sm10530708wrn.110.2023.02.13.03.44.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 03:44:57 -0800 (PST)
Message-ID: <bb1c9707-d127-43c9-b5ec-5e5dad282726@redhat.com>
Date:   Mon, 13 Feb 2023 12:44:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] mm/userfaultfd: Support operation on multiple VMAs
Content-Language: en-US
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        peterx@redhat.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel@collabora.com, Paul Gofman <pgofman@codeweavers.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230213104323.1792839-1-usama.anjum@collabora.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230213104323.1792839-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.02.23 11:43, Muhammad Usama Anjum wrote:
> mwriteprotect_range() errors out if [start, end) doesn't fall in one
> VMA. We are facing a use case where multiple VMAs are present in one
> range of interest. For example, the following pseudocode reproduces the
> error which we are trying to fix:
> 
> - Allocate memory of size 16 pages with PROT_NONE with mmap
> - Register userfaultfd
> - Change protection of the first half (1 to 8 pages) of memory to
>    PROT_READ | PROT_WRITE. This breaks the memory area in two VMAs.
> - Now UFFDIO_WRITEPROTECT_MODE_WP on the whole memory of 16 pages errors
>    out.
> 
> This is a simple use case where user may or may not know if the memory
> area has been divided into multiple VMAs.
> 
> Reported-by: Paul Gofman <pgofman@codeweavers.com>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>   mm/userfaultfd.c | 36 +++++++++++++++++++-----------------
>   1 file changed, 19 insertions(+), 17 deletions(-)
> 
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 65ad172add27..46e0a014af68 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -738,9 +738,11 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
>   			unsigned long len, bool enable_wp,
>   			atomic_t *mmap_changing)
>   {
> +	unsigned long end = start + len;
>   	struct vm_area_struct *dst_vma;
>   	unsigned long page_mask;
>   	int err;
> +	VMA_ITERATOR(vmi, dst_mm, start);
>   
>   	/*
>   	 * Sanitize the command parameters:
> @@ -762,26 +764,26 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
>   	if (mmap_changing && atomic_read(mmap_changing))
>   		goto out_unlock;
>   
> -	err = -ENOENT;
> -	dst_vma = find_dst_vma(dst_mm, start, len);
> -
> -	if (!dst_vma)
> -		goto out_unlock;
> -	if (!userfaultfd_wp(dst_vma))
> -		goto out_unlock;
> -	if (!vma_can_userfault(dst_vma, dst_vma->vm_flags))
> -		goto out_unlock;
> +	for_each_vma_range(vmi, dst_vma, end) {
> +		err = -ENOENT;
>   
> -	if (is_vm_hugetlb_page(dst_vma)) {
> -		err = -EINVAL;
> -		page_mask = vma_kernel_pagesize(dst_vma) - 1;
> -		if ((start & page_mask) || (len & page_mask))
> -			goto out_unlock;
> -	}
> +		if (!dst_vma->vm_userfaultfd_ctx.ctx)
> +			break;
> +		if (!userfaultfd_wp(dst_vma))
> +			break;
> +		if (!vma_can_userfault(dst_vma, dst_vma->vm_flags))
> +			break;
>   
> -	uffd_wp_range(dst_mm, dst_vma, start, len, enable_wp);
> +		if (is_vm_hugetlb_page(dst_vma)) {
> +			err = -EINVAL;
> +			page_mask = vma_kernel_pagesize(dst_vma) - 1;
> +			if ((start & page_mask) || (len & page_mask))
> +				break;
> +		}
>   
> -	err = 0;
> +		uffd_wp_range(dst_mm, dst_vma, start, len, enable_wp);

I suspect you should be adjusting the range to only cover that specific 
VMA here.

-- 
Thanks,

David / dhildenb

