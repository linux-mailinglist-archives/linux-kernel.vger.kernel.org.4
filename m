Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C03460FA4A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 16:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236265AbiJ0OTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 10:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236062AbiJ0OTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 10:19:08 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13066188A94
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 07:19:07 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id bp11so2418452wrb.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 07:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y/eINMlmbJBT0Nx7Q4sfLDyjRpzPNMcfZ0CREI4hqno=;
        b=mbukdALrSt0e0Xy4FkFyuHJzpwUdkyhoGFOxMyHUB7cxYmMBOVcqKs7RAsg3TvKCMI
         S6Zt6qpSUwkQjxNNynwidnp+zFyIsBNmXxZzJjNls7MYhrbClbxzYmIVgRYp06bSQdtL
         O7fH1uUWV7MEOXcVso26GgH9a/JML0ZANePeYFgvoRP0qL2d2Ahpn/AaBliDN7CLjbvY
         gJZTLiVy1C5KhCv9CDCCP3ri0epXt9PZTTgGTDX6YM3buYGEnVVu0TewyqNPkVoASFNV
         HoQLFEWGw10kDNxYOQhiSN2oCj4N7aJDsvRT/pTpO0Sl2koUjt+Id8P6r55SN+Gkye+h
         8EYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y/eINMlmbJBT0Nx7Q4sfLDyjRpzPNMcfZ0CREI4hqno=;
        b=VWbSCv+oWZtGnXzjLfWJ4z2YZk3jLx/Xgd3V2J8JGUeCR8fE1h+6gCUeKkInPVn7Hp
         MO+i30MXCp5Lo4tGvsFRGLp9cR8QPMBmM6ccdhrw3Nhp2tTpY/7s8wHxY469lylkJquD
         v/GgFZlt42ue/9jMFAZsKcKaZcQbcm8hyUarky62/jz5acouBlSSojY7GmfwugM+zq2Q
         ckUSYQi8RsgTQ9YTF4yPXgWogrFQE9jvnDsLNS9Wt2AlbhQt5ybYGz0m0glm5K4r4/TD
         IfWHmLLCO0Nihkv3cmAlAPje8zrsx/AILYp8RyqeK7TXg92AsG/Xxh1fmQsamt/N55j7
         UImQ==
X-Gm-Message-State: ACrzQf1dfMdO+86aO6U5ihQ23aCiR1Ch5vcY24pqn2Jnt+fBe5Qivs6g
        /vx7fNWPe/+Mk9zQ1OmXWTVwIA==
X-Google-Smtp-Source: AMsMyM6DMVnaAfEbCGsBgr0BuHUuRcLePH4/Vs6YQPdqiIKHzKuxA0+67WIXfXH9Uz+IHOQBcqEyow==
X-Received: by 2002:a05:6000:79c:b0:236:6f2e:301e with SMTP id bu28-20020a056000079c00b002366f2e301emr14778667wrb.458.1666880345421;
        Thu, 27 Oct 2022 07:19:05 -0700 (PDT)
Received: from localhost ([95.148.15.66])
        by smtp.gmail.com with ESMTPSA id bh17-20020a05600c3d1100b003cf47fdead5sm1727545wmb.30.2022.10.27.07.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 07:19:04 -0700 (PDT)
From:   Punit Agrawal <punit.agrawal@bytedance.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Barry Song <21cnbao@gmail.com>,
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
Date:   Thu, 27 Oct 2022 15:19:02 +0100
In-Reply-To: <ecd161db-b290-7997-a81e-a0a00bd1c599@arm.com> (Anshuman
        Khandual's message of "Thu, 27 Oct 2022 16:11:59 +0530")
Message-ID: <87o7tx5oyx.fsf@stealth>
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


[ Apologies for chiming in late in the conversation ]

Anshuman Khandual <anshuman.khandual@arm.com> writes:

> On 9/28/22 05:53, Barry Song wrote:
>> On Tue, Sep 27, 2022 at 10:15 PM Yicong Yang <yangyicong@huawei.com> wrote:
>>>
>>> On 2022/9/27 14:16, Anshuman Khandual wrote:
>>>> [...]
>>>>
>>>> On 9/21/22 14:13, Yicong Yang wrote:
>>>>> +static inline bool arch_tlbbatch_should_defer(struct mm_struct *mm)
>>>>> +{
>>>>> +    /* for small systems with small number of CPUs, TLB shootdown is cheap */
>>>>> +    if (num_online_cpus() <= 4)
>>>>
>>>> It would be great to have some more inputs from others, whether 4 (which should
>>>> to be codified into a macro e.g ARM64_NR_CPU_DEFERRED_TLB, or something similar)
>>>> is optimal for an wide range of arm64 platforms.
>>>>
>> 
>> I have tested it on a 4-cpus and 8-cpus machine. but i have no machine
>> with 5,6,7
>> cores.
>> I saw improvement on 8-cpus machines and I found 4-cpus machines don't need
>> this patch.
>> 
>> so it seems safe to have
>> if (num_online_cpus()  < 8)
>> 
>>>
>>> Do you prefer this macro to be static or make it configurable through kconfig then
>>> different platforms can make choice based on their own situations? It maybe hard to
>>> test on all the arm64 platforms.
>> 
>> Maybe we can have this default enabled on machines with 8 and more cpus and
>> provide a tlbflush_batched = on or off to allow users enable or
>> disable it according
>> to their hardware and products. Similar example: rodata=on or off.
>
> No, sounds bit excessive. Kernel command line options should not be added
> for every possible run time switch options.
>
>> 
>> Hi Anshuman, Will,  Catalin, Andrew,
>> what do you think about this approach?
>> 
>> BTW, haoxin mentioned another important user scenarios for tlb bach on arm64:
>> https://lore.kernel.org/lkml/393d6318-aa38-01ed-6ad8-f9eac89bf0fc@linux.alibaba.com/
>> 
>> I do believe we need it based on the expensive cost of tlb shootdown in arm64
>> even by hardware broadcast.
>
> Alright, for now could we enable ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH selectively
> with CONFIG_EXPERT and for num_online_cpus()  > 8 ?

When running the test program in the commit in a VM, I saw benefits from
the patches at all sizes from 2, 4, 8, 32 vcpus. On the test machine,
ptep_clear_flush() went from ~1% in the unpatched version to not showing
up.

Yicong mentioned that he didn't see any benefit for <= 4 CPUs but is
there any overhead? I am wondering what are the downsides of enabling
the config by default.

Thanks,
Punit
