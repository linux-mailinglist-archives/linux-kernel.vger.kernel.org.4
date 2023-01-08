Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4CDE661902
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 21:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233544AbjAHUEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 15:04:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233319AbjAHUEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 15:04:16 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5D52D30F
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 12:04:15 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 8927792009C; Sun,  8 Jan 2023 21:04:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 7BF1A92009B;
        Sun,  8 Jan 2023 20:04:14 +0000 (GMT)
Date:   Sun, 8 Jan 2023 20:04:14 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Borislav Petkov <bp@alien8.de>
cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] x86: Disable kernel stack offset randomization for
 !TSC
In-Reply-To: <Y7sfdxJ5/2DSQK/l@zn.tnic>
Message-ID: <alpine.DEB.2.21.2301082001540.65308@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2301081919550.65308@angie.orcam.me.uk> <Y7sfdxJ5/2DSQK/l@zn.tnic>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Jan 2023, Borislav Petkov wrote:

> > For x86 kernel stack offset randomization uses the RDTSC instruction, 
> > which causes an invalid opcode exception with hardware that does not 
> > implement this instruction:
> 
> Out of pure curiosity, what hw is that?

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 4
model		: 3
model name	: 486 DX/2
stepping	: 5
fdiv_bug	: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme cpuid
bugs		: itlb_multihit
bogomips	: 32.35
clflush size	: 32
cache_alignment	: 32
address sizes	: 32 bits physical, 32 bits virtual
power management:

> Also, I guess the fix should be something like this instead:
> 
> ---
> diff --git a/arch/x86/include/asm/entry-common.h b/arch/x86/include/asm/entry-common.h
> index 117903881fe4..57b372ca6ce7 100644
> --- a/arch/x86/include/asm/entry-common.h
> +++ b/arch/x86/include/asm/entry-common.h
> @@ -85,7 +85,8 @@ static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
>  	 * Therefore, final stack offset entropy will be 5 (x86_64) or
>  	 * 6 (ia32) bits.
>  	 */
> -	choose_random_kstack_offset(rdtsc() & 0xFF);
> +	if (cpu_feature_enabled(X86_FEATURE_TSC))
> +		choose_random_kstack_offset(rdtsc() & 0xFF);

 I'll check if that works, thanks for the suggestion.

  Maciej
