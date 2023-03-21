Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8428F6C3795
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 18:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjCURCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 13:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjCURCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 13:02:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989E12822B
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 10:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679418106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lcFH3Gw2MS2hxoUbFfkXJb2/O9gx/UdG3VWmXz/ijFE=;
        b=TBwUhcJu0rrBTa+OLtpnMSDXATL1J4DkryY+7orMN0oM8kPTnYhH5OmlnlyslS/S3FFsg4
        uFOtnJYdmodk1YNSpQ1qTsA1lUDtru573htb5ZhcewCcinAekrDDP3SRx9vB3+bAgK6ASI
        +GSN1D/7+WTeXZt743seufEW5J5F7Jw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527--W2BBs1aPmO-xHkcmQRwNA-1; Tue, 21 Mar 2023 13:01:43 -0400
X-MC-Unique: -W2BBs1aPmO-xHkcmQRwNA-1
Received: by mail-wm1-f70.google.com with SMTP id iv10-20020a05600c548a00b003ee112e6df1so2340043wmb.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 10:01:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679418102;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lcFH3Gw2MS2hxoUbFfkXJb2/O9gx/UdG3VWmXz/ijFE=;
        b=YMyG7q25RlJzoPZ1WRTOITS8Kfi/Bh9zjXXzcA4alO9KY5pWalrJN/6xd5mjALis8U
         uhc7PTnkAeaaR0f3Pv09UYCHto0VS8osKw8Dppz+4fmeGebJ64bnGw9Pk/Qz6Hu+zWA+
         +MVlInA/PjyrVmkP3nm5q52yL533S0llL1fVPDWSdeZU5ezWDds/k/egKZp/bqZitcXJ
         1fb45NNk0CKBI1NsM/LLRrlf4jxin3ghg68EMio5+uIgBTL6qjrvHoL3Ws02/tIWeOv6
         7fH+Q4c2N3GgS4j9UHng717CK12Y+nO10C2lU6ipFfMBXXyCt2cT//QFFJGj4T+R+Tc3
         pStg==
X-Gm-Message-State: AO0yUKVzTfqxAhAuwfdyGvuB6wJPUvrLDQ7UXzzhqr7HK+J2nOIf+9Ah
        olV4qa5Z791lmJMyV2zpzBAestngdATdXk66hGhZafHVugXLTJlFW2d0LA67PG8eDPmRu7Aa+HD
        5p2lSjT6y/os64f8SxMqc6t1R
X-Received: by 2002:a05:6000:10d0:b0:2ce:a7f6:2fe5 with SMTP id b16-20020a05600010d000b002cea7f62fe5mr3069228wrx.60.1679418102729;
        Tue, 21 Mar 2023 10:01:42 -0700 (PDT)
X-Google-Smtp-Source: AK7set8H4j1IS2DP9wgMOOzB3lkgc0urxBfNv94zaRLD/dw6IB/eqVFyZlA2Ttlu6q9hf9hZ1CwfOA==
X-Received: by 2002:a05:6000:10d0:b0:2ce:a7f6:2fe5 with SMTP id b16-20020a05600010d000b002cea7f62fe5mr3069210wrx.60.1679418102393;
        Tue, 21 Mar 2023 10:01:42 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:7f00:8245:d031:7f8b:e004? (p200300cbc7057f008245d0317f8be004.dip0.t-ipconnect.de. [2003:cb:c705:7f00:8245:d031:7f8b:e004])
        by smtp.gmail.com with ESMTPSA id a7-20020adff7c7000000b002c70ce264bfsm11856785wrq.76.2023.03.21.10.01.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 10:01:41 -0700 (PDT)
Message-ID: <d8318657-f119-b0f3-cfb8-ed314a8144e6@redhat.com>
Date:   Tue, 21 Mar 2023 18:01:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC 00/12] module: avoid userspace pressure on unwanted
 allocations
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Adam Manzanares <a.manzanares@samsung.com>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, petr.pavlu@suse.com, prarit@redhat.com,
        christophe.leroy@csgroup.eu, song@kernel.org,
        torvalds@linux-foundation.org
References: <f18ec4d3-be63-7e86-1951-f3d460acd7a7@redhat.com>
 <ZBOsc8dc0Mhvh/vv@bombadil.infradead.org>
 <ZBOsyBu68d4vh6yU@bombadil.infradead.org>
 <ZBUBsUx9++Ksl91w@bombadil.infradead.org>
 <c1375bdc-401b-308a-d931-80a95897dbc3@redhat.com>
 <2bd995a7-5b7f-59a1-751e-c56e76a7d592@redhat.com>
 <ZBjLp4YvN1m/cR4G@bombadil.infradead.org>
 <c0b2d9d0-ef5e-8c46-109e-742dbec8a07b@redhat.com>
 <ZBjO2LqBkayxG+Sd@bombadil.infradead.org>
 <eaa75ce0-7064-7919-0e72-6bb4ccc5d0d6@redhat.com>
 <ZBng0qnm/ADtSTBQ@bombadil.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZBng0qnm/ADtSTBQ@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.03.23 17:52, Luis Chamberlain wrote:
> On Tue, Mar 21, 2023 at 04:11:27PM +0100, David Hildenbrand wrote:
>> On 20.03.23 22:23, Luis Chamberlain wrote:
>>> On Mon, Mar 20, 2023 at 10:15:23PM +0100, David Hildenbrand wrote:
>>>> On 20.03.23 22:09, Luis Chamberlain wrote:
>>>>> On Mon, Mar 20, 2023 at 08:40:07PM +0100, David Hildenbrand wrote:
>>>>>> On 20.03.23 10:38, David Hildenbrand wrote:
>>>>>>> On 18.03.23 01:11, Luis Chamberlain wrote:
>>>>>>>> On Thu, Mar 16, 2023 at 04:56:56PM -0700, Luis Chamberlain wrote:
>>>>>>>>> On Thu, Mar 16, 2023 at 04:55:31PM -0700, Luis Chamberlain wrote:
>>>>>>>>>> On Wed, Mar 15, 2023 at 05:41:53PM +0100, David Hildenbrand wrote:
>>>>>>>>>>> I expect to have a machine (with a crazy number of CPUs/devices) available
>>>>>>>>>>> in a couple of days (1-2), so no need to rush.
>>>>>>>>>>>
>>>>>>>>>>> The original machine I was able to reproduce with is blocked for a little
>>>>>>>>>>> bit longer; so I hope the alternative I looked up will similarly trigger the
>>>>>>>>>>> issue easily.
>>>>>>>>>>
>>>>>>>>>> OK give this a spin:
>>>>>>>>>>
>>>>>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=20230316-module-alloc-opts
>>>>>>>>
>>>>>>>> Today I am up to here:
>>>>>>>>
>>>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=20230317-module-alloc-opts
>>>>>>>>
>>>>>>>> The last patch really would have no justification yet at all unless it
>>>>>>>> does help your case.
>>>>>>>
>>>>>>> Still waiting on the system (the replacement system I was able to grab
>>>>>>> broke ...).
>>>>>>>
>>>>>>> I'll let you know once I succeeded in reproducing + testing your fixes.
>>>>>>
>>>>>> Okay, I have a system where I can reproduce.
>>>>>>
>>>>>> Should I give
>>>>>>
>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=20230319-module-alloc-opts
>>>>>>
>>>>>> from yesterday a churn?
>>>>>
>>>>> Yes please give that a run.
>>>>
>>>> Reproduced with v6.3.0-rc1 (on 1st try)
>>>
>>> By reproduced, you mean it fails to boot?
>>
>> It boots but we get vmap allocation warnings, because the ~440 CPUs manage
>> to completely exhaust the module vmap area due to KASAN.
> 
> Thanks, can you post a trace?

See

https://lkml.kernel.org/r/20221013180518.217405-1-david@redhat.com

where I also describe the issue in more detail.

> 
>>>> Not able to reproduce with 20230319-module-alloc-opts so far (2 tries).
>>>
>>> Oh wow, so to clarify, it boots OK?
>>
>> It boots and I don't get the vmap allocation warnings.
> 
> Wonderful!

I'm still compiling/testing the debug kernels 
(20230319-module-alloc-opts-adjust +  single revert of the rcu patch). I 
should have some systemd-analyze results for !debug kernels later.

-- 
Thanks,

David / dhildenb

