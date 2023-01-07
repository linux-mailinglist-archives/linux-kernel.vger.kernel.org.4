Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46D7660BC8
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 03:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236595AbjAGCK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 21:10:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbjAGCKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 21:10:23 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E5287F20
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 18:10:20 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NpkCH3kZQzRqvs;
        Sat,  7 Jan 2023 10:08:43 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sat, 7 Jan 2023 10:10:18 +0800
Subject: Re: [BUG Report] undefined reference to `convert_to_fxsr'
To:     Borislav Petkov <bp@alien8.de>
CC:     "x86@kernel.org" <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, <hpa@zytor.com>
References: <50aa72a7-043d-8091-78de-458cbcc6c356@huawei.com>
 <Y6w49Y1d3lpv3KFn@zn.tnic> <23e2907c-5188-5ac6-3db8-1c5a12120bf2@huawei.com>
 <Y62vbjBzHF4rmh1V@zn.tnic> <e041533c-4005-b9bc-3985-02224985aa28@huawei.com>
 <Y67IlthBqaX69RwN@zn.tnic> <64fe1be4-954f-fe6f-44f0-59b572548663@huawei.com>
 <Y7dZwWsiUfHKxN3S@zn.tnic>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <d312c572-f232-a4e9-2ecc-023050528a29@huawei.com>
Date:   Sat, 7 Jan 2023 10:10:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <Y7dZwWsiUfHKxN3S@zn.tnic>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/1/6 7:14, Borislav Petkov wrote:
> On Tue, Jan 03, 2023 at 11:05:01AM +0800, Miaohe Lin wrote:
>> Yes, it still reproduces in my working server. It might be the problem of gcc
>> version.
> 
> What is that compiler you're using? Where did you get the package from? Does it
> have some out-of-tree patches in it?

My compiler is gcc 7.3.0:

linux-rtfsc:/home/linmiaohe/linux # gcc --version
gcc (GCC) 7.3.0
Copyright (C) 2017 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

linux-rtfsc:/home/linmiaohe/linux #

And I cloned the code from https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git. It's a
clean git repo without applying any out-of-tree patch to it.

> 
>> I think it's because convert_to_fxsr() is only defined when CONFIG_X86_32 or
>> CONFIG_IA32_EMULATION is enabled.
> 
> No, convert_to_fxsr() is part of arch/x86/kernel/fpu/regset.c which is built-in
> unconditionally.
> 
> What happens is this here:
> 
> bool fpu__restore_sig(void __user *buf, int ia32_frame)
> 
> 	...
> 
>         } else {
>                 success = __fpu_restore_sig(buf, buf_fx, ia32_fxstate);
>         }
> 
> That ia32_fxstate is false because
> 
>         ia32_frame &= (IS_ENABLED(CONFIG_X86_32) ||
>                        IS_ENABLED(CONFIG_IA32_EMULATION));
> 
> 
> neither of those config items are set...
> 
>         /*
>          * Only FXSR enabled systems need the FX state quirk.
>          * FRSTOR does not need it and can use the fast path.
>          */
>         if (ia32_frame && use_fxsr()) {
>                 buf_fx = buf + sizeof(struct fregs_state);
>                 size += sizeof(struct fregs_state);
>                 ia32_fxstate = true;
> 		^^^^^^^^^^^^^^^^^^^
> 
> ... so this doesn't happen.
> 
>         }
> 
> Then, in __fpu_restore_sig() you have:
> 
>         if (likely(!ia32_fxstate)) {
>                 /* Restore the FPU registers directly from user memory. */
>                 return restore_fpregs_from_user(buf_fx, user_xfeatures, fx_only,
>                                                 state_size);
>         }
> 
> and since ia32_fxstate is false, we return here, the compiler sees that
> everything behind that code is dead code and eliminates it.

Many thanks for your explanation! It's really helpful. I checked generated asm code
and I found calling to convert_to_fxsr is not eliminated as expected:

objdump -S arch/x86/kernel/fpu/signal.o

 3fc:   e9 00 00 00 00          jmpq   401 <__fpu_restore_sig+0x401>
                        fpregs->xsave.header.xfeatures |= XFEATURE_MASK_FPSSE;
 401:   48 83 8d 40 02 00 00    orq    $0x3,0x240(%rbp)
 408:   03
        convert_to_fxsr(&fpregs->fxsave, &env);
	^^^^^^^^^^^^^^^
 409:   48 8d 74 24 10          lea    0x10(%rsp),%rsi

linux-rtfsc:/home/linmiaohe/linux # objdump -S arch/x86/kernel/fpu/signal.o | grep convert_to_fxsr
	convert_to_fxsr(&fpregs->fxsave, &env);
linux-rtfsc:/home/linmiaohe/linux #

And if I compile the code with below patch, convert_to_fxsr is eliminated:

linux-rtfsc:/home/linmiaohe/linux # objdump -S arch/x86/kernel/fpu/signal.o | grep convert_to_fxsr
linux-rtfsc:/home/linmiaohe/linux #

diff --git a/arch/x86/include/asm/fpu/signal.h b/arch/x86/include/asm/fpu/signal.h
index 611fa41711af..77ea052a8967 100644
--- a/arch/x86/include/asm/fpu/signal.h
+++ b/arch/x86/include/asm/fpu/signal.h
@@ -20,8 +20,14 @@

 extern void convert_from_fxsr(struct user_i387_ia32_struct *env,
                              struct task_struct *tsk);
+#if defined CONFIG_X86_32 || defined CONFIG_IA32_EMULATION
 extern void convert_to_fxsr(struct fxregs_state *fxsave,
                            const struct user_i387_ia32_struct *env);
+#else
+static inline void convert_to_fxsr(struct fxregs_state *fxsave,
+                                  const struct user_i387_ia32_struct *env)
+{}
+#endif

 unsigned long
 fpu__alloc_mathframe(unsigned long sp, int ia32_frame,
-- 
2.27.0

> 
> Your compiler doesn't, apparently.
> 
> It does remove it from regset.c, though, as it sees it is an unused function,
> which leads to this undefined reference.
> 
> So it looks like a funky compiler to me...

It seems another issue with old compiler. Sigh... :(

Thanks,
Miaohe Lin

