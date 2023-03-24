Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07BBC6C824E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 17:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbjCXQYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 12:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbjCXQYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 12:24:07 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A4A7C16AEA
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 09:24:02 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1127)
        id 1E21220FC3DB; Fri, 24 Mar 2023 09:24:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1E21220FC3DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1679675042;
        bh=yqbHHscSbo1oBlvpxvO5FHULkS3Egh7mMvYUC8+o2Zc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pzu0gpVjITShGg6wI518TWtDrvIpG+eOG+yx6QDuvG27xs99Xjokx6mfd0cq/byoE
         m9Z1YrWu+AbFEn7xWAuTIvUQk2Oh20RTxexuX8NAWTE31UH/7AwNPkAzJcNySoKVL4
         Bh7x+Cn9m7ksKOCgzEbElHDB++KN2HTZDkm6CWvg=
Date:   Fri, 24 Mar 2023 09:24:02 -0700
From:   Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Borislav Petkov <bp@alien8.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "johan+linaro@kernel.org" <johan+linaro@kernel.org>,
        "isaku.yamahata@intel.com" <isaku.yamahata@intel.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rahul.tanwar@linux.intel.com" <rahul.tanwar@linux.intel.com>,
        "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>
Subject: Re: [EXTERNAL] Re: [PATCH] x86/ioapic: Don't return 0 as valid virq
Message-ID: <20230324162402.GA14597@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1677785686-2152-1-git-send-email-ssengar@linux.microsoft.com>
 <20230312204019.GBZA44s28AOAfAcRuy@fat_crate.local>
 <PUZP153MB074987B356FCB28933B87CCBBEB99@PUZP153MB0749.APCP153.PROD.OUTLOOK.COM>
 <20230313111425.GDZA8Fkar9Z9BzSImD@fat_crate.local>
 <PUZP153MB0749FE8554CACEAD2E43C5E2BEBE9@PUZP153MB0749.APCP153.PROD.OUTLOOK.COM>
 <87fs9u6twk.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fs9u6twk.ffs@tglx>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-17.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 04:39:07PM +0100, Thomas Gleixner wrote:
> On Tue, Mar 14 2023 at 10:23, Saurabh Singh Sengar wrote:
> >> This should be added to your commit message: what guest VM is that and
> >> why should the kernel support it.
> >
> > Guest VM is a linux VM running as child partition on Hyper-V. Hyper-v Linux
> > documentation is in Documentation/virt/hyperv/.
> >
> > In commit I wanted to mention that any system which is not registering
> > IO-APIC will have this issue. But I am fine to mention specifically
> > about the issue I am facing.  As part of your next comment, I have
> > explained the issue in detail if that is good, I can put that as
> > commit message.
> >> 
> >> Why doesn't it need an IO-APIC and why does the current code need to be
> >> changed just for your guest VM?
> >
> > For Hyper-V Virtual Machines, few platforms don't have any devices to be
> > hooked to IO-APIC. Although it has Hyper-V based MSI over VMBus which
> > assigns interrupts to PCIe devices. In such platforms IO-APIC is not
> > registered which causes gsi_top value to remain at 0 and not get properly
> > assigned. Moreover, due to the inability to disable CONFIG_X86_IO_APIC
> > flag, the io-apic code still gets compiled. Thus, arch_dynirq_lower_bound
> > function in io_apic.c decides the lower bound of irq numbers based on gsi_top.
> >
> > Later when PCIe-MSI attempts to allocate interrupts, it gets 0 as the first
> > virq number because gsi_top is still 0. 0 being invalid virq is ignored by
> > MSI irq domain and results allocation of the same PCIe MSI twice.
> >
> > 		CPU0		CPU1
> > 0:		2			0		Hyper-V PCIe MSI 1073741824-edge
> > 1:		69			0		Hyper-V PCIe MSI 1073741824-edge      nvme0q0
> >
> > To avoid this issue, if IO-APIC and gsi_top are not initialized, return the
> > hint value passed as 'from' value to arch_dynirq_lower_bound instead of 0.
> > This will also be identical to the behaviour of weak arch_dynirq_lower_bound
> > function defined in kernel/softirq.c.
> 
> I find this mightly confusing. Something like this perhaps:
> 
>   Subject: x86/ioapic: Don't return 0 from arch_dynirq_lower_bound()
> 
>   arch_dynirq_lower_bound() is invoked by the core interrupt code to
>   retrieve the lowest possible Linux interrupt number for dynamically
>   allocated interrupts like MSI.
> 
>   The x86 implementation uses this to exclude the IO/APIC GSI space.
>   This works correctly as long as there is an IO/APIC registered, but
>   returns 0 if not. This has been observed in VMs where the BIOS does
>   not advertise an IO/APIC.  
> 
>   0 is an invalid interrupt number except for the legacy timer interrupt
>   on x86. The return value is unchecked in the core code, so it ends up
>   to allocate interrupt number 0 which is subsequently considered to be
>   invalid by the caller, e.g. the MSI allocation code.
> 
>   The function has already a check for 0 in the case that an IO/APIC is
>   registered, but ioapic_dynirq_base is 0 in case of device tree setups.
> 
>   Consolidate this and zero check for both ioapic_dynirq_base and gsi_top,
>   which is used in the case that no IO/APIC is registered.
> 
> And then make the code to look like the below, which makes it very
> clear what this is about.
> 
> Thanks,
> 
>         tglx
> ---
> --- a/arch/x86/kernel/apic/io_apic.c
> +++ b/arch/x86/kernel/apic/io_apic.c
> @@ -2477,17 +2477,22 @@ static int io_apic_get_redir_entries(int
>  
>  unsigned int arch_dynirq_lower_bound(unsigned int from)
>  {
> +	unsigned int ret;
> +
>  	/*
>  	 * dmar_alloc_hwirq() may be called before setup_IO_APIC(), so use
>  	 * gsi_top if ioapic_dynirq_base hasn't been initialized yet.
>  	 */
> -	if (!ioapic_initialized)
> -		return gsi_top;
> +	ret = ioapic_dynirq_base ? : gsi_top;
> +
>  	/*
> -	 * For DT enabled machines ioapic_dynirq_base is irrelevant and not
> -	 * updated. So simply return @from if ioapic_dynirq_base == 0.
> +	 * For DT enabled machines ioapic_dynirq_base is irrelevant and
> +	 * always 0. gsi_top can be 0 if there is no IO/APIC registered.
> +	 *
> +	 * 0 is an invalid interrupt number for dynamic allocations. Return
> +	 * @from instead.
>  	 */
> -	return ioapic_dynirq_base ? : from;
> +	return ret ? : from;
>  }
>  
>  #ifdef CONFIG_X86_32
>

Thanks you for your valuable suggestions. Commit message and code looks
much better now. I will send the V2 with your "Co-Developed-by" tag, I
hope its fine with you.

Regards,
Saurabh
 
