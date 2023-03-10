Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2283D6B3B95
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 11:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjCJKBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 05:01:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjCJKBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 05:01:31 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3CF4AEE2BB;
        Fri, 10 Mar 2023 02:01:29 -0800 (PST)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8Bxedn3_wpkr_IKAA--.14685S3;
        Fri, 10 Mar 2023 18:01:27 +0800 (CST)
Received: from [10.20.42.35] (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxOL3z_wpkSNNRAA--.10580S3;
        Fri, 10 Mar 2023 18:01:26 +0800 (CST)
Subject: Re: [PATCH v1 2/2] spi: loongson: add bus driver for the loongson spi
 controller
To:     Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, zhuyinbo@loongson.cn
References: <20230308025908.21491-1-zhuyinbo@loongson.cn>
 <20230308025908.21491-3-zhuyinbo@loongson.cn>
 <1f0c2592-4433-47cb-9b73-d345e157dbf2@sirena.org.uk>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <fb502e11-a12f-58ca-4171-edec55b71fa5@loongson.cn>
Date:   Fri, 10 Mar 2023 18:01:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1f0c2592-4433-47cb-9b73-d345e157dbf2@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8AxOL3z_wpkSNNRAA--.10580S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxJFy8tr1UAr4xAF4UWFyUWrg_yoWrtr4xpF
        yYya1Ygr4fJr48Arn8XrWDXF1ayryrJr9xGaySy3yUKryDZw1fXFyUWF13CF4SyFyxCF17
        Zry09rWkGF4FkFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bx8Fc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM2
        8EF7xvwVC2z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAq
        jxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcV
        AFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG
        0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz4
        8v1sIEY20_WwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I
        3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIx
        AIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAI
        cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2js
        IEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j8pnQUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/3/8 下午11:03, Mark Brown 写道:
> On Wed, Mar 08, 2023 at 10:59:08AM +0800, Yinbo Zhu wrote:
>
>> +config SPI_LOONGSON
>> +	tristate "Loongson SPI Controller Support"
>> +	depends on LOONGARCH && OF && PCI
> I'm not seeing any build time dependencies here (possibly PCI?) so
> please add an || COMPILE_TEST to improve build coverage.  It'd be better
> to have separate modules for the platform and PCI functionality, that
> way someone who has a system without PCI can still use the driver even
> with PCI support disabled.

I will add an || COMPILE_TEST and drop && PCI then add some CONFIG_PCI 
macro

to limit some pci code.

>
>> +++ b/drivers/spi/spi-loongson.c
>> @@ -0,0 +1,502 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Loongson SPI Support
>> + *
>> + * Copyright (C) 2023 Loongson Technology Corporation Limited
> Please make the entire comment block a C++ one so things look more
> intentional.
okay, I got it.
>
>> +static int loongson_spi_update_state(struct loongson_spi *loongson_spi,
>> +				     struct spi_device *spi, struct spi_transfer *t)
>> +{
>> +	unsigned int hz;
>> +	unsigned int div, div_tmp;
>> +	unsigned int bit;
>> +	unsigned char val;
>> +	const char rdiv[12] = {0, 1, 4, 2, 3, 5, 6, 7, 8, 9, 10, 11};
>> +
>> +	hz  = t ? t->speed_hz : spi->max_speed_hz;
> Please write normal conditional statements so that things are legible,
> though in this case the core will ensure that there's a speed_hz in
> every transfer so there's no need for any of the logic around ensuring
> it's set.
Do you mean to achieve the following ?  and drop spi->max_speed_hz.

if (t)

       hz = t->speed_hz;


>
>> +static int loongson_spi_setup(struct spi_device *spi)
>> +{
>> +	struct loongson_spi *loongson_spi;
>> +
>> +	loongson_spi = spi_master_get_devdata(spi->master);
>> +	if (spi->bits_per_word % 8)
>> +		return -EINVAL;
>> +
>> +	if (spi->chip_select >= spi->master->num_chipselect)
>> +		return -EINVAL;
>> +
>> +	loongson_spi_update_state(loongson_spi, spi, NULL);
>> +	loongson_spi_set_cs(loongson_spi, spi, 1);
> Note that setup() needs to be able to run for one device while there are
> transfers for other devices on the same controller active.
okay, I will add a spin_lock for it.
>
>> +static int loongson_spi_write_read_8bit(struct spi_device *spi, const u8 **tx_buf,
>> +					u8 **rx_buf, unsigned int num)
>> +{
>> +	struct loongson_spi *loongson_spi = spi_master_get_devdata(spi->master);
>> +
>> +	if (tx_buf && *tx_buf) {
>> +		loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_FIFO_REG, *((*tx_buf)++));
>> +		while ((loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPSR_REG) & 0x1) == 1)
>> +			;
> A timeout would be good on these spins in case the controller gets
> stuck.  It'd also be polite to have a cpu_relax() somewhere either here
> or in the caller given that it's busy waiting.
okay, I got it.
>
>> +static void loongson_spi_work(struct work_struct *work)
>> +{
>> +	int param;
>> +	struct spi_message *m;
>> +	struct spi_device  *spi;
>> +	struct spi_transfer *t = NULL;
>> +	struct loongson_spi *loongson_spi = container_of(work, struct loongson_spi, work);
>> +
>> +	spin_lock(&loongson_spi->lock);
>> +	param = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_PARA_REG);
>> +	loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_PARA_REG, param&~1);
>> +	while (!list_empty(&loongson_spi->msg_queue)) {
>> +		m = container_of(loongson_spi->msg_queue.next, struct spi_message, queue);
>> +
> This all looks like it's open coding the core's message pump, only
> without the heavy optimisation work that the core has and missing some
> handling of cs_change and delays.  You should implement
> spi_transfer_one() instead, this will save a lot of code and should be
> more performant.
okay, I will try to add a spi_transfer_one for this.
>
>> +static int loongson_spi_transfer(struct spi_device *spi, struct spi_message *m)
>> +{
> In general you'd need an extremely strong reason to implement transfer()
> in a new driver.
okay, I got it.
>
>> +static int __maybe_unused loongson_spi_resume(struct device *dev)
>> +{
>> +static const struct dev_pm_ops loongson_spi_dev_pm_ops = {
>> +	.suspend = loongson_spi_suspend,
>> +	.resume = loongson_spi_resume,
>> +};
> The suspend/resume ops are assigned unconditionally.
sorry, I don't got it,  you mean was to  add a CONFIG_PM to limit code ?
>
>> +subsys_initcall(loongson_spi_init);
>> +module_exit(loongson_spi_exit);
> Why not just a regular module initcall like most SPI drivers?
okay, I will use module_init for register spi drivers.

