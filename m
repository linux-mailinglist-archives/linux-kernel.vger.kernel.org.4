Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F4F6FECBC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 09:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237126AbjEKHZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 03:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236758AbjEKHZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 03:25:12 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 518A2729E;
        Thu, 11 May 2023 00:24:57 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8CxPuu9llxkuKoHAA--.12843S3;
        Thu, 11 May 2023 15:18:21 +0800 (CST)
Received: from [10.20.42.35] (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dx87S7llxk_2dVAA--.20859S3;
        Thu, 11 May 2023 15:18:19 +0800 (CST)
Subject: Re: [PATCH v9 2/2] spi: loongson: add bus driver for the loongson spi
 controller
To:     andy.shevchenko@gmail.com
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, zhuyinbo@loongson.cn
References: <20230426071045.20753-1-zhuyinbo@loongson.cn>
 <20230426071045.20753-3-zhuyinbo@loongson.cn> <ZFkPZhF8QqScXAmH@surfacebook>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <049c871d-c658-24c1-91e6-701098f5fc28@loongson.cn>
Date:   Thu, 11 May 2023 15:18:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <ZFkPZhF8QqScXAmH@surfacebook>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dx87S7llxk_2dVAA--.20859S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW3tr4ruFW5CFyrKFWxJr1kXwb_yoWDWryxpF
        WkAa1UKFWxJr1xWrnFqF1kWF4jvry3J3WDta13XFWjkFyDZrn7G34UGF4fC393ZFW5ZFyx
        ZFy8Xw4kCan8JaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bxxFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487
        Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l42xK82IY6x
        8ErcxFaVAv8VWrMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4l
        x2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrw
        CI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI
        42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z2
        80aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUzgAwDUUUU
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2023/5/8 ÏÂÎç11:04, andy.shevchenko@gmail.com Ð´µÀ:
> Wed, Apr 26, 2023 at 03:10:45PM +0800, Yinbo Zhu kirjoitti:
>> This bus driver supports the Loongson spi hardware controller in the
>> Loongson platforms and supports to use DTS and PCI framework to
>> register spi device resources.
> 
> SPI

okay I got it.
> 
> ...
> 
>> +config SPI_LOONGSON_CORE
>> +	tristate "Loongson SPI Controller Core Driver Support"
> 
> Does it need to be visible to the user?

okay, I will set it invisible.
> 
>> +	depends on LOONGARCH || COMPILE_TEST
>> +	help
>> +	  This core driver supports the Loongson spi hardware controller in
>> +	  the Loongson platforms.
>> +	  Say Y or M here if you want to use the SPI controller on
>> +	  Loongson platform.
> 
> ...
> 
>> +config SPI_LOONGSON_PLATFORM
>> +	tristate "Loongson SPI Controller Platform Driver Support"
>> +	select SPI_LOONGSON_CORE
>> +	depends on OF && (LOONGARCH || COMPILE_TEST)
> 
> Is it really dependent to OF? Why?

Yes, because this driver need depend on device tree.
> 
>> +	help
>> +	  This bus driver supports the Loongson spi hardware controller in
>> +	  the Loongson platforms and supports to use DTS framework to
>> +	  register spi device resources.
>> +	  Say Y or M here if you want to use the SPI controller on
>> +	  Loongson platform.
> 
> ...
> 
>> +#include <linux/init.h>
>> +#include <linux/module.h>
>> +#include <linux/kernel.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/delay.h>
>> +#include <linux/err.h>
>> +#include <linux/spi/spi.h>
>> +#include <linux/clk.h>
>> +#include <linux/io.h>
> 
> Ordered?

okay, I got it.
> 
> ...
> 
>> +	if (loongson_spi->mode & SPI_NO_CS)
>> +		loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SFCS_REG, 0);
> 
> Missing {}

okay, I got it.
> 
>> +	else {
>> +		cs = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SFCS_REG)
>> +					   & ~(0x11 << spi->chip_select);
>> +		loongson_spi_write_reg(loongson_spi,
>> +				       LOONGSON_SPI_SFCS_REG,
>> +				       (val ? (0x11 << spi->chip_select) :
>> +				       (0x1 << spi->chip_select)) | cs);
> 
> Too many parentheses.
> 
>> +	}
> 
> ...
> 
>> +	const char rdiv[12] = {0, 1, 4, 2, 3, 5, 6, 7, 8, 9, 10, 11};
> 
> Oh, why?!

As you understand in another mail, you are right!

00 00  [0]  <= 2
00 01  [1]  <= 4
01 00  [2]  <= 8
00 10  [3]  <= 16
00 11  [4]  <= 32
01 01  [5]  <= 64
01 10  [6]  <= 128
01 11  [7]  <= 256
10 00  [8]  <= 512
10 01  [9]  <= 1024
10 10  [10]  <= 2048
10 11  [11]  <= 4096
> 
> ...
> 
>> +	if ((hz && loongson_spi->hz != hz) ||
>> +	    ((spi->mode ^ loongson_spi->mode) & (SPI_CPOL | SPI_CPHA))) {
>> +		div = DIV_ROUND_UP_ULL(loongson_spi->clk_rate, hz);
> 
>> +		if (div < 2)
>> +			div = 2;
>> +		if (div > 4096)
>> +			div = 4096;
> 
> NIH clamp_val()

okay, I will use it.
> 
>> +		bit = fls(div) - 1;
>> +		if ((1<<bit) == div)
>> +			bit--;
>> +		div_tmp = rdiv[bit];
> 
> I believe this can be optimized.

okay, I will apply your optimization advice in another mail for my
patch.
> 
>> +		dev_dbg(&spi->dev, "clk_rate = %llu hz = %d div_tmp = %d bit = %d\n",
>> +			loongson_spi->clk_rate, hz, div_tmp, bit);
>> +
>> +		loongson_spi->hz = hz;
>> +		loongson_spi->spcr = div_tmp & 3;
>> +		loongson_spi->sper = (div_tmp >> 2) & 3;
>> +		val = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPCR_REG);
>> +		val &= ~0xc;
> 
> GENMASK()
okay, I got it.
> 
>> +		if (spi->mode & SPI_CPOL)
>> +			val |= 8;
> 
> BIT()
okay, I got it.
> 
>> +		if (spi->mode & SPI_CPHA)
>> +			val |= 4;
> 
>> +		loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPCR_REG, (val & ~3) |
>> +				       loongson_spi->spcr);
>> +		val = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPER_REG);
>> +		loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPER_REG, (val & ~3) |
>> +				       loongson_spi->sper);
>> +		loongson_spi->mode &= SPI_NO_CS;
>> +		loongson_spi->mode |= spi->mode;
>> +	}
> 
> ...
> 
>> +		while ((loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPSR_REG) & 0x1) == 1 &&
>> +			time_after(timeout, jiffies))
>> +			cpu_relax();
> 
> iopoll.h has a suitable macro for this.
okay, I will use read_poll_timeout or similar api in iopoll.h for this.
> 
> ...
> 
>> +		while ((loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPSR_REG) & 0x1) == 1 &&
>> +			time_after(timeout, jiffies))
>> +			cpu_relax();
> 
> Ditto.
okay, I got it.
> 
> ...
> 
>> +	master = devm_spi_alloc_master(dev, sizeof(struct loongson_spi));
>> +	if (master == NULL) {
> 
>> +		dev_info(dev, "master allocation failed\n");
> 
> We do not issue a message for ENOMEM

I will remove the dmesg.
> 
>> +		return -ENOMEM;
>> +	}
> 
> ...
> 
>> +	master->dev.of_node = of_node_get(dev->of_node);
> 
> device_set_node()

okay, I got it.
> 
> ...
> 
>> +	spi->base = devm_ioremap(dev, res->start, resource_size(res));
> 
> Why not devm_ioremap_resource()?

I will use devm_platform_ioremap_resource as your low text advice and
there will be no needed for devm_ioremap_resource.
> 
> 
>> +	if (spi->base == NULL) {
>> +		dev_err(dev, "cannot map io\n");
>> +		return -ENXIO;
> 
> 	return dev_err_probe();
okay, I got it.
> 
>> +	}
> 
> ...
> 
>> +	clk = devm_clk_get(dev, NULL);
> 
> Can we hav
> 
>> +	if (!IS_ERR(clk))
> 
> Use _optional variant above instead of this.
> Do not forget about deferred probe.

I will use devm_clk_get_optional and dev_err_probe to replace above.
> 
>> +		spi->clk_rate = clk_get_rate(clk);
> 
> ...
> 
>> +	if (of_get_property(dev->of_node, "spi-nocs", NULL))
>> +		spi->mode |= SPI_NO_CS;
> 
> Don't we have something in the SPI core to handle this in a generic way?

The 2k500 has two type spi controller. one type was different other 
loongson-2 common spi. and other loongson-2 SoCs was only a common type
spi.

loongson-2 common type spi cs:
bit0: spi:csn_en0
bit4: spi_csn0
bit1: spi_csn_en1
bit5: spi_csn1
bit2: spi_csn_en2
bit6: spi_csn2
bit3: spi_csn_en3
bit7: spi_csn3

loongson-2 special type spi one cs:
bit0: spi_csn
bit1: spi_csn_en

The difference between the special type spi and common type spi not only
cs number but has register definition struct. The spi core seems unable
to use generic way to cover it.

and I found it has still has some issues that current code is compatible 
special type spi, so I will drop special type spi support and leave only
support for common type spi.  Support special type spi as needed in the
future.
> 
> ...
> 
> 
>> +EXPORT_SYMBOL_GPL(loongson_spi_init_master);
> 
> Please, use _NS variant.
> 
> ...
> 
>> +MODULE_DESCRIPTION("Loongson spi core driver");
> 
> SPI

okay, I got it.
> 
> ...
> 
>> +	struct resource res[2];
>> +	struct device *dev = &pdev->dev;
>> +
>> +	ret = pci_enable_device(pdev);
> 
> pcim_enable_device()

okay,  I got it.
> 
>> +	if (ret < 0) {
>> +		dev_err(dev, "cannot enable pci device\n");
>> +		goto err_out;
> 
> 	return dev_err_probe();

okay, I got it.
> 
>> +	}
>> +
>> +	ret = pci_request_region(pdev, 0, "loongson-spi io");
>> +	if (ret < 0) {
>> +		dev_err(dev, "cannot request region 0.\n");
>> +		goto err_out;
>> +	}
>> +
>> +	res[0].start = pci_resource_start(pdev, 0);
>> +	res[0].end = pci_resource_end(pdev, 0);
> 
> What's wrong with pcim_iomap_regions()?
No wrong, I don't notice it and I will use pcim_iomap_regions.
> 
> ...
> 
>> +	ret = pci_read_config_byte(pdev, PCI_INTERRUPT_LINE, &v8);
> 
> What?!
> 
> What's wrong with pci_alloc_irq_vectors()?

If the interupt is needed that I will use pci_alloc_irq_vectors.
currently, the driver is not using irq and I may  disacard
the parsing of interrupts.
> 
>> +
>> +	if (ret == PCIBIOS_SUCCESSFUL) {
>> +		res[1].start = v8;
>> +		res[1].end = v8;
>> +	}
>> +
>> +	ret = loongson_spi_init_master(dev, res);
> 
> Why not passing the remapped address and IRQ number instead?

okay I got it.
> 
>> +	if (ret)
>> +		dev_err(dev, "failed to initialize master\n");
> 
> 	return dev_err_probe();
> 
>> +
>> +err_out:
> 
> Completely useless. Return in-line.

I will remove the "err_out".
> 
>> +	return ret;
>> +}
> 
> ...
> 
>> +static struct pci_device_id loongson_spi_devices[] = {
>> +	{PCI_DEVICE(0x14, 0x7a0b)},
>> +	{PCI_DEVICE(0x14, 0x7a1b)},
> 
> Can you define vendor ID in pci_ids.h?

okay, I will add it into pci_ids.h.
> 
> 
>> +	{0, 0, 0, 0, 0, 0, 0}
> 
> What is this? Why {} is not working for you?
I will remove that.
> 
>> +};
> 
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	if (res == NULL) {
> 
> Why not using devm_platform_ioremap_resource()?
okay, I will use it.
> 
>> +		dev_err(dev, "cannot get io resource memory\n");
>> +		return -ENOENT;
> 
> 	return dev_err_probe();
okay, I got it.
> 
>> +	}
>> +
>> +	ret = loongson_spi_init_master(dev, res);
>> +	if (ret)
>> +		dev_err(dev, "failed to initialize master\n");
> 
> Ditto.
okay, I got it.
> 
> ...
> 
>> +static const struct of_device_id loongson_spi_id_table[] = {
>> +	{ .compatible = "loongson,ls2k-spi", },
> 
> Inned comma is redundant.
okay, I got it.
> 
>> +	{ }
>> +};
> 
> ...
> 
>> +#ifndef __LINUX_SPI_LOONGSON_H
>> +#define __LINUX_SPI_LOONGSON_H
> 
> Missing bits.h
> Missing types.h
> Missing declaration for msecs_to_jiffies()
> Missing forward declarations for struct spi_master and struct device.
> MIssing declaration for dev_pm_ops.

okay, I will add it.
> 
> 
>> +#define	LOONGSON_SPI_SPCR_REG	0x00
>> +#define	LOONGSON_SPI_SPSR_REG	0x01
>> +#define	LOONGSON_SPI_FIFO_REG	0x02
>> +#define	LOONGSON_SPI_SPER_REG	0x03
>> +#define	LOONGSON_SPI_PARA_REG	0x04
>> +#define	LOONGSON_SPI_SFCS_REG	0x05
>> +#define	LOONGSON_SPI_TIMI_REG	0x06
>> +
>> +/* Bits definition for Loongson SPI register */
>> +#define	LOONGSON_SPI_PARA_MEM_EN	BIT(0)
>> +#define	LOONGSON_SPI_SPSR_SPIF	BIT(7)
>> +#define	LOONGSON_SPI_SPSR_WCOL	BIT(6)
>> +#define	LOONGSON_SPI_SPCR_SPE	BIT(6)
>> +
>> +#define SPI_COMPLETION_TIMEOUT	msecs_to_jiffies(2000)
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
>> +extern int loongson_spi_init_master(struct device *dev, struct resource *res);
> 
> No extern for the function declarations.

okay, I got it.
> 
>> +extern const struct dev_pm_ops loongson_spi_dev_pm_ops;
> 
>> +#endif /* __LINUX_SPI_LOONGSON_H */
> 

