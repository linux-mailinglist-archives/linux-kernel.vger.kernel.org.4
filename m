Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085D0696416
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 13:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbjBNM7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 07:59:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbjBNM7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 07:59:50 -0500
Received: from srv6.fidu.org (srv6.fidu.org [IPv6:2a01:4f8:231:de0::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767E5171D;
        Tue, 14 Feb 2023 04:59:48 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id 294B4C800A8;
        Tue, 14 Feb 2023 13:59:47 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id sYXCixrkRyfs; Tue, 14 Feb 2023 13:59:46 +0100 (CET)
Received: from [192.168.178.52] (host-212-18-30-247.customer.m-online.net [212.18.30.247])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPSA id A2C37C800A7;
        Tue, 14 Feb 2023 13:59:46 +0100 (CET)
Message-ID: <ddd2f741-b29d-9405-eed0-7ae70ccb2f38@tuxedocomputers.com>
Date:   Tue, 14 Feb 2023 13:59:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3] gpiolib: acpi: Add a ignore wakeup quirk for Clevo
 NH5xAx
From:   Werner Sembach <wse@tuxedocomputers.com>
To:     mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com,
        linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, mario.limonciello@amd.com,
        alexander.deucher@amd.com
References: <20230214125810.10715-1-wse@tuxedocomputers.com>
Content-Language: en-US
In-Reply-To: <20230214125810.10715-1-wse@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 14.02.23 um 13:58 schrieb Werner Sembach:
> commit 1796f808e4bb ("HID: i2c-hid: acpi: Stop setting wakeup_capable")
> changed the policy such that I2C touchpads may be able to wake up the
> system by default if the system is configured as such.
>
> However for some devices there is a bug, that is causing the touchpad to
> instantly wake up the device again once it gets deactivated. The root cause
> is still under investigation:
> https://lore.kernel.org/linux-acpi/2d983050-f844-6c5e-8ae9-9f87ac68dfdd@tuxedocomputers.com/T/#mb2e738787f6b6208d17b92aa6e72d4de846d4e4d
>
> To workaround this problem for the time being, introduce a quirk for this
> model that will prevent the wakeup capability for being set for GPIO 16.
Wrong GPIO number in description of v2 (and v1).
>
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> ---
>   drivers/gpio/gpiolib-acpi.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> index e2ab4d5253bea..82e8e43582eba 100644
> --- a/drivers/gpio/gpiolib-acpi.c
> +++ b/drivers/gpio/gpiolib-acpi.c
> @@ -1612,6 +1612,18 @@ static const struct dmi_system_id gpiolib_acpi_quirks[] __initconst = {
>   			.ignore_wake = "ELAN0415:00@9",
>   		},
>   	},
> +	{
> +		/*
> +		 * Spurious wakeups from TP_ATTN# pin
> +		 * Found in BIOS 1.7.7
> +		 */
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "NH5xAx"),
> +		},
> +		.driver_data = &(struct acpi_gpiolib_dmi_quirk) {
> +			.ignore_wake = "SYNA1202:00@16",
> +		},
> +	},
>   	{} /* Terminating entry */
>   };
>   
