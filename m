Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0C2169136B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 23:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjBIWfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 17:35:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjBIWfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 17:35:14 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6568321A00;
        Thu,  9 Feb 2023 14:35:13 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id BCF229CA;
        Thu,  9 Feb 2023 23:35:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1675982112;
        bh=/0TqzXqJajOit12UUq1X0NS3AbiMJg83mTyFWxQtYsY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fj2CYTY7jy/AmnnrZ+fwyYRRA4QsLMHL2kRvsZkns5LPZnBrFFz02amRoxLRZ3irH
         Ff53SEn9GDS3RKqzluCH3jKC8gDzXXLpD+3ScN+XBdkr3A0EzfJA2XirkQxgwjieQD
         mctdtP9q7ZPmlKrRbSP1SjIlf14cGEe/Qe68JT4E=
Date:   Fri, 10 Feb 2023 00:35:09 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v2 1/1] media: i2c: imx290: Make use of
 get_unaligned_le24(), put_unaligned_le24()
Message-ID: <Y+V1Hds/yCjABDnL@pendragon.ideasonboard.com>
References: <20230209221205.46573-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230209221205.46573-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Thank you for the patch.

On Fri, Feb 10, 2023 at 12:12:05AM +0200, Andy Shevchenko wrote:
> Since we have a proper endianness converters for LE 24-bit data use them.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

I assume Sakari will pick both patches.

> ---
> v2: dropped unrelated noise from the commit message (Laurent)
>  drivers/media/i2c/imx290.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/i2c/imx290.c b/drivers/media/i2c/imx290.c
> index 49d6c8bdec41..330098a0772d 100644
> --- a/drivers/media/i2c/imx290.c
> +++ b/drivers/media/i2c/imx290.c
> @@ -16,6 +16,9 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
> +
> +#include <asm/unaligned.h>
> +
>  #include <media/media-entity.h>
>  #include <media/v4l2-ctrls.h>
>  #include <media/v4l2-device.h>
> @@ -466,18 +469,20 @@ static int __always_unused imx290_read(struct imx290 *imx290, u32 addr, u32 *val
>  		return ret;
>  	}
>  
> -	*value = (data[2] << 16) | (data[1] << 8) | data[0];
> +	*value = get_unaligned_le24(data);
>  	return 0;
>  }
>  
>  static int imx290_write(struct imx290 *imx290, u32 addr, u32 value, int *err)
>  {
> -	u8 data[3] = { value & 0xff, (value >> 8) & 0xff, value >> 16 };
> +	u8 data[3];
>  	int ret;
>  
>  	if (err && *err)
>  		return *err;
>  
> +	put_unaligned_le24(value, data);
> +
>  	ret = regmap_raw_write(imx290->regmap, addr & IMX290_REG_ADDR_MASK,
>  			       data, (addr >> IMX290_REG_SIZE_SHIFT) & 3);
>  	if (ret < 0) {

-- 
Regards,

Laurent Pinchart
