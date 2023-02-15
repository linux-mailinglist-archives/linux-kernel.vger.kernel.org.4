Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4866986D9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 22:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjBOVCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 16:02:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbjBOVCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 16:02:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1619E3E627
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 12:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676494776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q6S1VkTICkUqA9YHU6wXxGdQoIJSBXpOMfD6usHNMyI=;
        b=AA4sBrykE98+wYCj+Y9aXtRdXRv0TxyuNcr77f2qr2AwC3rW7sb0onzwcOJPNJEDUj3UX/
        yrVPJgucXXRl2NlqV9VOOziARDhyM92f8H8JBDoISfOH1BL2uraz0WX0G5CBr4uBEPzcta
        yp1lbZqAypMBCF5mLznKA5NF1sBfpLQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-586-M13cc2qNMaCDkz8ESkL2Dg-1; Wed, 15 Feb 2023 15:59:33 -0500
X-MC-Unique: M13cc2qNMaCDkz8ESkL2Dg-1
Received: by mail-wm1-f69.google.com with SMTP id bg3-20020a05600c3c8300b003e1e7d3cf9fso1903045wmb.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 12:59:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q6S1VkTICkUqA9YHU6wXxGdQoIJSBXpOMfD6usHNMyI=;
        b=Q5Sv3C7TTlgF4kl772RiCW9IdjywT+HzzK6I6VtPFUjEa8CAUCBrGrZj3uE7HzM3Sf
         acuQB+E3fSKCL3zERViwZlLBPCY53bkiIgffhldq0N4m6TUwkEPbzJW+eDbCK//Oj4pi
         vIqXdy5T7w1tPz3wXphl6v42/FWCrsf1eYVkneLIiCbAJQYPkpkUvRmDCdHk+7mD8W1o
         eBtMrJf5Xct8X2Oc7J+dFc+Ywkv4/j2jhFVlVJvVsjyz6H0Ve/vbnnm618a5j0RDYTi+
         D/z8yU2lTShPJRYnfYILMhF29p8AmBZXBt1akq9wtTUB5S46rYTGNT88PljxBzqKGswF
         0FDg==
X-Gm-Message-State: AO0yUKVbHsYw8xD5zl8pvViSRPC6QfNXBgEAE1umQEnHOXFTsEA/NirB
        mXxJ7mqGmIs5EUL+ssvqWq+GBmnF20NCvbrIxW1QoB7CsDxEOMpVCPeRN9Y19vsKer4Mi3+ocHS
        tWMXaS73WCID8R872HPb8m/bk
X-Received: by 2002:adf:f7c1:0:b0:2c5:4f48:cbb2 with SMTP id a1-20020adff7c1000000b002c54f48cbb2mr2789985wrq.51.1676494772486;
        Wed, 15 Feb 2023 12:59:32 -0800 (PST)
X-Google-Smtp-Source: AK7set8hffY8uY94ZVaHKD1JlU09IKXZUXP+Z3EUeF2EhZ+aIWmuPB0fxjsQYSj+MY98VMTBSCU9jQ==
X-Received: by 2002:adf:f7c1:0:b0:2c5:4f48:cbb2 with SMTP id a1-20020adff7c1000000b002c54f48cbb2mr2789969wrq.51.1676494772036;
        Wed, 15 Feb 2023 12:59:32 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:1400:b7d:4122:28d:f4c3? (p200300cbc70714000b7d4122028df4c3.dip0.t-ipconnect.de. [2003:cb:c707:1400:b7d:4122:28d:f4c3])
        by smtp.gmail.com with ESMTPSA id m20-20020a056000181400b002c54e89fcadsm11672017wrh.55.2023.02.15.12.59.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 12:59:31 -0800 (PST)
Message-ID: <45e0bb2a-c03c-e5fd-aa77-c2e3d079570c@redhat.com>
Date:   Wed, 15 Feb 2023 21:59:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] mm/uffd: Fix comment in handling pte markers
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nadav Amit <nadav.amit@gmail.com>
References: <20230215205800.223549-1-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230215205800.223549-1-peterx@redhat.com>
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

On 15.02.23 21:58, Peter Xu wrote:
> The comment is obsolete after f369b07c8614 ("mm/uffd: reset write
> protection when unregister with wp-mode", 2022-08-20).  Remove it.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   mm/memory.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 7a04a1130ec1..f456f3b5049c 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3627,9 +3627,7 @@ static vm_fault_t pte_marker_handle_uffd_wp(struct vm_fault *vmf)
>   {
>   	/*
>   	 * Just in case there're leftover special ptes even after the region
> -	 * got unregistered - we can simply clear them.  We can also do that
> -	 * proactively when e.g. when we do UFFDIO_UNREGISTER upon some uffd-wp
> -	 * ranges, but it should be more efficient to be done lazily here.
> +	 * got unregistered - we can simply clear them.
>   	 */
>   	if (unlikely(!userfaultfd_wp(vmf->vma) || vma_is_anonymous(vmf->vma)))
>   		return pte_marker_clear(vmf);

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

