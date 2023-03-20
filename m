Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5706C0C14
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 09:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjCTIVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 04:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjCTIVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 04:21:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57988B456
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 01:21:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F3DBAB80D7E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 08:21:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 729FAC433D2;
        Mon, 20 Mar 2023 08:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679300507;
        bh=jVn18uqDt5rfFoXE/I7E0XizLiknyMconn6QPnHtdLQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TSwW0AmSxuRFtl0g9F718VJ2W3q6LSKylGHTNj9byCTSaZa6mlm/YCrmaJK5BS5j1
         KGSEu3WXqYU/juOPwBpq7C1HipAEgLNnNrIoJnWvOolIeHrqU2KVXLXzrmoRcZEXCB
         ic9NSivyMigokjCbK3nFimEnng8NY6cvs61609sPkBvN6Fg/LW5Yh1dFrRFTTWysWm
         xTgXxDQZ/U2syZd8qk8wHLvc/yO6NTVHqYBl2RS31lX50Ti9WugSaWFtLH7sBjQZsY
         eqdFR7wvA3UbmjyV1XPTDGu3b5l2JNMcGNOETU3it5RSiMkyt0WLv0KpcPIk2ueuzf
         JkzKs4IFnOr8Q==
Date:   Mon, 20 Mar 2023 08:21:41 +0000
From:   Lee Jones <lee@kernel.org>
To:     Liu Ying <victor.liu@nxp.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 37/37] drm/bridge/imx/Kconfig: Prevent imx-ldb-helper
 from appearing in 2 separate modules
Message-ID: <20230320082141.GJ9667@google.com>
References: <20230317081718.2650744-1-lee@kernel.org>
 <20230317081718.2650744-38-lee@kernel.org>
 <fc8b6ec1f05c1514b6ed5535e16c9c2d21efea86.camel@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fc8b6ec1f05c1514b6ed5535e16c9c2d21efea86.camel@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Mar 2023, Liu Ying wrote:

> Hi Lee,
>
> On Fri, 2023-03-17 at 08:17 +0000, Lee Jones wrote:
> > Fixes the following W=1 kernel build warning(s):
> >
> >  scripts/Makefile.build:252: drivers/gpu/drm/bridge/imx/Makefile: imx-ldb-helper.o is added to multiple modules: imx8qm-ldb imx8qxp-ldb
> >
> > Cc: Liu Ying <victor.liu@nxp.com>
> > Cc: Andrzej Hajda <andrzej.hajda@intel.com>
> > Cc: Neil Armstrong <neil.armstrong@linaro.org>
> > Cc: Robert Foss <rfoss@kernel.org>
> > Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> > Cc: Jonas Karlman <jonas@kwiboo.se>
> > Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
> > Cc: David Airlie <airlied@gmail.com>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> > Cc: Fabio Estevam <festevam@gmail.com>
> > Cc: NXP Linux Team <linux-imx@nxp.com>
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Signed-off-by: Lee Jones <lee@kernel.org>
>
> Thank you for the patch.
>
> > ---
> >  drivers/gpu/drm/bridge/imx/Kconfig          |  7 +++++++
> >  drivers/gpu/drm/bridge/imx/Makefile         |  7 +++++--
> >  drivers/gpu/drm/bridge/imx/imx-ldb-helper.c | 13 +++++++++++++
> >  3 files changed, 25 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/imx/Kconfig b/drivers/gpu/drm/bridge/imx/Kconfig
> > index 608f47f41bcd1..97018dcd078d0 100644
> > --- a/drivers/gpu/drm/bridge/imx/Kconfig
> > +++ b/drivers/gpu/drm/bridge/imx/Kconfig
> > @@ -1,10 +1,16 @@
> >  if ARCH_MXC || COMPILE_TEST
> >
> > +config DRM_IMX8_LIB
>
> I would limit this to i.MX LVDS Display Bridge(LDB) library, so I
> suggest to use DRM_IMX_LDB_LIB.
>
> > +	tristate
> > +	help
> > +	  Common helper functions used by some of the drivers below.
>
> Considering to use DRM_IMX_LDB_LIB, help message can be a bit more
> specific to LDB drivers, like:
>
> Common helper functions used by i.MX LVDS display bridge drivers below.

Thanks for the help.  Leave it with me.

--
Lee Jones [李琼斯]
