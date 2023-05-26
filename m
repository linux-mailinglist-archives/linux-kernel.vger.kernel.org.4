Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38300713000
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 00:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244126AbjEZWYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 18:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjEZWYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 18:24:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B0E10CB
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 15:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685139790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sdSWc76ZFLkjK5DbgpWrJvf7OomkiaCs2j7NqqLWdDc=;
        b=Wwip9dfLcsMGyfuU9A0d0TDnZWuRRKUMAxPlk2+m0n7icoCin0Odd+CWhNXsNV2pAVLYU0
        4xAXOYno/uGhT4Pi03wDbdvKzX43I7udwPxEnED4zLCS0nrRASmM+ilNzhtTaDT5AZI0HN
        GhL/eiKVcaZ+nIcOWXujdwSbkXK/ogI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-qB3GjLWuNSeMNzxDfzlUAA-1; Fri, 26 May 2023 18:23:01 -0400
X-MC-Unique: qB3GjLWuNSeMNzxDfzlUAA-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-625891d5ad5so2867136d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 15:23:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685139781; x=1687731781;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sdSWc76ZFLkjK5DbgpWrJvf7OomkiaCs2j7NqqLWdDc=;
        b=cvDlltmr5Of9dZcd6kPAs07pstuYXq5nj8PIxuoOkY09hzCNRFnmpVgOd7VFyi4a62
         RIpZ912uWe443pjW/jUeXc92+QbDmAjsN7kC+Uak+gi3ZmAnKElAtg4tLxTwkV9DJ1Gi
         JKOW6Ejp2SVFMf5SLoZw26EvPJ5NCewKWn3RJuxmDF2Bw0faRtYqrpo24d/gl+GXC1zM
         U2ABCxqGPQzgRSdTPVPnW0KqESqGnhk1P5HA3CrAWsZQUJiBrc+LGtDBibRY9TBhJ+cu
         fu1Xve5mEBSGv0bxhb73zsIT/gzVgfvM5GCawkQD81H0aNRti+d8zeKZ2sgoM5ZHW9FH
         /5rA==
X-Gm-Message-State: AC+VfDxqJXA6kMDmoBtEE+HqvWFa10/3ciqRSd574isKV8r4zxPIxwHL
        c55sPiUrNORd2rwyhlLZE6sNz4dctSpeWv/qBAgoLJ5bQcYKmCfibXHi/Kp5jEiZv3w80SpzHIb
        +sRqbxuiUKEIT1Oyd74Y1N1q3
X-Received: by 2002:a05:620a:268f:b0:75b:23a1:69e2 with SMTP id c15-20020a05620a268f00b0075b23a169e2mr3017440qkp.2.1685139781028;
        Fri, 26 May 2023 15:23:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4ZeeGHHci/qLUqfkn3pWI2o/xkqxrBBY8lANdvqLJP3SiikP3MddtHA4HXHCbi071gnaAMeA==
X-Received: by 2002:a05:620a:268f:b0:75b:23a1:69e2 with SMTP id c15-20020a05620a268f00b0075b23a169e2mr3017424qkp.2.1685139780779;
        Fri, 26 May 2023 15:23:00 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca. [70.24.86.62])
        by smtp.gmail.com with ESMTPSA id a13-20020a05620a124d00b0075936b3026fsm1480280qkl.38.2023.05.26.15.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 15:23:00 -0700 (PDT)
Date:   Fri, 26 May 2023 18:22:58 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Price <steven.price@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zack Rusin <zackr@vmware.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Song Liu <song@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 03/31] mm/pgtable: kmap_local_page() instead of
 kmap_atomic()
Message-ID: <ZHExQo3KO5PcVR76@x1n>
References: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com>
 <9df4aba7-fd2f-2da3-1543-fc6b4b42f5b9@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9df4aba7-fd2f-2da3-1543-fc6b4b42f5b9@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 21, 2023 at 09:52:31PM -0700, Hugh Dickins wrote:
> pte_offset_map() was still using kmap_atomic(): update it to the
> preferred kmap_local_page() before making further changes there, in case
> we need this as a bisection point; but I doubt it can cause any trouble.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
>  include/linux/pgtable.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 8ec27fe69dc8..94235ff2706e 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -96,9 +96,9 @@ static inline pte_t *pte_offset_kernel(pmd_t *pmd, unsigned long address)
>  
>  #if defined(CONFIG_HIGHPTE)
>  #define pte_offset_map(dir, address)				\
> -	((pte_t *)kmap_atomic(pmd_page(*(dir))) +		\
> +	((pte_t *)kmap_local_page(pmd_page(*(dir))) +		\
>  	 pte_index((address)))
> -#define pte_unmap(pte) kunmap_atomic((pte))
> +#define pte_unmap(pte) kunmap_local((pte))
>  #else
>  #define pte_offset_map(dir, address)	pte_offset_kernel((dir), (address))
>  #define pte_unmap(pte) ((void)(pte))	/* NOP */

(I think this could be a dumb question if this patch has been running there
 for years downstream, but still..)

I assume one major difference of using kmap_local() is page fault will not
be disabled, while kmap_atomic() will.

Meanwhile, pte_offset_map() is also used by pte_offset_map_lock(), which
means before this patch CONFIG_HIGHPTE systems will disable pgfault before
taking pgtable lock for it, while it will stop doing so after the change.

Then what happens if a page fault happens on the same pgtable lock range
that is already taken by the thread context?  What stops the deadlock from
happening?

Thanks,

-- 
Peter Xu

