Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB387062A3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 10:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjEQIU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 04:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjEQIUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 04:20:23 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C88FE10D4;
        Wed, 17 May 2023 01:20:14 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8Bxa+o8jmRkTm4JAA--.16273S3;
        Wed, 17 May 2023 16:20:12 +0800 (CST)
Received: from [10.20.42.35] (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxRrU6jmRkhG9lAA--.42114S3;
        Wed, 17 May 2023 16:20:10 +0800 (CST)
Subject: Re: [PATCH v10 2/2] spi: loongson: add bus driver for the loongson
 spi controller
To:     "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Jianmin Lv <lvjianmin@loongson.cn>,
        "wanghongliang@loongson.cn" <wanghongliang@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>,
        "loongson-kernel@lists.loongnix.cn" 
        <loongson-kernel@lists.loongnix.cn>,
        "git (AMD-Xilinx)" <git@amd.com>, zhuyinbo@loongson.cn
References: <20230516131224.25481-1-zhuyinbo@loongson.cn>
 <20230516131224.25481-3-zhuyinbo@loongson.cn>
 <BN7PR12MB2802A6A9106C50F919693E4BDC7E9@BN7PR12MB2802.namprd12.prod.outlook.com>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <cf7a95c4-6a1e-9e7c-4d15-104435a98b5c@loongson.cn>
Date:   Wed, 17 May 2023 16:20:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <BN7PR12MB2802A6A9106C50F919693E4BDC7E9@BN7PR12MB2802.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxRrU6jmRkhG9lAA--.42114S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvAXoWfXw1DXw45tw4xCr47uFW5Awb_yoW8ur4fKo
        WfXFn7Xr48ur1UGF1jqryFqr47Xa45Wr4qyws3A34kJa15ta4DGr98JrW7CF48u3W3JFy7
        CFyfGFW8KF4Igrs5n29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXasCq-sGcSsGvf
        J3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnRJU
        UUB01xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFV
        AK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2
        z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr
        1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkE
        cVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F4
        0Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC
        6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x
        0EwIxGrwCF04k20xvE74AGY7Cv6cx26rWl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xF
        xVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWw
        C2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_
        JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJV
        WUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIY
        CTnIWIevJa73UjIFyTuYvjxUcOJ5UUUUU
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2023/5/17 ÏÂÎç12:55, Mahapatra, Amit Kumar Ð´µÀ:
> Hello,
> 
>> -----Original Message-----
>> From: Yinbo Zhu <zhuyinbo@loongson.cn>
>> Sent: Tuesday, May 16, 2023 6:42 PM
>> To: Mark Brown <broonie@kernel.org>; Rob Herring <robh+dt@kernel.org>;
>> Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>; linux-
>> spi@vger.kernel.org; devicetree@vger.kernel.org; linux-
>> kernel@vger.kernel.org
>> Cc: Jianmin Lv <lvjianmin@loongson.cn>; wanghongliang@loongson.cn; Liu
>> Peibao <liupeibao@loongson.cn>; loongson-kernel@lists.loongnix.cn; Yinbo
>> Zhu <zhuyinbo@loongson.cn>
>> Subject: [PATCH v10 2/2] spi: loongson: add bus driver for the loongson spi
>> controller
>>
>> CAUTION: This message has originated from an External Source. Please use
>> proper judgment and caution when opening attachments, clicking links, or
>> responding to this email.
>>
>>
>> This bus driver supports the Loongson SPI hardware controller in the Loongson
>> platforms and supports to use DTS and PCI framework to register SPI device
>> resources.
>>
>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
>> ---
>>   MAINTAINERS                     |   4 +
>>   drivers/spi/Kconfig             |  26 +++
>>   drivers/spi/Makefile            |   3 +
>>   drivers/spi/spi-loongson-core.c | 279 ++++++++++++++++++++++++++++++++
>> drivers/spi/spi-loongson-pci.c  |  61 +++++++  drivers/spi/spi-loongson-plat.c |
>> 46 ++++++
>>   drivers/spi/spi-loongson.h      |  47 ++++++
>>   7 files changed, 466 insertions(+)
>>   create mode 100644 drivers/spi/spi-loongson-core.c  create mode 100644
>> drivers/spi/spi-loongson-pci.c  create mode 100644 drivers/spi/spi-loongson-
>> plat.c  create mode 100644 drivers/spi/spi-loongson.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index dfcc5db4bbc0..ab08aba965f3 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -12218,6 +12218,10 @@ M:     Yinbo Zhu <zhuyinbo@loongson.cn>
>>   L:     linux-spi@vger.kernel.org
>>   S:     Maintained
>>   F:     Documentation/devicetree/bindings/spi/loongson,ls2k-spi.yaml
>> +F:     drivers/spi/spi-loongson-core.c
>> +F:     drivers/spi/spi-loongson-pci.c
>> +F:     drivers/spi/spi-loongson-plat.c
>> +F:     drivers/spi/spi-loongson.h
>>
>>   LSILOGIC MPT FUSION DRIVERS (FC/SAS/SPI)
>>   M:     Sathya Prakash <sathya.prakash@broadcom.com>
>> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig index
>> 3de2ebe8294a..6b953904792e 100644
>> --- a/drivers/spi/Kconfig
>> +++ b/drivers/spi/Kconfig
>> @@ -516,6 +516,32 @@ config SPI_LM70_LLP
>>            which interfaces to an LM70 temperature sensor using
>>            a parallel port.
>>
>> +config SPI_LOONGSON_CORE
>> +       tristate
>> +       depends on LOONGARCH || COMPILE_TEST
>> +
>> +config SPI_LOONGSON_PCI
>> +       tristate "Loongson SPI Controller PCI Driver Support"
>> +       select SPI_LOONGSON_CORE
>> +       depends on PCI && (LOONGARCH || COMPILE_TEST)
>> +       help
>> +         This bus driver supports the Loongson SPI hardware controller in
>> +         the Loongson platforms and supports to use PCI framework to
>> +         register SPI device resources.
>> +         Say Y or M here if you want to use the SPI controller on
>> +         Loongson platform.
>> +
>> +config SPI_LOONGSON_PLATFORM
>> +       tristate "Loongson SPI Controller Platform Driver Support"
>> +       select SPI_LOONGSON_CORE
>> +       depends on OF && (LOONGARCH || COMPILE_TEST)
>> +       help
>> +         This bus driver supports the Loongson SPI hardware controller in
>> +         the Loongson platforms and supports to use DTS framework to
>> +         register SPI device resources.
>> +         Say Y or M here if you want to use the SPI controller on
>> +         Loongson platform.
>> +
>>   config SPI_LP8841_RTC
>>          tristate "ICP DAS LP-8841 SPI Controller for RTC"
>>          depends on MACH_PXA27X_DT || COMPILE_TEST diff --git
>> a/drivers/spi/Makefile b/drivers/spi/Makefile index
>> 28c4817a8a74..3e933064d237 100644
>> --- a/drivers/spi/Makefile
>> +++ b/drivers/spi/Makefile
>> @@ -71,6 +71,9 @@ obj-$(CONFIG_SPI_INTEL_PLATFORM)      += spi-intel-
>> platform.o
>>   obj-$(CONFIG_SPI_LANTIQ_SSC)           += spi-lantiq-ssc.o
>>   obj-$(CONFIG_SPI_JCORE)                        += spi-jcore.o
>>   obj-$(CONFIG_SPI_LM70_LLP)             += spi-lm70llp.o
>> +obj-$(CONFIG_SPI_LOONGSON_CORE)                += spi-loongson-core.o
>> +obj-$(CONFIG_SPI_LOONGSON_PCI)         += spi-loongson-pci.o
>> +obj-$(CONFIG_SPI_LOONGSON_PLATFORM)    += spi-loongson-plat.o
>>   obj-$(CONFIG_SPI_LP8841_RTC)           += spi-lp8841-rtc.o
>>   obj-$(CONFIG_SPI_MESON_SPICC)          += spi-meson-spicc.o
>>   obj-$(CONFIG_SPI_MESON_SPIFC)          += spi-meson-spifc.o
>> diff --git a/drivers/spi/spi-loongson-core.c b/drivers/spi/spi-loongson-core.c
>> new file mode 100644 index 000000000000..435a58b0d9da
>> --- /dev/null
>> +++ b/drivers/spi/spi-loongson-core.c
>> @@ -0,0 +1,279 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +// Loongson SPI Support
>> +// Copyright (C) 2023 Loongson Technology Corporation Limited
>> +
>> +#include <linux/clk.h>
>> +#include <linux/delay.h>
>> +#include <linux/err.h>
>> +#include <linux/init.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/io.h>
>> +#include <linux/iopoll.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +
>> +#include "spi-loongson.h"
>> +
>> +static inline void loongson_spi_write_reg(struct loongson_spi *spi, unsigned
>> char reg,
>> +                                         unsigned char data) {
>> +       writeb(data, spi->base + reg);
>> +}
>> +
>> +static inline char loongson_spi_read_reg(struct loongson_spi *spi,
>> +unsigned char reg) {
>> +       return readb(spi->base + reg);
>> +}
>> +
>> +static void loongson_spi_set_cs(struct spi_device *spi, bool val) {
>> +       int cs;
>> +       struct loongson_spi *loongson_spi =
>> +spi_master_get_devdata(spi->master);
>> +
>> +       cs = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SFCS_REG)
>> +                                          & ~(0x11 << spi->chip_select);
> 
> New set/get APIs for accessing spi->chip_select were introduced by
> https://github.com/torvalds/linux/commit/303feb3cc06ac0665d0ee9c1414941200e60e8a3
> please use these APIs instead of accessing spi->chip_select directly.

okay, I got it. I will use spi_get_chipselect() to replace all 
spi->chip_select in spi driver.

Thanks.

> 
>> +       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SFCS_REG,
>> +                                      (val ? (0x11 << spi->chip_select) :
> 
> Same here
>> +                                      (0x1 << spi->chip_select)) | cs);
> 
> Same here
>> +}
>> +
>> +static void loongson_spi_set_clk(struct loongson_spi *loongson_spi,
>> +unsigned int hz) {
>> +       unsigned char val;
>> +       unsigned int div, div_tmp;
>> +       const char rdiv[12] = {0, 1, 4, 2, 3, 5, 6, 7, 8, 9, 10, 11};
>> +
>> +       div = clamp_val(DIV_ROUND_UP_ULL(loongson_spi->clk_rate, hz), 2,
>> 4096);
>> +       div_tmp = rdiv[fls(div - 1)];
>> +       loongson_spi->spcr = (div_tmp & GENMASK(1, 0)) >> 0;
>> +       loongson_spi->sper = (div_tmp & GENMASK(3, 2)) >> 2;
>> +       val = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPCR_REG);
>> +       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPCR_REG, (val &
>> ~3) |
>> +                              loongson_spi->spcr);
>> +       val = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPER_REG);
>> +       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPER_REG, (val &
>> ~3) |
>> +                              loongson_spi->sper);
>> +       loongson_spi->hz = hz;
>> +}
>> +
>> +static void loongson_spi_set_mode(struct loongson_spi *loongson_spi,
>> +                                 struct spi_device *spi) {
>> +       unsigned char val;
>> +
>> +       val = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPCR_REG);
>> +       val &= ~(LOONGSON_SPI_SPCR_CPOL | LOONGSON_SPI_SPCR_CPHA);
>> +       if (spi->mode & SPI_CPOL)
>> +               val |= LOONGSON_SPI_SPCR_CPOL;
>> +       if (spi->mode & SPI_CPHA)
>> +               val |= LOONGSON_SPI_SPCR_CPHA;
>> +
>> +       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPCR_REG, val);
>> +       loongson_spi->mode |= spi->mode; }
>> +
>> +static int loongson_spi_update_state(struct loongson_spi *loongson_spi,
>> +                               struct spi_device *spi, struct
>> +spi_transfer *t) {
>> +       unsigned int hz;
>> +
>> +       if (t)
>> +               hz = t->speed_hz;
>> +
>> +       if (hz && loongson_spi->hz != hz)
>> +               loongson_spi_set_clk(loongson_spi, hz);
>> +
>> +       if ((spi->mode ^ loongson_spi->mode) & SPI_MODE_X_MASK)
>> +               loongson_spi_set_mode(loongson_spi, spi);
>> +
>> +       return 0;
>> +}
>> +
>> +static int loongson_spi_setup(struct spi_device *spi) {
>> +       struct loongson_spi *loongson_spi;
>> +
>> +       loongson_spi = spi_master_get_devdata(spi->master);
>> +       if (spi->bits_per_word % 8)
>> +               return -EINVAL;
>> +
>> +       if (spi->chip_select >= spi->master->num_chipselect)
> 
> Same here
> 
> Regards,
> Amit
> 
>> +               return -EINVAL;
>> +
>> +       loongson_spi->hz = 0;
>> +       loongson_spi_set_cs(spi, 1);
>> +
>> +       return 0;
>> +}
>> +
>> +static int loongson_spi_write_read_8bit(struct spi_device *spi, const u8
>> **tx_buf,
>> +                                       u8 **rx_buf, unsigned int num) {
>> +       struct loongson_spi *loongson_spi =
>> +spi_master_get_devdata(spi->master);
>> +
>> +       if (tx_buf && *tx_buf)
>> +               loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_FIFO_REG,
>> *((*tx_buf)++));
>> +       else
>> +               loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_FIFO_REG,
>> 0);
>> +       readb_poll_timeout(loongson_spi->base + LOONGSON_SPI_SPSR_REG,
>> loongson_spi->spsr,
>> +                          (loongson_spi->spsr & 0x1) != 1, 1,
>> + MSEC_PER_SEC);
>> +
>> +       if (rx_buf && *rx_buf)
>> +               *(*rx_buf)++ = loongson_spi_read_reg(loongson_spi,
>> LOONGSON_SPI_FIFO_REG);
>> +       else
>> +               loongson_spi_read_reg(loongson_spi,
>> + LOONGSON_SPI_FIFO_REG);
>> +
>> +       return 0;
>> +}
>> +
>> +static unsigned int loongson_spi_write_read(struct spi_device *spi,
>> +struct spi_transfer *xfer) {
>> +       unsigned int count;
>> +       const u8 *tx = xfer->tx_buf;
>> +       u8 *rx = xfer->rx_buf;
>> +
>> +       count = xfer->len;
>> +
>> +       do {
>> +               if (loongson_spi_write_read_8bit(spi, &tx, &rx, count) < 0)
>> +                       goto out;
>> +               count--;
>> +       } while (count);
>> +
>> +out:
>> +       return xfer->len - count;
>> +}
>> +
>> +static int loongson_spi_prepare_message(struct spi_controller *ctlr,
>> +struct spi_message *m) {
>> +       struct loongson_spi *loongson_spi =
>> +spi_controller_get_devdata(ctlr);
>> +
>> +       loongson_spi->para = loongson_spi_read_reg(loongson_spi,
>> LOONGSON_SPI_PARA_REG);
>> +       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_PARA_REG,
>> + loongson_spi->para & ~1);
>> +
>> +       return 0;
>> +}
>> +
>> +static int loongson_spi_transfer_one(struct spi_controller *ctrl, struct
>> spi_device *spi,
>> +                                    struct spi_transfer *xfer) {
>> +       struct loongson_spi *loongson_spi =
>> +spi_master_get_devdata(spi->master);
>> +
>> +       loongson_spi_update_state(loongson_spi, spi, xfer);
>> +       if (xfer->len)
>> +               xfer->len = loongson_spi_write_read(spi, xfer);
>> +
>> +       return 0;
>> +}
>> +
>> +static int loongson_spi_unprepare_message(struct spi_controller *ctrl,
>> +struct spi_message *m) {
>> +       struct loongson_spi *loongson_spi =
>> +spi_controller_get_devdata(ctrl);
>> +
>> +       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_PARA_REG,
>> + loongson_spi->para);
>> +
>> +       return 0;
>> +}
>> +
>> +static void loongson_spi_reginit(struct loongson_spi *loongson_spi_dev)
>> +{
>> +       unsigned char val;
>> +
>> +       val = loongson_spi_read_reg(loongson_spi_dev,
>> LOONGSON_SPI_SPCR_REG);
>> +       val &= ~LOONGSON_SPI_SPCR_SPE;
>> +       loongson_spi_write_reg(loongson_spi_dev, LOONGSON_SPI_SPCR_REG,
>> + val);
>> +
>> +       loongson_spi_write_reg(loongson_spi_dev, LOONGSON_SPI_SPSR_REG,
>> +                              (LOONGSON_SPI_SPSR_SPIF |
>> + LOONGSON_SPI_SPSR_WCOL));
>> +
>> +       val = loongson_spi_read_reg(loongson_spi_dev,
>> LOONGSON_SPI_SPCR_REG);
>> +       val |= LOONGSON_SPI_SPCR_SPE;
>> +       loongson_spi_write_reg(loongson_spi_dev, LOONGSON_SPI_SPCR_REG,
>> +val); }
>> +
>> +int loongson_spi_init_master(struct device *dev, void __iomem *regs) {
>> +       struct spi_master *master;
>> +       struct loongson_spi *spi;
>> +       struct clk *clk;
>> +
>> +       master = devm_spi_alloc_master(dev, sizeof(struct loongson_spi));
>> +       if (master == NULL)
>> +               return -ENOMEM;
>> +
>> +       master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
>> +       master->setup = loongson_spi_setup;
>> +       master->prepare_message = loongson_spi_prepare_message;
>> +       master->transfer_one = loongson_spi_transfer_one;
>> +       master->unprepare_message = loongson_spi_unprepare_message;
>> +       master->set_cs = loongson_spi_set_cs;
>> +       master->num_chipselect = 4;
>> +       device_set_node(&master->dev, dev_fwnode(dev));
>> +       dev_set_drvdata(dev, master);
>> +
>> +       spi = spi_master_get_devdata(master);
>> +       spi->base = regs;
>> +       spi->master = master;
>> +
>> +       clk = devm_clk_get_optional(dev, NULL);
>> +       if (!IS_ERR(clk))
>> +               spi->clk_rate = clk_get_rate(clk);
>> +       else
>> +               return dev_err_probe(dev, PTR_ERR(clk), "unable to get
>> + clock\n");
>> +
>> +       loongson_spi_reginit(spi);
>> +
>> +       spi->mode = 0;
>> +
>> +       return devm_spi_register_master(dev, master); }
>> +EXPORT_SYMBOL_NS_GPL(loongson_spi_init_master,
>> SPI_LOONGSON_CORE);
>> +
>> +static int __maybe_unused loongson_spi_suspend(struct device *dev) {
>> +       struct loongson_spi *loongson_spi;
>> +       struct spi_master *master;
>> +
>> +       master = dev_get_drvdata(dev);
>> +       spi_master_suspend(master);
>> +
>> +       loongson_spi = spi_master_get_devdata(master);
>> +
>> +       loongson_spi->spcr = loongson_spi_read_reg(loongson_spi,
>> LOONGSON_SPI_SPCR_REG);
>> +       loongson_spi->sper = loongson_spi_read_reg(loongson_spi,
>> LOONGSON_SPI_SPER_REG);
>> +       loongson_spi->spsr = loongson_spi_read_reg(loongson_spi,
>> LOONGSON_SPI_SPSR_REG);
>> +       loongson_spi->para = loongson_spi_read_reg(loongson_spi,
>> LOONGSON_SPI_PARA_REG);
>> +       loongson_spi->sfcs = loongson_spi_read_reg(loongson_spi,
>> LOONGSON_SPI_SFCS_REG);
>> +       loongson_spi->timi = loongson_spi_read_reg(loongson_spi,
>> + LOONGSON_SPI_TIMI_REG);
>> +
>> +       return 0;
>> +}
>> +
>> +static int __maybe_unused loongson_spi_resume(struct device *dev) {
>> +       struct loongson_spi *loongson_spi;
>> +       struct spi_master *master;
>> +
>> +       master = dev_get_drvdata(dev);
>> +       loongson_spi = spi_master_get_devdata(master);
>> +
>> +       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPCR_REG,
>> loongson_spi->spcr);
>> +       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPER_REG,
>> loongson_spi->sper);
>> +       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPSR_REG,
>> loongson_spi->spsr);
>> +       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_PARA_REG,
>> loongson_spi->para);
>> +       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SFCS_REG,
>> loongson_spi->sfcs);
>> +       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_TIMI_REG,
>> + loongson_spi->timi);
>> +
>> +       spi_master_resume(master);
>> +
>> +       return 0;
>> +}
>> +
>> +const struct dev_pm_ops loongson_spi_dev_pm_ops = {
>> +       .suspend = loongson_spi_suspend,
>> +       .resume = loongson_spi_resume,
>> +};
>> +EXPORT_SYMBOL_NS_GPL(loongson_spi_dev_pm_ops,
>> SPI_LOONGSON_CORE);
>> +
>> +MODULE_DESCRIPTION("Loongson SPI core driver");
>> MODULE_LICENSE("GPL");
>> diff --git a/drivers/spi/spi-loongson-pci.c b/drivers/spi/spi-loongson-pci.c new
>> file mode 100644 index 000000000000..c351a689150a
>> --- /dev/null
>> +++ b/drivers/spi/spi-loongson-pci.c
>> @@ -0,0 +1,61 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +// PCI interface driver for Loongson SPI Support // Copyright (C) 2023
>> +Loongson Technology Corporation Limited
>> +
>> +#include <linux/pci.h>
>> +
>> +#include "spi-loongson.h"
>> +
>> +static int loongson_spi_pci_register(struct pci_dev *pdev,
>> +                       const struct pci_device_id *ent) {
>> +       int ret;
>> +       void __iomem *reg_base;
>> +       struct device *dev = &pdev->dev;
>> +       int pci_bar = 0;
>> +
>> +       ret = pcim_enable_device(pdev);
>> +       if (ret < 0)
>> +               return dev_err_probe(dev, ret, "cannot enable pci
>> + device\n");
>> +
>> +       ret = pcim_iomap_regions(pdev, BIT(pci_bar), pci_name(pdev));
>> +       if (ret)
>> +               return dev_err_probe(dev, ret, "failed to request and
>> + remap memory\n");
>> +
>> +       reg_base = pcim_iomap_table(pdev)[pci_bar];
>> +
>> +       ret = loongson_spi_init_master(dev, reg_base);
>> +       if (ret)
>> +               return dev_err_probe(dev, ret, "failed to initialize
>> + master\n");
>> +
>> +       return 0;
>> +}
>> +
>> +static void loongson_spi_pci_unregister(struct pci_dev *pdev) {
>> +       pcim_iounmap_regions(pdev, BIT(0));
>> +       pci_disable_device(pdev);
>> +}
>> +
>> +static struct pci_device_id loongson_spi_devices[] = {
>> +       { PCI_DEVICE(PCI_VENDOR_ID_LOONGSON, 0x7a0b) },
>> +       { PCI_DEVICE(PCI_VENDOR_ID_LOONGSON, 0x7a1b) },
>> +       { },
>> +};
>> +MODULE_DEVICE_TABLE(pci, loongson_spi_devices);
>> +
>> +static struct pci_driver loongson_spi_pci_driver = {
>> +       .name       = "loongson-spi-pci",
>> +       .id_table   = loongson_spi_devices,
>> +       .probe      = loongson_spi_pci_register,
>> +       .remove     = loongson_spi_pci_unregister,
>> +       .driver = {
>> +               .bus = &pci_bus_type,
>> +               .pm = &loongson_spi_dev_pm_ops,
>> +       },
>> +};
>> +module_pci_driver(loongson_spi_pci_driver);
>> +
>> +MODULE_DESCRIPTION("Loongson spi pci driver"); MODULE_LICENSE("GPL");
>> +MODULE_IMPORT_NS(SPI_LOONGSON_CORE);
>> diff --git a/drivers/spi/spi-loongson-plat.c b/drivers/spi/spi-loongson-plat.c
>> new file mode 100644 index 000000000000..2e0388d84044
>> --- /dev/null
>> +++ b/drivers/spi/spi-loongson-plat.c
>> @@ -0,0 +1,46 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +// Platform driver for Loongson SPI Support // Copyright (C) 2023
>> +Loongson Technology Corporation Limited
>> +
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +
>> +#include "spi-loongson.h"
>> +
>> +static int loongson_spi_platform_probe(struct platform_device *pdev) {
>> +       int ret;
>> +       void __iomem *reg_base;
>> +       struct device *dev = &pdev->dev;
>> +
>> +       reg_base = devm_platform_ioremap_resource(pdev, 0);
>> +       if (IS_ERR(reg_base))
>> +               return PTR_ERR(reg_base);
>> +
>> +       ret = loongson_spi_init_master(dev, reg_base);
>> +       if (ret)
>> +               return dev_err_probe(dev, ret, "failed to initialize
>> + master\n");
>> +
>> +       return ret;
>> +}
>> +
>> +static const struct of_device_id loongson_spi_id_table[] = {
>> +       { .compatible = "loongson,ls2k-spi" },
>> +       { }
>> +};
>> +MODULE_DEVICE_TABLE(of, loongson_spi_id_table);
>> +
>> +static struct platform_driver loongson_spi_plat_driver = {
>> +       .probe = loongson_spi_platform_probe,
>> +       .driver = {
>> +               .name   = "loongson-spi",
>> +               .bus = &platform_bus_type,
>> +               .pm = &loongson_spi_dev_pm_ops,
>> +               .of_match_table = loongson_spi_id_table,
>> +       },
>> +};
>> +module_platform_driver(loongson_spi_plat_driver);
>> +
>> +MODULE_DESCRIPTION("Loongson spi platform driver");
>> +MODULE_LICENSE("GPL"); MODULE_IMPORT_NS(SPI_LOONGSON_CORE);
>> diff --git a/drivers/spi/spi-loongson.h b/drivers/spi/spi-loongson.h new file
>> mode 100644 index 000000000000..5dca9750efa3
>> --- /dev/null
>> +++ b/drivers/spi/spi-loongson.h
>> @@ -0,0 +1,47 @@
>> +/* SPDX-License-Identifier: GPL-2.0+ */
>> +/* Header File for Loongson SPI Driver. */
>> +/* Copyright (C) 2023 Loongson Technology Corporation Limited */
>> +
>> +#ifndef __LINUX_SPI_LOONGSON_H
>> +#define __LINUX_SPI_LOONGSON_H
>> +
>> +#include <linux/bits.h>
>> +#include <linux/device.h>
>> +#include <linux/pm.h>
>> +#include <linux/spi/spi.h>
>> +#include <linux/types.h>
>> +
>> +#define        LOONGSON_SPI_SPCR_REG   0x00
>> +#define        LOONGSON_SPI_SPSR_REG   0x01
>> +#define        LOONGSON_SPI_FIFO_REG   0x02
>> +#define        LOONGSON_SPI_SPER_REG   0x03
>> +#define        LOONGSON_SPI_PARA_REG   0x04
>> +#define        LOONGSON_SPI_SFCS_REG   0x05
>> +#define        LOONGSON_SPI_TIMI_REG   0x06
>> +
>> +/* Bits definition for Loongson SPI register */
>> +#define        LOONGSON_SPI_PARA_MEM_EN        BIT(0)
>> +#define        LOONGSON_SPI_SPCR_CPHA  BIT(2)
>> +#define        LOONGSON_SPI_SPCR_CPOL  BIT(3)
>> +#define        LOONGSON_SPI_SPCR_SPE   BIT(6)
>> +#define        LOONGSON_SPI_SPSR_WCOL  BIT(6)
>> +#define        LOONGSON_SPI_SPSR_SPIF  BIT(7)
>> +
>> +struct loongson_spi {
>> +       struct  spi_master      *master;
>> +       void __iomem            *base;
>> +       int                     cs_active;
>> +       unsigned int            hz;
>> +       unsigned char           spcr;
>> +       unsigned char           sper;
>> +       unsigned char           spsr;
>> +       unsigned char           para;
>> +       unsigned char           sfcs;
>> +       unsigned char           timi;
>> +       unsigned int            mode;
>> +       u64                     clk_rate;
>> +};
>> +
>> +int loongson_spi_init_master(struct device *dev, void __iomem *reg);
>> +extern const struct dev_pm_ops loongson_spi_dev_pm_ops; #endif /*
>> +__LINUX_SPI_LOONGSON_H */
>> --
>> 2.20.1

