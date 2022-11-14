Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2DC62780A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 09:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235675AbiKNIqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 03:46:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236555AbiKNIqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 03:46:14 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6F41B9FF;
        Mon, 14 Nov 2022 00:46:13 -0800 (PST)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4N9jZS4TZcz15Md3;
        Mon, 14 Nov 2022 16:45:52 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 16:46:11 +0800
CC:     <yangyicong@hisilicon.com>, <corbet@lwn.net>,
        <peterz@infradead.org>, <arnd@arndb.de>,
        <punit.agrawal@bytedance.com>, <linux-kernel@vger.kernel.org>,
        <darren@os.amperecomputing.com>, <huzhanyuan@oppo.com>,
        <lipeifeng@oppo.com>, <zhangshiming@oppo.com>, <guojian@oppo.com>,
        <realmz6@gmail.com>, <linux-mips@vger.kernel.org>,
        <openrisc@lists.librecores.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-riscv@lists.infradead.org>, <linux-s390@vger.kernel.org>,
        Barry Song <21cnbao@gmail.com>, <wangkefeng.wang@huawei.com>,
        <xhao@linux.alibaba.com>, <prime.zeng@hisilicon.com>,
        Barry Song <v-songbaohua@oppo.com>,
        Nadav Amit <namit@vmware.com>, Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH v5 2/2] arm64: support batched/deferred tlb shootdown
 during page reclamation
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-arm-kernel@lists.infradead.org>, <x86@kernel.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <linux-doc@vger.kernel.org>
References: <20221028081255.19157-1-yangyicong@huawei.com>
 <20221028081255.19157-3-yangyicong@huawei.com>
 <86fbdc8c-0dcb-9b8f-d843-63460d8b1d6a@arm.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <9982dac0-9f2e-112a-d440-467c8e8f8aa4@huawei.com>
Date:   Mon, 14 Nov 2022 16:46:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <86fbdc8c-0dcb-9b8f-d843-63460d8b1d6a@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

On 2022/11/14 11:29, Anshuman Khandual wrote:
> 
> 
> On 10/28/22 13:42, Yicong Yang wrote:
>> +static inline bool arch_tlbbatch_should_defer(struct mm_struct *mm)
>> +{
>> +	/*
>> +	 * TLB batched flush is proved to be beneficial for systems with large
>> +	 * number of CPUs, especially system with more than 8 CPUs. TLB shutdown
>> +	 * is cheap on small systems which may not need this feature. So use
>> +	 * a threshold for enabling this to avoid potential side effects on
>> +	 * these platforms.
>> +	 */
>> +	if (num_online_cpus() <= CONFIG_ARM64_NR_CPUS_FOR_BATCHED_TLB)
>> +		return false;
>> +
>> +#ifdef CONFIG_ARM64_WORKAROUND_REPEAT_TLBI
>> +	if (unlikely(this_cpu_has_cap(ARM64_WORKAROUND_REPEAT_TLBI)))
>> +		return false;
>> +#endif
> 
> should_defer_flush() is immediately followed by set_tlb_ubc_flush_pending() which calls
> arch_tlbbatch_add_mm(), triggering the actual TLBI flush via __flush_tlb_page_nosync().
> It should be okay to check capability with this_cpu_has_cap() as the entire call chain
> here is executed on the same cpu. But just wondering if cpus_have_const_cap() would be
> simpler, consistent, and also cost effective ?
> 

ok. Checked cpus_have_const_cap() I think it matches your words.

> Regardless, a comment is needed before the #ifdef block explaining why it does not make
> sense to defer/batch when __tlbi()/__tlbi_user() implementation will execute 'dsb(ish)'
> between two TLBI instructions to workaround the errata.
> 

The workaround for the errata mentioned the affected platforms need the tlbi+dsb to be done
twice, so I'm not sure if we defer the final dsb will cause any problem so I think the judgement
here is used for safety. I have no such platform to test if it's ok to defer the last dsb.

>> +
>> +	return true;
>> +}
>> +
>> +static inline void arch_tlbbatch_add_mm(struct arch_tlbflush_unmap_batch *batch,
>> +					struct mm_struct *mm,
>> +					unsigned long uaddr)
>> +{
>> +	__flush_tlb_page_nosync(mm, uaddr);
>> +}
>> +
>> +static inline void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
>> +{
>> +	dsb(ish);
>> +}
> .
> 
