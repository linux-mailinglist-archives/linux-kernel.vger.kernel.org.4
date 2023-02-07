Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4496568DE10
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 17:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjBGQkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 11:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjBGQkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 11:40:20 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE60F166FD;
        Tue,  7 Feb 2023 08:40:18 -0800 (PST)
Received: from pendragon.ideasonboard.com (unknown [109.136.43.56])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B94E6589;
        Tue,  7 Feb 2023 17:40:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1675788016;
        bh=wq7TOYV2DuTuczCso9xs9cP6d5UpUm8m76Tk/x6Pvoc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hh7q+YvOOnhWnBaKu9RhL0V7m9Zt4iUOW5eQCMmPgpPZw0C8+LO4k38TMRhDn4ynb
         2DWI4I3dY0PCcirelnQaNB/K1+Ldja4eY+yXF6pwb1Dxf07BiDH2GfVXsuVkDL88bf
         maH5tW2sKtJ8Aet94ilkTuhtN3lTM4vVW3dWlwFI=
Date:   Tue, 7 Feb 2023 18:40:14 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: i2c: imx290: fix conditional function defintions
Message-ID: <Y+J+7lsf083k4x80@pendragon.ideasonboard.com>
References: <20230207161316.293923-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230207161316.293923-1-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

Thank you for the patch.

On Tue, Feb 07, 2023 at 05:13:12PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The runtime suspend/resume functions are only referenced from the
> dev_pm_ops, but they use the old SET_RUNTIME_PM_OPS() helper
> that requires a __maybe_unused annotation to avoid a warning:
> 
> drivers/media/i2c/imx290.c:1082:12: error: unused function 'imx290_runtime_resume' [-Werror,-Wunused-function]
> static int imx290_runtime_resume(struct device *dev)
>            ^
> drivers/media/i2c/imx290.c:1090:12: error: unused function 'imx290_runtime_suspend' [-Werror,-Wunused-function]
> static int imx290_runtime_suspend(struct device *dev)
>            ^
> 
> Convert this to the new RUNTIME_PM_OPS() helper that so this
> is not required. To improve this further, also use the pm_ptr()
> helper that lets the dev_pm_ops get dropped entirely when
> CONFIG_PM is disabled.
> 
> A related mistake happened in the of_match_ptr() macro here, which
> like SET_RUNTIME_PM_OPS() requires the match table to be marked
> as __maybe_unused, though I could not reproduce building this without
> CONFIG_OF. Remove the of_match_ptr() here as there is no point in
> dropping the match table in configurations without CONFIG_OF.
> 
> Fixes: 02852c01f654 ("media: i2c: imx290: Initialize runtime PM before subdev")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/media/i2c/imx290.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/media/i2c/imx290.c b/drivers/media/i2c/imx290.c
> index 49d6c8bdec41..48ae2e0adf9e 100644
> --- a/drivers/media/i2c/imx290.c
> +++ b/drivers/media/i2c/imx290.c
> @@ -1098,7 +1098,7 @@ static int imx290_runtime_suspend(struct device *dev)
>  }
>  
>  static const struct dev_pm_ops imx290_pm_ops = {
> -	SET_RUNTIME_PM_OPS(imx290_runtime_suspend, imx290_runtime_resume, NULL)
> +	RUNTIME_PM_OPS(imx290_runtime_suspend, imx290_runtime_resume, NULL)
>  };
>  
>  /* ----------------------------------------------------------------------------
> @@ -1362,8 +1362,8 @@ static struct i2c_driver imx290_i2c_driver = {
>  	.remove = imx290_remove,
>  	.driver = {
>  		.name  = "imx290",
> -		.pm = &imx290_pm_ops,
> -		.of_match_table = of_match_ptr(imx290_of_match),
> +		.pm = pm_ptr(&imx290_pm_ops),
> +		.of_match_table = imx290_of_match,
>  	},
>  };
>  

-- 
Regards,

Laurent Pinchart
