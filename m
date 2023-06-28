Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6513C740FFA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 13:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjF1LVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 07:21:42 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:48884 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbjF1LVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 07:21:34 -0400
Received: from pendragon.ideasonboard.com (aztw-30-b2-v4wan-166917-cust845.vm26.cable.virginm.net [82.37.23.78])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5E620814;
        Wed, 28 Jun 2023 13:20:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1687951252;
        bh=abc8pk8RuvvZJla85WjtaH3AoscYHKj27LLRxuhLM+E=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=HKOQlmhowxdU42zNj6H3E6T3eOqEEhzXTKmfc8bXe9RwDb/A99rCqBjBX9uWt9xn3
         tMnRI7u9H+OBkHZg+RwAQ1br5UzExCOZYoZldGLs3T7pjnX1iruPEU4E46qps37Uf6
         ehh4URLI2YyUURVZ+mFfgZnBdKjVjohp4j3TwaEw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230627201628.207483-3-umang.jain@ideasonboard.com>
References: <20230627201628.207483-1-umang.jain@ideasonboard.com> <20230627201628.207483-3-umang.jain@ideasonboard.com>
Subject: Re: [PATCH v8 2/5] staging: vc04_services: vchiq_arm: Register vchiq_bus_type
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     stefan.wahren@i2se.com, gregkh@linuxfoundation.org,
        f.fainelli@gmail.com, athierry@redhat.com, error27@gmail.com,
        dave.stevenson@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        Umang Jain <umang.jain@ideasonboard.com>
To:     Umang Jain <umang.jain@ideasonboard.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev
Date:   Wed, 28 Jun 2023 12:21:29 +0100
Message-ID: <168795128917.2878450.12280941046284606847@Monstersaurus>
User-Agent: alot/0.10
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Umang Jain (2023-06-27 21:16:25)
> Register the vchiq_bus_type bus with the vchiq interface.
> The bcm2835-camera nad bcm2835_audio will be registered to this bus type

s/nad/and/

Is it possible to rename bcm2835_audio to bcm2835-audio for consistency?
Or is that baked into existing usage/abi already?

If it can be changed, I think it's probably something to do in an
independent patch at the end of the series anyway.

I suspect this patch could be merged with 1/5 but I think it's ok
separate too.


Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>

> going ahead.
>=20
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> ---
>  .../vc04_services/interface/vchiq_arm/vchiq_arm.c        | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.=
c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> index aa2313f3bcab..e8d40f891449 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> @@ -12,6 +12,7 @@
>  #include <linux/cdev.h>
>  #include <linux/fs.h>
>  #include <linux/device.h>
> +#include <linux/device/bus.h>
>  #include <linux/mm.h>
>  #include <linux/highmem.h>
>  #include <linux/pagemap.h>
> @@ -34,6 +35,7 @@
>  #include "vchiq_ioctl.h"
>  #include "vchiq_arm.h"
>  #include "vchiq_debugfs.h"
> +#include "vchiq_device.h"
>  #include "vchiq_connected.h"
>  #include "vchiq_pagelist.h"
> =20
> @@ -1870,6 +1872,12 @@ static int __init vchiq_driver_init(void)
>  {
>         int ret;
> =20
> +       ret =3D bus_register(&vchiq_bus_type);
> +       if (ret) {
> +               pr_err("Failed to register %s\n", vchiq_bus_type.name);
> +               return ret;
> +       }
> +
>         ret =3D platform_driver_register(&vchiq_driver);
>         if (ret)
>                 pr_err("Failed to register vchiq driver\n");
> @@ -1880,6 +1888,7 @@ module_init(vchiq_driver_init);
> =20
>  static void __exit vchiq_driver_exit(void)
>  {
> +       bus_unregister(&vchiq_bus_type);
>         platform_driver_unregister(&vchiq_driver);
>  }
>  module_exit(vchiq_driver_exit);
> --=20
> 2.39.1
>
