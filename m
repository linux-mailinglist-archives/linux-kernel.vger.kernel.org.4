Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84EC96EAA07
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 14:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbjDUMKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 08:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjDUMKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 08:10:40 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8649119;
        Fri, 21 Apr 2023 05:10:39 -0700 (PDT)
Received: from pendragon.ideasonboard.com (133-32-181-51.west.xps.vectant.ne.jp [133.32.181.51])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id DC23B75B;
        Fri, 21 Apr 2023 14:10:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1682079030;
        bh=MLjiFgbZVuI3QHLjV0pcQsParubvi2960NDK92t2VeM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UCYcszbQse930iXlOS4V0MvlYvbXx7zuT3NSaBRPGAVIZmgUJYYq3eZyf+epPQsrN
         4bqP2D2ZGy4xh/sC1FOrgA/gqMk3Y8v9qrLeY1sUFgg2Zol2KLxaGI2gbPj0tZkdFn
         iyuZsdFhtSPQtrjlQ9XUDEO0sYS28bXUV1NMZLFg=
Date:   Fri, 21 Apr 2023 15:10:48 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Vaishnav Achath <vaishnav.a@ti.com>
Cc:     mchehab@kernel.org, sakari.ailus@linux.intel.com,
        hverkuil-cisco@xs4all.nl, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, u-kumar1@ti.com
Subject: Re: [PATCH] media: v4l2-mc: Drop subdev check in
 v4l2_create_fwnode_links_to_pad()
Message-ID: <20230421121048.GK21943@pendragon.ideasonboard.com>
References: <20230421100430.28962-1-vaishnav.a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230421100430.28962-1-vaishnav.a@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vaishnav,

Thank you for the patch.

On Fri, Apr 21, 2023 at 03:34:30PM +0530, Vaishnav Achath wrote:
> While updating v4l2_create_fwnode_links_to_pad() to accept non-subdev
> sinks, the check is_media_entity_v4l2_subdev() was not removed which
> prevented the function from being used with non-subdev sinks, Drop the
> unnecessary check.
> 
> Fixes: bd5a03bc5be8 ("media: Accept non-subdev sinks in v4l2_create_fwnode_links_to_pad()")
> 
> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Sakari, the commit this patch fixes will land in v6.4, should this be
merged as a v6.4 fix ?

> ---
>  drivers/media/v4l2-core/v4l2-mc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-mc.c b/drivers/media/v4l2-core/v4l2-mc.c
> index bf0c18100664..22fe08fce0a9 100644
> --- a/drivers/media/v4l2-core/v4l2-mc.c
> +++ b/drivers/media/v4l2-core/v4l2-mc.c
> @@ -314,8 +314,7 @@ int v4l2_create_fwnode_links_to_pad(struct v4l2_subdev *src_sd,
>  {
>  	struct fwnode_handle *endpoint;
>  
> -	if (!(sink->flags & MEDIA_PAD_FL_SINK) ||
> -	    !is_media_entity_v4l2_subdev(sink->entity))
> +	if (!(sink->flags & MEDIA_PAD_FL_SINK))
>  		return -EINVAL;
>  
>  	fwnode_graph_for_each_endpoint(dev_fwnode(src_sd->dev), endpoint) {

-- 
Regards,

Laurent Pinchart
