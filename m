Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6066640E3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 13:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238480AbjAJMuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 07:50:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238429AbjAJMuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 07:50:17 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49635004F
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 04:50:15 -0800 (PST)
Received: from kwepemi500024.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NrrBZ67B1zqV2V;
        Tue, 10 Jan 2023 20:45:26 +0800 (CST)
Received: from [10.174.179.163] (10.174.179.163) by
 kwepemi500024.china.huawei.com (7.221.188.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 10 Jan 2023 20:50:11 +0800
Message-ID: <0736f30a-294e-b8e0-f085-37b03e4f7efe@huawei.com>
Date:   Tue, 10 Jan 2023 20:50:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH -v2] x86/boot/compressed: Register dummy NMI handler in
 EFI boot loader, to avoid kdump crashes
Content-Language: en-US
To:     Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>
CC:     <michael.roth@amd.com>, <hpa@zytor.com>, <tglx@linutronix.de>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        <kirill.shutemov@linux.intel.com>, <jroedel@suse.de>,
        <keescook@chromium.org>, <mingo@redhat.com>,
        <dave.hansen@linux.intel.com>, <linux-kernel@vger.kernel.org>,
        <x86@kernel.org>, <liwei391@huawei.com>,
        Tony Luck <tony.luck@intel.com>
References: <20230110102745.2514694-1-zengheng4@huawei.com>
 <Y71FJ+G0NGQe3Ppq@gmail.com> <Y71TglxSLJKO17SY@gmail.com>
 <Y71V8SRLxZ/Uqkfs@zn.tnic> <Y71XPl8br2QU2L8E@zn.tnic>
 <Y71bW/8XZCackPLh@gmail.com>
From:   Zeng Heng <zengheng4@huawei.com>
In-Reply-To: <Y71bW/8XZCackPLh@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.163]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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


On 2023/1/10 20:34, Ingo Molnar wrote:
> * Borislav Petkov <bp@alien8.de> wrote:
>
>>> mce_panic -> panic -> __crash_kexec()
>>>
>>> Yes?
>>>
>>> If so, then we should make sure we have *exited* #MC context before calling
>>> panic() and not have to add hacks like this one of adding an empty NMI handler.
>>>
>>> But I'm only speculating as it is hard to make sense of all this text.
>> IOW, does this help?
>>
>> ---
>> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
>> index 7832a69d170e..55437d8a4fad 100644
>> --- a/arch/x86/kernel/cpu/mce/core.c
>> +++ b/arch/x86/kernel/cpu/mce/core.c
>> @@ -287,6 +287,7 @@ static noinstr void mce_panic(const char *msg, struct mce *final, char *exp)
>>   		if (panic_timeout == 0)
>>   			panic_timeout = mca_cfg.panic_timeout;
>>   		panic(msg);
>> +		mce_wrmsrl(MSR_IA32_MCG_STATUS, 0);

I'm willing to test any patch provided, but the panic() is never return 
and the

mce_wrmsrl() would be never called. Am I wrong?

B.R.,

Zeng Heng

> So your suggestion was to exit MC context 'before' the panic() call - but
> the patch calls it 'after' - was that intentional?
>
> Thanks,
>
> 	Ingo
