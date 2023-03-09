Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347E86B1BAC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 07:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjCIGmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 01:42:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjCIGmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 01:42:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A277A2B9C1;
        Wed,  8 Mar 2023 22:42:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27AAF616B3;
        Thu,  9 Mar 2023 06:41:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06258C433D2;
        Thu,  9 Mar 2023 06:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678344091;
        bh=anlaQGXty2j4C1rrpEoCgHw52aLsUAs5MLJO7BHeLtw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tp9UzSYOO7BblVcizcgJB0esyCT6luFhHreKeawJZE6BxreN6ibZ6wbkze8JzrZvm
         1nAeEs0nKuc+Du2rjYFK/qrr++qdd2iuphGhl0/2UezDrdhTaen4go1SOHXwEd/C7S
         OmtiiYzQy3znxH/FHwl/NvEYL2vHh3h0+MA78xVo=
Date:   Thu, 9 Mar 2023 07:41:28 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     srinivas.kandagatla@linaro.org, mathias.nyman@intel.com,
        perex@perex.cz, broonie@kernel.org, lgirdwood@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        Thinh.Nguyen@synopsys.com, bgoswami@quicinc.com,
        andersson@kernel.org, robh+dt@kernel.org, tiwai@suse.com,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, quic_jackp@quicinc.com,
        quic_plai@quicinc.com
Subject: Re: [PATCH v3 04/28] ASoC: Add SOC USB APIs for adding an USB backend
Message-ID: <ZAl/mHuP7U6zgzmZ@kroah.com>
References: <20230308235751.495-1-quic_wcheng@quicinc.com>
 <20230308235751.495-5-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308235751.495-5-quic_wcheng@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023 at 03:57:27PM -0800, Wesley Cheng wrote:
> Some platforms may have support for offloading USB audio devices to a
> dedicated audio DSP.  Introduce a set of APIs that allow for management of
> USB sound card and PCM devices enumerated by the USB SND class driver.
> This allows for the ASoC components to be aware of what USB devices are
> available for offloading.
> 
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> ---
>  include/sound/soc-usb.h |  35 ++++++++
>  sound/soc/Makefile      |   2 +-
>  sound/soc/soc-usb.c     | 180 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 216 insertions(+), 1 deletion(-)
>  create mode 100644 include/sound/soc-usb.h
>  create mode 100644 sound/soc/soc-usb.c
> 
> diff --git a/include/sound/soc-usb.h b/include/sound/soc-usb.h
> new file mode 100644
> index 000000000000..378992ea07bd
> --- /dev/null
> +++ b/include/sound/soc-usb.h
> @@ -0,0 +1,35 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#ifndef __LINUX_SND_SOC_USB_H
> +#define __LINUX_SND_SOC_USB_H
> +
> +/**
> + * struct snd_soc_usb
> + * @list - list head for SND SOC struct list
> + * @dev - USB backend device reference
> + * @component - reference to DAPM component
> + * @connection_status_cb - callback to notify connection events
> + * @priv_data - driver data
> + **/
> +struct snd_soc_usb {
> +	struct list_head list;
> +	struct device *dev;

If this is a USB device, then make it a pointer to the real structure,
not just struct device.


> +	struct snd_soc_component *component;
> +	int (*connection_status_cb)(struct snd_soc_usb *usb, int card_idx,
> +				int connected);
> +	void *priv_data;
> +};
> +
> +int snd_soc_usb_connect(struct device *usbdev, int card_idx);
> +int snd_soc_usb_disconnect(struct device *usbdev);
> +void snd_soc_usb_set_priv_data(struct device *dev, void *priv);
> +void *snd_soc_usb_get_priv_data(struct device *usbdev);

Same here, you mix "dev" and "usbdev" in the names, make them real USB
devices please.


> +
> +struct snd_soc_usb *snd_soc_usb_add_port(struct device *dev, void *priv,

And here.

> +			int (*connection_cb)(struct snd_soc_usb *usb, int card_idx,
> +			int connected));
> +int snd_soc_usb_remove_port(struct device *dev);
> +#endif
> diff --git a/sound/soc/Makefile b/sound/soc/Makefile
> index 507eaed1d6a1..3305ceb59d84 100644
> --- a/sound/soc/Makefile
> +++ b/sound/soc/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> -snd-soc-core-objs := soc-core.o soc-dapm.o soc-jack.o soc-utils.o soc-dai.o soc-component.o
> +snd-soc-core-objs := soc-core.o soc-dapm.o soc-jack.o soc-usb.o soc-utils.o soc-dai.o soc-component.o
>  snd-soc-core-objs += soc-pcm.o soc-devres.o soc-ops.o soc-link.o soc-card.o
>  snd-soc-core-$(CONFIG_SND_SOC_COMPRESS) += soc-compress.o
>  
> diff --git a/sound/soc/soc-usb.c b/sound/soc/soc-usb.c
> new file mode 100644
> index 000000000000..4293451cdd49
> --- /dev/null
> +++ b/sound/soc/soc-usb.c
> @@ -0,0 +1,180 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +#include <linux/of.h>
> +#include <linux/usb.h>
> +#include <sound/soc.h>
> +#include <sound/soc-usb.h>
> +#include "../usb/card.h"
> +
> +static DEFINE_MUTEX(ctx_mutex);
> +static LIST_HEAD(usb_ctx_list);
> +
> +static struct device_node *snd_soc_find_phandle(struct device *dev)
> +{
> +	struct device_node *node;
> +
> +	node = of_parse_phandle(dev->of_node, "usb-soc-be", 0);
> +	if (!node)
> +		return ERR_PTR(-ENODEV);
> +
> +	return node;
> +}
> +
> +static struct snd_soc_usb *snd_soc_find_usb_ctx(struct device *dev)
> +{
> +	struct device_node *node;
> +	struct snd_soc_usb *ctx = NULL;
> +
> +	node = snd_soc_find_phandle(dev);
> +	if (IS_ERR(node))
> +		return NULL;
> +
> +	mutex_lock(&ctx_mutex);
> +	list_for_each_entry(ctx, &usb_ctx_list, list) {
> +		if (ctx->dev->of_node == node) {
> +			of_node_put(node);
> +			mutex_unlock(&ctx_mutex);
> +			return ctx;
> +		}
> +	}
> +	of_node_put(node);
> +	mutex_unlock(&ctx_mutex);
> +
> +	return NULL;
> +}
> +
> +/**
> + * snd_soc_usb_get_priv_data() - Retrieve private data stored
> + * @dev: device reference
> + *
> + * Fetch the private data stored in the USB SND SOC structure.
> + *
> + */
> +void *snd_soc_usb_get_priv_data(struct device *dev)
> +{
> +	struct snd_soc_usb *ctx;
> +
> +	ctx = snd_soc_find_usb_ctx(dev);
> +	if (!ctx) {
> +		/* Check if backend device */
> +		list_for_each_entry(ctx, &usb_ctx_list, list) {
> +			if (dev->of_node == ctx->dev->of_node)
> +				goto out;

No locking for this list traversal?

thanks,

greg k-h
