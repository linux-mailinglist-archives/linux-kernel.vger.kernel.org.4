Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66436B01DF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 09:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjCHIow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 03:44:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjCHIok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 03:44:40 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95578FBDF;
        Wed,  8 Mar 2023 00:44:38 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id BA10D60015;
        Wed,  8 Mar 2023 08:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678265077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=19ErVvyeVJmPk1zHVh5os38udnPkfgS3DDWKkXdtOQU=;
        b=mUQyvRUTEC6ew9Z2iV/DSIJZMOo2Fl36/TtXtRIURIA5eK0lkYMqctcQjRiMGR1BInZHPt
        ae++Nz559IDjk6iapccR26Oa9L+xuTVtwcfpY5QSQoDSPJ9FjYIJVAOa7910dPqCGrxsLt
        fiziOp7cJCwVEhqyIDRQiJg6pdXcJeIjm0R/bVlo4IXU8mAvLqWfBGU2mOPwoF9IJ3v90I
        7p/ldiKOAEW5Xz1F3YTyew1XVePCmabri7fPScUX+e/St6ETOb1ZqPYxlLLrYD7UdGyFOg
        QAqY3LfF4HoOhFClgCzRwjXIIL8o2/EoyNjRqmVFDwotwd6oPtzTfv3VzGHGCQ==
Date:   Wed, 8 Mar 2023 09:44:36 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v1] max77663-rtc: pass rtc address from device tree node
 if exists
Message-ID: <202303080844360ced8b82@mail.local>
References: <20230308083759.11692-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308083759.11692-1-clamor95@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

the subject is not correct, please use the subsystem style

On 08/03/2023 10:37:59+0200, Svyatoslav Ryhel wrote:
> MAX77663 PMIC can have RTC on both 0x63 i2c address (like grouper)
> which is main address but on some devices RTC is located on 0x48
> i2c address (like p880 and p895 from LG). Lets add property to be
> able to use alternative address if needed without breaking existing
> bindings.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/rtc/rtc-max77686.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-max77686.c b/drivers/rtc/rtc-max77686.c
> index b0250d91fb00..218177375531 100644
> --- a/drivers/rtc/rtc-max77686.c
> +++ b/drivers/rtc/rtc-max77686.c
> @@ -691,6 +691,7 @@ static int max77686_init_rtc_regmap(struct max77686_rtc_info *info)
>  {
>  	struct device *parent = info->dev->parent;
>  	struct i2c_client *parent_i2c = to_i2c_client(parent);
> +	int rtc_i2c_addr;
>  	int ret;
>  
>  	if (info->drv_data->rtc_irq_from_platform) {
> @@ -714,8 +715,13 @@ static int max77686_init_rtc_regmap(struct max77686_rtc_info *info)
>  		goto add_rtc_irq;
>  	}
>  
> +	ret = device_property_read_u32(parent, "maxim,rtc-i2c-address",
> +				       &rtc_i2c_addr);

This property needs to be documented

> +	if (ret)
> +		rtc_i2c_addr = info->drv_data->rtc_i2c_addr;
> +
>  	info->rtc = devm_i2c_new_dummy_device(info->dev, parent_i2c->adapter,
> -					      info->drv_data->rtc_i2c_addr);
> +					      rtc_i2c_addr);
>  	if (IS_ERR(info->rtc)) {
>  		dev_err(info->dev, "Failed to allocate I2C device for RTC\n");
>  		return PTR_ERR(info->rtc);
> -- 
> 2.37.2
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
