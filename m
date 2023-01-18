Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3A0671F66
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 15:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbjAROW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 09:22:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjAROWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:22:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2771E5AA4B
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 06:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674050622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SPGQBg9MgduKKgBYZco3Nv67NZ90hWX2DplPWeCSJ94=;
        b=FIFYgpjBUQPFrSIXCCyz6oa1oWRPv9h3rl22R93pnljXWNpNFh2F1fzDKYri5x9A+lCQOJ
        O+41g5QblWycxcgpVIHjjM+Co+xQVxWBdvU/qEF0KFarsImpNCnNaq+MDNv+/b60hDbfKZ
        pfY8FU4/iICVP5AKv8b+WADoKXVyYC4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-567-3GBISAN7NYe8kl5obkENyQ-1; Wed, 18 Jan 2023 09:03:41 -0500
X-MC-Unique: 3GBISAN7NYe8kl5obkENyQ-1
Received: by mail-wr1-f71.google.com with SMTP id m12-20020adfa3cc000000b002b881cb0cb4so6875134wrb.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 06:03:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SPGQBg9MgduKKgBYZco3Nv67NZ90hWX2DplPWeCSJ94=;
        b=2X2xbLoU0EdEO16NhUEMWJT7S3dvpOGetO0LW3RBXGfeV/DUcRBguthet5AlW+4LMf
         XJmzn/91YYhwiWBFTjFlcSFKENMa0Y5ugpdTc0TI2Vf6T9Zw9aMYmkHa8mHhdzsikBQP
         QyyUO0UqmlQ1EBtRu4NFrzf88LzQKpz1im78GcFVzIiiLVrD0z9I4WH76mnvdQca08hp
         L6fCPPjkmoWVt/RXsDU5Y32fdNKwCLvxRLMjpe2St/6ciz4ytp8V2lewBx0UvJSkm0Mg
         B3p9Uy1K/cE71KZKbnXTe8fMX0IhIQ5E1KLJjxWP+tlsfBi4c7UtmUnowqQZg+L4N6z/
         vjBg==
X-Gm-Message-State: AFqh2krk4Gg8j4vqSHr2Awe0ZaK9w7M1b/GpNnFRkmqIhjW+Vp1W7AsP
        v8OMo/sIhOGy6kEYuG/SHGc41PjYS44XZo3tEuIIKIEVlzv7lNvnsT4cRrxBgxJ+aZQBncPaAZj
        72dj5GOwzsbRdhrY5rv8d5anX
X-Received: by 2002:a05:600c:6014:b0:3da:2032:6c0f with SMTP id az20-20020a05600c601400b003da20326c0fmr15387774wmb.31.1674050619858;
        Wed, 18 Jan 2023 06:03:39 -0800 (PST)
X-Google-Smtp-Source: AMrXdXubNs3zOMyVlXkvDDI43dE8RHNv9oeecf0SPH6HxZFoiy0PaZvJ2yugphCYiBNu97JGdbffZg==
X-Received: by 2002:a05:600c:6014:b0:3da:2032:6c0f with SMTP id az20-20020a05600c601400b003da20326c0fmr15387751wmb.31.1674050619543;
        Wed, 18 Jan 2023 06:03:39 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:800:1a88:f98a:d223:c454? (p200300cbc70508001a88f98ad223c454.dip0.t-ipconnect.de. [2003:cb:c705:800:1a88:f98a:d223:c454])
        by smtp.gmail.com with ESMTPSA id i18-20020a05600c355200b003d9df9e59c4sm2440796wmq.37.2023.01.18.06.03.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 06:03:39 -0800 (PST)
Message-ID: <0e0c90a2-d12c-f965-9cce-ecd5d28c09dd@redhat.com>
Date:   Wed, 18 Jan 2023 15:03:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v5 1/6] ksm: abstract the function
 try_to_get_old_rmap_item
Content-Language: en-US
To:     yang.yang29@zte.com.cn, akpm@linux-foundation.org
Cc:     imbrenda@linux.ibm.com, jiang.xuexin@zte.com.cn,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        ran.xiaokai@zte.com.cn, xu.xin.sc@gmail.com, xu.xin16@zte.com.cn
References: <202212300912449061763@zte.com.cn>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <202212300912449061763@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.12.22 02:12, yang.yang29@zte.com.cn wrote:
> From: xu xin <xu.xin16@zte.com.cn>
> 
> A new function try_to_get_old_rmap_item is abstracted from
> get_next_rmap_item. This function will be reused by the subsequent
> patches about counting ksm_zero_pages.
> 
> The patch improves the readability and reusability of KSM code.
> 
> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Cc: Xuexin Jiang <jiang.xuexin@zte.com.cn>
> Reviewed-by: Xiaokai Ran <ran.xiaokai@zte.com.cn>
> Reviewed-by: Yang Yang <yang.yang29@zte.com.cn>
> ---
>   mm/ksm.c | 25 +++++++++++++++++++------
>   1 file changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 83e2f74ae7da..5b0a7343ff4a 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -2214,23 +2214,36 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
>   	}
>   }
> 
> -static struct ksm_rmap_item *get_next_rmap_item(struct ksm_mm_slot *mm_slot,
> -					    struct ksm_rmap_item **rmap_list,
> -					    unsigned long addr)
> +static struct ksm_rmap_item *try_to_get_old_rmap_item(unsigned long addr,
> +					 struct ksm_rmap_item **rmap_list)
>   {
> -	struct ksm_rmap_item *rmap_item;
> -
>   	while (*rmap_list) {
> -		rmap_item = *rmap_list;
> +		struct ksm_rmap_item *rmap_item = *rmap_list;

Empty line missing.

>   		if ((rmap_item->address & PAGE_MASK) == addr)
>   			return rmap_item;
>   		if (rmap_item->address > addr)
>   			break;
>   		*rmap_list = rmap_item->rmap_list;
> +		/* Running here indicates it's vma has been UNMERGEABLE */

"If we end up here, the VMA is UNMERGEABLE."

Although I am not sure if that is true?

>   		remove_rmap_item_from_tree(rmap_item);
>   		free_rmap_item(rmap_item);
>   	}
> 
> +	return NULL;
> +}
> +
> +static struct ksm_rmap_item *get_next_rmap_item(struct ksm_mm_slot *mm_slot,
> +					    struct ksm_rmap_item **rmap_list,
> +					    unsigned long addr)
> +{
> +	struct ksm_rmap_item *rmap_item;
> +
> +	/* lookup if we have a old rmap_item matching the addr*/

I suggest dropping that comment, "try_to_get_old_rmap_item()" is 
expressive enough.

> +	rmap_item = try_to_get_old_rmap_item(addr, rmap_list);
> +	if (rmap_item)
> +		return rmap_item;
> +
> +	/* Need to allocate a new rmap_item */

I suggest dropping that comment for the same reason.

>   	rmap_item = alloc_rmap_item();
>   	if (rmap_item) {
>   		/* It has already been zeroed */

-- 
Thanks,

David / dhildenb

