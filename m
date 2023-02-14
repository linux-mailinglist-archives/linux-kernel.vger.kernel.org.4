Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC0C6962EB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 13:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbjBNMAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 07:00:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjBNMAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 07:00:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BAA4EDB
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 03:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676375923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xCI275q7Re7p2r++uBopIlhImbMsa+Jw/kg9hJ/qKDs=;
        b=a9hlxgt/xS39AdousOnQmDwjFNdxZ74w9Uvg+YUIBDPsrhEdamNbl0VlgHqecFRln0vmF5
        IOeM1IBjQyg1cyBUji5Ir1bOSb/b46/BiUEhZITj16ul8HAWb7OC9OjLdqoJe+CyfqgO66
        wHIkaai6NZG7fRsiGJ2hrXfuSGv1+pY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-581-BQqT5YiGOi28SWX3ul3nnA-1; Tue, 14 Feb 2023 06:58:42 -0500
X-MC-Unique: BQqT5YiGOi28SWX3ul3nnA-1
Received: by mail-wm1-f72.google.com with SMTP id b19-20020a05600c4e1300b003e10d3e1c23so10473354wmq.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 03:58:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xCI275q7Re7p2r++uBopIlhImbMsa+Jw/kg9hJ/qKDs=;
        b=w12+xBJfbG+LJODl5R/GD0kIYZ1jDffBcE0LnGYN4/2iyGYOOYjwXSGIkkJkm5ERBJ
         gJybrD4S2jJMyZm39PvLBbHhCUQaEXesrZ+Bmn8bgr+QfaVrkwPsSpFWIKM5UYEpjBIZ
         O5lTHuFAamRjCASjjsOnrNS7CoQVRLv9GdRE5V9pObM8Azm8q4nJ/TmL4rjVB2d7os7K
         1+olfB1ZLrH+mMuA8D8U47EizgBhXnmymqRx+/dp2ZWGCaTgaSYD/ettKJE/wPuFSU12
         rJXWfEpcSsNb133Ghh7KJGN556kwpmSfBQA3JNz8eVtQM5AYcPM8E8AJXmgOzU+pyA99
         dp+g==
X-Gm-Message-State: AO0yUKXcMWQ8moF8SEr91vt0dq3xV+ELKgXn1MqDdHoUPA5jtDxhsu09
        nT/ImvDkFyNXKqyVWB36YOGxSs9gaOzC8x/m9MvUum+pv54zsMf3YVqu5gAT5S6FohLdiOK0oLb
        Im4KQ6Eh1CoW3LSz8eda9iIFq
X-Received: by 2002:a05:600c:35c8:b0:3e0:fad:5fa8 with SMTP id r8-20020a05600c35c800b003e00fad5fa8mr1803232wmq.33.1676375921559;
        Tue, 14 Feb 2023 03:58:41 -0800 (PST)
X-Google-Smtp-Source: AK7set990JaS7uUFyKyTp55fSOofXVeZ1Srq5o+Oy+DgP2IHN1qweCfpWOLxsipUpS8mFC9XLhFCRQ==
X-Received: by 2002:a05:600c:35c8:b0:3e0:fad:5fa8 with SMTP id r8-20020a05600c35c800b003e00fad5fa8mr1803225wmq.33.1676375921326;
        Tue, 14 Feb 2023 03:58:41 -0800 (PST)
Received: from [192.168.3.108] (p5b0c60e7.dip0.t-ipconnect.de. [91.12.96.231])
        by smtp.gmail.com with ESMTPSA id p5-20020a1c5445000000b003dc492e4430sm16735098wmi.28.2023.02.14.03.58.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 03:58:40 -0800 (PST)
Message-ID: <a09bfe3a-87e4-f8ce-89bb-c5fde8cc33c9@redhat.com>
Date:   Tue, 14 Feb 2023 12:58:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] mm: page_alloc: don't allocate page from memoryless nodes
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Qi Zheng <zhengqi.arch@bytedance.com>,
        Qi Zheng <arch0.zheng@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Teng Hu <huteng.ht@bytedance.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <muchun.song@linux.dev>,
        Michal Hocko <mhocko@kernel.org>
References: <20230212110305.93670-1-zhengqi.arch@bytedance.com>
 <2484666e-e78e-549d-e075-b2c39d460d71@suse.cz>
 <85af4ada-96c8-1f99-90fa-9b6d63d0016e@bytedance.com>
 <c6908bd0-5f76-47eb-2b77-ce8f7bf9fbff@suse.cz>
 <eefc40e5-a14b-22c5-3480-6786afa1c8f4@redhat.com>
 <Y+tXrK/g1Nrd/q1h@kernel.org>
 <67240e55-af49-f20a-2b4b-b7d574cd910d@gmail.com>
 <22f0e262-982e-ea80-e52a-a3c924b31d58@redhat.com>
 <dbfbd982-27f3-0d72-49e0-d3dd5fe636a8@bytedance.com>
 <4386151c-0328-d207-9a71-933ef61817f9@redhat.com>
 <Y+t0Bhu7BCzH2Dp4@kernel.org>
 <a7f8be91-32c1-bfbe-7e81-5b1e818ba01d@redhat.com>
Organization: Red Hat
In-Reply-To: <a7f8be91-32c1-bfbe-7e81-5b1e818ba01d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.02.23 12:48, David Hildenbrand wrote:
> On 14.02.23 12:44, Mike Rapoport wrote:
>> (added x86 folks)
>>
>> On Tue, Feb 14, 2023 at 12:29:42PM +0100, David Hildenbrand wrote:
>>> On 14.02.23 12:26, Qi Zheng wrote:
>>>> On 2023/2/14 19:22, David Hildenbrand wrote:
>>>>>
>>>>> TBH, this is the first time I hear of NODE_MIN_SIZE and it seems to be a
>>>>> pretty x86 specific thing.
>>>>>
>>>>> Are we sure we want to get NODE_MIN_SIZE involved?
>>>>
>>>> Maybe add an arch_xxx() to handle it?
>>>
>>> I still haven't figured out what we want to achieve with NODE_MIN_SIZE at
>>> all. It smells like an arch-specific hack looking at
>>>
>>> "Don't confuse VM with a node that doesn't have the minimum amount of
>>> memory"
>>>
>>> Why shouldn't mm-core deal with that?
>>
>> Well, a node with <4M RAM is not very useful and bears all the overhead of
>> an extra live node.
> 
> And totally not with 4.1M, haha.
> 
> I really like the "Might fix boot" in the commit description.
> 
>>
>> But, hey, why won't we just drop that '< NODE_MIN_SIZE' and let people with
>> weird HW configurations just live with this?
> 
> 
> ;)
> 

Actually, remembering 09f49dca570a ("mm: handle uninitialized numa nodes 
gracefully"), this might be the right thing to do. That commit assumes 
that all offline nodes would get the pgdat allocated in 
free_area_init(). So that we end up with an allocated pgdat for all 
possible nodes. The reasoning IIRC was that we don't care about wasting 
memory in weird VM setups.

CCing Michal.

-- 
Thanks,

David / dhildenb

