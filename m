Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 472876E9507
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 14:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbjDTMtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 08:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjDTMtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 08:49:02 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171F7A7;
        Thu, 20 Apr 2023 05:49:01 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-38e12d973bfso534127b6e.0;
        Thu, 20 Apr 2023 05:49:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681994940; x=1684586940;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EEUOOi7Fz+VazakHzsq9RZGvdzOdQ6E4gugoOE3P2nw=;
        b=InBQMckw8D/MwC+lsyg/dukc3SRlMLJhj1J4qrqpCGrvmlDKyDKX7wBiegdwugkL4/
         yunw3a5YtGZ3G/QMl3eZZesS7muuI47GepWYDq9pq/XBi8xQ2oF45h6Web0+sGse8+wY
         L+hIAuIKc0T1yty46CdF8Owg2XJ2W9Q9URnHrCaYWfI5Jje6ZTbj6D6Y+efHOhGJpm3R
         tHDlCfmviDEMdMQ4+zzzLgFc3k6fUiIgcemzqp1bdIMgZp5NxT79vC5FoEaMxOdC7FsS
         Dx+a1ftv3G+geOV/tvv/lo/0tA7kExUpEAe7z6wNHHuccoiRRp8jeUc84QrFE5xU4vsH
         68jg==
X-Gm-Message-State: AAQBX9ci5Z/67vngx+Zkmi4Aya+uA8P++ju2EvStbnw+tlgObpTrsmx6
        byoloM1QkiWIlIJgz1oW2Q==
X-Google-Smtp-Source: AKy350bWxrvtN/1/bQ50uazmYuUpvfPgWUTslz3PKt1Rtz9FumSlaqHN7alJxrCzhHswsY+F5q7tBg==
X-Received: by 2002:aca:be55:0:b0:38e:295e:82ef with SMTP id o82-20020acabe55000000b0038e295e82efmr691968oif.17.1681994940297;
        Thu, 20 Apr 2023 05:49:00 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n9-20020acabd09000000b0038c06ae307asm518381oif.52.2023.04.20.05.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 05:48:59 -0700 (PDT)
Received: (nullmailer pid 2649879 invoked by uid 1000);
        Thu, 20 Apr 2023 12:48:58 -0000
Date:   Thu, 20 Apr 2023 07:48:58 -0500
From:   Rob Herring <robh@kernel.org>
To:     David Yang <mmyangfl@gmail.com>
Cc:     linux-crypto@vger.kernel.org, Weili Qian <qianweili@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] crypto: hisilicon/trng - add support for HiSTB TRNG
Message-ID: <20230420124858.GA2645094-robh@kernel.org>
References: <20230401164448.1393336-1-mmyangfl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230401164448.1393336-1-mmyangfl@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 02, 2023 at 12:44:40AM +0800, David Yang wrote:
> HiSTB TRNG are found on some HiSilicon STB SoCs.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> ---
> v2: fix typo
> v3: add option for post process depth, adjust timeout
> v4: do not case to __iomem, as requested
> v5: do not use rng->priv at all
>  drivers/crypto/hisilicon/Kconfig         |   7 +
>  drivers/crypto/hisilicon/Makefile        |   2 +-
>  drivers/crypto/hisilicon/trng/Makefile   |   3 +
>  drivers/crypto/hisilicon/trng/trng-stb.c | 176 +++++++++++++++++++++++
>  4 files changed, 187 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/crypto/hisilicon/trng/trng-stb.c
> 
> diff --git a/drivers/crypto/hisilicon/Kconfig b/drivers/crypto/hisilicon/Kconfig
> index 4137a8bf131f..e8690c223584 100644
> --- a/drivers/crypto/hisilicon/Kconfig
> +++ b/drivers/crypto/hisilicon/Kconfig
> @@ -82,3 +82,10 @@ config CRYPTO_DEV_HISI_TRNG
>  	select CRYPTO_RNG
>  	help
>  	  Support for HiSilicon TRNG Driver.
> +
> +config CRYPTO_DEV_HISTB_TRNG
> +	tristate "Support for HiSTB TRNG Driver"
> +	depends on ARCH_HISI || COMPILE_TEST
> +	select HW_RANDOM
> +	help
> +	  Support for HiSTB TRNG Driver.
> diff --git a/drivers/crypto/hisilicon/Makefile b/drivers/crypto/hisilicon/Makefile
> index 8595a5a5d228..fc51e0edec69 100644
> --- a/drivers/crypto/hisilicon/Makefile
> +++ b/drivers/crypto/hisilicon/Makefile
> @@ -5,4 +5,4 @@ obj-$(CONFIG_CRYPTO_DEV_HISI_SEC2) += sec2/
>  obj-$(CONFIG_CRYPTO_DEV_HISI_QM) += hisi_qm.o
>  hisi_qm-objs = qm.o sgl.o debugfs.o
>  obj-$(CONFIG_CRYPTO_DEV_HISI_ZIP) += zip/
> -obj-$(CONFIG_CRYPTO_DEV_HISI_TRNG) += trng/
> +obj-y += trng/
> diff --git a/drivers/crypto/hisilicon/trng/Makefile b/drivers/crypto/hisilicon/trng/Makefile
> index d909079f351c..cf20b057c66b 100644
> --- a/drivers/crypto/hisilicon/trng/Makefile
> +++ b/drivers/crypto/hisilicon/trng/Makefile
> @@ -1,2 +1,5 @@
>  obj-$(CONFIG_CRYPTO_DEV_HISI_TRNG) += hisi-trng-v2.o
>  hisi-trng-v2-objs = trng.o
> +
> +obj-$(CONFIG_CRYPTO_DEV_HISTB_TRNG) += histb-trng.o
> +histb-trng-objs += trng-stb.o
> diff --git a/drivers/crypto/hisilicon/trng/trng-stb.c b/drivers/crypto/hisilicon/trng/trng-stb.c
> new file mode 100644
> index 000000000000..29200a7d3d81
> --- /dev/null
> +++ b/drivers/crypto/hisilicon/trng/trng-stb.c
> @@ -0,0 +1,176 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> +/*
> + * Device driver for True RNG in HiSTB SoCs
> + *
> + * Copyright (c) 2023 David Yang
> + */
> +
> +#include <crypto/internal/rng.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/hw_random.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of_device.h>

You don't need anything from this header...

You need platform_device.h and mod_devicetable.h

[...]


> +static const struct of_device_id histb_trng_of_match[] = {
> +	{ .compatible = "hisilicon,histb-trng", },

This binding isn't documented. Please submit a schema.

Rob
