Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF1E6A8281
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 13:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjCBMnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 07:43:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCBMnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 07:43:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF4946148
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 04:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677760946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9EbyPGw/PLfi7RG+ShAiqiUEOlZiujjcNGly444bA7g=;
        b=IH5xcP0FsaSj50+XYGbJGrDK4tyrN2NV1NrsOsmMXtSMrvRk3nzjjsIUCUr4tUcUta3Cdp
        TfqPdt0J4IJuklOlpPI1XidxYbSyodSseVxpdPZ2AIG4OYJibKrBbhlTxveszjg7Wp2rBa
        /vqwUJnRdfQlnTDFogdcUceCXvPxpDI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-669-bFKSlrofOAax2aphrEqLfQ-1; Thu, 02 Mar 2023 07:42:24 -0500
X-MC-Unique: bFKSlrofOAax2aphrEqLfQ-1
Received: by mail-wm1-f70.google.com with SMTP id bi27-20020a05600c3d9b00b003e9d0925341so5698215wmb.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 04:42:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9EbyPGw/PLfi7RG+ShAiqiUEOlZiujjcNGly444bA7g=;
        b=U8BKN5koHr0EQ5sS3Zqo9GdlGnFK+OG6YZGkQgb7vGgj4k+JkD8efPkIY/yzySu9kt
         2iG+ihDZMmAaMi1BKtgIXO4EBAq0oi4vUKcOYfS8lGgjxDIq71g1Xy9DXLggSsf2hqdf
         B9Ff4wKhnaeyMxx9SOigD81hM3LNDKOVn5zv9neWSdMzcyYxDesgq/Jkp5ZG9+vxI+sn
         eddAUOx40x+qgNmHMEh9SRSpBTMqeONdpwjTjybcWoaYDahsCtHu7uBD/IaKURPlmDPX
         Hoip47pLkxAjiP8cbn+vzeeCvIVeqNoNDSGfgJIjD86OD9ANR1BbUvwNY2kg4xZ4fyUT
         oBeA==
X-Gm-Message-State: AO0yUKWzBNtTmQpd0hM0QbluWWyVk4dogV61UJxKVP3JfhWv1QrPLBcx
        sl/3ZoaYv/YZiPrx6nJuOK2WdTgT3krYCNF1xDG13hLfiOMRL7fYUOoFRn2+6q5ta8bYvwDx/It
        wJJKscn3VtTAAckwxw2xPrjI4ZrLZTg==
X-Received: by 2002:a05:600c:3b14:b0:3ea:d620:57a7 with SMTP id m20-20020a05600c3b1400b003ead62057a7mr7976426wms.8.1677760943698;
        Thu, 02 Mar 2023 04:42:23 -0800 (PST)
X-Google-Smtp-Source: AK7set/QrSiKFfiLUJO8Cajioz2AbQDvgkLMFQdM8vHtrEf3tbr3y3T5RsMAGax2eUNWsnEQkfOzWQ==
X-Received: by 2002:a05:600c:3b14:b0:3ea:d620:57a7 with SMTP id m20-20020a05600c3b1400b003ead62057a7mr7976416wms.8.1677760943365;
        Thu, 02 Mar 2023 04:42:23 -0800 (PST)
Received: from [192.168.3.108] (p4ff237b6.dip0.t-ipconnect.de. [79.242.55.182])
        by smtp.gmail.com with ESMTPSA id x16-20020a1c7c10000000b003e70a7c1b73sm2770968wmc.16.2023.03.02.04.42.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 04:42:22 -0800 (PST)
Message-ID: <d4895edc-a7de-239b-e452-c64535b68685@redhat.com>
Date:   Thu, 2 Mar 2023 13:42:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH V2] mm/debug_vm_pgtable: Replace pte_mkhuge() with
 arch_make_huge_pte()
Content-Language: en-US
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc:     mike.kravetz@oracle.com, Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>
References: <20230302114845.421674-1-anshuman.khandual@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230302114845.421674-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.03.23 12:48, Anshuman Khandual wrote:
> Since the following commit arch_make_huge_pte() should be used directly in
> generic memory subsystem as a platform provided page table helper, instead
> of pte_mkhuge(). Change hugetlb_basic_tests() to call arch_make_huge_pte()
> directly, and update its relevant documentation entry as required.
> 
> 'commit 16785bd77431 ("mm: merge pte_mkhuge() call into arch_make_huge_pte()")'
> 
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: "Mike Rapoport (IBM)" <rppt@kernel.org>
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> Reported-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Link: https://lore.kernel.org/all/1ea45095-0926-a56a-a273-816709e9075e@csgroup.eu/
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> This applies on latest mainline.
> 
> Changes in V2:
> 
> - Send PMD_SHIFT and VM_ACCESS_FLAGS as arguments for arch_make_huge_pte()
>   
> Changes in V1:
> 
> https://lore.kernel.org/all/20230302031833.360679-1-anshuman.khandual@arm.com/
> 
>   Documentation/mm/arch_pgtable_helpers.rst | 2 +-
>   mm/debug_vm_pgtable.c                     | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/mm/arch_pgtable_helpers.rst b/Documentation/mm/arch_pgtable_helpers.rst
> index 30d9a09f01f4..af3891f895b0 100644
> --- a/Documentation/mm/arch_pgtable_helpers.rst
> +++ b/Documentation/mm/arch_pgtable_helpers.rst
> @@ -214,7 +214,7 @@ HugeTLB Page Table Helpers
>   +---------------------------+--------------------------------------------------+
>   | pte_huge                  | Tests a HugeTLB                                  |
>   +---------------------------+--------------------------------------------------+
> -| pte_mkhuge                | Creates a HugeTLB                                |
> +| arch_make_huge_pte        | Creates a HugeTLB                                |
>   +---------------------------+--------------------------------------------------+
>   | huge_pte_dirty            | Tests a dirty HugeTLB                            |
>   +---------------------------+--------------------------------------------------+
> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
> index af59cc7bd307..7887cc2b75bf 100644
> --- a/mm/debug_vm_pgtable.c
> +++ b/mm/debug_vm_pgtable.c
> @@ -934,7 +934,7 @@ static void __init hugetlb_basic_tests(struct pgtable_debug_args *args)
>   #ifdef CONFIG_ARCH_WANT_GENERAL_HUGETLB
>   	pte = pfn_pte(args->fixed_pmd_pfn, args->page_prot);
>   
> -	WARN_ON(!pte_huge(pte_mkhuge(pte)));
> +	WARN_ON(!pte_huge(arch_make_huge_pte(pte, PMD_SHIFT, VM_ACCESS_FLAGS)));
>   #endif /* CONFIG_ARCH_WANT_GENERAL_HUGETLB */
>   }
>   #else  /* !CONFIG_HUGETLB_PAGE */


IMHO, it's a bit weird that we are starting to call these things 
"arch_*". PTE operations like these are already mostly arch-specific 
helpers with custom implementations (and some generic ones in 
asm-generic as a fallback).

So this one certainly sticks out now ... anyhow, change itself LGTM ...

-- 
Thanks,

David / dhildenb

