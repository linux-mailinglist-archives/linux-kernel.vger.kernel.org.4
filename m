Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A31C66421F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 14:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233068AbjAJNmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 08:42:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232706AbjAJNmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 08:42:15 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65AEA8FC1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 05:42:14 -0800 (PST)
Received: from kwepemi500024.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NrsLX6g8KzqV3Z;
        Tue, 10 Jan 2023 21:37:24 +0800 (CST)
Received: from [10.174.179.163] (10.174.179.163) by
 kwepemi500024.china.huawei.com (7.221.188.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 10 Jan 2023 21:42:09 +0800
Message-ID: <8fd825e3-494a-8a06-2b30-91458db2815b@huawei.com>
Date:   Tue, 10 Jan 2023 21:42:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH -v2] x86/boot/compressed: Register dummy NMI handler in
 EFI boot loader, to avoid kdump crashes
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
CC:     Ingo Molnar <mingo@kernel.org>, <michael.roth@amd.com>,
        <hpa@zytor.com>, <tglx@linutronix.de>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        <kirill.shutemov@linux.intel.com>, <jroedel@suse.de>,
        <keescook@chromium.org>, <mingo@redhat.com>,
        <dave.hansen@linux.intel.com>, <brijesh.singh@amd.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <liwei391@huawei.com>
References: <20230110102745.2514694-1-zengheng4@huawei.com>
 <Y71FJ+G0NGQe3Ppq@gmail.com> <Y71TglxSLJKO17SY@gmail.com>
 <Y71V8SRLxZ/Uqkfs@zn.tnic> <684a2472-f388-b2e1-4a7a-7bc9a07650b4@huawei.com>
 <Y71goW5qTW5dZKcv@zn.tnic>
From:   Zeng Heng <zengheng4@huawei.com>
In-Reply-To: <Y71goW5qTW5dZKcv@zn.tnic>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.163]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500024.china.huawei.com (7.221.188.100)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/1/10 20:57, Borislav Petkov wrote:
> On Tue, Jan 10, 2023 at 08:32:07PM +0800, Zeng Heng wrote:
>> mce is registered on NMI handler by inject_init().
> That's a handler for the NMI raised by raise_mce(). That's for the injection
> case, which is simulated. If you're fixing the injection case, then surely not
> with a bogus boot NMI handler.

OK, mce-injection is the simulated one.

>
>> Yes, exactly. The following procedure is like:
>>
>> panic() -> relocate_kernel() -> identity_mapped() -> x86 purgatory image ->
>> EFI loader -> secondary kernel
> I'm doubtful now as you're injecting errors so you're not really in #MC context
> but in this contrived context which is actually an NMI one. So we need to think
> about how to fix this case.
>
> Certainly not with an empty NMI handler...
>
> Regardless, we should do
>
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 7832a69d170e..57fe376ed049 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -286,6 +286,8 @@ static noinstr void mce_panic(const char *msg, struct mce *final, char *exp)
>   	if (!fake_panic) {
>   		if (panic_timeout == 0)
>   			panic_timeout = mca_cfg.panic_timeout;
> +
> +		mce_wrmsrl(MSR_IA32_MCG_STATUS, 0);
>   		panic(msg);
>   	} else
>   		pr_emerg(HW_ERR "Fake kernel panic: %s\n", msg);
>
> so that we not run kexec in #MC context.
>
> Hmmm.

I don't have ready test case for real MCE to verify whether it has 
exited #MC context before panic() or not.

In mce-inject case that based on NMI, it doesn't work as mentioned indeed.

B.R.,

Zeng Heng

