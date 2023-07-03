Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AADE745F02
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 16:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjGCOrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 10:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjGCOre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 10:47:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB3810F9;
        Mon,  3 Jul 2023 07:47:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0525060F59;
        Mon,  3 Jul 2023 14:47:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB6A9C433C7;
        Mon,  3 Jul 2023 14:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688395631;
        bh=0+HXRIje9Ard9diwM3PfMrFZZF9PNbX5EcSRVaV+SIc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mBEp3Y+/ivPwlfOe2N0+4Zc3M3+sctlgzv6KEosYsahzcLayVHqAiYVt/CPzLPuOK
         y7ydw10R8dsXPHWK3W7zszU/Qi2MeztWCLpgUVmx5kznDc9Fy1GruZzPCqL0HPDSHk
         kGMZ7SNrGylNEOlr9ZdDtcaVXYt5anIqlJNe+tRs=
Date:   Mon, 3 Jul 2023 16:46:25 +0200
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
Message-ID: <2023070309-flashback-droplet-a938@gregkh>
References: <20230627201628.207483-1-umang.jain@ideasonboard.com>
 <20230627201628.207483-4-umang.jain@ideasonboard.com>
 <2023070319-daycare-pointless-abba@gregkh>
 <f080a725-65ea-c3fe-896a-5ac711dddfc1@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f080a725-65ea-c3fe-896a-5ac711dddfc1@ideasonboard.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2023 at 04:44:39PM +0200, Umang Jain wrote:
> Hi Greg,
> 
> On 7/3/23 3:29 PM, Greg KH wrote:
> > On Tue, Jun 27, 2023 at 10:16:26PM +0200, Umang Jain wrote:
> > > Register the bcm2835-camera with the vchiq_bus_type instead of using
> > > platform driver/device.
> > > 
> > > Also the VCHIQ firmware doesn't support device enumeration, hence
> > > one has to maintain a list of devices to be registered in the interface.
> > > 
> > > Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> > > ---
> > >   .../bcm2835-camera/bcm2835-camera.c           | 16 +++++++-------
> > >   .../interface/vchiq_arm/vchiq_arm.c           | 21 ++++++++++++++++---
> > >   2 files changed, 26 insertions(+), 11 deletions(-)
> > > 
> > > diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
> > > index 346d00df815a..f37b2a881d92 100644
> > > --- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
> > > +++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
> > > @@ -24,8 +24,9 @@
> > >   #include <media/v4l2-event.h>
> > >   #include <media/v4l2-common.h>
> > >   #include <linux/delay.h>
> > > -#include <linux/platform_device.h>
> > > +#include "../interface/vchiq_arm/vchiq_arm.h"
> > > +#include "../interface/vchiq_arm/vchiq_device.h"
> > >   #include "../vchiq-mmal/mmal-common.h"
> > >   #include "../vchiq-mmal/mmal-encodings.h"
> > >   #include "../vchiq-mmal/mmal-vchiq.h"
> > > @@ -1841,7 +1842,7 @@ static struct v4l2_format default_v4l2_format = {
> > >   	.fmt.pix.sizeimage = 1024 * 768,
> > >   };
> > > -static int bcm2835_mmal_probe(struct platform_device *pdev)
> > > +static int bcm2835_mmal_probe(struct vchiq_device *device)
> > >   {
> > >   	int ret;
> > >   	struct bcm2835_mmal_dev *dev;
> > > @@ -1896,7 +1897,7 @@ static int bcm2835_mmal_probe(struct platform_device *pdev)
> > >   						       &camera_instance);
> > >   		ret = v4l2_device_register(NULL, &dev->v4l2_dev);
> > >   		if (ret) {
> > > -			dev_err(&pdev->dev, "%s: could not register V4L2 device: %d\n",
> > > +			dev_err(&device->dev, "%s: could not register V4L2 device: %d\n",
> > >   				__func__, ret);
> > >   			goto free_dev;
> > >   		}
> > > @@ -1976,7 +1977,7 @@ static int bcm2835_mmal_probe(struct platform_device *pdev)
> > >   	return ret;
> > >   }
> > > -static void bcm2835_mmal_remove(struct platform_device *pdev)
> > > +static void bcm2835_mmal_remove(struct vchiq_device *device)
> > >   {
> > >   	int camera;
> > >   	struct vchiq_mmal_instance *instance = gdev[0]->instance;
> > > @@ -1988,17 +1989,16 @@ static void bcm2835_mmal_remove(struct platform_device *pdev)
> > >   	vchiq_mmal_finalise(instance);
> > >   }
> > > -static struct platform_driver bcm2835_camera_driver = {
> > > +static struct vchiq_driver bcm2835_camera_driver = {
> > >   	.probe		= bcm2835_mmal_probe,
> > > -	.remove_new	= bcm2835_mmal_remove,
> > > +	.remove		= bcm2835_mmal_remove,
> > No need to change this here, right?  That's independant of this patch
> > series.
> 
> Why not ?
> 
> Should I have "remove_new()"  in the struct vchiq_driver {..} [Patch 1/5]
> instead of "remove()"  -  match up with platform_driver virtual interface ?

Ah, sorry, my fault, I thought this was just a platform driver change.
This is fine.

greg k-h
