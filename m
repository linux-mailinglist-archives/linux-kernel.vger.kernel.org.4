Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE99637B1D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 15:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiKXOKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 09:10:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiKXOKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 09:10:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CAE557B7C
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 06:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669298984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NJ+D/KTl6NhD/RFPiBvQ0Vau+fFQwZX75ajP08DKdEQ=;
        b=EDKL+fFAzXTXlEiTQYuuT4g0EV9XPsn6ZoLMBk1GfffO3eQYX0L+2KvReEPncmB1tiAPbF
        8lJslOic63a9EYwJMItSiVhpjZ7SP99MpEACGAbQkm155oOuaXJo0yRPsGv18Gpgsmr8sf
        UIDcd/CtmbreoGLzrxjiF2xry8xE3zs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-646-wvOz5AxGNFmFcN1PBkv56A-1; Thu, 24 Nov 2022 09:09:35 -0500
X-MC-Unique: wvOz5AxGNFmFcN1PBkv56A-1
Received: by mail-wm1-f70.google.com with SMTP id h9-20020a1c2109000000b003cfd37aec58so1016670wmh.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 06:09:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NJ+D/KTl6NhD/RFPiBvQ0Vau+fFQwZX75ajP08DKdEQ=;
        b=gBVgdKdedqNuGMfQGTvdGIvQOimgWrzU4OwkCU7HGOw/LkdsgGG2e4mHKo0g+JV2QX
         LQyugBpRGdxE1asgwPjIQpOE6Uzv6SGF0j8G5aymiTku3DJxTu+FqFaPbfsIZBPr4jD/
         sXM8TBlhSzGcse8IY8/uwXMfm/W4x3htwtpU6ZbhbeXtcXja8vvO2TFJe7TVQSjiD6ZM
         WqQNF57MNHMa1VV7N27ETLrqIC32jW35Yr4E9gQz46ZEpc1tvDtiuAzYXwRtUmZ7jmrA
         h1cd+ZAf7fhZJsizw4D6QTHgdwqE0RWX9/MfBPa1bELvqucsri3ehSPlEYkb5ErvQtGR
         6EiA==
X-Gm-Message-State: ANoB5plYfn676WNObofPU73ffoi7bmoAoSxAXRGr1oB2lmFmsKCEVoAU
        eSOf3zNvC8xtqp53YUtwgVgE94jnNOcGsqnij74R16/WtQo8SbCnbtmTm6gfLOS5swoLKC6mtCq
        9uhUTfC6xudTEue79ZJdHcG3W
X-Received: by 2002:adf:d844:0:b0:241:be45:54eb with SMTP id k4-20020adfd844000000b00241be4554ebmr17582612wrl.49.1669298974538;
        Thu, 24 Nov 2022 06:09:34 -0800 (PST)
X-Google-Smtp-Source: AA0mqf77OtRG/YLhx6Vkq6egrXPnulFii95ZIm3sNBSeMylQ39e+7TkHrW908yWtjaOxFDw2vaYSoQ==
X-Received: by 2002:adf:d844:0:b0:241:be45:54eb with SMTP id k4-20020adfd844000000b00241be4554ebmr17582585wrl.49.1669298974185;
        Thu, 24 Nov 2022 06:09:34 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:2200:bfcb:7212:1370:de13? (p200300cbc7042200bfcb72121370de13.dip0.t-ipconnect.de. [2003:cb:c704:2200:bfcb:7212:1370:de13])
        by smtp.gmail.com with ESMTPSA id p16-20020a05600c1d9000b003b3307fb98fsm1914066wms.24.2022.11.24.06.09.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Nov 2022 06:09:33 -0800 (PST)
Message-ID: <31947f33-cd9e-adbb-2dcc-106a464438df@redhat.com>
Date:   Thu, 24 Nov 2022 15:09:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v2] mm: migrate: Fix THP's mapcount on isolation
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
To:     Gavin Shan <gshan@redhat.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        william.kucharski@oracle.com, ziy@nvidia.com,
        kirill.shutemov@linux.intel.com, zhenyzha@redhat.com,
        apopple@nvidia.com, hughd@google.com, willy@infradead.org,
        shan.gavin@gmail.com
References: <20221124095523.31061-1-gshan@redhat.com>
 <3c584ce6-dc8c-e0e4-c78f-b59dfff1fc13@redhat.com>
 <22407f18-0406-6ede-ef1e-592f03d3699e@redhat.com>
 <31bda0ab-a185-340d-b96b-b1cfed7c3910@redhat.com>
 <da854e1c-c876-b2f3-a2cb-56664da541bf@redhat.com>
 <759a17cf-e234-2601-bf42-7a40a4d89466@redhat.com>
Organization: Red Hat
In-Reply-To: <759a17cf-e234-2601-bf42-7a40a4d89466@redhat.com>
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

On 24.11.22 14:22, David Hildenbrand wrote:
> On 24.11.22 13:55, Gavin Shan wrote:
>> On 11/24/22 6:43 PM, David Hildenbrand wrote:
>>> On 24.11.22 11:21, Gavin Shan wrote:
>>>> On 11/24/22 6:09 PM, David Hildenbrand wrote:
>>>>> On 24.11.22 10:55, Gavin Shan wrote:
>>>>>> The issue is reported when removing memory through virtio_mem device.
>>>>>> The transparent huge page, experienced copy-on-write fault, is wrongly
>>>>>> regarded as pinned. The transparent huge page is escaped from being
>>>>>> isolated in isolate_migratepages_block(). The transparent huge page
>>>>>> can't be migrated and the corresponding memory block can't be put
>>>>>> into offline state.
>>>>>>
>>>>>> Fix it by replacing page_mapcount() with total_mapcount(). With this,
>>>>>> the transparent huge page can be isolated and migrated, and the memory
>>>>>> block can be put into offline state. Besides, The page's refcount is
>>>>>> increased a bit earlier to avoid the page is released when the check
>>>>>> is executed.
>>>>>
>>>>> Did you look into handling pages that are in the swapcache case as well?
>>>>>
>>>>> See is_refcount_suitable() in mm/khugepaged.c.
>>>>>
>>>>> Should be easy to reproduce, let me know if you need inspiration.
>>>>>
>>>>
>>>> Nope, I didn't look into the case. Please elaborate the details so that
>>>> I can reproduce it firstly.
>>>
>>>
>>> A simple reproducer would be (on a system with ordinary swap (not zram))
>>>
>>> 1) mmap a region (MAP_ANON|MAP_PRIVATE) that can hold a THP
>>>
>>> 2) Enable THP for that region (MADV_HUGEPAGE)
>>>
>>> 3) Populate a THP (e.g., write access)
>>>
>>> 4) PTE-map the THP, for example, using MADV_FREE on the last subpage
>>>
>>> 5) Trigger swapout of the THP, for example, using MADV_PAGEOUT
>>>
>>> 6) Read-access to some subpages to fault them in from the swapcache
>>>
>>>
>>> Now you'd have a THP, which
>>>
>>> 1) Is partially PTE-mapped into the page table
>>> 2) Is in the swapcache (each subpage should have one reference from the swapache)
>>>
>>>
>>> Now we could test, if alloc_contig_range() will still succeed (e.g., using virtio-mem).
>>>
>>
>> Thanks for the details. Step (4) and (5) can be actually combined. To swap part of
>> the THP (e.g. one sub-page) will force the THP to be split.
>>
>> I followed your steps in the attached program, there is no issue to do memory hot-remove
>> through virtio-mem with or without this patch.
> 
> Interesting. But I don't really see how we could pass this check with a
> page that's in the swapcache, maybe I'm missing something else.
> 
> I'll try to see if I can reproduce it.
> 

After some unsuccessful attempts and many head-scratches, I realized 
that it's quite simple why we don't have to worry about swapcache pages 
here:

page_mapping() is != NULL for pages in the swapcache: folio_mapping() 
makes this rather obvious:

if (unlikely(folio_test_swapcache(folio))
	return swap_address_space(folio_swap_entry(folio));


I think the get_page_unless_zero() might also be a fix for the 
page_mapping() call, smells like something could blow up on concurrent 
page freeing. (what about concurrent removal from the swapcache? nobody 
knows :) )


Thanks Gavin!

Acked-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

