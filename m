Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE6673BE9C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 20:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjFWSw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 14:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbjFWSw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 14:52:57 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB271BE4;
        Fri, 23 Jun 2023 11:52:55 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id DBB40D5F;
        Fri, 23 Jun 2023 20:52:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1687546337;
        bh=T4l4qJ2IScPcpOSjZBjIdg+1mEYC03Hv+YAAeixilGo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WfSyio0w+6uDBtuyiwBSOlwJOGfur+p9+3bPKswIlBLHV8Kid/wr8RPki31Cg2wcj
         YuA2pFbSgdhmgDxfVyuuWTeH2YITXUdlevV95beUgwdVde+jzZ1ENAXmHsSVmiYxJR
         9Gn0sUO9TIYC9KXzrGUh/5sr2lTcFqLDFHFV2Jj4=
Date:   Fri, 23 Jun 2023 21:52:52 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Sam Ravnborg <sam@ravnborg.org>, devicetree@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 39/39] drm: renesas: shmobile: Add DT support
Message-ID: <20230623185252.GS2112@pendragon.ideasonboard.com>
References: <cover.1687423204.git.geert+renesas@glider.be>
 <2759075c94c011b0f15cb610f39f8fa9b3736600.1687423204.git.geert+renesas@glider.be>
 <20230623175019.GO2112@pendragon.ideasonboard.com>
 <20230623175409.GA2534204@ravnborg.org>
 <CAMuHMdVsvz1knSDqQW16rrT3tq2Zz4dfEJj4WS5By0AYLWRazA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdVsvz1knSDqQW16rrT3tq2Zz4dfEJj4WS5By0AYLWRazA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 08:09:53PM +0200, Geert Uytterhoeven wrote:
> On Fri, Jun 23, 2023 at 7:54 PM Sam Ravnborg <sam@ravnborg.org> wrote:
> > On Fri, Jun 23, 2023 at 08:50:19PM +0300, Laurent Pinchart wrote:
> > > On Thu, Jun 22, 2023 at 11:21:51AM +0200, Geert Uytterhoeven wrote:
> > > > Add DT support, by:
> > > >   1. Creating a panel bridge from DT, and attaching it to the encoder,
> > > >   2. Replacing the custom connector with a bridge connector,
> > > >   3. Obtaining clock configuration based on the compatible value.
> > > >
> > > > Note that for now the driver uses a fixed clock configuration selecting
> > > > the bus clock, as the current code to select other clock inputs needs
> > > > changes to support any other SoCs than SH7724.
> > > >
> > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > Cc: Rob Herring <robh+dt@kernel.org>
> > > > Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> > > > Cc: Conor Dooley <conor+dt@kernel.org>
> > > > Cc: devicetree@vger.kernel.org
> > > > ---
> > > > SH-Mobile AG5 (SH73A0) support is untested.
> > > >
> > > > Unbind crashes when drm_encoder_cleanup() calls drm_bridge_detach(), as
> > > > the bridge (allocated by devm_drm_panel_bridge_add()) has already been
> > > > freed by that time.
> > > > Should I allocate my encoder with devm_kzalloc(), instead of embedding
> > > > it inside struct shmob_drm_device?
> > >
> > > That shouldn't be needed, if you manage the memory for shmob_drm_device
> > > with the DRM managed helpers.
> 
> Well, Marek said unbind works fine in drivers/gpu/drm/mxsfb/lcdif_drv.c,
> where the order is:
> 
>     bridge = devm_drm_of_get_bridge(...)
>     encoder = devm_kzalloc(...)
>     drm_encoder_init(...)
> 
> > > Lifetime management of bridges is currently completely broken, there's
> > > nothing that prevents bridges from being freed while still in use.
> > > That's an issue in DRM, not in your driver.
> 
> OK ;-) (or :-(
> 
> > > > --- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
> > > > +++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
> > > > @@ -508,9 +508,43 @@ static const struct drm_encoder_helper_funcs encoder_helper_funcs = {
> > > >     .mode_fixup = shmob_drm_encoder_mode_fixup,
> > > >  };
> > > >
> > > > +/* -----------------------------------------------------------------------------
> > > > + * Encoder
> > > > + */
> > > > +
> > > > +static int shmob_drm_encoder_init(struct shmob_drm_device *sdev,
> > > > +                             struct device_node *enc_node)
> > > > +{
> > > > +   struct drm_bridge *bridge;
> > > > +   struct drm_panel *panel;
> > > > +   int ret;
> > > > +
> > > > +   /* Create a panel bridge */
> > > > +   panel = of_drm_find_panel(enc_node);
> > >
> > > Using drm_of_find_panel_or_bridge() would allow supporting platforms
> > > that connect a non-panel device to the SoC, in additional to the already
> > > supported panels.
> >
> > From the documentation of drm_of_find_panel_or_bridge():
> >
> >  * This function is deprecated and should not be used in new drivers. Use
> >  * devm_drm_of_get_bridge() instead.

Indeed, my bad/ devm_drm_of_get_bridge() is better.

> > I suggest to go that route.
> 
> OK (do I have the feeling that these helpers are sometimes deprecated
> faster than they are written? ;-)
> 
> > > > @@ -147,11 +148,13 @@ static int shmob_drm_remove(struct platform_device *pdev)
> > > >  static int shmob_drm_probe(struct platform_device *pdev)
> > > >  {
> > > >     struct shmob_drm_platform_data *pdata = pdev->dev.platform_data;
> > >
> > > How about dropping non-DT support ? That would simplify the driver.
> >
> > +1 for that, without knowing the implications.
> 
> That depends on your priorities: do you want to migrate all users of
> sh_mobile_lcdc_fb to shmob_drm, or do you want the SuperH users to
> stick with sh_mobile_lcdc_fb until they have migrated to DT? ;-)

I'd vote for dropping LCDC support from the SH users. Does anyone
*really* need it ? If they do, they should convert the board to DT.

> Regardless of the above, I do not have (visible) access to any of the
> affected SH772[234] platforms...

-- 
Regards,

Laurent Pinchart
