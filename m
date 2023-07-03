Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADC9D745D8B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 15:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbjGCNfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 09:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjGCNfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 09:35:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BBEE3;
        Mon,  3 Jul 2023 06:35:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 062E060F33;
        Mon,  3 Jul 2023 13:35:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CD0CC433C8;
        Mon,  3 Jul 2023 13:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688391312;
        bh=lPbmeFzhOOGrIsy8r8petL2/X1NI/8eaQFwx0o3iMv0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KlnBad0Gn0TJ3ilZMv9LBQVhdDz5bsVYW6GySkYYRxy8SlBqqtzBeDchQM7eF10RQ
         go8sp2tWfbkv3q5EFTo6wZZdY4UCIJlB/tVkaj+mGZSFzhNoz2/KiEvkKiz95K5Sxo
         JOHNl/y5mB4dlbUwO09v6D3qbvUlE6INjBMhffmc=
Date:   Mon, 3 Jul 2023 15:29:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Umang Jain <umang.jain@ideasonboard.com>
Cc:     linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, stefan.wahren@i2se.com,
        f.fainelli@gmail.com, athierry@redhat.com, error27@gmail.com,
        dave.stevenson@raspberrypi.com, kieran.bingham@ideasonboard.com,
        laurent.pinchart@ideasonboard.com
Subject: Re: [PATCH v8 3/5] staging: bcm2835-camera: Register bcm2835-camera
 with vchiq_bus_type
Message-ID: <2023070319-daycare-pointless-abba@gregkh>
References: <20230627201628.207483-1-umang.jain@ideasonboard.com>
 <20230627201628.207483-4-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627201628.207483-4-umang.jain@ideasonboard.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 10:16:26PM +0200, Umang Jain wrote:
> Register the bcm2835-camera with the vchiq_bus_type instead of using
> platform driver/device.
> 
> Also the VCHIQ firmware doesn't support device enumeration, hence
> one has to maintain a list of devices to be registered in the interface.
> 
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> ---
>  .../bcm2835-camera/bcm2835-camera.c           | 16 +++++++-------
>  .../interface/vchiq_arm/vchiq_arm.c           | 21 ++++++++++++++++---
>  2 files changed, 26 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
> index 346d00df815a..f37b2a881d92 100644
> --- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
> +++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
> @@ -24,8 +24,9 @@
>  #include <media/v4l2-event.h>
>  #include <media/v4l2-common.h>
>  #include <linux/delay.h>
> -#include <linux/platform_device.h>
>  
> +#include "../interface/vchiq_arm/vchiq_arm.h"
> +#include "../interface/vchiq_arm/vchiq_device.h"
>  #include "../vchiq-mmal/mmal-common.h"
>  #include "../vchiq-mmal/mmal-encodings.h"
>  #include "../vchiq-mmal/mmal-vchiq.h"
> @@ -1841,7 +1842,7 @@ static struct v4l2_format default_v4l2_format = {
>  	.fmt.pix.sizeimage = 1024 * 768,
>  };
>  
> -static int bcm2835_mmal_probe(struct platform_device *pdev)
> +static int bcm2835_mmal_probe(struct vchiq_device *device)
>  {
>  	int ret;
>  	struct bcm2835_mmal_dev *dev;
> @@ -1896,7 +1897,7 @@ static int bcm2835_mmal_probe(struct platform_device *pdev)
>  						       &camera_instance);
>  		ret = v4l2_device_register(NULL, &dev->v4l2_dev);
>  		if (ret) {
> -			dev_err(&pdev->dev, "%s: could not register V4L2 device: %d\n",
> +			dev_err(&device->dev, "%s: could not register V4L2 device: %d\n",
>  				__func__, ret);
>  			goto free_dev;
>  		}
> @@ -1976,7 +1977,7 @@ static int bcm2835_mmal_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> -static void bcm2835_mmal_remove(struct platform_device *pdev)
> +static void bcm2835_mmal_remove(struct vchiq_device *device)
>  {
>  	int camera;
>  	struct vchiq_mmal_instance *instance = gdev[0]->instance;
> @@ -1988,17 +1989,16 @@ static void bcm2835_mmal_remove(struct platform_device *pdev)
>  	vchiq_mmal_finalise(instance);
>  }
>  
> -static struct platform_driver bcm2835_camera_driver = {
> +static struct vchiq_driver bcm2835_camera_driver = {
>  	.probe		= bcm2835_mmal_probe,
> -	.remove_new	= bcm2835_mmal_remove,
> +	.remove		= bcm2835_mmal_remove,

No need to change this here, right?  That's independant of this patch
series.

thanks,

greg k-h
