Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8F86A7088
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 17:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjCAQHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 11:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjCAQHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 11:07:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024D737708;
        Wed,  1 Mar 2023 08:07:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B6811B8103F;
        Wed,  1 Mar 2023 16:07:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFC52C433D2;
        Wed,  1 Mar 2023 16:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677686850;
        bh=cry1Q2K76OClVdDMe8SjHbwxo+86zstNJ0kkh2LlQbY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nOKCaFTZBNgLs+isIU6edX/9IErGI8BThzyIHWbXyBOp3vhHR+v6PDzd5WjJr5Clu
         HeV2S8sgIZ6iZVA4+C8nMXLaFuigi5QxhinKGPwFUxVQCREeWdzPxLDnTaxxfzq6YG
         QCGGcwJpNpbPxOjiRJCP1D7s4olW/Q8SRYDKlaqshtkR/R+wFvkBmB8IAAWZVqhSAL
         OVl6dT1nzfnxjjvu7UDkJIdwGG46tnY2762wPnceIItKqy37VD/vNofCTC9oDTlz6J
         gnIg08viqUn2fyKr6dunqT6Je/F/b3yowwL0n7V94KIvqkWw/c51ZSUPUcPzzHvA+x
         heOXPk+uRwjKw==
Date:   Wed, 1 Mar 2023 16:07:25 +0000
From:   Lee Jones <lee@kernel.org>
To:     Jerome Neanne <jneanne@baylibre.com>
Cc:     tony@atomide.com, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com, nm@ti.com,
        afd@ti.com, msp@baylibre.com
Subject: Re: [PATCH] mfd: tps65219: Add support for soft shutdown via sys-off
 API
Message-ID: <Y/94Pew4vr6FROcI@google.com>
References: <20230203140150.13071-1-jneanne@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230203140150.13071-1-jneanne@baylibre.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Feb 2023, Jerome Neanne wrote:

> Use new API for power-off mode support:
> Link: https://lwn.net/Articles/894511/
> Link: https://lore.kernel.org/all/7hfseqa7l0.fsf@baylibre.com/
> 
> sys-off API allows support of shutdown handler and restart handler.
> 
> Shutdown was not supported before that enhancement.
> This is required for platform that are not using PSCI.
> 
> Test:
> - restart:
>   # reboot
>   Default is cold reset:
>   # cat /sys/kernel/reboot/mode
>   Switch boot mode to warm reset:
>   # echo warm > /sys/kernel/reboot/mode
> - power-off:
>   # halt
> 
> Tested on AM62-SP-SK board.
> 
> Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
> Suggested-by: Andrew Davis <afd@ti.com>

A review from Andrew would be helpful here.

> ---
>  drivers/mfd/tps65219.c | 45 +++++++++++++++++++++++++++++++-----------
>  1 file changed, 34 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/mfd/tps65219.c b/drivers/mfd/tps65219.c
> index 0e402fda206b..c134f3f6e202 100644
> --- a/drivers/mfd/tps65219.c
> +++ b/drivers/mfd/tps65219.c
> @@ -25,25 +25,34 @@ static int tps65219_cold_reset(struct tps65219 *tps)
>  				  TPS65219_MFP_COLD_RESET_I2C_CTRL_MASK);
>  }
>  
> -static int tps65219_restart(struct notifier_block *this,
> -			    unsigned long reboot_mode, void *cmd)
> +static int tps65219_soft_shutdown(struct tps65219 *tps)
>  {
> -	struct tps65219 *tps;
> +	return regmap_update_bits(tps->regmap, TPS65219_REG_MFP_CTRL,
> +				  TPS65219_MFP_I2C_OFF_REQ_MASK,
> +				  TPS65219_MFP_I2C_OFF_REQ_MASK);
> +}
>  
> -	tps = container_of(this, struct tps65219, nb);
> +static int tps65219_power_off_handler(struct sys_off_data *data)
> +{
> +	tps65219_soft_shutdown(data->cb_data);
> +	return NOTIFY_DONE;
> +}
>  
> +static int tps65219_restart(struct tps65219 *tps,
> +			    unsigned long reboot_mode)
> +{
>  	if (reboot_mode == REBOOT_WARM)
>  		tps65219_warm_reset(tps);
>  	else
>  		tps65219_cold_reset(tps);
> -
>  	return NOTIFY_DONE;
>  }
>  
> -static struct notifier_block pmic_rst_restart_nb = {
> -	.notifier_call = tps65219_restart,
> -	.priority = 200,
> -};
> +static int tps65219_restart_handler(struct sys_off_data *data)
> +{
> +	tps65219_restart(data->cb_data, data->mode);
> +	return NOTIFY_DONE;
> +}
>  
>  static const struct resource tps65219_pwrbutton_resources[] = {
>  	DEFINE_RES_IRQ_NAMED(TPS65219_INT_PB_FALLING_EDGE_DETECT, "falling"),
> @@ -269,13 +278,27 @@ static int tps65219_probe(struct i2c_client *client)
>  		}
>  	}
>  
> -	tps->nb = pmic_rst_restart_nb;
> -	ret = register_restart_handler(&tps->nb);
> +	ret = devm_register_sys_off_handler(tps->dev,
> +					    SYS_OFF_MODE_RESTART,
> +					    SYS_OFF_PRIO_HIGH,
> +					    tps65219_restart_handler,
> +					    tps);
> +
>  	if (ret) {
>  		dev_err(tps->dev, "cannot register restart handler, %d\n", ret);
>  		return ret;
>  	}
>  
> +	ret = devm_register_sys_off_handler(tps->dev,
> +					    SYS_OFF_MODE_POWER_OFF,
> +					    SYS_OFF_PRIO_DEFAULT,
> +					    tps65219_power_off_handler,
> +					    tps);
> +	if (ret) {
> +		dev_err(tps->dev, "failed to register sys-off handler: %d\n",
> +			ret);
> +		return ret;
> +	}
>  	return 0;
>  }
>  
> -- 
> 2.34.1
> 

-- 
Lee Jones [李琼斯]
