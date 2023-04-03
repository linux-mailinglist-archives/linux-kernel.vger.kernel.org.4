Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D8C6D3B7B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 03:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbjDCBY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 21:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbjDCBYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 21:24:23 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8924FF
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 18:24:22 -0700 (PDT)
Received: from dggpemm500013.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4PqY7k0vxLzKqtr;
        Mon,  3 Apr 2023 09:23:46 +0800 (CST)
Received: from [10.67.108.67] (10.67.108.67) by dggpemm500013.china.huawei.com
 (7.185.36.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 3 Apr
 2023 09:24:20 +0800
Message-ID: <dc0625d2-edaf-22fe-5eea-3088e95a2998@huawei.com>
Date:   Mon, 3 Apr 2023 09:24:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH] x86: profiling: Using generic unwinding in profile_pc
To:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>
References: <20230224021858.120078-1-chenzhongjin@huawei.com>
Content-Language: en-US
From:   Chen Zhongjin <chenzhongjin@huawei.com>
In-Reply-To: <20230224021858.120078-1-chenzhongjin@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.108.67]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.7 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just ping... Or has profile code already been obsoleted?

On 2023/2/24 10:18, chenzhongjin wrote:
> Syzbot has been reporting the problem of stack-out-of-bounds in
> profile_pc for a long time:
> https://syzkaller.appspot.com/bug?extid=84fe685c02cd112a2ac3
>
> profile_pc tries to get pc if current regs is inside lock function. For
> !CONFIG_FRAME_POINTER it used a hack way to get the pc from stack, which
> is not work with ORC. It makes profile_pc returns wrong result, and
> frequently triggers KASAN.
>
> This can be fixed by using the unwind_start, it will skip the first
> regs frame and get the caller of lock function directly, or 0 if
> unwind_get_return_address finds the unwinding failed. For all of FP, ORC
> and guess unwinders it works.
>
> Fixes: 0cb91a229364 ("[PATCH] i386: Account spinlocks to the caller during profiling for !FP kernels")
> Reported-by: syzbot+84fe685c02cd112a2ac3@syzkaller.appspotmail.com
> Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
> ---
>   arch/x86/kernel/time.c | 20 ++++++--------------
>   1 file changed, 6 insertions(+), 14 deletions(-)
>
> diff --git a/arch/x86/kernel/time.c b/arch/x86/kernel/time.c
> index e42faa792c07..5e0446f49906 100644
> --- a/arch/x86/kernel/time.c
> +++ b/arch/x86/kernel/time.c
> @@ -24,26 +24,18 @@
>   #include <asm/timer.h>
>   #include <asm/hpet.h>
>   #include <asm/time.h>
> +#include <asm/unwind.h>
>   
>   unsigned long profile_pc(struct pt_regs *regs)
>   {
>   	unsigned long pc = instruction_pointer(regs);
>   
>   	if (!user_mode(regs) && in_lock_functions(pc)) {
> -#ifdef CONFIG_FRAME_POINTER
> -		return *(unsigned long *)(regs->bp + sizeof(long));
> -#else
> -		unsigned long *sp = (unsigned long *)regs->sp;
> -		/*
> -		 * Return address is either directly at stack pointer
> -		 * or above a saved flags. Eflags has bits 22-31 zero,
> -		 * kernel addresses don't.
> -		 */
> -		if (sp[0] >> 22)
> -			return sp[0];
> -		if (sp[1] >> 22)
> -			return sp[1];
> -#endif
> +		struct unwind_state state;
> +
> +		/* unwind_start will skip the first regs frame */
> +		unwind_start(&state, current, regs, NULL);
> +		pc = unwind_get_return_address(&state);
>   	}
>   	return pc;
>   }
