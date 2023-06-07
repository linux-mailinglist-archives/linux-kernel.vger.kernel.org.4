Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B61072674C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 19:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbjFGR3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 13:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjFGR33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 13:29:29 -0400
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB21D128;
        Wed,  7 Jun 2023 10:29:27 -0700 (PDT)
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-33d37cc9d12so5140785ab.2;
        Wed, 07 Jun 2023 10:29:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686158967; x=1688750967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7FMI01c5/aTH2JgiQO7wvRsXSjI5A4s+waPLwXYaaxM=;
        b=ZwwJjIgQRTDqIgYZKOXkD8xh3Qra8npOmzExCeIy+uX/o9w+vXZjchSuhopZF1BUmj
         ztCBrS3pYl9wHqjJXTrncJdBAUeEx0sEkzRyBZwifQAcNfsxUpXp39hd6hd7ZWLEHpTO
         G9DpFJdPAUExjeQxidVjJXh1BeRCLw799wZNFghXEr9l1urTnmJsE1srwCi8v9iJvQyw
         K1oQg504J/lpd8j0mIwWkbhZ2y3gnO3Hexj38LybCb2Yxxvw38MxR67DD+VS1+E1jMOv
         okthc8dIKW/xmBORy8Zx0rPQFt2zTIyRCKQo991KGNHyjd02IC7KlvRpD9GX+uPnt+qG
         wH+g==
X-Gm-Message-State: AC+VfDyW9sZxS1l6D7CK3NjV9CUviRfulmdL1pkz4di6hvwaEDgMu6RR
        mZUOu4ZSkguwev5QJDwzd0R7bA55nw==
X-Google-Smtp-Source: ACHHUZ77+W7soNQkGWjIjKnRjXMpaSZyuPS4OksoJhSoV4je30sSUD5pjYDbOiotx2/eCZ5YGzFcQQ==
X-Received: by 2002:a92:dd08:0:b0:33a:bb61:6f26 with SMTP id n8-20020a92dd08000000b0033abb616f26mr6038616ilm.31.1686158966966;
        Wed, 07 Jun 2023 10:29:26 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id t9-20020a02c489000000b00411b4acc990sm3599292jam.7.2023.06.07.10.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 10:29:26 -0700 (PDT)
Received: (nullmailer pid 3602660 invoked by uid 1000);
        Wed, 07 Jun 2023 17:29:24 -0000
Date:   Wed, 7 Jun 2023 11:29:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     David Yang <mmyangfl@gmail.com>
Cc:     linux-crypto@vger.kernel.org, Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Weili Qian <qianweili@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jia Jie Ho <jiajie.ho@starfivetech.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Jenny Zhang <jenny.zhang@starfivetech.com>,
        William Zhang <william.zhang@broadcom.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hwrng: histb - Move driver to
 drivers/char/hw_random/histb-rng.c
Message-ID: <20230607172924.GA3597743-robh@kernel.org>
References: <20230421165700.1481002-1-mmyangfl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421165700.1481002-1-mmyangfl@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 22, 2023 at 12:56:49AM +0800, David Yang wrote:
> Move to drivers/char/hw_random since histb-(t)rng does not provide
> cryptography pseudo rng.
> 
> histb-rng is pretty like hisi-rng, but after investigation, we confirm
> there is no RNG_PHY_SEED register on histb-rng so a separate driver is
> needed.
> 
> Still we rename relevant function names to match those in hisi-rng.
> 
> Link: https://lore.kernel.org/r/20230401164448.1393336-1-mmyangfl@gmail.com
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> ---
> v2: drop the dependency on HW_RANDOM
>  drivers/char/hw_random/Kconfig                | 11 +++
>  drivers/char/hw_random/Makefile               |  1 +
>  .../trng-stb.c => char/hw_random/histb-rng.c} | 83 +++++++++----------
>  drivers/crypto/hisilicon/Kconfig              |  7 --
>  drivers/crypto/hisilicon/Makefile             |  2 +-
>  drivers/crypto/hisilicon/trng/Makefile        |  3 -
>  6 files changed, 53 insertions(+), 54 deletions(-)
>  rename drivers/{crypto/hisilicon/trng/trng-stb.c => char/hw_random/histb-rng.c} (53%)
> 
> diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
> index 4fdf07ae3c54..c92f146ee89a 100644
> --- a/drivers/char/hw_random/Kconfig
> +++ b/drivers/char/hw_random/Kconfig
> @@ -335,6 +335,17 @@ config HW_RANDOM_HISI
>  
>  	  If unsure, say Y.
>  
> +config HW_RANDOM_HISTB
> +	tristate "Hisilicon STB Random Number Generator support"
> +	depends on ARCH_HISI || COMPILE_TEST
> +	default ARCH_HISI
> +	help
> +	  This driver provides kernel-side support for the Random Number
> +	  Generator hardware found on Hisilicon Hi37xx SoC.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called histb-rng.
> +
>  config HW_RANDOM_ST
>  	tristate "ST Microelectronics HW Random Number Generator support"
>  	depends on HW_RANDOM && ARCH_STI
> diff --git a/drivers/char/hw_random/Makefile b/drivers/char/hw_random/Makefile
> index 09bde4a0f971..32549a1186dc 100644
> --- a/drivers/char/hw_random/Makefile
> +++ b/drivers/char/hw_random/Makefile
> @@ -29,6 +29,7 @@ obj-$(CONFIG_HW_RANDOM_NOMADIK) += nomadik-rng.o
>  obj-$(CONFIG_HW_RANDOM_PSERIES) += pseries-rng.o
>  obj-$(CONFIG_HW_RANDOM_POWERNV) += powernv-rng.o
>  obj-$(CONFIG_HW_RANDOM_HISI)	+= hisi-rng.o
> +obj-$(CONFIG_HW_RANDOM_HISTB) += histb-rng.o
>  obj-$(CONFIG_HW_RANDOM_BCM2835) += bcm2835-rng.o
>  obj-$(CONFIG_HW_RANDOM_IPROC_RNG200) += iproc-rng200.o
>  obj-$(CONFIG_HW_RANDOM_ST) += st-rng.o
> diff --git a/drivers/crypto/hisilicon/trng/trng-stb.c b/drivers/char/hw_random/histb-rng.c
> similarity index 53%
> rename from drivers/crypto/hisilicon/trng/trng-stb.c
> rename to drivers/char/hw_random/histb-rng.c
> index 29200a7d3d81..f652e1135e4b 100644
> --- a/drivers/crypto/hisilicon/trng/trng-stb.c
> +++ b/drivers/char/hw_random/histb-rng.c
> @@ -1,31 +1,27 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later OR MIT
>  /*
> - * Device driver for True RNG in HiSTB SoCs
> - *
>   * Copyright (c) 2023 David Yang
>   */
>  
> -#include <crypto/internal/rng.h>
> -#include <linux/device.h>
>  #include <linux/err.h>
>  #include <linux/hw_random.h>
>  #include <linux/io.h>
>  #include <linux/iopoll.h>
>  #include <linux/kernel.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> -#include <linux/mutex.h>
> -#include <linux/of_device.h>
> +#include <linux/platform_device.h>
>  
> -#define HISTB_TRNG_CTRL		0x0
> +#define RNG_CTRL		0x0
>  #define  RNG_SOURCE			GENMASK(1, 0)
>  #define  DROP_ENABLE			BIT(5)
>  #define  POST_PROCESS_ENABLE		BIT(7)
>  #define  POST_PROCESS_DEPTH		GENMASK(15, 8)
> -#define HISTB_TRNG_NUMBER	0x4
> -#define HISTB_TRNG_STAT		0x8
> +#define RNG_NUMBER		0x4
> +#define RNG_STAT		0x8
>  #define  DATA_COUNT			GENMASK(2, 0)	/* max 4 */
>  
> -struct histb_trng_priv {
> +struct histb_rng_priv {
>  	struct hwrng rng;
>  	void __iomem *base;
>  };
> @@ -35,19 +31,19 @@ struct histb_trng_priv {
>   * depth = 1 -> ~1ms
>   * depth = 255 -> ~16ms
>   */
> -static int histb_trng_wait(void __iomem *base)
> +static int histb_rng_wait(void __iomem *base)
>  {
>  	u32 val;
>  
> -	return readl_relaxed_poll_timeout(base + HISTB_TRNG_STAT, val,
> +	return readl_relaxed_poll_timeout(base + RNG_STAT, val,
>  					  val & DATA_COUNT, 1000, 30 * 1000);
>  }
>  
> -static void histb_trng_init(void __iomem *base, unsigned int depth)
> +static void histb_rng_init(void __iomem *base, unsigned int depth)
>  {
>  	u32 val;
>  
> -	val = readl_relaxed(base + HISTB_TRNG_CTRL);
> +	val = readl_relaxed(base + RNG_CTRL);
>  
>  	val &= ~RNG_SOURCE;
>  	val |= 2;
> @@ -58,72 +54,72 @@ static void histb_trng_init(void __iomem *base, unsigned int depth)
>  	val |= POST_PROCESS_ENABLE;
>  	val |= DROP_ENABLE;
>  
> -	writel_relaxed(val, base + HISTB_TRNG_CTRL);
> +	writel_relaxed(val, base + RNG_CTRL);
>  }
>  
> -static int histb_trng_read(struct hwrng *rng, void *data, size_t max, bool wait)
> +static int histb_rng_read(struct hwrng *rng, void *data, size_t max, bool wait)
>  {
> -	struct histb_trng_priv *priv = container_of(rng, typeof(*priv), rng);
> +	struct histb_rng_priv *priv = container_of(rng, typeof(*priv), rng);
>  	void __iomem *base = priv->base;
>  
>  	for (int i = 0; i < max; i += sizeof(u32)) {
> -		if (!(readl_relaxed(base + HISTB_TRNG_STAT) & DATA_COUNT)) {
> +		if (!(readl_relaxed(base + RNG_STAT) & DATA_COUNT)) {
>  			if (!wait)
>  				return i;
> -			if (histb_trng_wait(base)) {
> +			if (histb_rng_wait(base)) {
>  				pr_err("failed to generate random number, generated %d\n",
>  				       i);
>  				return i ? i : -ETIMEDOUT;
>  			}
>  		}
> -		*(u32 *) (data + i) = readl_relaxed(base + HISTB_TRNG_NUMBER);
> +		*(u32 *) (data + i) = readl_relaxed(base + RNG_NUMBER);
>  	}
>  
>  	return max;
>  }
>  
> -static unsigned int histb_trng_get_depth(void __iomem *base)
> +static unsigned int histb_rng_get_depth(void __iomem *base)
>  {
> -	return (readl_relaxed(base + HISTB_TRNG_CTRL) & POST_PROCESS_DEPTH) >> 8;
> +	return (readl_relaxed(base + RNG_CTRL) & POST_PROCESS_DEPTH) >> 8;
>  }
>  
>  static ssize_t
>  depth_show(struct device *dev, struct device_attribute *attr, char *buf)
>  {
> -	struct histb_trng_priv *priv = dev_get_drvdata(dev);
> +	struct histb_rng_priv *priv = dev_get_drvdata(dev);
>  	void __iomem *base = priv->base;
>  
> -	return sprintf(buf, "%d\n", histb_trng_get_depth(base));
> +	return sprintf(buf, "%d\n", histb_rng_get_depth(base));
>  }
>  
>  static ssize_t
>  depth_store(struct device *dev, struct device_attribute *attr,
>  	    const char *buf, size_t count)
>  {
> -	struct histb_trng_priv *priv = dev_get_drvdata(dev);
> +	struct histb_rng_priv *priv = dev_get_drvdata(dev);
>  	void __iomem *base = priv->base;
>  	unsigned int depth;
>  
>  	if (kstrtouint(buf, 0, &depth))
>  		return -ERANGE;
>  
> -	histb_trng_init(base, depth);
> +	histb_rng_init(base, depth);
>  	return count;
>  }
>  
>  static DEVICE_ATTR_RW(depth);
>  
> -static struct attribute *histb_trng_attrs[] = {
> +static struct attribute *histb_rng_attrs[] = {
>  	&dev_attr_depth.attr,
>  	NULL,
>  };
>  
> -ATTRIBUTE_GROUPS(histb_trng);
> +ATTRIBUTE_GROUPS(histb_rng);
>  
> -static int histb_trng_probe(struct platform_device *pdev)
> +static int histb_rng_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> -	struct histb_trng_priv *priv;
> +	struct histb_rng_priv *priv;
>  	void __iomem *base;
>  	int ret;
>  
> @@ -133,17 +129,17 @@ static int histb_trng_probe(struct platform_device *pdev)
>  
>  	base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(base))
> -		return -ENOMEM;
> +		return PTR_ERR(base);
>  
> -	histb_trng_init(base, 144);
> -	if (histb_trng_wait(base)) {
> +	histb_rng_init(base, 144);
> +	if (histb_rng_wait(base)) {
>  		dev_err(dev, "cannot bring up device\n");
>  		return -ENODEV;
>  	}
>  
>  	priv->base = base;
>  	priv->rng.name = pdev->name;
> -	priv->rng.read = histb_trng_read;
> +	priv->rng.read = histb_rng_read;
>  	ret = devm_hwrng_register(dev, &priv->rng);
>  	if (ret) {
>  		dev_err(dev, "failed to register hwrng: %d\n", ret);
> @@ -155,22 +151,23 @@ static int histb_trng_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static const struct of_device_id histb_trng_of_match[] = {
> -	{ .compatible = "hisilicon,histb-trng", },
> +static const struct of_device_id histb_rng_of_match[] = {
> +	{ .compatible = "hisilicon,histb-rng", },

You can't just change compatible strings as they are an ABI. Seems this 
is a newly added driver though, so I guess it's okay. However, neither 
string was documented with a DT schema and that must be fixed.

Rob
