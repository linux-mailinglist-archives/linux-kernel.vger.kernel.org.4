Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB0035FF8C9
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 08:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiJOGZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 02:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiJOGZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 02:25:43 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDAE58DC5;
        Fri, 14 Oct 2022 23:25:41 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0D73D499;
        Sat, 15 Oct 2022 08:25:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1665815140;
        bh=aT2KguQxhadQQ+y3D46GilX6S6F7D+eDnpeZT75gGnQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q4Q/V66AG52J5lfu+z16XnYGm3bPx8toWyjUM/5VYDj409KZGRis/UuVje77oiC7W
         PYoXFnXUiWpYQBE762q1lD4Rl1kYF5qAS2b0hIQ84t61FsjNbyxGCXpgRe2DtuO+lu
         47DoFiL6E70WinIHtrvk8kriAdmFe4slZsCbZkrQ=
Date:   Sat, 15 Oct 2022 09:25:37 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Shawn Tu <shawnx.tu@intel.com>,
        Jacopo Mondi <jacopo@jmondi.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v2 4/5] media: i2c: ov5645: Return zero for s_stream(0)
Message-ID: <Y0pSYfw+VDxXv85b@pendragon.ideasonboard.com>
References: <20221014183459.181567-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221014183459.181567-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221014183459.181567-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

Thank you for the patch.

On Fri, Oct 14, 2022 at 07:34:58PM +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Always return zero while stopping the stream as the caller will ignore the
> return value.
> 
> This patch drops checking the return value of ov5645_write_reg() and
> continues further in the code path while stopping stream. The user anyway
> gets an error message in case ov5645_write_reg() fails.

Continuing all the way to pm_runtime_put() is fine, but I don't think
the function should return 0. It's not up to the driver to decide if a
failure would be useful to signal to the caller or not.

> Suggested-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v1->v2
> * New patch
> ---
>  drivers/media/i2c/ov5645.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/media/i2c/ov5645.c b/drivers/media/i2c/ov5645.c
> index a0b9d0c43b78..b3825294aaf1 100644
> --- a/drivers/media/i2c/ov5645.c
> +++ b/drivers/media/i2c/ov5645.c
> @@ -995,14 +995,11 @@ static int ov5645_s_stream(struct v4l2_subdev *subdev, int enable)
>  		if (ret < 0)
>  			goto err_rpm_put;
>  	} else {
> -		ret = ov5645_write_reg(ov5645, OV5645_IO_MIPI_CTRL00, 0x40);
> -		if (ret < 0)
> -			return ret;
> +		ov5645_write_reg(ov5645, OV5645_IO_MIPI_CTRL00, 0x40);
> +
> +		ov5645_write_reg(ov5645, OV5645_SYSTEM_CTRL0,
> +				 OV5645_SYSTEM_CTRL0_STOP);
>  
> -		ret = ov5645_write_reg(ov5645, OV5645_SYSTEM_CTRL0,
> -				       OV5645_SYSTEM_CTRL0_STOP);
> -		if (ret < 0)
> -			return ret;
>  		pm_runtime_put(ov5645->dev);
>  	}
>  

-- 
Regards,

Laurent Pinchart
