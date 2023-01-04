Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52A865CE64
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 09:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234110AbjADIes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 03:34:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234034AbjADIem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 03:34:42 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC6F1A222
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 00:34:38 -0800 (PST)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Nn2tH1RsPz16MML;
        Wed,  4 Jan 2023 16:33:11 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 4 Jan 2023 16:34:36 +0800
Message-ID: <9dacbd7a-6dc5-099c-d427-b20bfa22aabd@huawei.com>
Date:   Wed, 4 Jan 2023 16:34:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v5 3/9] riscv/kprobe: Prepare the skeleton to prepare
 optimized kprobe
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Chen Guokai <chenguokai17@mails.ucas.ac.cn>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <rostedt@goodmis.org>, <mingo@redhat.com>,
        <sfr@canb.auug.org.au>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20221224114315.850130-1-chenguokai17@mails.ucas.ac.cn>
 <20221224114315.850130-4-chenguokai17@mails.ucas.ac.cn>
 <87v8lovmoa.fsf@all.your.base.are.belong.to.us>
From:   "liaochang (A)" <liaochang1@huawei.com>
In-Reply-To: <87v8lovmoa.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.108]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/1/3 2:03, Björn Töpel 写道:
> Chen Guokai <chenguokai17@mails.ucas.ac.cn> writes:
> 
>> From: Liao Chang <liaochang1@huawei.com>
> 
>>  arch/riscv/kernel/probes/opt.c | 107 ++++++++++++++++++++++++++++++++-
>>
>> diff --git a/arch/riscv/kernel/probes/opt.c b/arch/riscv/kernel/probes/opt.c
>> index 56c8a227c857..a4271e6033ba 100644
>> --- a/arch/riscv/kernel/probes/opt.c
>> +++ b/arch/riscv/kernel/probes/opt.c
> 
>> @@ -24,7 +72,64 @@ int arch_check_optimized_kprobe(struct optimized_kprobe *op)
>>  int arch_prepare_optimized_kprobe(struct optimized_kprobe *op,
>>  				  struct kprobe *orig)
>>  {
>> -	return 0;
>> +	long rel;
>> +	int rd, ra, ret;
>> +	kprobe_opcode_t *code = NULL, *slot = NULL;
>> +
>> +	if (!can_optimize((unsigned long)orig->addr, op))
>> +		return -EILSEQ;
>> +
>> +	code = kzalloc(MAX_OPTINSN_SIZE, GFP_KERNEL);
>> +	slot = get_optinsn_slot();
>> +	if (!code || !slot) {
>> +		ret = -ENOMEM;
>> +		goto on_error;
>> +	}
>> +
>> +	/*
>> +	 * Verify if the address gap is within 4GB range, because this uses
>> +	 * a auipc+jalr pair.
> 
> Try to be consistent. You're mixing "AUIPC/JALR" with "auipc+jalr".

OK，i will use AUIPC/JALR in all commit messages and comments of this series.

> 
>> +	 */
>> +	rel = (unsigned long)slot - (unsigned long)orig->addr;
>> +	if (!in_auipc_jalr_range(rel)) {
>> +		/*
>> +		 * Different from x86, we free code buf directly instead
>> of
> 
> Reword for readers that are not familiar with x86.

OK, BTW, i think the code following tag on_error is fairly self-explanatoty,
perhaps this comment is no need anymore.

> 
> 
> Björn

-- 
BR,
Liao, Chang
