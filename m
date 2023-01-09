Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 356116624E1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 12:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236979AbjAIL5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 06:57:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237040AbjAIL41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 06:56:27 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E064CF3;
        Mon,  9 Jan 2023 03:56:25 -0800 (PST)
Received: from pendragon.ideasonboard.com (85-76-142-108-nat.elisa-mobile.fi [85.76.142.108])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9F8986CF;
        Mon,  9 Jan 2023 12:56:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1673265382;
        bh=XPs/a0nVKMqSHxxTHoDGGKRDbVgF5xY49dDsiFhkpD8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PLmoZr7RwlGLLWwcEsLG9n8oXjD+y8bQOPc5lhvhoIABb6iuwghfRvuGVMTx61+A6
         bS9ffZdFQdVnZ1qZILPrK3B1qwNEutYzpt9aEMa2h6rND/bBamie3KuAsF5yp3bf6Q
         jfY2+5o0P7cuNM+O5SLtws7un/b+8ChPpvaGelxM=
Date:   Mon, 9 Jan 2023 13:56:19 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        sakari.ailus@linux.intel.com,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        niklas.soderlund+renesas@ragnatech.se,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        satish.nagireddy@getcruise.com, Tomasz Figa <tfiga@chromium.org>
Subject: Re: [PATCH v16 02/20] media: add V4L2_SUBDEV_FL_STREAMS
Message-ID: <Y7wA4z51PTf/KNK6@pendragon.ideasonboard.com>
References: <20221215121634.287100-1-tomi.valkeinen@ideasonboard.com>
 <20221215121634.287100-3-tomi.valkeinen@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221215121634.287100-3-tomi.valkeinen@ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomi,

Thank you for the patch.

On Thu, Dec 15, 2022 at 02:16:16PM +0200, Tomi Valkeinen wrote:
> Add subdev flag V4L2_SUBDEV_FL_STREAMS. It is used to indicate that the
> subdev supports the new API with multiplexed streams (routing, stream
> configs).
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>  include/media/v4l2-subdev.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/include/media/v4l2-subdev.h b/include/media/v4l2-subdev.h
> index 2f80c9c818ed..4be0a590c7c7 100644
> --- a/include/media/v4l2-subdev.h
> +++ b/include/media/v4l2-subdev.h
> @@ -879,6 +879,17 @@ struct v4l2_subdev_internal_ops {
>   * should set this flag.
>   */
>  #define V4L2_SUBDEV_FL_HAS_EVENTS		(1U << 3)
> +/*
> + * Set this flag if this subdev supports multiplexed streams. This means
> + * that the driver supports routing and handles the stream parameter in its
> + * v4l2_subdev_pad_ops handlers. More specifically, this means:
> + *
> + * - Centrally managed subdev active state is enabled
> + * - Legacy pad config is _not_ supported (state->pads is NULL)
> + * - Routing ioctls are available

I wonder, as a sanity check, should the subdev core verify that the
s_routing operation is available when this flag is set ? This could be
done on top, so

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> + * - Multiple streams per pad are supported
> + */
> +#define V4L2_SUBDEV_FL_STREAMS			(1U << 4)
>  
>  struct regulator_bulk_data;
>  

-- 
Regards,

Laurent Pinchart
