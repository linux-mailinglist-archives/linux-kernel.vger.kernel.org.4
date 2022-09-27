Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9FCF5EBE19
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 11:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbiI0JPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 05:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbiI0JPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 05:15:45 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF8F8A7F6;
        Tue, 27 Sep 2022 02:15:42 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4McDRd2xl3zpV3J;
        Tue, 27 Sep 2022 17:12:45 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 27 Sep 2022 17:15:40 +0800
CC:     <yangyicong@hisilicon.com>, <corbet@lwn.net>,
        <peterz@infradead.org>, <arnd@arndb.de>,
        <linux-kernel@vger.kernel.org>, <darren@os.amperecomputing.com>,
        <huzhanyuan@oppo.com>, <lipeifeng@oppo.com>,
        <zhangshiming@oppo.com>, <guojian@oppo.com>, <realmz6@gmail.com>,
        <linux-mips@vger.kernel.org>, <openrisc@lists.librecores.org>,
        <linux-mm@kvack.org>, <x86@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linuxppc-dev@lists.ozlabs.org>, <akpm@linux-foundation.org>,
        <linux-riscv@lists.infradead.org>, <linux-s390@vger.kernel.org>,
        Barry Song <21cnbao@gmail.com>, <wangkefeng.wang@huawei.com>,
        <xhao@linux.alibaba.com>, <prime.zeng@hisilicon.com>,
        Barry Song <v-songbaohua@oppo.com>,
        Nadav Amit <namit@vmware.com>, Mel Gorman <mgorman@suse.de>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] arm64: support batched/deferred tlb shootdown
 during page reclamation
To:     Anshuman Khandual <anshuman.khandual@arm.com>
References: <20220921084302.43631-1-yangyicong@huawei.com>
 <20220921084302.43631-3-yangyicong@huawei.com>
 <168eac93-a6ee-0b2e-12bb-4222eff24561@arm.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <8e391962-4e3a-5a56-64b4-78e8637e3b8c@huawei.com>
Date:   Tue, 27 Sep 2022 17:15:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <168eac93-a6ee-0b2e-12bb-4222eff24561@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/9/27 14:16, Anshuman Khandual wrote:
> [...]
> 
> On 9/21/22 14:13, Yicong Yang wrote:
>> +static inline bool arch_tlbbatch_should_defer(struct mm_struct *mm)
>> +{
>> +	/* for small systems with small number of CPUs, TLB shootdown is cheap */
>> +	if (num_online_cpus() <= 4)
> 
> It would be great to have some more inputs from others, whether 4 (which should
> to be codified into a macro e.g ARM64_NR_CPU_DEFERRED_TLB, or something similar)
> is optimal for an wide range of arm64 platforms.
> 

Do you prefer this macro to be static or make it configurable through kconfig then
different platforms can make choice based on their own situations? It maybe hard to
test on all the arm64 platforms.

Thanks.

>> +		return false;> +
>> +#ifdef CONFIG_ARM64_WORKAROUND_REPEAT_TLBI
>> +	if (unlikely(this_cpu_has_cap(ARM64_WORKAROUND_REPEAT_TLBI)))
>> +		return false;
>> +#endif
>> +
>> +	return true;
>> +}
>> +
> 
> [...]
> 
> .
> 
