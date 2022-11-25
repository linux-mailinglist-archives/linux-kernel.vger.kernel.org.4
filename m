Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949B5638432
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 07:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiKYG7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 01:59:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiKYG7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 01:59:12 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1926F2CC97
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 22:59:11 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id i10so8265092ejg.6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 22:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hoX4Z40MQwuszANnlGBImjuiii34Bm6IVdSkNEROGlk=;
        b=DYIALqhs5m9PNMHPE8yqYIxFmhgXWCNuD1nJkRncSHnTb9KsT2SEjTxLyCLcf07SND
         BuT1B67WTp6kKWo3FOST5wFfrrVouCr3lzbeI1KGFJ8ZBam/NFoSzrxJ91QWhGAFY65h
         a9xen1l7WE8m+vLpAI2NRR5TH2Q/wtYpx+7Hs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hoX4Z40MQwuszANnlGBImjuiii34Bm6IVdSkNEROGlk=;
        b=kKZ6BPqV02/CyHxhQuTID4b7sgj3zvN97bxBaSf7ZQWmqF/7miq7TaM4RS3TCI/fX5
         H6g1v7HsKOMGmLT3BoXJm5FUamvozabfrsl7Fcqn3bdqeZ9YE70KSUzl0UHCKaEXSZ1p
         ZySQA1Lgdau6kathHzUIC4qOSXwwfprjyE0XwRftHnW8qd7N2V17cASIS55mbkK+fmOG
         izCRUvKY0R1jqDWi5d1gjHhwr3zN50ssHfjpr9lu81xtCzwd6LTsneN7mUVZm9rlC+hs
         G0Gm3xEys0CDrNBImVbwQhDlJqKqiiZ6nYw8op2Y8FwTXiGturA6nIVgSM8euGMd1FYe
         Zz9g==
X-Gm-Message-State: ANoB5pmlGW7ES6CVaOBCRn0HWIuMXoGW8Hd3nRb4A2v1WkNWK1N+AAXB
        i6xZbWaWt8VJEZxtsA5sA//4A3Blq8X6qQxkRitkxCf3g+o=
X-Google-Smtp-Source: AA0mqf61omTI/URQcHXxO27ayXnv2S/Msse51DzkeZiQ+oIxOTmaxkcc1G6pL7lsFhNXP8G7IxSxXZbVbQkqQ2kKVNQ=
X-Received: by 2002:a17:906:b1c6:b0:7ad:e82b:b66b with SMTP id
 bv6-20020a170906b1c600b007ade82bb66bmr14937894ejb.453.1669359549666; Thu, 24
 Nov 2022 22:59:09 -0800 (PST)
MIME-Version: 1.0
References: <20221124102056.393220-1-treapking@chromium.org>
 <20221124102056.393220-6-treapking@chromium.org> <Y39g/OBLW3pt9qdy@smile.fi.intel.com>
In-Reply-To: <Y39g/OBLW3pt9qdy@smile.fi.intel.com>
From:   Pin-yen Lin <treapking@chromium.org>
Date:   Fri, 25 Nov 2022 14:58:58 +0800
Message-ID: <CAEXTbpeX7cfzBhvFvhCtP42LYDZ9OZQhDJ805VacQOE=-EVv0g@mail.gmail.com>
Subject: Re: [PATCH v6 5/7] drm/bridge: anx7625: Register Type C mode switches
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Stephen Boyd <swboyd@chromium.org>,
        dri-devel@lists.freedesktop.org,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        devicetree@vger.kernel.org, chrome-platform@lists.linux.dev,
        linux-acpi@vger.kernel.org, Marek Vasut <marex@denx.de>,
        Xin Ji <xji@analogixsemi.com>, Lyude Paul <lyude@redhat.com>,
        =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-kernel@vger.kernel.org, Allen Chen <allen.chen@ite.com.tw>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Thanks for reviewing the patch.

On Thu, Nov 24, 2022 at 8:18 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Nov 24, 2022 at 06:20:54PM +0800, Pin-yen Lin wrote:
> > Register USB Type-C mode switches when the "mode-switch" property and
> > relevant port are available in Device Tree. Configure the crosspoint
> > switch based on the entered alternate mode for a specific Type-C
> > connector.
>
> ...
>
> > +static void anx7625_typec_two_ports_update(struct anx7625_data *ctx)
> > +{
> > +     if (ctx->typec_ports[0].dp_connected && ctx->typec_ports[1].dp_connected)
> > +             /* Both ports available, do nothing to retain the current one. */
> > +             return;
>
> > +     else if (ctx->typec_ports[0].dp_connected)
>
> This 'else' is redundant. I would rewrite above as
>
>         /* Check if both ports available and do nothing to retain the current one */
>         if (ctx->typec_ports[0].dp_connected && ctx->typec_ports[1].dp_connected)
>                 return;
>
>         if (ctx->typec_ports[0].dp_connected)
>
> > +             anx7625_set_crosspoint_switch(ctx, TYPEC_ORIENTATION_NORMAL);
> > +     else if (ctx->typec_ports[1].dp_connected)
> > +             anx7625_set_crosspoint_switch(ctx, TYPEC_ORIENTATION_REVERSE);
> > +}

Thanks for the detailed suggestion. I'll adapt this in v7.
>
> ...
>
> > +     data->dp_connected = (state->alt && state->alt->svid == USB_TYPEC_DP_SID &&
> > +                           state->alt->mode == USB_TYPEC_DP_MODE);
>
> Parentheses are not needed.

Will fix this in v7.
>
> ...
>
> > +     /*
> > +      * <0 1> refers to SSRX1/SSTX1, and <2 3> refers to SSRX2/SSTX2.
> > +      */
> > +     for (i = 0; i < num_lanes; i++) {
>
> > +             if (port_num != -1 && port_num != dp_lanes[i] / 2) {
> > +                     dev_err(dev, "Invalid data lane numbers\n");
> > +                     return -EINVAL;
> > +             }
>
> According to Rob Linux must not validate device tree. If you need it, use
> proper YAML schema.
>
> > +             port_num = dp_lanes[i] / 2;
> > +     }
>

I'll remove this from the driver in v7.

> ...
>
> > +     if (!ctx->num_typec_switches) {
> > +             dev_warn(dev, "No Type-C switches node found\n");
>
> > +             return ret;
>
> Why not to return 0 explicitly?

Will update to just "return 0" in v7.

>
> > +     }
>
> ...
>
> > +     ctx->typec_ports = devm_kcalloc(
>
> Broken indentation.

Will fix in v7
>
> > +             dev, ctx->num_typec_switches, sizeof(struct anx7625_port_data),
> > +             GFP_KERNEL);
> > +     if (!ctx->typec_ports)
> > +             return -ENOMEM;
>
> ...
>
> > +struct anx7625_port_data {
>
> > +     bool dp_connected;
>
> You can save some bytes on some architectures if move this to be last field.

Thanks for the suggestion. I'll do so in v7
>
> > +     struct typec_mux_dev *typec_mux;
> > +     struct anx7625_data *ctx;
> > +};
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
