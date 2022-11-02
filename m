Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC27A615FF4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 10:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbiKBJhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 05:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbiKBJhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 05:37:33 -0400
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B9B2180F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 02:37:31 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id qABVoCLrinj75qABVocwYJ; Wed, 02 Nov 2022 10:37:29 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 02 Nov 2022 10:37:29 +0100
X-ME-IP: 86.243.100.34
Message-ID: <74726285-ae5a-459d-7b83-31025e47ea03@wanadoo.fr>
Date:   Wed, 2 Nov 2022 10:37:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [v3 3/3] hwmon: Add Aspeed ast2600 TACH support
To:     Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        joel@jms.id.au, andrew@aj.id.au, lee.jones@linaro.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        p.zabel@pengutronix.de, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, BMC-SW@aspeedtech.com,
        garnermic@meta.com
References: <20221102083601.10456-1-billy_tsai@aspeedtech.com>
 <20221102083601.10456-4-billy_tsai@aspeedtech.com>
Content-Language: fr
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20221102083601.10456-4-billy_tsai@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 02/11/2022 à 09:36, Billy Tsai a écrit :
> This patch add the support of Tachometer which can use to monitor the
> frequency of the input. The tach supports up to 16 channels and it's part
> function of multi-function device "pwm-tach controller".
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
>   Documentation/hwmon/index.rst               |   1 +
>   Documentation/hwmon/tach-aspeed-ast2600.rst |  28 ++
>   drivers/hwmon/Kconfig                       |   9 +
>   drivers/hwmon/Makefile                      |   1 +
>   drivers/hwmon/tach-aspeed-ast2600.c         | 476 ++++++++++++++++++++
>   5 files changed, 515 insertions(+)
>   create mode 100644 Documentation/hwmon/tach-aspeed-ast2600.rst
>   create mode 100644 drivers/hwmon/tach-aspeed-ast2600.c
> 

[...]

> +static int aspeed_tach_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np, *child;
> +	struct aspeed_tach_data *priv;
> +	struct device *hwmon;
> +	struct platform_device *parent_dev;
> +	int ret;
> +
> +	np = dev->parent->of_node;
> +	if (!of_device_is_compatible(np, "aspeed,ast2600-pwm-tach"))
> +		return dev_err_probe(dev, -ENODEV,
> +				     "Unsupported tach device binding\n");
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +	priv->dev = &pdev->dev;
> +	priv->tach_channel =
> +		devm_kcalloc(dev, TACH_ASPEED_NR_TACHS,
> +			     sizeof(*priv->tach_channel), GFP_KERNEL);

Hi,
the error handling is still missing:

	if (!priv->tach_channel)
		return -ENOMEM;

CJ

> +
> +	priv->regmap = syscon_node_to_regmap(np);
> +	if (IS_ERR(priv->regmap))
> +		return dev_err_probe(dev, PTR_ERR(priv->regmap),
> +				     "Couldn't get regmap\n");
> +	parent_dev = of_find_device_by_node(np);
> +	priv->clk = devm_clk_get_enabled(&parent_dev->dev, NULL);
> +	if (IS_ERR(priv->clk))
> +		return dev_err_probe(dev, PTR_ERR(priv->clk),
> +				     "Couldn't get clock\n");
> +

[...]

