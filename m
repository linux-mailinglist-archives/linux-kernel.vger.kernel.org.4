Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30576709DB3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 19:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjESRRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 13:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbjESRRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 13:17:34 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8436713D
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 10:17:32 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-3f38824a025so9191cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 10:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684516651; x=1687108651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWSm1cEpXeMPrwenjedCsFf1tUeTCbhwdrC4UWV2MSM=;
        b=0OKtpMQQ88pW4O6vVomt4WQaYJMnkMuCuRc38akMqduiGtOEUcXeH3wUbfGNVhdPWi
         40gVh8Vs0dbXDZT2LJKX25aFWbP92bXB1GyfcxnICj8PU4PKAwEo0aDmB6Hp6pFXx7y5
         0oL4N4ky/ma3tkVe1AkRlfeGt1X8ThICbPWR2tzq1RonFLPXL5mKf78W374eKzGdlAia
         pUYai/lfABlxuV9GEDbM1PewRcUGhHaUhkmKk9ZifXF6KCLPldT0QsnKB785Mg9k7W3q
         zBCobhmAy2Eue3O4+IVXa+ElyLaiI40nsaOAbcf8Ob9gBZfB9eDEUTH/15rg7rVck7Ou
         kDxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684516651; x=1687108651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TWSm1cEpXeMPrwenjedCsFf1tUeTCbhwdrC4UWV2MSM=;
        b=GWbo2nOefmL0kzOEz0GT+5HvHkIS/aWUj5YkgGb8zLPDJZ/i6f+PD9SsSx6TKY86b/
         VWhPtSigCuunWNj7CGm6ElpPggu1K7xOUiB6SdCNuY3ZDPZQgH1U425FesVUpME/TcGP
         /uJ+Px2ngiL/S2F4PiaW9r5SQR6YzyLlkdqnMdtWzqLaRCG4Ze8NjQSzNjLFebrSNuY1
         OJWpPpOH4suChQkGuBSK6NqjxnyXdfq5wdPBEMhhDJKaVkYCp+jQ3BKCz1tFLFHgTj8F
         HVjjLFKEsvRM3GW4emJD2lsAKNc5b1AIaBU8+xLQKQZ/ta9ZwDJtBB9UdEZ5XIApFkYq
         KMOw==
X-Gm-Message-State: AC+VfDw8ylg/LQpG90l4U6e8jzpDXfUzh2nfXJXztHGww0RfB8UTNb/h
        yCLyoZo/asvLHUi9yMoLeyV1L51CZhh/9jAqrjS+ew==
X-Google-Smtp-Source: ACHHUZ7lm4TVN9Z5iJydsVO+G5hvCxA38sM4jBtepA4PBLTBkfyiIgen/eOc9MlBka3yjoblNoPbjWfdnHkkRWIJxAo=
X-Received: by 2002:a05:622a:19a6:b0:3ef:4319:c6c5 with SMTP id
 u38-20020a05622a19a600b003ef4319c6c5mr209465qtc.19.1684516651501; Fri, 19 May
 2023 10:17:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230519032316.3464732-1-yangcong5@huaqin.corp-partner.google.com>
 <20230519080136.4058243-1-yangcong5@huaqin.corp-partner.google.com> <20230519080136.4058243-2-yangcong5@huaqin.corp-partner.google.com>
In-Reply-To: <20230519080136.4058243-2-yangcong5@huaqin.corp-partner.google.com>
From:   Doug Anderson <dianders@google.com>
Date:   Fri, 19 May 2023 10:17:19 -0700
Message-ID: <CAD=FV=Wjmff00acDU3JxwSNYW8ctdz+qi=2fXSGFRt+Bnese4Q@mail.gmail.com>
Subject: Re: [v1 1/2] drm/panel: Support for Starry-himax83102-j02 TDDI
 MIPI-DSI panel
To:     Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc:     sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch,
        hsinyi@google.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, May 19, 2023 at 1:02=E2=80=AFAM Cong Yang
<yangcong5@huaqin.corp-partner.google.com> wrote:
>
> The Starry-himax83102-j02 panel is a TDDI IC. From the datasheet[1],
> it seems that the touch can communicate successfully only when the RST
> signal is high. Since i2c_hid_core_probe comes after boe_panel_prepare
> let's set the default high for RST at boe_panel_add.

No, that doesn't work. There are no guarantees about the ordering of
the probe of the i2c_hid device and the panel and the order could
change from version to version of Linux. Also: deasserting this reset
early like this (before regulators are turned on) can cause leakage
since that will make the signal go high and the touchscreen can suck
current out of that line.

Is it possible to change the hardware to fix this and have separate
reset lines for the touchscreen and the panel?

For a long time, I have felt like we needed a better solution in Linux
for stuff like this, but I've never found a clean way to do it. We
really want the touchscreen to power on and off together with the
panel, where the panel is in charge and the touchscreen always powers
on after the panel and powers off before the panel. I can't promise
anything, but I can see if I can find some time to whip up a
prototype.


> @@ -1698,6 +1768,34 @@ static const struct panel_desc starry_qfh032011_53=
g_desc =3D {
>         .init_cmds =3D starry_qfh032011_53g_init_cmd,
>  };
>
> +static const struct drm_display_mode starry_himax83102_j02_default_mode =
=3D {
> +       .clock =3D 161600,
> +       .hdisplay =3D 1200,
> +       .hsync_start =3D 1200 + 40,
> +       .hsync_end =3D 1200 + 40 + 20,
> +       .htotal =3D 1200 + 40 + 20 + 40,
> +       .vdisplay =3D 1920,
> +       .vsync_start =3D 1920 + 116,
> +       .vsync_end =3D 1920 + 116 + 8,
> +       .vtotal =3D 1920 + 116 + 8 + 12,
> +       .type =3D DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
> +};
> +
> +static const struct panel_desc starry_himax83102_j02_desc =3D {
> +       .modes =3D &starry_himax83102_j02_default_mode,
> +       .bpc =3D 8,
> +       .size =3D {
> +               .width_mm =3D 141,
> +               .height_mm =3D 226,
> +       },
> +       .lanes =3D 4,
> +       .format =3D MIPI_DSI_FMT_RGB888,
> +       .mode_flags =3D MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PU=
LSE |
> +                     MIPI_DSI_MODE_LPM,
> +       .init_cmds =3D starry_himax83102_j02_init_cmd,
> +       .enable_gpio_init_value =3D 1,
> +       .lp11_before_reset =3D true,
> +};
>  static int boe_panel_get_modes(struct drm_panel *panel,

nit: put a blank line above.


> @@ -1871,6 +1969,9 @@ static const struct of_device_id boe_of_match[] =3D=
 {
>         { .compatible =3D "starry,2081101qfh032011-53g",
>           .data =3D &starry_qfh032011_53g_desc
>         },
> +       { .compatible =3D "starry,himax83102-j02",
> +         .data =3D &starry_himax83102_j02_desc

You need device tree bindings for the above compatible string.
