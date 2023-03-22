Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A88D6C492A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 12:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjCVL22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 07:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjCVL20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 07:28:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D9E61320
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 04:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679484464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fExeCVSfXhamVGjGq2iHtJb90MRnZXhs1bW6+hfCEAk=;
        b=P/3GKN8N6UdzYn9rYnwSf4q0Qa1C2QDNIe7ghl5jPvU0DTOga4evpBW9ey2Aq37a7f+zCm
        rUsVeX3iqQ6eQ+n4QkwT5qnwgARkJJgB2E/Ur9qS1ZG3kc56dh55A/hDdVGIgmZb4FHxMa
        lnEHzwkOBs5utE/vS+4z+wJTvTN0qtw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-YqQ5GAwcME28WRictAqGrw-1; Wed, 22 Mar 2023 07:27:42 -0400
X-MC-Unique: YqQ5GAwcME28WRictAqGrw-1
Received: by mail-wm1-f71.google.com with SMTP id iv10-20020a05600c548a00b003ee112e6df1so3382041wmb.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 04:27:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679484461;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fExeCVSfXhamVGjGq2iHtJb90MRnZXhs1bW6+hfCEAk=;
        b=Cmyro5CHeaL6uY94nRaHhhgHdafKmu6H6J6pBwYvrj0qafKsOw2UPMewI/sct/bIAJ
         uZw9GuvyYcAQ9RWhnvb6ni3lvz5634CtiS4cfnQEhZ0ySAJTauUy7Gk2yp0UFDq31hEk
         okox3Rh9GNObPoN+9TwAfRmDpOsyBSFt/3Okr9Fkvq3z/ejZjHI0zrrTEWxx1tkuBjtb
         Pn6yp8ggzZzHpLGdApJCYG+ipWYaMymnIFUKzK/F2vs7DOO31j7yV91J0zd3/q2l5PKB
         32QO9KfN7QuJX7E97O57fjetB4pIDojEYY0fugkncXQlX/OQ9ocl2Onn1t9C+vW8Of22
         WZgw==
X-Gm-Message-State: AO0yUKU5O0k39vtn3heqO3jojZEUFSmz8gzse/te/kh5xkokjW/6alJC
        uS8j/Ds4qSpmBnCQxvZ8rcdmZKo7lSZmZm7p8yiIO/8GK5eblEBu3GfDU5XMxIXAeo3vZgZWmKF
        0EUx0posDyKlhvxt5qIkbGqxvXnbYn8lP
X-Received: by 2002:a5d:6105:0:b0:2d4:7e19:a7fa with SMTP id v5-20020a5d6105000000b002d47e19a7famr4903981wrt.50.1679484461624;
        Wed, 22 Mar 2023 04:27:41 -0700 (PDT)
X-Google-Smtp-Source: AK7set90ZlH6TY+pFDLKJMYrm5kRNQS5Xp1TtFAlh5J6Icw+XC5xE8rWEzD/kMpw4qEMgzdk2G/PgA==
X-Received: by 2002:a5d:6105:0:b0:2d4:7e19:a7fa with SMTP id v5-20020a5d6105000000b002d47e19a7famr4903969wrt.50.1679484461322;
        Wed, 22 Mar 2023 04:27:41 -0700 (PDT)
Received: from ?IPV6:2003:cb:c703:d00:ca74:d9ea:11e0:dfb? (p200300cbc7030d00ca74d9ea11e00dfb.dip0.t-ipconnect.de. [2003:cb:c703:d00:ca74:d9ea:11e0:dfb])
        by smtp.gmail.com with ESMTPSA id h13-20020a5d430d000000b002d75ef32032sm6682236wrq.68.2023.03.22.04.27.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 04:27:40 -0700 (PDT)
Message-ID: <3600eca8-1924-0a8e-ea9a-ab362c9e2967@redhat.com>
Date:   Wed, 22 Mar 2023 12:27:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 1/4] mm/mlock: return EINVAL if len overflows for
 mlock/munlock
Content-Language: en-US
To:     mawupeng <mawupeng1@huawei.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kuleshovmail@gmail.com, aneesh.kumar@linux.ibm.com
References: <20230320024739.224850-1-mawupeng1@huawei.com>
 <20230320024739.224850-2-mawupeng1@huawei.com>
 <27b9cb5b-0118-f989-80c2-6a143a4232af@redhat.com>
 <3ef9520c-6713-527a-0214-ac7a8bb2d49c@huawei.com>
 <6dd844f7-d43b-c744-f295-9f14c68d3928@redhat.com>
 <8be13253-b4ca-b134-3e85-b4097484bb29@huawei.com>
 <9583bc53-716d-f2ff-38e7-1dda7e57dd5d@redhat.com>
 <9b531543-9f97-178f-8a97-494322410806@redhat.com>
 <7473311c-b259-c90d-e19b-66c27fd49dba@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <7473311c-b259-c90d-e19b-66c27fd49dba@huawei.com>
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

On 22.03.23 10:20, mawupeng wrote:
> 
> 
> On 2023/3/22 17:01, David Hildenbrand wrote:
>> On 22.03.23 09:54, David Hildenbrand wrote:
>>> On 22.03.23 03:14, mawupeng wrote:
>>>>
>>>>
>>>> On 2023/3/21 22:19, David Hildenbrand wrote:
>>>>> On 21.03.23 08:44, mawupeng wrote:
>>>>>>
>>>>>>
>>>>>> On 2023/3/20 18:54, David Hildenbrand wrote:
>>>>>>> On 20.03.23 03:47, Wupeng Ma wrote:
>>>>>>>> From: Ma Wupeng <mawupeng1@huawei.com>
>>>>>>>>
>>>>>>>> While testing mlock, we have a problem if the len of mlock is ULONG_MAX.
>>>>>>>> The return value of mlock is zero. But nothing will be locked since the
>>>>>>>> len in do_mlock overflows to zero due to the following code in mlock:
>>>>>>>>
>>>>>>>>        len = PAGE_ALIGN(len + (offset_in_page(start)));
>>>>>>>>
>>>>>>>> The same problem happens in munlock.
>>>>>>>>
>>>>>>>> Add new check and return -EINVAL to fix this overflowing scenarios since
>>>>>>>> they are absolutely wrong.
>>>>>>>
>>>>>>> Thinking again, wouldn't we reject mlock(0, ULONG_MAX) now as well?
>>>>>>
>>>>>> mlock will return 0 if len is zero which is the same w/o this patchset.
>>>>>> Here is the calltrace if len is zero.
>>>>>>
>>>>>> mlock(len == 0)
>>>>>>        do_mlock(len == 0)
>>>>>>            if (!len)
>>>>>>                return 0
>>>>>>
>>>>>
>>>>> I was asking about addr=0, len=ULONG_MAX.
>>>>>
>>>>> IIUC, that used to work but could now fail? I haven't played with it, though.
>>>>
>>>> Thanks for reviewing.
>>>>
>>>> Previous for add = 0 and len == ULONG_MAX, mlock will return ok(0) since len overflows to zero.
>>>> IFAICT, this is not right since mlock do noting(lock nothing) and return ok(0).
>>>>
>>>> With this patch, for the same situation, mlock can return EINVAL as expected.
>>>
>>> Quoting the man page:
>>>
>>> "EINVAL (mlock(),  mlock2(),  and  munlock()) The result of the addition
>>> addr+len was less than addr (e.g., the addition may have resulted in an
>>> overflow)."
>>>
>>> ULONG_MAX+0 = ULONG_MAX
>>>
>>> There is no overflow expected. The proper way to implement it would be
>>> to handle that case and not fail with EINVAL.
>>>
>>> At least that would be expected when reading the man page.
>>>
>>
>> As a side note, I agree that failing with EINVAL is better than doing noting (mlocking nothing). But I am not sure what we are expected to do in that case ... the man page is a bit vague on that.
> 
> Thanks for you reviewing.
> 
> Can we try to expand the man page since overflow is considered in man page?

I guess we could spell out that Linux aligns the length up to the next 
page boundary, and that overflow checks are performed on this aligned 
length.

-- 
Thanks,

David / dhildenb

