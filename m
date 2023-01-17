Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD72566E4F0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 18:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbjAQRbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 12:31:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234269AbjAQRZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 12:25:56 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96F53F2A9;
        Tue, 17 Jan 2023 09:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=xmaePmHrqRqwXI2zxlk6LLHoTQuoxmh/BPox46xydfs=; b=zS6BrPgqQ+mFJSwOJo5pNfMMJB
        L7aLbgYCufI3medq/00VKZcl0LUA87KD2B+7NQ0NPk//RVXrz82bvSS4294cKmhpav1XgguzJg7cW
        dbb9+uSxl7MOer3sFMZMG3MtvN4HVnuG6ZZsp9bZO66KPZG7RCwtKonhIQkwO5d40Mx3WF85RKN+K
        zLdMsHhWIg9uKYctLoj9UCKGHyaS95j8FIDTpq7p2Dkd4cKeblNANOPxF9I26f6TP7CrwAIk7O1nU
        lq6fnuzo4G5vYCJw8SkGahA81/QBcxsEQ5GGRQAKiDoC3Z7Yqr3hLVMzIyeS9/DKNoBrRlzuydzRG
        d3fNnGeQ==;
Received: from [2601:1c2:d80:3110::9307]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHpiO-00FFkU-LF; Tue, 17 Jan 2023 17:25:40 +0000
Message-ID: <9d34efb1-21a7-3e66-1115-8ddf6fae40af@infradead.org>
Date:   Tue, 17 Jan 2023 09:25:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] hid: stop drivers from selecting CONFIG_HID
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        Basavaraj Natikar <basavaraj.natikar@amd.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Douglas Anderson <dianders@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230117172121.2715953-1-arnd@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230117172121.2715953-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/17/23 09:20, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> There is a mix of drivers using either 'depends on HID' or 'select HID',
> which causes both circular dependencies and missed dependencies for
> a 'select':
> 
> WARNING: unment direct dependencies for HID
>   Depends on [m]: HID_SUPPORT [=y] && INPUT [=m]
>   Selected by [y]:
>   - AMD_SFH_HID [=y] && HID_SUPPORT [=y] && (X86_64 || COMPILE_TEST [=y]) && PCI [=y]
>   Selected by [m]:
>   - I2C_HID_CORE [=m] && HID_SUPPORT [=y]
> 
> WARNING: unmet direct dependencies detected for INPUT_FF_MEMLESS
>   Depends on [m]: INPUT [=m]
>   Selected by [y]:
>   - DRAGONRISE_FF [=y] && HID_SUPPORT [=y] && HID [=y] && HID_DRAGONRISE [=y]
>   - HID_MICROSOFT [=y] && HID_SUPPORT [=y] && HID [=y]
>   - GREENASIA_FF [=y] && HID_SUPPORT [=y] && HID [=y] && HID_GREENASIA [=y]
>   Selected by [m]:
>   - INPUT_ARIZONA_HAPTICS [=m] && INPUT [=m] && INPUT_MISC [=y] && MFD_ARIZONA [=y] && SND_SOC [=m]
>   - INPUT_PM8XXX_VIBRATOR [=m] && INPUT [=m] && INPUT_MISC [=y] && (MFD_PM8XXX [=m] || MFD_SPMI_PMIC [=n])
>   - INPUT_MAX8997_HAPTIC [=m] && INPUT [=m] && INPUT_MISC [=y] && PWM [=y] && MFD_MAX8997 [=y]
>   - INPUT_GPIO_VIBRA [=m] && INPUT [=m] && INPUT_MISC [=y] && (GPIOLIB [=y] || COMPILE_TEST [=y])
>   - INPUT_REGULATOR_HAPTIC [=m] && INPUT [=m] && INPUT_MISC [=y] && REGULATOR [=y]
>   - INPUT_TWL6040_VIBRA [=m] && INPUT [=m] && INPUT_MISC [=y] && TWL6040_CORE [=y]
>   - INPUT_PWM_VIBRA [=m] && INPUT [=m] && INPUT_MISC [=y] && PWM [=y]
>   - INPUT_DRV260X_HAPTICS [=m] && INPUT_MISC [=y] && INPUT [=m] && I2C [=y] && (GPIOLIB [=y] || COMPILE_TEST [=y])
>   - INPUT_DRV2665_HAPTICS [=m] && INPUT_MISC [=y] && INPUT [=m] && I2C [=y]
>   - INPUT_DRV2667_HAPTICS [=m] && INPUT_MISC [=y] && INPUT [=m] && I2C [=y]
>   - INPUT_SC27XX_VIBRA [=m] && INPUT [=m] && INPUT_MISC [=y] && (MFD_SC27XX_PMIC [=y] || COMPILE_TEST [=y])
>   - HID_MAYFLASH [=m] && HID_SUPPORT [=y] && HID [=y]
> 
> Avoid this by changing all HID client drivers to use 'depends on HID'.
> For I2C_HID, this requires a larger rework of the Kconfig description,
> but it hopefully becomes easier to understand without the complex
> I2C_HID_CORE definition.
> 
> Fixes: 25621bcc8976 ("HID: Kconfig: split HID support and hid-core compilation")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>


Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/hid/amd-sfh-hid/Kconfig   |  2 +-
>  drivers/hid/i2c-hid/Kconfig       | 31 ++++++++++++++++---------------
>  drivers/hid/intel-ish-hid/Kconfig |  2 +-
>  3 files changed, 18 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/hid/amd-sfh-hid/Kconfig b/drivers/hid/amd-sfh-hid/Kconfig
> index 56e473fc3c93..af752dd3a340 100644
> --- a/drivers/hid/amd-sfh-hid/Kconfig
> +++ b/drivers/hid/amd-sfh-hid/Kconfig
> @@ -5,7 +5,7 @@ menu "AMD SFH HID Support"
>  
>  config AMD_SFH_HID
>  	tristate "AMD Sensor Fusion Hub"
> -	select HID
> +	depends on HID
>  	help
>  	  If you say yes to this option, support will be included for the
>  	  AMD Sensor Fusion Hub.
> diff --git a/drivers/hid/i2c-hid/Kconfig b/drivers/hid/i2c-hid/Kconfig
> index d65abe65ce73..b72b7f1ceca8 100644
> --- a/drivers/hid/i2c-hid/Kconfig
> +++ b/drivers/hid/i2c-hid/Kconfig
> @@ -1,11 +1,15 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -menu "I2C HID support"
> -	depends on I2C
> +menuconfig I2C_HID
> +	tristate "I2C HID support"
> +	default y
> +	depends on I2C && INPUT && HID
> +
> +if I2C_HID
>  
>  config I2C_HID_ACPI
>  	tristate "HID over I2C transport layer ACPI driver"
> -	default n
> -	depends on I2C && INPUT && ACPI
> +	depends on ACPI
> +	select I2C_HID_CORE
>  	help
>  	  Say Y here if you use a keyboard, a touchpad, a touchscreen, or any
>  	  other HID based devices which is connected to your computer via I2C.
> @@ -19,8 +23,8 @@ config I2C_HID_ACPI
>  
>  config I2C_HID_OF
>  	tristate "HID over I2C transport layer Open Firmware driver"
> -	default n
> -	depends on I2C && INPUT && OF
> +	depends on OF
> +	select I2C_HID_CORE
>  	help
>  	  Say Y here if you use a keyboard, a touchpad, a touchscreen, or any
>  	  other HID based devices which is connected to your computer via I2C.
> @@ -34,8 +38,8 @@ config I2C_HID_OF
>  
>  config I2C_HID_OF_ELAN
>  	tristate "Driver for Elan hid-i2c based devices on OF systems"
> -	default n
> -	depends on I2C && INPUT && OF
> +	depends on OF
> +	select I2C_HID_CORE
>  	help
>  	  Say Y here if you want support for Elan i2c devices that use
>  	  the i2c-hid protocol on Open Firmware (Device Tree)-based
> @@ -49,8 +53,8 @@ config I2C_HID_OF_ELAN
>  
>  config I2C_HID_OF_GOODIX
>  	tristate "Driver for Goodix hid-i2c based devices on OF systems"
> -	default n
> -	depends on I2C && INPUT && OF
> +	depends on OF
> +	select I2C_HID_CORE
>  	help
>  	  Say Y here if you want support for Goodix i2c devices that use
>  	  the i2c-hid protocol on Open Firmware (Device Tree)-based
> @@ -62,10 +66,7 @@ config I2C_HID_OF_GOODIX
>  	  will be called i2c-hid-of-goodix.  It will also build/depend on
>  	  the module i2c-hid.
>  
> -endmenu
> -
>  config I2C_HID_CORE
>  	tristate
> -	default y if I2C_HID_ACPI=y || I2C_HID_OF=y || I2C_HID_OF_ELAN=y || I2C_HID_OF_GOODIX=y
> -	default m if I2C_HID_ACPI=m || I2C_HID_OF=m || I2C_HID_OF_ELAN=m || I2C_HID_OF_GOODIX=m
> -	select HID
> +
> +endif
> diff --git a/drivers/hid/intel-ish-hid/Kconfig b/drivers/hid/intel-ish-hid/Kconfig
> index 689da84a520d..253dc10d35ef 100644
> --- a/drivers/hid/intel-ish-hid/Kconfig
> +++ b/drivers/hid/intel-ish-hid/Kconfig
> @@ -6,7 +6,7 @@ config INTEL_ISH_HID
>  	tristate "Intel Integrated Sensor Hub"
>  	default n
>  	depends on X86
> -	select HID
> +	depends on HID
>  	help
>  	  The Integrated Sensor Hub (ISH) enables the ability to offload
>  	  sensor polling and algorithm processing to a dedicated low power

-- 
~Randy
