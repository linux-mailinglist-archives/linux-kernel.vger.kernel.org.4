Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3616EEF72
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 09:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239713AbjDZHkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 03:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239568AbjDZHkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 03:40:06 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A1F3C31
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 00:40:05 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <pza@pengutronix.de>)
        id 1prZkd-0000oH-C7; Wed, 26 Apr 2023 09:39:43 +0200
Received: from pza by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <pza@pengutronix.de>)
        id 1prZkb-0001VM-MH; Wed, 26 Apr 2023 09:39:41 +0200
Date:   Wed, 26 Apr 2023 09:39:41 +0200
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Jacky Huang <ychuang570808@gmail.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        tmaimon77@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org, arnd@arndb.de, schung@nuvoton.com,
        mjchen@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
Subject: Re: [PATCH v8 09/11] reset: Add Nuvoton ma35d1 reset driver support
Message-ID: <20230426073941.GB4724@pengutronix.de>
References: <20230425102418.185783-1-ychuang570808@gmail.com>
 <20230425102418.185783-10-ychuang570808@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425102418.185783-10-ychuang570808@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: pza@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacky,

On Tue, Apr 25, 2023 at 10:24:16AM +0000, Jacky Huang wrote:
> From: Jacky Huang <ychuang3@nuvoton.com>
> 
> This driver supports individual IP reset for ma35d1. The reset
> control registers is a subset of system control registers.
> 
> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
> ---
>  drivers/reset/Kconfig        |   6 +
>  drivers/reset/Makefile       |   1 +
>  drivers/reset/reset-ma35d1.c | 229 +++++++++++++++++++++++++++++++++++
[...]
> diff --git a/drivers/reset/reset-ma35d1.c b/drivers/reset/reset-ma35d1.c
> new file mode 100644
> index 000000000000..648b380becf7
> --- /dev/null
> +++ b/drivers/reset/reset-ma35d1.c
> @@ -0,0 +1,229 @@
[...]
> +static int ma35d1_reset_update(struct reset_controller_dev *rcdev,
> +			       unsigned long id, bool assert)
> +{
> +	u32 reg;
> +	struct ma35d1_reset_data *data = container_of(rcdev,
> +						      struct ma35d1_reset_data,
> +						      rcdev);
> +
> +	reg = readl_relaxed(data->base + ma35d1_reset_map[id].reg_ofs);
> +	if (assert)
> +		reg |= BIT(ma35d1_reset_map[id].bit);
> +	else
> +		reg &= ~(BIT(ma35d1_reset_map[id].bit));
> +	writel_relaxed(reg, data->base + ma35d1_reset_map[id].reg_ofs);

This is missing a spinlock to protect the read-modify-write cycle from
simultaneous updates.

[...]
> +static int ma35d1_reset_probe(struct platform_device *pdev)
> +{
> +	int err;
> +	struct device *dev = &pdev->dev;
> +	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	struct ma35d1_reset_data *reset_data;
> +
> +	if (!pdev->dev.of_node) {
> +		dev_err(&pdev->dev, "Device tree node not found\n");
> +		return -EINVAL;
> +	}
> +
> +	reset_data = devm_kzalloc(dev, sizeof(*reset_data), GFP_KERNEL);
> +	if (!reset_data)
> +		return -ENOMEM;
> +
> +	reset_data->base = devm_ioremap_resource(&pdev->dev, res);

You could use devm_platform_ioremap_resource() here.

regards
Philipp
