Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD736B2BD6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 18:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjCIRRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 12:17:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjCIRRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 12:17:18 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BADC7F2C20
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 09:15:13 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1127)
        id AF4A420C14D5; Thu,  9 Mar 2023 09:14:53 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AF4A420C14D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1678382093;
        bh=PJPf60vJHMF4gyqBZ1PedTw6bWcpI09LZjNAyGiWI1U=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=QEvp1fL+uKekqEczVg5cX16Q4+EHFchluVgEOYxksZYcnW8RjaGdwXR1Lz4QrTGkg
         wTguItlCCHYuJnzrZuj3G19u0O54B6qSpzoE5lhzP/cmCKR4C2HSEmg0pwlapQ9+jb
         muDYc7bb0WNv4YI9O2VPwuTIOIsOyNC9RYOcU4oI=
Date:   Thu, 9 Mar 2023 09:14:53 -0800
From:   Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        johan+linaro@kernel.org, isaku.yamahata@intel.com,
        mikelley@microsoft.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/ioapic: Don't return 0 as valid virq
Message-ID: <20230309171453.GA5800@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1677785686-2152-1-git-send-email-ssengar@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1677785686-2152-1-git-send-email-ssengar@linux.microsoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2023 at 11:34:46AM -0800, Saurabh Sengar wrote:
> Zero is invalid virq and should't be returned as a valid value for
> lower irq bound. If IO-APIC and gsi_top are not initialized return
> the 'from' value as virq.
> 
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
>  arch/x86/kernel/apic/io_apic.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
> index a868b76cd3d4..000cc6159b8b 100644
> --- a/arch/x86/kernel/apic/io_apic.c
> +++ b/arch/x86/kernel/apic/io_apic.c
> @@ -2483,9 +2483,11 @@ unsigned int arch_dynirq_lower_bound(unsigned int from)
>  	/*
>  	 * dmar_alloc_hwirq() may be called before setup_IO_APIC(), so use
>  	 * gsi_top if ioapic_dynirq_base hasn't been initialized yet.
> +	 *
> +	 * Incase gsi_top is also not initialized return @from.
>  	 */
>  	if (!ioapic_initialized)
> -		return gsi_top;
> +		return gsi_top ? : from;
>  	/*
>  	 * For DT enabled machines ioapic_dynirq_base is irrelevant and not
>  	 * updated. So simply return @from if ioapic_dynirq_base == 0.
> -- 
> 2.34.1

Hi Maintainers,

May I get your feedback on this patch.

Regards,
Saurabh
