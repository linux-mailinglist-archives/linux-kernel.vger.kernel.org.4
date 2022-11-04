Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD646196A4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 13:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbiKDMzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 08:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbiKDMzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 08:55:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA5026128;
        Fri,  4 Nov 2022 05:55:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A88A8B82DC5;
        Fri,  4 Nov 2022 12:55:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CEE9C433C1;
        Fri,  4 Nov 2022 12:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667566529;
        bh=8ijI/+zauSId0Guz7DtIF+hodICcqrHMZ8NhyWVLshA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Flq+g7VlFyv+2pfCHNO2gMCftGsewXx0vxtf+S1yzk6JTe3VJtjQgQEFc6Qabbemx
         u7ebyV5PsSfPakn9bRqFOiswK/xuwcetWLys65qCyR1s7qShAj0Bvi+WdtwY/F8+Tu
         Rj3S/Ttt8nXeHCAUb7nbfnRm8yMAzXnvPwaKrwdIxCuVK4zVWIhuA1vdxauXXAR1sh
         Lu9C/vlwvNDYUE95pvlWkvWoO5mSYDPb6oj5UlFjM81d01Xmm3PhJd3FO7rhZX3Yai
         prTI2DWy9htKN8TwZiLdCbfLOuZxMBFlH6OUElqJzEymijWvGmJim7QA0hx6wHgdhJ
         Cj8Xpnfr12LnQ==
Message-ID: <a729e4e2-2f2e-8c3e-af45-3b8276bc6522@kernel.org>
Date:   Fri, 4 Nov 2022 14:55:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v7 2/5] remoteproc: pru: Add APIs to get and put the PRU
 cores
Content-Language: en-US
To:     MD Danish Anwar <danishanwar@ti.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Suman Anna <s-anna@ti.com>, "Andrew F . Davis" <afd@ti.com>,
        nm@ti.com, vigneshr@ti.com, srk@ti.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20221031073801.130541-1-danishanwar@ti.com>
 <20221031073801.130541-3-danishanwar@ti.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20221031073801.130541-3-danishanwar@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Danish,

On 31/10/2022 09:37, MD Danish Anwar wrote:
> From: Tero Kristo <t-kristo@ti.com>
> 
> Add two new APIs, pru_rproc_get() and pru_rproc_put(), to the PRU
> driver to allow client drivers to acquire and release the remoteproc
> device associated with a PRU core. The PRU cores are treated as
> resources with only one client owning it at a time.
> 
> The pru_rproc_get() function returns the rproc handle corresponding
> to a PRU core identified by the device tree "ti,prus" property under
> the client node. The pru_rproc_put() is the complementary function
> to pru_rproc_get().
> 
> Co-developed-by: Suman Anna <s-anna@ti.com>
> Signed-off-by: Suman Anna <s-anna@ti.com>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Co-developed-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
> Signed-off-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
> Co-developed-by: Puranjay Mohan <p-mohan@ti.com>
> Signed-off-by: Puranjay Mohan <p-mohan@ti.com>
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
>  drivers/remoteproc/pru_rproc.c | 142 +++++++++++++++++++++++++++++++--
>  include/linux/pruss.h          |  56 +++++++++++++
>  2 files changed, 193 insertions(+), 5 deletions(-)
>  create mode 100644 include/linux/pruss.h
> 
> diff --git a/drivers/remoteproc/pru_rproc.c b/drivers/remoteproc/pru_rproc.c
> index 128bf9912f2c..9ba73cfc29e2 100644
> --- a/drivers/remoteproc/pru_rproc.c
> +++ b/drivers/remoteproc/pru_rproc.c
> @@ -2,12 +2,14 @@
>  /*
>   * PRU-ICSS remoteproc driver for various TI SoCs
>   *
> - * Copyright (C) 2014-2020 Texas Instruments Incorporated - https://www.ti.com/
> + * Copyright (C) 2014-2022 Texas Instruments Incorporated - https://www.ti.com/
>   *
>   * Author(s):
>   *	Suman Anna <s-anna@ti.com>
>   *	Andrew F. Davis <afd@ti.com>
>   *	Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org> for Texas Instruments
> + *	Puranjay Mohan <p-mohan@ti.com>
> + *	Md Danish Anwar <danishanwar@ti.com>
>   */
>  
>  #include <linux/bitops.h>
> @@ -16,6 +18,7 @@
>  #include <linux/module.h>
>  #include <linux/of_device.h>
>  #include <linux/of_irq.h>
> +#include <linux/pruss.h>
>  #include <linux/pruss_driver.h>
>  #include <linux/remoteproc.h>
>  
> @@ -111,6 +114,8 @@ struct pru_private_data {
>   * @rproc: remoteproc pointer for this PRU core
>   * @data: PRU core specific data
>   * @mem_regions: data for each of the PRU memory regions
> + * @client_np: client device node
> + * @lock: mutex to protect client usage
>   * @fw_name: name of firmware image used during loading
>   * @mapped_irq: virtual interrupt numbers of created fw specific mapping
>   * @pru_interrupt_map: pointer to interrupt mapping description (firmware)
> @@ -126,6 +131,8 @@ struct pru_rproc {
>  	struct rproc *rproc;
>  	const struct pru_private_data *data;
>  	struct pruss_mem_region mem_regions[PRU_IOMEM_MAX];
> +	struct device_node *client_np;
> +	struct mutex lock; /* client access lock */
>  	const char *fw_name;
>  	unsigned int *mapped_irq;
>  	struct pru_irq_rsc *pru_interrupt_map;
> @@ -146,6 +153,127 @@ void pru_control_write_reg(struct pru_rproc *pru, unsigned int reg, u32 val)
>  	writel_relaxed(val, pru->mem_regions[PRU_IOMEM_CTRL].va + reg);
>  }
>  
> +static struct rproc *__pru_rproc_get(struct device_node *np, int index)
> +{
> +	struct rproc *rproc;
> +	phandle rproc_phandle;
> +	int ret;
> +
> +	ret = of_property_read_u32_index(np, "ti,prus", index, &rproc_phandle);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	rproc = rproc_get_by_phandle(rproc_phandle);
> +	if (!rproc) {
> +		ret = -EPROBE_DEFER;
> +		goto err_no_rproc_handle;
> +	}
> +
> +	/* make sure it is PRU rproc */
> +	if (!is_pru_rproc(rproc->dev.parent)) {
> +		rproc_put(rproc);
> +		return ERR_PTR(-ENODEV);
> +	}
> +
> +	get_device(&rproc->dev);

Why do you need a get_device() here?
rproc_get_by_phandle() does it right?

> +
> +	return rproc;
> +
> +err_no_rproc_handle:
> +	rproc_put(rproc);
> +	return ERR_PTR(ret);
> +}
> +
> +/**
> + * pru_rproc_get() - get the PRU rproc instance from a device node
> + * @np: the user/client device node
> + * @index: index to use for the ti,prus property
> + * @pru_id: optional pointer to return the PRU remoteproc processor id
> + *
> + * This function looks through a client device node's "ti,prus" property at
> + * index @index and returns the rproc handle for a valid PRU remote processor if
> + * found. The function allows only one user to own the PRU rproc resource at a
> + * time. Caller must call pru_rproc_put() when done with using the rproc, not
> + * required if the function returns a failure.
> + *
> + * When optional @pru_id pointer is passed the PRU remoteproc processor id is
> + * returned.
> + *
> + * Return: rproc handle on success, and an ERR_PTR on failure using one
> + * of the following error values
> + *    -ENODEV if device is not found
> + *    -EBUSY if PRU is already acquired by anyone
> + *    -EPROBE_DEFER is PRU device is not probed yet
> + */
> +struct rproc *pru_rproc_get(struct device_node *np, int index,
> +			    enum pruss_pru_id *pru_id)
> +{
> +	struct rproc *rproc;
> +	struct pru_rproc *pru;
> +	struct device *dev;
> +	int ret;
> +
> +	rproc = __pru_rproc_get(np, index);
> +	if (IS_ERR(rproc))
> +		return rproc;

Why bother doing __pru_rproc_get() if pru->client_np exists?

You could do the below if check first and exit if pru->client_np exists.

> +
> +	pru = rproc->priv;
> +	dev = &rproc->dev;
> +
> +	mutex_lock(&pru->lock);
> +
> +	if (pru->client_np) {
> +		mutex_unlock(&pru->lock);
> +		put_device(dev);
> +		ret = -EBUSY;
> +		goto err_no_rproc_handle;
> +	}
> +
> +	pru->client_np = np;
> +
> +	mutex_unlock(&pru->lock);
> +
> +	if (pru_id)
> +		*pru_id = pru->id;
> +
> +	return rproc;
> +
> +err_no_rproc_handle:
> +	rproc_put(rproc);
> +	return ERR_PTR(ret);
> +}
> +EXPORT_SYMBOL_GPL(pru_rproc_get);
> +
> +/**
> + * pru_rproc_put() - release the PRU rproc resource
> + * @rproc: the rproc resource to release
> + *
> + * Releases the PRU rproc resource and makes it available to other
> + * users.
> + */
> +void pru_rproc_put(struct rproc *rproc)
> +{
> +	struct pru_rproc *pru;
> +
> +	if (IS_ERR_OR_NULL(rproc) || !is_pru_rproc(rproc->dev.parent))
> +		return;
> +
> +	pru = rproc->priv;
> +
> +	mutex_lock(&pru->lock);
> +
> +	if (!pru->client_np) {
> +		mutex_unlock(&pru->lock);
> +		return;
> +	}
> +
> +	pru->client_np = NULL;
> +	mutex_unlock(&pru->lock);
> +
> +	rproc_put(rproc);
> +}
> +EXPORT_SYMBOL_GPL(pru_rproc_put);
> +
>  static inline u32 pru_debug_read_reg(struct pru_rproc *pru, unsigned int reg)
>  {
>  	return readl_relaxed(pru->mem_regions[PRU_IOMEM_DEBUG].va + reg);
> @@ -438,7 +566,7 @@ static void *pru_d_da_to_va(struct pru_rproc *pru, u32 da, size_t len)
>  	dram0 = pruss->mem_regions[PRUSS_MEM_DRAM0];
>  	dram1 = pruss->mem_regions[PRUSS_MEM_DRAM1];
>  	/* PRU1 has its local RAM addresses reversed */
> -	if (pru->id == 1)
> +	if (pru->id == PRUSS_PRU1)

Introduction of PRUSS_PRU0/1 enum could have been a separate patch.

>  		swap(dram0, dram1);
>  	shrd_ram = pruss->mem_regions[PRUSS_MEM_SHRD_RAM2];
>  
> @@ -747,14 +875,14 @@ static int pru_rproc_set_id(struct pru_rproc *pru)
>  	case RTU0_IRAM_ADDR_MASK:
>  		fallthrough;
>  	case PRU0_IRAM_ADDR_MASK:
> -		pru->id = 0;
> +		pru->id = PRUSS_PRU0;
>  		break;
>  	case TX_PRU1_IRAM_ADDR_MASK:
>  		fallthrough;
>  	case RTU1_IRAM_ADDR_MASK:
>  		fallthrough;
>  	case PRU1_IRAM_ADDR_MASK:
> -		pru->id = 1;
> +		pru->id = PRUSS_PRU1;
>  		break;
>  	default:
>  		ret = -EINVAL;
> @@ -816,6 +944,8 @@ static int pru_rproc_probe(struct platform_device *pdev)
>  	pru->pruss = platform_get_drvdata(ppdev);
>  	pru->rproc = rproc;
>  	pru->fw_name = fw_name;
> +	pru->client_np = NULL;
> +	mutex_init(&pru->lock);
>  
>  	for (i = 0; i < ARRAY_SIZE(mem_names); i++) {
>  		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> @@ -904,7 +1034,7 @@ MODULE_DEVICE_TABLE(of, pru_rproc_match);
>  
>  static struct platform_driver pru_rproc_driver = {
>  	.driver = {
> -		.name   = "pru-rproc",
> +		.name   = PRU_RPROC_DRVNAME,
>  		.of_match_table = pru_rproc_match,
>  		.suppress_bind_attrs = true,
>  	},
> @@ -916,5 +1046,7 @@ module_platform_driver(pru_rproc_driver);
>  MODULE_AUTHOR("Suman Anna <s-anna@ti.com>");
>  MODULE_AUTHOR("Andrew F. Davis <afd@ti.com>");
>  MODULE_AUTHOR("Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>");
> +MODULE_AUTHOR("Puranjay Mohan <p-mohan@ti.com>");
> +MODULE_AUTHOR("Md Danish Anwar <danishanwar@ti.com>");
>  MODULE_DESCRIPTION("PRU-ICSS Remote Processor Driver");
>  MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/pruss.h b/include/linux/pruss.h
> new file mode 100644
> index 000000000000..fdc719b43db0
> --- /dev/null
> +++ b/include/linux/pruss.h
> @@ -0,0 +1,56 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/**
> + * PRU-ICSS Subsystem user interfaces
> + *
> + * Copyright (C) 2015-2022 Texas Instruments Incorporated - http://www.ti.com
> + *	Suman Anna <s-anna@ti.com>
> + */
> +
> +#ifndef __LINUX_PRUSS_H
> +#define __LINUX_PRUSS_H
> +
> +#include <linux/device.h>
> +#include <linux/types.h>
> +
> +#define PRU_RPROC_DRVNAME "pru-rproc"
> +
> +/*
> + * enum pruss_pru_id - PRU core identifiers
> + */
> +enum pruss_pru_id {
> +	PRUSS_PRU0 = 0,
> +	PRUSS_PRU1,
> +	PRUSS_NUM_PRUS,
> +};
> +
> +struct device_node;
> +
> +#if IS_ENABLED(CONFIG_PRU_REMOTEPROC)
> +
> +struct rproc *pru_rproc_get(struct device_node *np, int index,
> +			    enum pruss_pru_id *pru_id);
> +void pru_rproc_put(struct rproc *rproc);
> +
> +#else
> +
> +static inline struct rproc *
> +pru_rproc_get(struct device_node *np, int index, enum pruss_pru_id *pru_id)
> +{
> +	return ERR_PTR(-EOPNOTSUPP);
> +}
> +
> +static inline void pru_rproc_put(struct rproc *rproc) { }
> +
> +#endif /* CONFIG_PRU_REMOTEPROC */
> +
> +static inline bool is_pru_rproc(struct device *dev)
> +{
> +	const char *drv_name = dev_driver_string(dev);
> +
> +	if (strncmp(drv_name, PRU_RPROC_DRVNAME, sizeof(PRU_RPROC_DRVNAME)))
> +		return false;
> +
> +	return true;
> +}
> +
> +#endif /* __LINUX_PRUSS_H */

cheers,
-roger
