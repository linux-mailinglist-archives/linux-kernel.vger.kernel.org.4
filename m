Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9F75E870C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 03:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232991AbiIXBwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 21:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232982AbiIXBwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 21:52:32 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACFB10196D;
        Fri, 23 Sep 2022 18:52:32 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MZBmT4r3qzHqM9;
        Sat, 24 Sep 2022 09:50:17 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 24 Sep 2022 09:52:29 +0800
Message-ID: <19ffdae6-8484-08e5-f408-ab39a97ce5c0@huawei.com>
Date:   Sat, 24 Sep 2022 09:52:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 3/3] arm64/kprobe: Optimize the performance of patching
 single-step slot
To:     Mark Rutland <mark.rutland@arm.com>
CC:     <catalin.marinas@arm.com>, <will@kernel.org>, <guoren@kernel.org>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <mhiramat@kernel.org>,
        <rostedt@goodmis.org>, <maz@kernel.org>,
        <alexandru.elisei@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-csky@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
References: <20220923084658.99304-1-liaochang1@huawei.com>
 <20220923084658.99304-4-liaochang1@huawei.com>
 <Yy2pAEvWKVloVr3U@FVFF77S0Q05N>
From:   "liaochang (A)" <liaochang1@huawei.com>
In-Reply-To: <Yy2pAEvWKVloVr3U@FVFF77S0Q05N>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.108]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/9/23 20:39, Mark Rutland 写道:
> On Fri, Sep 23, 2022 at 04:46:58PM +0800, Liao Chang wrote:
>> Single-step slot would not be used until kprobe is enabled, that means
>> no race condition occurs on it under SMP, hence it is safe to pacth ss
>> slot without stopping machine.
> 
> I think this is correct, but this depends on a couple of subtleties,
> importantly:
> 
> * That the I-cache maintenance for these instructions is complete *before* the
>   kprobe BRK is written (and aarch64_insn_patch_text_nosync() ensures this, but
>   just omits causing a Context-Synchronization-Event on all CPUS).

So in order to guarantee the I-cache maintenance is observed on all CPUS,
it needs to be followed by a explicit Context-Synchronization-Event, perhaps
it is better to place ISB before kprobe BRK is written.

> 
> * That the kprobe BRK results in an exception (and consequently a
>   Context-Synchronoization-Event), which ensures that the CPU will fetch the
>   single-step slot instructions *after* this, ensuring that the new
>   instructions are used.

Yes, because of single-step slot is installed int the BRK execption handler,
so it is not necessary to generate Context-Synchronization-Event via ISB mentioned above...

Thanks.

> 
> It would be good if we could call that out explicitly.
> 
> Thanks,
> Mark.
> 
>> Since I and D caches are coherent within single-step slot from
>> aarch64_insn_patch_text_nosync(), hence no need to do it again via
>> flush_icache_range().
>>
>> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>> Signed-off-by: Liao Chang <liaochang1@huawei.com>
>> ---
>>  arch/arm64/kernel/probes/kprobes.c | 7 ++-----
>>  1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
>> index d1d182320245..29b98bc12833 100644
>> --- a/arch/arm64/kernel/probes/kprobes.c
>> +++ b/arch/arm64/kernel/probes/kprobes.c
>> @@ -44,13 +44,10 @@ post_kprobe_handler(struct kprobe *, struct kprobe_ctlblk *, struct pt_regs *);
>>  static void __kprobes arch_prepare_ss_slot(struct kprobe *p)
>>  {
>>  	kprobe_opcode_t *addr = p->ainsn.api.insn;
>> -	void *addrs[] = {addr, addr + 1};
>> -	u32 insns[] = {p->opcode, BRK64_OPCODE_KPROBES_SS};
>>  
>>  	/* prepare insn slot */
>> -	aarch64_insn_patch_text(addrs, insns, 2);
>> -
>> -	flush_icache_range((uintptr_t)addr, (uintptr_t)(addr + MAX_INSN_SIZE));
>> +	aarch64_insn_patch_text_nosync(addr, p->opcode);
>> +	aarch64_insn_patch_text_nosync(addr + 1, BRK64_OPCODE_KPROBES_SS);
>>  
>>  	/*
>>  	 * Needs restoring of return address after stepping xol.
>> -- 
>> 2.17.1
>>
> 
> .

-- 
BR,
Liao, Chang
