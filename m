Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5672370EFEA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 09:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240091AbjEXHw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 03:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232910AbjEXHwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 03:52:24 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E4A6E91;
        Wed, 24 May 2023 00:52:21 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8DxqvI0wm1kx1gAAA--.1050S3;
        Wed, 24 May 2023 15:52:20 +0800 (CST)
Received: from [10.20.42.35] (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxQbQywm1ku2pzAA--.61392S3;
        Wed, 24 May 2023 15:52:19 +0800 (CST)
Subject: Re: [PATCH v11 2/2] spi: loongson: add bus driver for the loongson
 spi controller
To:     andy.shevchenko@gmail.com
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, zhuyinbo@loongson.cn
References: <20230522071030.5193-1-zhuyinbo@loongson.cn>
 <20230522071030.5193-3-zhuyinbo@loongson.cn> <ZGy3b7ZfNwWoGDTu@surfacebook>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <35b0500c-d7fe-6479-eeff-d45bbf9a9426@loongson.cn>
Date:   Wed, 24 May 2023 15:52:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <ZGy3b7ZfNwWoGDTu@surfacebook>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxQbQywm1ku2pzAA--.61392S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW3AFyfGFy3ArW8CryrtF15CFg_yoW3JFW5pF
        48Aa15KFWSyr4Iyw18XFs5GF4Yqry3J3W7JFWav3y8Kr98Zw1xXa45KF1fCr4SvFZ5ZF1x
        ZFWUur4kCFs8C3DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bxkFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487
        Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l42xK82IY6x
        8ErcxFaVAv8VWrMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4l
        x2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrw
        CI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI
        42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z2
        80aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8c_-PUUUUU==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2023/5/23 ÏÂÎç8:54, andy.shevchenko@gmail.com Ð´µÀ:
> Mon, May 22, 2023 at 03:10:30PM +0800, Yinbo Zhu kirjoitti:
>> This bus driver supports the Loongson SPI hardware controller in the
>> Loongson platforms and supports to use DTS and PCI framework to
>> register SPI device resources.
> 
> It's polite to add reviewers of the previous versions to the Cc list.

okay, I got it.
> 
> ...
> 
>> +static void loongson_spi_set_clk(struct loongson_spi *loongson_spi, unsigned int hz)
>> +{
>> +	unsigned char val;
>> +	unsigned int div, div_tmp;
> 
>> +	const char rdiv[12] = {0, 1, 4, 2, 3, 5, 6, 7, 8, 9, 10, 11};
> 
> static?

okay, I will define "static const char rdiv".

> 
>> +
>> +	div = clamp_val(DIV_ROUND_UP_ULL(loongson_spi->clk_rate, hz), 2, 4096);
>> +	div_tmp = rdiv[fls(div - 1)];
>> +	loongson_spi->spcr = (div_tmp & GENMASK(1, 0)) >> 0;
>> +	loongson_spi->sper = (div_tmp & GENMASK(3, 2)) >> 2;
>> +	val = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPCR_REG);
>> +	loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPCR_REG, (val & ~3) |
>> +			       loongson_spi->spcr);
>> +	val = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPER_REG);
>> +	loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPER_REG, (val & ~3) |
>> +			       loongson_spi->sper);
>> +	loongson_spi->hz = hz;
>> +}
> 
> ...
> 
>> +static int loongson_spi_update_state(struct loongson_spi *loongson_spi,
>> +				struct spi_device *spi, struct spi_transfer *t)
>> +{
>> +	unsigned int hz;
>> +
>> +	if (t)
>> +		hz = t->speed_hz;
> 
> And if t is NULL? hz will be uninitialized. Don't you get a compiler warning?
> (Always test your code with `make W=1 ...`)

I alwasy use `make W=1` and I don't find any warnig, but that what you
said was right and I will initial hz.

> 
>> +	if (hz && loongson_spi->hz != hz)
>> +		loongson_spi_set_clk(loongson_spi, hz);
>> +
>> +	if ((spi->mode ^ loongson_spi->mode) & SPI_MODE_X_MASK)
>> +		loongson_spi_set_mode(loongson_spi, spi);
>> +
>> +	return 0;
>> +}
> 
> ...
> 
>> +	readb_poll_timeout(loongson_spi->base + LOONGSON_SPI_SPSR_REG, loongson_spi->spsr,
>> +			   (loongson_spi->spsr & 0x1) != 1, 1, MSEC_PER_SEC);
> 
> Wouldn't be better to use ' == 0' in the conditional? Or if you think your
> approach is better (to show the exact expectation) the definition of the bit 0
> might help
> 
> #define LOONGSON_... BIT(0)

okay, I got it.
> 
> 
> 	readb_poll_timeout(loongson_spi->base + LOONGSON_SPI_SPSR_REG, loongson_spi->spsr,
> 			   (loongson_spi->spsr & LOONGSON_...) != LOONGSON_...,
> 			   1, MSEC_PER_SEC);
> 
> ...
> 
>> +	do {
>> +		if (loongson_spi_write_read_8bit(spi, &tx, &rx, count) < 0)
> 
>> +			goto out;
> 
> 		break;
> 
>> +		count--;
>> +	} while (count);
> 
> 	} while (--count);
> 
> ?

okay, I got it.

> 
>> +out:
>> +	return xfer->len - count;
> 
> Shouldn't you return an error code if the write failed?

okay, I got it. I will add a error code for return when write failed.

> 
> ...
> 
>> +	master = devm_spi_alloc_master(dev, sizeof(struct loongson_spi));
> 
>> +	if (master == NULL)
> 
> 	if (!master)
> 
>> +		return -ENOMEM;
> 
> Why do you use deprecated naming? Can you use spi_controller* instead of
> spi_master* in all cases?


It seems was a personal code style issue and I don't find the
differences between spi_controller and spi_master, Using spi_controller*
is also acceptable to me and I will use spi_controller* instead of
spi_master* in all cases.


> 
> ...
> 
>> +	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
> 
> 	= SPI_MODE_X_MASK | SPI_CS_HIGH;
> 
> ...
> 
>> +	clk = devm_clk_get_optional(dev, NULL);
>> +	if (!IS_ERR(clk))
>> +		spi->clk_rate = clk_get_rate(clk);
> 
>> +	else
> 
> Redundant. Just check for the error first as it's very usual pattern in the
> Linux kernel.

Like below ?

         clk = devm_clk_get_optional(dev, NULL);
-       if (!IS_ERR(clk))
-               spi->clk_rate = clk_get_rate(clk);
-       else
+       if (IS_ERR(clk))
                 return dev_err_probe(dev, PTR_ERR(clk), "unable to get 
clock\n");

+       spi->clk_rate = clk_get_rate(clk);
         loongson_spi_reginit(spi);


> 
>> +		return dev_err_probe(dev, PTR_ERR(clk), "unable to get clock\n");
> 
> ...
> 
>> +static void loongson_spi_pci_unregister(struct pci_dev *pdev)
>> +{
> 
>> +	pcim_iounmap_regions(pdev, BIT(0));
> 
> Not needed due to 'm' in the API name, which means "managed".

> 
>> +	pci_disable_device(pdev);
> 
> This is simply wrong. We don't do explicit clean up for managed resources.
> 
>> +}
> 
> That said, drop the ->remove() completely.

okay,  I will drop the ->remove() completely.
> 
> ...
> 
>> +static struct pci_device_id loongson_spi_devices[] = {
>> +	{ PCI_DEVICE(PCI_VENDOR_ID_LOONGSON, 0x7a0b) },
>> +	{ PCI_DEVICE(PCI_VENDOR_ID_LOONGSON, 0x7a1b) },
>> +	{ },
> 
> No comma for the terminator entry. It's by definition "terminating" something.

okay, I got it.
> 
>> +};
> 
> ...
> 
>> +#include <linux/of.h>
> 
> There is no user of this header. Please, replace with what actually is being
> used (presumably mod_devicetable.h and maybe others).
> 

okay, I got it.

>> +#include <linux/platform_device.h>
>> +
>> +#include "spi-loongson.h"
>> +
>> +static int loongson_spi_platform_probe(struct platform_device *pdev)
>> +{
>> +	int ret;
>> +	void __iomem *reg_base;
>> +	struct device *dev = &pdev->dev;
>> +
>> +	reg_base = devm_platform_ioremap_resource(pdev, 0);
>> +	if (IS_ERR(reg_base))
>> +		return PTR_ERR(reg_base);
>> +
>> +	ret = loongson_spi_init_master(dev, reg_base);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "failed to initialize master\n");
>> +
>> +	return ret;
> 
> 	return 0;

It seems was more appropriate that initialize ret then return ret.
Do you think so ?

> 
>> +}
> 
> ...
> 
>> +#ifndef __LINUX_SPI_LOONGSON_H
>> +#define __LINUX_SPI_LOONGSON_H
>> +
>> +#include <linux/bits.h>
> 
>> +#include <linux/device.h>
> 
> This header is not used.

okay, I got it.
> 
>> +#include <linux/pm.h>
> 
>> +#include <linux/spi/spi.h>
> 
> This neither.

That other .c file seems to need it and I will move it to other .c
code file.
> 
>> +#include <linux/types.h>
> 
> 
> For them use forward declarations
> 
> struct device;
> struct spi_controller;
> 
> The rest of the inclusions is correct.

okay, I got it.
> 
> ...
> 
>> +#define	LOONGSON_SPI_SPCR_REG	0x00
>> +#define	LOONGSON_SPI_SPSR_REG	0x01
>> +#define	LOONGSON_SPI_FIFO_REG	0x02
>> +#define	LOONGSON_SPI_SPER_REG	0x03
>> +#define	LOONGSON_SPI_PARA_REG	0x04
>> +#define	LOONGSON_SPI_SFCS_REG	0x05
>> +#define	LOONGSON_SPI_TIMI_REG	0x06
> 
> Where is this used outside of the main driver?

These definitions are only used in core.c

> 
>> +/* Bits definition for Loongson SPI register */
>> +#define	LOONGSON_SPI_PARA_MEM_EN	BIT(0)
>> +#define	LOONGSON_SPI_SPCR_CPHA	BIT(2)
>> +#define	LOONGSON_SPI_SPCR_CPOL	BIT(3)
>> +#define	LOONGSON_SPI_SPCR_SPE	BIT(6)
>> +#define	LOONGSON_SPI_SPSR_WCOL	BIT(6)
>> +#define	LOONGSON_SPI_SPSR_SPIF	BIT(7)
>> +
>> +struct loongson_spi {
>> +	struct	spi_master	*master;
>> +	void __iomem		*base;
>> +	int			cs_active;
>> +	unsigned int		hz;
>> +	unsigned char		spcr;
>> +	unsigned char		sper;
>> +	unsigned char		spsr;
>> +	unsigned char		para;
>> +	unsigned char		sfcs;
>> +	unsigned char		timi;
>> +	unsigned int		mode;
>> +	u64			clk_rate;
>> +};
>> +
>> +int loongson_spi_init_master(struct device *dev, void __iomem *reg);
>> +extern const struct dev_pm_ops loongson_spi_dev_pm_ops;
>> +#endif /* __LINUX_SPI_LOONGSON_H */
> 

