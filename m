Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA70696320
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 13:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbjBNMJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 07:09:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjBNMJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 07:09:49 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE401AE
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 04:09:48 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id d13-20020a17090ad3cd00b0023127b2d602so15257856pjw.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 04:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112; t=1676376588;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JohS/G46dDJJaRwmkaimdqoi1ZxeM/9vZjySLS+uQwQ=;
        b=OVz7AZaHqQSiSLh1huurKqZkyRiLVURJDxTfYTukZgZJdT7P2/NHkgmBKZ5v7X5wAE
         7FRKXOSXC+NVo8Zkl9fVcHlVd4EXmHJQzPj8XvTq5uatosxWy217ip8PxT+lLif+x9aJ
         kZsm2Remk78KUb2+ylSR8WqImWws50ROwgsnfUmK8WoiKPlOJnhXOVV+U5LyBDp9hPSe
         WtIk67t1meitkltsFdhvNmkRJvo1jlt2HHesNZPmF8wDjFvGmK7VxLvDB3cfydRZI1S1
         trPAAsCP7/qWSM4iNyMt3Z/NXYkTG2RAhekG81o6uTfnej0Y8ur3bGXYM8+1y8Sg6u8n
         FLbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676376588;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JohS/G46dDJJaRwmkaimdqoi1ZxeM/9vZjySLS+uQwQ=;
        b=OdShliDz10Tm2ZBY9gYH9WtWkOZUIzgjJCE7Mmb0BdV2TvTp1kd1vqyfOQGNUjYy5J
         u+doZSRGesA9q6DUhHzvkY91EMM+aLazjKUZyloxJHzwHdsZqMp511ulhCpwuxrQlbib
         KUWIpY53CWtfnmQDdDeVYyDCnWR001yyBxLTDni86N3I0vC335EEJypiQIB6AKrPmPfz
         XyBMC6CKap/UxVpD7TnVZrcSlWDAJVYf090Ml8MC0s0Qy5VlzvKINruq2KIzxpmel6E4
         2YQYbTxJ67XBS2+04bvWUoO/zKOiXECqLI/MfMcX0vKPmknYnEiMQUPgXsf7Ws4LF7Hy
         2aZg==
X-Gm-Message-State: AO0yUKWFck76vdCj+BttNn4hJm+xSEoiegknvG8vV94oGj5MYh4xZkLe
        fjb2y7tfi+LByCk8uTPszde/WA==
X-Google-Smtp-Source: AK7set+4em1PeVzryPDOVt3z+VTZiSbLPDmVXMf+fMaf3rL2DC4JB0rbMP/MTxR9YiJpDyOxBGj1TQ==
X-Received: by 2002:a17:902:e886:b0:19a:7439:3e98 with SMTP id w6-20020a170902e88600b0019a74393e98mr2703242plg.4.1676376588100;
        Tue, 14 Feb 2023 04:09:48 -0800 (PST)
Received: from [10.200.11.190] ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id iy1-20020a170903130100b0019a9436d2a0sm5117555plb.89.2023.02.14.04.09.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 04:09:47 -0800 (PST)
Message-ID: <27da47d9-2daf-c580-66e2-cae55f53e784@bytedance.com>
Date:   Tue, 14 Feb 2023 20:09:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [External] Re: [PATCH] mm: page_alloc: don't allocate page from
 memoryless nodes
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@kernel.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org,
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
 <a09bfe3a-87e4-f8ce-89bb-c5fde8cc33c9@redhat.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <a09bfe3a-87e4-f8ce-89bb-c5fde8cc33c9@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/2/14 19:58, David Hildenbrand wrote:
> On 14.02.23 12:48, David Hildenbrand wrote:
>> On 14.02.23 12:44, Mike Rapoport wrote:
>>> (added x86 folks)
>>>
>>> On Tue, Feb 14, 2023 at 12:29:42PM +0100, David Hildenbrand wrote:
>>>> On 14.02.23 12:26, Qi Zheng wrote:
>>>>> On 2023/2/14 19:22, David Hildenbrand wrote:
>>>>>>
>>>>>> TBH, this is the first time I hear of NODE_MIN_SIZE and it seems 
>>>>>> to be a
>>>>>> pretty x86 specific thing.
>>>>>>
>>>>>> Are we sure we want to get NODE_MIN_SIZE involved?
>>>>>
>>>>> Maybe add an arch_xxx() to handle it?
>>>>
>>>> I still haven't figured out what we want to achieve with 
>>>> NODE_MIN_SIZE at
>>>> all. It smells like an arch-specific hack looking at
>>>>
>>>> "Don't confuse VM with a node that doesn't have the minimum amount of
>>>> memory"
>>>>
>>>> Why shouldn't mm-core deal with that?
>>>
>>> Well, a node with <4M RAM is not very useful and bears all the 
>>> overhead of
>>> an extra live node.
>>
>> And totally not with 4.1M, haha.
>>
>> I really like the "Might fix boot" in the commit description.
>>
>>>
>>> But, hey, why won't we just drop that '< NODE_MIN_SIZE' and let 
>>> people with
>>> weird HW configurations just live with this?
>>
>>
>> ;)
>>
> 
> Actually, remembering 09f49dca570a ("mm: handle uninitialized numa nodes 
> gracefully"), this might be the right thing to do. That commit assumes 
> that all offline nodes would get the pgdat allocated in 
> free_area_init(). So that we end up with an allocated pgdat for all 
Can also See commit 1ca75fa7f19d ("arch/x86/mm/numa: Do not initialize 
nodes twice"). The commit message explains the initialization process
more clearly, it may be helpful. :)

> possible nodes. The reasoning IIRC was that we don't care about wasting 
> memory in weird VM setups.
> 
> CCing Michal.
> 

-- 
Thanks,
Qi
