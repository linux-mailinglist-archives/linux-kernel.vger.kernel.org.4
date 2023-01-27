Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4040367EAD6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 17:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234896AbjA0QZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 11:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234936AbjA0QYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 11:24:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A36D84948
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 08:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674836644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rBcfIHEg4jZbTQIImkzkLN9g2iVk6db6jthiIxejuwA=;
        b=JGnV88AJ0whKKFYNNvpsJ9PAgdk6VpN7eKOyf1GcO9tXJZNR7y7DDX8RbUejinfOixckKW
        9/viXG1ILs0BVy1VhYqbLWv23owcEu+pZEaEvzJTGcDWrlmL8m67cnmCvBgl0DtvL2R/wr
        FrXDCjdLGrvpg3RTbGuwssMmceNLI8k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-615-6pwFjO_qNDmkk_B_0Z0_6g-1; Fri, 27 Jan 2023 11:24:02 -0500
X-MC-Unique: 6pwFjO_qNDmkk_B_0Z0_6g-1
Received: by mail-wm1-f72.google.com with SMTP id bg24-20020a05600c3c9800b003db0ddddb6fso3062150wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 08:24:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rBcfIHEg4jZbTQIImkzkLN9g2iVk6db6jthiIxejuwA=;
        b=IZ2wpz++cO7CaHNlPv0a160feaZm8rrLhhjdF+Jc+eGQ5LB5fsW+vMmIrEawc9IQHa
         djz565qEA7/Tv9n+QVUEUbhXZ+GHvHWgAAuTxTBOa5l3wewNCSvtJ1ZkKwFCkIrvQqCs
         SI0BqFttIlL/7aY528LXTE5Ui9dzJKe7JB7xbcDcEnNRe1/TCkPJ++bxJ7ox8lPN+m31
         1o3Q3Ob0eooziY83K9dPGzHaN3B5UGcYBiGcx2DsWFHIgX8Hbb85Pjo7oEnML15rQoQi
         +dveEPfmfJaMY+9m9qrzB6W6ycVMHvAEChTfRMiYcZ4xdCCCZMvhMFiD5XMAjPMboMTC
         CAWw==
X-Gm-Message-State: AO0yUKXtCe1BuERTzOlKaTIX8x8f1JcTNPqiUwa+1o/SgLJYk/sjMXmB
        gQiAGbV6IdMLEEn0x1YZPv6b3NUd1grQNxXgXUCOJkCCjJei3qOiGkXd8S4dHDlyTLhfCyA1wn4
        /zoEvEx49vCiYJ+/BfGFZ+5F8
X-Received: by 2002:a5d:5588:0:b0:2bf:cfb4:2e2 with SMTP id i8-20020a5d5588000000b002bfcfb402e2mr3530685wrv.17.1674836641196;
        Fri, 27 Jan 2023 08:24:01 -0800 (PST)
X-Google-Smtp-Source: AK7set/Y+LNaZDyABiiOmf5N54VfZvfoeUt9bSW+AQh4dtqSkfuGAZY0DclafN1Se1z2VO+XUxpTjQ==
X-Received: by 2002:a5d:5588:0:b0:2bf:cfb4:2e2 with SMTP id i8-20020a5d5588000000b002bfcfb402e2mr3530671wrv.17.1674836640968;
        Fri, 27 Jan 2023 08:24:00 -0800 (PST)
Received: from ?IPV6:2003:d8:2f16:1800:a9b4:1776:c5d9:1d9a? (p200300d82f161800a9b41776c5d91d9a.dip0.t-ipconnect.de. [2003:d8:2f16:1800:a9b4:1776:c5d9:1d9a])
        by smtp.gmail.com with ESMTPSA id z14-20020a5d640e000000b002bfb5bda59asm4467446wru.25.2023.01.27.08.23.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 08:24:00 -0800 (PST)
Message-ID: <f9f13d4d-5882-2647-0032-e4f0e9296c69@redhat.com>
Date:   Fri, 27 Jan 2023 17:23:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 2/2] migrate: hugetlb: Check for hugetlb shared PMD in
 node migration
Content-Language: en-US
To:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        James Houghton <jthoughton@google.com>,
        Peter Xu <peterx@redhat.com>, Michal Hocko <mhocko@suse.com>,
        Yang Shi <shy828301@gmail.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org
References: <20230126222721.222195-1-mike.kravetz@oracle.com>
 <20230126222721.222195-3-mike.kravetz@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230126222721.222195-3-mike.kravetz@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.01.23 23:27, Mike Kravetz wrote:
> migrate_pages/mempolicy semantics state that CAP_SYS_NICE is required
> to move pages shared with another process to a different node.
> page_mapcount > 1 is being used to determine if a hugetlb page is shared.
> However, a hugetlb page will have a mapcount of 1 if mapped by multiple
> processes via a shared PMD.  As a result, hugetlb pages shared by multiple
> processes and mapped with a shared PMD can be moved by a process without
> CAP_SYS_NICE.
> 
> To fix, check for a shared PMD if mapcount is 1.  If a shared PMD is
> found consider the page shared.
> 
> Fixes: e2d8cf405525 ("migrate: add hugepage migration code to migrate_pages()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>   mm/mempolicy.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 85a34f1f3ab8..72142fbe7652 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -600,7 +600,8 @@ static int queue_pages_hugetlb(pte_t *pte, unsigned long hmask,
>   
>   	/* With MPOL_MF_MOVE, we migrate only unshared hugepage. */
>   	if (flags & (MPOL_MF_MOVE_ALL) ||
> -	    (flags & MPOL_MF_MOVE && page_mapcount(page) == 1)) {
> +	    (flags & MPOL_MF_MOVE && page_mapcount(page) == 1 &&
> +	     !hugetlb_pmd_shared(pte))) {
>   		if (isolate_hugetlb(page, qp->pagelist) &&
>   			(flags & MPOL_MF_STRICT))
>   			/*

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

