Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D084166526B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 04:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235733AbjAKDcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 22:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235716AbjAKDbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 22:31:39 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D3217588
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 19:31:23 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id 3so7061574iou.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 19:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jqmRSD6VKdYWZ+SJv6ehJPDhj3p2v9Nk0+3Tds66tis=;
        b=hYrLw3Cw5Sm66XPWhcU5vNYulWczhbyiQqdcFNuy+4k/u6bm/NzuBZNNsI/Yenxhvx
         O6mOhYJcQFwaJmYLCeAs1cL1EB+eYs/h5RlLVFsNM/PCz9QvNfvVQpR/h+32PBrmZTW7
         iHwR3xCpoeq+pHQ7+PHCBOkydqGoLGFgP2SAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jqmRSD6VKdYWZ+SJv6ehJPDhj3p2v9Nk0+3Tds66tis=;
        b=D01CweYPAI1YpPH6cuiQ82TQ2GjLlDerGkH4WW81l17gnd/eT2BVyoLkJjPzNQTG8Q
         X2CuKL15q9pOU3QtBA2b1hlklzwaJmpRTYEBrhedF6u2DOnxLF8b0n2p5RKqbXLERJQ1
         ehoqDdclYYHylVb8YJExxSTuTFNJNHJwUAA9NcJFfsb3XCWKsAZ0AX1Tx/6rmLTVegys
         mD6+D+hHSPcnMLAFRUb58B9T7PMI8fiJEx4hKhzgXpbKYKj4Jw/5VEHdTvJP54TmZYC7
         zKAPuINMGy/dY8GdoLAuPE8fKe1hQs5y7O0KdVdlVOb/b/RAoc1r0g9ZX86CERCChRz6
         7s/Q==
X-Gm-Message-State: AFqh2kqEkLRj12at8N48UxmWbCEOKpT9JdEx3xL37sjqD9mg5Ppvl6BZ
        HtlDDo+BUqIBRy7NxkiW29sCvODH2GLTK8az/jwYqw==
X-Google-Smtp-Source: AMrXdXuI8UJgsTEPz41Qko+pkxgoB7obHnvZeKTKwhlzMuJnouZnhqjW9lCoaxgssepI+1TDZhxrCHjLxmr3bkFdAmg=
X-Received: by 2002:a5e:c00f:0:b0:6e3:38c6:e35f with SMTP id
 u15-20020a5ec00f000000b006e338c6e35fmr6266793iol.153.1673407882942; Tue, 10
 Jan 2023 19:31:22 -0800 (PST)
MIME-Version: 1.0
References: <20230109084101.265664-1-treapking@chromium.org>
 <20230109084101.265664-7-treapking@chromium.org> <CAGXv+5E=-=cPGSi1eEDAkTm+RvuJNU4zeZOxunpR7r4+RgzNYA@mail.gmail.com>
In-Reply-To: <CAGXv+5E=-=cPGSi1eEDAkTm+RvuJNU4zeZOxunpR7r4+RgzNYA@mail.gmail.com>
From:   Pin-yen Lin <treapking@chromium.org>
Date:   Wed, 11 Jan 2023 11:31:12 +0800
Message-ID: <CAEXTbpeQm2+KjHDi6qW8GkF0_MCzqeBNUPz9G+23RBqfgFhWPw@mail.gmail.com>
Subject: Re: [PATCH v9 6/9] drm/bridge: anx7625: Register Type C mode switches
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Marek Vasut <marex@denx.de>, devicetree@vger.kernel.org,
        =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= 
        <nfraprado@collabora.com>, linux-acpi@vger.kernel.org,
        Allen Chen <allen.chen@ite.com.tw>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        dri-devel@lists.freedesktop.org,
        Stephen Boyd <swboyd@chromium.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        chrome-platform@lists.linux.dev, Xin Ji <xji@analogixsemi.com>,
        linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chen-Yu,

Thanks for the review.

On Mon, Jan 9, 2023 at 7:26 PM Chen-Yu Tsai <wenst@chromium.org> wrote:
>
> On Mon, Jan 9, 2023 at 4:41 PM Pin-yen Lin <treapking@chromium.org> wrote:
> >
> > Register USB Type-C mode switches when the "mode-switch" property and
> > relevant port are available in Device Tree. Configure the crosspoint
>            ^ ports
>
Thanks for catching this. I'll fix in v10.
> > switch based on the entered alternate mode for a specific Type-C
> > connector.
>
> You should also mention that the "one mode switch" scenario is not
> covered in this implementation, due to lack of actual hardware.

If I understand correctly, we should use "orientation-switch"[1]
instead when the crosspoint switch on anx7625 is used to support
different orientations of the Type-C connector.

I'll add some explanations around this in the commit message in v10.

[1]: https://docs.kernel.org/driver-api/usb/typec.html#multiplexer-demultiplexer-switches
>
> > Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> >
> > ---
> >
> > (no changes since v7)
> >
> > Changes in v7:
> > - Fixed style issues in anx7625 driver
> > - Removed DT property validation in anx7625 driver.
> > - Extracted common codes to another commit.
> >
> > Changes in v6:
> > - Squashed to a single patch
> >
> >  drivers/gpu/drm/bridge/analogix/Kconfig   |  1 +
> >  drivers/gpu/drm/bridge/analogix/anx7625.c | 88 +++++++++++++++++++++++
> >  drivers/gpu/drm/bridge/analogix/anx7625.h | 13 ++++
> >  3 files changed, 102 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/bridge/analogix/Kconfig b/drivers/gpu/drm/bridge/analogix/Kconfig
> > index 173dada218ec..992b43ed1dd7 100644
> > --- a/drivers/gpu/drm/bridge/analogix/Kconfig
> > +++ b/drivers/gpu/drm/bridge/analogix/Kconfig
> > @@ -34,6 +34,7 @@ config DRM_ANALOGIX_ANX7625
> >         tristate "Analogix Anx7625 MIPI to DP interface support"
> >         depends on DRM
> >         depends on OF
> > +       depends on TYPEC || TYPEC=n
> >         select DRM_DISPLAY_DP_HELPER
> >         select DRM_DISPLAY_HDCP_HELPER
> >         select DRM_DISPLAY_HELPER
> > diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > index 1cf242130b91..2bb504a8d789 100644
> > --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> > +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > @@ -15,6 +15,8 @@
> >  #include <linux/regulator/consumer.h>
> >  #include <linux/slab.h>
> >  #include <linux/types.h>
> > +#include <linux/usb/typec_dp.h>
> > +#include <linux/usb/typec_mux.h>
> >  #include <linux/workqueue.h>
> >
> >  #include <linux/of_gpio.h>
> > @@ -2572,6 +2574,86 @@ static void anx7625_runtime_disable(void *data)
> >         pm_runtime_disable(data);
> >  }
> >
> > +static void anx7625_set_crosspoint_switch(struct anx7625_data *ctx,
> > +                                         enum typec_orientation orientation)
> > +{
> > +       if (orientation == TYPEC_ORIENTATION_NORMAL) {
> > +               anx7625_reg_write(ctx, ctx->i2c.tcpc_client, TCPC_SWITCH_0,
> > +                                 SW_SEL1_SSRX_RX1 | SW_SEL1_DPTX0_RX2);
> > +               anx7625_reg_write(ctx, ctx->i2c.tcpc_client, TCPC_SWITCH_1,
> > +                                 SW_SEL2_SSTX_TX1 | SW_SEL2_DPTX1_TX2);
> > +       } else if (orientation == TYPEC_ORIENTATION_REVERSE) {
> > +               anx7625_reg_write(ctx, ctx->i2c.tcpc_client, TCPC_SWITCH_0,
> > +                                 SW_SEL1_SSRX_RX2 | SW_SEL1_DPTX0_RX1);
> > +               anx7625_reg_write(ctx, ctx->i2c.tcpc_client, TCPC_SWITCH_1,
> > +                                 SW_SEL2_SSTX_TX2 | SW_SEL2_DPTX1_TX1);
> > +       }
> > +}
> > +
> > +static void anx7625_typec_two_ports_update(struct anx7625_data *ctx)
> > +{
> > +       struct drm_dp_typec_switch_desc switch_desc = ctx->switch_desc;
> > +       /* Check if both ports available and do nothing to retain the current one */
> > +       if (switch_desc.typec_ports[0].dp_connected && switch_desc.typec_ports[1].dp_connected)
> > +               return;
> > +
> > +       if (switch_desc.typec_ports[0].dp_connected)
> > +               anx7625_set_crosspoint_switch(ctx, TYPEC_ORIENTATION_NORMAL);
> > +       else if (switch_desc.typec_ports[1].dp_connected)
> > +               anx7625_set_crosspoint_switch(ctx, TYPEC_ORIENTATION_REVERSE);
> > +}
> > +
> > +static int anx7625_typec_mux_set(struct typec_mux_dev *mux,
> > +                                struct typec_mux_state *state)
> > +{
> > +       struct drm_dp_typec_port_data *port_data = typec_mux_get_drvdata(mux);
> > +       struct anx7625_data *ctx = (struct anx7625_data *) port_data->data;
> > +       struct device *dev = &ctx->client->dev;
> > +       struct drm_dp_typec_switch_desc switch_desc = ctx->switch_desc;
> > +       bool new_dp_connected, old_dp_connected;
> > +
>
> And place a TODO note here.

I'll add it in v10.
>
> Otherwise this looks OK.
>
> Also,
>
> Tested-by: Chen-Yu Tsai <wenst@chromium.org>
> on MT8192 based Hayato (ASUS Chromebook Flip CM3200).
>
> And this also uncovered a deadlock in the unplug & disable path.
> I'll send a fix for that later once I figure out all the details.
Thank you so much for this!
