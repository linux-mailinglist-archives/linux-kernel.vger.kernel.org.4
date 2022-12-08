Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88EE4646FAA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 13:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbiLHM3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 07:29:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiLHM3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 07:29:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0BE2B185;
        Thu,  8 Dec 2022 04:29:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BAE8961EEE;
        Thu,  8 Dec 2022 12:29:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05875C433C1;
        Thu,  8 Dec 2022 12:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670502556;
        bh=zbX8/ClFA3b2CThz56cTysR/0+gs5BUOcVmr4sqX8fc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M9aAZxAvft8qRQ0t9SH9a4A7edcdMpmF/DIvHtqVmKMX67+nipkhZzYqP7N6XHAxc
         1JsQDSahfmod5QD0xJ1hKD5fJD52lp6afr49c8GETzvJtBtje+7/3V7r16T1UfiiHh
         ayr29LSi6LVoJdeIlk9lx4Q0JG3kwrZEuxg9MASt07OhBHSHT/rXI1fBKL6AX/7hLV
         jJkNnifxVnE2oVyIshpvLwLHIDD4L6esgn7DlxEZ/AGmMbA4SWKMk08mrkKizjnwGb
         uxEK6G9oX8Jbo+ygbvtAHcvNGfuah423J0zsf/SkoPYzygexbie1WzOkOE4qKwcowN
         dSt/ZwIqSYMig==
Date:   Thu, 8 Dec 2022 12:29:11 +0000
From:   Lee Jones <lee@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     tony@atomide.com, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bin Liu <b-liu@ti.com>
Subject: Re: [PATCH] mfd: twl: fix TWL6032 phy vbus detection
Message-ID: <Y5HYl2Umqs7HSOKN@google.com>
References: <20221119100341.2930647-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221119100341.2930647-1-andreas@kemnade.info>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Nov 2022, Andreas Kemnade wrote:

> TWL6032 has a few charging registers prepended before the charging
> registers the TWL6030 has. To be able to use common register defines
> declare the additional registers as additional module.
> At the moment this affects the access to CHARGERUSB_CTRL1 in
> phy-twl6030-usb.  Without this patch, it is accessing the wrong register
> on TWL6032.
> The consequence is that presence of Vbus is not reported.
> 
> Cc: Bin Liu <b-liu@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  drivers/mfd/twl-core.c  | 8 ++++----
>  include/linux/mfd/twl.h | 2 ++
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
> index f6b4b9d94bbd..5a7ed71d0e30 100644
> --- a/drivers/mfd/twl-core.c
> +++ b/drivers/mfd/twl-core.c
> @@ -111,6 +111,7 @@
>  #define TWL6030_BASEADD_GASGAUGE	0x00C0
>  #define TWL6030_BASEADD_PIH		0x00D0
>  #define TWL6030_BASEADD_CHARGER		0x00E0
> +/* A few regs prepended before the 6030 regs */

This would be better represented if the defines were in order.

The comment is also superfluous.

>  #define TWL6032_BASEADD_CHARGER		0x00DA

Are you sure this is prepended i.e. before the other registers?

These looks as though they sit in the middle.

>  #define TWL6030_BASEADD_LED		0x00F4
>  
> @@ -353,6 +354,9 @@ static struct twl_mapping twl6030_map[] = {
>  	{ 2, TWL6030_BASEADD_ZERO },
>  	{ 1, TWL6030_BASEADD_GPADC_CTRL },
>  	{ 1, TWL6030_BASEADD_GASGAUGE },
> +
> +	/* TWL6032 specific charger registers */
> +	{ 1, TWL6032_BASEADD_CHARGER },
>  };
>  
>  static const struct regmap_config twl6030_regmap_config[3] = {
> @@ -802,10 +806,6 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  	if ((id->driver_data) & TWL6030_CLASS) {
>  		twl_priv->twl_id = TWL6030_CLASS_ID;
>  		twl_priv->twl_map = &twl6030_map[0];
> -		/* The charger base address is different in twl6032 */
> -		if ((id->driver_data) & TWL6032_SUBCLASS)
> -			twl_priv->twl_map[TWL_MODULE_MAIN_CHARGE].base =
> -							TWL6032_BASEADD_CHARGER;
>  		twl_regmap_config = twl6030_regmap_config;
>  	} else {
>  		twl_priv->twl_id = TWL4030_CLASS_ID;
> diff --git a/include/linux/mfd/twl.h b/include/linux/mfd/twl.h
> index eaa233038254..6e3d99b7a0ee 100644
> --- a/include/linux/mfd/twl.h
> +++ b/include/linux/mfd/twl.h
> @@ -69,6 +69,8 @@ enum twl6030_module_ids {
>  	TWL6030_MODULE_GPADC,
>  	TWL6030_MODULE_GASGAUGE,
>  
> +	/* A few extra registers before the registers shared with the 6030 */
> +	TWL6032_MODULE_CHARGE,
>  	TWL6030_MODULE_LAST,
>  };
>  

-- 
Lee Jones [李琼斯]
