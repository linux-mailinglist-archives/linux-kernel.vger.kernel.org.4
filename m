Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD2616776E3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 09:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjAWI6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 03:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbjAWI6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 03:58:39 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74B5EB58;
        Mon, 23 Jan 2023 00:58:38 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 047CC2B3;
        Mon, 23 Jan 2023 09:58:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1674464316;
        bh=lw5ZoZGd0JjnnsdpQ85HbvHHq83hF6MA1T6umOobxfI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HbUpt0++foq2zNyIboCH9YHJlz54AlYhOeFSKrs4wdTONGxn4EPdx4O80QLaVrJqm
         8pjdhOlD1azPnFZmGkHhbGHbP8kmjEtYvNsOaLCSb4j+NGtCDN8bjX85sawYQ/LsVT
         LQ4zPJSlEDeky41pnmmjxQjgeuy3aiuUo6AZFmqM=
Date:   Mon, 23 Jan 2023 10:58:33 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Umang Jain <umang.jain@ideasonboard.com>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrien Thierry <athierry@redhat.com>,
        Dan Carpenter <error27@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Paul Elder <paul.elder@ideasonboard.com>
Subject: Re: [PATCH v6 0/6] staging: vc04_services: vchiq: Register devices
 with a custom bus_type
Message-ID: <Y85MOdAVh/fv5HRt@pendragon.ideasonboard.com>
References: <20230120201104.606876-1-umang.jain@ideasonboard.com>
 <786df750-221e-82fc-a324-d30261296974@i2se.com>
 <62644cd8-c871-aee0-30b7-2fbab097504c@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <62644cd8-c871-aee0-30b7-2fbab097504c@ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 01:18:30PM +0530, Umang Jain wrote:
> Hi Stefan,
> 
> Thank for the testing.
> 
> On 1/23/23 5:04 AM, Stefan Wahren wrote:
> > Hi Umang,
> >
> > Am 20.01.23 um 21:10 schrieb Umang Jain:
> >> This series just introduces five extra patches for dropping include
> >> directives from Makefiles (suggested by Greg KH) and rebased.
> >>
> >> The main patch (6/6) removes platform device/driver abuse and moves
> >> things to standard device/driver model using a custom_bus. Specific
> >> details are elaborated in the commit message.
> >>
> >> The patch series is based on top of d514392f17fd (tag: next-20230120)
> >> of linux-next.
> >
> > applied this series on top of linux-next and build it with 
> > arm/multi_v7_defconfig plus the following:
> >
> > CONFIG_BCM_VIDEOCORE=y
> > CONFIG_BCM2835_VCHIQ=m
> > CONFIG_VCHIQ_CDEV=y
> > CONFIG_SND_BCM2835=m
> > CONFIG_VIDEO_BCM2835=m
> > CONFIG_BCM2835_VCHIQ_MMAL=m
> >
> > and the devices doesn't register on Raspberry Pi 3 B Plus:
> >
> > [   25.523337] vchiq: module is from the staging directory, the quality is unknown, you have been warned.
> > [   25.541647] bcm2835_vchiq 3f00b840.mailbox: Failed to register bcm2835_audio vchiq device
> > [   25.553692] bcm2835_vchiq 3f00b840.mailbox: Failed to register bcm2835-camera vchiq device
> 
> I was able to reproduce and it seems the issue here is the change 
> mentioned in the cover
> 
> - drop dma_set_mask_and_coherent
> 
> in V6.
> 
> (I usually test patches on RPi 4B with vcsm-cma and bcm2835-isp applied 
> so my branch has the DMA hunk included while I was testing V6)
> 
> Below is the hunk which should resolve the issue.
> 
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.c
> @@ -6,6 +6,7 @@
>    */
> 
>   #include <linux/device/bus.h>
> +#include <linux/dma-mapping.h>
>   #include <linux/slab.h>
>   #include <linux/string.h>
> 
> @@ -72,6 +73,12 @@ int vchiq_device_register(struct device *parent, 
> const char *name)
>          device->dev.type = &vchiq_device_type;
>          device->dev.release = vchiq_device_release;
> 
> +       ret = dma_set_mask_and_coherent(&device->dev, DMA_BIT_MASK(32));
> +       if (ret < 0) {
> +               vchiq_device_release(&device->dev);
> +               return ret;
> +       }
> +
>          ret = device_register(&device->dev);
>          if (ret) {
>                  put_device(&device->dev);
> 
> It seems we need to include the dma_set_mask_and_coherent() even if 
> bcm2835-audio, bcm2835-camera device doesn't do DMA? I need to look into 
> why is that/
> 
>   Laurent, any thoughts on this please?

Nothing that immediately springs to my mind. Can you investigate ?

-- 
Regards,

Laurent Pinchart
