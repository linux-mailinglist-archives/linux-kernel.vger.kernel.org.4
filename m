Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4E168F1F1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 16:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbjBHP1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 10:27:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjBHP1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 10:27:37 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A77C301AD;
        Wed,  8 Feb 2023 07:27:36 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D5660E79;
        Wed,  8 Feb 2023 16:27:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1675870055;
        bh=v2kB8dThcKfo0PAIArXh+N1F/eUzy2P5U/bncrQmbsE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R7awEdcAld66PPze9JPXGjcVTmnb/GpMRs1PpsZkPs9hanKBY640Wx12a6BgNtEM4
         T73mh/Cuepm9EgZLhnpfB4NXAjeF5Gev1afA+YiG8Ls4bgRB/pOb8aPyt49hzWnVf2
         q5ZKOhfa2Kg0hRVDKYpdl4WCY4y75/A9BNFRRbWI=
Date:   Wed, 8 Feb 2023 17:27:33 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v1 1/1] media: i2c: imx290: Use
 device_property_read_u32() directly
Message-ID: <Y+O/ZbAa3zu1nSI0@pendragon.ideasonboard.com>
References: <20230208113348.16880-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230208113348.16880-1-andriy.shevchenko@linux.intel.com>
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

On Wed, Feb 08, 2023 at 01:33:48PM +0200, Andy Shevchenko wrote:
> No need to call fwnode_property_read_u32(dev_fwnode()), when
> we have already existing helper. So use it.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/media/i2c/imx290.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/media/i2c/imx290.c b/drivers/media/i2c/imx290.c
> index 330098a0772d..e7aa2ecdcc88 100644
> --- a/drivers/media/i2c/imx290.c
> +++ b/drivers/media/i2c/imx290.c
> @@ -1137,8 +1137,7 @@ static int imx290_init_clk(struct imx290 *imx290)
>  	u32 xclk_freq;
>  	int ret;
>  
> -	ret = fwnode_property_read_u32(dev_fwnode(imx290->dev),
> -				       "clock-frequency", &xclk_freq);
> +	ret = device_property_read_u32(imx290->dev, "clock-frequency", &xclk_freq);

I'd break the line here.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>  	if (ret) {
>  		dev_err(imx290->dev, "Could not get xclk frequency\n");
>  		return ret;

-- 
Regards,

Laurent Pinchart
