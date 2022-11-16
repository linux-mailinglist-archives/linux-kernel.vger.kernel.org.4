Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7188B62B5EF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 10:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbiKPJFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 04:05:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbiKPJFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 04:05:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52C818E36
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 01:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668589451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2zNQ6t63zpMKIFqQZNZg7vAMrJ9IVL6Oa/vcPoC0RUs=;
        b=M8Lz5CXJl5xfpnmrhrf0GQg+S6g43NuANoJ2b74I+tJ4m/AoEfDryLr0gICPilJug3f0jn
        kPibS+ir134kaNERQ4Vz2a3BLHU9rLP1NIK6oWDpqllzFg/bmYrsymSGmdpMkuQJf6I/np
        2GRDzOXMWNW/xV3SzOhLpT2Fg5/bHUI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-644-XmJBW0IgPCGRNMgLtbJfZA-1; Wed, 16 Nov 2022 04:04:10 -0500
X-MC-Unique: XmJBW0IgPCGRNMgLtbJfZA-1
Received: by mail-wr1-f72.google.com with SMTP id s11-20020adfbc0b000000b0023659af24a8so3506252wrg.14
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 01:04:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2zNQ6t63zpMKIFqQZNZg7vAMrJ9IVL6Oa/vcPoC0RUs=;
        b=wdYFeSmzEwBc34kGeku3cUZTwgRYa8oM51iMBrsTNwBoV1H18J50Tkjl16vxdD9B8z
         x7lR+W4eKzotQIFBrKYSVKGloDEVMnWFQvyyKEOEfUUoO/TqMBwF25cHPZdaEqK81cSN
         JwqilnJbMATnBjqFMm19V+iSNo6ubc537tIbB2rOOApGdSSVGuX5LahXgNAvUaCUGcJG
         9/XWGsMt7wP3Z0D7DtfJMqp8FERkA9e6tP6v0gr49ds31dEKgezM7eyvWpkpWnTeORYF
         rugQ73lzzZ24Y44Ptabry1NLRbXTuXb9vI3rYJG7fRCumv3ZGNIhUbt8IvBmhZd73YXP
         i+wg==
X-Gm-Message-State: ANoB5pmuD7basMBLUSWStcs+pTeD0F8y3AeGBqv8H3iItSsaDfcQT9HU
        zkC7PKy88ti3K3Pc09LuTQkwnpgfH88UdORL8+/qnFLbFi/eVp3hJ0S72gcO3Q8wX1XTB32C1wQ
        sNC/q8TnOtZR+a59+GPRWmO6J
X-Received: by 2002:adf:e812:0:b0:241:7277:990b with SMTP id o18-20020adfe812000000b002417277990bmr13359520wrm.672.1668589448795;
        Wed, 16 Nov 2022 01:04:08 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7vb6kqkj4wvLBhA23X/5AKYOFI3w30OyZOaeCywvqpbTUabY9PahR3F/tVAwNWoqNdDInp0Q==
X-Received: by 2002:adf:e812:0:b0:241:7277:990b with SMTP id o18-20020adfe812000000b002417277990bmr13359488wrm.672.1668589448404;
        Wed, 16 Nov 2022 01:04:08 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:9f00:a98d:4026:7c44:40fd? (p200300cbc7049f00a98d40267c4440fd.dip0.t-ipconnect.de. [2003:cb:c704:9f00:a98d:4026:7c44:40fd])
        by smtp.gmail.com with ESMTPSA id fn15-20020a05600c688f00b003b47ff307e1sm1328642wmb.31.2022.11.16.01.04.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 01:04:07 -0800 (PST)
Message-ID: <ad4a64bf-b67e-abfd-c432-a90fd38be80b@redhat.com>
Date:   Wed, 16 Nov 2022 10:04:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 1/2] arm64/mm: fix incorrect file_map_count for non-leaf
 pmd/pud
Content-Language: en-US
To:     Liu Shixin <liushixin2@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        David Hildenbrand <dhildenb@redhat.com>,
        Rafael Aquini <raquini@redhat.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221116083811.464678-1-liushixin2@huawei.com>
 <20221116083811.464678-2-liushixin2@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20221116083811.464678-2-liushixin2@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.11.22 09:38, Liu Shixin wrote:
> The page table check trigger BUG_ON() unexpectedly when collapse hugepage:
> 
>   ------------[ cut here ]------------
>   kernel BUG at mm/page_table_check.c:82!
>   Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
>   Dumping ftrace buffer:
>      (ftrace buffer empty)
>   Modules linked in:
>   CPU: 6 PID: 68 Comm: khugepaged Not tainted 6.1.0-rc3+ #750
>   Hardware name: linux,dummy-virt (DT)
>   pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>   pc : page_table_check_clear.isra.0+0x258/0x3f0
>   lr : page_table_check_clear.isra.0+0x240/0x3f0
> [...]
>   Call trace:
>    page_table_check_clear.isra.0+0x258/0x3f0
>    __page_table_check_pmd_clear+0xbc/0x108
>    pmdp_collapse_flush+0xb0/0x160
>    collapse_huge_page+0xa08/0x1080
>    hpage_collapse_scan_pmd+0xf30/0x1590
>    khugepaged_scan_mm_slot.constprop.0+0x52c/0xac8
>    khugepaged+0x338/0x518
>    kthread+0x278/0x2f8
>    ret_from_fork+0x10/0x20
> [...]
> 
> Since pmd_user_accessible_page() doesn't check if a pmd is leaf, it
> decrease file_map_count for a non-leaf pmd comes from collapse_huge_page().
> and so trigger BUG_ON() unexpectedly.
> 
> Fix this problem by using pmd_leaf() insteal of pmd_present() in
> pmd_user_accessible_page(). Moreover, use pud_leaf() for
> pud_user_accessible_page() too.
> 
> Fixes: 42b2547137f5 ("arm64/mm: enable ARCH_SUPPORTS_PAGE_TABLE_CHECK")
> Reported-by: Denys Vlasenko <dvlasenk@redhat.com>
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---
>   arch/arm64/include/asm/pgtable.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 71a1af42f0e8..edf6625ce965 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -863,12 +863,12 @@ static inline bool pte_user_accessible_page(pte_t pte)
>   
>   static inline bool pmd_user_accessible_page(pmd_t pmd)
>   {
> -	return pmd_present(pmd) && (pmd_user(pmd) || pmd_user_exec(pmd));
> +	return pmd_leaf(pmd) && (pmd_user(pmd) || pmd_user_exec(pmd));
>   }
>   
>   static inline bool pud_user_accessible_page(pud_t pud)
>   {
> -	return pud_present(pud) && pud_user(pud);
> +	return pud_leaf(pud) && pud_user(pud);
>   }
>   #endif
>   

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

