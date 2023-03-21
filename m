Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79076C2F29
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 11:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjCUKgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 06:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjCUKgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 06:36:47 -0400
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBCCD193C8;
        Tue, 21 Mar 2023 03:36:10 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 2D1131343;
        Tue, 21 Mar 2023 11:36:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1679394966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E0MuSZFY8OGr+b15UxWX+eX6mHT3AIP15MrknYT0oDo=;
        b=SYUR6h5ShloAmYOjykyuNNESDI6xZ92J1NZljaxgdIBboeWcWErdhkrNePPyKYGro2kE4k
        HVFfr/+/dNP+X0ckUs7pomi7/cIU9ga7I9I/FmZSnFsSJvs5/HOvS/Zu6+em3AbjFv1rG7
        5oJxDEN6Y74ByO7vPdtHskc1yqIwdM60BnPuw/S5IqG92SAUl3ExnlXZebl8H7E3Kvyb/w
        /eIs57oU4z8whxiCJPeK+tJ1VU6A2xzhfv4HnsjidOl2rJDAEjbrALVIdRYOhOxZioqEdx
        rEOyYgFeHk41EWZDnXLL3FIj5JLy9uO+4DrTXvfe8no37uaLyOFBgiihuGOzaQ==
MIME-Version: 1.0
Date:   Tue, 21 Mar 2023 11:36:05 +0100
From:   Michael Walle <michael@walle.cc>
To:     =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Ra?= =?UTF-8?Q?fa=C5=82_Mi=C5=82ecki?= 
        <rafal@milecki.pl>
Subject: Re: [PATCH V5 3/3] nvmem: core: add support for fixed cells *layout*
In-Reply-To: <20230321102418.4190-4-zajec5@gmail.com>
References: <20230321102418.4190-1-zajec5@gmail.com>
 <20230321102418.4190-4-zajec5@gmail.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <024fd4500089d479b60580449d3567b8@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2023-03-21 11:24, schrieb Rafał Miłecki:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> This adds support for the "fixed-layout" NVMEM layout binding. It 
> allows
> defining NVMEM cells in a layout DT node named "nvmem-layout".
> 
> While NVMEM subsystem supports layout drivers it has been discussed 
> that
> "fixed-layout" may actually be supperted internally. It's because:
> 1. It's a very basic layout
> 2. It allows sharing code with legacy syntax parsing
> 3. It's safer for soc_device_match() due to -EPROBE_DEFER
> 4. This will make the syntax transition easier
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>  drivers/nvmem/core.c | 32 +++++++++++++++++++++++++++++---
>  1 file changed, 29 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 212c5ba5789f..591b640f53dd 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -694,7 +694,7 @@ static int nvmem_validate_keepouts(struct
> nvmem_device *nvmem)
>  	return 0;
>  }
> 
> -static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
> +static int nvmem_add_cells_from_dt(struct nvmem_device *nvmem, struct
> device_node *np)
>  {
>  	struct nvmem_layout *layout = nvmem->layout;
>  	struct device *dev = &nvmem->dev;
> @@ -702,7 +702,7 @@ static int nvmem_add_cells_from_of(struct
> nvmem_device *nvmem)
>  	const __be32 *addr;
>  	int len, ret;
> 
> -	for_each_child_of_node(dev->of_node, child) {
> +	for_each_child_of_node(np, child) {
>  		struct nvmem_cell_info info = {0};
> 
>  		addr = of_get_property(child, "reg", &len);
> @@ -740,6 +740,28 @@ static int nvmem_add_cells_from_of(struct
> nvmem_device *nvmem)
>  	return 0;
>  }
> 
> +static int nvmem_add_cells_from_legacy_of(struct nvmem_device *nvmem)
> +{
> +	return nvmem_add_cells_from_dt(nvmem, nvmem->dev.of_node);
> +}
> +
> +static int nvmem_add_cells_fixed(struct nvmem_device *nvmem)
> +{
> +	struct device_node *layout_np;
> +	int err = 0;
> +
> +	layout_np = of_nvmem_layout_get_container(nvmem);
> +	if (!layout_np)
> +		return 0;
> +
> +	if (of_device_is_compatible(layout_np, "fixed-layout"))
> +		err = nvmem_add_cells_from_dt(nvmem, layout_np);
> +
> +	of_node_put(layout_np);
> +
> +	return err;
> +}
> +
>  int __nvmem_layout_register(struct nvmem_layout *layout, struct module 
> *owner)
>  {
>  	layout->owner = owner;
> @@ -970,7 +992,7 @@ struct nvmem_device *nvmem_register(const struct
> nvmem_config *config)
>  	if (rval)
>  		goto err_remove_cells;
> 
> -	rval = nvmem_add_cells_from_of(nvmem);
> +	rval = nvmem_add_cells_from_legacy_of(nvmem);
>  	if (rval)
>  		goto err_remove_cells;
> 
> @@ -980,6 +1002,10 @@ struct nvmem_device *nvmem_register(const struct
> nvmem_config *config)
>  	if (rval)
>  		goto err_remove_cells;
> 
> +	rval = nvmem_add_cells_fixed(nvmem);

nvmem_add_cells_from_fixed_layout()?

Reviewed-by: Michael Walle <michael@walle.cc>

> +	if (rval)
> +		goto err_remove_cells;
> +
>  	rval = nvmem_add_cells_from_layout(nvmem);
>  	if (rval)
>  		goto err_remove_cells;
