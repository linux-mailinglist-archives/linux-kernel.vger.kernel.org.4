Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBAF75E715D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 03:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbiIWBZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 21:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiIWBZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 21:25:01 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF51D107DF0;
        Thu, 22 Sep 2022 18:24:59 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MYZ971SjTzWh5r;
        Fri, 23 Sep 2022 09:20:59 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 23 Sep 2022 09:24:56 +0800
Message-ID: <55c32279-1a96-0a31-ca2b-ae4e34365625@huawei.com>
Date:   Fri, 23 Sep 2022 09:24:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH V2 3/3] arm64/kprobe: Optimize the performance of patching
 single-step slot
To:     Will Deacon <will@kernel.org>
CC:     <catalin.marinas@arm.com>, <guoren@kernel.org>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <rostedt@goodmis.org>,
        <mhiramat@kernel.org>, <maz@kernel.org>,
        <alexandru.elisei@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-csky@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
References: <20220913033454.104519-1-liaochang1@huawei.com>
 <20220913033454.104519-4-liaochang1@huawei.com>
 <20220922133850.GC12095@willie-the-truck>
From:   "liaochang (A)" <liaochang1@huawei.com>
In-Reply-To: <20220922133850.GC12095@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.108]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/9/22 21:38, Will Deacon 写道:
> On Tue, Sep 13, 2022 at 11:34:54AM +0800, Liao Chang wrote:
>> Single-step slot would not be used until kprobe is enabled, that means
>> no race condition occurs on it under SMP, hence it is safe to pacth ss
>> slot without stopping machine.
>>
>> Signed-off-by: Liao Chang <liaochang1@huawei.com>
>> ---
>>  arch/arm64/kernel/probes/kprobes.c | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
>> index d1d182320245..5902e33fd3b6 100644
>> --- a/arch/arm64/kernel/probes/kprobes.c
>> +++ b/arch/arm64/kernel/probes/kprobes.c
>> @@ -44,11 +44,10 @@ post_kprobe_handler(struct kprobe *, struct kprobe_ctlblk *, struct pt_regs *);
>>  static void __kprobes arch_prepare_ss_slot(struct kprobe *p)
>>  {
>>  	kprobe_opcode_t *addr = p->ainsn.api.insn;
>> -	void *addrs[] = {addr, addr + 1};
>> -	u32 insns[] = {p->opcode, BRK64_OPCODE_KPROBES_SS};
>>  
>>  	/* prepare insn slot */
>> -	aarch64_insn_patch_text(addrs, insns, 2);
>> +	aarch64_insn_write(addr, p->opcode);
>> +	aarch64_insn_write(addr + 1, BRK64_OPCODE_KPROBES_SS);
>>  
>>  	flush_icache_range((uintptr_t)addr, (uintptr_t)(addr + MAX_INSN_SIZE));
> 
> Hmm, so it looks like prior to your change we were doing the cache
> maintebnance twice: once in aarch64_insn_patch_text() from stop machine
> context and then again in the flush_icache_range() call above.
> 
> I suppose the cleanest thing would be to drop the flush_icache_range()
> call and then use aarch64_insn_patch_text_nosync() instead of
> aarch64_insn_write() in your change.

OK，I will improve it in next version, thanks.

> 
> Will
> .

-- 
BR,
Liao, Chang
