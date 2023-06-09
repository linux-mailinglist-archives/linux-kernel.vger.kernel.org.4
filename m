Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A487729099
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 09:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237067AbjFIHK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 03:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236923AbjFIHKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:10:16 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A46D930D1;
        Fri,  9 Jun 2023 00:10:08 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8CxNulP0IJkCPIAAA--.1048S3;
        Fri, 09 Jun 2023 15:10:07 +0800 (CST)
Received: from [10.20.42.35] (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxK8pO0IJkWxQKAA--.22402S3;
        Fri, 09 Jun 2023 15:10:06 +0800 (CST)
Subject: Re: [PATCH v12 2/2] spi: loongson: add bus driver for the loongson
 spi controller
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, zhuyinbo@loongson.cn
References: <20230608072819.25930-1-zhuyinbo@loongson.cn>
 <20230608072819.25930-3-zhuyinbo@loongson.cn>
 <CAHp75VfrPX=VsXMry0Dg_Y4zgt59S=uY=rxCZzv8fBvr_w+i-g@mail.gmail.com>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <44239068-e0ac-1dc8-337e-fb44f5266097@loongson.cn>
Date:   Fri, 9 Jun 2023 15:10:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VfrPX=VsXMry0Dg_Y4zgt59S=uY=rxCZzv8fBvr_w+i-g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxK8pO0IJkWxQKAA--.22402S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
        ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
        nUUI43ZEXa7xR_UUUUUUUUU==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/6/8 下午6:15, Andy Shevchenko 写道:
> On Thu, Jun 8, 2023 at 10:28 AM Yinbo Zhu <zhuyinbo@loongson.cn> wrote:
>>
>> This bus driver supports the Loongson SPI hardware controller in the
>> Loongson platforms and supports to use DTS and PCI framework to
> 
> the use


okay, I got it.

> 
>> register SPI device resources.
> 
> Thank you for an update. I have a few nit-picks below, but in general
> this version is good (esp. if you address them)
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 


You're welcome, I will add the reviewed-by in v13.

...

>> +static void loongson_spi_set_cs(struct spi_device *spi, bool val)
>> +{
>> +       int cs;
>> +       struct loongson_spi *loongson_spi = spi_controller_get_devdata(spi->controller);
>> +
>> +       cs = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SFCS_REG)
>> +                                          & ~(0x11 << spi_get_chipselect(spi, 0));
>> +       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SFCS_REG,
>> +                                      (val ? (0x11 << spi_get_chipselect(spi, 0)) :
>> +                                      (0x1 << spi_get_chipselect(spi, 0))) | cs);
> 
> Can be done as
> 
> static void loongson_spi_set_cs(struct spi_device *spi, bool en)
> 
>      unsigned char mask = (BIT(4) | BIT(0)) << spi_get_chipselect(spi, 0);
>      unsigned char val = en ? mask :  (BIT(0) << spi_get_chipselect(spi, 0));
> 
>      cs = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SFCS_REG) & ~mask;
>      loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SFCS_REG, val | cs);


okay, I will do it.

> 
> (Renamed variables to be consistent with the other uses in the driver below)


sorry, I don't got it. Are you referring to the following changes ?
loongson_spi_set_cs(spi, 1) => loongson_spi_set_cs(spi, true)

> 
>> +}
>> +
>> +static void loongson_spi_set_clk(struct loongson_spi *loongson_spi, unsigned int hz)
>> +{
>> +       unsigned char val;
>> +       unsigned int div, div_tmp;
>> +       static const char rdiv[12] = {0, 1, 4, 2, 3, 5, 6, 7, 8, 9, 10, 11};
>> +
>> +       div = clamp_val(DIV_ROUND_UP_ULL(loongson_spi->clk_rate, hz), 2, 4096);
>> +       div_tmp = rdiv[fls(div - 1)];
>> +       loongson_spi->spcr = (div_tmp & GENMASK(1, 0)) >> 0;
>> +       loongson_spi->sper = (div_tmp & GENMASK(3, 2)) >> 2;
>> +       val = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPCR_REG);
> 
>      val &= GENMASK(1, 0);


This seems to be "val &= ~GENMASK(1, 0);"

> 
>> +       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPCR_REG, (val & ~3) |
>> +                              loongson_spi->spcr);
> 
>         loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPCR_REG, val
> | loongson_spi->spcr);


okay, I got it.

> 
>> +       val = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPER_REG);
> 
>      val &= GENMASK(1, 0);


This seems to be "val &= ~GENMASK(1, 0);"

> 
>> +       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPER_REG, (val & ~3) |
>> +                              loongson_spi->sper);
> 
>         loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPER_REG, val
> | loongson_spi->sper);
> 


okay,  I got it.

>> +       loongson_spi->hz = hz;
>> +}
>> +
>> +static void loongson_spi_set_mode(struct loongson_spi *loongson_spi,
>> +                                 struct spi_device *spi)
>> +{
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
>> +       loongson_spi->mode |= spi->mode;
>> +}
>> +
>> +static int loongson_spi_update_state(struct loongson_spi *loongson_spi,
>> +                               struct spi_device *spi, struct spi_transfer *t)
>> +{
>> +       if (t && loongson_spi->hz != t->speed_hz)
>> +               loongson_spi_set_clk(loongson_spi, t->speed_hz);
>> +
>> +       if ((spi->mode ^ loongson_spi->mode) & SPI_MODE_X_MASK)
>> +               loongson_spi_set_mode(loongson_spi, spi);
>> +
>> +       return 0;
>> +}
>> +
>> +static int loongson_spi_setup(struct spi_device *spi)
>> +{
>> +       struct loongson_spi *loongson_spi;
>> +
>> +       loongson_spi = spi_controller_get_devdata(spi->controller);
>> +       if (spi->bits_per_word % 8)
>> +               return -EINVAL;
>> +
>> +       if (spi_get_chipselect(spi, 0) >= spi->controller->num_chipselect)
>> +               return -EINVAL;
>> +
>> +       loongson_spi->hz = 0;
>> +       loongson_spi_set_cs(spi, 1);
>> +
>> +       return 0;
>> +}
>> +
>> +static int loongson_spi_write_read_8bit(struct spi_device *spi, const u8 **tx_buf,
>> +                                       u8 **rx_buf, unsigned int num)
>> +{
>> +       int ret;
>> +       struct loongson_spi *loongson_spi = spi_controller_get_devdata(spi->controller);
>> +
>> +       if (tx_buf && *tx_buf)
>> +               loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_FIFO_REG, *((*tx_buf)++));
>> +       else
>> +               loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_FIFO_REG, 0);
> 
> + Blank line


okay, I will add the blank line.

> 
>> +       ret = readb_poll_timeout(loongson_spi->base + LOONGSON_SPI_SPSR_REG, loongson_spi->spsr,
>> +                       (loongson_spi->spsr & 0x1) != LOONGSON_SPI_SPSR_RFEMPTY, 1, MSEC_PER_SEC);
> 
>                         (loongson_spi->spsr &
> LOONGSON_SPI_SPSR_RFEMPTY) != LOONGSON_SPI_SPSR_RFEMPTY,
>                         1, MSEC_PER_SEC);


okay, I got it.

> 
>> +       if (rx_buf && *rx_buf)
>> +               *(*rx_buf)++ = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_FIFO_REG);
>> +       else
>> +               loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_FIFO_REG);
>> +
>> +       return ret;
>> +}
>> +
>> +static int loongson_spi_write_read(struct spi_device *spi, struct spi_transfer *xfer)
>> +{
>> +       int ret;
>> +       unsigned int count;
>> +       const u8 *tx = xfer->tx_buf;
>> +       u8 *rx = xfer->rx_buf;
>> +
>> +       count = xfer->len;
> 
>> +
> 
> Unneeded blank line.


okay, I will remove the blank line.

> 
>> +       do {
>> +               ret = loongson_spi_write_read_8bit(spi, &tx, &rx, count);
>> +               if (ret)
>> +                       break;
>> +       } while (--count);
>> +
>> +       return ret;
>> +}
>> +
>> +static int loongson_spi_prepare_message(struct spi_controller *ctlr, struct spi_message *m)
>> +{
>> +       struct loongson_spi *loongson_spi = spi_controller_get_devdata(ctlr);
> 
>> +       loongson_spi->para = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_PARA_REG);
> 
>> +       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_PARA_REG, loongson_spi->para & ~1);
> 
> BIT(0) ?
> LOONGSON_SPI_PARA_MEM_EN ?


I will use LOONGSON_SPI_PARA_MEM_EN.

> 
>> +       return 0;
>> +}
>> +

...

>> +int loongson_spi_init_controller(struct device *dev, void __iomem *regs)
>> +{
>> +       struct spi_controller *controller;
>> +       struct loongson_spi *spi;
>> +       struct clk *clk;
>> +
>> +       controller = devm_spi_alloc_host(dev, sizeof(struct loongson_spi));
>> +       if (controller == NULL)
>> +               return -ENOMEM;
>> +
>> +       controller->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
> 
>     ... = SPI_MODE_X_MASK | SPI_CS_HIGH;


okay, I got it.


Thanks,
Yinbo

