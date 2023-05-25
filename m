Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B920710A70
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 13:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240845AbjEYLA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 07:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240334AbjEYLAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 07:00:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0A7C5
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 04:00:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D09EC61382
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 11:00:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0617C433EF;
        Thu, 25 May 2023 11:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685012431;
        bh=oJ6QgPbGXWqRoqlX01O23tO6hItbrjZO+12l/zxII90=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q+2qRjDKb+rSiGR3JP9GLEgCuUic1R3fHUdw1ErP/R+PcPkw1BFOyuIe6pyFnh/p2
         P79a5BXsNGnn4BoYpKbmmv+uVomwIaKbx1B/ds4oolpFWgHHvNClzloWoZ7GTH6uQr
         p/gA8KRJEP2g3pICPKA38Y+NwSSCVvLfQzFBGgQrEm1wojL2MGrJQ2T+m7PdgAcXSr
         ie81kGfM/a+N6LQw/r3DNaR7bZ7cEQds8+UMTRUSOJPcHcsbARIlnpS1q1ysWE7WqF
         uUTH8S5I5kBFo+on3XK6HNqOHkZMeS1fQTAgc4rUHgaPMeNpc7c99xmU39nXPG4lV1
         tOBH9NN9be7Ig==
Date:   Thu, 25 May 2023 12:00:26 +0100
From:   Lee Jones <lee@kernel.org>
To:     Milo Spadacini <milo.spadacini@gmail.com>
Cc:     heiko@sntech.de, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver: mfd: admit rk805 driver registration without
 interrupt support
Message-ID: <20230525110026.GG9691@google.com>
References: <20230525070011.23761-1-milo.spadacini@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230525070011.23761-1-milo.spadacini@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do you mean "Omit"?

On Thu, 25 May 2023, Milo Spadacini wrote:

> rk805 use interrupt only for "rk808-rtc" and "rk805-pwrkey" drivers.

RK805 only uses interrupts for ...

> On custom board these drivers could be not used and the irq gpio

"boards"
"IRQ GPIQs"

> could be not connected.

"are not connected"

> Force the usage of a not used gpio, that could be floating, could cause
> spurious interrupt.

Please rephrase this.  I can't quite make it out to make suggestions.

> Signed-off-by: Milo Spadacini <milo.spadacini@gmail.com>
> ---
>  drivers/mfd/rk808.c | 39 +++++++++++++++++++++++++++------------
>  1 file changed, 27 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
> index e00da7c7e3b1..ae33be90b312 100644
> --- a/drivers/mfd/rk808.c
> +++ b/drivers/mfd/rk808.c
> @@ -643,6 +643,7 @@ MODULE_DEVICE_TABLE(of, rk808_of_match);
>  static int rk808_probe(struct i2c_client *client,
>  		       const struct i2c_device_id *id)
>  {
> +	struct irq_domain * rk808_irq_domain = NULL;

Drop the ' ' after the '*'.

>  	struct device_node *np = client->dev.of_node;
>  	struct rk808 *rk808;
>  	const struct rk808_reg_data *pre_init_reg;
> @@ -692,7 +693,11 @@ static int rk808_probe(struct i2c_client *client,
>  		pre_init_reg = rk805_pre_init_reg;
>  		nr_pre_init_regs = ARRAY_SIZE(rk805_pre_init_reg);
>  		cells = rk805s;
> -		nr_cells = ARRAY_SIZE(rk805s);
> +		if (client->irq)
> +			nr_cells = ARRAY_SIZE(rk805s);
> +		else
> +			nr_cells = ARRAY_SIZE(rk805s) - 2;

What's 2?  Please define it.

Does this rely on the ordering of rk805s?  Seems fragile.

> +
>  		break;
>  	case RK808_ID:
>  		rk808->regmap_cfg = &rk808_regmap_config;
> @@ -734,19 +739,28 @@ static int rk808_probe(struct i2c_client *client,
>  		return PTR_ERR(rk808->regmap);
>  	}
>  
> -	if (!client->irq) {
> +	if (client->irq) {
> +
> +		ret = regmap_add_irq_chip(rk808->regmap, client->irq,
> +					  IRQF_ONESHOT, -1,
> +					  rk808->regmap_irq_chip, &rk808->irq_data);
> +		if (ret) {
> +			dev_err(&client->dev, "Failed to add irq_chip %d\n", ret);
> +			return ret;
> +		}
> +
> +		rk808_irq_domain = regmap_irq_get_domain(rk808->irq_data);
> +	}
> +	else if (rk808->variant == RK805_ID)

else goes on the line above.
> +	{
> +		dev_warn(&client->dev, "Skip interrupt support, no core IRQ\n");
> +	}
> +	else
> +	{
>  		dev_err(&client->dev, "No interrupt support, no core IRQ\n");
>  		return -EINVAL;
>  	}
>  
> -	ret = regmap_add_irq_chip(rk808->regmap, client->irq,
> -				  IRQF_ONESHOT, -1,
> -				  rk808->regmap_irq_chip, &rk808->irq_data);
> -	if (ret) {
> -		dev_err(&client->dev, "Failed to add irq_chip %d\n", ret);
> -		return ret;
> -	}
> -
>  	for (i = 0; i < nr_pre_init_regs; i++) {
>  		ret = regmap_update_bits(rk808->regmap,
>  					pre_init_reg[i].addr,
> @@ -762,7 +776,7 @@ static int rk808_probe(struct i2c_client *client,
>  
>  	ret = devm_mfd_add_devices(&client->dev, PLATFORM_DEVID_NONE,
>  			      cells, nr_cells, NULL, 0,
> -			      regmap_irq_get_domain(rk808->irq_data));
> +			      rk808_irq_domain);
>  	if (ret) {
>  		dev_err(&client->dev, "failed to add MFD devices %d\n", ret);
>  		goto err_irq;
> @@ -796,7 +810,8 @@ static void rk808_remove(struct i2c_client *client)
>  {
>  	struct rk808 *rk808 = i2c_get_clientdata(client);
>  
> -	regmap_del_irq_chip(client->irq, rk808->irq_data);
> +	if (client->irq)
> +		regmap_del_irq_chip(client->irq, rk808->irq_data);
>  
>  	/**
>  	 * pm_power_off may points to a function from another module.
> -- 
> 2.34.1
> 

-- 
Lee Jones [李琼斯]
