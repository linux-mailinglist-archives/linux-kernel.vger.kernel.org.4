Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62172681BEB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 21:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjA3U43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 15:56:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjA3U4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 15:56:22 -0500
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E509470A3;
        Mon, 30 Jan 2023 12:56:20 -0800 (PST)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-163ba2b7c38so4952614fac.4;
        Mon, 30 Jan 2023 12:56:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Um3RKnpjfXkq9mWJo4q+B/UMhf/0ck3dJkEENGHNeio=;
        b=dyBB2NPH4SR/Q5ehGclZP+7wsY/6S5vShwdR+CGvW26S1HdgR/tiZSE+2m9ZFgv1po
         /AArWG7SX7coqZMOywcUfFyMizXLqtqyclqL1sfWAJwEWV8j5rIV4qQ3N763NR+vnQ6N
         8/ifh/BmOHW6NaqjPAQg+Lt/iwhmolnItd/XwKJ35Vg3StCUsjYdbjYUvtu0NhVLHtDB
         un2ejmUqPxKoWMj6vu7ea14HUnTVQoq2RbV+IEJmvZQ5FBuob8yRs+4xoHgraA9OytMR
         s2wrzvOuDyU1UYllNbfMEqz16uf1TjYYNwwDecqA89oRExfNuIoxp2o6OBZOOCeu4b5s
         iH2A==
X-Gm-Message-State: AFqh2kqvS68w9UXpQBj1O39I5dH+2qQnIPsZlrCSDS0J8srYKFDpg+EM
        ot3B45XRr6DByO2h+7Bc2kWqCCTh+A==
X-Google-Smtp-Source: AMrXdXuMGOH9ed9QMTQf8yNGL82yCaizoIAWODEuXMz67wCZsEJ3r+tXpXoEgrQSRomNPJajkcwaRA==
X-Received: by 2002:a05:6871:4489:b0:13c:e933:2898 with SMTP id ne9-20020a056871448900b0013ce9332898mr24894159oab.49.1675112179803;
        Mon, 30 Jan 2023 12:56:19 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id gn12-20020a056870d98c00b0013ae39d0575sm5619127oab.15.2023.01.30.12.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 12:56:19 -0800 (PST)
Received: (nullmailer pid 3339510 invoked by uid 1000);
        Mon, 30 Jan 2023 20:56:18 -0000
Date:   Mon, 30 Jan 2023 14:56:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH 2/2] nvmem: add generic driver for devices with I/O based
 access
Message-ID: <20230130205618.GB3290808-robh@kernel.org>
References: <20230127175831.26753-1-zajec5@gmail.com>
 <20230127175831.26753-2-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230127175831.26753-2-zajec5@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 06:58:31PM +0100, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> With nvmem layouts in place we should now work on plain content access
> NVMEM drivers (e.g. IO one). Actual NVMEM content handling should go to
> layout drivers.

Surely we have some existing driver that could use this? Point its 
compatible here and delete the driver.

I'm normally against 'generic' bindings, but for generic drivers. In 
this case, I think nvmem is simple enough to be generic (hopefully).

> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>  drivers/nvmem/Kconfig  |  7 ++++
>  drivers/nvmem/Makefile |  2 ++
>  drivers/nvmem/io.c     | 79 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 88 insertions(+)
>  create mode 100644 drivers/nvmem/io.c
> 
> diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
> index 789729ff7e50..e77bfe6eb52e 100644
> --- a/drivers/nvmem/Kconfig
> +++ b/drivers/nvmem/Kconfig
> @@ -90,6 +90,13 @@ config NVMEM_IMX_OCOTP_SCU
>  	  This is a driver for the SCU On-Chip OTP Controller (OCOTP)
>  	  available on i.MX8 SoCs.
>  
> +config NVMEM_IO
> +	tristate "IO access based NVMEM support"
> +	depends on HAS_IOMEM
> +	help
> +	  This driver provides support for NVMEM devices that can be accessed
> +	  using I/O mapping.
> +
>  config NVMEM_JZ4780_EFUSE
>  	tristate "JZ4780 EFUSE Memory Support"
>  	depends on MACH_INGENIC || COMPILE_TEST
> diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
> index 442f9a4876a5..82db0a89c4d6 100644
> --- a/drivers/nvmem/Makefile
> +++ b/drivers/nvmem/Makefile
> @@ -20,6 +20,8 @@ obj-$(CONFIG_NVMEM_IMX_OCOTP)		+= nvmem-imx-ocotp.o
>  nvmem-imx-ocotp-y			:= imx-ocotp.o
>  obj-$(CONFIG_NVMEM_IMX_OCOTP_SCU)	+= nvmem-imx-ocotp-scu.o
>  nvmem-imx-ocotp-scu-y			:= imx-ocotp-scu.o
> +obj-$(CONFIG_NVMEM_IO)			+= nvmem-io.o
> +nvmem-io-y				:= io.o
>  obj-$(CONFIG_NVMEM_JZ4780_EFUSE)	+= nvmem_jz4780_efuse.o
>  nvmem_jz4780_efuse-y			:= jz4780-efuse.o
>  obj-$(CONFIG_NVMEM_LAN9662_OTPC)	+= nvmem-lan9662-otpc.o
> diff --git a/drivers/nvmem/io.c b/drivers/nvmem/io.c
> new file mode 100644
> index 000000000000..307526fda036
> --- /dev/null
> +++ b/drivers/nvmem/io.c
> @@ -0,0 +1,79 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2023 Rafał Miłecki <rafal@milecki.pl>
> + */
> +
> +#include <linux/io.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/nvmem-provider.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/slab.h>
> +
> +struct io_nvmem {
> +	void __iomem *base;
> +};
> +
> +static int io_nvmem_read(void *context, unsigned int offset, void *val, size_t bytes)
> +{
> +	struct io_nvmem *priv = context;
> +	u8 *dst = val;
> +
> +	while (bytes--)
> +		*dst++ = readb(priv->base + offset++);

memcpy_fromio

readb() has a barrier to ensure ordering. Not likely needed here.

Rob
