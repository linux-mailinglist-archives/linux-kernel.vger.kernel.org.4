Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330B9701DDD
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 16:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbjENOcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 10:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjENOb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 10:31:59 -0400
Received: from smtp.smtpout.orange.fr (smtp-29.smtpout.orange.fr [80.12.242.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2376C30CF
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 07:31:56 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id yClJps2VJKyEByClJpiTwJ; Sun, 14 May 2023 16:31:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1684074714;
        bh=6dTqDvAKG79B/2e2RDgHQKyZvLzcOF4scBFg7nUwea4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=MI9OJ8Svm31cyT9bP/+QGf/dgGfmyuld8CPIVqfZ3UW+0jNrNwQ9udVp7Z1kq1cQ+
         veoATUUZ8OEcBQQsbXZcoir1Vvp8o9gMr3MPk1eZhyLjKFE8JGlgsfSGakdUuPlBBi
         /xwvBBC9O4XI/Si7mmb27L0mfwY6RLcgx4NlwMKlW14I/usuXDA1Q1SyOmsc0NaStG
         HpiklhZFJwamsYnbr/KkdlgsqGGTDjXSFEN6epIFkC2+cjSfvf5h/nRjWYktpiiOMT
         WLhCrsTFDGGGCoHIinYCRt1pL+XGWc0fYvEF1kjwmlnV5dX3VtPkBOgqX4d7Ne5cX/
         AaY8xf3yq8zwQ==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 14 May 2023 16:31:54 +0200
X-ME-IP: 86.243.2.178
Message-ID: <2e0f37ef-b80c-1a4d-2159-29598ac11156@wanadoo.fr>
Date:   Sun, 14 May 2023 16:31:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 05/10] power: supply: rt5033_charger: Add RT5033
 charger device driver
Content-Language: fr
To:     jahau@rocketmail.com
Cc:     axel.lin@ingics.com, beomho.seo@samsung.com, broonie@kernel.org,
        cw00.choi@samsung.com, cy_huang@richtek.com,
        devicetree@vger.kernel.org, henrik@grimler.se,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        lgirdwood@gmail.com, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        pavel@ucw.cz, phone-devel@vger.kernel.org,
        raymondhackley@protonmail.com, robh+dt@kernel.org, sre@kernel.org,
        stephan@gerhold.net, ~postmarketos/upstreaming@lists.sr.ht
References: <20230514123130.41172-1-jahau@rocketmail.com>
 <20230514123130.41172-6-jahau@rocketmail.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230514123130.41172-6-jahau@rocketmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 14/05/2023 à 14:31, Jakob Hauser a écrit :
> This patch adds device driver of Richtek RT5033 PMIC. The driver supports
> switching charger. rt5033 charger provides three charging modes. The charging
> modes are pre-charge mode, fast charge mode and constant voltage mode. They
> vary in charge rate, the charge parameters can be controlled by i2c interface.
> 
> Cc: Beomho Seo <beomho.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> Cc: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> Tested-by: Raymond Hackley <raymondhackley-g/b1ySJe57IN+BqQ9rBEUg@public.gmane.org>
> Signed-off-by: Jakob Hauser <jahau-ur4TIblo6goN+BqQ9rBEUg@public.gmane.org>
> Reviewed-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>   drivers/power/supply/Kconfig          |   8 +
>   drivers/power/supply/Makefile         |   1 +
>   drivers/power/supply/rt5033_charger.c | 472 ++++++++++++++++++++++++++
>   include/linux/mfd/rt5033.h            |  16 -
>   4 files changed, 481 insertions(+), 16 deletions(-)
>   create mode 100644 drivers/power/supply/rt5033_charger.c
> 

[...]

> +static int rt5033_charger_probe(struct platform_device *pdev)
> +{
> +	struct rt5033_charger *charger;
> +	struct power_supply_config psy_cfg = {};
> +	int ret;
> +
> +	charger = devm_kzalloc(&pdev->dev, sizeof(*charger), GFP_KERNEL);
> +	if (!charger)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, charger);
> +	charger->dev = &pdev->dev;
> +	charger->regmap = dev_get_regmap(pdev->dev.parent, NULL);
> +
> +	psy_cfg.of_node = pdev->dev.of_node;
> +	psy_cfg.drv_data = charger;
> +
> +	charger->psy = devm_power_supply_register(&pdev->dev,
> +						  &rt5033_charger_desc,
> +						  &psy_cfg);
> +	if (IS_ERR(charger->psy))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(charger->psy),
> +				     "Failed to register power supply\n");
> +
> +	charger->chg = rt5033_charger_dt_init(charger);
> +	if (IS_ERR_OR_NULL(charger->chg))

Hi,

Nit: charger->chg can't be NULL.

> +		return -ENODEV;

Why bother returning specific error code in rt5033_charger_dt_init() if 
they are eaten here.

return PTR_ERR(charger->chg)?


CJ

> +
> +	ret = rt5033_charger_reg_init(charger);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}

[...]
