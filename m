Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D69A6369E8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 20:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237570AbiKWTcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 14:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235321AbiKWTcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 14:32:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62FC2A245
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 11:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669231882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=of6BBewdTwcAl18GJoeXpGt0yO4qHxqQv2rqdT+vNQU=;
        b=Aiiwel9IUcBYlLaiixBFsy8n2Ehp+5yKR0ESThaAjIxMXMgM9dF5d7stavt2+YFhmVhZLz
        iYPvCwWU/SzKM+245i/CXwAN0uInIZzL08Ba8m0A1FAA85gpk4y+DJ4WsystcTyc+7r8Nt
        mfnlE8lylTwe+cl9eG4ikrMxinDJCY4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-513-C2u4n5n2Prif3gq6Zu3POw-1; Wed, 23 Nov 2022 14:31:21 -0500
X-MC-Unique: C2u4n5n2Prif3gq6Zu3POw-1
Received: by mail-wm1-f70.google.com with SMTP id bg25-20020a05600c3c9900b003cf3ed7e27bso10001590wmb.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 11:31:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=of6BBewdTwcAl18GJoeXpGt0yO4qHxqQv2rqdT+vNQU=;
        b=0GgE3B2GdVrgsjh4VEewbxbRscFIpcxR8Ukt9c/wb2Gluo8rNR61JzSQdTMpPJ2bd4
         zr6C4I5D5NJIM6BPatrb7xtvnteBlHEOJab2Pb2wlB9+5uFdXoTh9S60FAyX6oA3ptg0
         v9edMG+5wK+TFFaIMcq/iHZFZMu8x+PDZH6XfmUWJruyx7/Jk4Ibm+GSR3DrkRXYYn3M
         dE2J+dCwxpiT9hO5D8xoy76CWv28eealjgS39xCTJxGc2y+Q6yPBQseRUGqqs51I+btn
         mHQ6Nc+R88KfPseE6TNU8Q8/efMtsvC7FT8DhCU1hvAZzr7Uep+MBcET6iG61e1M4Lya
         ECKw==
X-Gm-Message-State: ANoB5plTytpQvUx/JRbtccjC/faztr2t5irDxXDzsuWn66ievY1LLl9c
        le3QmWaulDQkmw5+ocfI4dBi93HFQDmpUPhwyrQcfHCQW5u3hDnwzyX2hCFjmy6FEGZdWLO2Kgm
        ZXAlwhcM/+TNctf/mC4z8POTB
X-Received: by 2002:a7b:c048:0:b0:3a8:3e58:bb9b with SMTP id u8-20020a7bc048000000b003a83e58bb9bmr11074614wmc.168.1669231880237;
        Wed, 23 Nov 2022 11:31:20 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4Wp/b0j11VObTynBBu9QcnlwyPQSskAgXFOBT/I+1/dIPrJfEOGaLa02LYRHt8G6iE5vlpVw==
X-Received: by 2002:a7b:c048:0:b0:3a8:3e58:bb9b with SMTP id u8-20020a7bc048000000b003a83e58bb9bmr11074594wmc.168.1669231879864;
        Wed, 23 Nov 2022 11:31:19 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:9f00:a98d:4026:7c44:40fd? (p200300cbc7049f00a98d40267c4440fd.dip0.t-ipconnect.de. [2003:cb:c704:9f00:a98d:4026:7c44:40fd])
        by smtp.gmail.com with ESMTPSA id u12-20020adfdb8c000000b002367ad808a9sm17174818wri.30.2022.11.23.11.31.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 11:31:19 -0800 (PST)
Message-ID: <6fc2066e-1386-5fc4-44c6-d84404c2ef25@redhat.com>
Date:   Wed, 23 Nov 2022 20:31:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH RFC v2 00/12] mm/hugetlb: Make huge_pte_offset()
 thread-safe for pmd unshare
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Rik van Riel <riel@surriel.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        James Houghton <jthoughton@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>
References: <20221118011025.2178986-1-peterx@redhat.com>
 <70376d57-7924-8ac9-9e93-1831248115a0@redhat.com> <Y343kIQ9l2d8wViz@x1n>
 <Y35kqkYQGW8ohKEa@monkey> <Y35swd4HHblyL3P7@x1n>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Y35swd4HHblyL3P7@x1n>
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

On 23.11.22 19:56, Peter Xu wrote:
> On Wed, Nov 23, 2022 at 10:21:30AM -0800, Mike Kravetz wrote:
>> On 11/23/22 10:09, Peter Xu wrote:
>>> On Wed, Nov 23, 2022 at 10:40:40AM +0100, David Hildenbrand wrote:
>>>> Let me try understand the basic problem first:
>>>>
>>>> hugetlb walks page tables semi-lockless: while we hold the mmap lock, we
>>>> don't grab the page table locks. That's very hugetlb specific handling and I
>>>> assume hugetlb uses different mechanisms to sync against MADV_DONTNEED,
>>>> concurrent page fault s... but that's no news. hugetlb is weird in many ways
>>>> :)
>>>>
>>>> So, IIUC, you want a mechanism to synchronize against PMD unsharing. Can't
>>>> we use some very basic locking for that?
>>>
>>> Yes we can in most cases.  Please refer to above paragraph [1] where I
>>> referred Mike's recent work on vma lock.  That's the basic locking we need
>>> so far to protect pmd unsharing.  I'll attach the link too in the next
>>> post, which is here:
>>>
>>> https://lore.kernel.org/r/20220914221810.95771-1-mike.kravetz@oracle.com
>>>
>>>>
>>>> Using RCU / disabling local irqs seems a bit excessive because we *are*
>>>> holding the mmap lock and only care about concurrent unsharing
>>>
>>> The series wanted to address where the vma lock is not easy to take.  It
>>> originates from when I was reading Mike's other patch, I forgot why I did
>>> that but I just noticed there's some code path that we may not want to take
>>> a sleepable lock, e.g. in follow page code.
>>
>> Yes, it was the patch suggested by David,
>>
>> https://lore.kernel.org/linux-mm/20221030225825.40872-1-mike.kravetz@oracle.com/
>>
>> The issue was that FOLL_NOWAIT could be passed into follow_page_mask.  If so,
>> then we do not want potentially sleep on the mutex.
>>
>> Since you both are on this thread, I thought of/noticed a related issue.  In
>> follow_hugetlb_page, it looks like we can call hugetlb_fault if FOLL_NOWAIT
>> is set.  hugetlb_fault certainly has the potential for sleeping.  Is this also
>> a similar issue?
> 
> Yeah maybe the clean way to do this is when FAULT_FLAG_RETRY_NOWAIT is set
> we should always try to not sleep at all.

hva_to_pfn_slow() that sets FOLL_NOWAIT calls get_user_pages_unlocked(), 
which will just do a straight mmap_read_lock().

The interpretation of FOLL_NOWAIT should not be "don't take any 
sleepable locks" but instead more like "don't wait for a page to get 
swapped in".

#define FOLL_NOWAIT  0x20  /* if a disk transfer is needed, start the IO


I did not read the full replies yet (sorry, busy hacking :) ) but *any* 
code path that already takes the mmap_read_lock() can just take whatever 
other lock we want -- IMHO. No need to over-complicate our code trying 
to avoid locks in that case.

-- 
Thanks,

David / dhildenb

