Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC2C62F2FC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 11:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233055AbiKRKuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 05:50:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241796AbiKRKua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 05:50:30 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2443097AA6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 02:50:27 -0800 (PST)
Received: from pendragon.ideasonboard.com (cpc89244-aztw30-2-0-cust3082.18-1.cable.virginm.net [86.31.172.11])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 954A349C;
        Fri, 18 Nov 2022 11:50:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1668768625;
        bh=1CsWy/GmyIFnYxae/LDO/zoah3Qc8VosycoLHVtCM/c=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Sk7X679FDVTwWZyGdinLcsA3j0tQFr6iwEo9vF/+oBe0+HSTF0hYCFQ6Nl4kyqdZX
         JXteJnucFzeBrHnB0Na+BWVdhKWB4zU1uqNJr9jwJPmpXWBR3VCTG2mcgdoJ0vcimf
         7NgfxkJJcczL8/aZnu0HBeGmBzT1OLI3SRobt5y4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221118084244.199909-4-umang.jain@ideasonboard.com>
References: <20221118084244.199909-1-umang.jain@ideasonboard.com> <20221118084244.199909-4-umang.jain@ideasonboard.com>
Subject: Re: [PATCH v2 3/3] vc04_services: bcm2835-camera: Use bool values for mmal_fmt.remove_padding
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     Umang Jain <umang.jain@ideasonboard.com>
To:     Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Dan Carpenter <error27@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        Umang Jain <umang.jain@ideasonboard.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org, linux-staging@lists.linux.dev
Date:   Fri, 18 Nov 2022 10:50:23 +0000
Message-ID: <166876862357.50677.2208743534141685703@Monstersaurus>
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Umang Jain (2022-11-18 08:42:44)
> mmal_fmt.remove_padding is defined as a boolean type hence, use boolean
> values for it instead of 0/1 integers. This enhances code readability.

This could be (optionally) expanded:

"""
The field 'remove_padding' in 'struct mmal_fmt' is defined as a boolean
type.

The initialisation of the formats[] array stores integer 0/1 values into
this field rather than a more readable bool type.

Convert the usages to boolean true/false, and fix up the local storage
type in mmal_setup_components() to enhance code readability.
"""

Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>


> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> ---
>  .../bcm2835-camera/bcm2835-camera.c           | 30 +++++++++----------
>  1 file changed, 15 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.=
c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
> index fd456d1f7061..797ebe2a973a 100644
> --- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
> +++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
> @@ -87,21 +87,21 @@ static struct mmal_fmt formats[] =3D {
>                 .depth =3D 12,
>                 .mmal_component =3D COMP_CAMERA,
>                 .ybbp =3D 1,
> -               .remove_padding =3D 1,
> +               .remove_padding =3D true,
>         }, {
>                 .fourcc =3D V4L2_PIX_FMT_YUYV,
>                 .mmal =3D MMAL_ENCODING_YUYV,
>                 .depth =3D 16,
>                 .mmal_component =3D COMP_CAMERA,
>                 .ybbp =3D 2,
> -               .remove_padding =3D 0,
> +               .remove_padding =3D false,
>         }, {
>                 .fourcc =3D V4L2_PIX_FMT_RGB24,
>                 .mmal =3D MMAL_ENCODING_RGB24,
>                 .depth =3D 24,
>                 .mmal_component =3D COMP_CAMERA,
>                 .ybbp =3D 3,
> -               .remove_padding =3D 0,
> +               .remove_padding =3D false,
>         }, {
>                 .fourcc =3D V4L2_PIX_FMT_JPEG,
>                 .flags =3D V4L2_FMT_FLAG_COMPRESSED,
> @@ -109,7 +109,7 @@ static struct mmal_fmt formats[] =3D {
>                 .depth =3D 8,
>                 .mmal_component =3D COMP_IMAGE_ENCODE,
>                 .ybbp =3D 0,
> -               .remove_padding =3D 0,
> +               .remove_padding =3D false,
>         }, {
>                 .fourcc =3D V4L2_PIX_FMT_H264,
>                 .flags =3D V4L2_FMT_FLAG_COMPRESSED,
> @@ -117,7 +117,7 @@ static struct mmal_fmt formats[] =3D {
>                 .depth =3D 8,
>                 .mmal_component =3D COMP_VIDEO_ENCODE,
>                 .ybbp =3D 0,
> -               .remove_padding =3D 0,
> +               .remove_padding =3D false,
>         }, {
>                 .fourcc =3D V4L2_PIX_FMT_MJPEG,
>                 .flags =3D V4L2_FMT_FLAG_COMPRESSED,
> @@ -125,63 +125,63 @@ static struct mmal_fmt formats[] =3D {
>                 .depth =3D 8,
>                 .mmal_component =3D COMP_VIDEO_ENCODE,
>                 .ybbp =3D 0,
> -               .remove_padding =3D 0,
> +               .remove_padding =3D false,
>         }, {
>                 .fourcc =3D V4L2_PIX_FMT_YVYU,
>                 .mmal =3D MMAL_ENCODING_YVYU,
>                 .depth =3D 16,
>                 .mmal_component =3D COMP_CAMERA,
>                 .ybbp =3D 2,
> -               .remove_padding =3D 0,
> +               .remove_padding =3D false,
>         }, {
>                 .fourcc =3D V4L2_PIX_FMT_VYUY,
>                 .mmal =3D MMAL_ENCODING_VYUY,
>                 .depth =3D 16,
>                 .mmal_component =3D COMP_CAMERA,
>                 .ybbp =3D 2,
> -               .remove_padding =3D 0,
> +               .remove_padding =3D false,
>         }, {
>                 .fourcc =3D V4L2_PIX_FMT_UYVY,
>                 .mmal =3D MMAL_ENCODING_UYVY,
>                 .depth =3D 16,
>                 .mmal_component =3D COMP_CAMERA,
>                 .ybbp =3D 2,
> -               .remove_padding =3D 0,
> +               .remove_padding =3D false,
>         }, {
>                 .fourcc =3D V4L2_PIX_FMT_NV12,
>                 .mmal =3D MMAL_ENCODING_NV12,
>                 .depth =3D 12,
>                 .mmal_component =3D COMP_CAMERA,
>                 .ybbp =3D 1,
> -               .remove_padding =3D 1,
> +               .remove_padding =3D true,
>         }, {
>                 .fourcc =3D V4L2_PIX_FMT_BGR24,
>                 .mmal =3D MMAL_ENCODING_BGR24,
>                 .depth =3D 24,
>                 .mmal_component =3D COMP_CAMERA,
>                 .ybbp =3D 3,
> -               .remove_padding =3D 0,
> +               .remove_padding =3D false,
>         }, {
>                 .fourcc =3D V4L2_PIX_FMT_YVU420,
>                 .mmal =3D MMAL_ENCODING_YV12,
>                 .depth =3D 12,
>                 .mmal_component =3D COMP_CAMERA,
>                 .ybbp =3D 1,
> -               .remove_padding =3D 1,
> +               .remove_padding =3D true,
>         }, {
>                 .fourcc =3D V4L2_PIX_FMT_NV21,
>                 .mmal =3D MMAL_ENCODING_NV21,
>                 .depth =3D 12,
>                 .mmal_component =3D COMP_CAMERA,
>                 .ybbp =3D 1,
> -               .remove_padding =3D 1,
> +               .remove_padding =3D true,
>         }, {
>                 .fourcc =3D V4L2_PIX_FMT_BGR32,
>                 .mmal =3D MMAL_ENCODING_BGRA,
>                 .depth =3D 32,
>                 .mmal_component =3D COMP_CAMERA,
>                 .ybbp =3D 4,
> -               .remove_padding =3D 0,
> +               .remove_padding =3D false,
>         },
>  };
> =20
> @@ -1147,7 +1147,7 @@ static int mmal_setup_components(struct bcm2835_mma=
l_dev *dev,
>         struct vchiq_mmal_port *port =3D NULL, *camera_port =3D NULL;
>         struct vchiq_mmal_component *encode_component =3D NULL;
>         struct mmal_fmt *mfmt =3D get_format(f);
> -       u32 remove_padding;
> +       bool remove_padding;
> =20
>         if (!mfmt)
>                 return -EINVAL;
> --=20
> 2.38.1
>
