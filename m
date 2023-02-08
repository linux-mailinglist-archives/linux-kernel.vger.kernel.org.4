Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B264868F1EB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 16:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjBHPYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 10:24:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjBHPYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 10:24:41 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B59843910;
        Wed,  8 Feb 2023 07:24:40 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B832DE79;
        Wed,  8 Feb 2023 16:24:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1675869879;
        bh=J2AM0VSiaK/y4JYEQt5auLng2d4dU5C3HzbJTR4RmLE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CMbTz6igmjaPzRETReTnGhosfIGL3ITOVk8hYp4bnvbGUV/TptUBF6eafMIDBt3g+
         ZRkc2Ckb5nLUOQWnD6p97Mfh3ydipKOf+sN/uG4hCNmjpum2ycNtxsd1k2Z1oCq7n/
         xaUl879LK+b/75j+6dXxUvMXcfw1LIMXJir0szLQ=
Date:   Wed, 8 Feb 2023 17:24:37 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v1 1/1] media: i2c: imx290: Make use of
 get_unaligned_le24(), put_unaligned_le24()
Message-ID: <Y+O+tcx9eFfBNjWm@pendragon.ideasonboard.com>
References: <20230208112957.15563-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230208112957.15563-1-andriy.shevchenko@linux.intel.com>
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

On Wed, Feb 08, 2023 at 01:29:57PM +0200, Andy Shevchenko wrote:
> Since we have a proper endianness converters for LE 24-bit data use
> them. While at it, format the code using switch-cases as it's done
> for the rest of the endianness handlers.

I don't see any new switch-case :-)

The rest looks fine.

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
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
