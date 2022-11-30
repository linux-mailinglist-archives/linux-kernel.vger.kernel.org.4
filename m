Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6911563DAB4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 17:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbiK3QdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 11:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiK3Qc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 11:32:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5018E1E73C
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 08:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669825917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pEkc/NdzJ5BAtLBUXs3aV4VjbEYHVP21kc0vslGaB3o=;
        b=FDhwRcC/Kqt4MHj2n+rtaDxETbN5uhiVBkeVTS+kotgms0zAijIC2z6ErTcU7zqgYcrt1s
        2QMmhPkBUjjG/Fih5UbryIQmi9JdunHR3D/BR0oNECMdNHtHzY/15OJ+XeC8S9i/yY5muR
        mv7/QLBBQ3CP7wAHk6sPzhSgRIYTb/8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-260-EbMczosnP7CdPM1k16VzaA-1; Wed, 30 Nov 2022 11:31:55 -0500
X-MC-Unique: EbMczosnP7CdPM1k16VzaA-1
Received: by mail-wm1-f71.google.com with SMTP id 204-20020a1c02d5000000b003d06031f2cfso3461733wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 08:31:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pEkc/NdzJ5BAtLBUXs3aV4VjbEYHVP21kc0vslGaB3o=;
        b=QfkPOqSwSdru0SUBTmIo93UoyCM8xAxUpclLZtgKT31Gschbf9J5qIcJ2aR8iJyfby
         LdFmiO53NVdCzIYsP/nGmVsvzGSXsfqvn5edQdpSFBNDK2cNSPi+0p54P+TOG6PhjMHe
         pBfG+EkmJlpXb8yWbbEqEM+WayyPXj5+YPNzzhehGXYiJSL0IQlty0nMvtiIIa71yZqT
         TWiEpyBFqKJRBp30QLrJERCy5KsGHExsDBNAanyfmaaM9jWA1PCkgR3lCivy82MBg07w
         8HjVMLCEDpeBWMa/CtKaBILqnl4sP21HV/3SMdBWaJNFfn4uhmLiJjPwHdHvAAYJdJWm
         iNvQ==
X-Gm-Message-State: ANoB5plmrp8QnAVFb6HE+ZcrZk/XL2yzkCm8q7ReoLekooPayeB7tpzC
        8qJ9h5p9XhB+ZW/+EcDREFWCHxMWNRVMaSABtn6k5WtaL8TAhF+2dtl0mF0zoKBcSHB34ZJmYjG
        2t0glvnV+XoTbuJ2yDQFs4UTp
X-Received: by 2002:adf:f605:0:b0:241:ea0f:f0eb with SMTP id t5-20020adff605000000b00241ea0ff0ebmr25332817wrp.358.1669825914684;
        Wed, 30 Nov 2022 08:31:54 -0800 (PST)
X-Google-Smtp-Source: AA0mqf538u/c9H8IV7ppsdCRQf7/+KO5mEY+8fN5YYe6gxPZB8H/ZZlnKzNCfJQNf/zaE3lTvoYp/Q==
X-Received: by 2002:adf:f605:0:b0:241:ea0f:f0eb with SMTP id t5-20020adff605000000b00241ea0ff0ebmr25332794wrp.358.1669825914375;
        Wed, 30 Nov 2022 08:31:54 -0800 (PST)
Received: from ?IPV6:2003:cb:c703:7600:a8ea:29ce:7ee3:dd41? (p200300cbc7037600a8ea29ce7ee3dd41.dip0.t-ipconnect.de. [2003:cb:c703:7600:a8ea:29ce:7ee3:dd41])
        by smtp.gmail.com with ESMTPSA id d18-20020a5d6452000000b002366553eca7sm1896548wrw.83.2022.11.30.08.31.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 08:31:53 -0800 (PST)
Message-ID: <02f5ff51-c78c-ba87-e627-560b52090cbc@redhat.com>
Date:   Wed, 30 Nov 2022 17:31:52 +0100
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
 <b4bad424-9ae3-41e2-d844-6fa63f44be62@redhat.com> <Y4eD4EW2sAlb00RO@x1n>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Y4eD4EW2sAlb00RO@x1n>
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

On 30.11.22 17:25, Peter Xu wrote:
>          On Wed, Nov 30, 2022 at 05:11:36PM +0100, David Hildenbrand wrote:
>> On 30.11.22 17:09, Peter Xu wrote:
>>> On Wed, Nov 30, 2022 at 11:24:34AM +0100, David Hildenbrand wrote:
>>>> On 29.11.22 20:35, Peter Xu wrote:
>>>>> huge_pte_offset() is potentially a pgtable walker, looking up pte_t* for a
>>>>> hugetlb address.
>>>>>
>>>>> Normally, it's always safe to walk a generic pgtable as long as we're with
>>>>> the mmap lock held for either read or write, because that guarantees the
>>>>> pgtable pages will always be valid during the process.
>>>>>
>>>>> But it's not true for hugetlbfs, especially shared: hugetlbfs can have its
>>>>> pgtable freed by pmd unsharing, it means that even with mmap lock held for
>>>>> current mm, the PMD pgtable page can still go away from under us if pmd
>>>>> unsharing is possible during the walk.
>>>>>
>>>>> So we have two ways to make it safe even for a shared mapping:
>>>>>
>>>>>      (1) If we're with the hugetlb vma lock held for either read/write, it's
>>>>>          okay because pmd unshare cannot happen at all.
>>>>>
>>>>>      (2) If we're with the i_mmap_rwsem lock held for either read/write, it's
>>>>>          okay because even if pmd unshare can happen, the pgtable page cannot
>>>>>          be freed from under us.
>>>>>
>>>>> Document it.
>>>>>
>>>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>>>> ---
>>>>>     include/linux/hugetlb.h | 32 ++++++++++++++++++++++++++++++++
>>>>>     1 file changed, 32 insertions(+)
>>>>>
>>>>> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
>>>>> index 551834cd5299..81efd9b9baa2 100644
>>>>> --- a/include/linux/hugetlb.h
>>>>> +++ b/include/linux/hugetlb.h
>>>>> @@ -192,6 +192,38 @@ extern struct list_head huge_boot_pages;
>>>>>     pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
>>>>>     			unsigned long addr, unsigned long sz);
>>>>> +/*
>>>>> + * huge_pte_offset(): Walk the hugetlb pgtable until the last level PTE.
>>>>> + * Returns the pte_t* if found, or NULL if the address is not mapped.
>>>>> + *
>>>>> + * Since this function will walk all the pgtable pages (including not only
>>>>> + * high-level pgtable page, but also PUD entry that can be unshared
>>>>> + * concurrently for VM_SHARED), the caller of this function should be
>>>>> + * responsible of its thread safety.  One can follow this rule:
>>>>> + *
>>>>> + *  (1) For private mappings: pmd unsharing is not possible, so it'll
>>>>> + *      always be safe if we're with the mmap sem for either read or write.
>>>>> + *      This is normally always the case, IOW we don't need to do anything
>>>>> + *      special.
>>>>
>>>> Maybe worth mentioning that hugetlb_vma_lock_read() and friends already
>>>> optimize for private mappings, to not take the VMA lock if not required.
>>>
>>> Yes we can.  I assume this is not super urgent so I'll hold a while to see
>>> whether there's anything else that needs amending for the documents.
>>>
>>> Btw, even with hugetlb_vma_lock_read() checking SHARED for a private only
>>> code path it's still better to not take the lock at all, because that still
>>> contains a function jump which will be unnecesary.
>>
>> IMHO it makes coding a lot more consistent and less error-prone when not
>> care about whether to the the lock or not (as an optimization) and just
>> having this handled "automatically".
>>
>> Optimizing a jump out would rather smell like a micro-optimization.
> 
> Or we can move the lock helpers into the headers, too.

Ah, yes.

-- 
Thanks,

David / dhildenb

