Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916AC5ED4A8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 08:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbiI1GUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 02:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiI1GUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 02:20:50 -0400
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5306B8E4F1;
        Tue, 27 Sep 2022 23:20:46 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id m4so3797806wrr.5;
        Tue, 27 Sep 2022 23:20:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=shEaMo5orbctUFMK5fzpueKSH5BdWxV9UydPGz0jxeg=;
        b=dnve9R+l5CrhZHzSaaSKN49PFU66chyW0jJaRQ9jK2tGRQ9kUNpwqWtRBZdb/dBQgl
         0KDHVlFL1CrY8cqzt8HDWhlvehXUEERLIVddrl6hLiaZi9dNNxapny4r1T4M1XOQG2VH
         V6UFn7tllEeLtGbufXzZkmO8sHWzcsjXjBMlfxw8Q1vFoEy7Z1ZMgoCsq6X2M2e+rEPm
         lYj+T6suRb8WcNbwQqME/GLk+Cz93hpgtFaWRW0M7gENuk1BTKFq9opKsy4zTV7QYnGY
         o/SpdhL942beyQ1JWRd8MIbbGN7HMOIaVvnZT6l2c8WjMz9CZXwsXGjqS4B/BG+bpNpd
         9TTQ==
X-Gm-Message-State: ACrzQf11jHD8szlsBZxwVasyYpciQoUu0XK6GUnB+wBV2VPoq+hcsMWA
        w3YCfcfyjshGYGsxU6gXAOlHdSoqN/I=
X-Google-Smtp-Source: AMsMyM7OMHDDTym08dnrzI+VycAr6rEoe8+pfB57dO5Ef3jkjjMXXWOCN9CrFx+R9kouvpgOSoijVg==
X-Received: by 2002:adf:d1c2:0:b0:22a:66ad:2669 with SMTP id b2-20020adfd1c2000000b0022a66ad2669mr19392473wrd.468.1664346044753;
        Tue, 27 Sep 2022 23:20:44 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id q16-20020a7bce90000000b003b492b30822sm839530wmj.2.2022.09.27.23.20.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 23:20:44 -0700 (PDT)
Message-ID: <0450c7c0-4787-2aa2-de3e-c71522e467ce@kernel.org>
Date:   Wed, 28 Sep 2022 08:20:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v6] ACPI: skip IRQ override on AMD Zen platforms
Content-Language: en-US
To:     Chuanhong Guo <gch981213@gmail.com>, linux-acpi@vger.kernel.org
Cc:     Tighe Donnelly <tighe.donnelly@protonmail.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220712020058.90374-1-gch981213@gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220712020058.90374-1-gch981213@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12. 07. 22, 4:00, Chuanhong Guo wrote:
> IRQ override isn't needed on modern AMD Zen systems.
> There's an active low keyboard IRQ on AMD Ryzen 6000 and it will stay
> this way on newer platforms. This IRQ override breaks keyboards for
> almost all Ryzen 6000 laptops currently on the market.
> 
> Skip this IRQ override for all AMD Zen platforms because this IRQ
> override is supposed to be a workaround for buggy ACPI DSDT and we can't
> have a long list of all future AMD CPUs/Laptops in the kernel code.
> If a device with buggy ACPI DSDT shows up, a separated list containing
> just them should be created.

This breaks pads on IdeaPad 5 Flex:
https://bugzilla.suse.com/show_bug.cgi?id=1203794

 > [    1.058135] hid-generic 0020:1022:0001.0001: hidraw0: SENSOR HUB 
HID v0.00 Device [hid-amdsfh 1022:0001] on pcie_mp2_amd
 > [    2.038937] i2c_designware AMDI0010:00: controller timed out
 > [    2.146627] i2c_designware AMDI0010:03: controller timed out
 > [    6.166859] i2c_hid_acpi i2c-MSFT0001:00: failed to reset device: -61
 > [    8.279604] i2c_designware AMDI0010:03: controller timed out
 > [   12.310897] i2c_hid_acpi i2c-MSFT0001:00: failed to reset device: -61
 > [   14.429372] i2c_designware AMDI0010:03: controller timed out
 > [   18.462629] i2c_hid_acpi i2c-MSFT0001:00: failed to reset device: -61
 > [   20.579183] i2c_designware AMDI0010:03: controller timed out
 > [   24.598703] i2c_hid_acpi i2c-MSFT0001:00: failed to reset device: -61
 > [   25.629071] i2c_hid_acpi i2c-MSFT0001:00: can't add hid device: -61
 > [   25.629430] i2c_hid_acpi: probe of i2c-MSFT0001:00 failed with 
error -61

The diff of good and bad dmesgs:
-ACPI: IRQ 10 override to edge, high
-ACPI: IRQ 6 override to edge, high

The diff of /proc/interrupts:
      6: ...  IR-IO-APIC    [-6-fasteoi-]    {+6-edge+}      AMDI0010:03
     10: ...  IR-IO-APIC   [-10-fasteoi-]   {+10-edge+}      AMDI0010:00

And:
   i2c_designware: /devices/platform/AMDI0010:00
   i2c_designware: /devices/platform/AMDI0010:03


So the if needs to be fine-tuned, apparently. Maybe introduce some list 
as suggested in the commit log. Based on the below?

DMI says:
   System Info: #14
     Manufacturer: "LENOVO"
     Product: "82RA"
     Version: "IdeaPad Flex 5 16ALC7"
     Serial: "PW02359K"
     UUID: 6b2d54d9-cd80-11ec-83eb-e00af665fbac
     Wake-up: 0x06 (Power Switch)
   Board Info: #15
     Manufacturer: "LENOVO"
     Product: "LNVNB161216"
     Version: "SDK0T76463 WIN"
     Serial: "PW02359K"
     Asset Tag: "No Asset Tag"
     Type: 0x0a (Motherboard)
     Features: 0x09
       Hosting Board
       Replaceable
     Location: "Chassis Location Unknown"
   Chassis Info: #16
     Manufacturer: "LENOVO"
     Version: "IdeaPad Flex 5 16ALC7"
     Serial: "PW02359K"
     Asset Tag: "No Asset Tag"
     Type: 0x1f (Other)
     Bootup State: 0x03 (Safe)
     Power Supply State: 0x03 (Safe)
     Thermal State: 0x01 (Other)
     Security Status: 0x01 (Other)

> Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
> ---
> Change sice v5: reworked
> 
>   drivers/acpi/resource.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index c2d494784425..510cdec375c4 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -416,6 +416,16 @@ static bool acpi_dev_irq_override(u32 gsi, u8 triggering, u8 polarity,
>   {
>   	int i;
>   
> +#ifdef CONFIG_X86
> +	/*
> +	 * IRQ override isn't needed on modern AMD Zen systems and
> +	 * this override breaks active low IRQs on AMD Ryzen 6000 and
> +	 * newer systems. Skip it.
> +	 */
> +	if (boot_cpu_has(X86_FEATURE_ZEN))
> +		return false;
> +#endif
> +
>   	for (i = 0; i < ARRAY_SIZE(skip_override_table); i++) {
>   		const struct irq_override_cmp *entry = &skip_override_table[i];
>   

thanks,
-- 
js

