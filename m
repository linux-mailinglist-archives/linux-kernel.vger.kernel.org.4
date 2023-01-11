Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57576654E5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 07:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235730AbjAKGwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 01:52:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235515AbjAKGwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 01:52:37 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F41614C
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 22:52:36 -0800 (PST)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1pFUyJ-0006cZ-Bc; Wed, 11 Jan 2023 07:52:27 +0100
Message-ID: <d7951827-1023-4cd6-4230-0915716ee276@pengutronix.de>
Date:   Wed, 11 Jan 2023 07:52:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/6] nvmem: core: add nvmem_dev_size() helper
Content-Language: en-US
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     devicetree@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, u-boot@lists.denx.de,
        Michael Walle <michael@walle.cc>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
References: <20230110105425.13188-1-zajec5@gmail.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <20230110105425.13188-1-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.01.23 11:54, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> This is required by layouts that need to read whole NVMEM space. It
> applies to NVMEM devices without hardcoded layout (like U-Boot
> environment data block).
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>  drivers/nvmem/core.c           | 13 +++++++++++++
>  include/linux/nvmem-consumer.h |  1 +
>  2 files changed, 14 insertions(+)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 1f05f0a50d86..81743ae8793b 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -2062,6 +2062,19 @@ void nvmem_del_cell_lookups(struct nvmem_cell_lookup *entries, size_t nentries)
>  }
>  EXPORT_SYMBOL_GPL(nvmem_del_cell_lookups);
>  
> +/**
> + * nvmem_dev_size() - Get the size of a given nvmem device.
> + *
> + * @nvmem: nvmem device.
> + *
> + * Return: size of the nvmem device.
> + */
> +const size_t nvmem_dev_size(struct nvmem_device *nvmem)

The const here is quite unusual. You can make the parameter
a const struct nvmem_device though.

> +{
> +	return nvmem->size;
> +}
> +EXPORT_SYMBOL_GPL(nvmem_dev_size);
> +
>  /**
>   * nvmem_dev_name() - Get the name of a given nvmem device.
>   *
> diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
> index fa030d93b768..d88294ddf562 100644
> --- a/include/linux/nvmem-consumer.h
> +++ b/include/linux/nvmem-consumer.h
> @@ -78,6 +78,7 @@ ssize_t nvmem_device_cell_read(struct nvmem_device *nvmem,
>  int nvmem_device_cell_write(struct nvmem_device *nvmem,
>  			    struct nvmem_cell_info *info, void *buf);
>  
> +const size_t nvmem_dev_size(struct nvmem_device *nvmem);
>  const char *nvmem_dev_name(struct nvmem_device *nvmem);
>  
>  void nvmem_add_cell_lookups(struct nvmem_cell_lookup *entries,

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

