Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6C461FFDA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 21:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbiKGUwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 15:52:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233082AbiKGUwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 15:52:36 -0500
X-Greylist: delayed 1496 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Nov 2022 12:52:35 PST
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB64627DCD
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 12:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
        s=20161220; h=Subject:References:Cc:To:Message-ID:From:
        Content-Transfer-Encoding:Content-Type:Date:MIME-Version:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Mhxy5k+UO90ee/DYJ0f+UQwoC8MB8QgKlM5qkTcHKxk=; b=p3yQhIawv9MS9Agnnd3LQ7Yl1P
        lSL2hF1KFN7BOTVmLUWDhS1WMCZ7bAgpNaFpyGJptvzkYdu4S9Rd5jh0msp4lrzNW96XIapTKPUZb
        d1aj8iiOc2DO8UlkMmoZle3jMFIoC+PaNHtNMxPr/CHMZT8RfbE3Dt/cQmfqarFwRwqp8PAVdR+td
        payVxccfqk6M2VlEej0ShaUd0c+yrAwOUkSNXB1dMQwWpVWOPPXU2cdZFWyFLQwtJQQHrccVo3Fn7
        FGu0qFotkXCO6FKpqi30p/Du6uWhEWTBlWqDZCKa3FzYNDTMl0Y9zzz5qiVynRTcGTvH5V0Kc0eui
        GEPI7lwA==;
Received: from [2001:67c:1be8::200] (helo=rainloop.kapsi.fi)
        by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sarha@kapsi.fi>)
        id 1os8it-00Cfbu-Qc; Mon, 07 Nov 2022 22:28:00 +0200
MIME-Version: 1.0
Date:   Mon, 07 Nov 2022 20:27:59 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From:   sarha@kapsi.fi
Message-ID: <0c84acf54ab7db9210cede8ca210438c4c902324@kapsi.fi>
To:     "Paul Cercueil" <paul@crapouillou.net>,
        "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        "Maxime Ripard" <mripard@kernel.org>,
        "Thomas Zimmermann" <tzimmermann@suse.de>,
        "David Airlie" <airlied@gmail.com>,
        "Daniel Vetter" <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        "Jyri Sarha" <jyri.sarha@iki.fi>,
        "Tomi Valkeinen" <tomba@kernel.org>
References: undefined <20221107175106.360578-1-paul@crapouillou.net>
 <20221107175256.360839-1-paul@crapouillou.net>
X-SA-Exim-Connect-IP: 2001:67c:1be8::200
X-SA-Exim-Mail-From: sarha@kapsi.fi
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH 21/26] drm: tilcdc: Remove #ifdef guards for PM
 related functions
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on mail.kapsi.fi)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

November 7, 2022 at 7:52 PM, "Paul Cercueil" <paul@crapouillou.net mailto=
:paul@crapouillou.net?to=3D%22Paul%20Cercueil%22%20%3Cpaul%40crapouillou.=
net%3E > wrote:

>=20
>=20Use the DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr() macros to handl=
e
> the .suspend/.resume callbacks.
>=20
>=20These macros allow the suspend and resume functions to be automatical=
ly
> dropped by the compiler when CONFIG_SUSPEND is disabled, without having
> to use #ifdef guards.
>=20
>=20This has the advantage of always compiling these functions in,
> independently of any Kconfig option. Thanks to that, bugs and other
> regressions are subsequently easier to catch.
>=20
>=20Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Acked-by: Jyri Sarha <jyri.sarha=C4=B1@iki.fi>

> ---
> Cc: Jyri Sarha <jyri.sarha@iki.fi>
> Cc: Tomi Valkeinen <tomba@kernel.org>
> ---
> drivers/gpu/drm/tilcdc/tilcdc_drv.c | 9 +++------
> 1 file changed, 3 insertions(+), 6 deletions(-)
>=20
>=20diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/ti=
lcdc/tilcdc_drv.c
> index f72755b8ea14..cd5bdc2f803a 100644
> --- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
> +++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
> @@ -496,7 +496,6 @@ static const struct drm_driver tilcdc_driver =3D {
> * Power management:
> */
>=20
>=20-#ifdef CONFIG_PM_SLEEP
> static int tilcdc_pm_suspend(struct device *dev)
> {
>  struct drm_device *ddev =3D dev_get_drvdata(dev);
> @@ -518,11 +517,9 @@ static int tilcdc_pm_resume(struct device *dev)
>  pinctrl_pm_select_default_state(dev);
>  return drm_mode_config_helper_resume(ddev);
> }
> -#endif
>=20
>=20-static const struct dev_pm_ops tilcdc_pm_ops =3D {
> - SET_SYSTEM_SLEEP_PM_OPS(tilcdc_pm_suspend, tilcdc_pm_resume)
> -};
> +static DEFINE_SIMPLE_DEV_PM_OPS(tilcdc_pm_ops,
> + tilcdc_pm_suspend, tilcdc_pm_resume);
>=20
>=20/*
> * Platform driver:
> @@ -597,7 +594,7 @@ static struct platform_driver tilcdc_platform_drive=
r =3D {
>  .remove =3D tilcdc_pdev_remove,
>  .driver =3D {
>  .name =3D "tilcdc",
> - .pm =3D &tilcdc_pm_ops,
> + .pm =3D pm_sleep_ptr(&tilcdc_pm_ops),
>  .of_match_table =3D tilcdc_of_match,
>  },
> };
> --=20
>=202.35.1
>
