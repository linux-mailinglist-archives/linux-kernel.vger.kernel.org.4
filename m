Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E44620F26
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 12:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233910AbiKHLeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 06:34:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233846AbiKHLd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 06:33:59 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17611277E
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 03:33:57 -0800 (PST)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N65Vw2fD9zpWG1;
        Tue,  8 Nov 2022 19:30:16 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 19:33:55 +0800
Message-ID: <598bc40d-e826-f9cc-14fd-f4570051f4c6@huawei.com>
Date:   Tue, 8 Nov 2022 19:33:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v4 0/8] Add OPTPROBES feature on RISCV
To:     Xim <chenguokai17@mails.ucas.ac.cn>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
CC:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <rostedt@goodmis.org>, <mingo@redhat.com>,
        <sfr@canb.auug.org.au>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Liao Chang <liaoclark@163.com>
References: <20221106100316.2803176-1-chenguokai17@mails.ucas.ac.cn>
 <87y1sm1z8j.fsf@all.your.base.are.belong.to.us>
 <9A705974-A007-45E2-BC5D-A7E90821A258@mails.ucas.ac.cn>
From:   "liaochang (A)" <liaochang1@huawei.com>
In-Reply-To: <9A705974-A007-45E2-BC5D-A7E90821A258@mails.ucas.ac.cn>
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



在 2022/11/8 19:04, Xim 写道:
> Hi Björn,
> 
> Thanks for your great review! Some explanations below.
> 
>> 2022年11月8日 00:54，Björn Töpel <bjorn@kernel.org> 写道：
>>
>> Have you run the series on real hardware, or just qemu?
> 
> Currently only qemu tests are made, I will try to test it on a FPGA real hardware soon.
> 
>> AFAIU, the algorithm only tracks registers that are *in use*. You are
>> already scanning the whole function (next patch). What about the caller
>> saved registers that are *not* used by the function in the probe range?
>> Can those, potentially unused, regs be used?
> 
> Great missing part! I have made a static analyzation right upon receiving this mail.
> The result shows that this newly purposed idea reaches about the same
> success rate on my test set (rv64 defconf with RVI only) while when combined,
> they can reach a higher success rate, 1/3 above their baseline. A patch that
> includes this strategy will be sent soon.
>>
>>> +static void arch_find_register(unsigned long start, unsigned long end,
>>
>> Nit; When I see "arch_" I think it's functionality that can be
>> overridden per-arch. This is not the case, but just a helper for RV.
> 
> It can be explained from two aspects. First, it can be extended to most RISC
> archs, which can be extracted into the common flow of Kprobe. Second, it is indeed
> a internal helper for now, so I will correct the name in the next version.
> 
>>> static void find_free_registers(struct kprobe *kp, struct optimized_kprobe *op,
>>> -				int *rd1, int *rd2)
>>> +				int *rd, int *ra)
>>
>> Nit; Please get rid of this code churn, just name the parameters
>> correctly on introduction in the previous patch.
> 
> Will be fixed.
> 
>>> +	*rd = ((kw | ow) == 1UL) ? 0 : __builtin_ctzl((kw | ow) & ~1UL);
>>> +	*ra = (kw == 1UL) ? 0 : __builtin_ctzl(kw & ~1UL);
>>
>> Hmm, __builtin_ctzl is undefined for 0, right? Can that be triggered
>> here?

This corner case has been taken into account, look these condition parts,
if kw == 1UL this expression will return 0 directly, no chance to invoke __builtin_ctzl.

Thanks.

> 
> Will be fixed.
> 
> Regards,
> Guokai Chen
> 

-- 
BR,
Liao, Chang
