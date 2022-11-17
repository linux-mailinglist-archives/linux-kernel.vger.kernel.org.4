Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBD8862D462
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 08:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234715AbiKQHum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 02:50:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233622AbiKQHuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 02:50:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62EA95B861
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 23:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668671384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y2N7xLwoVXU6ukMGzXJcgviVQf/Bp/XT+1487tW1sk4=;
        b=eBV3OkzFvD4yfAb5ela2KG7pS8LEBfYXCjdPiPUopb83h/6Yfffwjigs43C1IN4IiF9hzi
        k/Qpzlk5JhDC6TMxVs5qOBPOvoXg7GmedCUa8FDW8z25YTkS1zIh85bQjiC36hq+AEf/kB
        OBnJNhRmJ8BTPtCR8TWMioUOsH/vN1w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-557-cKYHGfPTNI283p8iQaOx3w-1; Thu, 17 Nov 2022 02:49:42 -0500
X-MC-Unique: cKYHGfPTNI283p8iQaOx3w-1
Received: by mail-wr1-f71.google.com with SMTP id k7-20020adfc707000000b002416f2e9ad5so352872wrg.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 23:49:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y2N7xLwoVXU6ukMGzXJcgviVQf/Bp/XT+1487tW1sk4=;
        b=bBrpjnoCknYSNXaoHG9faGpYiZesbM7Aa9HiEAOR1GM1PrLgu5XILqInKpeC9Knqm2
         pUktkiseHIuSLSWMa4Ahy/xs+Rz0KOpdvhYmVNHfPN9hP3DUwZjWDfHM6X1zVNHKnsct
         OR69nCkgEjqIriiqDzoRxFSLu1hQy6fnQu9EjcZB1laAkjMWWt3GHQLP/dzd4K/yIn/t
         H7UfgWKnWr+82aNYgOUe4Q1bxjkkVIN3AyTAS/NFyr2C/GkXGCAAipxBkaZ33RExGThX
         F3suw/I6eKx8SU/VHM3amNzew0u8A0FHEDwa4ML5ZtlcapfKNMDVmBx6ko2z+Jx+L9kb
         8qNw==
X-Gm-Message-State: ANoB5pnO2HIcFH4BPHrEYZDQ4f6DQ5bTITXN2O0jUHLtYW7UlZ2UblAG
        aachk8cHbON19A3Si7g29ZXUlFjYhmJBmmNOgBPIVJj0XrBbK5hsjMkwcq4otSK270mmhtbWMxr
        fjgDtm36KPtbtC+XLIr4dlqFd
X-Received: by 2002:a05:600c:3516:b0:3cf:a8a5:63ab with SMTP id h22-20020a05600c351600b003cfa8a563abmr768814wmq.101.1668671381550;
        Wed, 16 Nov 2022 23:49:41 -0800 (PST)
X-Google-Smtp-Source: AA0mqf682MiO2XGLvTeH42jZuNuCPofp/JskA2KYwkzF3hTXpKObK4Za6QoJRdoJrJIofbFlbbMxYQ==
X-Received: by 2002:a05:600c:3516:b0:3cf:a8a5:63ab with SMTP id h22-20020a05600c351600b003cfa8a563abmr768806wmq.101.1668671381262;
        Wed, 16 Nov 2022 23:49:41 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:5200:39a9:b834:27c1:4ede? (p200300cbc707520039a9b83427c14ede.dip0.t-ipconnect.de. [2003:cb:c707:5200:39a9:b834:27c1:4ede])
        by smtp.gmail.com with ESMTPSA id t65-20020a1c4644000000b003cfa622a18asm4645357wma.3.2022.11.16.23.49.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 23:49:40 -0800 (PST)
Message-ID: <cc7e7763-9e19-88e2-7d88-b6fc1f2158e3@redhat.com>
Date:   Thu, 17 Nov 2022 08:49:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v2 2/2] arm64/mm: fix incorrect file_map_count for invalid
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
References: <20221117075602.2904324-1-liushixin2@huawei.com>
 <20221117075602.2904324-3-liushixin2@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20221117075602.2904324-3-liushixin2@huawei.com>
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

On 17.11.22 08:56, Liu Shixin wrote:
> The page table check trigger BUG_ON() unexpectedly when split hugepage:
> 
>   ------------[ cut here ]------------
>   kernel BUG at mm/page_table_check.c:119!
>   Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
>   Dumping ftrace buffer:
>      (ftrace buffer empty)
>   Modules linked in:
>   CPU: 7 PID: 210 Comm: transhuge-stres Not tainted 6.1.0-rc3+ #748
>   Hardware name: linux,dummy-virt (DT)
>   pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>   pc : page_table_check_set.isra.0+0x398/0x468
>   lr : page_table_check_set.isra.0+0x1c0/0x468
> [...]
>   Call trace:
>    page_table_check_set.isra.0+0x398/0x468
>    __page_table_check_pte_set+0x160/0x1c0
>    __split_huge_pmd_locked+0x900/0x1648
>    __split_huge_pmd+0x28c/0x3b8
>    unmap_page_range+0x428/0x858
>    unmap_single_vma+0xf4/0x1c8
>    zap_page_range+0x2b0/0x410
>    madvise_vma_behavior+0xc44/0xe78
>    do_madvise+0x280/0x698
>    __arm64_sys_madvise+0x90/0xe8
>    invoke_syscall.constprop.0+0xdc/0x1d8
>    do_el0_svc+0xf4/0x3f8
>    el0_svc+0x58/0x120
>    el0t_64_sync_handler+0xb8/0xc0
>    el0t_64_sync+0x19c/0x1a0
> [...]
> 
> On arm64, pmd_leaf() will return true even if the pmd is invalid due to
> pmd_present_invalid() check. So in pmdp_invalidate() the file_map_count
> will not only decrease once but also increase once. Then in set_pte_at(),
> the file_map_count increase again, and so trigger BUG_ON() unexpectedly.
> 
> Fix this problem by adding pmd_valid() in pmd_user_accessible_page().
> Moreover, add pud_valid() for pud_user_accessible_page() too.
> 
> Fixes: 42b2547137f5 ("arm64/mm: enable ARCH_SUPPORTS_PAGE_TABLE_CHECK")
> Reported-by: Denys Vlasenko <dvlasenk@redhat.com>
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> Acked-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>   arch/arm64/include/asm/pgtable.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index edf6625ce965..3bc64199aa2e 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -863,12 +863,12 @@ static inline bool pte_user_accessible_page(pte_t pte)
>   
>   static inline bool pmd_user_accessible_page(pmd_t pmd)
>   {
> -	return pmd_leaf(pmd) && (pmd_user(pmd) || pmd_user_exec(pmd));
> +	return pmd_valid(pmd) && pmd_leaf(pmd) && (pmd_user(pmd) || pmd_user_exec(pmd));
>   }
>   
>   static inline bool pud_user_accessible_page(pud_t pud)
>   {
> -	return pud_leaf(pud) && pud_user(pud);
> +	return pud_valid(pud) && pud_leaf(pud) && pud_user(pud);
>   }
>   #endif
>   

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

