Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354EC5EF2CE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 11:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235096AbiI2Jz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 05:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiI2Jzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 05:55:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5394E9DFAB;
        Thu, 29 Sep 2022 02:55:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E449160BF0;
        Thu, 29 Sep 2022 09:55:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C598DC433D6;
        Thu, 29 Sep 2022 09:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664445352;
        bh=n00c4eeAjMCSUOYpZjK2HcCQN9bxyNQChU/4UPcuT58=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sD44uY+uXt+HgoIFBUjwnCKOBKC1bgtPcVmAVtP0XWaYvB0H+OlwLkenCEsPESrWg
         6g+U6RIDZUKZqT9SYcC3PZF/Ib7ZmpQI7Ykc6tynbrqizVJcROODUl+pxM0w6AxCiW
         UBTj2a50d5A4IFEZk+rFA4tk+MfZbYdzdqd6USRg=
Date:   Thu, 29 Sep 2022 11:55:49 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Quan Nguyen <quan@os.amperecomputing.com>
Cc:     macro@orcam.me.uk, Lee Jones <lee@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thu Nguyen <thu@os.amperecomputing.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Open Source Submission <patches@amperecomputing.com>,
        Phong Vo <phong@os.amperecomputing.com>,
        thang@os.amperecomputing.com
Subject: Re: [PATCH v9 5/9] misc: smpro-misc: Add Ampere's Altra SMpro misc
 driver
Message-ID: <YzVrpT6BD6qmu5ZG@kroah.com>
References: <20220929094321.770125-1-quan@os.amperecomputing.com>
 <20220929094321.770125-6-quan@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929094321.770125-6-quan@os.amperecomputing.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 04:43:17PM +0700, Quan Nguyen wrote:
> This commit adds driver support for accessing various information
> reported by Ampere's SMpro co-processor such as Boot Progress and
> other miscellaneous data.
> 
> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
> ---
> Changes in v9:
>   + Update SPDX licence                                     [Greg]
>   + Use ATTRIBUTE_GROUPS()                                  [Greg]
>   + Use dev_groups instead of sysfs_create_group() to avoid
>   racing issue with user space                              [Greg]
>   + Refactor code to avoid clever encoding issue            [Quan]
> 
> Changes in v8:
>   + Update wording for SMPRO_MISC in Kconfig file           [Quan]
>   + Switch to use sysfs_emit()                              [Quan]
> 
> Changes in v7:
>   + Fix wrong return type of *_show/store()
>   functions                                    [kernel robot test]
>   + Adjust patch order to remove dependence with
>   smpro-mfd                                            [Lee Jones]
> 
> Changes in v6:
>   + First introduced in v6 [Quan]
> 
>  drivers/misc/Kconfig      |  10 +++
>  drivers/misc/Makefile     |   1 +
>  drivers/misc/smpro-misc.c | 145 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 156 insertions(+)
>  create mode 100644 drivers/misc/smpro-misc.c
> 
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index b9ceee949dab..9947b7892bd5 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -188,6 +188,16 @@ config SMPRO_ERRMON
>  	  To compile this driver as a module, say M here. The driver will be
>  	  called smpro-errmon.
>  
> +config SMPRO_MISC
> +	tristate "Ampere Computing SMPro miscellaneous driver"
> +	depends on MFD_SMPRO || COMPILE_TEST
> +	help
> +	  Say Y here to get support for the SMpro error miscellalenous function
> +	  provided by Ampere Computing's Altra and Altra Max SoCs.
> +
> +	  To compile this driver as a module, say M here. The driver will be
> +	  called smpro-misc.
> +
>  config CS5535_MFGPT
>  	tristate "CS5535/CS5536 Geode Multi-Function General Purpose Timer (MFGPT) support"
>  	depends on MFD_CS5535
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index bbe24d4511a3..87b54a4a4422 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -24,6 +24,7 @@ obj-$(CONFIG_KGDB_TESTS)	+= kgdbts.o
>  obj-$(CONFIG_SGI_XP)		+= sgi-xp/
>  obj-$(CONFIG_SGI_GRU)		+= sgi-gru/
>  obj-$(CONFIG_SMPRO_ERRMON)	+= smpro-errmon.o
> +obj-$(CONFIG_SMPRO_MISC)	+= smpro-misc.o
>  obj-$(CONFIG_CS5535_MFGPT)	+= cs5535-mfgpt.o
>  obj-$(CONFIG_GEHC_ACHC)		+= gehc-achc.o
>  obj-$(CONFIG_HP_ILO)		+= hpilo.o
> diff --git a/drivers/misc/smpro-misc.c b/drivers/misc/smpro-misc.c
> new file mode 100644
> index 000000000000..6c427141e51b
> --- /dev/null
> +++ b/drivers/misc/smpro-misc.c
> @@ -0,0 +1,145 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Ampere Computing SoC's SMpro Misc Driver
> + *
> + * Copyright (c) 2022, Ampere Computing LLC
> + */
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +/* Boot Stage/Progress Registers */
> +#define BOOTSTAGE	0xB0
> +#define BOOTSTAGE_LO	0xB1
> +#define CUR_BOOTSTAGE	0xB2
> +#define BOOTSTAGE_HI	0xB3
> +
> +/* SOC State Registers */
> +#define SOC_POWER_LIMIT		0xE5
> +
> +struct smpro_misc {
> +	struct regmap *regmap;
> +};
> +
> +static ssize_t boot_progress_show(struct device *dev, struct device_attribute *da, char *buf)
> +{
> +	struct smpro_misc *misc = dev_get_drvdata(dev);
> +	u16 boot_progress[3] = { 0 };
> +	u32 bootstage;
> +	u8 boot_stage;
> +	u8 cur_stage;
> +	u32 reg_lo;
> +	u32 reg;
> +	int ret;
> +
> +	/* Read current boot stage */
> +	ret = regmap_read(misc->regmap, CUR_BOOTSTAGE, &reg);
> +	if (ret)
> +		return ret;
> +
> +	cur_stage = reg & 0xff;
> +
> +	ret = regmap_read(misc->regmap, BOOTSTAGE, &bootstage);
> +	if (ret)
> +		return ret;
> +
> +	boot_stage = (bootstage >> 8) & 0xff;
> +
> +	if (boot_stage > cur_stage)
> +		return -EINVAL;
> +
> +	ret = regmap_read(misc->regmap,	BOOTSTAGE_LO, &reg_lo);
> +	if (!ret)
> +		ret = regmap_read(misc->regmap, BOOTSTAGE_HI, &reg);
> +	if (ret)
> +		return ret;
> +
> +	/* Firmware to report new boot stage next time */
> +	if (boot_stage < cur_stage) {
> +		ret = regmap_write(misc->regmap, BOOTSTAGE, ((bootstage & 0xff00) | 0x1));
> +		if (ret)
> +			return ret;
> +	}
> +
> +	boot_progress[0] = bootstage;
> +	boot_progress[1] = swab16(reg);
> +	boot_progress[2] = swab16(reg_lo);
> +
> +	return sysfs_emit(buf, "%*phN\n", (int)sizeof(boot_progress), boot_progress);
> +}

Again, please put the Documentation/ABI/ entries in this commit so that
we can verify they are all correct.  Putting them at the end of the
series makes it pretty impossible to review.  Would you want to have to
match them all up the way you sent them?

thanks,

greg k-h
