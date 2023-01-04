Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1708B65DAD6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 17:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240093AbjADQ5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 11:57:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240356AbjADQ5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 11:57:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A81C00;
        Wed,  4 Jan 2023 08:55:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3434B617B3;
        Wed,  4 Jan 2023 16:55:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 401AFC433EF;
        Wed,  4 Jan 2023 16:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672851300;
        bh=PRT9pyRYXkxTWpB3lRIbo0OKaSnhV5A3KNAJsop1Qhw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yflc5IqAZB+mr3pTNLZaIWWHnHQzKqJIK8gXyn7fIxTuSZ4pUmH878QlnmTz4dfcX
         56gjGE+gKKaNFA2Kj3+Zb3FQGICuY9nJnXJTR/DweCBmGXxJxGRecoDldf9SU0xSJN
         9u7O/9gNnMelBN0OGIQHou0lTsXgBDa0wIFG+UgR3RPxyK0PJMNIc8hq28zAqHzlXQ
         Rw+qvFzlrE294xQFEAoWefHhFGC4Q9mMo9NVfcdS06OG38R/5w8N0IHUdo9CIUaadz
         bVOKG187B8Y/3ZYdUC/WqqYfiN/MrXtEXMJ/r+7TJz9P/ER+bK3tsbWfIBzKPXStEv
         vgW8OsZGYnIJA==
Date:   Wed, 4 Jan 2023 16:54:53 +0000
From:   Lee Jones <lee@kernel.org>
To:     Jeremy Kerr <jk@codeconstruct.com.au>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH v3 2/2] mfd: syscon: allow reset control for syscon
 devices
Message-ID: <Y7WvXTPxyIGw5y9R@google.com>
References: <20221211025700.1180843-1-jk@codeconstruct.com.au>
 <20221211025700.1180843-3-jk@codeconstruct.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221211025700.1180843-3-jk@codeconstruct.com.au>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Dec 2022, Jeremy Kerr wrote:

> Simple syscon devices may require deassertion of a reset signal in order
> to access their register set. Rather than requiring a custom driver to
> implement this, we can use the generic "resets" specifiers to link a
> reset line to the syscon.
> 
> This change adds an optional reset line to the syscon device
> description, and deasserts the reset if detected.
> 
> Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
> 
> ---
> v2:
>  * do reset control in the early of_syscon_register() path, rather than
>    the platform device init, which isn't used.
> v3:
>  * use a direct reset_control_deassert rather than handling in the
>    regmap
> ---
>  drivers/mfd/syscon.c | 27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
> index bdb2ce7ff03b..05e286a69dbe 100644
> --- a/drivers/mfd/syscon.c
> +++ b/drivers/mfd/syscon.c
> @@ -20,6 +20,7 @@
>  #include <linux/platform_data/syscon.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
> +#include <linux/reset.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/slab.h>
>  
> @@ -31,6 +32,7 @@ static LIST_HEAD(syscon_list);
>  struct syscon {
>  	struct device_node *np;
>  	struct regmap *regmap;
> +	struct reset_control *reset;
>  	struct list_head list;
>  };
>  
> @@ -40,7 +42,7 @@ static const struct regmap_config syscon_regmap_config = {
>  	.reg_stride = 4,
>  };
>  
> -static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
> +static struct syscon *of_syscon_register(struct device_node *np, bool check_res)
>  {
>  	struct clk *clk;
>  	struct syscon *syscon;
> @@ -50,6 +52,7 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
>  	int ret;
>  	struct regmap_config syscon_config = syscon_regmap_config;
>  	struct resource res;
> +	struct reset_control *reset;
>  
>  	syscon = kzalloc(sizeof(*syscon), GFP_KERNEL);
>  	if (!syscon)
> @@ -114,7 +117,7 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
>  		goto err_regmap;
>  	}
>  
> -	if (check_clk) {
> +	if (check_res) {
>  		clk = of_clk_get(np, 0);
>  		if (IS_ERR(clk)) {
>  			ret = PTR_ERR(clk);
> @@ -124,7 +127,17 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
>  		} else {
>  			ret = regmap_mmio_attach_clk(regmap, clk);
>  			if (ret)
> -				goto err_attach;
> +				goto err_attach_clk;
> +		}
> +
> +		reset = of_reset_control_get_optional_exclusive(np, NULL);
> +		if (IS_ERR(reset)) {
> +			ret = PTR_ERR(reset);
> +			goto err_attach_clk;
> +		} else {
> +			ret = reset_control_deassert(reset);
> +			if (ret)
> +				goto err_reset;
>  		}

The else is superfluous, right?

Arnd, besides this are you happy with the patch?

-- 
Lee Jones [李琼斯]
