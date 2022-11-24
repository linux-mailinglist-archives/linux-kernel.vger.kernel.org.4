Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745066379D2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 14:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiKXNVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 08:21:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiKXNVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 08:21:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017667210B
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 05:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669296043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zKVh5LMLpMEzx628uR7TstqMz9DC8m5tstRZUPhlS3M=;
        b=copgreWoFxBynzOdfJW/2dFrZllg6HHMUi3Li/4ToGYbOB52xfi4P0kJLwbv4ptH/p223H
        gNaZZEgWS8kT0BriQ40rlUpisVYFsvMOPCJ3A/IUg7hJMQnuHFTAr1bbwt/ucrSHZuSDKs
        tunlq0cZ679GVb794th3RFaMLjSvzto=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-361-P6B1ycOLP4qSgh3-t5gHQA-1; Thu, 24 Nov 2022 08:20:41 -0500
X-MC-Unique: P6B1ycOLP4qSgh3-t5gHQA-1
Received: by mail-wr1-f72.google.com with SMTP id g14-20020adfa48e000000b00241f94bcd54so406712wrb.23
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 05:20:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zKVh5LMLpMEzx628uR7TstqMz9DC8m5tstRZUPhlS3M=;
        b=KkippERNNiagSjVrl1s5JGwbYBqj5Pm/AwmPZQMdLHx1RHtc9A2YHn+NcVBQ1uowiP
         7C48hiF49vnb0sXKT4S6j8I7d3cAhfVwqYwYkkOjF4LAx+3o/HprZkWT4lA4fzoscDjM
         A+jb2r26erlS9lPGzf9T5Sbbq/jyEGBSt3vVGxtyE+XCXEw/ru2jMKk572XK1DfEAJ+3
         MY7fowbkCbVa6Zn4y8kEPVYF1eWXApEPhy66lOEcWD2zuyRvVzc143EyZvRsu9laWt8g
         CRtd6591GsVE+N6NMi7kGYSYuaNpOGXOBN7d3oAnt8rInH6baCDwSdfjiMXJAWmC8KHU
         CxUg==
X-Gm-Message-State: ANoB5pnujUFMYdPvVWwBk2aUpbPlUJBx9b+pUOi3Zri5a+tgltFAcA0v
        j8PUCU7znpjl77QH3uePjTlSOEBnnkotAUDthy6pDrdmZ/k/rlW/3VLVhEtDQzIJNDbFWEJwUWY
        /hx1t2HHDNb5Pt28MKsoR0Hb/
X-Received: by 2002:a5d:5a8b:0:b0:241:b92b:d895 with SMTP id bp11-20020a5d5a8b000000b00241b92bd895mr14315198wrb.449.1669296040270;
        Thu, 24 Nov 2022 05:20:40 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7fbE6DnOhP990SWIzCZp2wuhX/dzyJ5UGMSxijAD+AF4Cy7yZbdWHbiYCcaV2k7ZnOQ6VLug==
X-Received: by 2002:a5d:5a8b:0:b0:241:b92b:d895 with SMTP id bp11-20020a5d5a8b000000b00241b92bd895mr14315178wrb.449.1669296039926;
        Thu, 24 Nov 2022 05:20:39 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:2200:bfcb:7212:1370:de13? (p200300cbc7042200bfcb72121370de13.dip0.t-ipconnect.de. [2003:cb:c704:2200:bfcb:7212:1370:de13])
        by smtp.gmail.com with ESMTPSA id bi25-20020a05600c3d9900b003cf4eac8e80sm2075927wmb.23.2022.11.24.05.20.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Nov 2022 05:20:39 -0800 (PST)
Message-ID: <5bafb39c-4365-b691-c516-4ce595af7ef7@redhat.com>
Date:   Thu, 24 Nov 2022 14:20:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v2] mm: migrate: Fix THP's mapcount on isolation
Content-Language: en-US
To:     Zi Yan <ziy@nvidia.com>
Cc:     Gavin Shan <gshan@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        william.kucharski@oracle.com, kirill.shutemov@linux.intel.com,
        zhenyzha@redhat.com, apopple@nvidia.com, hughd@google.com,
        willy@infradead.org, shan.gavin@gmail.com,
        Huang Ying <ying.huang@intel.com>
References: <20221124095523.31061-1-gshan@redhat.com>
 <3c584ce6-dc8c-e0e4-c78f-b59dfff1fc13@redhat.com>
 <22407f18-0406-6ede-ef1e-592f03d3699e@redhat.com>
 <31bda0ab-a185-340d-b96b-b1cfed7c3910@redhat.com>
 <D3D4DD02-F16F-4E9E-B1F0-65491F5B7207@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <D3D4DD02-F16F-4E9E-B1F0-65491F5B7207@nvidia.com>
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

On 24.11.22 13:38, Zi Yan wrote:
> 
> On 24 Nov 2022, at 5:43, David Hildenbrand wrote:
> 
>> On 24.11.22 11:21, Gavin Shan wrote:
>>> On 11/24/22 6:09 PM, David Hildenbrand wrote:
>>>> On 24.11.22 10:55, Gavin Shan wrote:
>>>>> The issue is reported when removing memory through virtio_mem device.
>>>>> The transparent huge page, experienced copy-on-write fault, is wrongly
>>>>> regarded as pinned. The transparent huge page is escaped from being
>>>>> isolated in isolate_migratepages_block(). The transparent huge page
>>>>> can't be migrated and the corresponding memory block can't be put
>>>>> into offline state.
>>>>>
>>>>> Fix it by replacing page_mapcount() with total_mapcount(). With this,
>>>>> the transparent huge page can be isolated and migrated, and the memory
>>>>> block can be put into offline state. Besides, The page's refcount is
>>>>> increased a bit earlier to avoid the page is released when the check
>>>>> is executed.
>>>>
>>>> Did you look into handling pages that are in the swapcache case as well?
>>>>
>>>> See is_refcount_suitable() in mm/khugepaged.c.
>>>>
>>>> Should be easy to reproduce, let me know if you need inspiration.
>>>>
>>>
>>> Nope, I didn't look into the case. Please elaborate the details so that
>>> I can reproduce it firstly.
>>
>>
>> A simple reproducer would be (on a system with ordinary swap (not zram))
>>
>> 1) mmap a region (MAP_ANON|MAP_PRIVATE) that can hold a THP
>>
>> 2) Enable THP for that region (MADV_HUGEPAGE)
>>
>> 3) Populate a THP (e.g., write access)
>>
>> 4) PTE-map the THP, for example, using MADV_FREE on the last subpage
>>
>> 5) Trigger swapout of the THP, for example, using MADV_PAGEOUT
> 
> Added the original THP swapout code author, Ying.
> 
> At this step, the THP will be split, right?
> 
> https://elixir.bootlin.com/linux/latest/source/mm/vmscan.c#L1786
> 
> Even if a THP has PMD mapping, IIRC, it is split in the add_to_swap()
> then swapped out. But I cannot find that split code now.

I recall there was some sequence to achieve it. Maybe it was
swapping out the PMD first and not triggering a PTE-mapping first.

mm/vmscan.c:shrink_folio_list()

if (folio_test_large(folio)) {
	/* cannot split folio, skip it */
	if (!can_split_folio(folio, NULL))
		goto activate_locked;
	/*
	 * Split folios without a PMD map right
	 * away. Chances are some or all of the
	 * tail pages can be freed without IO.
	 */
	if (!folio_entire_mapcount(folio) &&
	    split_folio_to_list(folio, folio_list))
		goto activate_locked;
	}
}

So the sequence might have to be

1) mmap a region (MAP_ANON|MAP_PRIVATE) that can hold a THP

2) Enable THP for that region (MADV_HUGEPAGE)

3) Populate a THP (e.g., write access)

4) Trigger swapout of the THP, for example, using MADV_PAGEOUT

5) Access some subpage

As we don't have PMD swap entries, we will PTE-map the
THP during try_to_unmap() IIRC.



Independent of that, the check we have here also doesn't consider
ordinary order-0 pages that might be in the swapache.

-- 
Thanks,

David / dhildenb

