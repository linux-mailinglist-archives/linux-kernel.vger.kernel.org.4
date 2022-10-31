Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA5E6139EC
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 16:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbiJaPW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 11:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbiJaPWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 11:22:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947041182E
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 08:22:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 438A3B81898
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 15:22:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28B6DC433C1;
        Mon, 31 Oct 2022 15:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667229725;
        bh=J3dKmEKuFWkJaXd8gj5Mc/X0liGbVck7VRFtLcqVYe8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WHKX3jDbResdeT6UiWDBY9yFhHnApEkZlRgsav1aUm4jUocz62HOcbT4zQLwMGl+4
         uKbEoAzjLNr6EHBqtpq/uHsPN7hHByIMj0hOqS+KDwPmleUtBF6FhML2VWY6vOnfJb
         T5sAUHCHwJWQT9pnracgU/2/UddHKao6UKnAeC+OznqtOHJjLsj9IwYjaOxuG+ILp4
         qePCBKTBdb6qaVDVtBp2BMKRciF0wMHUHMRcL0FvLepAjqETgqoYAKp3v2eZVuOwiI
         88DDgITYVxVak559WqsCRe1zjQtVsLii+LxtoBCaYNyTzxq5pOhjZ6u9LwCcp/s6rv
         ik7i3i83wQrzA==
Date:   Mon, 31 Oct 2022 15:22:02 +0000
From:   Lee Jones <lee@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: rk808: permit having multiple PMIC instances
Message-ID: <Y1/oGhqPZNvyVTkY@google.com>
References: <20221025-rk808-multi-v1-0-c07b7cf3fd67@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221025-rk808-multi-v1-0-c07b7cf3fd67@linaro.org>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Oct 2022, Neil Armstrong wrote:

> This set each cells id to -1 to allow multiple instances of
> each cell in case multiple PMICs handled by the rk808 driver
> are probed.
> 
> This fixes probing a RK818 and a RK817 on the Odroid Go Ultra
> devices.

No issue with the premise Neil, but would you be kind enough to use
the define provided (PLATFORM_DEVID_NONE) instead of the magic number
please?

> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> Cc: Lee Jones <lee@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/mfd/rk808.c | 26 ++++++++++++++++----------
>  1 file changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
> index e00da7c7e3b1..b9cfd249912d 100644
> --- a/drivers/mfd/rk808.c
> +++ b/drivers/mfd/rk808.c
> @@ -137,58 +137,64 @@ static const struct resource rk817_charger_resources[] = {
>  };
>  
>  static const struct mfd_cell rk805s[] = {
> -	{ .name = "rk808-clkout", },
> -	{ .name = "rk808-regulator", },
> -	{ .name = "rk805-pinctrl", },
> +	{ .name = "rk808-clkout", .id = -1, },
> +	{ .name = "rk808-regulator", .id = -1, },
> +	{ .name = "rk805-pinctrl", .id = -1, },
>  	{
>  		.name = "rk808-rtc",
>  		.num_resources = ARRAY_SIZE(rtc_resources),
>  		.resources = &rtc_resources[0],
> +		.id = -1,
>  	},
>  	{	.name = "rk805-pwrkey",
>  		.num_resources = ARRAY_SIZE(rk805_key_resources),
>  		.resources = &rk805_key_resources[0],
> +		.id = -1,
>  	},
>  };
>  
>  static const struct mfd_cell rk808s[] = {
> -	{ .name = "rk808-clkout", },
> -	{ .name = "rk808-regulator", },
> +	{ .name = "rk808-clkout", .id = -1, },
> +	{ .name = "rk808-regulator", .id = -1, },
>  	{
>  		.name = "rk808-rtc",
>  		.num_resources = ARRAY_SIZE(rtc_resources),
>  		.resources = rtc_resources,
> +		.id = -1,
>  	},
>  };
>  
>  static const struct mfd_cell rk817s[] = {
> -	{ .name = "rk808-clkout",},
> -	{ .name = "rk808-regulator",},
> +	{ .name = "rk808-clkout", .id = -1, },
> +	{ .name = "rk808-regulator", .id = -1, },
>  	{
>  		.name = "rk805-pwrkey",
>  		.num_resources = ARRAY_SIZE(rk817_pwrkey_resources),
>  		.resources = &rk817_pwrkey_resources[0],
> +		.id = -1,
>  	},
>  	{
>  		.name = "rk808-rtc",
>  		.num_resources = ARRAY_SIZE(rk817_rtc_resources),
>  		.resources = &rk817_rtc_resources[0],
> +		.id = -1,
>  	},
> -	{ .name = "rk817-codec",},
> +	{ .name = "rk817-codec", .id = -1, },
>  	{
>  		.name = "rk817-charger",
>  		.num_resources = ARRAY_SIZE(rk817_charger_resources),
>  		.resources = &rk817_charger_resources[0],
> +		.id = -1,
>  	},
>  };
>  
>  static const struct mfd_cell rk818s[] = {
> -	{ .name = "rk808-clkout", },
> -	{ .name = "rk808-regulator", },
> +	{ .name = "rk808-regulator", .id = -1, },
>  	{
>  		.name = "rk808-rtc",
>  		.num_resources = ARRAY_SIZE(rtc_resources),
>  		.resources = rtc_resources,
> +		.id = -1,
>  	},
>  };
>  
> 
> ---
> base-commit: 247f34f7b80357943234f93f247a1ae6b6c3a740
> change-id: 20221025-rk808-multi-65dd03a92705
> 
> Best regards,

-- 
Lee Jones [李琼斯]
