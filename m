Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823366BF840
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 07:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjCRGHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 02:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCRGHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 02:07:20 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 365A430E80;
        Fri, 17 Mar 2023 23:07:17 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8CxTNoUVRVk6rcNAA--.8431S3;
        Sat, 18 Mar 2023 14:07:17 +0800 (CST)
Received: from [10.20.42.35] (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cx8eQUVRVkILAEAA--.20922S3;
        Sat, 18 Mar 2023 14:07:16 +0800 (CST)
Subject: Re: [PATCH v2 2/2] spi: loongson: add bus driver for the loongson spi
 controller
To:     Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, zhuyinbo@loongson.cn
References: <20230317082950.12738-1-zhuyinbo@loongson.cn>
 <20230317082950.12738-3-zhuyinbo@loongson.cn>
 <68b6034f-8305-4854-a4c9-962be988ade7@sirena.org.uk>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <9b7aff76-eff4-3b82-d7af-a723fbf21a32@loongson.cn>
Date:   Sat, 18 Mar 2023 14:07:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <68b6034f-8305-4854-a4c9-962be988ade7@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Cx8eQUVRVkILAEAA--.20922S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7WF1DZw4rZFyUuw4fXrWxXrb_yoW8tFWfpF
        ya934YgFyfJr18Arn8JrZ8XFyYyrWrXwnrJFZ2ya1IkryDZwn8XryUWF1Y9r43CFWxAr17
        Xry09rWkua1rCrDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bxxFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r1j6r4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM2
        8EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l
        57IF6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
        vE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
        r2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCF04k20xvE74
        AGY7Cv6cx26rWl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC2
        0s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMI
        IF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF
        0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87
        Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2oGQDUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/3/18 上午12:26, Mark Brown 写道:
> On Fri, Mar 17, 2023 at 04:29:50PM +0800, Yinbo Zhu wrote:
>
>> +static int loongson_spi_update_state(struct loongson_spi *loongson_spi,
>> +				     struct spi_device *spi, struct spi_transfer *t)
>> +{
> ...
>
>> +		loongson_spi->hz = hz;
>> +		loongson_spi->spcr = div_tmp & 3;
>> +		loongson_spi->sper = (div_tmp >> 2) & 3;
>> +		val = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPCR_REG);
> This is writing to general chip registers, apparently not per chip
> select ones.

The loongson_spi_update_state was only be called in setup or transfer_one, and I will also
add a spin lock in tranfser_one.

>
>> +static int loongson_spi_setup(struct spi_device *spi)
>> +{
>> +	struct loongson_spi *loongson_spi;
>> +	spin_lock(&loongson_spi->lock);
>> +	loongson_spi_update_state(loongson_spi, spi, NULL);
> As IIRC I mentioned last time setup() might be called while other
> transfers are happening and therefore shouldn't affect parallel
> operations on other devices.
I think add spin_lock in  transfer_one interface that should be to fix 
this issue, Do you think so?
loongson_spi_transfer_one(struct spi_controller *ctrl, struct spi_dev
  {
         struct loongson_spi *loongson_spi = 
spi_master_get_devdata(spi->master);

+       spin_lock(&loongson_spi->lock);
         loongson_spi_update_state(loongson_spi, spi, xfer);
+       spin_unlock(&loongson_spi->lock);

>
>> +static const struct of_device_id loongson_spi_id_table[] = {
>> +	{ .compatible = "loongson,ls2k-spi", },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, loongson_spi_id_table);
>> +
>> +static struct platform_driver loongson_spi_driver = {
>> +	.probe = loongson_spi_platform_probe,
>> +	.driver	= {
>> +		.name	= "loongson-spi",
>> +		.owner	= THIS_MODULE,
>> +		.bus = &platform_bus_type,
>> +		.pm = &loongson_spi_dev_pm_ops,
>> +		.of_match_table = loongson_spi_id_table,
>> +	},
>> +};
>> +
>> +#ifdef CONFIG_PCI
>> +static int loongson_spi_pci_register(struct pci_dev *pdev,
>> +			const struct pci_device_id *ent)
> Again as I said last time the two buses should probably be separate
> modules.
>
> Otherwise this looks fine.
okay, I will do it.

