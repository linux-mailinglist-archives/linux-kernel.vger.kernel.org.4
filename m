Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEC53689DE8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 16:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233857AbjBCPRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 10:17:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235207AbjBCPQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 10:16:28 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C7BA6434
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 07:14:33 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id m16-20020a05600c3b1000b003dc4050c94aso4089827wms.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 07:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xoHwZU+cWQXTJUAoXfICLN7SVVTwbgwEtqjg8VeFKLk=;
        b=4NjEY1AGatFNGFa9jkxwMZ1sdWAL7LvfrpD/mrwjtx20MEWVd6A5SHBQ/p0/XFGf3/
         h8MYRcIrgyjBLG3q8MTKpu1Ll+Ae19v8WCNYTEdm4pPeMh69pVOjeijjLNrY3AvhdbKZ
         2EdsVKXC62uVpA5LpSspAZBYR/2iJTxRD56eKxcgLsc7eE5z8Y97ZJ6zoBMkdq2tfhyn
         ioYJR1sHVq7i/YSya2dV0banxGr+BNUW7tg/uaITuuz7MY2pPYGw5aT0g0jtJg3Mbwyw
         Leo9Q3zNC7cGytjtRrUVkYAJaIH30auv5ivtVwFJlPDDq7tzlU0SnwOvg8xrqCic29ZZ
         VDdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xoHwZU+cWQXTJUAoXfICLN7SVVTwbgwEtqjg8VeFKLk=;
        b=UyVFELLtbZevay4EggiBFFRaREa/Qg5zWGcdjLLCCCZ/68ZbLsjW4ndC6isIBoI8hv
         tn9kfaetKihxpAI0uU+FpkhaIU3YKxh+gSO1fDjKAvIL6lJeKN5TJvTCMR8yxwLd0U89
         6IRu/lp9N4Om5byr4Je6XrDF8t9U8QRaJvf1QxUTBvjKpGoB5U1fuwg9kr4LA08YGtQe
         ANQZ/1qJhQ6OlF2QRGJgEm5xFlqTDqh6z64g3rYhNBAhZw6/lBYx+umSyaRK6pMsgPKS
         PeKks4JJckRx6Z2c5Cn4vDZG6RWk0YHnk2/JwXiFKXBH5sZSnRjd5LFMoVtL7n/sKdjg
         dBCQ==
X-Gm-Message-State: AO0yUKXmX0oUm1GLIyJzpbqbSvSOd6DpsQ4lUKsSyDMhE31s03LK5UeT
        O7tEc1nFgxqoxHtEtc4af2RasobmMpOVIiNT
X-Google-Smtp-Source: AK7set+TZOa/QpgWZbA2Z1iDxGZMdFjbssOBfc1aGV5wp+5zqmoeBKoYca0HfpOh2j5JfqJXa6hIow==
X-Received: by 2002:a05:600c:1d8a:b0:3dc:50b8:67d7 with SMTP id p10-20020a05600c1d8a00b003dc50b867d7mr10265173wms.11.1675437206814;
        Fri, 03 Feb 2023 07:13:26 -0800 (PST)
Received: from localhost ([2a01:cb1a:d:9cd7:1733:6588:b4e9:c6d3])
        by smtp.gmail.com with ESMTPSA id n36-20020a05600c3ba400b003dc54eef495sm3351939wms.24.2023.02.03.07.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 07:13:26 -0800 (PST)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     Jiri Valek - 2N <jiriv@axis.com>, linux-input@vger.kernel.org
Cc:     devicetree@vger.kernel.org, dmitry.torokhov@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, u.kleine-koenig@pengutronix.de, jiriv@axis.com
Subject: Re: [PATCH v4 2/2] Input: cap11xx - add support for cap1203,
 cap1293 and cap1298
In-Reply-To: <20230111131111.475270-3-jiriv@axis.com>
References: <20230111131111.475270-1-jiriv@axis.com>
 <20230111131111.475270-3-jiriv@axis.com>
Date:   Fri, 03 Feb 2023 16:13:23 +0100
Message-ID: <87mt5ulr3g.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 14:11, Jiri Valek - 2N <jiriv@axis.com> wrote:

> Add basic support for more CAP1xxx sensors.
> All models from CAP1xxx family are register-compatible.
> Some advanced features are not used and disabled by default.
>
> Reported-by: kernel test robot <lkp@xxxxxxxxx>
> Signed-off-by: Jiri Valek - 2N <jiriv@axis.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

Small nitpick below

> ---
> Changes in v2:
>   - Fixed if statement.
>   
> Changes in v3:
>   - Model names sorted alphabetically.
>
> Changes in v4
>   - No changes.
>
>  drivers/input/keyboard/cap11xx.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/input/keyboard/cap11xx.c b/drivers/input/keyboard/cap11xx.c
> index 79afd0386e3f..ce27168302a8 100644
> --- a/drivers/input/keyboard/cap11xx.c
> +++ b/drivers/input/keyboard/cap11xx.c
> @@ -98,14 +98,20 @@ enum {
>  	CAP1106,
>  	CAP1126,
>  	CAP1188,
> +	CAP1203,
>  	CAP1206,
> +	CAP1293,
> +	CAP1298
>  };
>  
>  static const struct cap11xx_hw_model cap11xx_devices[] = {
>  	[CAP1106] = { .product_id = 0x55, .num_channels = 6, .num_leds = 0, .no_gain = false },
>  	[CAP1126] = { .product_id = 0x53, .num_channels = 6, .num_leds = 2, .no_gain = false },
>  	[CAP1188] = { .product_id = 0x50, .num_channels = 8, .num_leds = 8, .no_gain = false },
> +	[CAP1203] = { .product_id = 0x6d, .num_channels = 3, .num_leds = 0, .no_gain = true },
>  	[CAP1206] = { .product_id = 0x67, .num_channels = 6, .num_leds = 0, .no_gain = true },
> +	[CAP1293] = { .product_id = 0x6f, .num_channels = 3, .num_leds = 0, .no_gain = false },
> +	[CAP1298] = { .product_id = 0x71, .num_channels = 8, .num_leds = 0, .no_gain = false },
>  };
>  
>  static const struct reg_default cap11xx_reg_defaults[] = {
> @@ -377,7 +383,8 @@ static int cap11xx_i2c_probe(struct i2c_client *i2c_client)
>  	if (error < 0)
>  		return error;
>  
> -	dev_info(dev, "CAP11XX detected, revision 0x%02x\n", rev);
> +	dev_info(dev, "CAP11XX detected, model %s, revision 0x%02x\n",
> +			id->name, rev);
>  	node = dev->of_node;
>  
>  	if (!of_property_read_u32(node, "microchip,sensor-gain", &gain32)) {
> @@ -390,7 +397,9 @@ static int cap11xx_i2c_probe(struct i2c_client *i2c_client)
>  			dev_err(dev, "Invalid sensor-gain value %d\n", gain32);
>  	}
>  
> -	if (id->driver_data != CAP1206) {
> +	if ((id->driver_data == CAP1106) ||
> +		(id->driver_data == CAP1126) ||
> +		(id->driver_data == CAP1188)) {

checkpatch --strict is not happy about this indendation:
CHECK: Alignment should match open parenthesis

>  		if (of_property_read_bool(node, "microchip,irq-active-high")) {
>  			error = regmap_update_bits(priv->regmap,
>  						   CAP11XX_REG_CONFIG2,
> @@ -483,7 +492,10 @@ static const struct of_device_id cap11xx_dt_ids[] = {
>  	{ .compatible = "microchip,cap1106", },
>  	{ .compatible = "microchip,cap1126", },
>  	{ .compatible = "microchip,cap1188", },
> +	{ .compatible = "microchip,cap1203", },
>  	{ .compatible = "microchip,cap1206", },
> +	{ .compatible = "microchip,cap1293", },
> +	{ .compatible = "microchip,cap1298", },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, cap11xx_dt_ids);
> @@ -492,7 +504,10 @@ static const struct i2c_device_id cap11xx_i2c_ids[] = {
>  	{ "cap1106", CAP1106 },
>  	{ "cap1126", CAP1126 },
>  	{ "cap1188", CAP1188 },
> +	{ "cap1203", CAP1203 },
>  	{ "cap1206", CAP1206 },
> +	{ "cap1293", CAP1293 },
> +	{ "cap1298", CAP1298 },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(i2c, cap11xx_i2c_ids);
> -- 
> 2.25.1
