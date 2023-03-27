Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED316CAF4A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 21:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjC0T5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 15:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjC0T5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 15:57:44 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16F8198E;
        Mon, 27 Mar 2023 12:57:42 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5E4B01EC047F;
        Mon, 27 Mar 2023 21:57:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1679947061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l5gnOX5yVQXR2M15js5dRRfm8Zhhkb+3IthyvLKln3Y=;
        b=UrheBNULRgx34INuvS0YaF9yD0WVcu6RyJhPmEfpyQ5T7pGP4pXXRHA0X6ln/4SSn6aet5
        VZq7I82peWEHQu4Vv/GRB0H+pf1hpIqW6shFMsi8biyWdN3juhHuiRAg2RiUtojtq1k9P7
        EJo3lFmRJz/StzOEJDgKW4Y5pnbZS78=
Date:   Mon, 27 Mar 2023 21:57:37 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Eric DeVolder <eric.devolder@oracle.com>, mario.limonciello@amd.com
Cc:     rafael@kernel.org, lenb@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvijayab@amd.com,
        miguel.luis@oracle.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH 1/1] x86/acpi: acpi_is_processor_usable() dropping
 possible cpus
Message-ID: <20230327195737.GDZCH1MWNvFQrXdY9M@fat_crate.local>
References: <20230327191026.3454-1-eric.devolder@oracle.com>
 <20230327191026.3454-2-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230327191026.3454-2-eric.devolder@oracle.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 03:10:26PM -0400, Eric DeVolder wrote:
> The logic in acpi_is_processor_usable() requires the Online Capable
> bit be set for hotpluggable cpus.  The Online Capable bit is
> introduced in ACPI 6.3 and MADT.revision 5.

I can't find where in the spec it says that MADT.revision 5 means that
bit is present?

I'm looking at:

aa06e20f1be6 ("x86/ACPI: Don't add CPUs that are not online capable")

Mario?

I see in the 6.3 spec it says:

"1948 Adds a “Hot-plug Capable” flag to the Local APIC and x2APIC structures in MADT"

and the MADT.revision is 5 and in the 6.2 spec the MADT revision is "45"
- 4.5 maybe?

But I don't see the connection between MADT.revision 5 and the presence
of the online capable bit.

Anyone got a better quote?

> However, as currently coded, for MADT.revision < 5,
> acpi_is_processor_usable() no longer allows for possible hot
> pluggable cpus, which is a regressive change in behavior.
> 
> This patch restores the behavior where for MADT.revision < 5, the

Avoid having "This patch" or "This commit" in the commit message. It is
tautologically useless.

Also, do

$ git grep 'This patch' Documentation/process

for more details.

> presence of the lapic/x2apic structure implies a possible hotpluggable
> cpu.
> 
> Fixes: e2869bd7af60 ("x86/acpi/boot: Do not register processors that cannot be onlined for x2APIC")
> Suggested-by: Miguel Luis <miguel.luis@oracle.com>
> Suggested-by: Boris Ostrovsky <boris.ovstrosky@oracle.com>
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> ---
>  arch/x86/kernel/acpi/boot.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> index 1c38174b5f01..7b5b8ed018b0 100644
> --- a/arch/x86/kernel/acpi/boot.c
> +++ b/arch/x86/kernel/acpi/boot.c
> @@ -193,7 +193,13 @@ static bool __init acpi_is_processor_usable(u32 lapic_flags)
>  	if (lapic_flags & ACPI_MADT_ENABLED)
>  		return true;
>  
> -	if (acpi_support_online_capable && (lapic_flags & ACPI_MADT_ONLINE_CAPABLE))
> +	/*
> +	 * Prior to MADT.revision 5, the presence of the Local x2/APIC
> +	 * structure _implicitly_ noted a possible hotpluggable cpu.
> +	 * Starting with MADT.revision 5, the Online Capable bit
> +	 * _explicitly_ indicates a hotpluggable cpu.
> +	 */

In all your text

s/cpu/CPU/g

> +	if (!acpi_support_online_capable || (lapic_flags & ACPI_MADT_ONLINE_CAPABLE))
>  		return true;
>  
>  	return false;
> -- 

Otherwise, the change makes sense to me.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
