Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17A0725DEB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 14:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239169AbjFGMBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 08:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234132AbjFGMBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 08:01:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1EA6184
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 05:01:48 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686139306;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YJJk4TXDby3/H2FkL9O8SbY7aXPkF4xS/ijxCWeHZYc=;
        b=23keO+gIRuQkoGVs9Dp5mBh6FeswvanyDB7toCFGQnW6TRrIf2g0hPzvIZBb/Xr21wksHl
        2q8Bf8f/KXURT/wd07PIzDGL92HfwFEJZ9btPmglwazZlFPqyfhRDdql8y5nzWObg715yp
        TWnxPmpbuXtd5OG5FWZ3YIhEjgnEfP6Ui8Y0ObDgznfKkMy1mcTM0tNu5rMz7QS7EWzC61
        l4nwgzOEBM6mM2vzqQE4119ZQSc/6B7ezrcNOPSM2yC3UHTREV8CHeB7+WFmlc42hHkbJC
        kmx0s88RiM29ZJP9EaRztLSHvj9VR5+zAr+Lg7bafkadzHwFq8cxrqOhDkcmzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686139306;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YJJk4TXDby3/H2FkL9O8SbY7aXPkF4xS/ijxCWeHZYc=;
        b=EP/aQEgTp5HXh14nWxMjHN3HJWL/EJ1oDWmG85+Yfbi2vbTRv+cIBsVeMZkLHHRArnW4Up
        ftlMFLDwzduyrCCQ==
To:     Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, mhocko@suse.com, jslaby@suse.cz,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [PATCH 3/3] x86: Disable running 32bit processes if
 ia32_disabled is passed
In-Reply-To: <20230607072936.3766231-4-nik.borisov@suse.com>
References: <20230607072936.3766231-1-nik.borisov@suse.com>
 <20230607072936.3766231-4-nik.borisov@suse.com>
Date:   Wed, 07 Jun 2023 14:01:46 +0200
Message-ID: <87legvjxat.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07 2023 at 10:29, Nikolay Borisov wrote:
> In addition to disabling 32bit syscall interface let's also disable the
> ability to run 32bit processes altogether. This is achieved by setting
> the GDT_ENTRY_DEFAULT_USER32_CS descriptor to not present which would
> cause 32 bit processes to trap with a #NP exception. Furthermore,
> forbid loading compat processes as well.

This is obviously the wrong order of things. Prevent loading of compat
processes is the first step, no?

>  
> +extern bool ia32_disabled;
>  #define compat_elf_check_arch(x)					\

So in patch 1 you add the declaration with #ifdef guards and now you add
another one without. Fortunately this is the last patch otherwise we'd
might end up with another incarnation in the next header file.

> -	(elf_check_arch_ia32(x) ||					\
> -	 (IS_ENABLED(CONFIG_X86_X32_ABI) && (x)->e_machine == EM_X86_64))
> +	(!ia32_disabled && (elf_check_arch_ia32(x) ||			\
> +	 (IS_ENABLED(CONFIG_X86_X32_ABI) && (x)->e_machine == EM_X86_64)))

If I'm reading this correctly then ia32_disabled also prevents binaries
with X32 ABI to be loaded.

That might be intentional but I'm failing to find any explanation for
this in the changelog.

X32_ABI != IA32_EMULATION

>  static inline void elf_common_init(struct thread_struct *t,
>  				   struct pt_regs *regs, const u16 ds)
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 71f8b55f70c9..ddc301c09419 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -2359,6 +2359,11 @@ void microcode_check(struct cpuinfo_x86 *prev_info)
>  }
>  #endif
>  
> +static void remove_user32cs_from_gdt(void * __unused)
> +{
> +	get_current_gdt_rw()[GDT_ENTRY_DEFAULT_USER32_CS].p = 0;
> +}
> +
>  /*
>   * Invoked from core CPU hotplug code after hotplug operations
>   */
> @@ -2368,4 +2373,7 @@ void arch_smt_update(void)
>  	cpu_bugs_smt_update();
>  	/* Check whether IPI broadcasting can be enabled */
>  	apic_smt_update();
> +	if (ia32_disabled)
> +		on_each_cpu(remove_user32cs_from_gdt, NULL, 1);
> +
>  }

This issues a SMP function call on all online CPUs to set these entries
to 0 on _every_ CPU hotplug operation.

I'm sure there is a reason why these bits need to be cleared over and
over. It's just not obvious to me why clearing them _ONCE_ per boot is
not sufficient. It's neither clear to me why CPU0 must do that ($NCPUS -
1) times, but for the last CPU it's enough to do it once.

That aside, what's the justification for doing this in the first place
and why is this again inconsistent vs. CONFIG_IA32_EMULATION=n?

The changelog is full of void in that aspect.

Thanks,

        tglx
        
