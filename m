Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53CD06C456D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 09:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjCVIzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 04:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjCVIzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 04:55:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA3B1E1E0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 01:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679475260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IApH7V/JlJdEuuLgSYXZarTqHccnCAL1QO8ubX/jbCQ=;
        b=UKJtOgT//zyuo8XxHBT/53jU6wsZHDWY5f4R0kU75Sn2xDRP9wj4S+n5rt8zB8GSP62Qop
        GvmZCyz6JtJatGulKJsWelXLVOLC85lDHmD7Gu4OQHNDZgLsjR9jZfXZ80XF/3MMT4/Csq
        S3Eyxewqi3P3huNRa8ao0gtwbuSA304=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-2RVR0I-_PzOIr56-_YI8xA-1; Wed, 22 Mar 2023 04:54:19 -0400
X-MC-Unique: 2RVR0I-_PzOIr56-_YI8xA-1
Received: by mail-wm1-f72.google.com with SMTP id bi7-20020a05600c3d8700b003edecc610abso4598211wmb.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 01:54:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679475258;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IApH7V/JlJdEuuLgSYXZarTqHccnCAL1QO8ubX/jbCQ=;
        b=QgtpD7bcWXWo+H67UMV2UMjFqM9g64n5pwcO/d2hS64/MFqDew83J9p+ExZ7+L+eHu
         qkynL2bqx4RX/OQegZQ2gyQuBkrB+FINCYk+65WlWPV5sNWYiNOb/Ypkwwv8k/XL6uQB
         JDYIrdmvj59xZGP462vk66kChsONH14xGJbYtYMNmdxDGOiCgoSC0REagJCLCCHLHUEG
         hmCub7e5NSwa8OdUIehWVouvijrYa/O2xMuT33TOm13lv+dkRqUrR9MG2+7NpYpTWi5j
         5blQP9D4sGMLTIyLwQwUiUScbpH5yO2byQF7JWcwlA/3ctDDBvNrf4Ykjw2injxvT1H7
         jb3w==
X-Gm-Message-State: AO0yUKWPa3WNIcrViWvETDdYBCvDp5fNgPuzzZX+dG7cbOnyDp9W6uzh
        hYRChGyauno3npTDHj8YwmL5sN04G1ZHmL7FbwkeHFrtVX1cQIm25OlW3WNcwzSSBhFFtvkJbue
        EGpCS93aByfYegIVYSwy/2WjipEn78Vp8
X-Received: by 2002:a05:600c:228d:b0:3ed:a07b:c591 with SMTP id 13-20020a05600c228d00b003eda07bc591mr4743842wmf.1.1679475258040;
        Wed, 22 Mar 2023 01:54:18 -0700 (PDT)
X-Google-Smtp-Source: AK7set95drn2g5O/s1b42KEdPz4+LCYpJnJgOQFnwZgakJtZnoU5K1hIa8lWzMnEXqhx3uG3aCNH1g==
X-Received: by 2002:a05:600c:228d:b0:3ed:a07b:c591 with SMTP id 13-20020a05600c228d00b003eda07bc591mr4743830wmf.1.1679475257723;
        Wed, 22 Mar 2023 01:54:17 -0700 (PDT)
Received: from ?IPV6:2003:cb:c703:d00:ca74:d9ea:11e0:dfb? (p200300cbc7030d00ca74d9ea11e00dfb.dip0.t-ipconnect.de. [2003:cb:c703:d00:ca74:d9ea:11e0:dfb])
        by smtp.gmail.com with ESMTPSA id p20-20020a05600c469400b003ee2a0d49dbsm5197275wmo.25.2023.03.22.01.54.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 01:54:17 -0700 (PDT)
Message-ID: <9583bc53-716d-f2ff-38e7-1dda7e57dd5d@redhat.com>
Date:   Wed, 22 Mar 2023 09:54:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 1/4] mm/mlock: return EINVAL if len overflows for
 mlock/munlock
To:     mawupeng <mawupeng1@huawei.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kuleshovmail@gmail.com, aneesh.kumar@linux.ibm.com
References: <20230320024739.224850-1-mawupeng1@huawei.com>
 <20230320024739.224850-2-mawupeng1@huawei.com>
 <27b9cb5b-0118-f989-80c2-6a143a4232af@redhat.com>
 <3ef9520c-6713-527a-0214-ac7a8bb2d49c@huawei.com>
 <6dd844f7-d43b-c744-f295-9f14c68d3928@redhat.com>
 <8be13253-b4ca-b134-3e85-b4097484bb29@huawei.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <8be13253-b4ca-b134-3e85-b4097484bb29@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.03.23 03:14, mawupeng wrote:
> 
> 
> On 2023/3/21 22:19, David Hildenbrand wrote:
>> On 21.03.23 08:44, mawupeng wrote:
>>>
>>>
>>> On 2023/3/20 18:54, David Hildenbrand wrote:
>>>> On 20.03.23 03:47, Wupeng Ma wrote:
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
>>>>
>>>> Thinking again, wouldn't we reject mlock(0, ULONG_MAX) now as well?
>>>
>>> mlock will return 0 if len is zero which is the same w/o this patchset.
>>> Here is the calltrace if len is zero.
>>>
>>> mlock(len == 0)
>>>      do_mlock(len == 0)
>>>          if (!len)
>>>              return 0
>>>
>>
>> I was asking about addr=0, len=ULONG_MAX.
>>
>> IIUC, that used to work but could now fail? I haven't played with it, though.
> 
> Thanks for reviewing.
> 
> Previous for add = 0 and len == ULONG_MAX, mlock will return ok(0) since len overflows to zero.
> IFAICT, this is not right since mlock do noting(lock nothing) and return ok(0).
> 
> With this patch, for the same situation, mlock can return EINVAL as expected.

Quoting the man page:

"EINVAL (mlock(),  mlock2(),  and  munlock()) The result of the addition 
addr+len was less than addr (e.g., the addition may have resulted in an 
overflow)."

ULONG_MAX+0 = ULONG_MAX

There is no overflow expected. The proper way to implement it would be 
to handle that case and not fail with EINVAL.

At least that would be expected when reading the man page.

-- 
Thanks,

David / dhildenb

