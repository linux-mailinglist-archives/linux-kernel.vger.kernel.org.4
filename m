Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A316DD26F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 08:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjDKGJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 02:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjDKGJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 02:09:53 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8FDB01704
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 23:09:46 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1127)
        id 1A4912174E4C; Mon, 10 Apr 2023 23:09:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1A4912174E4C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1681193386;
        bh=0vqxaTyHjkm2ePh3n+RG3jF8MQwkysGYAZtESJuLKW0=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=IYcIbOqOFJ3n70KmQHreJKEVQjeBtnDRM+Ut8PHLIDfEfK/JBBgATGZf1gIlngrf9
         LfTjWnEDEbQTmTJUlZD295SHeYlmo6rSg9WtzHOcukIhiRgd1iTxn6Vw37QDojcvAW
         j7yRS9WLoHpBcp8ZUed9ogdZYXe+LMAfMwtlRhLM=
Date:   Mon, 10 Apr 2023 23:09:46 -0700
From:   Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        johan+linaro@kernel.org, isaku.yamahata@intel.com,
        mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        andriy.shevchenko@intel.com
Subject: Re: [PATCH v2] x86/ioapic: Don't return 0 from
 arch_dynirq_lower_bound()
Message-ID: <20230411060946.GA17134@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1679988604-20308-1-git-send-email-ssengar@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1679988604-20308-1-git-send-email-ssengar@linux.microsoft.com>
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

On Tue, Mar 28, 2023 at 12:30:04AM -0700, Saurabh Sengar wrote:
> arch_dynirq_lower_bound() is invoked by the core interrupt code to
> retrieve the lowest possible Linux interrupt number for dynamically
> allocated interrupts like MSI.
> 
> The x86 implementation uses this to exclude the IO/APIC GSI space.
> This works correctly as long as there is an IO/APIC registered, but
> returns 0 if not. This has been observed in VMs where the BIOS does
> not advertise an IO/APIC.
> 
> 0 is an invalid interrupt number except for the legacy timer interrupt
> on x86. The return value is unchecked in the core code, so it ends up
> to allocate interrupt number 0 which is subsequently considered to be
> invalid by the caller, e.g. the MSI allocation code.
> 
> The function has already a check for 0 in the case that an IO/APIC is
> registered, but ioapic_dynirq_base is 0 in case of device tree setups.
> 
> Consolidate this and zero check for both ioapic_dynirq_base and gsi_top,
> which is used in the case that no IO/APIC is registered.
> 
> Fixes: 3e5bedc2c258 ("x86/apic: Fix arch_dynirq_lower_bound() bug for DT enabled machines")
> Co-developed-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---
> [V2]
> - Edit commit message
> - Consolidated the 0 check for ioapic_dynirq_base as well
> 
>  arch/x86/kernel/apic/io_apic.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
> index 1f83b052bb74..f980b38b0227 100644
> --- a/arch/x86/kernel/apic/io_apic.c
> +++ b/arch/x86/kernel/apic/io_apic.c
> @@ -2477,17 +2477,21 @@ static int io_apic_get_redir_entries(int ioapic)
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
> +	 * 0 is an invalid interrupt number for dynamic allocations. Return
> +	 * @from instead.
>  	 */
> -	return ioapic_dynirq_base ? : from;
> +	return ret ? : from;
>  }
>  
>  #ifdef CONFIG_X86_32

Is this good to get accepted ? Please let me know if anything pending from my end on this.

- Saurabh

> -- 
> 2.34.1
