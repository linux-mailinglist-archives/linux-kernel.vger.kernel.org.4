Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94EEB63DA47
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 17:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbiK3QMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 11:12:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbiK3QMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 11:12:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B0181DB0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 08:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669824701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j7/K8W5xLJ1MTcPVoq3LKtEdS3w02DLD54QmBsm/5yg=;
        b=hp4gjfgKOmn9grXrNoMZzeK0wtevlLkUqWHrE2NRWpocuE+MC+7dvGtjun1g0Ym5XJ9gdE
        c5ONIFVfuzLPA7E9BL04+NDib+47gYWZyE7Iw8nLMX2VbCamZHGQLqrZkxH/VRiikVJcBD
        Cja6aM2vXkjaaRdD1LAC1hozHSvuJEY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-479-RHuh2XiHMUW7tW4NSA2DfQ-1; Wed, 30 Nov 2022 11:11:39 -0500
X-MC-Unique: RHuh2XiHMUW7tW4NSA2DfQ-1
Received: by mail-wm1-f69.google.com with SMTP id c126-20020a1c3584000000b003cfffcf7c1aso1190445wma.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 08:11:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j7/K8W5xLJ1MTcPVoq3LKtEdS3w02DLD54QmBsm/5yg=;
        b=JfeLIx0SqKPSsu3Ap+HlMy54p65qtFQTVKQwx9ucegJ5gUJ1sIyGfBnbbXxvzC7hXw
         coJDdGHCQzO6lI4sKETEwoxa/ERIgkQp0v9Io1pzRJXi53cjAVKL82TGt6u8j58WmIKn
         U4D7HHtM4nVwEF+NeyCL6qh8ZpB5gYvxbmd+MrJyuqjsjePJwBb/BBcSHNm1nrC+n4cw
         UmV1Jvff3r6zyWfRtKju+6joROhGPenCWRceLUUgwkvKDfL/kAHuzUYgTybFErbV4o3I
         spw/zO/8Blcy/No5lQc4Px+r7jzKqmVaOaTf+Zx9GVQHvlryHnugd7eJxCTV1S/mVAE/
         8XXw==
X-Gm-Message-State: ANoB5pnnG8oUCeK5RBj/Ta7jSrCJ65M7sMWIo4ofQRqYgADnIfsmxOAf
        9vwMzyN5A52txCDuhSN7K/GApZIreB+kpCVdcNSpmKS8lJ50hD40YJ4vC9dMTN2jyn8gpVJWRT/
        4UBFo60CTDXXHeLx6/LQxusni
X-Received: by 2002:adf:dc0f:0:b0:241:e7b4:e10 with SMTP id t15-20020adfdc0f000000b00241e7b40e10mr23921881wri.423.1669824698738;
        Wed, 30 Nov 2022 08:11:38 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6XAHkXOyJKQ1Ux+KmxILsOrz8YtOr2Gmx1Av8naJIpA55ErjahSokbrqKoTyoo8rZQzT00xA==
X-Received: by 2002:adf:dc0f:0:b0:241:e7b4:e10 with SMTP id t15-20020adfdc0f000000b00241e7b40e10mr23921868wri.423.1669824698428;
        Wed, 30 Nov 2022 08:11:38 -0800 (PST)
Received: from ?IPV6:2003:cb:c703:7600:a8ea:29ce:7ee3:dd41? (p200300cbc7037600a8ea29ce7ee3dd41.dip0.t-ipconnect.de. [2003:cb:c703:7600:a8ea:29ce:7ee3:dd41])
        by smtp.gmail.com with ESMTPSA id t1-20020a5d49c1000000b00241e4bff85asm1858952wrs.100.2022.11.30.08.11.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 08:11:37 -0800 (PST)
Message-ID: <b4bad424-9ae3-41e2-d844-6fa63f44be62@redhat.com>
Date:   Wed, 30 Nov 2022 17:11:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 03/10] mm/hugetlb: Document huge_pte_offset usage
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        James Houghton <jthoughton@google.com>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
References: <20221129193526.3588187-1-peterx@redhat.com>
 <20221129193526.3588187-4-peterx@redhat.com>
 <afce1bdf-6b5f-3393-cafa-81148277773d@redhat.com> <Y4eAJuZRG0CLP7PW@x1n>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Y4eAJuZRG0CLP7PW@x1n>
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

On 30.11.22 17:09, Peter Xu wrote:
> On Wed, Nov 30, 2022 at 11:24:34AM +0100, David Hildenbrand wrote:
>> On 29.11.22 20:35, Peter Xu wrote:
>>> huge_pte_offset() is potentially a pgtable walker, looking up pte_t* for a
>>> hugetlb address.
>>>
>>> Normally, it's always safe to walk a generic pgtable as long as we're with
>>> the mmap lock held for either read or write, because that guarantees the
>>> pgtable pages will always be valid during the process.
>>>
>>> But it's not true for hugetlbfs, especially shared: hugetlbfs can have its
>>> pgtable freed by pmd unsharing, it means that even with mmap lock held for
>>> current mm, the PMD pgtable page can still go away from under us if pmd
>>> unsharing is possible during the walk.
>>>
>>> So we have two ways to make it safe even for a shared mapping:
>>>
>>>     (1) If we're with the hugetlb vma lock held for either read/write, it's
>>>         okay because pmd unshare cannot happen at all.
>>>
>>>     (2) If we're with the i_mmap_rwsem lock held for either read/write, it's
>>>         okay because even if pmd unshare can happen, the pgtable page cannot
>>>         be freed from under us.
>>>
>>> Document it.
>>>
>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>> ---
>>>    include/linux/hugetlb.h | 32 ++++++++++++++++++++++++++++++++
>>>    1 file changed, 32 insertions(+)
>>>
>>> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
>>> index 551834cd5299..81efd9b9baa2 100644
>>> --- a/include/linux/hugetlb.h
>>> +++ b/include/linux/hugetlb.h
>>> @@ -192,6 +192,38 @@ extern struct list_head huge_boot_pages;
>>>    pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
>>>    			unsigned long addr, unsigned long sz);
>>> +/*
>>> + * huge_pte_offset(): Walk the hugetlb pgtable until the last level PTE.
>>> + * Returns the pte_t* if found, or NULL if the address is not mapped.
>>> + *
>>> + * Since this function will walk all the pgtable pages (including not only
>>> + * high-level pgtable page, but also PUD entry that can be unshared
>>> + * concurrently for VM_SHARED), the caller of this function should be
>>> + * responsible of its thread safety.  One can follow this rule:
>>> + *
>>> + *  (1) For private mappings: pmd unsharing is not possible, so it'll
>>> + *      always be safe if we're with the mmap sem for either read or write.
>>> + *      This is normally always the case, IOW we don't need to do anything
>>> + *      special.
>>
>> Maybe worth mentioning that hugetlb_vma_lock_read() and friends already
>> optimize for private mappings, to not take the VMA lock if not required.
> 
> Yes we can.  I assume this is not super urgent so I'll hold a while to see
> whether there's anything else that needs amending for the documents.
> 
> Btw, even with hugetlb_vma_lock_read() checking SHARED for a private only
> code path it's still better to not take the lock at all, because that still
> contains a function jump which will be unnecesary.

IMHO it makes coding a lot more consistent and less error-prone when not 
care about whether to the the lock or not (as an optimization) and just 
having this handled "automatically".

Optimizing a jump out would rather smell like a micro-optimization.

-- 
Thanks,

David / dhildenb

