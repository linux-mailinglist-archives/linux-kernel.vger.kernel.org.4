Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A0F6C3F6B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 02:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjCVBFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 21:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjCVBFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 21:05:34 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54EA650718;
        Tue, 21 Mar 2023 18:05:32 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Ph9GY1Fr1zrW1T;
        Wed, 22 Mar 2023 09:04:05 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 22 Mar 2023 09:05:05 +0800
Message-ID: <51651742-8c48-73c7-b283-4465b28fc0a0@huawei.com>
Date:   Wed, 22 Mar 2023 09:05:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: next-20230321: arm64: Unable to handle kernel paging request at
 virtual address
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
CC:     Petr Mladek <pmladek@suse.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        <lkft-triage@lists.linaro.org>, linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Steven Rostedt <rostedt@goodmis.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>
References: <CA+G9fYsTk0GPOTEMm1KG2iJvMLG0SqUfG0JSenRYFHuOQTpuxw@mail.gmail.com>
 <ZBl4Zi03pzURXkD9@alley> <20230321155626.GA3765079@dev-arch.thelio-3990X>
 <ZBnifM5B/E5weCnF@bombadil.infradead.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <ZBnifM5B/E5weCnF@bombadil.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/22 0:59, Luis Chamberlain wrote:
> On Tue, Mar 21, 2023 at 08:56:26AM -0700, Nathan Chancellor wrote:
>> On Tue, Mar 21, 2023 at 10:27:02AM +0100, Petr Mladek wrote:
>>> Hi,
>>>
>>> I add Luis into Cc.
>>>
>>> On Tue 2023-03-21 11:42:56, Naresh Kamboju wrote:
>>>> The following kernel crash was noticed on arm64 Juno-r2 and Raspberry Pi 4
>>>> Model B on Linux next-20230321.
>>>>
>>>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>>>>
>>>> log:
>>>> ----
>>>> [    3.071500] Unable to handle kernel paging request at virtual
>>>> address 0000000000001000
>>>
>>> I guess that this is exactly PAGE_SIZE (4k).
>>>
>>>> [    3.079432] Mem abort info:
>>>> [    3.082225]   ESR = 0x0000000096000004
>>>> [    3.085977]   EC = 0x25: DABT (current EL), IL = 32 bits
>>>> [    3.091295]   SET = 0, FnV = 0
>>>> [    3.094350]   EA = 0, S1PTW = 0
>>>> [    3.097491]   FSC = 0x04: level 0 translation fault
>>>> [    3.102373] Data abort info:
>>>> [    3.105252]   ISV = 0, ISS = 0x00000004
>>>> [    3.109089]   CM = 0, WnR = 0
>>>> [    3.112055] [0000000000001000] user address but active_mm is swapper
>>>> [    3.114230] usb 1-1: new high-speed USB device number 2 using ehci-platform
>>>> [    3.118418] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
>>>> [    3.118426] Modules linked in:
>>>> [    3.134717] CPU: 1 PID: 1 Comm: swapper/0 Not tainted
>>>> 6.3.0-rc3-next-20230321 #1
>>>> [    3.142126] Hardware name: ARM Juno development board (r2) (DT)
>>>> [    3.148052] pstate: 000000c5 (nzcv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>>> [    3.155027] pc : string (lib/vsprintf.c:644 lib/vsprintf.c:726)
>>>> [    3.158443] lr : vsnprintf (lib/vsprintf.c:2817)
>>>> [    3.162196] sp : ffff80000b34b8f0
>>>> [    3.165511] x29: ffff80000b34b8f0 x28: ffff800009d7b1ca x27: ffff80000b34bab0
>>>> [    3.172666] x26: ffff800009d7b1ca x25: 0000000000000020 x24: 0000000000000008
>>>> [    3.179820] x23: 00000000ffffffd8 x22: ffff8000099858a0 x21: ffff80000b34bc30
>>>> [    3.186973] x20: ffff80000b34ba90 x19: ffff80000b34ba98 x18: 000000003c98bfdd
>>>> [    3.194127] x17: 000000000000001c x16: 00000000eec48da2 x15: 00000000a9dbdd17
>>>> [    3.201280] x14: ffff80000b0242e8 x13: 0000000057a049ef x12: 00000000cfa47237
>>>> [    3.208433] x11: 0000000000000001 x10: 00000000bd5b8780 x9 : ffff80000812cbec
>>>> [    3.215586] x8 : 00000000ffffffff x7 : 0000000000000002 x6 : ffff80000b34ba98
>>>> [    3.222739] x5 : ffffffffffffffff x4 : 0000000000000000 x3 : ffff0a00ffffff04
>>>> [    3.229891] x2 : 0000000000001000 x1 : 0000000000000000 x0 : ffff80000b34bab0
>>>> [    3.237044] Call trace:
>>>> [    3.239489] string (lib/vsprintf.c:644 lib/vsprintf.c:726)
>>>
>>> This is the line where vsprintf() reads a string to be printed:
>>>
>>> static char *string_nocheck(char *buf, char *end, const char *s,
>>> 			    struct printf_spec spec)
>>> {
>>> 	int len = 0;
>>> 	int lim = spec.precision;
>>>
>>> 	while (lim--) {
>>> ---->		char c = *s++;
>>>
>>>
>>>> [    3.242551] vsnprintf (lib/vsprintf.c:2817)
>>>> [    3.245954] vprintk_store (kernel/printk/printk.c:2200)
>>>> [    3.249712] vprintk_emit (kernel/printk/printk.c:2297)
>>>> [    3.253381] vprintk_default (kernel/printk/printk.c:2328)
>>>> [    3.257137] vprintk (kernel/printk/printk_safe.c:50)
>>>> [    3.260198] _printk (kernel/printk/printk.c:2341)
>>>> [    3.263257] sysctl_err (fs/proc/proc_sysctl.c:1109)
>>>> [    3.266577] __register_sysctl_table (fs/proc/proc_sysctl.c:1140
>>>> fs/proc/proc_sysctl.c:1383)
>>>> [    3.271202] __register_sysctl_init (fs/proc/proc_sysctl.c:1462)
>>>
>>> The has been done some reractoring/modification of this code
>>> by the patchset ("[PATCH 00/11] sysctl: deprecate
>>> register_sysctl_paths()"), see
>>> https://lore.kernel.org/lkml/20230302202826.776286-1-mcgrof@kernel.org/
>>>
>>> Luis, does it trigger any bell, please?
>>> Do you have an idea where this code could pass a pointer PAGE_SIZE
>>> as string to printk("%s")?
>>
>> My bisect actually landed on commit cfe7e6ea5ee2 ("mm: memory-failure:
>> Move memory failure sysctls to its own file"). The new sysctl table is
>> missing a sentinel. The following diff resolves it for me.
>>
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index 6367714af61d..b2377f12f062 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -143,6 +143,7 @@ static struct ctl_table memory_failure_table[] = {
>>   		.extra1		= SYSCTL_ZERO,
>>   		.extra2		= SYSCTL_ONE,
>>   	},
>> +	{ }
>>   };
> 

Sorry, I don't know why this is removed after v1[1] when resend :(
thanks for your fix.

[1] https://lkml.org/lkml/2023/3/8/1644

> Thanks pushed this fix in to sysctl-next.
> 
>    Luis
