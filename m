Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAD85B8B14
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 16:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiINOxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 10:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiINOxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 10:53:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CF28035F;
        Wed, 14 Sep 2022 07:53:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1699361E34;
        Wed, 14 Sep 2022 14:53:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEDD8C433D6;
        Wed, 14 Sep 2022 14:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663167196;
        bh=x2mRu6ozYBweZ3MuATzw0nKMjh2Dk4MFiV0lclAWNLw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JMNu79BxdLl9pL6vqHJQ9wWkKIG1wrgwsaZkVOtmmUrDaz8D/WQXV4KNkEhZUKDHw
         wLD5bpNuCLmWSVaQ5nIX65a+yvhihMWKs2o4DhUiQUXWa85WiDR+Lr+tlBRCSyBlb5
         PhU53dAXlsdZNyVLnSr/i5Hi58oYnyxX5ov2y2ZY=
Date:   Wed, 14 Sep 2022 16:53:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
Cc:     linux-kernel@vger.kernel.org, will@kernel.org, axboe@kernel.dk,
        robh+dt@kernel.org, mb@lightnvm.io, ckeepax@opensource.cirrus.com,
        arnd@arndb.d, mst@redhat.com, javier@javigon.com,
        mikelley@microsoft.com, jasowang@redhat.com,
        sunilmut@microsoft.com, bjorn.andersson@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        ashish.deshpande@nxp.com, rvmanjumce@gmail.com
Subject: Re: [PATCH v5 2/2] misc: nxp-sr1xx: UWB driver support for sr1xx
 series chip
Message-ID: <YyHq9OOKBLP2GEcc@kroah.com>
References: <20220914142944.576482-1-manjunatha.venkatesh@nxp.com>
 <20220914142944.576482-3-manjunatha.venkatesh@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914142944.576482-3-manjunatha.venkatesh@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 07:59:44PM +0530, Manjunatha Venkatesh wrote:
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -471,6 +471,17 @@ config HISI_HIKEY_USB
>  	  switching between the dual-role USB-C port and the USB-A host ports
>  	  using only one USB controller.
> 
> +config NXP_UWB
> +    tristate "NXP UCI(Uwb Command Interface) protocol driver support"
> +    depends on SPI
> +    help
> +      This option enables the UWB driver for NXP sr1xx device.
> +      Such device supports UCI packet structure, FiRa compliant.
> +
> +      Say Y here to compile support for nxp-sr1xx into the kernel or
> +      say M to compile it as a module. The module will be called
> +      nxp-sr1xx.ko

No tabs?

> +
>  config OPEN_DICE
>  	tristate "Open Profile for DICE driver"
>  	depends on OF_RESERVED_MEM
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index 2be8542616dd..ee8ca32c66f6 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -60,4 +60,5 @@ obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
>  obj-$(CONFIG_HISI_HIKEY_USB)	+= hisi_hikey_usb.o
>  obj-$(CONFIG_HI6421V600_IRQ)	+= hi6421v600-irq.o
>  obj-$(CONFIG_OPEN_DICE)		+= open-dice.o
>  obj-$(CONFIG_VCPU_STALL_DETECTOR)	+= vcpu_stall_detector.o
> +obj-$(CONFIG_NXP_UWB) 		+= nxp-sr1xx.o
> diff --git a/drivers/misc/nxp-sr1xx.c b/drivers/misc/nxp-sr1xx.c
> new file mode 100644
> index 000000000000..6ca9a2b54b86
> --- /dev/null
> +++ b/drivers/misc/nxp-sr1xx.c
> @@ -0,0 +1,794 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)

Please no.  If you really want to dual-license your Linux kernel code,
that's fine, but I will insist that you get a signed-off-by from your
corporate lawyer so that I know that they agree with this and are
willing to handle all of the complex issues that this entails as it will
require work on their side over time.

If that's not worth bothering your lawyers over, please just stick with
GPL as the only license.


> +/*
> + * Copyright 2018-2022 NXP.
> + *
> + * SPI driver for UWB SR1xx
> + * Author: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
> + */
> +
> +#include <linux/miscdevice.h>
> +#include <linux/module.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/of_gpio.h>
> +#include <linux/spi/spi.h>
> +#include <linux/uaccess.h>
> +
> +#define SR1XX_MAGIC 0xEA
> +#define SR1XX_SET_PWR _IOW(SR1XX_MAGIC, 0x01, long)
> +#define SR1XX_SET_FWD _IOW(SR1XX_MAGIC, 0x02, long)

You can't stick ioctl command definitions in a .c file that userspace
never sees.  How are your userspace tools supposed to know what the
ioctl is and how it is defined?

How was this ever tested and where is your userspace code that interacts
with this code?

thanks,

greg k-h
