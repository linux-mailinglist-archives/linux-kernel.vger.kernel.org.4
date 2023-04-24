Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B87E6ED5CA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 22:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbjDXUDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 16:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbjDXUDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 16:03:10 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D498E1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 13:03:09 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <pza@pengutronix.de>)
        id 1pr2Ol-0008E0-El; Mon, 24 Apr 2023 22:02:55 +0200
Received: from pza by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <pza@pengutronix.de>)
        id 1pr2Oj-0004R7-Ph; Mon, 24 Apr 2023 22:02:53 +0200
Date:   Mon, 24 Apr 2023 22:02:53 +0200
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Jacky Huang <ychuang570808@gmail.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
Subject: Re: [PATCH v6 10/12] reset: Add Nuvoton ma35d1 reset driver support
Message-ID: <20230424200253.GC30248@pengutronix.de>
References: <20230328021912.177301-1-ychuang570808@gmail.com>
 <20230328021912.177301-11-ychuang570808@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328021912.177301-11-ychuang570808@gmail.com>
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

On Tue, Mar 28, 2023 at 02:19:10AM +0000, Jacky Huang wrote:
> From: Jacky Huang <ychuang3@nuvoton.com>
> 
> This driver supports individual IP reset for ma35d1. The reset
> control registers is a subset of system control registers.
> 
> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
> ---
>  drivers/reset/Kconfig        |   6 ++
>  drivers/reset/Makefile       |   1 +
>  drivers/reset/reset-ma35d1.c | 152 +++++++++++++++++++++++++++++++++++
>  3 files changed, 159 insertions(+)
>  create mode 100644 drivers/reset/reset-ma35d1.c
> 
[...]
> diff --git a/drivers/reset/reset-ma35d1.c b/drivers/reset/reset-ma35d1.c
> new file mode 100644
> index 000000000000..221299e7b873
> --- /dev/null
> +++ b/drivers/reset/reset-ma35d1.c
> @@ -0,0 +1,152 @@
[...]
> +static int ma35d1_reset_update(struct reset_controller_dev *rcdev,
> +			       unsigned long id, bool assert)
> +{
> +	unsigned int reg;
> +	int ret;
> +	int offset = (id / RST_PRE_REG) * 4;
> +	struct ma35d1_reset_data *data =
> +			container_of(rcdev, struct ma35d1_reset_data, rcdev);
> +
> +	ret = regmap_read(data->regmap, REG_SYS_IPRST0 + offset, &reg);
> +	if (ret < 0)
> +		return ret;
> +	if (assert)
> +		reg |= 1 << (id % RST_PRE_REG);
> +	else
> +		reg &= ~(1 << (id % RST_PRE_REG));
> +
> +	return regmap_write(data->regmap, REG_SYS_IPRST0 + offset, reg);

This should use regmap_update_bits().

[...]
> +static int ma35d1_reset_status(struct reset_controller_dev *rcdev,
> +			      unsigned long id)
> +{
> +	int reg, ret;
> +	int offset = id / RST_PRE_REG;

Should this be

	int offset = (id / RST_PRE_REG) * 4;

?

> +static int ma35d1_reset_probe(struct platform_device *pdev)
> +{
> +	int err;
> +	struct device *dev = &pdev->dev;
> +	struct device_node *parent;
> +	struct ma35d1_reset_data *reset_data;
> +	struct ma35d1_reboot_data *reboot_data;
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
> +	reboot_data = devm_kzalloc(dev, sizeof(*reboot_data), GFP_KERNEL);
> +	if (!reboot_data)
> +		return -ENOMEM;

These structures could be combined into one.

regards
Philipp
