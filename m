Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5720C601470
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 19:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiJQRNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 13:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbiJQRNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 13:13:12 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B021270E78
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 10:13:01 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id s30so17032119eds.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 10:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oEAY6Cotgn/ZxpsoP6Gzuop0YADoHyQTniLvgQ1pizg=;
        b=KzuJXUFW/kdm7LIF+npMNkUkA6hN+cgMuuwzEHsZBApCtxwBczHry+ftQjywmLOXC3
         t32v7mZ8dNCOn+KPvYB6J59N4QZEUVkUO3eaqG66udEq/VYPdAP1HrUTHhwJx54dUBvu
         WMO0KkbcUOdqmVTutGEFYS4c2paOushJnq8uPk7Yk5/rgl8oalVeYjXIbFXWQsXJwCnB
         VJfYud4WkhbZHWrkQ7KRLygIcJXMSf5VpTzf38RoeL37golkSaJMAQ0uHXV4YWPS/iuU
         n7P3sxUmdXqYmE9vVjDxkkSrBqyksO8jQHeq76AkKUMWb2guMjIo67L2p9icimkeZViw
         Jt7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oEAY6Cotgn/ZxpsoP6Gzuop0YADoHyQTniLvgQ1pizg=;
        b=srGsmrjl5g01ptTatVqooHLOx53tIMyXiRI+xcljKqxHjwE7RuSwhlpkBqRUv85R0B
         iceuCWAEbdYUVk+NkSEb922mP3loqZZL26r2UYzmcr4Kl6dVK8zAGibS8U7KFwZUrK0b
         sLQVM6nuiDjRY/1bZ6LJfNB6ZALAE80qrIDvI6WPyoIqv3SVMxiey17vYScss7j5bAFK
         wtaGz8tDt3QcMk2BeX+GQp2T/N21HlQ1HnHZ58hi6/SA9D5mSezJRQIDa9UdNFJoNSGd
         +VrmHEuZBu/VnVD5xwYfBSuZC4/bcn2s+PjSZVLKtC9xfEFoyZPsv5sloBo3qGH9K2SM
         scqA==
X-Gm-Message-State: ACrzQf3gxoAaSmKt094qq5s+6NCETCtqXZHvui4YipOqhMr4oy/o5Fzl
        B8T+5fVymQKj3D+HOL6rdMYRQAkxPLboAS8xpBceZg==
X-Google-Smtp-Source: AMsMyM4QGUc/+zi0I19dg8IHN7efVyCK8QCtt3xvbowENarcgt6RgIUhlT83cgJRdmEYy1qwKYIAjo+ZUQQi+mLPVjM=
X-Received: by 2002:a05:6402:22ef:b0:458:bfe5:31a3 with SMTP id
 dn15-20020a05640222ef00b00458bfe531a3mr11134713edb.6.1666026779615; Mon, 17
 Oct 2022 10:12:59 -0700 (PDT)
MIME-Version: 1.0
References: <20221013-rpi-dpi-improvements-v1-0-8a7a96949cb0@cerno.tech>
 <20221013-rpi-dpi-improvements-v1-4-8a7a96949cb0@cerno.tech> <Y0rt8FIkRniuv0l4@pendragon.ideasonboard.com>
In-Reply-To: <Y0rt8FIkRniuv0l4@pendragon.ideasonboard.com>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Mon, 17 Oct 2022 18:12:44 +0100
Message-ID: <CAPY8ntCVyC7xWtONA4T3x42GYt+t3v+PDbzy3PwE9TfJErUL+A@mail.gmail.com>
Subject: Re: [PATCH 4/7] drm/vc4: dpi: Support RGB565 format
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        Maxime Ripard <mripard@kernel.org>,
        Eric Anholt <eric@anholt.net>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, Rob Herring <robh@kernel.org>,
        Emma Anholt <emma@anholt.net>, dri-devel@lists.freedesktop.org,
        Joerg Quinten <aBUGSworstnightmare@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent

On Sat, 15 Oct 2022 at 18:29, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Maxime and Chris,
>
> Thank you for the patch.
>
> On Thu, Oct 13, 2022 at 11:56:48AM +0200, Maxime Ripard wrote:
> > From: Chris Morgan <macromorgan@hotmail.com>
> >
> > The RGB565 format with padding over 24 bits
> > (MEDIA_BUS_FMT_RGB565_1X24_CPADHI) is supported by the vc4 DPI
> > controller as "mode 3".  This is what the Geekworm MZP280 DPI display
>
> The code below uses DPI_FORMAT_16BIT_565_RGB_2. Is that mode 3, or
> should the commit message refer to mode 2 ?

It's a mis-mash of documentation from the firmware stack.
[1] lists the firmware modes, which start at 1 for the equivalent of
DPI_FORMAT_9BIT_666_RGB, so there padded RGB565 is mode 3.

I'd advocate dropping the reference to which mode it is:
The RGB565 format with padding over 24 bits
(MEDIA_BUS_FMT_RGB565_1X24_CPADHI) is supported by the vc4 DPI controller.

  Dave

[1] https://www.raspberrypi.com/documentation/computers/raspberry-pi.html#parallel-display-interface-dpi

> With this fixed,
>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
> > uses, so let's add support for it in the DPI controller driver.
> >
> > Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> > ---
> >  drivers/gpu/drm/vc4/vc4_dpi.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/vc4/vc4_dpi.c b/drivers/gpu/drm/vc4/vc4_dpi.c
> > index 1f8f44b7b5a5..7da3dd1db50e 100644
> > --- a/drivers/gpu/drm/vc4/vc4_dpi.c
> > +++ b/drivers/gpu/drm/vc4/vc4_dpi.c
> > @@ -182,6 +182,10 @@ static void vc4_dpi_encoder_enable(struct drm_encoder *encoder)
> >                               dpi_c |= VC4_SET_FIELD(DPI_FORMAT_16BIT_565_RGB_3,
> >                                                      DPI_FORMAT);
> >                               break;
> > +                     case MEDIA_BUS_FMT_RGB565_1X24_CPADHI:
> > +                             dpi_c |= VC4_SET_FIELD(DPI_FORMAT_16BIT_565_RGB_2,
> > +                                                    DPI_FORMAT);
> > +                             break;
> >                       default:
> >                               DRM_ERROR("Unknown media bus format %d\n",
> >                                         bus_format);
> >
>
> --
> Regards,
>
> Laurent Pinchart
