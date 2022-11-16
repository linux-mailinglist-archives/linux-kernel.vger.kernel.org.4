Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2080762B183
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 03:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbiKPCva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 21:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbiKPCv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 21:51:28 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 48B0A29353;
        Tue, 15 Nov 2022 18:51:26 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2060D13D5;
        Tue, 15 Nov 2022 18:51:32 -0800 (PST)
Received: from [10.162.40.17] (unknown [10.162.40.17])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D8A1C3F663;
        Tue, 15 Nov 2022 18:51:15 -0800 (PST)
Message-ID: <01ffa482-8d59-4cf9-f103-fb39a987873d@arm.com>
Date:   Wed, 16 Nov 2022 08:21:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v6 2/2] arm64: support batched/deferred tlb shootdown
 during page reclamation
Content-Language: en-US
To:     Nadav Amit <namit@vmware.com>, Yicong Yang <yangyicong@huawei.com>
Cc:     "yangyicong@hisilicon.com" <yangyicong@hisilicon.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, X86 ML <x86@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "punit.agrawal@bytedance.com" <punit.agrawal@bytedance.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        "darren@os.amperecomputing.com" <darren@os.amperecomputing.com>,
        "huzhanyuan@oppo.com" <huzhanyuan@oppo.com>,
        "lipeifeng@oppo.com" <lipeifeng@oppo.com>,
        "zhangshiming@oppo.com" <zhangshiming@oppo.com>,
        "guojian@oppo.com" <guojian@oppo.com>,
        "realmz6@gmail.com" <realmz6@gmail.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Barry Song <21cnbao@gmail.com>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        haoxin <xhao@linux.alibaba.com>,
        "prime.zeng@hisilicon.com" <prime.zeng@hisilicon.com>,
        Barry Song <v-songbaohua@oppo.com>,
        Mel Gorman <mgorman@suse.de>
References: <20221115031425.44640-1-yangyicong@huawei.com>
 <20221115031425.44640-3-yangyicong@huawei.com>
 <0D3A45FE-5367-40CD-A035-37F6EE98B25E@vmware.com>
 <91e4804d-cb99-fd22-dafd-2f418f5c7ba9@huawei.com>
 <E3756C83-767A-4C68-AE3F-8C979F47A029@vmware.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <E3756C83-767A-4C68-AE3F-8C979F47A029@vmware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/16/22 07:26, Nadav Amit wrote:
> On Nov 15, 2022, at 5:50 PM, Yicong Yang <yangyicong@huawei.com> wrote:
> 
>> !! External Email
>>
>> On 2022/11/16 7:38, Nadav Amit wrote:
>>> On Nov 14, 2022, at 7:14 PM, Yicong Yang <yangyicong@huawei.com> wrote:
>>>
>>>> diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
>>>> index 8a497d902c16..5bd78ae55cd4 100644
>>>> --- a/arch/x86/include/asm/tlbflush.h
>>>> +++ b/arch/x86/include/asm/tlbflush.h
>>>> @@ -264,7 +264,8 @@ static inline u64 inc_mm_tlb_gen(struct mm_struct *mm)
>>>> }
>>>>
>>>> static inline void arch_tlbbatch_add_mm(struct arch_tlbflush_unmap_batch *batch,
>>>> -                                    struct mm_struct *mm)
>>>> +                                    struct mm_struct *mm,
>>>> +                                    unsigned long uaddr)
>>>
>>> Logic-wise it looks fine. I notice the “v6", and it should not be blocking,
>>> but I would note that the name "arch_tlbbatch_add_mm()” does not make much
>>> sense once the function also takes an address.
>>
>> ok the add_mm should still apply to x86 since the address is not used, but not for arm64.
>>
>>> It could’ve been something like arch_set_tlb_ubc_flush_pending() but that’s
>>> too long. I’m not very good with naming, but the current name is not great.
>>
>> What about arch_tlbbatch_add_pending()? Considering the x86 is pending the flush operation
>> while arm64 is pending the sychronization operation, arch_tlbbatch_add_pending() should
>> make sense to both.
> 
> Sounds reasonable. Thanks.

+1, agreed.
