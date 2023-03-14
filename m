Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96F26B8E2B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 10:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjCNJKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 05:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjCNJJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 05:09:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D018B4345C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 02:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678784948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MZiEdMEJZU9Q5QYrqalML5RHHEvYiFGOlrIymPa3oQk=;
        b=ETW9mQrU2MgX+hk4b60o2a2rF8qoh2AAOhOFUgLKI+JfYmAIQ0rlJhBrbSdJ/dSRJdEkq9
        D1QL8OjvHkkL+uDNPTt0jGbEE75o2BMEgiArZHUvJ9JzoHM6a/tzr8rJgiYpkoSFkDn9+R
        q2WEoeu1m6bvFIkCFHPwX/7qHUDL8FA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-xP4AMAcoO5S0g6gJipUx7Q-1; Tue, 14 Mar 2023 05:09:07 -0400
X-MC-Unique: xP4AMAcoO5S0g6gJipUx7Q-1
Received: by mail-wr1-f70.google.com with SMTP id o15-20020a05600002cf00b002c54a27803cso2536511wry.22
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 02:09:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678784946;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZiEdMEJZU9Q5QYrqalML5RHHEvYiFGOlrIymPa3oQk=;
        b=xxuAilE35ozNxq5zqDEpn12EEEsjpGy0HDzJqJJzoncsDTFKLhldxCTsFEO0zmoOwJ
         EQZpBuWOkmLyEtBsSkPDunwPC8VlF+xpwsguIchvt0kmsKvu3a+CozxKzosfuprQWPNr
         f/MxlV+CKlW9C41WJrfNCw3UPUqFdVoQNMOMwqTiVpkl7/fJj6YgK6uGWtjefkEiF5yJ
         90vTpdEY0yXghYc+kAp/zwVanFE5mE7m2GxxYn6phD4IXbcQPV4KPWw6gXn4X1NitLyW
         gJokyS+QUc65SbrDF9fmkoVInyKJG2eZML+1GnNApVl3mI+gKoIr2RzIzjU3aPSyFmBw
         vwhg==
X-Gm-Message-State: AO0yUKVaxs12YA5xa4QqLVqv2VDtOBkhd9ocnaMpl4+6rtdBduIfBuwN
        nFrMSvjBdsXhcTPcyAn32t5HtqFO2AhOPN8i+ltWZFp7HGI9YXcnJ+5TcGpY/HBQu0H3hmjAXG+
        VWxKBTIXavgRJUZUBe7p293gv
X-Received: by 2002:a5d:6188:0:b0:2ce:ad32:5439 with SMTP id j8-20020a5d6188000000b002cead325439mr5664624wru.21.1678784945952;
        Tue, 14 Mar 2023 02:09:05 -0700 (PDT)
X-Google-Smtp-Source: AK7set/2QYhcEW7QJ2oWWSMlZ7W5mOKcxbLyj4yDmNaK0xMlrlFcBHnyxJAs4vay6omYiKl8xlIIsw==
X-Received: by 2002:a5d:6188:0:b0:2ce:ad32:5439 with SMTP id j8-20020a5d6188000000b002cead325439mr5664603wru.21.1678784945628;
        Tue, 14 Mar 2023 02:09:05 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:1000:21d5:831d:e107:fbd6? (p200300cbc704100021d5831de107fbd6.dip0.t-ipconnect.de. [2003:cb:c704:1000:21d5:831d:e107:fbd6])
        by smtp.gmail.com with ESMTPSA id m1-20020adffa01000000b002c5526234d2sm1602596wrr.8.2023.03.14.02.09.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 02:09:05 -0700 (PDT)
Message-ID: <70abf872-99d1-6ff4-3332-d86d320abff2@redhat.com>
Date:   Tue, 14 Mar 2023 10:09:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] mm: remove redundant check in handle_mm_fault
To:     Haifeng Xu <haifeng.xu@shopee.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230306024959.131468-1-haifeng.xu@shopee.com>
 <df3997ed-a844-597b-fbb1-154caad78543@redhat.com>
 <354360d5-dce6-a11c-ee61-d41e615bfa05@shopee.com>
 <ZAamFX/hq6Y/iNJb@casper.infradead.org>
 <6df72872-2829-47ab-552c-7ef8a6470e6f@shopee.com>
 <562e9cc3-d0aa-23e9-bd19-266b5aef2ae7@redhat.com>
 <b07c5e99-b251-2509-dfac-0f8e571d39d7@shopee.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <b07c5e99-b251-2509-dfac-0f8e571d39d7@shopee.com>
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

On 14.03.23 09:05, Haifeng Xu wrote:
> 
> 
> On 2023/3/8 17:13, David Hildenbrand wrote:
>> On 08.03.23 10:03, Haifeng Xu wrote:
>>>
>>>
>>> On 2023/3/7 10:48, Matthew Wilcox wrote:
>>>> On Tue, Mar 07, 2023 at 10:36:55AM +0800, Haifeng Xu wrote:
>>>>> On 2023/3/6 21:49, David Hildenbrand wrote:
>>>>>> On 06.03.23 03:49, Haifeng Xu wrote:
>>>>>>> mem_cgroup_oom_synchronize() has checked whether current memcg_in_oom is
>>>>>>> set or not, so remove the check in handle_mm_fault().
>>>>>>
>>>>>> "mem_cgroup_oom_synchronize() will returned immediately if memcg_in_oom is not set, so remove the check from handle_mm_fault()".
>>>>>>
>>>>>> However, that requires now always an indirect function call -- do we care about dropping that optimization?
>>>>>>
>>>>>>
>>>>>
>>>>> If memcg_in_oom is set, we will check it twice, one is from handle_mm_fault(), the other is from mem_cgroup_oom_synchronize(). That seems a bit redundant.
>>>>>
>>>>> if memcg_in_oom is not set, mem_cgroup_oom_synchronize() returns directly. Though it's an indirect function call, but the time spent can be negligible
>>>>> compare to the whole mm user falut preocess. And that won't cause stack overflow error.
>>>>
>>>> I suggest you measure it.
>>>
>>> test steps:
>>> 1) Run command: ./mmap_anon_test(global alloc, so the memcg_in_oom is not set)
>>> 2) Calculate the quotient of cost time and page-fault counts, run 10 rounds and average the results.
>>>
>>> The test result shows that whether using indirect function call or not, the time spent in user fault
>>> is almost the same, about 2.3ms.
>>
>> I guess most of the benchmark time is consumed by allocating fresh pages in your test (also, why exactly do you use MAP_SHARED?).
>>
>> Is 2.3ms the total time for writing to that 1GiB of memory or how did you derive that number? Posting both results would be cleaner (with more digits ;) ).
>>
> 
> Hi Daivd, the details of test result were posted last week. Do you have any suggestions or more concerns about this change?

No, I guess it really doesn't matter performance wise.

One valid question would be: why perform this change at all? The 
redundancy doesn't seem to harm performance either.

If the change would obviously improve code readability it would be easy 
to justify. I'm not convinced, that is the case, but maybe for others.

So FWIW, the change looks good to me and should not affect performance 
in one way or the other. So no objections from my side ...

-- 
Thanks,

David / dhildenb

