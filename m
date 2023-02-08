Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A300768F026
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 14:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjBHNwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 08:52:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBHNwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 08:52:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352CA358F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 05:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675864287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8f4Lc2ZsDECvEyXxTOnp5TT2eF3kMdrxVivxOD7lHPg=;
        b=G+OQMs7s5yIBweI21JcElhEuannU9pLG6/qoO1ZSVS/GscwDcumh6CqGZ5AktU0j0AqCCb
        yVlBHBFoKeCrbZmUPs8JfUB42C3YatcErEgRAVgogRUNjhn5MRBzGVUt3Z3+NedLdd3Qqg
        gVvT/o14UlqGhG4KxK5f1Od2IOmGc18=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-563-dCWgrDZTPVW0phUszKXDaA-1; Wed, 08 Feb 2023 08:51:20 -0500
X-MC-Unique: dCWgrDZTPVW0phUszKXDaA-1
Received: by mail-wm1-f71.google.com with SMTP id k9-20020a05600c1c8900b003dc5dec2ac6so1169408wms.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 05:51:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8f4Lc2ZsDECvEyXxTOnp5TT2eF3kMdrxVivxOD7lHPg=;
        b=NpoI+U6ERXJWNKbSgTGTkC1mnkHh8PTmwFmqhJh9IVaWYp648ztJx3L/Puh+zBIrmM
         oBtpAEgHOL6VojrXSy+3UOnJDfaL60thL8lzLaM/etZL+KItegx8F38vNXMNWgDGcx6+
         NpwMwGKWNp/WDn1v9yr157+zNKV9t30BA+RUnN48JQfGMgPM92hhzpy0pXVC8DSt2Xit
         KJjkWq34Dg6ITHObDWT8gLL+4t32OObJQexGmXyMc3UPx8m+BmVCrEBgvgJB1p4yt8sx
         GDTQQeOASEnuIIzNmTjhUxT7MhDqT0ss4XHyotDMAvHevun/EJfK8TW+4xZdiXHKGCDx
         u+cw==
X-Gm-Message-State: AO0yUKVaSza5nHrBr1skKDy+a/QJzg5mmIGQaYa5MhHFOA1lGnHZVJiv
        oqyjTLfF56E6IFSQbQBctTs9lOUxbC252+egBBqRtCArPdzsAMbFIqo/cR/l13eyOBWbbHo0BLv
        8ZvU9+bVyv1LtKMGfDJxx2pAsFVDziw==
X-Received: by 2002:adf:e80e:0:b0:2bf:f44b:7a29 with SMTP id o14-20020adfe80e000000b002bff44b7a29mr6265282wrm.40.1675864279234;
        Wed, 08 Feb 2023 05:51:19 -0800 (PST)
X-Google-Smtp-Source: AK7set+/P8Hnan+RUsgyxcbtP3t9UYtqY6Y7Z2jiGR33JnciivnbxAm2l5SpqDi1orwZfoZ2eOLAoA==
X-Received: by 2002:adf:e80e:0:b0:2bf:f44b:7a29 with SMTP id o14-20020adfe80e000000b002bff44b7a29mr6265267wrm.40.1675864279005;
        Wed, 08 Feb 2023 05:51:19 -0800 (PST)
Received: from [192.168.3.108] (p5b0c66bc.dip0.t-ipconnect.de. [91.12.102.188])
        by smtp.gmail.com with ESMTPSA id v7-20020adfebc7000000b002bc7e5a1171sm13901113wrn.116.2023.02.08.05.51.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 05:51:18 -0800 (PST)
Message-ID: <a3d9550e-ed3a-9b05-99fe-f0ba8b38a2b9@redhat.com>
Date:   Wed, 8 Feb 2023 14:51:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 1/4] mm/mlock: return EINVAL if len overflows for
 mlock/munlock
Content-Language: en-US
To:     mawupeng <mawupeng1@huawei.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kuleshovmail@gmail.com, aneesh.kumar@linux.ibm.com
References: <20230128063229.989058-1-mawupeng1@huawei.com>
 <20230128063229.989058-2-mawupeng1@huawei.com>
 <753c53d3-84a6-da73-4121-0db4a71e4fde@redhat.com>
 <a5ae7d0c-61dc-3071-434d-5152c46c05e8@huawei.com>
 <10a3929a-7109-169f-6e42-e51c83305567@redhat.com>
 <c74516a1-9f9d-6c5f-0dc5-7ea07c975dfb@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <c74516a1-9f9d-6c5f-0dc5-7ea07c975dfb@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.02.23 02:24, mawupeng wrote:
> 
> 
> On 2023/2/7 1:05, David Hildenbrand wrote:
>> On 06.02.23 01:48, mawupeng wrote:
>>>
>>>
>>> On 2023/2/4 1:14, David Hildenbrand wrote:
>>>> On 28.01.23 07:32, Wupeng Ma wrote:
>>>>> From: Ma Wupeng <mawupeng1@huawei.com>
>>>>>
>>>>> While testing mlock, we have a problem if the len of mlock is ULONG_MAX.
>>>>> The return value of mlock is zero. But nothing will be locked since the
>>>>> len in do_mlock overflows to zero due to the following code in mlock:
>>>>>
>>>>>      len = PAGE_ALIGN(len + (offset_in_page(start)));
>>>>>
>>>>> The same problem happens in munlock.
>>>>>
>>>>> Add new check and return -EINVAL to fix this overflowing scenarios since
>>>>> they are absolutely wrong.
>>>>>
>>>>> Return 0 early to avoid burn a bunch of cpu cycles if len == 0.
>>>>>
>>>>> Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
>>>>> ---
>>>>>     mm/mlock.c | 14 ++++++++++++--
>>>>>     1 file changed, 12 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/mm/mlock.c b/mm/mlock.c
>>>>> index 7032f6dd0ce1..eb09968ba27f 100644
>>>>> --- a/mm/mlock.c
>>>>> +++ b/mm/mlock.c
>>>>> @@ -478,8 +478,6 @@ static int apply_vma_lock_flags(unsigned long start, size_t len,
>>>>>         end = start + len;
>>>>>         if (end < start)
>>>>>             return -EINVAL;
>>>>> -    if (end == start)
>>>>> -        return 0;
>>>>>         vma = mas_walk(&mas);
>>>>>         if (!vma)
>>>>>             return -ENOMEM;
>>>>> @@ -575,7 +573,13 @@ static __must_check int do_mlock(unsigned long start, size_t len, vm_flags_t fla
>>>>>         if (!can_do_mlock())
>>>>>             return -EPERM;
>>>>>     +    if (!len)
>>>>> +        return 0;
>>>>> +
>>>>>         len = PAGE_ALIGN(len + (offset_in_page(start)));
>>>>> +    if (!len)
>>>>> +        return -EINVAL;
>>>>> +
>>>>>         start &= PAGE_MASK;
>>>>
>>>> The "ordinary" overflows are detected in apply_vma_lock_flags(), correct?
>>>
>>> Overflow is not checked anywhere however the ordinary return early if len == 0 is detected in apply_vma_lock_flags().
>>>
>>
>> I meant the
>>
>> end = start + len;
>> if (end < start)
>>      return -EINVAL;
>>
>> Essentially, what I wanted to double-check is that with your changes, we catch all kinds of overflows as documented in the man page, correct?
> 
> Oh i see. You are right, The "ordinary" overflows are detected for mlock/munlock in apply_vma_lock_flags().
> 
> Yes, we may need to update the man page for all these four syscalls.

E.g., mlock() already documents "EINVAL (mlock(),  mlock2(),  and 
munlock()) The result of the addition addr+len was less than addr (e.g., 
the addition may have resulted in an overflow)."

Just to rephrase my question what I wanted to double-check: are we now 
identifying all such overflows or are you aware of other corner cases?

-- 
Thanks,

David / dhildenb

