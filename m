Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA6C720646
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 17:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236707AbjFBPee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 11:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235809AbjFBPe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 11:34:29 -0400
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D9318D;
        Fri,  2 Jun 2023 08:34:26 -0700 (PDT)
Received: from [192.168.178.25] (host-212-18-30-247.customer.m-online.net [212.18.30.247])
        (Authenticated sender: wse@tuxedocomputers.com)
        by mail.tuxedocomputers.com (Postfix) with ESMTPSA id E24EA2FC00B8;
        Fri,  2 Jun 2023 17:34:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
        s=default; t=1685720065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DMw4aBwZvd76/Th6Lg3FoMKLs9BCdBhFxrm3snd6MOY=;
        b=rpooj18oiiKFoE+4g/NNuAPMHYO/itiIZ0+6FdM7pIM+2oLC5ILM410mDuWC1qOv1R8oPC
        YrzeRRRLvC2Y9b5iYzWHGySXdbWthGK67oH/Wvev4k4nS6elLTdL2akDauejueecY8N8GQ
        M8shkSGPcaQOpZplCQnlMh2WUZzvIAU=
Authentication-Results: mail.tuxedocomputers.com;
        auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <c801e9ba-0169-606f-1122-e1c2691c8ee3@tuxedocomputers.com>
Date:   Fri, 2 Jun 2023 17:34:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3] ACPI: resource: Remove "Zen" specific match and quirks
To:     Mario Limonciello <mario.limonciello@amd.com>,
        linux-acpi@vger.kernel.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, ofenfisch@googlemail.com,
        adam.niederer@gmail.com, adrian@freund.io, jirislaby@kernel.org,
        Renjith.Pananchikkal@amd.com, anson.tsao@amd.com,
        Richard.Gong@amd.com, Chuanhong Guo <gch981213@gmail.com>,
        evilsnoo@proton.me, ruinairas1992@gmail.com, nmschulte@gmail.com
References: <20230601221151.670-1-mario.limonciello@amd.com>
Content-Language: en-US
From:   Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <20230601221151.670-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Works for TongFang GMxRGxx/XMG CORE 15 (M22)/TUXEDO Stellaris 15 Gen4 AMD

Tested-by: Werner Sembach <wse@tuxedocomputers.com>

Am 02.06.23 um 00:11 schrieb Mario Limonciello:
> commit 9946e39fe8d0 ("ACPI: resource: skip IRQ override on
> AMD Zen platforms") attempted to overhaul the override logic so it
> didn't apply on X86 AMD Zen systems.  This was intentional so that
> systems would prefer DSDT values instead of default MADT value for
> IRQ 1 on Ryzen 6000 systems which typically uses ActiveLow for IRQ1.
>
> This turned out to be a bad assumption because several vendors
> add Interrupt Source Override but don't fix the DSDT. A pile of
> quirks was collecting that proved this wasn't sustaintable.
>
> Furthermore some vendors have used ActiveHigh for IRQ1.
> To solve this problem revert the following commits:
> * commit 17bb7046e7ce ("ACPI: resource: Do IRQ override on all TongFang
> GMxRGxx")
> * commit f3cb9b740869 ("ACPI: resource: do IRQ override on Lenovo 14ALC7")
> * commit bfcdf58380b1 ("ACPI: resource: do IRQ override on LENOVO IdeaPad")
> * commit 7592b79ba4a9 ("ACPI: resource: do IRQ override on XMG Core 15")
> * commit 9946e39fe8d0 ("ACPI: resource: skip IRQ override on AMD Zen
> platforms")
>
> Cc: ofenfisch@googlemail.com
> Cc: wse@tuxedocomputers.com
> Cc: adam.niederer@gmail.com
> Cc: adrian@freund.io
> Cc: jirislaby@kernel.org
> Cc: Renjith.Pananchikkal@amd.com
> Cc: anson.tsao@amd.com
> Cc: Richard.Gong@amd.com
> Cc: Chuanhong Guo <gch981213@gmail.com>
> Reported-by: evilsnoo@proton.me
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217394
> Reported-by: ruinairas1992@gmail.com
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217406
> Reported-by: nmschulte@gmail.com
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217336
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v2->v3:
>   * Adjust to drop heuristics entirely
>   * Drop tested tags
>   * Add more links and people to Cc
>   * Drop Fixes tag as this got a lot more risky
> v1->v2:
>   * Rebase on 71a485624c4c ("ACPI: resource: Add IRQ override quirk for LG UltraPC 17U70P")
>   * Pick up tag
>
> Rafael,
> Please hold off on picking this up until the majority of those on CC
> have tested it on hardware they have and reported results.
>
> Everyone else,
> Please test. If you have problems with this applied, please share
> an acpidump and dmesg either on a bug or to me privately.
> ---
>   drivers/acpi/resource.c | 60 -----------------------------------------
>   1 file changed, 60 deletions(-)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index 0800a9d77558..1dd8d5aebf67 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -470,52 +470,6 @@ static const struct dmi_system_id asus_laptop[] = {
>   	{ }
>   };
>   
> -static const struct dmi_system_id lenovo_laptop[] = {
> -	{
> -		.ident = "LENOVO IdeaPad Flex 5 14ALC7",
> -		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "82R9"),
> -		},
> -	},
> -	{
> -		.ident = "LENOVO IdeaPad Flex 5 16ALC7",
> -		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "82RA"),
> -		},
> -	},
> -	{ }
> -};
> -
> -static const struct dmi_system_id tongfang_gm_rg[] = {
> -	{
> -		.ident = "TongFang GMxRGxx/XMG CORE 15 (M22)/TUXEDO Stellaris 15 Gen4 AMD",
> -		.matches = {
> -			DMI_MATCH(DMI_BOARD_NAME, "GMxRGxx"),
> -		},
> -	},
> -	{ }
> -};
> -
> -static const struct dmi_system_id maingear_laptop[] = {
> -	{
> -		.ident = "MAINGEAR Vector Pro 2 15",
> -		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Micro Electronics Inc"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "MG-VCP2-15A3070T"),
> -		}
> -	},
> -	{
> -		.ident = "MAINGEAR Vector Pro 2 17",
> -		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Micro Electronics Inc"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "MG-VCP2-17A3070T"),
> -		},
> -	},
> -	{ }
> -};
> -
>   static const struct dmi_system_id lg_laptop[] = {
>   	{
>   		.ident = "LG Electronics 17U70P",
> @@ -539,10 +493,6 @@ struct irq_override_cmp {
>   static const struct irq_override_cmp override_table[] = {
>   	{ medion_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
>   	{ asus_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
> -	{ lenovo_laptop, 6, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, true },
> -	{ lenovo_laptop, 10, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, true },
> -	{ tongfang_gm_rg, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
> -	{ maingear_laptop, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
>   	{ lg_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
>   };
>   
> @@ -562,16 +512,6 @@ static bool acpi_dev_irq_override(u32 gsi, u8 triggering, u8 polarity,
>   			return entry->override;
>   	}
>   
> -#ifdef CONFIG_X86
> -	/*
> -	 * IRQ override isn't needed on modern AMD Zen systems and
> -	 * this override breaks active low IRQs on AMD Ryzen 6000 and
> -	 * newer systems. Skip it.
> -	 */
> -	if (boot_cpu_has(X86_FEATURE_ZEN))
> -		return false;
> -#endif
> -
>   	return true;
>   }
>   
