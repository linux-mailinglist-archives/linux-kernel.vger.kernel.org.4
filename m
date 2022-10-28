Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A8D61126D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 15:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbiJ1NM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 09:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbiJ1NMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 09:12:55 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8853D1C7D69
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 06:12:52 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id bk15so6511323wrb.13
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 06:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o3XkdRF1alR2hBxhKv7+KC2xEVL/mNE1pCUslh91CNk=;
        b=czSDanOWkaznNFvfzkhI+RldJ79y0lOKTXLazE2INVObzdIpuA02fnxmTp4HXTRQTi
         IvuTylcXIq/Sg1jCgh9FzcPYK6wCnCgisN2SPpD2hY2iM3U6UJQJMLePIaRYzRfU+2Wh
         y9qb6oEWb7kSxsaXWIlY4Dkr2UM2TLk7qXYPH5mBMLvwd3vtyLYpmiqZDG3Zxj0+CARd
         L8/aJqqA6LprQ5Pk4/015K7SAUBuZTJBf3EKbWQG93N7hmK53CJDPw0U9whLdkPu5vWz
         3ELADVGMWSrtaYcGW48cTX8dbadiAO+awqSfgOoWpeoUTHQ8/pHHrLwFT/4AdLUkI1S8
         O7bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o3XkdRF1alR2hBxhKv7+KC2xEVL/mNE1pCUslh91CNk=;
        b=dVLMmLpqtVqSoq1miHIkuhNpzl+nK0iRtPDyJ1x6cRPrHS26xkWzdLHOeq/fQSU6MA
         ckVIyckywGJdlDy3Bt0p0/UlxtyXo1D1MY5NPGpHPMtdmWOKWjz4T49nXJ3PbJEs9QDX
         zl4qwZvFsptyOwMtdzfwSJ0QjhUkPPnLDZwMeQ7ZPH9JXzY3TFqD8G4zJfyfKihFqmfD
         whETPv/PoMj+7SJLpTwnNtJ7+5CQuMbt28/W2qOGQBcvzbrWyHVC9ULR5TWPe5WyRcqG
         0R3hDaonnUfy4teD3fQjZ+dDCsDMo3vlye6Ob7mdQs2kjD8zB/6bepOn4fXUeZw+Q1sN
         h+Vw==
X-Gm-Message-State: ACrzQf2TYO/fX5U0iHJon1SwgalZ8XOeAX2LbO/llcsxpbMWmJoGlSWy
        O/dcErdsfVNR70P+Rw4WGNJ4Bw==
X-Google-Smtp-Source: AMsMyM6F7+GscrQBfN0kqw1I2NMyhLF2BzgPRHQOCPO+qKjjp7P6MaY7wew3G5OT+7MX9xpYkZlRUQ==
X-Received: by 2002:a05:6000:18c7:b0:22e:5503:9c46 with SMTP id w7-20020a05600018c700b0022e55039c46mr33561930wrq.668.1666962771104;
        Fri, 28 Oct 2022 06:12:51 -0700 (PDT)
Received: from localhost ([95.148.15.66])
        by smtp.gmail.com with ESMTPSA id n17-20020a05600c501100b003b4fdbb6319sm5926108wmr.21.2022.10.28.06.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 06:12:50 -0700 (PDT)
From:   Punit Agrawal <punit.agrawal@bytedance.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Barry Song <21cnbao@gmail.com>,
        Punit Agrawal <punit.agrawal@bytedance.com>,
        Yicong Yang <yangyicong@huawei.com>, yangyicong@hisilicon.com,
        corbet@lwn.net, peterz@infradead.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, darren@os.amperecomputing.com,
        huzhanyuan@oppo.com, lipeifeng@oppo.com, zhangshiming@oppo.com,
        guojian@oppo.com, realmz6@gmail.com, linux-mips@vger.kernel.org,
        openrisc@lists.librecores.org, linux-mm@kvack.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        wangkefeng.wang@huawei.com, xhao@linux.alibaba.com,
        prime.zeng@hisilicon.com, Barry Song <v-songbaohua@oppo.com>,
        Nadav Amit <namit@vmware.com>, Mel Gorman <mgorman@suse.de>,
        catalin.marinas@arm.com, will@kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 2/2] arm64: support batched/deferred tlb shootdown
 during page reclamation
References: <20220921084302.43631-1-yangyicong@huawei.com>
        <20220921084302.43631-3-yangyicong@huawei.com>
        <168eac93-a6ee-0b2e-12bb-4222eff24561@arm.com>
        <8e391962-4e3a-5a56-64b4-78e8637e3b8c@huawei.com>
        <CAGsJ_4z=dZbrAUD9jczT08S3qi_ep-h+EK35UfayVk1S+Cnp2A@mail.gmail.com>
        <ecd161db-b290-7997-a81e-a0a00bd1c599@arm.com>
        <87o7tx5oyx.fsf@stealth>
        <CAGsJ_4zrGfPYAXGW0g3Z-GF4vT7GD0xDjZn1dv-qruztEQTghg@mail.gmail.com>
        <8a3ade4c-1714-5ffd-ed57-02ab0509725b@arm.com>
Date:   Fri, 28 Oct 2022 14:12:49 +0100
In-Reply-To: <8a3ade4c-1714-5ffd-ed57-02ab0509725b@arm.com> (Anshuman
        Khandual's message of "Fri, 28 Oct 2022 07:44:29 +0530")
Message-ID: <877d0k5bxq.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Anshuman Khandual <anshuman.khandual@arm.com> writes:

> On 10/28/22 03:25, Barry Song wrote:
>> On Fri, Oct 28, 2022 at 3:19 AM Punit Agrawal
>> <punit.agrawal@bytedance.com> wrote:
>>>
>>> [ Apologies for chiming in late in the conversation ]
>>>
>>> Anshuman Khandual <anshuman.khandual@arm.com> writes:
>>>
>>>> On 9/28/22 05:53, Barry Song wrote:
>>>>> On Tue, Sep 27, 2022 at 10:15 PM Yicong Yang <yangyicong@huawei.com> wrote:
>>>>>> On 2022/9/27 14:16, Anshuman Khandual wrote:
>>>>>>> [...]
>>>>>>>
>>>>>>> On 9/21/22 14:13, Yicong Yang wrote:
>>>>>>>> +static inline bool arch_tlbbatch_should_defer(struct mm_struct *mm)
>>>>>>>> +{
>>>>>>>> +    /* for small systems with small number of CPUs, TLB shootdown is cheap */
>>>>>>>> +    if (num_online_cpus() <= 4)
>>>>>>> It would be great to have some more inputs from others, whether 4 (which should
>>>>>>> to be codified into a macro e.g ARM64_NR_CPU_DEFERRED_TLB, or something similar)
>>>>>>> is optimal for an wide range of arm64 platforms.
>>>>>>>
>>>>> I have tested it on a 4-cpus and 8-cpus machine. but i have no machine
>>>>> with 5,6,7
>>>>> cores.
>>>>> I saw improvement on 8-cpus machines and I found 4-cpus machines don't need
>>>>> this patch.
>>>>>
>>>>> so it seems safe to have
>>>>> if (num_online_cpus()  < 8)
>>>>>
>>>>>> Do you prefer this macro to be static or make it configurable through kconfig then
>>>>>> different platforms can make choice based on their own situations? It maybe hard to
>>>>>> test on all the arm64 platforms.
>>>>> Maybe we can have this default enabled on machines with 8 and more cpus and
>>>>> provide a tlbflush_batched = on or off to allow users enable or
>>>>> disable it according
>>>>> to their hardware and products. Similar example: rodata=on or off.
>>>> No, sounds bit excessive. Kernel command line options should not be added
>>>> for every possible run time switch options.
>>>>
>>>>> Hi Anshuman, Will,  Catalin, Andrew,
>>>>> what do you think about this approach?
>>>>>
>>>>> BTW, haoxin mentioned another important user scenarios for tlb bach on arm64:
>>>>> https://lore.kernel.org/lkml/393d6318-aa38-01ed-6ad8-f9eac89bf0fc@linux.alibaba.com/
>>>>>
>>>>> I do believe we need it based on the expensive cost of tlb shootdown in arm64
>>>>> even by hardware broadcast.
>>>> Alright, for now could we enable ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH selectively
>>>> with CONFIG_EXPERT and for num_online_cpus()  > 8 ?
>>> When running the test program in the commit in a VM, I saw benefits from
>>> the patches at all sizes from 2, 4, 8, 32 vcpus. On the test machine,
>>> ptep_clear_flush() went from ~1% in the unpatched version to not showing
>>> up.
>>>
>>> Yicong mentioned that he didn't see any benefit for <= 4 CPUs but is
>>> there any overhead? I am wondering what are the downsides of enabling
>>> the config by default.
>> As we are deferring tlb flush, but sometimes while we are modifying the vma
>> which are deferred, we need to do a sync by flush_tlb_batched_pending() in
>> mprotect() , madvise() to make sure they can see the flushed result. if nobody
>> is doing mprotect(), madvise() etc in the deferred period, the overhead is zero.
>
> Right, it is difficult to justify this overhead for smaller systems,
> which for sure would not benefit from this batched TLB framework.

Thank you for the pointers to the overhead.

Having looked at this more closely, I also see that
flush_tlb_batched_pending() discards the entire mm vs just flushing the
page being unmapped (as is done with ptep_clear_flush()).
