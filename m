Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091CE6D37B6
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 13:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjDBLoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 07:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjDBLoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 07:44:08 -0400
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4854D22E8D
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 04:44:07 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id iw7tpzqjOuZFDiw7upFXdu; Sun, 02 Apr 2023 13:44:05 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 02 Apr 2023 13:44:05 +0200
X-ME-IP: 86.243.2.178
Message-ID: <a4927787-4fcc-27c5-c838-760e0b07a334@wanadoo.fr>
Date:   Sun, 2 Apr 2023 13:44:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v6 2/2] spi: loongson: add bus driver for the loongson spi
 controller
Content-Language: fr
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     broonie@kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, liupeibao@loongson.cn,
        loongson-kernel@lists.loongnix.cn, lvjianmin@loongson.cn,
        robh+dt@kernel.org, wanghongliang@loongson.cn
References: <20230401095652.17364-1-zhuyinbo@loongson.cn>
 <20230401095652.17364-3-zhuyinbo@loongson.cn>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230401095652.17364-3-zhuyinbo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 01/04/2023 à 11:56, Yinbo Zhu a écrit :
> This bus driver supports the Loongson spi hardware controller in the
> Loongson platforms and supports to use DTS and PCI framework to
> register spi device resources.
> 
> Signed-off-by: Yinbo Zhu <zhuyinbo-cXZgJK919ebM1kAEIRd3EQ@public.gmane.org>
> ---

[...]

> +int loongson_spi_init_master(struct device *dev, struct resource *res)
> +{
> +	struct spi_master *master;
> +	struct loongson_spi *spi;
> +	struct clk *clk;
> +	int ret;
> +
> +	master = spi_alloc_master(dev, sizeof(struct loongson_spi));

devm_spi_alloc_master()?
(to simplify code and be consistent with devm_ function below)

> +	if (master == NULL) {
> +		dev_dbg(dev, "master allocation failed\n");
> +		return -ENOMEM;
> +	}
> +
> +	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
> +	master->setup = loongson_spi_setup;
> +	master->prepare_message = loongson_spi_prepare_message;
> +	master->transfer_one = loongson_spi_transfer_one;
> +	master->unprepare_message = loongson_spi_unprepare_message;
> +	master->set_cs = loongson_spi_set_cs;
> +	master->num_chipselect = 4;
> +	master->dev.of_node = of_node_get(dev->of_node);
> +	dev_set_drvdata(dev, master);
> +
> +	spi = spi_master_get_devdata(master);
> +
> +	spi->master = master;
> +
> +	spi->base = devm_ioremap(dev, res->start, resource_size(res));
> +	if (spi->base == NULL) {
> +		dev_err(dev, "cannot map io\n");
> +		ret = -ENXIO;
> +		goto free_master;
> +	}
> +
> +	clk = devm_clk_get(dev, NULL);
> +	if (!IS_ERR(clk))
> +		spi->clk_rate = clk_get_rate(clk);
> +
> +	loongson_spi_reginit(spi);
> +
> +	spi->mode = 0;
> +	if (of_get_property(dev->of_node, "spi-nocs", NULL))
> +		spi->mode |= SPI_NO_CS;
> +
> +	ret = spi_register_master(master);
> +	if (ret < 0)
> +		goto free_master;
> +
> +	return ret;
> +
> +free_master:
> +	kfree(master);
> +	spi_master_put(master);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(loongson_spi_init_master);

[...]

> diff --git a/drivers/spi/spi-loongson-pci.c b/drivers/spi/spi-loongson-pci.c
> new file mode 100644
> index 000000000000..b811de769ecb
> --- /dev/null
> +++ b/drivers/spi/spi-loongson-pci.c
> @@ -0,0 +1,89 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +// PCI interface driver for Loongson SPI Support
> +// Copyright (C) 2023 Loongson Technology Corporation Limited
> +
> +#include <linux/pci.h>
> +
> +#include "spi-loongson.h"
> +
> +static int loongson_spi_pci_register(struct pci_dev *pdev,
> +			const struct pci_device_id *ent)
> +{
> +	int ret;
> +	unsigned char v8;
> +	struct resource res[2];
> +	struct device *dev = &pdev->dev;
> +
> +	ret = pci_enable_device(pdev);
> +	if (ret < 0) {
> +		dev_err(dev, "cannot enable pci device\n");
> +		goto err_out;
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
> +	ret = pci_read_config_byte(pdev, PCI_INTERRUPT_LINE, &v8);
> +
> +	if (ret == PCIBIOS_SUCCESSFUL) {
> +		res[1].start = v8;
> +		res[1].end = v8;
> +	}
> +
> +	ret = loongson_spi_init_master(dev, res);
> +	if (ret)
> +		dev_err(dev, "failed to initialize master\n");
> +
> +err_out:
> +	return ret;
> +}
> +
> +static void loongson_spi_pci_unregister(struct pci_dev *pdev)
> +{
> +	pci_release_region(pdev, 0);

pci_disable_device()?

> +}

CJ

