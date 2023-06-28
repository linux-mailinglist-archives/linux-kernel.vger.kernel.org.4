Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59DD3741BF4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 00:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbjF1Wv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 18:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbjF1Wvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 18:51:50 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A847310CF;
        Wed, 28 Jun 2023 15:51:48 -0700 (PDT)
Received: from pendragon.ideasonboard.com (aztw-30-b2-v4wan-166917-cust845.vm26.cable.virginm.net [82.37.23.78])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 890F3905;
        Thu, 29 Jun 2023 00:51:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1687992666;
        bh=FbpZiCKBRCQmKJWrA2DWJ1gw6fwfmj/bFIqXsro0RTQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=N7B+zAML9O8fAGsUpcNFyj9nAHNOQcS3s3QvrbBXE6Ph1mY052O3H6oXZ3MpKUWxX
         YCSnjHQ7qdLgpwq3efgl0bBeOgz5C9lqlfmsWYuMI3HAupJfGYeprG/RH/PVW3uiu2
         9dNHFaJfndb033InaGitqTjURDYnWAVPmL1h+iKk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230627201628.207483-5-umang.jain@ideasonboard.com>
References: <20230627201628.207483-1-umang.jain@ideasonboard.com> <20230627201628.207483-5-umang.jain@ideasonboard.com>
Subject: Re: [PATCH v8 4/5] staging: bcm2835-audio: Register bcm2835-audio with vchiq_bus_type
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     stefan.wahren@i2se.com, gregkh@linuxfoundation.org,
        f.fainelli@gmail.com, athierry@redhat.com, error27@gmail.com,
        dave.stevenson@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        Umang Jain <umang.jain@ideasonboard.com>
To:     Umang Jain <umang.jain@ideasonboard.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev
Date:   Wed, 28 Jun 2023 23:51:43 +0100
Message-ID: <168799270390.3298351.3592364441774693940@Monstersaurus>
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Umang Jain (2023-06-27 21:16:27)
> Similar to how bcm2385-camera device is registered, register the
> bcm2835-audio with vchiq_bus_type as well.

bcm2835-audio here and in the dir name, but registered as
bcm2835_audio... Personally I prefer bcm2835-audio ... but this is
already discussed earlier in the series.


>=20
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> ---
>  .../vc04_services/bcm2835-audio/bcm2835.c       | 17 ++++++++---------
>  .../interface/vchiq_arm/vchiq_arm.c             |  6 +-----
>  2 files changed, 9 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c b/driv=
ers/staging/vc04_services/bcm2835-audio/bcm2835.c
> index 00bc898b0189..f81a9a4fbd5d 100644
> --- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
> +++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
> @@ -1,12 +1,12 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /* Copyright 2011 Broadcom Corporation.  All rights reserved. */
> =20
> -#include <linux/platform_device.h>
> -
>  #include <linux/init.h>
>  #include <linux/slab.h>
>  #include <linux/module.h>
> =20
> +#include "../interface/vchiq_arm/vchiq_arm.h"
> +#include "../interface/vchiq_arm/vchiq_device.h"
>  #include "bcm2835.h"
> =20
>  static bool enable_hdmi;
> @@ -268,9 +268,9 @@ static int snd_add_child_devices(struct device *devic=
e, u32 numchans)
>         return 0;
>  }
> =20
> -static int snd_bcm2835_alsa_probe(struct platform_device *pdev)
> +static int snd_bcm2835_alsa_probe(struct vchiq_device *device)
>  {
> -       struct device *dev =3D &pdev->dev;
> +       struct device *dev =3D &device->dev;
>         int err;
> =20
>         if (num_channels <=3D 0 || num_channels > MAX_SUBSTREAMS) {
> @@ -292,20 +292,20 @@ static int snd_bcm2835_alsa_probe(struct platform_d=
evice *pdev)
> =20
>  #ifdef CONFIG_PM
> =20
> -static int snd_bcm2835_alsa_suspend(struct platform_device *pdev,
> +static int snd_bcm2835_alsa_suspend(struct vchiq_device *device,
>                                     pm_message_t state)
>  {
>         return 0;
>  }
> =20
> -static int snd_bcm2835_alsa_resume(struct platform_device *pdev)
> +static int snd_bcm2835_alsa_resume(struct vchiq_device *device)
>  {
>         return 0;
>  }
> =20
>  #endif
> =20
> -static struct platform_driver bcm2835_alsa_driver =3D {
> +static struct vchiq_driver bcm2835_alsa_driver =3D {
>         .probe =3D snd_bcm2835_alsa_probe,
>  #ifdef CONFIG_PM
>         .suspend =3D snd_bcm2835_alsa_suspend,
> @@ -315,9 +315,8 @@ static struct platform_driver bcm2835_alsa_driver =3D=
 {
>                 .name =3D "bcm2835_audio",
>         },
>  };
> -module_platform_driver(bcm2835_alsa_driver);
> +module_vchiq_driver(bcm2835_alsa_driver);
> =20
>  MODULE_AUTHOR("Dom Cobley");
>  MODULE_DESCRIPTION("Alsa driver for BCM2835 chip");
>  MODULE_LICENSE("GPL");
> -MODULE_ALIAS("platform:bcm2835_audio");

And same as with the bcm2385-camera ... I expect this might be required
in some form to support module autoloading?

But with that resolved:

Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>

> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.=
c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> index 79d4d0eeb5fb..75da37fa6372 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> @@ -67,8 +67,6 @@ int vchiq_susp_log_level =3D VCHIQ_LOG_ERROR;
>  DEFINE_SPINLOCK(msg_queue_spinlock);
>  struct vchiq_state g_state;
> =20
> -static struct platform_device *bcm2835_audio;
> -
>  struct vchiq_drvdata {
>         const unsigned int cache_line_size;
>         struct rpi_firmware *fw;
> @@ -139,6 +137,7 @@ struct vchiq_pagelist_info {
>   * the interface.
>   */
>  static const char *const vchiq_devices[] =3D {
> +       "bcm2835_audio",
>         "bcm2835-camera",
>  };
> =20
> @@ -1849,8 +1848,6 @@ static int vchiq_probe(struct platform_device *pdev)
>                 goto error_exit;
>         }
> =20
> -       bcm2835_audio =3D vchiq_register_child(pdev, "bcm2835_audio");
> -
>         for (i =3D 0; i < ARRAY_SIZE(vchiq_devices); i++) {
>                 err =3D vchiq_device_register(&pdev->dev, vchiq_devices[i=
]);
>                 if (err)
> @@ -1868,7 +1865,6 @@ static int vchiq_probe(struct platform_device *pdev)
> =20
>  static void vchiq_remove(struct platform_device *pdev)
>  {
> -       platform_device_unregister(bcm2835_audio);
>         bus_for_each_dev(&vchiq_bus_type, NULL, NULL, vchiq_device_unregi=
ster);
>         vchiq_debugfs_deinit();
>         vchiq_deregister_chrdev();
> --=20
> 2.39.1
>
