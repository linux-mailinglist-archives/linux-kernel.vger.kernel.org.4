Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA6B67FE84
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 12:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjA2LXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 06:23:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjA2LW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 06:22:58 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9C286B4;
        Sun, 29 Jan 2023 03:22:56 -0800 (PST)
Received: from ideasonboard.com (host-212-171-97-20.pool212171.interbusiness.it [212.171.97.20])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8F9F2327;
        Sun, 29 Jan 2023 12:22:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1674991373;
        bh=18lyyDdMH3ASfX0bsVz4X4eeAG0fyPMWsl95UcdFtt8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GIruMnyHmhxawvfqEv5j1SYgcVDuenq19Y0MpjkL9GIfqSnyYVcBa1lGFR+8X4NFD
         azg7HrZoNWC8+1Sn9VVW3MNn8/xOxsshDSLWLPEvR+YipKYIwuSGMTxzgewK1+8nl/
         GUGbxBfIdwKTrNeY3joSIJmaNwggtB/HQDMm1Iwc=
Date:   Sun, 29 Jan 2023 12:22:49 +0100
From:   Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] media: i2c: ov2685: Make reset gpio optional
Message-ID: <20230129112249.lf2vb7pthrv4nien@uno.localdomain>
References: <20230129-ov2685-improvements-v1-0-f281bd49399c@z3ntu.xyz>
 <20230129-ov2685-improvements-v1-1-f281bd49399c@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230129-ov2685-improvements-v1-1-f281bd49399c@z3ntu.xyz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luca

On Sun, Jan 29, 2023 at 10:42:35AM +0100, Luca Weiss wrote:
> In some setups XSHUTDOWN is connected to DOVDD when it's unused,
> therefore treat the reset gpio as optional.

I don't have a datasheet for this sensor, but OV sensors usually have
to gpio lines to control powerdown and reset. Datasheets usually
suggest to hook one of the 2 to DOVDD and control the other from the
SoC. How is the sensor hooked up in your design ? No gpio lines is
controlled by the SoC ?

Another question is if we need to software-reset the sensor if no gpio
line is hooked up to XSHUTDOWN.

>
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>  drivers/media/i2c/ov2685.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/media/i2c/ov2685.c b/drivers/media/i2c/ov2685.c
> index a3b524f15d89..a422f4c8a2eb 100644
> --- a/drivers/media/i2c/ov2685.c
> +++ b/drivers/media/i2c/ov2685.c
> @@ -734,7 +734,7 @@ static int ov2685_probe(struct i2c_client *client,
>  	if (clk_get_rate(ov2685->xvclk) != OV2685_XVCLK_FREQ)
>  		dev_warn(dev, "xvclk mismatched, modes are based on 24MHz\n");
>
> -	ov2685->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
> +	ov2685->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
>  	if (IS_ERR(ov2685->reset_gpio)) {
>  		dev_err(dev, "Failed to get reset-gpios\n");
>  		return -EINVAL;
>
> --
> 2.39.1
>
