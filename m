Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1C272BE94
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 12:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbjFLKP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 06:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbjFLKOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 06:14:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A1649F3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686563698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2+lliQQv0MFqMy2/MjnJS4GgfZK9CtTvSlEKJTTXlR0=;
        b=DOEe/Xew12p6V9pgc0y0z6YsJXrNH1s7W7EhoKevVRHuKl2RWd2gpdwe6PSrwfMNdmFlEy
        R5ZrrDo1kmqXil8ymRvI42KMtU9QjtL8WTLk0+xlaeZ0fYl3jEeT7HjR2wfh01LSEYZshS
        eq9wlv9EtYprb9xxh/E4BQEgmZrt814=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-t_O5PXXHOIi8hpvhlrifpQ-1; Mon, 12 Jun 2023 05:54:53 -0400
X-MC-Unique: t_O5PXXHOIi8hpvhlrifpQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f7ecc15771so18390315e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:54:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686563693; x=1689155693;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2+lliQQv0MFqMy2/MjnJS4GgfZK9CtTvSlEKJTTXlR0=;
        b=Lw2/EgeFTknFt6rfcy6ovkHdRFHQFGaUGfSnbiOxmDGtYQ0xEVH/mdfpIMFB9b5Xsf
         rriY60EAz4ZwghvDT3Po+G1zFIp3O4xJn1UsCkFBjBWUImNpIy6upO6BIPrHQtpjBfTa
         wt/eyjIEzdDPAvb5wvBvYfZw4/Om8MWOmBHzMBAc0SLM8F054Vm/AvSOlMkfZAPts2o/
         M683OWn2u/LHvkXv7sjX/YclJ8Vs3L6xQ4qw6Ek8G4GGc7eNw/yK/F3DVC6tL9p7T88T
         QsAVYeiVK3Ngv2MkWWvjyCRszfslymjGBYaDR3//kXrzKspJOoOjYe2pYg5tLxy+YtC/
         YKNw==
X-Gm-Message-State: AC+VfDxPda/WRgb3RrhGJDSerfyJhdHeee+rgcgSzTlep+d1a0qXqtPN
        S9MWP4MBubj21GuIXfZC7n4YYd7+zmsaNYe/+HPOcY/QUCdfWjCVCOKoOtY16e/VbMn2OqYGYtR
        gqNx/kfUsa3wC/YNuo38aHSV+
X-Received: by 2002:a1c:f70e:0:b0:3f4:1ce0:a606 with SMTP id v14-20020a1cf70e000000b003f41ce0a606mr6887900wmh.1.1686563692838;
        Mon, 12 Jun 2023 02:54:52 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7zaoW/4EJw3xh9E18HQ7DmUYd+SNWO5wWCUYsDX5fhzMtWJef4K3YX9DfpLzkdvYrozazasg==
X-Received: by 2002:a1c:f70e:0:b0:3f4:1ce0:a606 with SMTP id v14-20020a1cf70e000000b003f41ce0a606mr6887887wmh.1.1686563692460;
        Mon, 12 Jun 2023 02:54:52 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74e:1600:4f67:25b2:3e8c:2a4e? (p200300cbc74e16004f6725b23e8c2a4e.dip0.t-ipconnect.de. [2003:cb:c74e:1600:4f67:25b2:3e8c:2a4e])
        by smtp.gmail.com with ESMTPSA id i12-20020a05600c290c00b003f7e653c3e3sm10904071wmd.21.2023.06.12.02.54.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 02:54:51 -0700 (PDT)
Message-ID: <55e05ac0-041d-75eb-4707-e053dc3f2976@redhat.com>
Date:   Mon, 12 Jun 2023 11:54:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] mm: compaction: skip memory hole rapidly when isolating
 migratable pages
Content-Language: en-US
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Huang, Ying" <ying.huang@intel.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        vbabka@suse.cz, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <8cc668b77c8eb2fa78058b3d81386ebed9c5a9cd.1686294549.git.baolin.wang@linux.alibaba.com>
 <87sfax6v7c.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <d8444045-9497-1073-5cf9-e2959197701d@linux.alibaba.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <d8444045-9497-1073-5cf9-e2959197701d@linux.alibaba.com>
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

On 12.06.23 11:36, Baolin Wang wrote:
> 
> 
> On 6/12/2023 2:39 PM, Huang, Ying wrote:
>> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
>>
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
>>> [    0.000000] Zone ranges:
>>> [    0.000000]   DMA      [mem 0x0000000040000000-0x00000000ffffffff]
>>> [    0.000000]   DMA32    empty
>>> [    0.000000]   Normal   [mem 0x0000000100000000-0x0000001fa7ffffff]
>>> [    0.000000] Movable zone start for each node
>>> [    0.000000] Early memory node ranges
>>> [    0.000000]   node   0: [mem 0x0000000040000000-0x0000000fffffffff]
>>> [    0.000000]   node   0: [mem 0x0000001800000000-0x0000001fa3c7ffff]
>>> [    0.000000]   node   0: [mem 0x0000001fa3c80000-0x0000001fa3ffffff]
>>> [    0.000000]   node   0: [mem 0x0000001fa4000000-0x0000001fa402ffff]
>>> [    0.000000]   node   0: [mem 0x0000001fa4030000-0x0000001fa40effff]
>>> [    0.000000]   node   0: [mem 0x0000001fa40f0000-0x0000001fa73cffff]
>>> [    0.000000]   node   0: [mem 0x0000001fa73d0000-0x0000001fa745ffff]
>>> [    0.000000]   node   0: [mem 0x0000001fa7460000-0x0000001fa746ffff]
>>> [    0.000000]   node   0: [mem 0x0000001fa7470000-0x0000001fa758ffff]
>>> [    0.000000]   node   0: [mem 0x0000001fa7590000-0x0000001fa7ffffff]
>>>
>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>> ---
>>>    include/linux/mmzone.h | 10 ++++++++++
>>>    mm/compaction.c        | 23 ++++++++++++++++++++++-
>>>    2 files changed, 32 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
>>> index 5a7ada0413da..87e6c535d895 100644
>>> --- a/include/linux/mmzone.h
>>> +++ b/include/linux/mmzone.h
>>> @@ -2000,6 +2000,16 @@ static inline unsigned long next_present_section_nr(unsigned long section_nr)
>>>    	return -1;
>>>    }
>>>    
>>> +static inline unsigned long next_online_section_nr(unsigned long section_nr)
>>> +{
>>> +	while (++section_nr <= __highest_present_section_nr) {
>>> +		if (online_section_nr(section_nr))
>>> +			return section_nr;
>>> +	}
>>> +
>>> +	return -1UL;
>>> +}
>>> +
>>>    /*
>>>     * These are _only_ used during initialisation, therefore they
>>>     * can use __initdata ...  They could have names to indicate
>>> diff --git a/mm/compaction.c b/mm/compaction.c
>>> index 3398ef3a55fe..3a55fdd20c49 100644
>>> --- a/mm/compaction.c
>>> +++ b/mm/compaction.c
>>> @@ -229,6 +229,21 @@ static void reset_cached_positions(struct zone *zone)
>>>    				pageblock_start_pfn(zone_end_pfn(zone) - 1);
>>>    }
>>>    
>>> +static unsigned long skip_hole_pageblock(unsigned long start_pfn)
>>> +{
>>> +	unsigned long next_online_nr;
>>> +	unsigned long start_nr = pfn_to_section_nr(start_pfn);
>>> +
>>> +	if (online_section_nr(start_nr))
>>> +		return -1UL;
>>
>> Define a macro for the maigic "-1UL"?  Which is used for multiple times
>> in the patch.
> 
> I am struggling to find a readable macro for these '-1UL', since the
> '-1UL' in next_online_section_nr() indicates that it can not find an
> online section. However the '-1' in skip_hole_pageblock() indicates that
> it can not find an online pfn.

Maybe something like

#define SECTION_NR_INVALID -1UL

> 
> So after more thinking, I will change to return 'NR_MEM_SECTIONS' if can
> not find next online section in next_online_section_nr(). And in
> skip_hole_pageblock(), I will change to return 0 if can not find next
> online pfn. What do you think?

Well, 0 "might be" (and most likely is) a valid section number, so you'd 
simulate some kind-of a wraparound. I guess I'd prefer 
SECTION_NR_INVALID instead.

-- 
Cheers,

David / dhildenb

