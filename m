Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E974170DD0D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 14:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236742AbjEWMyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 08:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236093AbjEWMyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 08:54:15 -0400
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC53118
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 05:54:13 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw21.mail.saunalahti.fi (Halon) with ESMTP
        id e796b66c-f968-11ed-abf4-005056bdd08f;
        Tue, 23 May 2023 15:54:11 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Tue, 23 May 2023 15:54:07 +0300
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v11 2/2] spi: loongson: add bus driver for the loongson
 spi controller
Message-ID: <ZGy3b7ZfNwWoGDTu@surfacebook>
References: <20230522071030.5193-1-zhuyinbo@loongson.cn>
 <20230522071030.5193-3-zhuyinbo@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522071030.5193-3-zhuyinbo@loongson.cn>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, May 22, 2023 at 03:10:30PM +0800, Yinbo Zhu kirjoitti:
> This bus driver supports the Loongson SPI hardware controller in the
> Loongson platforms and supports to use DTS and PCI framework to
> register SPI device resources.

It's polite to add reviewers of the previous versions to the Cc list.

...

> +static void loongson_spi_set_clk(struct loongson_spi *loongson_spi, unsigned int hz)
> +{
> +	unsigned char val;
> +	unsigned int div, div_tmp;

> +	const char rdiv[12] = {0, 1, 4, 2, 3, 5, 6, 7, 8, 9, 10, 11};

static?

> +
> +	div = clamp_val(DIV_ROUND_UP_ULL(loongson_spi->clk_rate, hz), 2, 4096);
> +	div_tmp = rdiv[fls(div - 1)];
> +	loongson_spi->spcr = (div_tmp & GENMASK(1, 0)) >> 0;
> +	loongson_spi->sper = (div_tmp & GENMASK(3, 2)) >> 2;
> +	val = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPCR_REG);
> +	loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPCR_REG, (val & ~3) |
> +			       loongson_spi->spcr);
> +	val = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPER_REG);
> +	loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPER_REG, (val & ~3) |
> +			       loongson_spi->sper);
> +	loongson_spi->hz = hz;
> +}

...

> +static int loongson_spi_update_state(struct loongson_spi *loongson_spi,
> +				struct spi_device *spi, struct spi_transfer *t)
> +{
> +	unsigned int hz;
> +
> +	if (t)
> +		hz = t->speed_hz;

And if t is NULL? hz will be uninitialized. Don't you get a compiler warning?
(Always test your code with `make W=1 ...`)

> +	if (hz && loongson_spi->hz != hz)
> +		loongson_spi_set_clk(loongson_spi, hz);
> +
> +	if ((spi->mode ^ loongson_spi->mode) & SPI_MODE_X_MASK)
> +		loongson_spi_set_mode(loongson_spi, spi);
> +
> +	return 0;
> +}

...

> +	readb_poll_timeout(loongson_spi->base + LOONGSON_SPI_SPSR_REG, loongson_spi->spsr,
> +			   (loongson_spi->spsr & 0x1) != 1, 1, MSEC_PER_SEC);

Wouldn't be better to use ' == 0' in the conditional? Or if you think your
approach is better (to show the exact expectation) the definition of the bit 0
might help

#define LOONGSON_... BIT(0)


	readb_poll_timeout(loongson_spi->base + LOONGSON_SPI_SPSR_REG, loongson_spi->spsr,
			   (loongson_spi->spsr & LOONGSON_...) != LOONGSON_...,
			   1, MSEC_PER_SEC);

...

> +	do {
> +		if (loongson_spi_write_read_8bit(spi, &tx, &rx, count) < 0)

> +			goto out;

		break;

> +		count--;
> +	} while (count);

	} while (--count);

?

> +out:
> +	return xfer->len - count;

Shouldn't you return an error code if the write failed?

...

> +	master = devm_spi_alloc_master(dev, sizeof(struct loongson_spi));

> +	if (master == NULL)

	if (!master)

> +		return -ENOMEM;

Why do you use deprecated naming? Can you use spi_controller* instead of
spi_master* in all cases?

...

> +	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;

	= SPI_MODE_X_MASK | SPI_CS_HIGH;

...

> +	clk = devm_clk_get_optional(dev, NULL);
> +	if (!IS_ERR(clk))
> +		spi->clk_rate = clk_get_rate(clk);

> +	else

Redundant. Just check for the error first as it's very usual pattern in the
Linux kernel.

> +		return dev_err_probe(dev, PTR_ERR(clk), "unable to get clock\n");

...

> +static void loongson_spi_pci_unregister(struct pci_dev *pdev)
> +{

> +	pcim_iounmap_regions(pdev, BIT(0));

Not needed due to 'm' in the API name, which means "managed".

> +	pci_disable_device(pdev);

This is simply wrong. We don't do explicit clean up for managed resources.

> +}

That said, drop the ->remove() completely.

...

> +static struct pci_device_id loongson_spi_devices[] = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_LOONGSON, 0x7a0b) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_LOONGSON, 0x7a1b) },
> +	{ },

No comma for the terminator entry. It's by definition "terminating" something.

> +};

...

> +#include <linux/of.h>

There is no user of this header. Please, replace with what actually is being
used (presumably mod_devicetable.h and maybe others).

> +#include <linux/platform_device.h>
> +
> +#include "spi-loongson.h"
> +
> +static int loongson_spi_platform_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +	void __iomem *reg_base;
> +	struct device *dev = &pdev->dev;
> +
> +	reg_base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(reg_base))
> +		return PTR_ERR(reg_base);
> +
> +	ret = loongson_spi_init_master(dev, reg_base);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to initialize master\n");
> +
> +	return ret;

	return 0;

> +}

...

> +#ifndef __LINUX_SPI_LOONGSON_H
> +#define __LINUX_SPI_LOONGSON_H
> +
> +#include <linux/bits.h>

> +#include <linux/device.h>

This header is not used.

> +#include <linux/pm.h>

> +#include <linux/spi/spi.h>

This neither.

> +#include <linux/types.h>


For them use forward declarations

struct device;
struct spi_controller;

The rest of the inclusions is correct.

...

> +#define	LOONGSON_SPI_SPCR_REG	0x00
> +#define	LOONGSON_SPI_SPSR_REG	0x01
> +#define	LOONGSON_SPI_FIFO_REG	0x02
> +#define	LOONGSON_SPI_SPER_REG	0x03
> +#define	LOONGSON_SPI_PARA_REG	0x04
> +#define	LOONGSON_SPI_SFCS_REG	0x05
> +#define	LOONGSON_SPI_TIMI_REG	0x06

Where is this used outside of the main driver?

> +/* Bits definition for Loongson SPI register */
> +#define	LOONGSON_SPI_PARA_MEM_EN	BIT(0)
> +#define	LOONGSON_SPI_SPCR_CPHA	BIT(2)
> +#define	LOONGSON_SPI_SPCR_CPOL	BIT(3)
> +#define	LOONGSON_SPI_SPCR_SPE	BIT(6)
> +#define	LOONGSON_SPI_SPSR_WCOL	BIT(6)
> +#define	LOONGSON_SPI_SPSR_SPIF	BIT(7)
> +
> +struct loongson_spi {
> +	struct	spi_master	*master;
> +	void __iomem		*base;
> +	int			cs_active;
> +	unsigned int		hz;
> +	unsigned char		spcr;
> +	unsigned char		sper;
> +	unsigned char		spsr;
> +	unsigned char		para;
> +	unsigned char		sfcs;
> +	unsigned char		timi;
> +	unsigned int		mode;
> +	u64			clk_rate;
> +};
> +
> +int loongson_spi_init_master(struct device *dev, void __iomem *reg);
> +extern const struct dev_pm_ops loongson_spi_dev_pm_ops;
> +#endif /* __LINUX_SPI_LOONGSON_H */

-- 
With Best Regards,
Andy Shevchenko


