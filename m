Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C86D73BE4C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 20:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbjFWSKK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 23 Jun 2023 14:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbjFWSKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 14:10:09 -0400
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7F8E41;
        Fri, 23 Jun 2023 11:10:07 -0700 (PDT)
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-471658cc106so422524e0c.0;
        Fri, 23 Jun 2023 11:10:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687543807; x=1690135807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pdLesGDWRYBklitp69Kt70nnbJt9dWfGsl/z3ZsnPiw=;
        b=eifMZZ0M9EZBVnLpLTnPNFwXgWlW9bO9iJkvGGOjEMJ0B2eTmEmfbkyFwPNeOuQSes
         Fe1ujWr31ksRXb2xujk1ZpwZ9KKJb8XBLrNsQdGk4N0MJIcS4o8AhdYzMT+MPbqtBgmh
         tFD0U6Szi/0k5JSlM4TUDaHlbrFr7uKn6P7Du/EW89xQvj/2Zf2AHpJRzDmbARVIc8tz
         L4kv8aQ4HacraLpjFSpbkklEQtbOJzfNP9QEA5LMHUlulqRsx47qPbVfRVtmzb8bI1ko
         yags7ZE3LjjGE6AfkZZ7xE1kDB8YdzhhZ1ibANdYJ2rmy7bjdwhneZISuIP3DKIbDX6L
         07Cg==
X-Gm-Message-State: AC+VfDwC1uymDs6zySbLdmcMfWh58Sb69YGsm3zqDmhPs+C9IiMavskP
        FVjUv72ov1hFLPHaUw3EgQs7WZHWRvXzwg==
X-Google-Smtp-Source: ACHHUZ5dmTtmAcBsTo1BFp1zbbME5iw3XsMNvKwQmTvEaufDtFZxoeG6u2+wyNQKhmPIK49HpyWUDg==
X-Received: by 2002:a1f:c1c4:0:b0:471:19d6:1ce1 with SMTP id r187-20020a1fc1c4000000b0047119d61ce1mr12458804vkf.11.1687543806624;
        Fri, 23 Jun 2023 11:10:06 -0700 (PDT)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id n11-20020a056122068b00b004570689ae5esm8669vkq.26.2023.06.23.11.10.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 11:10:05 -0700 (PDT)
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-78cbc37c5b1so376166241.0;
        Fri, 23 Jun 2023 11:10:04 -0700 (PDT)
X-Received: by 2002:a67:ee13:0:b0:43b:1561:9e6b with SMTP id
 f19-20020a67ee13000000b0043b15619e6bmr12740902vsp.18.1687543804614; Fri, 23
 Jun 2023 11:10:04 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1687423204.git.geert+renesas@glider.be> <2759075c94c011b0f15cb610f39f8fa9b3736600.1687423204.git.geert+renesas@glider.be>
 <20230623175019.GO2112@pendragon.ideasonboard.com> <20230623175409.GA2534204@ravnborg.org>
In-Reply-To: <20230623175409.GA2534204@ravnborg.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 23 Jun 2023 20:09:53 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVsvz1knSDqQW16rrT3tq2Zz4dfEJj4WS5By0AYLWRazA@mail.gmail.com>
Message-ID: <CAMuHMdVsvz1knSDqQW16rrT3tq2Zz4dfEJj4WS5By0AYLWRazA@mail.gmail.com>
Subject: Re: [PATCH 39/39] drm: renesas: shmobile: Add DT support
To:     Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam, Laurent,

On Fri, Jun 23, 2023 at 7:54 PM Sam Ravnborg <sam@ravnborg.org> wrote:
> On Fri, Jun 23, 2023 at 08:50:19PM +0300, Laurent Pinchart wrote:
> > On Thu, Jun 22, 2023 at 11:21:51AM +0200, Geert Uytterhoeven wrote:
> > > Add DT support, by:
> > >   1. Creating a panel bridge from DT, and attaching it to the encoder,
> > >   2. Replacing the custom connector with a bridge connector,
> > >   3. Obtaining clock configuration based on the compatible value.
> > >
> > > Note that for now the driver uses a fixed clock configuration selecting
> > > the bus clock, as the current code to select other clock inputs needs
> > > changes to support any other SoCs than SH7724.
> > >
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > Cc: Rob Herring <robh+dt@kernel.org>
> > > Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> > > Cc: Conor Dooley <conor+dt@kernel.org>
> > > Cc: devicetree@vger.kernel.org
> > > ---
> > > SH-Mobile AG5 (SH73A0) support is untested.
> > >
> > > Unbind crashes when drm_encoder_cleanup() calls drm_bridge_detach(), as
> > > the bridge (allocated by devm_drm_panel_bridge_add()) has already been
> > > freed by that time.
> > > Should I allocate my encoder with devm_kzalloc(), instead of embedding
> > > it inside struct shmob_drm_device?
> >
> > That shouldn't be needed, if you manage the memory for shmob_drm_device
> > with the DRM managed helpers.

Well, Marek said unbind works fine in drivers/gpu/drm/mxsfb/lcdif_drv.c,
where the order is:

    bridge = devm_drm_of_get_bridge(...)
    encoder = devm_kzalloc(...)
    drm_encoder_init(...)

> > Lifetime management of bridges is currently completely broken, there's
> > nothing that prevents bridges from being freed while still in use.
> > That's an issue in DRM, not in your driver.

OK ;-) (or :-(

> > > --- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
> > > +++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
> > > @@ -508,9 +508,43 @@ static const struct drm_encoder_helper_funcs encoder_helper_funcs = {
> > >     .mode_fixup = shmob_drm_encoder_mode_fixup,
> > >  };
> > >
> > > +/* -----------------------------------------------------------------------------
> > > + * Encoder
> > > + */
> > > +
> > > +static int shmob_drm_encoder_init(struct shmob_drm_device *sdev,
> > > +                             struct device_node *enc_node)
> > > +{
> > > +   struct drm_bridge *bridge;
> > > +   struct drm_panel *panel;
> > > +   int ret;
> > > +
> > > +   /* Create a panel bridge */
> > > +   panel = of_drm_find_panel(enc_node);
> >
> > Using drm_of_find_panel_or_bridge() would allow supporting platforms
> > that connect a non-panel device to the SoC, in additional to the already
> > supported panels.
>
> From the documentation of drm_of_find_panel_or_bridge():
>
>  * This function is deprecated and should not be used in new drivers. Use
>  * devm_drm_of_get_bridge() instead.
>
> I suggest to go that route.

OK (do I have the feeling that these helpers are sometimes deprecated
faster than they are written? ;-)

> > > @@ -147,11 +148,13 @@ static int shmob_drm_remove(struct platform_device *pdev)
> > >  static int shmob_drm_probe(struct platform_device *pdev)
> > >  {
> > >     struct shmob_drm_platform_data *pdata = pdev->dev.platform_data;
> >
> > How about dropping non-DT support ? That would simplify the driver.
>
> +1 for that, without knowing the implications.

That depends on your priorities: do you want to migrate all users of
sh_mobile_lcdc_fb to shmob_drm, or do you want the SuperH users to
stick with sh_mobile_lcdc_fb until they have migrated to DT? ;-)

Regardless of the above, I do not have (visible) access to any of the
affected SH772[234] platforms...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
