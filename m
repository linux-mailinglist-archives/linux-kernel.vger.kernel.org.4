Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 797CE6F7789
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 22:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjEDUzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 16:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbjEDUy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 16:54:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1F811B7E
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 13:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683233535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Ay2JEt7inO0BkwdzXSrUbAjcniFNqgKD5Qlm2OK4ao=;
        b=URAfh1UpKcueoGlyFH6TmcLZ+6fukEYLLUPb5n8rO6AsgoHCMsDPxpqkOw57ghEvu4RgcH
        qw4Ow0sAA+HyfIJH7OwfJGLJv8VrIrMtgO54qgjDAiSsk9/0Q2ylzJC21Op/yjvU7CD4rh
        JZqkZx2+rbV24n56WUpLkveJM8Z+ugo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-6emBcRv5PhW_g8Yijl8fEw-1; Thu, 04 May 2023 16:05:46 -0400
X-MC-Unique: 6emBcRv5PhW_g8Yijl8fEw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f321e60feaso4053335e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 13:05:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683230745; x=1685822745;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Ay2JEt7inO0BkwdzXSrUbAjcniFNqgKD5Qlm2OK4ao=;
        b=c4SmbtzsOvAt33rJXLdMd3wLXo4hg4S7+BGN3ys28fLxmArTYlh/Yyfx6QehZpFCBK
         Fe0fIO73uOk1BcVfIYAOJHhZoJO1E/LtXt5Ko7HzJjG1QPFCCrbh+nZnS1Nlkkk+l9V0
         +CQxgGiru4a5+XQOhUIRIBbtB8LXS+dILRIPJvXOGoFaEi0wSR00Wvld2Jo2wwEG6I2z
         E/dGfDqGTkQf/GK6NApqoMpRfjAuF6n+pymJwOboPM3l7DMAs7SPqLlEhQPUvP+J+3tu
         J/ORQSrHnauxr1UCsKdFT9Os6h66nmy7wrTJHGsKRdPvTvkeLFwudrSvQZ28/jVEYyW9
         U3YQ==
X-Gm-Message-State: AC+VfDwa7wDsBWg+bTJ9EjFdyR5xKDejH+JspIm4BPPfTLM6HVoAXTEI
        ST3iOoMd7NKuHjR66gIcTDTSPUP6ijjUm+IusFVPFoVzxAPcnDLqMbFYKsziyy76wLh3MN+aMpM
        R1na4zVgwxnkgEKC6ZZinm/k=
X-Received: by 2002:a7b:c8d6:0:b0:3f1:72ec:4024 with SMTP id f22-20020a7bc8d6000000b003f172ec4024mr581582wml.21.1683230745732;
        Thu, 04 May 2023 13:05:45 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ58rh8gmeKmohoFQOP/3n9E0OFbDBfUl4ChicP8Hsr85oC9Labv/UHu5PIBITjyJTbbafX/dA==
X-Received: by 2002:a7b:c8d6:0:b0:3f1:72ec:4024 with SMTP id f22-20020a7bc8d6000000b003f172ec4024mr581562wml.21.1683230745437;
        Thu, 04 May 2023 13:05:45 -0700 (PDT)
Received: from [192.168.9.16] (net-2-34-28-169.cust.vodafonedsl.it. [2.34.28.169])
        by smtp.gmail.com with ESMTPSA id q6-20020a7bce86000000b003f1836c98b7sm5729913wmj.48.2023.05.04.13.05.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 13:05:44 -0700 (PDT)
Message-ID: <6f3ba18c-8724-f4ae-8267-719cc6f45c69@redhat.com>
Date:   Thu, 4 May 2023 22:05:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH v4 1/4] fpga: add fake FPGA manager
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
References: <20230417122308.131453-1-marpagan@redhat.com>
 <20230417122308.131453-2-marpagan@redhat.com>
 <ZEGE+UqTyKGTyv9h@yilunxu-OptiPlex-7050>
 <cef792a1-42c1-b262-b07e-529006fdcb6d@redhat.com>
 <594789b2-eb5d-11fc-9c47-310bdb258f7c@redhat.com>
 <ZFOkPNOmbjsalTmn@yilunxu-OptiPlex-7050>
Content-Language: en-US
From:   Marco Pagani <marpagan@redhat.com>
In-Reply-To: <ZFOkPNOmbjsalTmn@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-05-04 14:25, Xu Yilun wrote:
> On 2023-05-03 at 18:53:02 +0200, Marco Pagani wrote:
>> On 2023-04-26 17:44, Marco Pagani wrote:
>>>
>>>
>>> On 2023-04-20 20:31, Xu Yilun wrote:
>>>> On 2023-04-17 at 14:23:05 +0200, Marco Pagani wrote:
>>>>> Add fake FPGA manager platform driver with support functions.
>>>>> The driver checks the programming sequence using KUnit expectations.
>>>>> This module is part of the KUnit tests for the FPGA subsystem.
>>>>>
>>>>> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> 
> [...]
> 
>>>>> +EXPORT_SYMBOL_GPL(fake_fpga_mgr_check_write_sgt);
>>>>
>>>> I'm wondering, if we could move all these exported functions out of
>>>> fake_fpga driver module. And make this driver module serves FPGA
>>>> mgr framework only, just like other fpga drivers do.
>>>>
>>>> I assume the main requirement is to check the statistics produced
>>>> by the fake fpga driver. Directly accessing mgr->priv outside the
>>>> driver could be unwanted.  To solve this, could we create a shared
>>>> buffer for the statistics and pass to fake drivers by platform data.
>>>>
>>>> I hope move all the tester's actions in fpga-test.c, so that people
>>>> could easily see from code what a user need to do to enable fpga
>>>> reprogramming and what are expected in one file. The fake drivers could
>>>> be kept as simple, they only move the process forward and produce
>>>> statistics.
>>>>
>>>> Thanks,
>>>> Yilun
>>>>
>>>
>>> I agree with you. Initially, I wanted to keep all KUnit test assertions
>>> and expectations contained in fpga-test. However, I could not find a simple
>>> way to test that the FPGA manager performs the correct state transitions
>>> during programming. So I ended up putting KUnit assertions in the methods
>>> of the low-level fake driver as a first solution.
>>>
>>> I like your suggestion of using a shared buffer to have a cleaner
>>> implementation. My only concern is that it would make the code more complex.
>>> I will work on this for V5.
>>>
>>
>> I experimented with a couple of alternatives to move all tests inside
>> fpga-test and remove the external functions. Unfortunately, each alternative
>> comes with its drawbacks.
>>
>> Using a shared buffer (e.g., kfifo) to implement an events buffer between
>> fake mgr/bridge and the fpga-test overcomplicates the code (i.e., defining
>> message structs, enums for the operations, locks, etc.).
> 
> Oh, I actually didn't expect a message based mechanism for statistics
> reading, which is overcomplicated for a test.
> 
> Maybe just pass a structured data buffer via platform_data, so that both
> fpga-test & fake drivers could recognize and access it directly. fpga-test
> could directly check the updated statistics after reprograming and assert
> them. Is that OK for you?
> 
> Thanks,
> Yilun

In principle, yes. I was just concerned that testing all properties with a plain
buffer wouldn't be feasible. With the current implementation, fake-fpga-mgr
tests two distinct sets of properties: (i) all required ops are called during
programming, and (ii) the fpga mgr is in the correct state when each op is called.

I was convinced that testing (ii) would have required some sort of events queue
to trace the calls. However, on second thought, I might simply use fpga_mgr_states
enums to test (ii) using a plain buffer. Moreover, by adding sequence numbers, we
could also test an additional property (iii) ops are called in the right order.
I'll follow the shared buffer approach for V5.

Thanks,
Marco

> 
>>
>> Moving fake modules' (mgr, bridge, region) implementations inside fpga-test
>> makes fpga-test monolithic and harder to understand and maintain.
>>
>> Accessing modules' private data directly from fpga-test breaks encapsulation.
>>
>> Overall, it seems to me that using external functions to get the state of fake
>> modules is the least-worst alternative. What are your thoughts and preferences?
>>
>> Thanks,
>> Marco
>>
>>
>>>>> [...]
>>
> 

