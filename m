Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A454873113E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 09:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245149AbjFOHsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 03:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245141AbjFOHrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 03:47:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675FFED
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 00:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686815220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oAC3VUgTK58AFtVKiltpsFbsCaEbRXjpjSi3HmTg4+U=;
        b=UGOPw/AazkXOvJ5gbIz6X6gdHsW+UezXo3tQgNr69jd7MkQNz7I7on/rHX36RjDKzv3d5V
        nwS/XkI66IOh50WesUROVxO/7dVyrVBaPSgBAuOnKJ/ZZMpT2I0CRnf4ls1TU7z4fwsAKt
        LgfyF9rLljC4npEBKXy1YVs+DEj4rPM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-sYlEs9D1MrSso7i9yidQQg-1; Thu, 15 Jun 2023 03:46:57 -0400
X-MC-Unique: sYlEs9D1MrSso7i9yidQQg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f8e17708b0so4146135e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 00:46:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686815216; x=1689407216;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oAC3VUgTK58AFtVKiltpsFbsCaEbRXjpjSi3HmTg4+U=;
        b=SUvwVH5pVgkUNtDMp/Jc9W4Az/vvpwqGAt5mEo8n6ZdrvOvv9ji6uAuuvcnSwPQeu0
         LE6FB05GWGm/77IaYkalam8oaqua5El1ExtRvpPq2qZvbetL19i9IvHtOlMOj9rUBfJM
         En7JvoUF1WxAxC/MUkyKxLcoNpXmmfnzwT80kfGtePV77aROmcBtYB9KeUir5R8kTPJ8
         o8pdbIIqH8q60Z/71XD0VwzvhqHDM0/pVv2wtsN+LRDl7H+CAYZq1XAPO1/aTAkcez92
         joOYzjsS3dPDDHIkuwz7CP+6Ks6raI/afknA0DA38ZYKvKCR0ObLWapa217IJpQEwIj6
         lvTA==
X-Gm-Message-State: AC+VfDyHC3hXwfVcf5vlMq/XJgHVKMCOH0a0k6FVFvzHYC6f2dnMMCRM
        0ITRlhCxf/FUDDFmGYH3QdY/X3Swsu6PTL8b2ACKvNkbTniEzZaLjQWATRQNPhKDuRhKRg9+3C/
        yjHwTIrCWGy+sS8gAqTLr73qu
X-Received: by 2002:adf:f592:0:b0:30f:c679:793a with SMTP id f18-20020adff592000000b0030fc679793amr7440797wro.3.1686815216294;
        Thu, 15 Jun 2023 00:46:56 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6ByPKOjUuV6aqVpU6Kxdu/rKoMFQNGQoBKGhCydv3UJZ41+p4N/AV9s1LjZ5f/ZpfOQzYKbA==
X-Received: by 2002:adf:f592:0:b0:30f:c679:793a with SMTP id f18-20020adff592000000b0030fc679793amr7440781wro.3.1686815215804;
        Thu, 15 Jun 2023 00:46:55 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id k1-20020a5d6e81000000b0030e5ccaec84sm20400430wrz.32.2023.06.15.00.46.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 00:46:55 -0700 (PDT)
Message-ID: <5b5e7dd0-d60b-ca46-215c-f59947b805fe@redhat.com>
Date:   Thu, 15 Jun 2023 09:46:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     "Huang, Ying" <ying.huang@intel.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        akpm@linux-foundation.org, vbabka@suse.cz, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <770f9f61472b24b6bc89adbd71a77d9cf62bb54f.1686646361.git.baolin.wang@linux.alibaba.com>
 <20230614095501.m4porztaibchrgwx@techsingularity.net>
 <87ilbpo1d9.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <5f340d98-4ee0-35a9-58ed-943834d68042@linux.alibaba.com>
 <87fs6tfaw5.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2] mm: compaction: skip memory hole rapidly when
 isolating migratable pages
In-Reply-To: <87fs6tfaw5.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.06.23 09:22, Huang, Ying wrote:
> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
> 
>> On 6/15/2023 11:22 AM, Huang, Ying wrote:
>>> Hi, Mel,
>>> Mel Gorman <mgorman@techsingularity.net> writes:
>>>
>>>> On Tue, Jun 13, 2023 at 04:55:04PM +0800, Baolin Wang wrote:
>>>>> On some machines, the normal zone can have a large memory hole like
>>>>> below memory layout, and we can see the range from 0x100000000 to
>>>>> 0x1800000000 is a hole. So when isolating some migratable pages, the
>>>>> scanner can meet the hole and it will take more time to skip the large
>>>>> hole. From my measurement, I can see the isolation scanner will take
>>>>> 80us ~ 100us to skip the large hole [0x100000000 - 0x1800000000].
>>>>>
>>>>> So adding a new helper to fast search next online memory section
>>>>> to skip the large hole can help to find next suitable pageblock
>>>>> efficiently. With this patch, I can see the large hole scanning only
>>>>> takes < 1us.
>>>>>
>>>>> [    0.000000] Zone ranges:
>>>>> [    0.000000]   DMA      [mem 0x0000000040000000-0x00000000ffffffff]
>>>>> [    0.000000]   DMA32    empty
>>>>> [    0.000000]   Normal   [mem 0x0000000100000000-0x0000001fa7ffffff]
>>>>> [    0.000000] Movable zone start for each node
>>>>> [    0.000000] Early memory node ranges
>>>>> [    0.000000]   node   0: [mem 0x0000000040000000-0x0000000fffffffff]
>>>>> [    0.000000]   node   0: [mem 0x0000001800000000-0x0000001fa3c7ffff]
>>>>> [    0.000000]   node   0: [mem 0x0000001fa3c80000-0x0000001fa3ffffff]
>>>>> [    0.000000]   node   0: [mem 0x0000001fa4000000-0x0000001fa402ffff]
>>>>> [    0.000000]   node   0: [mem 0x0000001fa4030000-0x0000001fa40effff]
>>>>> [    0.000000]   node   0: [mem 0x0000001fa40f0000-0x0000001fa73cffff]
>>>>> [    0.000000]   node   0: [mem 0x0000001fa73d0000-0x0000001fa745ffff]
>>>>> [    0.000000]   node   0: [mem 0x0000001fa7460000-0x0000001fa746ffff]
>>>>> [    0.000000]   node   0: [mem 0x0000001fa7470000-0x0000001fa758ffff]
>>>>> [    0.000000]   node   0: [mem 0x0000001fa7590000-0x0000001fa7ffffff]
>>>>>
>>>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>>
>>>> This may only be necessary for non-contiguous zones so a check for
>>>> zone_contiguous could be made but I suspect the saving, if any, would be
>>>> marginal.
>>>>
>>>> However, it's subtle that block_end_pfn can end up in an arbirary location
>>>> past the end of the zone or past cc->free_pfn. As the "continue" will update
>>>> cc->migrate_pfn, that might lead to errors in the future. It would be a
>>>> lot safer to pass in cc->free_pfn and do two things with the value. First,
>>>> there is no point scanning for a valid online section past cc->free_pfn so
>>>> terminating after cc->free_pfn may save some cycles. Second, cc->migrate_pfn
>>>> does not end up with an arbitrary value which is a more defensive approach
>>>> to any future programming errors.
>>> I have thought about this before.  Originally, I had thought that we
>>> were safe because cc->free_pfn should be in a online section and
>>> block_end_pfn should reach cc->free_pfn before the end of zone.  But
>>> after checking more code and thinking about it again, I found that the
>>> underlying sections may go offline under us during compaction.  So that,
>>> cc->free_pfn may be in a offline section or after the end of zone.  So,
>>> you are right, we need to consider the range of block_end_pfn.
>>> But, if we thought in this way (memory online/offline at any time),
>>> it
>>> appears that we need to check whether the underlying section was
>>> offlined.  For example, is it safe to use "pfn_to_page()" in
>>> "isolate_migratepages_block()"?  Is it possible for the underlying
>>> section to be offlined under us?
>>
>> It is possible. There is a previous discussion[1] about the race
>> between pfn_to_online_page() and memory offline.
>>
>> [1]
>> https://lore.kernel.org/lkml/87zgc6buoq.fsf@nvidia.com/T/#m642d91bcc726437e1848b295bc57ce249c7ca399
> 
> Thank you very much for sharing!  That answers my questions directly!

I remember another discussion (but can't find it) regarding why memory 
compaction can get away without pfn_to_online_page() all over the place. 
The use is limited to __reset_isolation_pfn().

But yes, in theory pfn_to_online_page() can race with memory offlining.

-- 
Cheers,

David / dhildenb

