Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF1EC63CA01
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 22:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236312AbiK2VF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 16:05:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235854AbiK2VFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 16:05:55 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62CFB55AA2;
        Tue, 29 Nov 2022 13:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1669755952; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YAhTqf0mpOfTgrwMsJ93pGWwF6JJXckeKDiFq8AeMac=;
        b=RQKQFjZx7+KIdZC4o9WymR+WfAhfGjDb9pLmQP3SNNryecamoca3/zQ+FStYCDmUihmpbh
        qcUL6CyDgP7th5Wc2APfsWheempGuKE/aXzbUyuRfS5WOkvT/q9FXWz003wKP3bnOU74OL
        01CziRC4hJEy8lJuE8Uj40xz4V49dVg=
Message-ID: <bc6ece2831188a6041a2956f5efb6a7c3a5b4a18.camel@crapouillou.net>
Subject: Re: [PATCH v2 17/26] drm: rcar-du: Remove #ifdef guards for PM
 related functions
From:   Paul Cercueil <paul@crapouillou.net>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        linux-renesas-soc@vger.kernel.org
Date:   Tue, 29 Nov 2022 21:05:49 +0000
In-Reply-To: <Y4Zg9yg7KP0yCPIL@pendragon.ideasonboard.com>
References: <20221129191733.137897-1-paul@crapouillou.net>
         <20221129191942.138244-1-paul@crapouillou.net>
         <20221129191942.138244-4-paul@crapouillou.net>
         <Y4Zg9yg7KP0yCPIL@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

Le mardi 29 novembre 2022 =C3=A0 21:43 +0200, Laurent Pinchart a =C3=A9crit=
=C2=A0:
> Hi Paul,
>=20
> Thank you for the patch.
>=20
> On Tue, Nov 29, 2022 at 07:19:33PM +0000, Paul Cercueil wrote:
> > Use the DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr() macros to
> > handle
> > the .suspend/.resume callbacks.
> >=20
> > These macros allow the suspend and resume functions to be
> > automatically
> > dropped by the compiler when CONFIG_SUSPEND is disabled, without
> > having
> > to use #ifdef guards.
> >=20
> > This has the advantage of always compiling these functions in,
> > independently of any Kconfig option. Thanks to that, bugs and other
> > regressions are subsequently easier to catch.
> >=20
> > Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> > Reviewed-by: Kieran Bingham
> > <kieran.bingham+renesas@ideasonboard.com>
>=20
> Reviewed-by: Laurent Pinchart
> <laurent.pinchart+renesas@ideasonboard.com>
>=20
> Will you get this whole series merged in one go in drm-misc, or do
> you
> expect me to take this patch in my tree ? I'd prefer the first option
> if
> possible (less work for me :-)).

I actually answered that in my cover letter ;)

However I assumed it had to go through drm-next, if you think it can go
through drm-misc-next, I can apply it myself.

Cheers,
-Paul

>=20
> > ---
> > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Cc: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> > Cc: linux-renesas-soc@vger.kernel.org
> > ---
> > =C2=A0drivers/gpu/drm/rcar-du/rcar_du_drv.c | 9 +++------
> > =C2=A01 file changed, 3 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> > b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> > index d003e8d9e7a2..eeec1e02446f 100644
> > --- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> > +++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> > @@ -599,7 +599,6 @@ static const struct drm_driver rcar_du_driver =3D
> > {
> > =C2=A0 * Power management
> > =C2=A0 */
> > =C2=A0
> > -#ifdef CONFIG_PM_SLEEP
> > =C2=A0static int rcar_du_pm_suspend(struct device *dev)
> > =C2=A0{
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct rcar_du_device *=
rcdu =3D dev_get_drvdata(dev);
> > @@ -613,11 +612,9 @@ static int rcar_du_pm_resume(struct device
> > *dev)
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return drm_mode_config_=
helper_resume(&rcdu->ddev);
> > =C2=A0}
> > -#endif
> > =C2=A0
> > -static const struct dev_pm_ops rcar_du_pm_ops =3D {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0SET_SYSTEM_SLEEP_PM_OPS(rcar=
_du_pm_suspend,
> > rcar_du_pm_resume)
> > -};
> > +static DEFINE_SIMPLE_DEV_PM_OPS(rcar_du_pm_ops,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rcar_du_pm_suspend,
> > rcar_du_pm_resume);
> > =C2=A0
> > =C2=A0/* --------------------------------------------------------------=
-
> > --------------
> > =C2=A0 * Platform driver
> > @@ -712,7 +709,7 @@ static struct platform_driver
> > rcar_du_platform_driver =3D {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.shutdown=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D rcar_du_shutdown,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.driver=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0.name=C2=A0=C2=A0=C2=A0=3D "rcar-du",
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0.pm=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D &rcar_du_pm_ops,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0.pm=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D pm_sleep_ptr(&rca=
r_du_pm_ops),
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0.of_match_table =3D rcar_du_of_table,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0},
> > =C2=A0};
>=20

