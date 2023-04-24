Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E89C6EC96D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 11:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbjDXJvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 05:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbjDXJvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 05:51:18 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6C310FB
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 02:51:11 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-247122e9845so2972826a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 02:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682329871; x=1684921871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/O13qopzmctziSNmxMv34ISA8PP1ZG4FW+wAiHL6n9E=;
        b=V1aR6gDAMmcxrTIA8ogOfMbqJNLv/BXqvdVYJe21RUSFwHJNtwzTlzopNjgWiGgmZO
         ldZ2DP+dRFqymcX2cbrl+tGA/zMcBS/vpHHOjxIkTY2BsVJ1/T28nhNVYm/t0CrGo7tv
         FQdqjR37c8dGiseMYjQQq20IepxdZf7kgJA6SxkTQ3fgqlsY/xrQaK6rBx7XIqSJwBWo
         eB3Dt+6TdNs6aMmrH4P4Mk+CZtNdH2eVvsNQm+fR7JigSsG1WXH3Or+jGGICvmqP+Qtt
         fsi4YsrhqhHPZXf6U9WmDfIRgG/WFrcrDfeOtWninuHk6w/fbUVmynXtoIXhuPRQJqDb
         jiZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682329871; x=1684921871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/O13qopzmctziSNmxMv34ISA8PP1ZG4FW+wAiHL6n9E=;
        b=SVK4a8IABINVhaRB4k43WBWSv9XB94E1ncMx5VMlG7Y+Jr2WD4zhS2pJJuKWCuGOPL
         jxUlQujz3/YI7SgXuIDF8uurzUvc4XokeSGw/i7z72byFahoMVKbAjs0+4uNRHPys6Es
         9Qz5yR3ktmQ2giMTnEjbons7pZsxFOxeXaIIGJ7LD8S630em0p/ubwS7DUfPwqFyMmlM
         To/eSlH4DiD7vhWPOVL5zSoHW4f/nont+Sb9xAP/nYZOPxecGcTK4aUJpkvOmpHcldjX
         36E4UOiTEGaAxHK0kH3RbZ4H/XW/I9F1yKWU0vInpKzbS1ND1mcHzrXkidYHNrpHQUYi
         TwiA==
X-Gm-Message-State: AAQBX9fLum6KKRTNgzLD5z4qMRiByTH8bcl7ttYOgzo+OOB5J80xa3fa
        gBiCXKRNktZD91ntrr1u+htUzQJcuvvHOJ1AScs=
X-Google-Smtp-Source: AKy350ZGvywolBBm9ifg1befPUZP6EICM2majGckkZ7j0nuV2k/il+WaFmAMnEEMN7PLLlTTeQPp7r3R+StDku/lscA=
X-Received: by 2002:a17:90a:bb0f:b0:246:63c8:6abf with SMTP id
 u15-20020a17090abb0f00b0024663c86abfmr13792609pjr.20.1682329870678; Mon, 24
 Apr 2023 02:51:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230423121232.1345909-1-aford173@gmail.com> <20230423121232.1345909-5-aford173@gmail.com>
 <CAGXv+5GHcigEahCp+UefxR+AboF7i-kYJjiNftz8fPDLAZVMow@mail.gmail.com>
 <CAHCN7x+i41UkpdqLbK8s+OJmS=ExsctZwZL0YAQAic=N6kCbAw@mail.gmail.com>
 <CGME20230424094440eucas1p1ca3d678493aef1d6a893abdfcaf01584@eucas1p1.samsung.com>
 <CAGXv+5H34ojUAPWWpF+-=XpdF6Jj_Q7nqiPg3TEKVNXu4F6JAQ@mail.gmail.com> <ceee0290-211b-a675-2ba5-9342ee27fc49@samsung.com>
In-Reply-To: <ceee0290-211b-a675-2ba5-9342ee27fc49@samsung.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 24 Apr 2023 04:50:59 -0500
Message-ID: <CAHCN7x+koEFVoTOvY16DXYmSE_7+GrYkAk5mnZ02MX9gRmD=DQ@mail.gmail.com>
Subject: Re: [PATCH V2 4/6] drm: bridge: samsung-dsim: Dynamically configure
 DPHY timing
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, dri-devel@lists.freedesktop.org,
        Marek Vasut <marex@denx.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        aford@beaconembedded.com,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-kernel@vger.kernel.org,
        Jagan Teki <jagan@amarulasolutions.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        dario.binacchi@amarulasolutions.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2023 at 4:47=E2=80=AFAM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> On 24.04.2023 11:44, Chen-Yu Tsai wrote:
> > On Mon, Apr 24, 2023 at 5:31=E2=80=AFPM Adam Ford <aford173@gmail.com> =
wrote:
> >> On Mon, Apr 24, 2023 at 1:12=E2=80=AFAM Chen-Yu Tsai <wenst@chromium.o=
rg> wrote:
> >>> On Sun, Apr 23, 2023 at 8:13=E2=80=AFPM Adam Ford <aford173@gmail.com=
> wrote:
> >>>> The DPHY timings are currently hard coded. Since the input
> >>>> clock can be variable, the phy timings need to be variable
> >>>> too.  Add an additional variable to the driver data to enable
> >>>> this feature to prevent breaking boards that don't support it.
> >>>>
> >>>> The phy_mipi_dphy_get_default_config function configures the
> >>>> DPHY timings in pico-seconds, and a small macro converts those
> >>>> timings into clock cycles based on the pixel clock rate.
> >>>>
> >>>> Signed-off-by: Adam Ford <aford173@gmail.com>
> >>>> ---
> >>>>   drivers/gpu/drm/bridge/samsung-dsim.c | 79 +++++++++++++++++++++++=
----
> >>>>   include/drm/bridge/samsung-dsim.h     |  1 +
> >>>>   2 files changed, 70 insertions(+), 10 deletions(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm=
/bridge/samsung-dsim.c
> >>>> index 5b6e7825b92f..f165483d5044 100644
> >>>> --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> >>>> +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> >>>> @@ -18,9 +18,7 @@
> >>>>   #include <linux/media-bus-format.h>
> >>>>   #include <linux/of_device.h>
> >>>>   #include <linux/phy/phy.h>
> >>>> -
> >>>>   #include <video/mipi_display.h>
> >>>> -
> >>>>   #include <drm/bridge/samsung-dsim.h>
> >>>>   #include <drm/drm_panel.h>
> >>>>   #include <drm/drm_print.h>
> >>>> @@ -218,6 +216,8 @@
> >>>>
> >>>>   #define OLD_SCLK_MIPI_CLK_NAME         "pll_clk"
> >>>>
> >>>> +#define PS_TO_CYCLE(PS, MHz) DIV64_U64_ROUND_CLOSEST(((PS) * (MHz))=
, 1000000000000ULL)
> >>>> +
> >>>>   static const char *const clk_names[5] =3D {
> >>>>          "bus_clk",
> >>>>          "sclk_mipi",
> >>>> @@ -487,6 +487,7 @@ static const struct samsung_dsim_driver_data imx=
8mm_dsi_driver_data =3D {
> >>>>          .m_min =3D 64,
> >>>>          .m_max =3D 1023,
> >>>>          .vco_min =3D 1050,
> >>>> +       .dynamic_dphy =3D 1,
> >>>>   };
> >>>>
> >>>>   static const struct samsung_dsim_driver_data *
> >>>> @@ -698,13 +699,50 @@ static void samsung_dsim_set_phy_ctrl(struct s=
amsung_dsim *dsi)
> >>>>          const struct samsung_dsim_driver_data *driver_data =3D dsi-=
>driver_data;
> >>>>          const unsigned int *reg_values =3D driver_data->reg_values;
> >>>>          u32 reg;
> >>>> +       struct drm_display_mode *m =3D &dsi->mode;
> >>>> +       int bpp =3D mipi_dsi_pixel_format_to_bpp(dsi->format);
> >>>> +       struct phy_configure_opts_mipi_dphy cfg;
> >>>> +       int clk_prepare, lpx, clk_zero, clk_post, clk_trail;
> >>>> +       int hs_exit, hs_prepare, hs_zero, hs_trail;
> >>>> +       unsigned long long clock_in_hz =3D m->clock * 1000;
> >>>>
> >>>>          if (driver_data->has_freqband)
> >>>>                  return;
> >>>>
> >>>> +       /* The dynamic_phy has the ability to adjust PHY Timing sett=
ings */
> >>>> +       if (driver_data->dynamic_dphy) {
> >>>> +               phy_mipi_dphy_get_default_config(clock_in_hz, bpp, d=
si->lanes, &cfg);
> >>> This requires adding "select GENERIC_PHY_MIPI_DPHY" to DRM_SAMSUNG_DS=
IM,
> >>> otherwise with CONFIG_DRM_SAMSUNG_DSIM=3Dm:
> >>>
> >>> ERROR: modpost: "phy_mipi_dphy_get_default_config"
> >>> [drivers/gpu/drm/bridge/samsung-dsim.ko] undefined!
> >>> make[5]: *** [scripts/Makefile.modpost:136: Module.symvers] Error 1
> >>> make[4]: *** [Makefile:1978: modpost] Error 2
> >>> make[3]: *** [Makefile:357: __build_one_by_one] Error 2
> >>>
> >>> I'm sure there'll be a similar error if CONFIG_DRM_SAMSUNG_DSIM=3Dy.
> >> That's interesting, I didn't come across that.
> >> What did you use for a starting point when you applied the patches?
> >> I want to see if I can replicate it.
> > next-20230421. My config is pretty much tailored to the Hummingbird Pul=
se.
> > Device drivers for other hardware or things that I can't enable are all
> > disabled. For example I don't have PHY_MIXEL_MIPI_DPHY enabled.
> >
> > Maybe you have some other bridge or phy that selects it enabled?
>
>
> I've observed similar issue while building exynos_defconfig for arm 32bit=
.

Thanks to both of you for the head's up.  I'll add a patch to update
Kconfig to explicitly select that when I do V3.  I was just using the
base arm64 'defconfig' option without any customization.

adam
>
>
> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>
