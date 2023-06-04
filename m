Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B0072177F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 15:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjFDNpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 09:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjFDNpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 09:45:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F079AB
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 06:45:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1039611C3
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 13:45:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D19C433EF
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 13:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685886344;
        bh=zstFA3ZC/r8M4sgsYcjqLFs6XLer0/06lWPv/lS6N7k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iXo58lvOWCpp1Z1xiaduR+itTQyh6UPQ/ZmbaiGOIbO7PsXchEv3A1uDhVjBQIITr
         5TQ0NnaKiPVAaqJgY755uty0bwzt9LwsElwijB6divWi31SZPKbt7rv1m5SU6hdmgk
         thUvM6bTzPOX7lFedNjAQvId9bN83mgTbDy1GwTqUgdm7psk6cX5hTNNKUu44oLPes
         wGY7JbA16FqdvCsrMuvAdpw3+bGyW/3O5oKrlsP++rSCdtH7ZHwUHT4D2L2WAsXPVI
         KTXOJebMStlYfbj62+m26wjeiQZwAj1Uc8A4ghwJLfNtMAX4+zfinkFsQPpBDZhtdf
         78h9IxLBurQpA==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-19f8af9aa34so4062543fac.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jun 2023 06:45:44 -0700 (PDT)
X-Gm-Message-State: AC+VfDzeuCox++BiMIIoycUTTBhOmBESIXU0Ji3ftg+0pElQIwbE4bHI
        m8JPoFPKu9YkVvvyRejd3J9DIT4/0PlQWS7H9P4=
X-Google-Smtp-Source: ACHHUZ6IaOZz4xna38CDXCo+gOZkwlV4sbFc+vs8c0lY+SoyPY2xM+o9uZaGKCSg/HFRonfeoKT9nErKC/GDsIdhjOo=
X-Received: by 2002:a05:6870:72c2:b0:19f:45a1:b5a2 with SMTP id
 o2-20020a05687072c200b0019f45a1b5a2mr6442978oak.49.1685886343512; Sun, 04 Jun
 2023 06:45:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230604075713.1027261-1-masahiroy@kernel.org> <20230604132602.GB7754@pendragon.ideasonboard.com>
In-Reply-To: <20230604132602.GB7754@pendragon.ideasonboard.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 4 Jun 2023 22:45:07 +0900
X-Gmail-Original-Message-ID: <CAK7LNATv_t+4pt6-RJxX3DyNgyXN=nEoVHQ8zMRtgrtB_4VJ5Q@mail.gmail.com>
Message-ID: <CAK7LNATv_t+4pt6-RJxX3DyNgyXN=nEoVHQ8zMRtgrtB_4VJ5Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/bridge: imx: fix mixed module-builtin object
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Liu Ying <victor.liu@nxp.com>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Nick Terrell <terrelln@fb.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 4, 2023 at 10:26=E2=80=AFPM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hello Yamada-san,
>
> Thank you for the patch.
>
> On Sun, Jun 04, 2023 at 04:57:12PM +0900, Masahiro Yamada wrote:
> > With CONFIG_DRM_IMX8QM_LDB=3Dm and CONFIG_DRM_IMX8QXP_LDB=3Dy (or vice
> > versa), imx-ldb-helper.o is linked to a module and also to vmlinux
> > even though the expected CFLAGS are different between builtins and
> > modules.
> >
> > This is the same situation as fixed by commit 637a642f5ca5 ("zstd:
> > Fixing mixed module-builtin objects").
> >
> > Split imx-ldb-helper.c into a separate module.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> > Changes in v2:
> >  - Add a separate module instead of making the functions static inline
> >
> >  drivers/gpu/drm/bridge/imx/Kconfig          |  5 +++++
> >  drivers/gpu/drm/bridge/imx/Makefile         |  5 +++--
> >  drivers/gpu/drm/bridge/imx/imx-ldb-helper.c | 20 ++++++++++++++++++++
> >  3 files changed, 28 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/imx/Kconfig b/drivers/gpu/drm/bridg=
e/imx/Kconfig
> > index 608f47f41bcd..9fae28db6aa7 100644
> > --- a/drivers/gpu/drm/bridge/imx/Kconfig
> > +++ b/drivers/gpu/drm/bridge/imx/Kconfig
> > @@ -1,9 +1,13 @@
> >  if ARCH_MXC || COMPILE_TEST
> >
> > +config DRM_IMX_LDB_HELPER
> > +     tristate
> > +
> >  config DRM_IMX8QM_LDB
> >       tristate "Freescale i.MX8QM LVDS display bridge"
> >       depends on OF
> >       depends on COMMON_CLK
> > +     select DRM_IMX_LDB_HELPER
> >       select DRM_KMS_HELPER
> >       help
> >         Choose this to enable the internal LVDS Display Bridge(LDB) fou=
nd in
> > @@ -13,6 +17,7 @@ config DRM_IMX8QXP_LDB
> >       tristate "Freescale i.MX8QXP LVDS display bridge"
> >       depends on OF
> >       depends on COMMON_CLK
> > +     select DRM_IMX_LDB_HELPER
> >       select DRM_KMS_HELPER
> >       help
> >         Choose this to enable the internal LVDS Display Bridge(LDB) fou=
nd in
> > diff --git a/drivers/gpu/drm/bridge/imx/Makefile b/drivers/gpu/drm/brid=
ge/imx/Makefile
> > index aa90ec8d5433..5fc821278693 100644
> > --- a/drivers/gpu/drm/bridge/imx/Makefile
> > +++ b/drivers/gpu/drm/bridge/imx/Makefile
> > @@ -1,7 +1,8 @@
> > -imx8qm-ldb-objs :=3D imx-ldb-helper.o imx8qm-ldb-drv.o
> > +obj-$(CONFIG_DRM_IMX_LDB_HELPER) +=3D imx-ldb-helper.o
> > +imx8qm-ldb-objs :=3D imx8qm-ldb-drv.o
> >  obj-$(CONFIG_DRM_IMX8QM_LDB) +=3D imx8qm-ldb.o
> >
> > -imx8qxp-ldb-objs :=3D imx-ldb-helper.o imx8qxp-ldb-drv.o
> > +imx8qxp-ldb-objs :=3D imx8qxp-ldb-drv.o
> >  obj-$(CONFIG_DRM_IMX8QXP_LDB) +=3D imx8qxp-ldb.o
> >
> >  obj-$(CONFIG_DRM_IMX8QXP_PIXEL_COMBINER) +=3D imx8qxp-pixel-combiner.o
> > diff --git a/drivers/gpu/drm/bridge/imx/imx-ldb-helper.c b/drivers/gpu/=
drm/bridge/imx/imx-ldb-helper.c
> > index 7338b84bc83d..7382cb1fbfd7 100644
> > --- a/drivers/gpu/drm/bridge/imx/imx-ldb-helper.c
> > +++ b/drivers/gpu/drm/bridge/imx/imx-ldb-helper.c
> > @@ -4,8 +4,10 @@
> >   * Copyright 2019,2020,2022 NXP
> >   */
> >
> > +#include <linux/export.h>
> >  #include <linux/media-bus-format.h>
> >  #include <linux/mfd/syscon.h>
> > +#include <linux/module.h>
> >  #include <linux/of.h>
> >  #include <linux/regmap.h>
> >
> > @@ -15,16 +17,20 @@
> >
> >  #include "imx-ldb-helper.h"
> >
> > +#define DRIVER_NAME          "imx-ldb-helper"
> > +
> >  bool ldb_channel_is_single_link(struct ldb_channel *ldb_ch)
> >  {
> >       return ldb_ch->link_type =3D=3D LDB_CH_SINGLE_LINK;
> >  }
> > +EXPORT_SYMBOL_GPL(ldb_channel_is_single_link);
> >
> >  bool ldb_channel_is_split_link(struct ldb_channel *ldb_ch)
> >  {
> >       return ldb_ch->link_type =3D=3D LDB_CH_DUAL_LINK_EVEN_ODD_PIXELS =
||
> >              ldb_ch->link_type =3D=3D LDB_CH_DUAL_LINK_ODD_EVEN_PIXELS;
> >  }
> > +EXPORT_SYMBOL_GPL(ldb_channel_is_split_link);
> >
> >  int ldb_bridge_atomic_check_helper(struct drm_bridge *bridge,
> >                                  struct drm_bridge_state *bridge_state,
> > @@ -38,6 +44,7 @@ int ldb_bridge_atomic_check_helper(struct drm_bridge =
*bridge,
> >
> >       return 0;
> >  }
> > +EXPORT_SYMBOL_GPL(ldb_bridge_atomic_check_helper);
> >
> >  void ldb_bridge_mode_set_helper(struct drm_bridge *bridge,
> >                               const struct drm_display_mode *mode,
> > @@ -69,6 +76,7 @@ void ldb_bridge_mode_set_helper(struct drm_bridge *br=
idge,
> >               break;
> >       }
> >  }
> > +EXPORT_SYMBOL_GPL(ldb_bridge_mode_set_helper);
> >
> >  void ldb_bridge_enable_helper(struct drm_bridge *bridge)
> >  {
> > @@ -81,6 +89,7 @@ void ldb_bridge_enable_helper(struct drm_bridge *brid=
ge)
> >        */
> >       regmap_write(ldb->regmap, ldb->ctrl_reg, ldb->ldb_ctrl);
> >  }
> > +EXPORT_SYMBOL_GPL(ldb_bridge_enable_helper);
> >
> >  void ldb_bridge_disable_helper(struct drm_bridge *bridge)
> >  {
> > @@ -95,6 +104,7 @@ void ldb_bridge_disable_helper(struct drm_bridge *br=
idge)
> >
> >       regmap_write(ldb->regmap, ldb->ctrl_reg, ldb->ldb_ctrl);
> >  }
> > +EXPORT_SYMBOL_GPL(ldb_bridge_disable_helper);
> >
> >  int ldb_bridge_attach_helper(struct drm_bridge *bridge,
> >                            enum drm_bridge_attach_flags flags)
> > @@ -117,6 +127,7 @@ int ldb_bridge_attach_helper(struct drm_bridge *bri=
dge,
> >                               ldb_ch->next_bridge, bridge,
> >                               DRM_BRIDGE_ATTACH_NO_CONNECTOR);
> >  }
> > +EXPORT_SYMBOL_GPL(ldb_bridge_attach_helper);
> >
> >  int ldb_init_helper(struct ldb *ldb)
> >  {
> > @@ -157,6 +168,7 @@ int ldb_init_helper(struct ldb *ldb)
> >
> >       return 0;
> >  }
> > +EXPORT_SYMBOL_GPL(ldb_init_helper);
> >
> >  int ldb_find_next_bridge_helper(struct ldb *ldb)
> >  {
> > @@ -184,6 +196,7 @@ int ldb_find_next_bridge_helper(struct ldb *ldb)
> >
> >       return 0;
> >  }
> > +EXPORT_SYMBOL_GPL(ldb_find_next_bridge_helper);
> >
> >  void ldb_add_bridge_helper(struct ldb *ldb,
> >                          const struct drm_bridge_funcs *bridge_funcs)
> > @@ -204,6 +217,7 @@ void ldb_add_bridge_helper(struct ldb *ldb,
> >               drm_bridge_add(&ldb_ch->bridge);
> >       }
> >  }
> > +EXPORT_SYMBOL_GPL(ldb_add_bridge_helper);
> >
> >  void ldb_remove_bridge_helper(struct ldb *ldb)
> >  {
> > @@ -219,3 +233,9 @@ void ldb_remove_bridge_helper(struct ldb *ldb)
> >               drm_bridge_remove(&ldb_ch->bridge);
> >       }
> >  }
> > +EXPORT_SYMBOL_GPL(ldb_remove_bridge_helper);
> > +
> > +MODULE_DESCRIPTION("i.MX8 LVDS Display Bridge(LDB)/Pixel Mapper bridge=
 helper");
> > +MODULE_AUTHOR("Liu Ying <victor.liu@nxp.com>");
> > +MODULE_LICENSE("GPL");
> > +MODULE_ALIAS("platform:" DRIVER_NAME);
>
> Is the alias needed ? With that fixed (if needed),


I just tried to be consistent because all the modules
in drivers/gpu/drm/bridge/imx/ have this boilerplate.

I do not know why MODULE_ALIAS() is needed, though.




>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
> --
> Regards,
>
> Laurent Pinchart



--=20
Best Regards
Masahiro Yamada
