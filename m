Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4245F74A5CA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 23:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbjGFVPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 17:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjGFVPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 17:15:03 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF9A1FD2
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 14:14:57 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b701e1ca63so18074511fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 14:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688678092; x=1691270092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JLaQczdD7KeTXk4DDv/J61xDEsmIdzEy/EqXxRGJCq0=;
        b=AQZYQkWa9CIfOPfWKekTzdiT8eXjPTkZYlrI45cYBma1pak53T1buzaqOKRY3+wyDW
         Mi1Zyuvhw/VvPvgGd1rHar6oJvNQGrKpt7zOjtVikXX5taWuccqhiAVEMTFWZHoTmf/+
         k5VSDbKTDaRDuHDai/HAf0aH4v8qMbGMF6eWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688678092; x=1691270092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JLaQczdD7KeTXk4DDv/J61xDEsmIdzEy/EqXxRGJCq0=;
        b=SpnzhNB/OUI82nA4IySFpbrBN2DQbetBrWbKAX5+XtxVpZgUnubuRZVcUyztASbMV8
         qdMvAdIQiAaBeh8Arw0DGPRoJ34dQpZfoGUfl8QtzpjzP+egTEpQ1W7x9q/avFNMn76R
         LCq1nChRpWMyc7uyeOSWlQUI0Pr+29ODpVc9q9m/Rq2o5YE6BP/y3fG1M2zHXJvZOShX
         ESyfLOOrD6rLoaj4gSiGJnaLzwuoMHCi4qvEMVXh55ViEY+SVtbkET4wb4683yCiYjOq
         rcANMdB8iPXFspuPpTdzwfXkZ2yevt0FIkVb0tw0cs00wnlNAXEEiiB4ygkBfJ8KWd2C
         +q7w==
X-Gm-Message-State: ABy/qLYN2ZNJOox2c0i5hcd+/1eLe9gYq58TbxAYC4Ld9bqtMaVqOcyE
        JY4erb/Jbtl4EXlihmrzPfWiPSYoZcvajO8scuFFNCFF
X-Google-Smtp-Source: APBJJlFLUQt6gfanwPV8ea9ZayVjRhIorREID1i8uNSi8F6R39FOkCNjgtjYEmGt/bb6HRu6EibNeA==
X-Received: by 2002:a2e:3a1a:0:b0:2b6:3651:f12f with SMTP id h26-20020a2e3a1a000000b002b63651f12fmr2238715lja.3.1688678092590;
        Thu, 06 Jul 2023 14:14:52 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id qq2-20020a17090720c200b0098860721959sm1272460ejb.198.2023.07.06.14.14.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 14:14:52 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-516500163b2so1084a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 14:14:51 -0700 (PDT)
X-Received: by 2002:a50:ab56:0:b0:51a:2012:5b34 with SMTP id
 t22-20020a50ab56000000b0051a20125b34mr29385edc.4.1688678091505; Thu, 06 Jul
 2023 14:14:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230703-fix-boe-tv101wum-nl6-v3-0-bd6e9432c755@linaro.org> <20230703-fix-boe-tv101wum-nl6-v3-3-bd6e9432c755@linaro.org>
In-Reply-To: <20230703-fix-boe-tv101wum-nl6-v3-3-bd6e9432c755@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 6 Jul 2023 14:14:39 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xkr3Qpd8m_6Xta_2jL_ezbxsmMyarbKXTXL+UJLG9xNw@mail.gmail.com>
Message-ID: <CAD=FV=Xkr3Qpd8m_6Xta_2jL_ezbxsmMyarbKXTXL+UJLG9xNw@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] drm/panel: ili9882t: Break out as separate driver
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Ruihai Zhou <zhouruihai@huaqin.corp-partner.google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jul 3, 2023 at 6:22=E2=80=AFAM Linus Walleij <linus.walleij@linaro.=
org> wrote:
>
> The Starry ILI9882t-based panel should never have been part of the boe
> tv101wum driver, it is clearly based on the Ilitek ILI9882t display
> controller and if you look at the custom command sequences for the
> panel these clearly contain the signature Ilitek page switch (0xff)
> commands. The hardware has nothing in common with the other panels
> supported by this driver.
>
> Break this out into a separate driver and config symbol instead.
>
> If the placement here is out of convenience for using similar code,
> we should consider creating a helper library instead.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/gpu/drm/panel/Kconfig                  |   9 +
>  drivers/gpu/drm/panel/Makefile                 |   1 +
>  drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 386 -------------
>  drivers/gpu/drm/panel/panel-ilitek-ili9882t.c  | 739 +++++++++++++++++++=
++++++
>  4 files changed, 749 insertions(+), 386 deletions(-)

I have no real objection here and am happy to let others argue about
bikeshed color. I think the "panel-boe-tv101wum-nl6.c" driver ended up
becoming a dumping ground for a bunch of panels in response to Sam's
feedback originally [1].

[1] https://lore.kernel.org/all/YSPAseE6WD8dDRuz@ravnborg.org/

...so it would be good to get Sam's feedback here.


> +/*
> + * Use this descriptor struct to describe different panels using the
> + * Ilitek ILI9882T display controller.
> + */
> +struct panel_desc {
> +       const struct drm_display_mode *modes;
> +       unsigned int bpc;
> +
> +       /**
> +        * @width_mm: width of the panel's active display area
> +        * @height_mm: height of the panel's active display area
> +        */
> +       struct {
> +               unsigned int width_mm;
> +               unsigned int height_mm;
> +       } size;
> +
> +       unsigned long mode_flags;
> +       enum mipi_dsi_pixel_format format;
> +       int (*init)(struct mipi_dsi_device *dsi);
> +       unsigned int lanes;
> +       bool discharge_on_disable;

IMO "discharge_on_disable" should be removed since the one panel
supported by this driver doesn't use it. If later we find that some
ili9882t panels need this logic then we can add it back in, but it
seems hard to believe it would use the same code.


> +       bool lp11_before_reset;

IMO "lp11_before_reset" should be removed. The one panel supported by
this driver _always_ needs lp11_before_reset. If we later find that
some ili9882t panels want different behavior then we can add it back
in. It doesn't feel like the kind of thing that would be different on
different drivers using the same chip.


> +static int ili9882t_get_modes(struct drm_panel *panel,
> +                              struct drm_connector *connector)
> +{
> +       struct ili9882t *ili =3D to_ili9882t(panel);
> +       const struct drm_display_mode *m =3D ili->desc->modes;
> +       struct drm_display_mode *mode;
> +
> +       mode =3D drm_mode_duplicate(connector->dev, m);
> +       if (!mode) {
> +               dev_err(panel->dev, "failed to add mode %ux%u@%u\n",
> +                       m->hdisplay, m->vdisplay, drm_mode_vrefresh(m));
> +               return -ENOMEM;
> +       }
> +
> +       mode->type =3D DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
> +       drm_mode_set_name(mode);
> +       drm_mode_probed_add(connector, mode);
> +
> +       connector->display_info.width_mm =3D ili->desc->size.width_mm;
> +       connector->display_info.height_mm =3D ili->desc->size.height_mm;
> +       connector->display_info.bpc =3D ili->desc->bpc;
> +       /*
> +        * TODO: Remove once all drm drivers call
> +        * drm_connector_set_orientation_from_panel()
> +        */
> +       drm_connector_set_panel_orientation(connector, ili->orientation);

I'd be inclined to take the above call out and assume anyone using
this new panel has a DRM driver that's working properly...


-Doug
