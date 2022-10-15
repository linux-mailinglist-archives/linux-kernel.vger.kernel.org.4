Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 143FE5FF8D6
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 08:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbiJOG2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 02:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiJOG1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 02:27:13 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBA9659E4;
        Fri, 14 Oct 2022 23:26:39 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0B941499;
        Sat, 15 Oct 2022 08:26:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1665815198;
        bh=Cn/hJ0clCI7VAKIRxe8PPQFi5xPi17rVs3wRrQadLxM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WcdCzKUmydu+xlPtWNxlPMVcRY5JR1XsD4CBXFkR9SZhYHQ6XQAoR9UFAu2HYZUMT
         IjUKRpvpKWKSNHMpwJ0V0gtanpvpJCIGhQUck6sAz4VCUFCkzFwlFNWaifirNVaACd
         rEnjuG4Jyeg7z48UX7ORJ2WVQlOEJHkSvH9tI0hA=
Date:   Sat, 15 Oct 2022 09:26:36 +0300
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
Subject: Re: [PATCH v2 5/5] media: i2c: ov5645: Call ov5645_entity_init_cfg()
 before registering the subdev
Message-ID: <Y0pSnKREW0pjtPYI@pendragon.ideasonboard.com>
References: <20221014183459.181567-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221014183459.181567-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221014183459.181567-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

On Fri, Oct 14, 2022 at 07:34:59PM +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Make sure we call ov5645_entity_init_cfg() before registering the subdev
> to make sure default formats are set up.
> 
> Suggested-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

If you have a few spare cycles, it would be even better to convert the
driver to the subdev active state API :-) You could then drop this call
entirely.

> ---
> v1->v2
> * New patch
> ---
>  drivers/media/i2c/ov5645.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/i2c/ov5645.c b/drivers/media/i2c/ov5645.c
> index b3825294aaf1..14bcc6e42dd2 100644
> --- a/drivers/media/i2c/ov5645.c
> +++ b/drivers/media/i2c/ov5645.c
> @@ -1212,6 +1212,8 @@ static int ov5645_probe(struct i2c_client *client)
>  		goto err_pm_runtime;
>  	}
>  
> +	ov5645_entity_init_cfg(&ov5645->sd, NULL);
> +
>  	ret = v4l2_async_register_subdev(&ov5645->sd);
>  	if (ret < 0) {
>  		dev_err(dev, "could not register v4l2 device\n");
> @@ -1224,8 +1226,6 @@ static int ov5645_probe(struct i2c_client *client)
>  	pm_runtime_use_autosuspend(dev);
>  	pm_runtime_put_autosuspend(dev);
>  
> -	ov5645_entity_init_cfg(&ov5645->sd, NULL);
> -
>  	return 0;
>  
>  err_pm_runtime:

-- 
Regards,

Laurent Pinchart
