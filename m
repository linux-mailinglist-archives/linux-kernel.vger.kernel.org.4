Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89A06A7DE6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 10:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjCBJie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 04:38:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjCBJic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 04:38:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D62E15C96
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 01:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677749868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xCyIOQlAHowOBFpFZNERppk5qbkMBHYYddRv3uQrzRM=;
        b=bCE1lrMZdTHVG1bELtpZFIKPiAZYYQpZbY+6aXUnnqWpO349zS3fI3/6cAnSTTWuBEjV5q
        kaK3eNkB4DZRLzDbaIqICGixHrN7C1Lsny2yiqYe0SPI9z4e9tVdzAeYHZ7EMGQBTM+jCk
        N+sEnla4Uvls2+Vc0ieH10S6ZEWdjYY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-daLDT85ZPZCqtrem6ebldA-1; Thu, 02 Mar 2023 04:37:47 -0500
X-MC-Unique: daLDT85ZPZCqtrem6ebldA-1
Received: by mail-wm1-f72.google.com with SMTP id z6-20020a05600c220600b003e222c9c5f4so5526146wml.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 01:37:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xCyIOQlAHowOBFpFZNERppk5qbkMBHYYddRv3uQrzRM=;
        b=aqRhpUZmZddhKLqhzwWuziaOmGz0gt8pKi2aBf2Xms9hzozM5tbuExZn3FJq1+eWCF
         1dnKYxSsAs2CLYyMZR+pHSzmkSxWUTJLRLPM+aXuFOxkG8wJwmjURYnZeBKhevfnVQ+i
         GAOlYKniYGqvUu9+uWaKH13c+yhvqXQfxmfEMJMvWe9NUErK9q8zx9Q57B01J84wyiuq
         FcBAf648OpmBfPuUq01EdrDYnTOPV6TxHatfj0ldWi0dkTSRj3osypagW+qSVSf4NRyR
         Hull2myRbPCvGpmcfiF6uyIgbRDRQTmxKGTd3anTlPWyHnRK48usCJtT8eSlCS4yYDLm
         YJJQ==
X-Gm-Message-State: AO0yUKUTFJXPKIpgVSWERt36mFkrjaOLBAYfYGD+b7T83ryN/eXtu+9R
        aI/ysIxOwrPKuV7DGOTG3IRjPAcJoUVPdwfbqMRcIwMkM/j/LTERv9VnuX7WhoNsVTC1i0iCoLm
        HL9uvwaJzdF6GQtfb7Nt6iZ5W
X-Received: by 2002:a05:600c:4a9f:b0:3eb:3908:8541 with SMTP id b31-20020a05600c4a9f00b003eb39088541mr6751781wmp.2.1677749865951;
        Thu, 02 Mar 2023 01:37:45 -0800 (PST)
X-Google-Smtp-Source: AK7set+yT0q8Eak3+0dGOMRr28r+W5fBZL7HrHJk+MpwmXUwrgNdDscuWuYDwQQDggZrOjJhQ5saSQ==
X-Received: by 2002:a05:600c:4a9f:b0:3eb:3908:8541 with SMTP id b31-20020a05600c4a9f00b003eb39088541mr6751763wmp.2.1677749865583;
        Thu, 02 Mar 2023 01:37:45 -0800 (PST)
Received: from ?IPV6:2003:cb:c70e:4f00:87ba:e9e9:3821:677b? (p200300cbc70e4f0087bae9e93821677b.dip0.t-ipconnect.de. [2003:cb:c70e:4f00:87ba:e9e9:3821:677b])
        by smtp.gmail.com with ESMTPSA id p20-20020a05600c205400b003e8dcc67bdesm2192666wmg.30.2023.03.02.01.37.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 01:37:45 -0800 (PST)
Message-ID: <8783f47e-76ea-cd24-e373-f2156884cd05@redhat.com>
Date:   Thu, 2 Mar 2023 10:37:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] mm/uffd: UFFD_FEATURE_WP_UNPOPULATED
Content-Language: en-US
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        "kernel@collabora.com" <kernel@collabora.com>
References: <20230227230044.1596744-1-peterx@redhat.com>
 <Y/1Mh5uivFt+zWKM@x1n> <e1e0ed70-76df-647f-30ac-0bb6ae8dc05c@collabora.com>
 <Y/4kjnom6MQqh9iA@x1n> <fb7ec372-2b16-14e1-a8cd-a90f4449661f@collabora.com>
 <640319be-ddb6-d74f-b731-eee5ceab3d01@collabora.com> <Y/9tA2EVglOJ0Ap1@x1n>
 <fc95fd2c-d661-926c-3bdb-8709cb49de3b@collabora.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <fc95fd2c-d661-926c-3bdb-8709cb49de3b@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.03.23 18:13, Muhammad Usama Anjum wrote:
> On 3/1/23 8:19 PM, Peter Xu wrote:
>> On Wed, Mar 01, 2023 at 12:55:51PM +0500, Muhammad Usama Anjum wrote:
>>> Hi Peter,
>>
>> Hi, Muhammad,
>>
>>> While using WP_UNPOPULATED, we get stuck if newly allocated memory is read
>>> without initialization. This can be reproduced by either of the following
>>> statements:
>>>      printf("%c", buffer[0]);
>>>      buffer[0]++;
>>>
>>> This bug has start to appear on this patch. How are you handling reading
>>> newly allocated memory when WP_UNPOPULATED is defined?
>>
>> Yes it's a bug, thanks for the reproducer. You're right I missed a trivial
>> but important detail.  Could you try apply below on top?
>>
>> ---8<---
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 46934133bd0b..2f4b3892948b 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -4062,7 +4062,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>>                                                  vma->vm_page_prot));
>>                  vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
>>                                  vmf->address, &vmf->ptl);
>> -               if (!pte_none(*vmf->pte)) {
>> +               if (vmf_pte_changed(vmf)) {
>>                          update_mmu_tlb(vma, vmf->address, vmf->pte);
>>                          goto unlock;
>>                  }
>> ---8<---
> This patch works. Thank you so much!
> 
>>
>> I can send a new version after you confirmed it at least works on your
>> side. I'll also add some more test to cover that in the next version.
>>
>> The current smoke test within this patch is really light; I somehow rely on
>> you on this patch on the testing side, and thanks for that.
>>
>>> Running my pagemap_ioctl selftest as benchmark in a VM:
>>> without zeropage / wp_unpopulated (decide from pte_none() if page is dirty
>>> or not, buggy and wrong implementation, just for reference)
>>> 26.608 seconds
>>> with zeropage
>>> 39.203 seconds
>>> with wp_unpopulated
>>> 62.907 seconds
>>>
>>> 136% worse performance overall
>>> 60% worse performance of unpopulated than zeropage
>>
>> Yes this is unfortunate, because we're protecting more things than before
>> when with WP_ZEROPAGE / WP_UNPOPULATED but that's what it is for (when we
>> want to make sure that accuracy on the holes).
>>
>> I didn't look closer to your whole test suite yet, but my pure test on
>> protection above should mean that it's still much better for such a use
>> case than either (1) pre-read or (2) MADV_POPULATE_READ.
> Ohh... I should stop comparing UNPOPULATE with buggy implementation and
> compare with pre-read. I've compared apples with oranges.

Note that I think there are ways to avoid that overhead (as raised in 
reply to Peter's reply), so IMHO it's still valuable to know which 
benefit we could have without allocating pagetables and placing the 
shared zeropages.

> 
> I'll do better benchmark for the comparison sake. I'll let you know if the
> performance is becoming an issue. Overall we need pagemap_ioctl + UFFD to
> correctly emulate Windows syscall. Secondly we also need good performance
> (more the better).

I'm curious, are you eventually applying UFFD to possibly large (sparse) 
VMAs, that are eventually even only PROT_READ or PROT_WRITE?

Especially for such large sparse VMAs, the current way of allocating 
pagetables to place markers/zeropages is far from optimal.

-- 
Thanks,

David / dhildenb

