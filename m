Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8186B02A0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 10:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbjCHJPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 04:15:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjCHJOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 04:14:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC24699BD2
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 01:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678266801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nL07OXOTECIQ3+AAmmOwYpqRhIVNzr9bj2mSTEdfSNE=;
        b=UYZ4GpufajpEsGvBVZkSY9TlQG6Gwyp5d+JDbNVx7NLKUUo/jd3R1VBe/T6k8wa0W1BjSV
        1XZa1z1kawYjuOyL4tlmedhekEQFKiBMsjYcSzV8d7LNelJZ7q4Wv25tQYXz1rfL+qYLxG
        W6AVaEsXkSFch52u6R5joTvWsGQ1ZvQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-dxrsVGGjNBuKKFG0YeTmZQ-1; Wed, 08 Mar 2023 04:13:18 -0500
X-MC-Unique: dxrsVGGjNBuKKFG0YeTmZQ-1
Received: by mail-wr1-f71.google.com with SMTP id n6-20020a5d51c6000000b002ca3c48ba46so2696254wrv.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 01:13:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678266797;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nL07OXOTECIQ3+AAmmOwYpqRhIVNzr9bj2mSTEdfSNE=;
        b=N3pw/TTSJF9mOfYvCBh2emrH9LCSNWKaO+k+Gyw5RpPCF3b6kC86vhzR6i5FzdJeWd
         Tmqw17rCvtQLdMY6CRYyoBtEBuhQJOLYTobptiyPOCSxznbh7xhvlI1AVEHYc0bBXBdz
         my5biwDoszOb8MdyXuQJtnRy37wWaukz6PXbEriO4xJ10a5HA5tDHfWhje8gJjtYODE5
         WkKpi7vdXdxDuvqNynSd/Rxgz4kuhCAQN5swyo6Segi7mYlVeAyHBEjC0yUDxA6whp0s
         lapP00C8TcUs9yHXKg0I3fi8pAfeBEWDZ/MZrgwwft9ilXDUgQOESmmY07IODLiCVOrW
         xMiQ==
X-Gm-Message-State: AO0yUKVoLQSAR3TIElRWe83yGT4qGlSstaB86xAohWUZOf4IDmRBa0aI
        zctaAyUA3PuOl8FfI1oDCxQ42iBTtYWIJS+m8SiF1z80AlS+8vi1TR507d+OcX/Nc3/8/ljN9OV
        RKL/jvcVTeS9n3yOGKYGYge3KcUqeDIzF
X-Received: by 2002:a05:600c:4e8c:b0:3e2:dba:7155 with SMTP id f12-20020a05600c4e8c00b003e20dba7155mr14460962wmq.20.1678266797464;
        Wed, 08 Mar 2023 01:13:17 -0800 (PST)
X-Google-Smtp-Source: AK7set88RAKW4KwEadLYLLhL+xQvkBCka/j77islJ+OlSpGWPMJoJ2je1C3IXMNMJkIRBF5Y9JIlEw==
X-Received: by 2002:a05:600c:4e8c:b0:3e2:dba:7155 with SMTP id f12-20020a05600c4e8c00b003e20dba7155mr14460944wmq.20.1678266797115;
        Wed, 08 Mar 2023 01:13:17 -0800 (PST)
Received: from ?IPV6:2003:cb:c71b:cb00:d372:1da8:9e9e:422d? (p200300cbc71bcb00d3721da89e9e422d.dip0.t-ipconnect.de. [2003:cb:c71b:cb00:d372:1da8:9e9e:422d])
        by smtp.gmail.com with ESMTPSA id r18-20020a05600c35d200b003dfe549da4fsm20440570wmq.18.2023.03.08.01.13.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 01:13:16 -0800 (PST)
Message-ID: <562e9cc3-d0aa-23e9-bd19-266b5aef2ae7@redhat.com>
Date:   Wed, 8 Mar 2023 10:13:15 +0100
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
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <6df72872-2829-47ab-552c-7ef8a6470e6f@shopee.com>
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

On 08.03.23 10:03, Haifeng Xu wrote:
> 
> 
> On 2023/3/7 10:48, Matthew Wilcox wrote:
>> On Tue, Mar 07, 2023 at 10:36:55AM +0800, Haifeng Xu wrote:
>>> On 2023/3/6 21:49, David Hildenbrand wrote:
>>>> On 06.03.23 03:49, Haifeng Xu wrote:
>>>>> mem_cgroup_oom_synchronize() has checked whether current memcg_in_oom is
>>>>> set or not, so remove the check in handle_mm_fault().
>>>>
>>>> "mem_cgroup_oom_synchronize() will returned immediately if memcg_in_oom is not set, so remove the check from handle_mm_fault()".
>>>>
>>>> However, that requires now always an indirect function call -- do we care about dropping that optimization?
>>>>
>>>>
>>>
>>> If memcg_in_oom is set, we will check it twice, one is from handle_mm_fault(), the other is from mem_cgroup_oom_synchronize(). That seems a bit redundant.
>>>
>>> if memcg_in_oom is not set, mem_cgroup_oom_synchronize() returns directly. Though it's an indirect function call, but the time spent can be negligible
>>> compare to the whole mm user falut preocess. And that won't cause stack overflow error.
>>
>> I suggest you measure it.
> 
> test steps:
> 1) Run command: ./mmap_anon_test(global alloc, so the memcg_in_oom is not set)
> 2) Calculate the quotient of cost time and page-fault counts, run 10 rounds and average the results.
> 
> The test result shows that whether using indirect function call or not, the time spent in user fault
> is almost the same, about 2.3ms.

I guess most of the benchmark time is consumed by allocating fresh pages 
in your test (also, why exactly do you use MAP_SHARED?).

Is 2.3ms the total time for writing to that 1GiB of memory or how did 
you derive that number? Posting both results would be cleaner (with more 
digits ;) ).

-- 
Thanks,

David / dhildenb

