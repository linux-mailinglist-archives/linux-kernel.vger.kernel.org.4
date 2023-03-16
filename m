Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531F16BD2D1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 15:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjCPO6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 10:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjCPO6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 10:58:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A988CB061
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 07:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678978636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dzgtYRuv2N6ox79mROVezmyy+dEWrd7NrYkm4MuwFdo=;
        b=MF8VRFD+335ms5hze0Z54L3dmRJnz7CpBJ1gBxsNFT7TdCJoDmu87E6+9Lax3wq/seyGZc
        oQD+n9/cAZsm062vxkM1YX/XDtireBrljxBCf1x3dG5gwSwvll4WCqtqOdoH9JEWBZ+J7/
        y/zOHaqzeCUjuqSJQFNa+sXBgo0lejg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-rZnVZdlhPVyMjeReKwI1EA-1; Thu, 16 Mar 2023 10:57:15 -0400
X-MC-Unique: rZnVZdlhPVyMjeReKwI1EA-1
Received: by mail-wm1-f69.google.com with SMTP id n18-20020a05600c501200b003ed24740ea4so2749124wmr.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 07:57:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678978634;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dzgtYRuv2N6ox79mROVezmyy+dEWrd7NrYkm4MuwFdo=;
        b=cF5QGBcg3ZzCLZJ2gMjEaAlR3+tqCtvRvboRIsEluFGTO8wdWuw8ji564xL/nwYGzY
         bozoPsPFUJXAz5uNDt0SyL5P+KGOqcGy2dfKUORnVsMqu7m1cO+7NbHlOmVcyBiojQ/F
         JLh2RmxLNljz6Mxci1uOibV06z/osxnH/Qh6hckTK6IC363hl4XrcL4tr/npJWSC4i/d
         Z96LUfODxcKzCsTpDH9bbsxIFUlguHk2Oo23JOIRwTUVWfNy7+rrek1Xr5yjIfr4v/m7
         0ZL+kiP+5OfGQ9i3r7PbYGFm7y3cMgTP0UyLuZQEPc3tpKysLb986ltdJgEtOfqqqyPI
         Oonw==
X-Gm-Message-State: AO0yUKXHZEqq2FVOm/JiF177sB9wblAHJ2FO6p6Jm3toVwBij68R3gsf
        fCKStH5sFPymu1MVoZ3G2zRCF17tpg1dWHGh390xP9tiD112BM0Dlpy3EKl0GbayS3FKaqbVqns
        +N3ZJuksqzrkKzkNWpsK/1E2N
X-Received: by 2002:a05:600c:27cd:b0:3ed:5a12:5641 with SMTP id l13-20020a05600c27cd00b003ed5a125641mr2118062wmb.36.1678978633923;
        Thu, 16 Mar 2023 07:57:13 -0700 (PDT)
X-Google-Smtp-Source: AK7set9Lgxs8uH0JXoZf16zE7x4qcYswa8cWdymlyPBoS/qG+4kXT/DlM+LrT8xXJG6ATIxR0lqOpQ==
X-Received: by 2002:a05:600c:27cd:b0:3ed:5a12:5641 with SMTP id l13-20020a05600c27cd00b003ed5a125641mr2118044wmb.36.1678978633558;
        Thu, 16 Mar 2023 07:57:13 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id bg5-20020a05600c3c8500b003e7f1086660sm5529697wmb.15.2023.03.16.07.57.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 07:57:13 -0700 (PDT)
Message-ID: <83625129-26c9-8885-7367-bb56bc5367f3@redhat.com>
Date:   Thu, 16 Mar 2023 15:57:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] mm/thp: Rename TRANSPARENT_HUGEPAGE_NEVER_DAX to
 _UNSUPPORTED
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>
References: <20230315171642.1244625-1-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230315171642.1244625-1-peterx@redhat.com>
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

On 15.03.23 18:16, Peter Xu wrote:
> TRANSPARENT_HUGEPAGE_NEVER_DAX has nothing to do with DAX.  It's set when
> has_transparent_hugepage() returns false, checked in hugepage_vma_check()
> and will disable THP completely if false.  Rename it to reflect its real
> purpose.
> 
> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   include/linux/huge_mm.h | 2 +-
>   mm/huge_memory.c        | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 70bd867eba94..9a3a3af2dd80 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -79,7 +79,7 @@ static inline vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn,
>   }
>   
>   enum transparent_hugepage_flag {
> -	TRANSPARENT_HUGEPAGE_NEVER_DAX,
> +	TRANSPARENT_HUGEPAGE_UNSUPPORTED,
>   	TRANSPARENT_HUGEPAGE_FLAG,
>   	TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG,
>   	TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG,
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index b0ab247939e0..913e7dc32869 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -88,7 +88,7 @@ bool hugepage_vma_check(struct vm_area_struct *vma, unsigned long vm_flags,
>   	/*
>   	 * If the hardware/firmware marked hugepage support disabled.
>   	 */
> -	if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_NEVER_DAX))
> +	if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_UNSUPPORTED))
>   		return false;
>   
>   	/* khugepaged doesn't collapse DAX vma, but page fault is fine. */
> @@ -464,7 +464,7 @@ static int __init hugepage_init(void)
>   		 * Hardware doesn't support hugepages, hence disable
>   		 * DAX PMD support.


We should also fixup that comment then, no?

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

