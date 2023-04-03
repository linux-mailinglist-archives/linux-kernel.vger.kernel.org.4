Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832F96D40CD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 11:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbjDCJjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 05:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbjDCJiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 05:38:46 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4978F1205C;
        Mon,  3 Apr 2023 02:37:46 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8BxIk7WnSpkj_4VAA--.33690S3;
        Mon, 03 Apr 2023 17:35:18 +0800 (CST)
Received: from [10.20.42.35] (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dxib3VnSpky1kUAA--.16629S3;
        Mon, 03 Apr 2023 17:35:18 +0800 (CST)
Subject: Re: [PATCH v6 2/2] spi: loongson: add bus driver for the loongson spi
 controller
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, zhuyinbo@loongson.cn
References: <20230401095652.17364-1-zhuyinbo@loongson.cn>
 <20230401095652.17364-3-zhuyinbo@loongson.cn>
 <9fcb66fa-aadc-8660-bd4a-452c4811ced9@linaro.org>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <5ab476ce-a1ef-871d-2eda-e8e494509f1a@loongson.cn>
Date:   Mon, 3 Apr 2023 17:35:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <9fcb66fa-aadc-8660-bd4a-452c4811ced9@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dxib3VnSpky1kUAA--.16629S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxur4UAr1UtFWUWF4UGw45ZFb_yoWrtFy8pF
        WUAa1UKF4xJr10y3sxXrZ8AFWYvryrWry29ay7t3yYk34qvrn7X34DGFy7Crs7AF4DZF1j
        vay8urs7CF45WFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bxkFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28E
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
X-Spam-Status: No, score=-1.4 required=5.0 tests=NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/4/2 下午6:04, Krzysztof Kozlowski 写道:
> On 01/04/2023 11:56, Yinbo Zhu wrote:
>> This bus driver supports the Loongson spi hardware controller in the
>> Loongson platforms and supports to use DTS and PCI framework to
>> register spi device resources.
>>
>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
>> ---
> 
> 
> ...
> 
>> +
>> +#include <linux/init.h>
>> +#include <linux/module.h>
>> +#include <linux/kernel.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/delay.h>
>> +#include <linux/err.h>
>> +#include <linux/spi/spi.h>
>> +#include <linux/clk.h>
>> +#include <linux/io.h>
>> +
>> +#include "spi-loongson.h"
>> +
>> +static inline void loongson_spi_write_reg(struct loongson_spi *spi, unsigned char reg,
>> +					  unsigned char data)
>> +{
>> +	writeb(data, spi->base + reg);
> 
> This wrapper does not simplify anything.
Mark seems to have other viewpoint.
> 
>> +}
>> +
>> +static inline char loongson_spi_read_reg(struct loongson_spi *spi, unsigned char reg)
>> +{
>> +	return readb(spi->base + reg);
> 
> Neither this one.
> 
>> +}
>> +
>> +static void loongson_spi_set_cs(struct spi_device *spi, bool val)
>> +{
>> +	int cs;
>> +	struct loongson_spi *loongson_spi = spi_master_get_devdata(spi->master);
>> +
> 
> (...)
> 
>> +
>> +static int __init loongson_spi_pci_init(void)
>> +{
>> +	int ret;
>> +
>> +	ret = pci_register_driver(&loongson_spi_pci_driver);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return 0;
>> +}
>> +
>> +static void __exit loongson_spi_pci_exit(void)
>> +{
>> +	pci_unregister_driver(&loongson_spi_pci_driver);
>> +}
>> +
>> +module_init(loongson_spi_pci_init);
>> +module_exit(loongson_spi_pci_exit);
> 
> module_xxx_driver?
okay, I got it.
> 
>> +
>> +MODULE_DESCRIPTION("Loongson spi pci driver");
>> +MODULE_LICENSE("GPL");
>> diff --git a/drivers/spi/spi-loongson-plat.c b/drivers/spi/spi-loongson-plat.c
>> new file mode 100644
>> index 000000000000..8f4aa70168f3
>> --- /dev/null
>> +++ b/drivers/spi/spi-loongson-plat.c
>> @@ -0,0 +1,66 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +// Platform driver for Loongson SPI Support
>> +// Copyright (C) 2023 Loongson Technology Corporation Limited
>> +
>> +#include <linux/platform_device.h>
>> +#include <linux/of.h>
>> +
>> +#include "spi-loongson.h"
>> +
>> +static int loongson_spi_platform_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct resource *res;
>> +	int ret;
>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	if (res == NULL) {
>> +		dev_err(dev, "cannot get io resource memory\n");
>> +		return -ENOENT;
>> +	}
>> +
>> +	ret = loongson_spi_init_master(dev, res);
>> +	if (ret)
>> +		dev_err(dev, "failed to initialize master\n");
>> +
>> +	return ret;
>> +}
>> +
>> +static const struct of_device_id loongson_spi_id_table[] = {
>> +	{ .compatible = "loongson,ls2k-spi", },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, loongson_spi_id_table);
>> +
>> +static struct platform_driver loongson_spi_plat_driver = {
>> +	.probe = loongson_spi_platform_probe,
>> +	.driver	= {
>> +		.name	= "loongson-spi",
>> +		.owner	= THIS_MODULE,
> 
> Really? We get rid of it years ago. I bet you did not run coccicheck,
> smatch, sparse...
okay, I got it, I will remove this line.

Thanks.
> 
>> +		.bus = &platform_bus_type,
>> +		.pm = &loongson_spi_dev_pm_ops,
>> +		.of_match_table = loongson_spi_id_table,
>> +	},
>> +};
>> +
>> +static int __init loongson_spi_plat_init(void)
>> +{
>> +	int ret;
>> +
>> +	ret = platform_driver_register(&loongson_spi_plat_driver);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return 0;
>> +}
>> +
>> +static void __exit loongson_spi_plat_exit(void)
>> +{
>> +	platform_driver_unregister(&loongson_spi_plat_driver);
>> +}
>> +
>> +module_init(loongson_spi_plat_init);
>> +module_exit(loongson_spi_plat_exit);
> 
> module_platform_driver.
okay, I will use it.
> 
>> +
>> +MODULE_DESCRIPTION("Loongson spi platform driver");
>> +MODULE_LICENSE("GPL");
>> diff --git a/drivers/spi/spi-loongson.h b/drivers/spi/spi-loongson.h
>> new file mode 100644
>> index 000000000000..44818340188d
>> --- /dev/null
>> +++ b/drivers/spi/spi-loongson.h
>> @@ -0,0 +1,41 @@
>> +/* SPDX-License-Identifier: GPL-2.0+ */
>> +/* Header File for Loongson SPI Driver. */
>> +/* Copyright (C) 2023 Loongson Technology Corporation Limited */
>> +
>> +#ifndef __LINUX_SPI_LOONGSON_H
>> +#define __LINUX_SPI_LOONGSON_H
>> +
>> +#define	LOONGSON_SPI_SPCR_REG	0x00
> 
> There is just one space after #define.
Mark seems to have other viewpoint.
> 
> 
> Best regards,
> Krzysztof
> 

