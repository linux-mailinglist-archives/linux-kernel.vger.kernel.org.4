Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D2E6D72CF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 06:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjDEEAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 00:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjDEEAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 00:00:31 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A72130ED;
        Tue,  4 Apr 2023 21:00:30 -0700 (PDT)
Received: from pendragon.ideasonboard.com (fp76f193f3.tkyc206.ap.nuro.jp [118.241.147.243])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 40241905;
        Wed,  5 Apr 2023 06:00:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1680667228;
        bh=AHIsH12us0GQXr96+co1pM5tm6f1rwXMYmg/pzvTPKw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pooJfr1XDvgME43QEgTlYSUpVUYybfLU0cWmbZr7oDqvCrthUz0qvO+CV5VboHV1Y
         O+dTxiMHIdV/bt2cbr5wOAPTgYB0thySLTlGuJPERoz2wMISGAaMv6aeYDydy3EH60
         /GRJwLeqUl8/zAV4afqGU+dio76Eoz17bkcD/vjc=
Date:   Wed, 5 Apr 2023 07:00:35 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] drm: shmobile: Add missing call to
 drm_fbdev_generic_setup()
Message-ID: <20230405040035.GJ9915@pendragon.ideasonboard.com>
References: <cover.1680273039.git.geert+renesas@glider.be>
 <fd4cf33c68fd103228cf4e6d76959827b187230b.1680273039.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fd4cf33c68fd103228cf4e6d76959827b187230b.1680273039.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Fri, Mar 31, 2023 at 04:48:10PM +0200, Geert Uytterhoeven wrote:
> Set up generic fbdev emulation, to enable support for the Linux console.
> 
> Use 16 as the preferred depth, as that is a good compromise between
> colorfulness and resource utilization, and the default of the fbdev
> driver.
> 
> Suggested-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpu/drm/shmobile/shmob_drm_drv.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/shmobile/shmob_drm_drv.c b/drivers/gpu/drm/shmobile/shmob_drm_drv.c
> index faacfee24763b1d4..30493ce874192e3e 100644
> --- a/drivers/gpu/drm/shmobile/shmob_drm_drv.c
> +++ b/drivers/gpu/drm/shmobile/shmob_drm_drv.c
> @@ -16,6 +16,7 @@
>  #include <linux/slab.h>
>  
>  #include <drm/drm_drv.h>
> +#include <drm/drm_fbdev_generic.h>
>  #include <drm/drm_gem_dma_helper.h>
>  #include <drm/drm_module.h>
>  #include <drm/drm_probe_helper.h>
> @@ -271,6 +272,8 @@ static int shmob_drm_probe(struct platform_device *pdev)
>  	if (ret < 0)
>  		goto err_irq_uninstall;
>  
> +	drm_fbdev_generic_setup(ddev, 16);
> +
>  	return 0;
>  
>  err_irq_uninstall:

-- 
Regards,

Laurent Pinchart
