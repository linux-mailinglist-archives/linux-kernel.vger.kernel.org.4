Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBEA66748EA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 02:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjATBfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 20:35:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjATBfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 20:35:47 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDEB1A6C4B;
        Thu, 19 Jan 2023 17:35:42 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6C5CF514;
        Fri, 20 Jan 2023 02:35:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1674178540;
        bh=1e/LkC/AWtUpZm9OJ2dgJop/d/JDH2chsbU5gwSmkVQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tbZI/5kyibv5UfM//cxWY/XK0zcUsccQuKhTFHv9wW9AyEB1q/XUjQ2mu4A+oRow9
         yJu33n2valeTm/7zJl+HtPX1UyH3dQksjrwcM/DkK/kxzLOf1t+iULBwHIu0uc3brB
         Zhly9D3Xl03vRJbkmmd5Rfv6fM8kXC8ybMPiKUCc=
Date:   Fri, 20 Jan 2023 03:35:38 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Umang Jain <umang.jain@ideasonboard.com>
Cc:     linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrien Thierry <athierry@redhat.com>,
        Dan Carpenter <error27@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Paul Elder <paul.elder@ideasonboard.com>
Subject: Re: [PATCH v5 5/6] staging: vc04_services: interface: Drop include
 Makefile directive
Message-ID: <Y8nv6tZ3PhUYpsKm@pendragon.ideasonboard.com>
References: <20230119115503.268693-1-umang.jain@ideasonboard.com>
 <20230119115503.268693-6-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230119115503.268693-6-umang.jain@ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Umang,

Thank you for the patch.

On Thu, Jan 19, 2023 at 05:25:02PM +0530, Umang Jain wrote:
> Drop the include directive they can break the build one only wants to
> build a subdirectory. Replace with "../" for the includes, in the
> interface/ files instead.
> 
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> ---
>  drivers/staging/vc04_services/Makefile                         | 2 --
>  drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h | 2 +-
>  .../staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h    | 3 ++-
>  3 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/vc04_services/Makefile b/drivers/staging/vc04_services/Makefile
> index 1fd191e2e2a5..44794bdf6173 100644
> --- a/drivers/staging/vc04_services/Makefile
> +++ b/drivers/staging/vc04_services/Makefile
> @@ -15,5 +15,3 @@ obj-$(CONFIG_SND_BCM2835)		+= bcm2835-audio/
>  obj-$(CONFIG_VIDEO_BCM2835)		+= bcm2835-camera/
>  obj-$(CONFIG_BCM2835_VCHIQ_MMAL)	+= vchiq-mmal/
>  
> -ccflags-y += -I $(srctree)/$(src)/include
> -

Same comment as for 2/6. Personally, I think I'd prefer dropping 2/6,
4/6 and 5/6 until it's time to move vchiq out of staging, at which point
the ccflags-y will just be dropped, without requiring other changes.

> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
> index 3c198eb1c77a..ec1a3caefaea 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
> @@ -10,8 +10,8 @@
>  #include <linux/kref.h>
>  #include <linux/rcupdate.h>
>  #include <linux/wait.h>
> -#include <linux/raspberrypi/vchiq.h>
>  
> +#include "../../include/linux/raspberrypi/vchiq.h"
>  #include "vchiq_cfg.h"
>  
>  /* Do this so that we can test-build the code on non-rpi systems */
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h
> index 96f50beace44..17550831f86c 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h
> @@ -5,7 +5,8 @@
>  #define VCHIQ_IOCTLS_H
>  
>  #include <linux/ioctl.h>
> -#include <linux/raspberrypi/vchiq.h>
> +
> +#include "../../include/linux/raspberrypi/vchiq.h"
>  
>  #define VCHIQ_IOC_MAGIC 0xc4
>  #define VCHIQ_INVALID_HANDLE (~0)

-- 
Regards,

Laurent Pinchart
