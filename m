Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738A2696141
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 11:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbjBNKpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 05:45:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjBNKpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 05:45:46 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528A672BA;
        Tue, 14 Feb 2023 02:45:21 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E29533D7;
        Tue, 14 Feb 2023 11:44:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1676371475;
        bh=LgXIhzXlHcYn51kJucQuyEecJ0gO+eQkyE0ZY1xUqlY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cmSZkqYosg9NqqJgQ3qkQTUwFwaF63JYdcOIrsPYu8JxaBzAMj1JBhknVoOIbSq3S
         n50LB1+22pBtHLVHW3l/dgzwceGzyJDngZcEbjfz2KFyQzs2cJhYMlOvcdNX/VlqJq
         U+b1Pd5o41SFnqCg1NJi9oRZULXWeQ0Mr+MofigA=
Date:   Tue, 14 Feb 2023 12:44:34 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Mirela Rabulea <mirela.rabulea@nxp.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Ming Qian <ming.qian@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: imx-jpeg: avoid array overflow
Message-ID: <Y+tmEpvr5tky+YbY@pendragon.ideasonboard.com>
References: <20230214102827.920927-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230214102827.920927-1-arnd@kernel.org>
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

On Tue, Feb 14, 2023 at 11:28:20AM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> gcc-9 (unlike newer versions) reports a possible array overflow
> in mxc_jpeg_dec_irq():
> 
> drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c: In function 'mxc_jpeg_dec_irq':
> drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c:641:28: error: array subscript 2 is above array bounds of 'u32[2]' {aka 'unsigned int[2]'} [-Werror=array-bounds]
>   641 |   size += q_data->sizeimage[i];
>       |           ~~~~~~~~~~~~~~~~~^~~
> drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c:641:28: error: array subscript 3 is above array bounds of 'u32[2]' {aka 'unsigned int[2]'} [-Werror=array-bounds]
> 
> The compiler clearly deduces that fmt->mem_planes is at least '2' if
> this code line is reached, and that fmt->comp_planes must be at least
> one more for the loop to make sense. However, this does not actually
> seem to be the case in the initialized values, so I would guess that
> this part of the function is never reached in practice.
> 
> As a workaround, add a compile-time condition that skips any out-of-range
> array indices.
> 
> Fixes: ccc9f1db9c6b ("media: imx-jpeg: Support contiguous and non contiguous format")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> index f085f14d676a..7a667bfc2424 100644
> --- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> +++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> @@ -638,7 +638,8 @@ static u32 mxc_jpeg_get_plane_size(struct mxc_jpeg_q_data *q_data, u32 plane_no)
>  
>  	size = q_data->sizeimage[fmt->mem_planes - 1];
>  	for (i = fmt->mem_planes; i < fmt->comp_planes; i++)
> -		size += q_data->sizeimage[i];
> +		if (i < MXC_JPEG_MAX_PLANES)
> +			size += q_data->sizeimage[i];

There's a risk someone will try to optimize this later, realizing that
the check isn't needed, and we'll get the warning back. A comment would
thus be useful.

Also, how about writing it as

	for (i = fmt->mem_planes; i < min(fmt->comp_planes, MXC_JPEG_MAX_PLANES); i++)
		size += q_data->sizeimage[i];

>  
>  	return size;
>  }

-- 
Regards,

Laurent Pinchart
