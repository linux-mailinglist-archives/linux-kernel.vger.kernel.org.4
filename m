Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEBFE66E4DA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 18:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233018AbjAQRYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 12:24:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235415AbjAQRXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 12:23:41 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACAB74B742;
        Tue, 17 Jan 2023 09:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=d4WBILilzYsNGArsge+y5s7v2GX865hdolZPV6TRt7I=; b=Em7g0qDcz7bEafI6aNIe2D0so+
        Cg9kajB3XyiKTQiPy5XroTuGTnsQUOza+shC4LCIflse5oQMU9Uh0ycYhT5GDpVrxrOXCQAwdTQrJ
        YHe/LqCUWDKmGtqzJieWDu7sMXEtSzFLVjVT0zWHy2eTapJOrzmfcZUXly1zP/kUY/V2+ATItLS24
        0l+PABRuPUz68XY8uU9OOE1ZIK9IgIJr8Yg5zh+aOf6wkperDZYMdPid1ERuvYyX+cPfMOXCh0Djx
        DI1mTyDKFHWBhae2IB11pVz8AAUyVITlkzhZ27g2KyLmuhs4LAEMlWXP/hYdcp3901yQpJq7e9RQr
        Swg5WMlQ==;
Received: from [2601:1c2:d80:3110::9307]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHpeg-00FF2u-Rl; Tue, 17 Jan 2023 17:21:50 +0000
Message-ID: <cc20a76f-6de5-b850-2c54-1e2a535feca6@infradead.org>
Date:   Tue, 17 Jan 2023 09:21:48 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 01/19] bus/cdx: add the cdx bus driver
Content-Language: en-US
To:     Nipun Gupta <nipun.gupta@amd.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, eric.auger@redhat.com,
        alex.williamson@redhat.com, cohuck@redhat.com,
        song.bao.hua@hisilicon.com, mchehab+huawei@kernel.org,
        maz@kernel.org, f.fainelli@gmail.com, jeffrey.l.hugo@gmail.com,
        saravanak@google.com, Michael.Srba@seznam.cz, mani@kernel.org,
        yishaih@nvidia.com, jgg@ziepe.ca, jgg@nvidia.com,
        robin.murphy@arm.com, will@kernel.org, joro@8bytes.org,
        masahiroy@kernel.org, ndesaulniers@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     okaya@kernel.org, harpreet.anand@amd.com, nikhil.agarwal@amd.com,
        michal.simek@amd.com, git@amd.com
References: <20230117134139.1298-1-nipun.gupta@amd.com>
 <20230117134139.1298-2-nipun.gupta@amd.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230117134139.1298-2-nipun.gupta@amd.com>
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

Hi--

On 1/17/23 05:41, Nipun Gupta wrote:
> Introduce AMD CDX bus, which provides a mechanism for scanning
> and probing CDX devices. These devices are memory mapped on
> system bus for Application Processors(APUs).
> 
> CDX devices can be changed dynamically in the Fabric and CDX
> bus interacts with CDX controller to rescan the bus and
> rediscover the devices.
> 
> Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
> Signed-off-by: Tarak Reddy <tarak.reddy@amd.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-cdx |  12 +
>  MAINTAINERS                             |   7 +
>  drivers/bus/Kconfig                     |   1 +
>  drivers/bus/Makefile                    |   2 +
>  drivers/bus/cdx/Kconfig                 |  14 +
>  drivers/bus/cdx/Makefile                |   8 +
>  drivers/bus/cdx/cdx.c                   | 433 ++++++++++++++++++++++++
>  drivers/bus/cdx/cdx.h                   |  62 ++++
>  include/linux/cdx/cdx_bus.h             | 153 +++++++++
>  include/linux/mod_devicetable.h         |  15 +
>  scripts/mod/devicetable-offsets.c       |   4 +
>  scripts/mod/file2alias.c                |  12 +
>  12 files changed, 723 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-cdx
>  create mode 100644 drivers/bus/cdx/Kconfig
>  create mode 100644 drivers/bus/cdx/Makefile
>  create mode 100644 drivers/bus/cdx/cdx.c
>  create mode 100644 drivers/bus/cdx/cdx.h
>  create mode 100644 include/linux/cdx/cdx_bus.h
> 

> diff --git a/drivers/bus/cdx/Kconfig b/drivers/bus/cdx/Kconfig
> new file mode 100644
> index 000000000000..54e0623ebcff
> --- /dev/null
> +++ b/drivers/bus/cdx/Kconfig
> @@ -0,0 +1,14 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# CDX bus configuration
> +#
> +# Copyright (C) 2022-2023, Advanced Micro Devices, Inc.
> +#
> +
> +config CDX_BUS
> +	bool "CDX Bus driver"
> +	help
> +	  Driver to enable CDX Bus. CDX bus provides a mechanism for
> +	  scanning and probing of CDX devices. CDX devices are memory
> +	  mapped on system bus for embedded CPUs. CDX bus uses CDX
> +	  controller and firmware to scan the CDX devices.

Would you mind telling people who use 'make *config' what CDX means,
either in the bool prompt string or in the help text?


> +/**
> + * cdx_unregister_device - Unregister a CDX device
> + * @dev: CDX device
> + * @data: This is always passed as NULL, and is not used in this API,
> + *	  but is required here as the bus_for_each_dev() API expects
> + *	  the passed function (cdx_unregister_device) to have this
> + *	  as an argument.
> + *
> + * @return: -errno on failure, 0 on success.

The syntax (or spelling) for a function's return value in kernel-doc is just:
 * Return: -errno on failure, 0 on success.

That should be changed in many places throughout.

Thanks.

-- 
~Randy
