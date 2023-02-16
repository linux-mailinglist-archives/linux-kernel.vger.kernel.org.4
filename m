Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149D8698AAB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 03:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjBPCxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 21:53:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjBPCxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 21:53:52 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11F846097;
        Wed, 15 Feb 2023 18:53:51 -0800 (PST)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4PHKG81pxwz16Nc9;
        Thu, 16 Feb 2023 10:51:28 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 16 Feb 2023 10:53:48 +0800
Subject: Re: [PATCH 2/3] x86/kprobes: Fix __recover_optprobed_insn check
 optimizing logic
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <naveen.n.rao@linux.ibm.com>, <anil.s.keshavamurthy@intel.com>,
        <davem@davemloft.net>, <ast@kernel.org>, <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>
References: <20230215115430.236046-1-yangjihong1@huawei.com>
 <20230215115430.236046-3-yangjihong1@huawei.com>
 <20230216000849.f0e332ebf35150cb5d5c4a29@kernel.org>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <403950ec-b4d1-e0e1-2c30-742e2bd905f8@huawei.com>
Date:   Thu, 16 Feb 2023 10:53:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20230216000849.f0e332ebf35150cb5d5c4a29@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Masami,

On 2023/2/15 23:08, Masami Hiramatsu (Google) wrote:
> On Wed, 15 Feb 2023 19:54:29 +0800
> Yang Jihong <yangjihong1@huawei.com> wrote:
> 
>> Since the following commit:
>>
>>    commit f66c0447cca1 ("kprobes: Set unoptimized flag after unoptimizing code")
>>
>> modified the update timing of the KPROBE_FLAG_OPTIMIZED, a optimized_kprobe
>> may be in the optimizing or unoptimizing state when op.kp->flags
>> has KPROBE_FLAG_OPTIMIZED and op->list is not empty.
>>
>> The __recover_optprobed_insn check logic is incorrect, a kprobe in the
>> unoptimizing state may be incorrectly determined as unoptimizing.
>> As a result, incorrect instructions are copied.
> 
> Ah, good catch!
> 
>>
>> The optprobe_queued_unopt function needs to be exported for invoking in
>> arch directory.
>>
>> Fixes: f66c0447cca1 ("kprobes: Set unoptimized flag after unoptimizing code")
> 
> Cc: stable@vger.kernel.org

OK, will add in next version.

> 
>> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
>> ---
>>   arch/x86/kernel/kprobes/opt.c | 4 ++--
>>   include/linux/kprobes.h       | 1 +
>>   kernel/kprobes.c              | 2 +-
>>   3 files changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
>> index e57e07b0edb6..3718d6863555 100644
>> --- a/arch/x86/kernel/kprobes/opt.c
>> +++ b/arch/x86/kernel/kprobes/opt.c
>> @@ -46,8 +46,8 @@ unsigned long __recover_optprobed_insn(kprobe_opcode_t *buf, unsigned long addr)
>>   		/* This function only handles jump-optimized kprobe */
>>   		if (kp && kprobe_optimized(kp)) {
>>   			op = container_of(kp, struct optimized_kprobe, kp);
>> -			/* If op->list is not empty, op is under optimizing */
>> -			if (list_empty(&op->list))
>> +			/* If op is [un]optimized or under unoptimizing */
> 
> Hmm, this is a bit confusing comment. If it is unoptimized, the kprobe_optimized() returns false.
> Thus the comment should be /* If op is optimized or under unoptimizing */.
> 

OK, will fix in next version.

Thanks,
Yang.
