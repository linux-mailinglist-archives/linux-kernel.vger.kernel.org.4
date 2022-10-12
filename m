Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB485FC078
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 08:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiJLGO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 02:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJLGOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 02:14:53 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F49C13F4D;
        Tue, 11 Oct 2022 23:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1665555291; x=1697091291;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dIiJvNW9H0kZKHNV27mWxIVX92jlmQwVIvQ4BR+HJoM=;
  b=Zceooy0Fa84SoSXDY2xhHiZ3ZUvV9TXmmV5n4QxivcUqNLAtGToK+U4+
   4mzD6nEjviilBWtHl8lL14L309GWp2Eoct7GYh7tD7ffJH3G8OqD9ukyn
   nVaIwxWGVC1KGC7vhiHvzP4g6tbm0TSkKtwuX0TyDsaYRZUmMT4f03k2w
   Eoev9jvlPhu0Xnhgp4wsFeo/R7CDLrFovc+aEZusrrFq0YhymrWVtRtmW
   2cHSzofNJI6/cvj8r8mHFkYRhlD90zmUtjw9oKU+UVx9I6pGH65RXof/N
   qpju3npfNcsf73DI8vrDgcuEZTg4s8TdzrixJQQ841ekesAW0xdcLRS0j
   A==;
X-IronPort-AV: E=Sophos;i="5.95,178,1661810400"; 
   d="scan'208";a="26694906"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 12 Oct 2022 08:14:49 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 12 Oct 2022 08:14:49 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 12 Oct 2022 08:14:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1665555289; x=1697091289;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dIiJvNW9H0kZKHNV27mWxIVX92jlmQwVIvQ4BR+HJoM=;
  b=RNqiXoFQo7zQbSSFG/qdDhO/QBi6zVbnFUWodQwQJ0idHfjCiRqzwaIN
   y7L+yS8I+OjwEVaT9iOf3dBxAD9fcGb9kHiGW/mkpddmJmy2rxspKj39g
   akHoRGohNqh12eD1kkWWjUGAFR/BSzgwa0SaDuDFf4utLOl5w4FT7A+x+
   x+1t0Ajc3mXRxOxtH9jzhz9H1Ek1jfoKwAvi0TNkeYE8wFdVaDTHNDGJ3
   px8v9CjM3o7Vy0af/DvyX1i3H7v6B9LJbQdNtdMK3hrDe469aRfPDdu4g
   lgXnW65xwfUFp15CntwQUT1VFMUyQXVMCjDDDxebL13wIYvhGGv3U3ZlK
   A==;
X-IronPort-AV: E=Sophos;i="5.95,178,1661810400"; 
   d="scan'208";a="26694905"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 12 Oct 2022 08:14:49 +0200
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 65155280056;
        Wed, 12 Oct 2022 08:14:49 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-arm-kernel@lists.infradead.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 7/7] gpiolib: of: add quirk for phy reset polarity for Freescale Ethernet
Date:   Wed, 12 Oct 2022 08:14:46 +0200
Message-ID: <12081856.O9o76ZdvQC@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20221011-gpiolib-quirks-v1-7-e01d9d3e7b29@gmail.com>
References: <20221011-gpiolib-quirks-v1-0-e01d9d3e7b29@gmail.com> <20221011-gpiolib-quirks-v1-7-e01d9d3e7b29@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 12. Oktober 2022, 00:19:35 CEST schrieb Dmitry Torokhov:
> Bindings for Freescale Fast Ethernet Controller use a separate
> property "phy-reset-active-high" to specify polarity of its phy
> gpio line. To allow converting the driver to gpiod API we need
> to add this quirk to gpiolib.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/gpio/gpiolib-of.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
> index 3200d705fbe3..c3d3fe4d927c 100644
> --- a/drivers/gpio/gpiolib-of.c
> +++ b/drivers/gpio/gpiolib-of.c
> @@ -231,6 +231,33 @@ static void of_gpio_flags_quirks(const struct
> device_node *np, !strcmp(propname, "snps,reset-gpio") &&
>  	    of_property_read_bool(np, "snps,reset-active-low"))
>  		*flags |= OF_GPIO_ACTIVE_LOW;
> +
> +	/*
> +	 * Freescale Fast Ethernet Controller uses a separate property to
> +	 * describe polarity of the phy reset line.
> +	 */
> +	if (IS_ENABLED(CONFIG_FEC)) {
> +		static const char * const fec_devices[] = {
> +			"fsl,imx25-fec",
> +			"fsl,imx27-fec",
> +			"fsl,imx28-fec",
> +			"fsl,imx6q-fec",
> +			"fsl,mvf600-fec",
> +			"fsl,imx6sx-fec",
> +			"fsl,imx6ul-fec",

> +			"fsl,imx6mq-fec",
> +			"fsl,imx6qm-fec",

These two should be 'fsl,imx8mq-fec' & 'fsl,imx8qm-fec' (imx8 instead of 
imx6).

Best regards,
Alexander

> +			"fsl,s32v234-fec",
> +			NULL
> +		};
> +
> +		if (!strcmp(propname, "phy-reset-gpios") &&
> +		    of_device_compatible_match(np, fec_devices)) {
> +			bool active_high = of_property_read_bool(np,
> +						"phy-reset-
active-high");
> +			of_gpio_quirk_polarity(np, active_high, 
flags);
> +		}
> +	}
>  }
> 
>  /**




