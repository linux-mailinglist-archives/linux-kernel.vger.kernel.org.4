Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4B470E460
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 20:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235976AbjEWSK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 14:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjEWSK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 14:10:27 -0400
X-Greylist: delayed 600 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 23 May 2023 11:10:24 PDT
Received: from debian-mailserver.fidu.org (static.7.84.90.157.clients.your-server.de [157.90.84.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC52697;
        Tue, 23 May 2023 11:10:24 -0700 (PDT)
Received: from [192.168.178.25] (unknown [24.134.105.141])
        (Authenticated sender: wse@tuxedocomputers.com)
        by debian-mailserver.fidu.org (Postfix) with ESMTPSA id B957C2FC00F7;
        Tue, 23 May 2023 19:52:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
        s=default; t=1684864378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7Zq5G7Pc/40n5rmr+flZjkj7BiqB0EBVaCzcpRsZzC8=;
        b=Viq1uFkW3FRY14Yx3guOCjrL23ts9YFeaa04kFJ0yhRmCE3bMOEbZqC7mh6GYIPOAgjsdi
        D1EAZ3Z6RLWTKgwA3c96MAmsOCdG9v7yI2ukcjeYzE5lKfg4cVTkBDRrbwLrqymFW0tNda
        iB7bauApxX2CZV1imu+eIuvfM/annns=
Authentication-Results: debian-mailserver.fidu.org;
        auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <ca1f3eeb-76b5-d80f-e12f-94890922fdd6@tuxedocomputers.com>
Date:   Tue, 23 May 2023 19:52:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] ACPI: resource: Remove "Zen" specific match and quirks
To:     Mario Limonciello <mario.limonciello@amd.com>, rafael@kernel.org
Cc:     gch981213@gmail.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, regressions@leemhuis.info,
        ofenfisch@googlemail.com, adam.niederer@gmail.com,
        adrian@freund.io, jirislaby@kernel.org,
        Renjith.Pananchikkal@amd.com, anson.tsao@amd.com,
        Richard.Gong@amd.com, evilsnoo@proton.me, ruinairas1992@gmail.com
References: <20230518183920.93472-1-mario.limonciello@amd.com>
Content-Language: en-US
From:   Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <20230518183920.93472-1-mario.limonciello@amd.com>
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

Hi,

Am 18.05.23 um 20:39 schrieb Mario Limonciello:
> commit 9946e39fe8d0 ("ACPI: resource: skip IRQ override on
> AMD Zen platforms") attempted to overhaul the override logic so it
> didn't apply on X86 AMD Zen systems.  This was intentional so that
> systems would prefer DSDT values instead of default MADT value for
> IRQ 1 on Ryzen 6000 systems which use ActiveLow for IRQ1.
>
> This turned out to be a bad assumption because several vendors seem
> to add Interrupt Source Override but don't fix the DSDT. A pile of
> quirks was collecting that proved this wasn't sustaintable.
>
> Adjust the logic so that only IRQ1 is overridden in Ryzen 6000 case.
>
> This effectively reverts the following commits:
> commit 17bb7046e7ce ("ACPI: resource: Do IRQ override on all TongFang
> GMxRGxx")
> commit f3cb9b740869 ("ACPI: resource: do IRQ override on Lenovo 14ALC7")
> commit bfcdf58380b1 ("ACPI: resource: do IRQ override on LENOVO IdeaPad")
> commit 7592b79ba4a9 ("ACPI: resource: do IRQ override on XMG Core 15")

The TongFang GMxRGxx/XMG CORE 15 (M22)/TUXEDO Stellaris 15 Gen4 AMD breaks again with this patch (applied to 6.4-rc3). Am I missing an additional patch that is required?

>
> Cc: ofenfisch@googlemail.com
> Cc: wse@tuxedocomputers.com
> Cc: adam.niederer@gmail.com
> Cc: adrian@freund.io
> Cc: jirislaby@kernel.org
> Tested-by: Renjith.Pananchikkal@amd.com
> Tested-by: anson.tsao@amd.com
> Tested-by: Richard.Gong@amd.com
> Tested-by: Chuanhong Guo <gch981213@gmail.com>
> Reported-by: evilsnoo@proton.me
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217394
> Reported-by: ruinairas1992@gmail.com
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217406
> Fixes: 9946e39fe8d0 ("ACPI: resource: skip IRQ override on AMD Zen platforms")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v1->v2:
>   * Rebase on 71a485624c4c ("ACPI: resource: Add IRQ override quirk for LG UltraPC 17U70P")
>   * Pick up tag
> ---
>   drivers/acpi/resource.c | 154 +++++++++++++++++-----------------------
>   1 file changed, 65 insertions(+), 89 deletions(-)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index 0800a9d77558..c6ac87e01e1c 100644
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
> @@ -527,7 +481,7 @@ static const struct dmi_system_id lg_laptop[] = {
>   	{ }
>   };
>   
> -struct irq_override_cmp {
> +struct irq_override_dmi_cmp {
>   	const struct dmi_system_id *system;
>   	unsigned char irq;
>   	unsigned char triggering;
> @@ -536,50 +490,86 @@ struct irq_override_cmp {
>   	bool override;
>   };
>   
> -static const struct irq_override_cmp override_table[] = {
> +struct irq_override_acpi_cmp {
> +	const char *id;
> +	unsigned char irq;
> +	unsigned char triggering;
> +	unsigned char polarity;
> +};
> +
> +static const struct irq_override_dmi_cmp dmi_override_table[] = {
>   	{ medion_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
>   	{ asus_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
> -	{ lenovo_laptop, 6, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, true },
> -	{ lenovo_laptop, 10, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, true },
> -	{ tongfang_gm_rg, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
> -	{ maingear_laptop, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
>   	{ lg_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
>   };
>   
> -static bool acpi_dev_irq_override(u32 gsi, u8 triggering, u8 polarity,
> -				  u8 shareable)
> +/*
> + * Ryzen 6000 requires ActiveLow for keyboard, but a number of machines
> + * seem to get it wrong in DSDT or don't have an Interrupt Source
> + * Override.
> + */
> +static const struct irq_override_acpi_cmp acpi_override_table[] = {
> +	{ "AMDI0007", 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW },
> +};
> +
> +static void acpi_dev_irq_override(u32 gsi, u8 *triggering, u8 *polarity,
> +				  u8 *shareable)
>   {
> -	int i;
> +	int i, p, t;
> +	int check_override = true;
>   
> -	for (i = 0; i < ARRAY_SIZE(override_table); i++) {
> -		const struct irq_override_cmp *entry = &override_table[i];
> +	for (i = 0; i < ARRAY_SIZE(dmi_override_table); i++) {
> +		const struct irq_override_dmi_cmp *entry = &dmi_override_table[i];
>   
>   		if (dmi_check_system(entry->system) &&
>   		    entry->irq == gsi &&
> -		    entry->triggering == triggering &&
> -		    entry->polarity == polarity &&
> -		    entry->shareable == shareable)
> -			return entry->override;
> +		    entry->triggering == *triggering &&
> +		    entry->polarity == *polarity &&
> +		    entry->shareable == *shareable)
> +			check_override = entry->override;
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
> +	if (!check_override)
> +		return;
>   
> -	return true;
> +	if (!acpi_get_override_irq(gsi, &t, &p)) {
> +		u8 trig = t ? ACPI_LEVEL_SENSITIVE : ACPI_EDGE_SENSITIVE;
> +		u8 pol = p ? ACPI_ACTIVE_LOW : ACPI_ACTIVE_HIGH;
> +
> +		if (*triggering != trig || *polarity != pol) {
> +			pr_warn("ACPI: IRQ %d override to %s%s, %s%s\n", gsi,
> +				t ? "level" : "edge",
> +				trig == *triggering ? "" : "(!)",
> +				p ? "low" : "high",
> +				pol == *polarity ? "" : "(!)");
> +			*triggering = trig;
> +			*polarity = pol;
> +		}
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(acpi_override_table); i++) {
> +		const struct irq_override_acpi_cmp *entry = &acpi_override_table[i];
> +
> +		if (acpi_dev_found(entry->id) && gsi == entry->irq &&
> +		   (*polarity != entry->polarity || *triggering != entry->triggering)) {
> +			pr_warn("ACPI: IRQ %d override to %s%s, %s%s due to %s\n",
> +				gsi,
> +				entry->triggering ? "level" : "edge",
> +				entry->triggering == *triggering ? "" : "(!)",
> +				entry->polarity ? "low" : "high",
> +				entry->polarity == *polarity ? "" : "(!)",
> +				entry->id);
> +			*polarity = entry->polarity;
> +			*triggering = entry->triggering;
> +		}
> +	}
>   }
>   
>   static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
>   				     u8 triggering, u8 polarity, u8 shareable,
>   				     u8 wake_capable, bool check_override)
>   {
> -	int irq, p, t;
> +	int irq;
>   
>   	if (!valid_IRQ(gsi)) {
>   		irqresource_disabled(res, gsi);
> @@ -592,26 +582,12 @@ static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
>   	 * 2. BIOS uses IO-APIC mode Interrupt Source Override
>   	 *
>   	 * We do this only if we are dealing with IRQ() or IRQNoFlags()
> -	 * resource (the legacy ISA resources). With modern ACPI 5 devices
> +	 * resource (the legacy ISA resources). With ACPI devices
>   	 * using extended IRQ descriptors we take the IRQ configuration
>   	 * from _CRS directly.
>   	 */
> -	if (check_override &&
> -	    acpi_dev_irq_override(gsi, triggering, polarity, shareable) &&
> -	    !acpi_get_override_irq(gsi, &t, &p)) {
> -		u8 trig = t ? ACPI_LEVEL_SENSITIVE : ACPI_EDGE_SENSITIVE;
> -		u8 pol = p ? ACPI_ACTIVE_LOW : ACPI_ACTIVE_HIGH;
> -
> -		if (triggering != trig || polarity != pol) {
> -			pr_warn("ACPI: IRQ %d override to %s%s, %s%s\n", gsi,
> -				t ? "level" : "edge",
> -				trig == triggering ? "" : "(!)",
> -				p ? "low" : "high",
> -				pol == polarity ? "" : "(!)");
> -			triggering = trig;
> -			polarity = pol;
> -		}
> -	}
> +	if (check_override)
> +		acpi_dev_irq_override(gsi, &triggering, &polarity, &shareable);
>   
>   	res->flags = acpi_dev_irq_flags(triggering, polarity, shareable, wake_capable);
>   	irq = acpi_register_gsi(NULL, gsi, triggering, polarity);
>
> base-commit: c554eee18c9a440bd2dd5a363b0f79325717f0bf
