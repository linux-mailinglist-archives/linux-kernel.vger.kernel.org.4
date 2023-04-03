Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F074D6D3E56
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 09:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjDCHpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 03:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjDCHpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 03:45:01 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DDCA91FF5;
        Mon,  3 Apr 2023 00:44:58 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8AxJPz5gypk_fUVAA--.33829S3;
        Mon, 03 Apr 2023 15:44:57 +0800 (CST)
Received: from [10.20.42.35] (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxeb34gypkvkoUAA--.16286S3;
        Mon, 03 Apr 2023 15:44:56 +0800 (CST)
Subject: Re: [PATCH v6 2/2] spi: loongson: add bus driver for the loongson spi
 controller
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     broonie@kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, liupeibao@loongson.cn,
        loongson-kernel@lists.loongnix.cn, lvjianmin@loongson.cn,
        robh+dt@kernel.org, wanghongliang@loongson.cn, zhuyinbo@loongson.cn
References: <20230401095652.17364-1-zhuyinbo@loongson.cn>
 <20230401095652.17364-3-zhuyinbo@loongson.cn>
 <a4927787-4fcc-27c5-c838-760e0b07a334@wanadoo.fr>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <ee83b5d5-2f8c-dc62-bd31-91580704eee1@loongson.cn>
Date:   Mon, 3 Apr 2023 15:44:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <a4927787-4fcc-27c5-c838-760e0b07a334@wanadoo.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cxeb34gypkvkoUAA--.16286S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxur4UWF48WFWktr48tF4xWFg_yoWrZF15pa
        n5JFW5GrWfJrn3Jr1UJr4UXFy5Zryrta4DJr4IqF1UGFZFyr10gr1UWrn29r13AF48Ar1U
        Zr1jgrsruF13JaDanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bfxFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY
        6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrV
        C2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
        7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7V
        AKI48JMxAIw28IcVCjz48v1sIEY20_WwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C2
        67AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
        8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8
        JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
        1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBI
        daVFxhVjvjDU0xZFpf9x07j19a9UUUUU=
X-Spam-Status: No, score=-2.4 required=5.0 tests=NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/4/2 下午7:44, Christophe JAILLET 写道:
> Le 01/04/2023 à 11:56, Yinbo Zhu a écrit :
>> This bus driver supports the Loongson spi hardware controller in the
>> Loongson platforms and supports to use DTS and PCI framework to
>> register spi device resources.
>>
>> Signed-off-by: Yinbo Zhu 
>> <zhuyinbo-cXZgJK919ebM1kAEIRd3EQ@public.gmane.org>
>> ---
> 
> [...]
> 
>> +int loongson_spi_init_master(struct device *dev, struct resource *res)
>> +{
>> +    struct spi_master *master;
>> +    struct loongson_spi *spi;
>> +    struct clk *clk;
>> +    int ret;
>> +
>> +    master = spi_alloc_master(dev, sizeof(struct loongson_spi));
> 
> devm_spi_alloc_master()?
> (to simplify code and be consistent with devm_ function below)
okay, I got it, I will use it.
> 
>> +    if (master == NULL) {
>> +        dev_dbg(dev, "master allocation failed\n");
>> +        return -ENOMEM;
>> +    }
>> +
>> +    master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
>> +    master->setup = loongson_spi_setup;
>> +    master->prepare_message = loongson_spi_prepare_message;
>> +    master->transfer_one = loongson_spi_transfer_one;
>> +    master->unprepare_message = loongson_spi_unprepare_message;
>> +    master->set_cs = loongson_spi_set_cs;
>> +    master->num_chipselect = 4;
>> +    master->dev.of_node = of_node_get(dev->of_node);
>> +    dev_set_drvdata(dev, master);
>> +
>> +    spi = spi_master_get_devdata(master);
>> +
>> +    spi->master = master;
>> +
>> +    spi->base = devm_ioremap(dev, res->start, resource_size(res));
>> +    if (spi->base == NULL) {
>> +        dev_err(dev, "cannot map io\n");
>> +        ret = -ENXIO;
>> +        goto free_master;
>> +    }
>> +
>> +    clk = devm_clk_get(dev, NULL);
>> +    if (!IS_ERR(clk))
>> +        spi->clk_rate = clk_get_rate(clk);
>> +
>> +    loongson_spi_reginit(spi);
>> +
>> +    spi->mode = 0;
>> +    if (of_get_property(dev->of_node, "spi-nocs", NULL))
>> +        spi->mode |= SPI_NO_CS;
>> +
>> +    ret = spi_register_master(master);
>> +    if (ret < 0)
>> +        goto free_master;
>> +
>> +    return ret;
>> +
>> +free_master:
>> +    kfree(master);
>> +    spi_master_put(master);
>> +
>> +    return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(loongson_spi_init_master);
> 
> [...]
> 
>> diff --git a/drivers/spi/spi-loongson-pci.c 
>> b/drivers/spi/spi-loongson-pci.c
>> new file mode 100644
>> index 000000000000..b811de769ecb
>> --- /dev/null
>> +++ b/drivers/spi/spi-loongson-pci.c
>> @@ -0,0 +1,89 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +// PCI interface driver for Loongson SPI Support
>> +// Copyright (C) 2023 Loongson Technology Corporation Limited
>> +
>> +#include <linux/pci.h>
>> +
>> +#include "spi-loongson.h"
>> +
>> +static int loongson_spi_pci_register(struct pci_dev *pdev,
>> +            const struct pci_device_id *ent)
>> +{
>> +    int ret;
>> +    unsigned char v8;
>> +    struct resource res[2];
>> +    struct device *dev = &pdev->dev;
>> +
>> +    ret = pci_enable_device(pdev);
>> +    if (ret < 0) {
>> +        dev_err(dev, "cannot enable pci device\n");
>> +        goto err_out;
>> +    }
>> +
>> +    ret = pci_request_region(pdev, 0, "loongson-spi io");
>> +    if (ret < 0) {
>> +        dev_err(dev, "cannot request region 0.\n");
>> +        goto err_out;
>> +    }
>> +
>> +    res[0].start = pci_resource_start(pdev, 0);
>> +    res[0].end = pci_resource_end(pdev, 0);
>> +    ret = pci_read_config_byte(pdev, PCI_INTERRUPT_LINE, &v8);
>> +
>> +    if (ret == PCIBIOS_SUCCESSFUL) {
>> +        res[1].start = v8;
>> +        res[1].end = v8;
>> +    }
>> +
>> +    ret = loongson_spi_init_master(dev, res);
>> +    if (ret)
>> +        dev_err(dev, "failed to initialize master\n");
>> +
>> +err_out:
>> +    return ret;
>> +}
>> +
>> +static void loongson_spi_pci_unregister(struct pci_dev *pdev)
>> +{
>> +    pci_release_region(pdev, 0);
> 
> pci_disable_device()?
okay, I will add pci_disable_device() here.

Thanks.
> 
>> +}
> 
> CJ

