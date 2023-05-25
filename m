Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE42710A48
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 12:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240204AbjEYKsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 06:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234122AbjEYKsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 06:48:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A1510B;
        Thu, 25 May 2023 03:48:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D3CC6449C;
        Thu, 25 May 2023 10:48:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94633C433EF;
        Thu, 25 May 2023 10:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685011731;
        bh=syfifLlyaCvCKOOmv82wXtJYyig6H3axNUQALr6O/Po=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nUDlQbvjYUYvKbKHVeHHpAqXZgMNsmrf6QQHoQh1xz8pCNXHdXxZwsn0EfOB8rKRn
         YhMg2VldyoCQEgcy04zbZ80kaL4/F2XCv4HVogzMs7jQCYymBfZCXXGaXPk3vq2Dv6
         8d/yJrGwbW85yH5sTaeY2sogxLsSFO4OwBMMipnie5r9j/1dzFXlMORhVvF4mNga14
         /ht5p2AjBcqc/HwzFGofqysVDqAnZf2x0swrfqkgDW4UtGNU9Fo2ztEhBbC6sOT9an
         D17lK4fErodcOjSXvhQVFKqa6CXTLUZOyW2ctbxuP0tyj7vYYpQj05F9NUIDrgctFf
         H30SgAvWakNlg==
Date:   Thu, 25 May 2023 11:48:46 +0100
From:   Lee Jones <lee@kernel.org>
To:     Jerome Neanne <jneanne@baylibre.com>
Cc:     tony@atomide.com, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com, nm@ti.com,
        afd@ti.com, msp@baylibre.com
Subject: Re: [PATCH] mfd: tps65219: Add support for soft shutdown via sys-off
 API
Message-ID: <20230525104846.GE9691@google.com>
References: <20230511122100.2225417-1-jneanne@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230511122100.2225417-1-jneanne@baylibre.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 May 2023, Jerome Neanne wrote:

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
> Tested on AM62-LP-SK board.
> 
> Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
> Suggested-by: Andrew Davis <afd@ti.com>
> Reviewed-by: Andrew Davis <afd@ti.com>
> ---
> 
> Notes:
>     Change-log v2 to v1
>     v1: Link: https://lore.kernel.org/all/20230203140150.13071-1-jneanne@baylibre.com/
>     Andrew Davis Review:
>     - Use new helpers devm_register_restart_handler and devm_register_power_off_handler
>     Vignesh Raghavendra:
>     - Fix typo on board name in commit message
> 
>  drivers/mfd/tps65219.c | 41 ++++++++++++++++++++++++++++++-----------
>  1 file changed, 30 insertions(+), 11 deletions(-)

Couple of nits.
 
> diff --git a/drivers/mfd/tps65219.c b/drivers/mfd/tps65219.c
> index 0e402fda206b..5115d0a66701 100644
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

Why the line-wrap?

> +{
>  	if (reboot_mode == REBOOT_WARM)
>  		tps65219_warm_reset(tps);
>  	else
>  		tps65219_cold_reset(tps);
> -

This has nothing to do with the patch, and I liked it better before.

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
> @@ -269,13 +278,23 @@ static int tps65219_probe(struct i2c_client *client)
>  		}
>  	}
>  
> -	tps->nb = pmic_rst_restart_nb;
> -	ret = register_restart_handler(&tps->nb);
> +	ret = devm_register_restart_handler(tps->dev,
> +					    tps65219_restart_handler,
> +					    tps);
> +
>  	if (ret) {
>  		dev_err(tps->dev, "cannot register restart handler, %d\n", ret);
>  		return ret;
>  	}
>  
> +	ret = devm_register_power_off_handler(tps->dev,
> +					      tps65219_power_off_handler,
> +					      tps);
> +	if (ret) {
> +		dev_err(tps->dev, "failed to register power-off handler: %d\n",
> +			ret);

I wouldn't wrap here either to be honest.

checkpatch.pl now complains at 100-chars.

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
