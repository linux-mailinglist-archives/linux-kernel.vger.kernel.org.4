Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F48972E326
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 14:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242305AbjFMMh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 08:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234660AbjFMMh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 08:37:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEFA12A
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 05:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686659798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IwztSBCwtqouJyVErCmtPmLaRUsji80d2SLsW427MQ8=;
        b=ghk8X4sMqnwNsS+9tXsAraMWHN8HmQur+u6fCOw2OOWXCrw+UT3c7ME8nZtOw26GCtewcB
        KgoAichIplvRpyZifNEpQE/m91TVMIeOD3CraRsCI1JzhPUhHjfxqe+243Kd61Jx9BOWea
        rpZdIzt19BGahjdr+qdTveCLHcgJCPU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-1WxLAAXaOvajwuMNVzrQzg-1; Tue, 13 Jun 2023 08:36:36 -0400
X-MC-Unique: 1WxLAAXaOvajwuMNVzrQzg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-30af222c5feso3196215f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 05:36:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686659795; x=1689251795;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IwztSBCwtqouJyVErCmtPmLaRUsji80d2SLsW427MQ8=;
        b=SkmoDvlQlFFdNwpSWBKKpnOGgys2SGjMndDuZbOxq8ACEa4ZzwV1yU1ZLhKaLdOnbo
         UDapnlpPBtRYLBN/BAmyS88HvdWJDiTN1RKLPLNeo6zAqT59yrBvJ/YE021dey8+iN3U
         jW8RLoaEgX2iCDO14Q7KemKfwvPwtLL6k2UHrZa4vbYg0FDdIkUAiMMBxZemoyy/R+rF
         iyr7y9E4LKIOVw3K1olVlZ3DAjbu6Pp8fhIJG2lctftija9+bfrBaNoJadEOFZPJVCu2
         oeV5OamheEZdB1aYh59qPQ5D45Hea8gRG6CLCwgAo/2bn10Mz4sTPFmpMwmzmV6qNNxh
         DlPw==
X-Gm-Message-State: AC+VfDxNY6VlCQablvhvnfp+UjI2Wb/OL9Du9G8+9kW2gvM02+lG1o3e
        iziKdCEo1g1RV+pEncRBP/oDLqb06cWxxd3/xD46+pHxMmQ32ytKfucSN7VUDQudPMtbAgJUbZk
        CKXaSINTkjY1JcuQyhIlKxI9A
X-Received: by 2002:adf:fec1:0:b0:30f:aef1:2add with SMTP id q1-20020adffec1000000b0030faef12addmr7030262wrs.47.1686659795189;
        Tue, 13 Jun 2023 05:36:35 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5g2FT0ijPSlFtIsniv+3ENRlk0le0ANaVtXIyfFz3PWrUpJkfg0XSYPA4P9L0pBLdSDDDQ8A==
X-Received: by 2002:adf:fec1:0:b0:30f:aef1:2add with SMTP id q1-20020adffec1000000b0030faef12addmr7030246wrs.47.1686659794783;
        Tue, 13 Jun 2023 05:36:34 -0700 (PDT)
Received: from ?IPV6:2003:cb:c710:ff00:1a06:80f:733a:e8c6? (p200300cbc710ff001a06080f733ae8c6.dip0.t-ipconnect.de. [2003:cb:c710:ff00:1a06:80f:733a:e8c6])
        by smtp.gmail.com with ESMTPSA id v5-20020a5d43c5000000b0030abe7c36b1sm15151354wrr.93.2023.06.13.05.36.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 05:36:34 -0700 (PDT)
Message-ID: <77b2ffeb-732c-229e-0f41-f63f75e43164@redhat.com>
Date:   Tue, 13 Jun 2023 14:36:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] mm: compaction: skip memory hole rapidly when
 isolating migratable pages
Content-Language: en-US
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, vbabka@suse.cz, ying.huang@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <770f9f61472b24b6bc89adbd71a77d9cf62bb54f.1686646361.git.baolin.wang@linux.alibaba.com>
 <c9384e52-3f3b-cb1b-a607-955cd7066422@redhat.com>
 <838c3066-43e9-2035-cf69-4957481cddda@linux.alibaba.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <838c3066-43e9-2035-cf69-4957481cddda@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.06.23 13:13, Baolin Wang wrote:
> 
> 
> On 6/13/2023 5:56 PM, David Hildenbrand wrote:
>> On 13.06.23 10:55, Baolin Wang wrote:
>>> On some machines, the normal zone can have a large memory hole like
>>> below memory layout, and we can see the range from 0x100000000 to
>>> 0x1800000000 is a hole. So when isolating some migratable pages, the
>>> scanner can meet the hole and it will take more time to skip the large
>>> hole. From my measurement, I can see the isolation scanner will take
>>> 80us ~ 100us to skip the large hole [0x100000000 - 0x1800000000].
>>>
>>> So adding a new helper to fast search next online memory section
>>> to skip the large hole can help to find next suitable pageblock
>>> efficiently. With this patch, I can see the large hole scanning only
>>> takes < 1us.
>>>
>>> [    0.000000] Zone ranges:
>>> [    0.000000]   DMA      [mem 0x0000000040000000-0x00000000ffffffff]
>>> [    0.000000]   DMA32    empty
>>> [    0.000000]   Normal   [mem 0x0000000100000000-0x0000001fa7ffffff]
>>> [    0.000000] Movable zone start for each node
>>> [    0.000000] Early memory node ranges
>>> [    0.000000]   node   0: [mem 0x0000000040000000-0x0000000fffffffff]
>>> [    0.000000]   node   0: [mem 0x0000001800000000-0x0000001fa3c7ffff]
>>> [    0.000000]   node   0: [mem 0x0000001fa3c80000-0x0000001fa3ffffff]
>>> [    0.000000]   node   0: [mem 0x0000001fa4000000-0x0000001fa402ffff]
>>> [    0.000000]   node   0: [mem 0x0000001fa4030000-0x0000001fa40effff]
>>> [    0.000000]   node   0: [mem 0x0000001fa40f0000-0x0000001fa73cffff]
>>> [    0.000000]   node   0: [mem 0x0000001fa73d0000-0x0000001fa745ffff]
>>> [    0.000000]   node   0: [mem 0x0000001fa7460000-0x0000001fa746ffff]
>>> [    0.000000]   node   0: [mem 0x0000001fa7470000-0x0000001fa758ffff]
>>> [    0.000000]   node   0: [mem 0x0000001fa7590000-0x0000001fa7ffffff]
>>>
>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>> ---
>>> Changes from v1:
>>>    - Fix building errors if CONFIG_SPARSEMEM is not selected.
>>>    - Use NR_MEM_SECTIONS instead of '-1' per Huang Ying.
>>> ---
>>>    include/linux/mmzone.h | 10 ++++++++++
>>>    mm/compaction.c        | 30 +++++++++++++++++++++++++++++-
>>>    2 files changed, 39 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
>>> index 5a7ada0413da..5ff1fa2efe28 100644
>>> --- a/include/linux/mmzone.h
>>> +++ b/include/linux/mmzone.h
>>> @@ -2000,6 +2000,16 @@ static inline unsigned long
>>> next_present_section_nr(unsigned long section_nr)
>>>        return -1;
>>>    }
>>> +static inline unsigned long next_online_section_nr(unsigned long
>>> section_nr)
>>> +{
>>> +    while (++section_nr <= __highest_present_section_nr) {
>>> +        if (online_section_nr(section_nr))
>>> +            return section_nr;
>>> +    }
>>> +
>>> +    return NR_MEM_SECTIONS;
>>> +}
>>> +
>>>    /*
>>>     * These are _only_ used during initialisation, therefore they
>>>     * can use __initdata ...  They could have names to indicate
>>> diff --git a/mm/compaction.c b/mm/compaction.c
>>> index 3398ef3a55fe..c31ff6123891 100644
>>> --- a/mm/compaction.c
>>> +++ b/mm/compaction.c
>>> @@ -229,6 +229,28 @@ static void reset_cached_positions(struct zone
>>> *zone)
>>>                    pageblock_start_pfn(zone_end_pfn(zone) - 1);
>>>    }
>>> +#ifdef CONFIG_SPARSEMEM
>>> +static unsigned long skip_hole_pageblock(unsigned long start_pfn)
>>> +{
>>> +    unsigned long next_online_nr;
>>> +    unsigned long start_nr = pfn_to_section_nr(start_pfn);
>>> +
>>> +    if (online_section_nr(start_nr))
>>> +        return 0;
>>> +
>>> +    next_online_nr = next_online_section_nr(start_nr);
>>> +    if (next_online_nr < NR_MEM_SECTIONS)
>>> +        return section_nr_to_pfn(next_online_nr);
>>> +
>>
>> I would simply inline next_online_section_nr and simplify (and add a
>> comment):
>>
>> /*
>>    * If the PFN falls into an offline section, return the start PFN of the
>>    * next online section. If the PFN falls into an online section or if
>>    * there is no next online section, return 0.
>>    */
>> static unsigned long skip_hole_pageblock(unsigned long start_pfn)
>> {
>>       unsigned long nr = pfn_to_section_nr(start_pfn);
>>
>>       if (online_section_nr(nr))
>>           return 0;
>>
>>       while (++nr <= __highest_present_section_nr) {
>>           if (online_section_nr(nr))
>>               return section_nr_to_pfn(nr);
>>       }
>>       return 0
>> }
>>
>> Easier, no?
> 
> Originally I want to add a common helper like next_present_section_nr(),
> which can be used by other users. But yes, your suggestion is easier,
> and I am fine with that.
> 
>> And maybe just call that function "skip_offline_sections()" then?
>> Because we're not operating on pageblocks.
> 
> OK. Thanks.
> 

Feel free to add to the simplified version

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

