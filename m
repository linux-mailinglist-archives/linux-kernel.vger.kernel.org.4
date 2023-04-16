Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E866E3CA4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 00:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjDPWbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 18:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjDPWbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 18:31:37 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DE226A1;
        Sun, 16 Apr 2023 15:31:36 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id q191so18556547pgq.7;
        Sun, 16 Apr 2023 15:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681684296; x=1684276296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XFwNbwTeZCLBVi0XkvXE7u6Jd7tTvMFg3HLldvV4R4A=;
        b=aevjBF9o/afH9OcEqMfa0y3GDp6G0r4ZRicU0NQBxnGr2zQu2o9JYLkPtxGayMCpVR
         2ZFLMRijtzm8cM8hynCZ9Q0j5cT+CYqVJA98BoNHMRG06g+6e3hrt6PqUKnKKvghExIS
         agCfStD+rX1lw06usNZTpVs8nMNl9rMYo1ihnFeWunGdDSnpnopjHcTBpeu+2Vp5JPUg
         c307tySXNgRnmPjOBjiqY0KtOe91+xfv2aLFLV9iCv1e7HLM6YpagAdK9LcPx/RamvM0
         DTBP/19/8GTSIwk+SceHE0bbf4RPzadoatqxsLSJ9qa1tXRNxvH6mcdNeqlvrNOy0QqR
         ccSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681684296; x=1684276296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XFwNbwTeZCLBVi0XkvXE7u6Jd7tTvMFg3HLldvV4R4A=;
        b=Rn4+QKz4guaxWcT/2RaqNjo1pXLrxfjZ2rWgLzmJZnn1rSwQ+r3R0xck6aN7nHrYml
         Xmd3HkdzkjgL/cottdaoUMhxJ6I3C03tNO67bO9KBks0fAJTUQBDkw2koz4zOku7fni0
         YE7mqk7IRTfqbvdol9D/JqRl2K0dMaa40P+LW70Oi0tswvrTFWvm4MLsCt7hc9hAQPQL
         uCS4fxGMxcqM37BcOBtxR0JgbZ50q6IU1DmHhpz4JHV5r2FtCTneM6QAjBDKlbVIWNDv
         tRn4T2r0w/5EIaurWxKX6kA2ePoRxUCtboxaqikCaY6DqXf+4DfMw0aF/kIYO+DzXFLb
         Vjtg==
X-Gm-Message-State: AAQBX9faEBHNQaf495Scl/2N41Z0jNHlb271dKnJRXZrvfrFSYrl6Ikc
        hVhTWDZOTzsVHNHSCvq7EA/8IxwGSjcyaYYZcXY=
X-Google-Smtp-Source: AKy350YBBXwEZ9X8S2MW5Q3T6K4il3kW5VzZMfBL1UAIS6CK51N2QxjHJCum+Rp5h2vYo1uXMKDb8UmSJokdVEdqB6M=
X-Received: by 2002:a65:4583:0:b0:50c:a00:c1fa with SMTP id
 o3-20020a654583000000b0050c0a00c1famr2594015pgq.7.1681684295645; Sun, 16 Apr
 2023 15:31:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230415104104.5537-1-aford173@gmail.com> <20230415104104.5537-2-aford173@gmail.com>
 <414febc4-aab1-95ec-ac2e-e82a3f881d01@denx.de>
In-Reply-To: <414febc4-aab1-95ec-ac2e-e82a3f881d01@denx.de>
From:   Adam Ford <aford173@gmail.com>
Date:   Sun, 16 Apr 2023 17:31:24 -0500
Message-ID: <CAHCN7xKsvT-TL4xdP=CKDzTJoFq1PGqmFmTohdRF9JaWaxWemw@mail.gmail.com>
Subject: Re: [PATCH 2/6] drm: bridge: samsung-dsim: Fix PMS Calculator on imx8m[mnp]
To:     Marek Vasut <marex@denx.de>
Cc:     dri-devel@lists.freedesktop.org, m.szyprowski@samsung.com,
        aford@beaconembedded.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Inki Dae <inki.dae@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
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

On Sun, Apr 16, 2023 at 5:07=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> On 4/15/23 12:40, Adam Ford wrote:
> > According to Table 13-45 of the i.MX8M Mini Reference Manual, the min
> > and max values for M and  the frequency range for the VCO_out
> > calculator were incorrect.  This also appears to be the case for the
> > imx8mn and imx8mp.
> >
> > To fix this, make new variables to hold the min and max values of m
> > and the minimum value of VCO_out, and update the PMS calculator to
> > use these new variables instead of using hard-coded values to keep
> > the backwards compatibility with other parts using this driver.
>
> [...]
>
> >   static const struct samsung_dsim_driver_data imx8mm_dsi_driver_data =
=3D {
> > @@ -470,6 +485,9 @@ static const struct samsung_dsim_driver_data imx8mm=
_dsi_driver_data =3D {
> >        */
> >       .pll_p_offset =3D 14,
> >       .reg_values =3D imx8mm_dsim_reg_values,
> > +     .m_min =3D 64,
> > +     .m_max =3D 1023,
> > +     .vco_min =3D 1050,
>
> You might want to call this 'min_freq' since there is a 'max_freq' which
> seems to indicate what VCO max frequency is.
>
> Note that the same datasheet contains the following information:
> "
> MIPI_DPHY_M_PLLPMS field descriptions
>
> 12=E2=80=934 PMS_M
> Specifies the PLL PMS value for the M divider
> NOTE: The programmable divider range should be within 25 to 125 to
> ensure PLL stability.

I was confused by this because this statement is not consistent with
the link they reference jumps me to the table where it reads M is
between 64 and 1023.

> NOTE: The M and P divider values should be considered together to ensure
> VCO ouput frequency
> (VCO_out) range is between 350 MHz to 750 MHz.
> Please refer to the topic DPHY PLL for more information.

I was confused by this too, because the NXP documentation reads the
350 - 750MHz that you state, but  "Table 13-45: DPHY PLL Parameters"
which immediately follows that sentence  on page 4158 shows VCO_out is
between 1050-2100 MHz.

I compared the PMS values for a variety of frequencies to those that
were set in the downstream NXP code, and the PMS values matched.
Maybe someone from NXP can explain the discrepancy.

adam

> "
