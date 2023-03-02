Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D5A6A83FD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 15:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjCBONw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 09:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCBONu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 09:13:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D93BB92
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 06:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677766380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bKd8rPEmV4UERQunTxXjSiSz/2xedTBRivrunoUSBW0=;
        b=JAiVSIi179iE7Jk+oZR+H3dr+HkFXiGAQnrR+ZuoabS6ORPAaX6i1IcjQChSjd4pBCzksq
        GhbgtV/Bab0X0Mq5FMxY6b9tC5p18hu6gtOoCeDUCWxfccAt+gWjduockfSlMLZ6ejZNKJ
        +ec2O3GDCYsyFflkpv0X5xzgPeOXPeo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-202-9lmgYBhIO1-twAjLpdXrCA-1; Thu, 02 Mar 2023 09:12:58 -0500
X-MC-Unique: 9lmgYBhIO1-twAjLpdXrCA-1
Received: by mail-wr1-f72.google.com with SMTP id j2-20020adfa782000000b002ca9ab26627so3013976wrc.23
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 06:12:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bKd8rPEmV4UERQunTxXjSiSz/2xedTBRivrunoUSBW0=;
        b=0z8DCjASwBPnXpKnYUHVSCsfC0b10Zmhe7XBy9b0U5yw7Xmm8FKIyhUmzDoop+YQtI
         h5PMt1e2IkA5QfaOa+JAzGmAN519W/ZvQ3m8ViD/wwfCvUDRJp1b7VA77BiZn0beDjsa
         Tmsw1I0s58PDRVwIUitL2i78bhUd4t6kaLqsORl0aa26K0L6aesXZYPdcBcnCgt0qn8i
         gypgAmkbsoDReKR/eppGt6uukyGXyAsHRq0sb8h0QZJKjOuO7YQb9EX4lCjD6e/v9k9a
         eeYAF/dUr1dn0eqNfpHg9TEMgL0IPAeHteZXnn/eTHX68Dldhhj8gTttH7wDFyHzcahO
         xhhA==
X-Gm-Message-State: AO0yUKVtkK29dCVo+iS/Ois6wiTozavefGgRosZlSQpnIhBVS53jrbaK
        BvWW6Li4AyQEZ1I0J7lxzVfBFG0UCRJxHM4W97B0u/7OKJBiNszuIf1AutKRkjtCSSK57X9iGVN
        S4VqHI9NvJgdharkwUzMzyjefDi4V4A==
X-Received: by 2002:a5d:60d2:0:b0:2c5:587e:75ba with SMTP id x18-20020a5d60d2000000b002c5587e75bamr6955156wrt.55.1677766377582;
        Thu, 02 Mar 2023 06:12:57 -0800 (PST)
X-Google-Smtp-Source: AK7set8PgLYMjCA04jBmWxGzPzlNFoZHR6pbQHNtfTO8hgS3jeCv/FIwB37mxpdQjZikJ1B3/gR81Q==
X-Received: by 2002:a5d:60d2:0:b0:2c5:587e:75ba with SMTP id x18-20020a5d60d2000000b002c5587e75bamr6955144wrt.55.1677766377231;
        Thu, 02 Mar 2023 06:12:57 -0800 (PST)
Received: from ?IPV6:2003:cb:c70e:4f00:87ba:e9e9:3821:677b? (p200300cbc70e4f0087bae9e93821677b.dip0.t-ipconnect.de. [2003:cb:c70e:4f00:87ba:e9e9:3821:677b])
        by smtp.gmail.com with ESMTPSA id h8-20020adff188000000b002c54241b4fesm15245527wro.80.2023.03.02.06.12.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 06:12:56 -0800 (PST)
Message-ID: <c7fc5bc3-7f86-c699-2968-a861ab44989a@redhat.com>
Date:   Thu, 2 Mar 2023 15:12:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>
References: <Y+5uIS5E9sTLi41T@x1n>
 <456f8e2e-9554-73a3-4fdb-be21f9cc54b6@redhat.com> <Y+6NKPuty9V3nycI@x1n>
 <4dbc9913-3483-d22d-bbd2-e4f510fff56d@redhat.com> <Y/AIEvHJoMUnh4b6@x1n>
 <c463c421-2f33-9ae3-7d41-b394d1737d42@redhat.com> <Y/VQMyssclyIGa5i@x1n>
 <91d7c512-ee57-7d71-34b7-90e45f5c109b@redhat.com> <Y/Z9ACW8l2E3kOVk@x1n>
 <4b3c2f37-3b84-3147-7513-4293e5408fdd@redhat.com> <Y/5ZNTESKfntBSF3@x1n>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm/uffd: UFFD_FEATURE_WP_ZEROPAGE
In-Reply-To: <Y/5ZNTESKfntBSF3@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>
>> uffd-wp protecting a range:
>> * !pte_none() -> set uffd-wp bit and wrprotect
>> * pte_none() -> nothing to do
>> * PTE_UFFD_WP -> nothing to do
>> * PTE_UFFD_NO_WP -> set PTE_UFFD_WP
>>
>> unmapping a page (old way: !pte_none() -> pte_none()):
>> * uffd-wp bit set: set PTE_UFFD_WP
>> * uffd-wp bit not set: set PTE_UFFD_NO_WP
>>
>> (re)mapping a page (old: pte_none() -> !pte_none()):
>> * PTE_UFFD_WP -> set pte bit for new PTE
>> * PTE_UFFD_NO_WP -> don't set pte bit for new PTE
>> * pte_none() -> set pte bit for new PTE
>>
>> Zapping an anon page using MADV_DONTNEED is a bit confusing. It's actually
>> similar to a memory write (-> write zeroes), but we don't notify uffd-wp for
>> that (I think that's something you comment on below). Theoretically, we'd
>> want to set PTE_UFFD_NO_WP ("dirty") in the async mode. But that might need
>> more thought of what the expected semantics actually are.
>>
>> When we walk over the page tables we would get the following information
>> after protecting the range:
>>
>> * PTE_UFFD_WP -> clean, not modified since last protection round
>> * PTE_UFFD_NO_WP -> dirty, modified since last protection round
>> * pte_none() -> not mapped and therefore not modified since beginning of
>>                  protection.
>> * !pte_none() -> uffd-wp bit decides
> 
> I can't say I thought a lot but I feel like it may work. I'd probably avoid
> calling it PTE_UFFD_NO_WP or it'll be confusing.. maybe WP_WRITTEN or
> WP_RESOLVED instead.

I haven't thought about this further, but I maybe we might be able to 
just use a single PTE marker , because pte_none() would translate to 
PTE_UFFD_WP in such VMAs. So we could make the meaning of the 
PTE_UFFD_WP marker simply depend on the type of VMA.

If I am not wrong, we could stop setting PTE_UFFD_WP completely then, 
for any memory type (shmem/anon/hugetlb).

> 
> But that interface looks weird in that the protection happens right after
> VM_UFFD_WP applied to VMA and that keeps true until unregister.  One needs
> to reprotect using ioctl(UFFDIO_WRITEPROTECT) OTOH after the 1st round of
> tracking.  It just looks a little bit over-complicated, not to mention we
> will need two markers only for userfault-wp.  I had a feeling this
> complexity can cause us some trouble elsewhere.

When to apply this logic is indeed the interesting part. Doing it right 
from the beginning when the feature is enabled sounds like the simplest 
approach to me.  For background snapshots and dirty tracking that might 
just be good enough.


> 
> IIUC this can be something done on top even if it'll work (I think the

I think the API would have to change eventually, to enable it via a new 
feature ("unpopulated implies uffd-wp is active").

> userspace API doesn't need to change at all), so I'd suggest giving it some
> more thoughts and we start with simple and working.

Yes.

-- 
Thanks,

David / dhildenb

