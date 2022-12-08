Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4136470A6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 14:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiLHNR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 08:17:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiLHNRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 08:17:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7C092FDC
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 05:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670505368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=neWLwjcyNjI8ZbLG+eysMC72AXD8ev/7q1C2nUvKC3k=;
        b=PNoMsKw9ZZ+OzsWDRal7QugrhSNFpqkUnEQoCcBQC/KfI0lvM695cpUz1+p0G2oTjT7AP/
        HloYJI53wyb720NNJAcb3OCHhDHHXMae5O8V+B6nJ5dDhg/IdGwrieyHNHjP/Go+qpg6Ub
        Lyw+tl+l+hwpuKEsh2MVYF6+FvxtOAo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-465-IscL99eoMS-qNa6BGtnDXw-1; Thu, 08 Dec 2022 08:16:06 -0500
X-MC-Unique: IscL99eoMS-qNa6BGtnDXw-1
Received: by mail-wm1-f72.google.com with SMTP id bi19-20020a05600c3d9300b003cf9d6c4016so2386309wmb.8
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 05:16:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=neWLwjcyNjI8ZbLG+eysMC72AXD8ev/7q1C2nUvKC3k=;
        b=3VdM92kog8tafweWwCW7lo3+cK9ozghOU34XsytZdKeviqKvmnXXL0gFW0AcCvBdRa
         yD3VnH3f6vnNiEUAcn2H24xAPTE0D+j8Rc0pbi0SDepZXcQxTOueynMT7NIJFexhUf64
         nQV6M7O9+Id+tzTbZxLczyRLUXEFwkcnZ3htv+2pUjJvTCHl5BhXqEeUfcxKb2Ner87Q
         OhrKvgQ+B5YyiZ+VDhdX6X3uxkMTI33wsx6QKupJiyCjOsbbuUp7Ije+WPNvEJuUXe6H
         /gEkYGgVkaZDhphRSAzYagvTslUyZ6r6BoTQn91MInqVZlKZoigeRiH0CdHrKK8q2g98
         2K2g==
X-Gm-Message-State: ANoB5pmefvQ/4rFZWzVJcQ8KeXMkzDfADv0KNK/fVsiV66yYqdlfW3SA
        6ojRVyFbTpPcCRqldhqEU3SE0ufosF/4/BahAUsQ9zdDhCFrWrdgLU98xzVyoHgmbHtRi46g0JO
        qqjESQlrlWvsDS2/Fp8VOirVP
X-Received: by 2002:a1c:5406:0:b0:3d1:e3ba:3bb6 with SMTP id i6-20020a1c5406000000b003d1e3ba3bb6mr9123508wmb.29.1670505365093;
        Thu, 08 Dec 2022 05:16:05 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7ZeniNqSJf/bXpP3fqsWoiP81fRuzC3ndMmkkBsTOt9cQD+OEqUkQszPtaCwAqFcKUdPfeWw==
X-Received: by 2002:a1c:5406:0:b0:3d1:e3ba:3bb6 with SMTP id i6-20020a1c5406000000b003d1e3ba3bb6mr9123496wmb.29.1670505364741;
        Thu, 08 Dec 2022 05:16:04 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id k32-20020a05600c1ca000b003b4ff30e566sm11743772wms.3.2022.12.08.05.16.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 05:16:04 -0800 (PST)
Message-ID: <799d6831-2af3-72c1-84b2-1f0454a46c07@redhat.com>
Date:   Thu, 8 Dec 2022 14:16:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 10/10] mm/hugetlb: Document why page_vma_mapped_walk()
 is safe to walk
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Jann Horn <jannh@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Rik van Riel <riel@surriel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>
References: <20221207203034.650899-1-peterx@redhat.com>
 <20221207203158.651092-1-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20221207203158.651092-1-peterx@redhat.com>
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

On 07.12.22 21:31, Peter Xu wrote:
> Taking vma lock here is not needed for now because all potential hugetlb
> walkers here should have i_mmap_rwsem held.  Document the fact.
> 
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   mm/page_vma_mapped.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> index e97b2e23bd28..2e59a0419d22 100644
> --- a/mm/page_vma_mapped.c
> +++ b/mm/page_vma_mapped.c
> @@ -168,8 +168,14 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>   		/* The only possible mapping was handled on last iteration */
>   		if (pvmw->pte)
>   			return not_found(pvmw);
> -
> -		/* when pud is not present, pte will be NULL */
> +		/*
> +		 * NOTE: we don't need explicit lock here to walk the
> +		 * hugetlb pgtable because either (1) potential callers of
> +		 * hugetlb pvmw currently holds i_mmap_rwsem, or (2) the
> +		 * caller will not walk a hugetlb vma (e.g. ksm or uprobe).
> +		 * When one day this rule breaks, one will get a warning
> +		 * in hugetlb_walk(), and then we'll figure out what to do.
> +		 */
>   		pvmw->pte = hugetlb_walk(vma, pvmw->address, size);
>   		if (!pvmw->pte)
>   			return false;

Would it make sense to squash that into the previous commit?

-- 
Thanks,

David / dhildenb

