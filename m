Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E5562B0C9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 02:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbiKPBvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 20:51:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiKPBvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 20:51:03 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0719225E9D;
        Tue, 15 Nov 2022 17:51:01 -0800 (PST)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NBmGP6h74z15Mgc;
        Wed, 16 Nov 2022 09:50:37 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 09:50:58 +0800
CC:     <yangyicong@hisilicon.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, X86 ML <x86@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
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
Subject: Re: [PATCH v6 2/2] arm64: support batched/deferred tlb shootdown
 during page reclamation
To:     Nadav Amit <namit@vmware.com>
References: <20221115031425.44640-1-yangyicong@huawei.com>
 <20221115031425.44640-3-yangyicong@huawei.com>
 <0D3A45FE-5367-40CD-A035-37F6EE98B25E@vmware.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <91e4804d-cb99-fd22-dafd-2f418f5c7ba9@huawei.com>
Date:   Wed, 16 Nov 2022 09:50:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <0D3A45FE-5367-40CD-A035-37F6EE98B25E@vmware.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/16 7:38, Nadav Amit wrote:
> On Nov 14, 2022, at 7:14 PM, Yicong Yang <yangyicong@huawei.com> wrote:
> 
>> diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
>> index 8a497d902c16..5bd78ae55cd4 100644
>> --- a/arch/x86/include/asm/tlbflush.h
>> +++ b/arch/x86/include/asm/tlbflush.h
>> @@ -264,7 +264,8 @@ static inline u64 inc_mm_tlb_gen(struct mm_struct *mm)
>> }
>>
>> static inline void arch_tlbbatch_add_mm(struct arch_tlbflush_unmap_batch *batch,
>> -					struct mm_struct *mm)
>> +					struct mm_struct *mm,
>> +					unsigned long uaddr)
> 
> Logic-wise it looks fine. I notice the “v6", and it should not be blocking,
> but I would note that the name "arch_tlbbatch_add_mm()” does not make much
> sense once the function also takes an address.
> 

ok the add_mm should still apply to x86 since the address is not used, but not for arm64.

> It could’ve been something like arch_set_tlb_ubc_flush_pending() but that’s
> too long. I’m not very good with naming, but the current name is not great.
> 

What about arch_tlbbatch_add_pending()? Considering the x86 is pending the flush operation
while arm64 is pending the sychronization operation, arch_tlbbatch_add_pending() should
make sense to both.

Thanks.

