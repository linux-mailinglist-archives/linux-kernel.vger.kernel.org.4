Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7A0647070
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 14:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiLHNGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 08:06:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiLHNGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 08:06:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B80CE01
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 05:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670504741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G4cFc8Temq+w0DYrWdjMcxtoGARvIjvLcHmmwSHCKIw=;
        b=B1atHWQyp5MUJlMpSOzZ3wUkvqQI86odr2FQpyy/Lo+0h9XTAlcyHGWqfsDA27aRjS1sjz
        lsCTLN7xVvnFt5JZttDNx93Cqc6yXlfrQsF3PF7u0TDaKRJ7SimgoHfJt9dDAaBDjkmsdn
        jYOZxRAegnh3YV9jwz7PM2yvQ681Wts=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-593-apg63BQuO_yC14Gy9hCLlg-1; Thu, 08 Dec 2022 08:05:38 -0500
X-MC-Unique: apg63BQuO_yC14Gy9hCLlg-1
Received: by mail-wm1-f70.google.com with SMTP id s24-20020a7bc398000000b003d087485a9aso611409wmj.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 05:05:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G4cFc8Temq+w0DYrWdjMcxtoGARvIjvLcHmmwSHCKIw=;
        b=NjafMeX0N9fA5Q0cii3+CpFDFXxOtXWYNsUee5z9N8LAvr/6f8MfHxxWEj5AU8fvXV
         NWjqqGYo3OiI2ig8t1amtUyWlFk8OoA44hm3hW24h5rE38OFHYau3ZT+UhMzpz5k15tQ
         rgN4BR6K7mRGyp/vJsjjI0ysanVbVhBW5jvKhnj8PtrDMM3FK269gyqQsDQ5HqXmx/ya
         AURBaKsw8fyBlvw6zuWGDCj03CAfGIRLoquUKg1RQQ/Z5wG5rOHoNuXkPf9cQxk8ZM/1
         nRhgy10mJy9PADgyMNcn0PAiR8rjqg7U7i1aWKdi9mDb3sLrfQtEBj6A51TGaFge1MW9
         /Ong==
X-Gm-Message-State: ANoB5pmn65uOs3G/OIeqpnn3/XjUOz9mi3zBsJTQ6CdAdgRJxtSnF04+
        We8j6hZzn0W9WSay0KsPUvaLjn0pF8Lh3YIiMVrNx9Bhg42PqF4w12VrfKhuXanfHEhiak9q+9a
        1DRB++ixEzNa3u31yMQmAl3MH
X-Received: by 2002:adf:a413:0:b0:242:1cbf:8f73 with SMTP id d19-20020adfa413000000b002421cbf8f73mr28184008wra.317.1670504736906;
        Thu, 08 Dec 2022 05:05:36 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5TGCakyMMVHnsf95161xPf76MW4Brp2FkZmMATCV3JFnGxzfGy7/DZIxZRlKyD5UxVm1NeKg==
X-Received: by 2002:adf:a413:0:b0:242:1cbf:8f73 with SMTP id d19-20020adfa413000000b002421cbf8f73mr28183996wra.317.1670504736583;
        Thu, 08 Dec 2022 05:05:36 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id l39-20020a05600c1d2700b003c6c4639ac6sm5444673wms.34.2022.12.08.05.05.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 05:05:35 -0800 (PST)
Message-ID: <63404406-1da7-901f-cec0-83746c9ea8a9@redhat.com>
Date:   Thu, 8 Dec 2022 14:05:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 03/10] mm/hugetlb: Document huge_pte_offset usage
Content-Language: en-US
To:     John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Jann Horn <jannh@google.com>, Rik van Riel <riel@surriel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>
References: <20221207203034.650899-1-peterx@redhat.com>
 <20221207203034.650899-4-peterx@redhat.com>
 <fea54b2f-2d17-394e-93f6-5d8ce69fd156@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <fea54b2f-2d17-394e-93f6-5d8ce69fd156@nvidia.com>
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

On 07.12.22 21:49, John Hubbard wrote:
> On 12/7/22 12:30, Peter Xu wrote:
>> huge_pte_offset() is potentially a pgtable walker, looking up pte_t* for a
>> hugetlb address.
>>
>> Normally, it's always safe to walk a generic pgtable as long as we're with
>> the mmap lock held for either read or write, because that guarantees the
>> pgtable pages will always be valid during the process.
>>
>> But it's not true for hugetlbfs, especially shared: hugetlbfs can have its
>> pgtable freed by pmd unsharing, it means that even with mmap lock held for
>> current mm, the PMD pgtable page can still go away from under us if pmd
>> unsharing is possible during the walk.
>>
>> So we have two ways to make it safe even for a shared mapping:
>>
>>     (1) If we're with the hugetlb vma lock held for either read/write, it's
>>         okay because pmd unshare cannot happen at all.
>>
>>     (2) If we're with the i_mmap_rwsem lock held for either read/write, it's
>>         okay because even if pmd unshare can happen, the pgtable page cannot
>>         be freed from under us.
>>
>> Document it.
>>
>> Signed-off-by: Peter Xu <peterx@redhat.com>
>> ---
>>    include/linux/hugetlb.h | 32 ++++++++++++++++++++++++++++++++
>>    1 file changed, 32 insertions(+)
> 
> Looks good, with a couple of minor wording tweaks below that you might
> consider folding in, but either way,
> 
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> 
>>
>> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
>> index 551834cd5299..81efd9b9baa2 100644
>> --- a/include/linux/hugetlb.h
>> +++ b/include/linux/hugetlb.h
>> @@ -192,6 +192,38 @@ extern struct list_head huge_boot_pages;
>>    
>>    pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
>>    			unsigned long addr, unsigned long sz);
>> +/*
>> + * huge_pte_offset(): Walk the hugetlb pgtable until the last level PTE.
>> + * Returns the pte_t* if found, or NULL if the address is not mapped.
>> + *
>> + * Since this function will walk all the pgtable pages (including not only
>> + * high-level pgtable page, but also PUD entry that can be unshared
>> + * concurrently for VM_SHARED), the caller of this function should be
>> + * responsible of its thread safety.  One can follow this rule:
> 
>        "responsible for"
> 
>> + *
>> + *  (1) For private mappings: pmd unsharing is not possible, so it'll
>> + *      always be safe if we're with the mmap sem for either read or write.
> 
> mmap sem is sooo two years ago! :)
> 
>> + *      This is normally always the case, IOW we don't need to do anything
> 
> "normally always" hurts my sense of logic. And "IOW" is for typing very quickly
> in chats or email, not for long term documentation that is written rarely
> and read many times.
> 
>> + *      special.
> 
> So putting all that together, maybe:
> 
>    *  (1) For private mappings: pmd unsharing is not possible, so holding the
>    *      mmap_lock for either read or write is sufficient. Most callers already
>    *      hold the mmap_lock, so normally, no special action is required.

With that,

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

