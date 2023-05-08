Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3046FB363
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 17:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234326AbjEHPE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 11:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233864AbjEHPE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 11:04:27 -0400
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F129311A
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 08:04:24 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw22.mail.saunalahti.fi (Halon) with ESMTP
        id 93d5ad66-edb1-11ed-a9de-005056bdf889;
        Mon, 08 May 2023 18:04:10 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Mon, 8 May 2023 18:04:06 +0300
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v9 2/2] spi: loongson: add bus driver for the loongson
 spi controller
Message-ID: <ZFkPZhF8QqScXAmH@surfacebook>
References: <20230426071045.20753-1-zhuyinbo@loongson.cn>
 <20230426071045.20753-3-zhuyinbo@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230426071045.20753-3-zhuyinbo@loongson.cn>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, Apr 26, 2023 at 03:10:45PM +0800, Yinbo Zhu kirjoitti:
> This bus driver supports the Loongson spi hardware controller in the
> Loongson platforms and supports to use DTS and PCI framework to
> register spi device resources.

SPI

...

> +config SPI_LOONGSON_CORE
> +	tristate "Loongson SPI Controller Core Driver Support"

Does it need to be visible to the user?

> +	depends on LOONGARCH || COMPILE_TEST
> +	help
> +	  This core driver supports the Loongson spi hardware controller in
> +	  the Loongson platforms.
> +	  Say Y or M here if you want to use the SPI controller on
> +	  Loongson platform.

...

> +config SPI_LOONGSON_PLATFORM
> +	tristate "Loongson SPI Controller Platform Driver Support"
> +	select SPI_LOONGSON_CORE
> +	depends on OF && (LOONGARCH || COMPILE_TEST)

Is it really dependent to OF? Why?

> +	help
> +	  This bus driver supports the Loongson spi hardware controller in
> +	  the Loongson platforms and supports to use DTS framework to
> +	  register spi device resources.
> +	  Say Y or M here if you want to use the SPI controller on
> +	  Loongson platform.

...

> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/interrupt.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/spi/spi.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>

Ordered?

...

> +	if (loongson_spi->mode & SPI_NO_CS)
> +		loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SFCS_REG, 0);

Missing {}

> +	else {
> +		cs = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SFCS_REG)
> +					   & ~(0x11 << spi->chip_select);
> +		loongson_spi_write_reg(loongson_spi,
> +				       LOONGSON_SPI_SFCS_REG,
> +				       (val ? (0x11 << spi->chip_select) :
> +				       (0x1 << spi->chip_select)) | cs);

Too many parentheses.

> +	}

...

> +	const char rdiv[12] = {0, 1, 4, 2, 3, 5, 6, 7, 8, 9, 10, 11};

Oh, why?!

...

> +	if ((hz && loongson_spi->hz != hz) ||
> +	    ((spi->mode ^ loongson_spi->mode) & (SPI_CPOL | SPI_CPHA))) {
> +		div = DIV_ROUND_UP_ULL(loongson_spi->clk_rate, hz);

> +		if (div < 2)
> +			div = 2;
> +		if (div > 4096)
> +			div = 4096;

NIH clamp_val()

> +		bit = fls(div) - 1;
> +		if ((1<<bit) == div)
> +			bit--;
> +		div_tmp = rdiv[bit];

I believe this can be optimized.

> +		dev_dbg(&spi->dev, "clk_rate = %llu hz = %d div_tmp = %d bit = %d\n",
> +			loongson_spi->clk_rate, hz, div_tmp, bit);
> +
> +		loongson_spi->hz = hz;
> +		loongson_spi->spcr = div_tmp & 3;
> +		loongson_spi->sper = (div_tmp >> 2) & 3;
> +		val = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPCR_REG);
> +		val &= ~0xc;

GENMASK()

> +		if (spi->mode & SPI_CPOL)
> +			val |= 8;

BIT()

> +		if (spi->mode & SPI_CPHA)
> +			val |= 4;

> +		loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPCR_REG, (val & ~3) |
> +				       loongson_spi->spcr);
> +		val = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPER_REG);
> +		loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPER_REG, (val & ~3) |
> +				       loongson_spi->sper);
> +		loongson_spi->mode &= SPI_NO_CS;
> +		loongson_spi->mode |= spi->mode;
> +	}

...

> +		while ((loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPSR_REG) & 0x1) == 1 &&
> +			time_after(timeout, jiffies))
> +			cpu_relax();

iopoll.h has a suitable macro for this.

...

> +		while ((loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPSR_REG) & 0x1) == 1 &&
> +			time_after(timeout, jiffies))
> +			cpu_relax();

Ditto.

...

> +	master = devm_spi_alloc_master(dev, sizeof(struct loongson_spi));
> +	if (master == NULL) {

> +		dev_info(dev, "master allocation failed\n");

We do not issue a message for ENOMEM

> +		return -ENOMEM;
> +	}

...

> +	master->dev.of_node = of_node_get(dev->of_node);

device_set_node()

...

> +	spi->base = devm_ioremap(dev, res->start, resource_size(res));

Why not devm_ioremap_resource()?


> +	if (spi->base == NULL) {
> +		dev_err(dev, "cannot map io\n");
> +		return -ENXIO;

	return dev_err_probe();

> +	}

...

> +	clk = devm_clk_get(dev, NULL);

Can we hav

> +	if (!IS_ERR(clk))

Use _optional variant above instead of this.
Do not forget about deferred probe.

> +		spi->clk_rate = clk_get_rate(clk);

...

> +	if (of_get_property(dev->of_node, "spi-nocs", NULL))
> +		spi->mode |= SPI_NO_CS;

Don't we have something in the SPI core to handle this in a generic way?

...


> +EXPORT_SYMBOL_GPL(loongson_spi_init_master);

Please, use _NS variant.

...

> +MODULE_DESCRIPTION("Loongson spi core driver");

SPI

...

> +	struct resource res[2];
> +	struct device *dev = &pdev->dev;
> +
> +	ret = pci_enable_device(pdev);

pcim_enable_device()

> +	if (ret < 0) {
> +		dev_err(dev, "cannot enable pci device\n");
> +		goto err_out;

	return dev_err_probe();

> +	}
> +
> +	ret = pci_request_region(pdev, 0, "loongson-spi io");
> +	if (ret < 0) {
> +		dev_err(dev, "cannot request region 0.\n");
> +		goto err_out;
> +	}
> +
> +	res[0].start = pci_resource_start(pdev, 0);
> +	res[0].end = pci_resource_end(pdev, 0);

What's wrong with pcim_iomap_regions()?

...

> +	ret = pci_read_config_byte(pdev, PCI_INTERRUPT_LINE, &v8);

What?!

What's wrong with pci_alloc_irq_vectors()?

> +
> +	if (ret == PCIBIOS_SUCCESSFUL) {
> +		res[1].start = v8;
> +		res[1].end = v8;
> +	}
> +
> +	ret = loongson_spi_init_master(dev, res);

Why not passing the remapped address and IRQ number instead?

> +	if (ret)
> +		dev_err(dev, "failed to initialize master\n");

	return dev_err_probe();

> +
> +err_out:

Completely useless. Return in-line.

> +	return ret;
> +}

...

> +static struct pci_device_id loongson_spi_devices[] = {
> +	{PCI_DEVICE(0x14, 0x7a0b)},
> +	{PCI_DEVICE(0x14, 0x7a1b)},

Can you define vendor ID in pci_ids.h?


> +	{0, 0, 0, 0, 0, 0, 0}

What is this? Why {} is not working for you?

> +};

> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (res == NULL) {

Why not using devm_platform_ioremap_resource()?

> +		dev_err(dev, "cannot get io resource memory\n");
> +		return -ENOENT;

	return dev_err_probe();

> +	}
> +
> +	ret = loongson_spi_init_master(dev, res);
> +	if (ret)
> +		dev_err(dev, "failed to initialize master\n");

Ditto.

...

> +static const struct of_device_id loongson_spi_id_table[] = {
> +	{ .compatible = "loongson,ls2k-spi", },

Inned comma is redundant.

> +	{ }
> +};

...

> +#ifndef __LINUX_SPI_LOONGSON_H
> +#define __LINUX_SPI_LOONGSON_H

Missing bits.h
Missing types.h
Missing declaration for msecs_to_jiffies()
Missing forward declarations for struct spi_master and struct device.
MIssing declaration for dev_pm_ops.


> +#define	LOONGSON_SPI_SPCR_REG	0x00
> +#define	LOONGSON_SPI_SPSR_REG	0x01
> +#define	LOONGSON_SPI_FIFO_REG	0x02
> +#define	LOONGSON_SPI_SPER_REG	0x03
> +#define	LOONGSON_SPI_PARA_REG	0x04
> +#define	LOONGSON_SPI_SFCS_REG	0x05
> +#define	LOONGSON_SPI_TIMI_REG	0x06
> +
> +/* Bits definition for Loongson SPI register */
> +#define	LOONGSON_SPI_PARA_MEM_EN	BIT(0)
> +#define	LOONGSON_SPI_SPSR_SPIF	BIT(7)
> +#define	LOONGSON_SPI_SPSR_WCOL	BIT(6)
> +#define	LOONGSON_SPI_SPCR_SPE	BIT(6)
> +
> +#define SPI_COMPLETION_TIMEOUT	msecs_to_jiffies(2000)
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
> +extern int loongson_spi_init_master(struct device *dev, struct resource *res);

No extern for the function declarations.

> +extern const struct dev_pm_ops loongson_spi_dev_pm_ops;

> +#endif /* __LINUX_SPI_LOONGSON_H */

-- 
With Best Regards,
Andy Shevchenko


