Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57BF76902E3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 10:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjBIJI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 04:08:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjBIJI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 04:08:26 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E5659E44
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 01:08:16 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B07B78DD;
        Thu,  9 Feb 2023 10:08:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1675933693;
        bh=9gEIDUadgNZyLFj40uCKC8g0CBVkC66Tp2TYayBGgC4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KjzwSJXHCoMsJmFGoR9+EZORgLva+ViDU3OouzPsoumgRO2aJRmca5O4kottegcEh
         m7/S4PVMz3Scc1g2bPQ3eu+b3XUBHYewoM7vMDO5qZA1qlVdVWccObkaCHjIOAhmxD
         Sy1EFj75D3YpRUPRTuOl8SigNQI09WFUQPbf4SLs=
Date:   Thu, 9 Feb 2023 11:08:12 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH] media: i2c: imx290: make suspend/resume functions
 __maybe_unused
Message-ID: <Y+S3/E1Djhwilu0k@pendragon.ideasonboard.com>
References: <20230208211914.7625-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230208211914.7625-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

Thank you for the patch.

On Wed, Feb 08, 2023 at 01:19:14PM -0800, Randy Dunlap wrote:
> GCC reports that these 2 functions are defined but not used, so mark
> them as __maybe_unused to pacify the build.
> 
> drivers/media/i2c/imx290.c:1090:12: warning: 'imx290_runtime_suspend' defined but not used [-Wunused-function]
>  1090 | static int imx290_runtime_suspend(struct device *dev)
>       |            ^~~~~~~~~~~~~~~~~~~~~~
> drivers/media/i2c/imx290.c:1082:12: warning: 'imx290_runtime_resume' defined but not used [-Wunused-function]
>  1082 | static int imx290_runtime_resume(struct device *dev)
>       |            ^~~~~~~~~~~~~~~~~~~~~

Arnd has sent another fix for this, see [1].

[1] https://lore.kernel.org/linux-media/20230207161316.293923-1-arnd@kernel.org/

> Fixes: 02852c01f654 ("media: i2c: imx290: Initialize runtime PM before subdev")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Alexander Stein <alexander.stein@ew.tq-group.com>
> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/media/i2c/imx290.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff -- a/drivers/media/i2c/imx290.c b/drivers/media/i2c/imx290.c
> --- a/drivers/media/i2c/imx290.c
> +++ b/drivers/media/i2c/imx290.c
> @@ -1079,7 +1079,7 @@ static void imx290_power_off(struct imx2
>  	regulator_bulk_disable(ARRAY_SIZE(imx290->supplies), imx290->supplies);
>  }
>  
> -static int imx290_runtime_resume(struct device *dev)
> +static int __maybe_unused imx290_runtime_resume(struct device *dev)
>  {
>  	struct v4l2_subdev *sd = dev_get_drvdata(dev);
>  	struct imx290 *imx290 = to_imx290(sd);
> @@ -1087,7 +1087,7 @@ static int imx290_runtime_resume(struct
>  	return imx290_power_on(imx290);
>  }
>  
> -static int imx290_runtime_suspend(struct device *dev)
> +static int __maybe_unused imx290_runtime_suspend(struct device *dev)
>  {
>  	struct v4l2_subdev *sd = dev_get_drvdata(dev);
>  	struct imx290 *imx290 = to_imx290(sd);

-- 
Regards,

Laurent Pinchart
