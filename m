Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7E066A84D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 02:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbjANBas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 20:30:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjANBaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 20:30:46 -0500
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9025371C
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 17:30:45 -0800 (PST)
Date:   Sat, 14 Jan 2023 01:30:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connolly.tech;
        s=protonmail; t=1673659842; x=1673919042;
        bh=AdZAhK55J//xC6CGMSCMaoU1ntstNCM0ncZKk8nZWlc=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=Z4VjL+egla2BJR+hp4BC/RWQ5LuWYsGA67ggqO1uEspGNjbvtK/CODPdqeNtIVbQu
         TbJVYk29SzPjUqxt+YlewOhw/xq8a1kzd+swnIdjKR3vbU/0JI/xmKy50zFHlGyx4P
         spgWJ2hZTA/y1c1QepxojQZXudhOlAN49SNhdUWU=
To:     Richard Acayan <mailingradian@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Vinay Simha BN <simhavcs@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
From:   Caleb Connolly <caleb@connolly.tech>
Cc:     Daniel Mentz <danielmentz@google.com>
Subject: Re: [RFC PATCH v2 2/2] drm/panel: sofef00: Use 16-bit panel brightness
Message-ID: <160f5f63-6e80-a98c-c2c4-5e5e03e574da@connolly.tech>
In-Reply-To: <20230114010006.50471-3-mailingradian@gmail.com>
References: <20230114010006.50471-1-mailingradian@gmail.com> <20230114010006.50471-3-mailingradian@gmail.com>
Feedback-ID: 10753939:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/01/2023 01:00, Richard Acayan wrote:
> These panels communicate brightness in big endian. This is not a quirk
> of the panels themselves, but rather, a part of the MIPI standard. Use
> the new mipi_dsi_dcs_set_display_brightness_wide() function that
> properly handles 16-bit brightness instead of doing special processing
> of the brightness values.
>
> Signed-off-by: Richard Acayan <mailingradian@gmail.com>

Awesome! Thanks for this series, glad to know this isn't a weird panel
quirk aha.

This works fine on the OnePlus 6 (the user of this panel), so for both
patches:

Tested-by: Caleb Connolly <caleb@connolly.tech>
> ---
>  drivers/gpu/drm/panel/panel-samsung-sofef00.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/panel/panel-samsung-sofef00.c b/drivers/gpu/=
drm/panel/panel-samsung-sofef00.c
> index 1a0d24595faa..014fe350bc59 100644
> --- a/drivers/gpu/drm/panel/panel-samsung-sofef00.c
> +++ b/drivers/gpu/drm/panel/panel-samsung-sofef00.c
> @@ -10,7 +10,6 @@
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/regulator/consumer.h>
> -#include <linux/swab.h>
>  #include <linux/backlight.h>
>
>  #include <video/mipi_display.h>
> @@ -221,13 +220,9 @@ static int sofef00_panel_bl_update_status(struct bac=
klight_device *bl)
>  {
>  =09struct mipi_dsi_device *dsi =3D bl_get_data(bl);
>  =09int err;
> -=09u16 brightness;
> +=09u16 brightness =3D (u16)backlight_get_brightness(bl);
>
> -=09brightness =3D (u16)backlight_get_brightness(bl);
> -=09// This panel needs the high and low bytes swapped for the brightness=
 value
> -=09brightness =3D __swab16(brightness);
> -
> -=09err =3D mipi_dsi_dcs_set_display_brightness(dsi, brightness);
> +=09err =3D mipi_dsi_dcs_set_display_brightness_large(dsi, brightness);
>  =09if (err < 0)
>  =09=09return err;
>
> --
> 2.39.0
>

--
Kind Regards,
Caleb

