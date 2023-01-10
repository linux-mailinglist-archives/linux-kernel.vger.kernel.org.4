Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0407B664054
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 13:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238119AbjAJMV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 07:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238435AbjAJMUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 07:20:52 -0500
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40988669A8;
        Tue, 10 Jan 2023 04:19:12 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 0790415E8;
        Tue, 10 Jan 2023 13:19:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1673353150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vg0R9V13voCKreQZ5cG3ECpcKyIv8/ruYPHBw0+RoOk=;
        b=RHKQYdi6wDRUpTm2h+G1yDBt0uW0qQSuBlxc9wKnnz+ETGbjJi6gRdZuK+xd1QYncL7QtR
        59V5NbeKoM3QT0dQiewQ37ZtHfuXbL3knBAQSLBoM5mFtkFjFrorUFNsSCzX3DvntAPEfm
        kaAzBlhyJQ9EQNRBSzHfnR9IWhoHh4oN4TwSBhp5k0EryJ3sDR7eH1lt8bHwhjhNF4qyly
        c44B8GsK5nnzfr8JsoQx5+L9SCsxAGigKYLF6PlB2ERdt0VA/ABPNsAzCMLBHhu/CWKD1q
        R2/t6lmnhGtwJF9xjiLpTTP3nyqQZe+nr4eb5d26K+kBcJGM74jUVAAL0UNa+w==
MIME-Version: 1.0
Date:   Tue, 10 Jan 2023 13:19:09 +0100
From:   Michael Walle <michael@walle.cc>
To:     =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, u-boot@lists.denx.de,
        =?UTF-8?Q?Rafa?= =?UTF-8?Q?=C5=82_Mi=C5=82ecki?= 
        <rafal@milecki.pl>
Subject: Re: [PATCH 6/6] nvmem: u-boot-env: post process "ethaddr" env
 variable
In-Reply-To: <20230110105425.13188-6-zajec5@gmail.com>
References: <20230110105425.13188-1-zajec5@gmail.com>
 <20230110105425.13188-6-zajec5@gmail.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <c4cc5b274745fe9dcb83747e74879582@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 2023-01-10 11:54, schrieb Rafał Miłecki:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> U-Boot environment variables are stored in ASCII format so "ethaddr"
> requires parsing into binary to make it work with Ethernet interfaces.
> 
> This includes support for indexes to support #nvmem-cell-cells = <1>.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>  drivers/nvmem/layouts/Kconfig      |  1 +
>  drivers/nvmem/layouts/u-boot-env.c | 24 ++++++++++++++++++++++++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/drivers/nvmem/layouts/Kconfig 
> b/drivers/nvmem/layouts/Kconfig
> index 8a38c514943a..566b4f25630d 100644
> --- a/drivers/nvmem/layouts/Kconfig
> +++ b/drivers/nvmem/layouts/Kconfig
> @@ -23,6 +23,7 @@ config NVMEM_LAYOUT_ONIE_TLV
>  config NVMEM_LAYOUT_U_BOOT_ENV
>  	bool "U-Boot environment variables support"
>  	select CRC32
> +	select GENERIC_NET_UTILS
>  	help
>  	  U-Boot stores its setup as environment variables. This driver adds
>  	  support for verifying & exporting such data. It also exposes 
> variables
> diff --git a/drivers/nvmem/layouts/u-boot-env.c
> b/drivers/nvmem/layouts/u-boot-env.c
> index 95c314553952..63baeb18bd56 100644
> --- a/drivers/nvmem/layouts/u-boot-env.c
> +++ b/drivers/nvmem/layouts/u-boot-env.c
> @@ -4,6 +4,8 @@
>   */
> 
>  #include <linux/crc32.h>
> +#include <linux/etherdevice.h>
> +#include <linux/if_ether.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/nvmem-consumer.h>
> @@ -36,6 +38,26 @@ struct u_boot_env_image_broadcom {
>  	uint8_t data[];
>  } __packed;
> 
> +static int u_boot_env_read_post_process_ethaddr(void *context, const
> char *id, int index,
> +						unsigned int offset, void *data, size_t *bytes)
> +{
> +	u8 mac[ETH_ALEN];
> +
> +	if (*bytes != 3 * ETH_ALEN - 1)
> +		return -EINVAL;
> +
> +	if (!mac_pton(data, mac))
> +		return -EINVAL;
> +
> +	if (index)
> +		eth_addr_add(mac, index);
> +
> +	ether_addr_copy(data, mac);
> +	*bytes = ETH_ALEN;

I don't know how to feel about this. This will only work if the new
size is smaller than the old one. Can't we have a correct size in
the first place? I.e. while adding the cells.

-michael

> +
> +	return 0;
> +}
> +
>  static int u_boot_env_parse_data(struct device *dev, struct
> nvmem_device *nvmem, uint8_t *buf,
>  				 size_t data_offset, size_t data_len)
>  {
> @@ -67,6 +89,8 @@ static int u_boot_env_parse_data(struct device *dev,
> struct nvmem_device *nvmem,
>  		info.offset = data_offset + value - data;
>  		info.bytes = strlen(value);
>  		info.np = of_get_child_by_name(np, info.name);
> +		if (!strcmp(var, "ethaddr"))
> +			info.read_post_process = u_boot_env_read_post_process_ethaddr;
> 
>  		err = nvmem_add_one_cell(nvmem, &info);
>  		if (err) {
