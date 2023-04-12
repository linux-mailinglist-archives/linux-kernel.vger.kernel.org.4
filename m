Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3366DEF94
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 10:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbjDLIwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 04:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbjDLIwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 04:52:02 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0223900A;
        Wed, 12 Apr 2023 01:51:37 -0700 (PDT)
Received: from pendragon.ideasonboard.com (133-32-181-51.west.xps.vectant.ne.jp [133.32.181.51])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id EA022616E;
        Wed, 12 Apr 2023 10:50:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1681289432;
        bh=P9omQNjGcS98ijd1kM117+6oifyx6ZMzbf6istyRB4g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fd33A+4wt3y/33SzfS4z5h7/h/wcRGcdvwjMJyAze3ctbDteoo/NRvI5UySQHI5tc
         o1prKtHhFq2S77Iwuu35OJET47uY+nL2q4CL/D6zttYHOoDgwQGRvT+/tzwFvOB4Cx
         0IxMAwS6Ug5VaiZNyAtzWetyj5o7oCxXHgLcVYkg=
Date:   Wed, 12 Apr 2023 11:50:44 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Tomi Valkeinen <tomba@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sebastian Reichel <sre@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/omap: dsi: Fix deferred probe warnings
Message-ID: <20230412085044.GP11253@pendragon.ideasonboard.com>
References: <20230412073954.20601-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230412073954.20601-1-tony@atomide.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

Thank you for the patch.

On Wed, Apr 12, 2023 at 10:39:53AM +0300, Tony Lindgren wrote:
> We may not have dsi->dsidev initialized during probe, and that can
> lead into various dsi related warnings as omap_dsi_host_detach() gets
> called with dsi->dsidev set to NULL.
> 
> The warnings can be "Fixed dependency cycle(s)" followed by a
> WARNING: CPU: 0 PID: 787 at drivers/gpu/drm/omapdrm/dss/dsi.c:4414.

How can this happen ? I assume .detach() can't be called without a
priori successful call to .attach(), that that sets dsi->dsidev.

> Let's fix the warnings by checking for a valid dsi->dsidev.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/gpu/drm/omapdrm/dss/dsi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/dss/dsi.c
> --- a/drivers/gpu/drm/omapdrm/dss/dsi.c
> +++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
> @@ -4411,7 +4411,7 @@ static int omap_dsi_host_detach(struct mipi_dsi_host *host,
>  {
>  	struct dsi_data *dsi = host_to_omap(host);
>  
> -	if (WARN_ON(dsi->dsidev != client))
> +	if (dsi->dsidev && WARN_ON(dsi->dsidev != client))
>  		return -EINVAL;
>  
>  	cancel_delayed_work_sync(&dsi->dsi_disable_work);

-- 
Regards,

Laurent Pinchart
